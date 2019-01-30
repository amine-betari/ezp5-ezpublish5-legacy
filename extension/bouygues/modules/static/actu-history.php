<?php
include_once( "kernel/common/template.php" );

$http = eZHTTPTool::instance();
$Module = $Params['Module'];
$tpl = templateInit();


$tpl->setVariable( 'view_parameters', array( 'offset' => $Params['offset']));


$Result = array();
$Result['content'] = $tpl->fetch( "design:static/actu-history.tpl" );
$Result['mode'] = 'homepage';
$Result['path'] = array( 
			array( 'url' => false, 'text' => ezpI18n::tr( 'design/bouygues/metadata', 'metadata_news_history' ) )
);