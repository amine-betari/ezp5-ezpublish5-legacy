<?php
include_once( "kernel/common/template.php" );

$http = eZHTTPTool::instance();
$Module = $Params['Module'];
$tpl = templateInit();


if($http->hasPostVariable('who')){
	//Send email to group
	$nodes = eZContentObjectTreeNode::subTreeByNodeID(  array(	'Depth' => 2,
																'ClassFilterType' => 'include',
																'ClassFilterArray' => array( 'user' ),
																'Limitation' => array()
															), $http->postVariable('who') );
															
	$contactGroupNode = eZContentObjectTreeNode::fetch( $http->postVariable('who') );
															
	$tpl = templateInit();
	$tpl->setVariable( 'message', $http->postVariable('message') );
	$tpl->setVariable( 'subject', $http->postVariable('subject') );
	$tpl->setVariable( 'email', $http->postVariable('email') );
	$tpl->setVariable( 'title', ezpI18n::tr( 'design/bouygues/static', 'contact_title1' ) );
	$tpl->setVariable( 'subtitle', ezpI18n::tr( 'design/bouygues/static', 'contact_title2' ) );

	$contactGroupObj = eZContentObject::fetch($contactGroupNode->ContentObjectID);
	$tpl->setVariable( 'groupName', $contactGroupObj->attribute('name') );
	$mail = new eZMail();
	
	foreach($nodes as $node){
		
		$userId = $node->attribute('contentobject_id');
		$userObject = eZContentObject::fetch($userId);
		$user = eZUser::fetch( $userId );
		$email = $user->attribute('email');

		$templateResult = $tpl->fetch( 'design:emails/contact.tpl' );
		
		$ini = eZINI::instance();
		if ( $tpl->hasVariable( 'content_type' ) )
			$mail->setContentType( $tpl->variable( 'content_type' ) );
		
		$mail->setSender( $http->postVariable('email') );
		$mail->addReceiver( $email );		
	
	}
		
	$mail->setSubject( ezpI18n::tr( 'design/bouygues/static', 'contact_subject_mail' ) );
	$mail->setBody( $templateResult );
	$mailResult = eZMailTransport::send( $mail );

	echo $http->postVariable('who');
	
	eZDB::checkTransactionCounter();
	eZExecution::cleanExit();
}

$Result = array();
$Result['content'] = $tpl->fetch( "design:static/webmaster.tpl" );
$Result['static_mode'] = 'footer';
$Result['static_identifier'] = 'webmaster';
$Result['path'] = array( 
			array( 'url' => false, 'text' => ezpI18n::tr( 'design/bouygues/metadata', 'metadata_contact' ) )
);