<?php
include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/newsletter.php" );

$http = eZHTTPTool::instance();
$Module = $Params['Module'];
$tpl = templateInit();


$newsletterTypeObj = new eZNewsletterType();
$newsletterTypes = $newsletterTypeObj->fetchList(eZNewsletterType::StatusPublished,false);
$tpl->setVariable( 'newsletterlist', $newsletterTypes );

$Result = array();
$Result['content'] = $tpl->fetch( "design:static/newsletter.tpl" );
$Result['static_mode'] = 'profile';
$Result['static_identifier'] = 'yournewsletter';
$Result['path'] = array( 
			array( 'url' => false, 'text' => ezpI18n::tr( 'design/bouygues/metadata', 'metadata_newsletter' ) )
);