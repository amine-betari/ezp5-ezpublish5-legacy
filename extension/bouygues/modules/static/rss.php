<?php
include_once( "kernel/common/template.php" );

$http = eZHTTPTool::instance();
$Module = $Params['Module'];
$tpl = templateInit();

// Get all RSS Exports
$exportArray = eZRSSExport::fetchList();
$exportList = array();
foreach( $exportArray as $export )
{
    $exportList[$export->attribute( 'id' )] = $export;
}

$tpl->setVariable( 'exportList', $exportList );
$tpl->setVariable( 'host_path', eZSys::hostname() );

$Result = array();
$Result['content'] = $tpl->fetch( "design:static/rss.tpl" );
$Result['static_mode'] = 'homepage';
$Result['static_identifier'] = 'rss';
$Result['path'] = array( 
			array( 'url' => false, 'text' => ezpI18n::tr( 'design/bouygues/metadata', 'metadata_rss' ) )
);