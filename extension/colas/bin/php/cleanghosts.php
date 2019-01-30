<?php
require 'autoload.php';

class kezfinCleanNode
{
	public 	$node_id;
	public	$lang;
	public	$guid;
	public	$url_alias;
	public	$name;
	private	$_node;
	
	public function __construct($row)
	{
		$this->node_id		= $row['meta_main_node_id_si'];
		$this->lang			= $row['meta_language_code_ms'];
		$this->guid 		= $row['meta_guid_ms'];
		$this->url_alias	= $row['meta_main_url_alias_ms'];
		$this->name			= $row['meta_name_t']; 
	}
	
	public function node()
	{
		if(is_null($this->_node))
			$this->_node = eZContentObjectTreeNode::fetch($this->node_id, $this->lang);
		return $this->_node;
	}
}

$cli    = eZCLI::instance();
$script = eZScript::instance(array(
            'description'   => "Compares objects in Solr and in eZ and allows to remove\n
            					ghosts from solr index\n",
            'use-session'   => false,
            'use-modules'   => true,
            'use-extensions'=> true 
            ));

$script->startup();
$options = $script->getOptions(
    "[subtree:][list]",
    "",
    array(	'subtree'		=> 	'Top node id under which to check (not required)',
            'list'		=>	'Allows to list ghosts without removing them from Solr',
    ),
    false,
    array( 'user' => true )
 );

$subtree = $options['subtree'];
$debugMode = $options['list'];
$ghosts = array();

$script->initialize();

if( !$subtree ){
    $cli->output('Getting solr results for');
}
else{
    $cli->output('Getting solr results for '.$subtree);
}


if( $debugMode ){
    $cli->notice( "debug mode activated" );
}

/* @var $solr eZSolr */
$solr = new eZSolr();
$solrBase = new eZSolrBase();

$fq = 'meta_installation_id_ms:'.eZSolr::installationID();
if( $subtree ){
    $fq .= ' AND meta_path_si:'.$subtree;
}

$params = array(
	'indent'		=> 'on',
	'q' 			=> '',
	'fq'			=> $fq,
	'start'			=> 0,
	'rows'			=> 0,
	'fl'			=> 'meta_main_url_alias_ms,meta_main_node_id_si,meta_name_t,meta_guid_ms,meta_language_code_ms',
	'qt'			=> 'ezpublish',
	'explainOther'	=> '',
	'hl.fl'			=> '',
);

$r = $solrBase->rawSolrRequest('/select', $params);
$num_found = $r['response']['numFound'];

$cli->output( "$num_found solr objects found" );

$offset = 0;
$params['rows'] = 100;
while($offset < $num_found){

	$r = $solrBase->rawSolrRequest('/select', $params);
	
	foreach($r['response']['docs'] as $row){
		$n = new kezfinCleanNode($row);
		
		if(!$n->node())															// ghost
			$ghosts[] = $n;
		elseif($n->url_alias != $n->node()->urlAlias())							// wrong path
			$wrong_path[] = $n;
		else																	// ok
			unset($n);						
	}
	
	$offset += 100;
	$params['start'] = $offset;
}

$cli->output( $num_found.' nodes found in solr' );
$cli->output( 'Ghosts: '.count($ghosts) );
	
if(count($ghosts))
{
	$del_docs = array();
	$cli->output("Ghosts\n---------------");
	/* @var $n kezfinCleanNode */
	foreach($ghosts as $n)
	{
		$cli->output($n->url_alias);
		$del_docs[] = $n->guid;
	}
	
	if( !$debugMode )
	{
		$cli->output("Removing ghosts from solr");
		$solrBase->deleteDocs($del_docs, false, true, false);
	}
}

$cli->output("\nDone");
$script->shutdown();


?>