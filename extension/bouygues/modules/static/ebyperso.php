<?php
include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebyperso.php" );

$http = eZHTTPTool::instance();
$Module = $Params['Module'];
$tpl = templateInit();

$oEby = new ebyPerso();
$usrObj = eZContentObject::fetch( $oEby->userId );
$widgetList = $oEby->widget_list;

$tpl->setVariable( 'widget_list', $widgetList );


$Result = array();
$Result['content'] = $tpl->fetch( "design:static/ebyperso.tpl" );
$Result['static_mode'] = 'ebyperso';
$Result['static_identifier'] = 'faq';
$Result['path'] = array( 
			array( 'url' => false, 'text' => ezpI18n::tr( 'design/bouygues/metadata', 'metadata_ebyperso' ) )
);