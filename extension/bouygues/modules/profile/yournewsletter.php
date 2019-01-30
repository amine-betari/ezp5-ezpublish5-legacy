<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/newsletter.php" );

$http = eZHTTPTool::instance();

$Module = $Params["Module"];
$Result = array();

$http = eZHTTPTool::instance();


$newsletterObj = new newsletter();

if ( isset($Params['action']))
{
	$newsletterTypeObj = new eZNewsletterType();
	$newsletterTypeObj->setAttribute( 'id', $Params['newsletter'] );
	$subscriptionList = $newsletterTypeObj->subscriptionList();
	
	$booUnsubscribe = false;$booSubscribe = false;
	
	if($Params['action'] == 'subscribe'){
		$newsletterObj->addSubscription($subscriptionList[0]->SubscriptionID);
		$booSubscribe = true;
	}elseif($Params['action'] == 'unsubscribe'){
		$newsletterObj->delSubscription($subscriptionList[0]->SubscriptionID, null);
		$booUnsubscribe = true;
	}
}

$tpl = templateInit();
$tpl->setVariable( 'langCurrent',(eZLocale::instance()->localeFullCode()=='fre-FR')?'':'/en');

//Check if user has subscribed to even 1 newsletter
$subscriptions = $newsletterObj->getSubscription();
$tpl->setVariable( 'countSubscription', count($subscriptions)?count($subscriptions):0 );

//Get all the newsletters available
$newsletterTypeObj = new eZNewsletterType();
$newsletterTypesTmp = $newsletterTypeObj->fetchList(eZNewsletterType::StatusPublished,false);


$arrNewsletterUserLink = array(); $newsletterTypes = array(); $i = 1;
foreach ( $newsletterTypesTmp as $node ){
	
	$newsletterTypeObj->setAttribute( 'id', $node['id'] );
	$subscriptionList = $newsletterTypeObj->subscriptionList();

	$newsletterTypes[$i] = $node;
	$newsletterTypes[$i]['listId'] = $subscriptionList[0]->SubscriptionID;
	
	$arrNewsletterUserLink[$subscriptionList[0]->SubscriptionID] = null;
	$linkArr = $newsletterObj->getSubscription(null, $subscriptionList[0]->SubscriptionID);

	if(count($linkArr) == 1)
		$arrNewsletterUserLink[$subscriptionList[0]->SubscriptionID] = 1;
		
	$i++;
}


if($booSubscribe)
	$tpl->setVariable( 'subscribed', true );

if($booUnsubscribe)
	$tpl->setVariable( 'unsubscribed', true );

$tpl->setVariable( 'newsletterUserLink', $arrNewsletterUserLink );
$tpl->setVariable( 'newsletterlist', $newsletterTypes );

$Result['content'] = $tpl->fetch( "design:profile/yournewsletter.tpl" );
$Result['static_mode'] = 'profile';
$Result['static_identifier'] = 'yournewsletter';
$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => ezpI18n::tr( 'design/bouygues/tools', 'menu_left_newsletter' ) ) );