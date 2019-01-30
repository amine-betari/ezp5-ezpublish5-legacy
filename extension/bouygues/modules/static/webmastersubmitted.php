<?php
include_once( "kernel/common/template.php" );

$http = eZHTTPTool::instance();
$Module = $Params['Module'];
$tpl = templateInit();

$tpl->setVariable('contactNodeId', $http->variable('who'));

$Result = array();
$Result['content'] = $tpl->fetch( "design:static/webmastersubmitted.tpl" );
$Result['static_mode'] = 'footer';
$Result['static_identifier'] = 'webmastersubmitted';
$Result['path'] = array( 
			array( 'url' => false, 'text' => ezpI18n::tr( 'design/bouygues/metadata', 'metadata_contact' ) )
);