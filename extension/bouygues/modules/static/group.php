<?php
include_once( "kernel/common/template.php" );

$http = eZHTTPTool::instance();
$Module = $Params['Module'];
$tpl = templateInit();

$Result = array();
$Result['content'] = $tpl->fetch( "design:static/group.tpl" );
$Result['static_mode'] = 'footer';
$Result['static_identifier'] = 'group';
$Result['path'] = array( 
			array( 'url' => false, 'text' => ezpI18n::tr( 'design/bouygues/metadata', 'metadata_group' ) )
);