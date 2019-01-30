<?php

require 'autoload.php';

$cli = eZCLI::instance();

$script = eZScript::instance(
    array(
        'description' =>
            "eZFind search index updater.\n\n" .
            "Goes trough all objects and reindexes the meta data to the search engine" .
            "\n" .
            "updatesearchindexsolr.php",
        'use-session' => true,
        'use-modules' => true,
        'use-extensions' => true
    )
);

$options = $script->getOptions(
    "[db-host:][db-user:][db-password:][db-database:][db-type:|db-driver:][sql][clean][clean-all][conc:][offset:][limit:][topNodeID:][php-exec:]",
    "",
    array(
        'db-host' => "Database host",
        'db-user' => "Database user",
        'db-password' => "Database password",
        'db-database' => "Database name",
        'db-driver' => "Database driver",
        'db-type' => "Database driver, alias for --db-driver",
        'sql' => "Display sql queries",
        'clean' =>  "Remove all search data of the current installation id before beginning indexing",
        'clean-all' => "Remove all search data for all installations",
        'conc' => 'Parallelization, number of concurent processes to use',
        'php-exec' => 'Full path to PHP executable',
        'offset' => '*For internal use only*',
        'limit' => '*For internal use only*',
        'topNodeID' => '*For internal use only*',
    )
);

$script->initialize();

$topNodeID = $options['topNodeID'];
const DEFAULT_COMMIT_WITHIN = 30;

$count = 0;
$node = eZContentObjectTreeNode::fetch( $topNodeID );
if ( !( $node instanceof eZContentObjectTreeNode ) )
{
    $this->CLI->error( "An error occured while trying fetching node $nodeID" );
    return 0;
}
$searchEngine = new eZSolr();

if ($subTree = $node->subTree(
            array(
            'SortBy' => array(),
            'Limitation' => array(),
            'MainNodeOnly' => true
            )
) )
{
    foreach ( $subTree as $innerNode )
    {
        $object = $innerNode->attribute( 'object' );
        if ( !$object )
        {
            continue;
        }

        //pass false as we are going to do a commit at the end
        $result = $searchEngine->addObject( $object, false, 0 , true );
        if ( !$result )
        {
        $cli->error( ' Failed indexing ' . $object->attribute('class_identifier') .  ' object with ID ' . $object->attribute( 'id' ) );
        }
        ++$count;
    }
}

$script->shutdown( 0 );