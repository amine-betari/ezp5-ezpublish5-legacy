<?php
include_once( "kernel/common/template.php" );

$http = eZHTTPTool::instance();
$Module = $Params['Module'];
$tpl = templateInit();

$Result = array();
$Result['content'] = $tpl->fetch( "design:static/sitemap.tpl" );
$Result['static_mode'] = 'footer';
$Result['static_identifier'] = 'sitemap';
$Result['path'] = array( 
			array( 'url' => false, 'text' => ezpI18n::tr( 'design/bouygues/metadata', 'metadata_sitemap' ))
);