<?php

include_once( "kernel/common/template.php" );

$Module = $Params["Module"];
$Result = array();
$tpl = templateInit();
$http = eZHTTPTool::instance();
$user = eZUser::currentUser();
$tpl->setVariable( 'langCurrent',(eZLocale::instance()->localeFullCode()=='fre-FR')?'':'/en');

$view = 'yournotification';

/* cleanup notifications  */
$nodeList = eZSubtreeNotificationRule::fetchNodesForUserID($user->attribute( 'contentobject_id' ),false);

foreach ($nodeList as $nodeID){

	$myNode = eZContentObjectTreeNode::fetch($nodeID);

	if($myNode == null){
		$action = eZSubtreeNotificationRule::removeByNodeAndUserID( $user->attribute( 'contentobject_id' ), $nodeID );
	}
}

/* Ajax Actions */
if ( isset($Params['action']))
{
	if($Params['action'] == 'subscribe'){
		$view = 'yournotificationsubscribe';
		$nodeID = $Params['notification'];
			
		if(isset($Params['final'])){
			$view = 'yournotificationsubscribed';
			
			$nodeIDList = eZSubtreeNotificationRule::fetchNodesForUserID( $user->attribute( 'contentobject_id' ), false );
			if ( !in_array( $nodeID, $nodeIDList ) )
			{

			    $rule = eZSubtreeNotificationRule::create( $nodeID, $user->attribute( 'contentobject_id' ) );
			   	$rule->store();
			        
		        $address = $user->attribute( 'email' );
		        $settings = eZGeneralDigestUserSettings::fetchForUser( $address );
		        
		        if(!$settings){
		        	$userSettings = eZGeneralDigestUserSettings::create($address,1,3,'','23:00');
		        	$userSettings->store();
		        }

			    $alreadyExists = false;
			}
		}
		$tpl->setVariable( 'nodeId', $nodeID);
		
	}elseif($Params['action'] == 'unsubscribe'){
		$nodeID = $Params['notification'];
		
		$nodeIDList = eZSubtreeNotificationRule::fetchNodesForUserID( $user->attribute( 'contentobject_id' ), false );
		if ( in_array( $nodeID, $nodeIDList ) )
		{
		    $rule = eZSubtreeNotificationRule::removeByNodeAndUserID( $user->attribute( 'contentobject_id' ), $nodeID );
		}
		
		$tpl->setVariable( 'unsubscribed', '1' );
	}
}

//Check if user has subscribed to even 1 notification
$tpl->setVariable( 'countSubscription', count($subscriptions)?count($subscriptions):0 );

$Result['content'] = $tpl->fetch( "design:profile/".$view.".tpl" );
$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => ezpI18n::tr( 'design/bouygues/tools', 'menu_left_notification' )  ) );