<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/whoswho.php" );

$http = eZHTTPTool::instance();

$Module = $Params["Module"];
$Result = array();
$http = eZHTTPTool::instance();

$whoswhoObj = new whoswho();

$view = 'yourwhoswho';
$iNodeID = null;
$uWWName = null;
if ( isset($Params['action']))
{
	if($Params['action'] == 'subscribe'){
		$view = 'yourwhoswhosubscribe1';
		$nodeID = $Params['whoswho'];
		
		$ww_obj = eZContentObject::fetch($nodeID);
		$uWWName = $ww_obj->attribute('name');
		
		if($whoswhoObj->hasSubscribed($Params['whoswho'], null, 0))
			$view = 'yourwhoswhosubscribe3';
		elseif($whoswhoObj->hasSubscribed($Params['whoswho'], null, 1))
			$view = 'yourwhoswhosubscribe4';
			
		if(isset($Params['final'])){
			$view = 'yourwhoswhosubscribe2';
			$whoswhoObj->addSubscription($Params['whoswho'], null, $http->postVariable( 'message' ));
			eZDB::checkTransactionCounter();
			eZExecution::cleanExit();
		}
		$iNodeID = $nodeID;
	}
	elseif($Params['action'] == 'subscribemessage'){
		$nodeID = $Params['whoswho'];
		
		$ww_obj = eZContentObject::fetch($nodeID);
		$uWWName = $ww_obj->attribute('name');

		$view = 'yourwhoswhosubscribe2';

		$iNodeID = $nodeID;
	}
	elseif($Params['action'] == 'unsubscribe')
	{
		$nodeID = $Params['whoswho'];
		
		$ww_obj = eZContentObject::fetch($nodeID);
		$uWWName = $ww_obj->attribute('name');
		
		$view = 'yourwhoswhounsubscribe';
		$nodeID = $Params['whoswho'];
		$iNodeID = $nodeID;
	}
	elseif($Params['action'] == 'unsubscribed')
	{
		$nodeID = $Params['whoswho'];
		$ww_obj = eZContentObject::fetch($nodeID);
		if (is_object($ww_obj))
			$uWWName = $ww_obj->attribute('name');
			
		$view = 'yourwhoswhounsubscribed';
		
		if($whoswhoObj->hasSubscribed($Params['whoswho'], null, 1))
			$whoswhoObj->delSubscription($Params['whoswho'], null);	
		
		eZDB::checkTransactionCounter();
		eZExecution::cleanExit();
	}elseif($Params['action'] == 'unsubscribedmessage')
	{
		$nodeID = $Params['whoswho'];
		$ww_obj = eZContentObject::fetch($nodeID);
		if (is_object($ww_obj))
			$uWWName = $ww_obj->attribute('name');

		$view = 'yourwhoswhounsubscribed';
	}
}

$tpl = templateInit();
$tpl->setVariable( 'langCurrent',(eZLocale::instance()->localeFullCode()=='fre-FR')?'':'/en');


// From actions
$tpl->setVariable( 'whowho_name', $uWWName );
if ( $iNodeID != null )
{
	$tpl->setVariable( 'nodeId', $iNodeID);
}

//Check if user has subscribed to even 1 whoswho
$subscriptions = $whoswhoObj->getSubscription();

$tpl->setVariable( 'countSubscription', count($subscriptions) );

//Get all the whos who available
$nodes = eZContentObjectTreeNode::subTreeByNodeID(  array(	'Depth' => 2,
															'ClassFilterType' => 'include',
															'ClassFilterArray' => array( 'bouygues_whoswho' ),
															'Limitation' => array(),
															'SortBy' => array(array('name'))
														), 2 );
$arrWhoswhoUserLink = array();
foreach ( $nodes as $node ){
	
	$arrWhoswhoUserLink[$node->attribute( 'contentobject_id' )] = null;
	$linkArr = $whoswhoObj->getSubscription(null, $node->attribute( 'contentobject_id' ));
	if(count($linkArr) == 1)
		$arrWhoswhoUserLink[$node->attribute( 'contentobject_id' )] = $linkArr[0]['etat'];
}

$tpl->setVariable( 'whoswhouserlink', $arrWhoswhoUserLink );
$tpl->setVariable( 'whoswholist', $nodes );
$tpl->setVariable('user_id', eZUser::currentUserID());

$Result['content'] = $tpl->fetch( "design:profile/".$view.".tpl" );
$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => ezpI18n::tr( 'design/bouygues/tools', 'menu_left_whoswho' )  ) );