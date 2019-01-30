<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebysondage.php" );

$Module = $Params["Module"];
$Result = array();
$tpl = templateInit();
$http = eZHTTPTool::instance();

$oSondage = new ebySondage();

if($http->hasPostVariable( 'id' )){
	ebySondage::setResponse($http->postVariable( 'id' ), $http->postVariable( 'reponse' ));
	$tpl->setVariable( 'current_language', $http->postVariable( 'current_language' ) );
	$tpl->setVariable( 'userHasResponded', 'true' );
}


$Result['content'] = $tpl->fetch( "design:home/sondage.tpl" );
	$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => 'Réponse sondage' ) );

