<?php

include_once( "kernel/common/template.php" );

$http = eZHTTPTool::instance();
$Module = $Params['Module'];
$emailUser = '';
$statusMessage ='';

$tpl = templateInit();
$tpl->setVariable( 'langCurrent',(eZLocale::instance()->localeFullCode()=='fre-FR')?'':'/en');

$Result = array();
$Result['content'] = $tpl->fetch( "design:ebyidentification/error.tpl" );
$Result['path'] = array( 
			array( 'url' => false, 'text' => "Erreur Galby" )
);