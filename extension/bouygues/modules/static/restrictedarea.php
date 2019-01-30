<?php
include_once( "kernel/common/template.php" );

$http = eZHTTPTool::instance();
$Module = $Params['Module'];
$tpl = templateInit();

$Result = array();
$Result['content'] = $tpl->fetch( "design:static/restrictedarea.tpl" );
$Result['static_mode'] = 'error';
$Result['static_identifier'] = 'error';
$Result['path'] = array( 
			array( 'url' => false, 'text' => ezpI18n::tr( 'extension/bouygues/error', 'error_restricted_meta' ) )
);