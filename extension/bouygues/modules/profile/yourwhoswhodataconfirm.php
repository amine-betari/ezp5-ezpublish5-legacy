<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/whoswho.php" );

$http = eZHTTPTool::instance();

$Module = $Params["Module"];
$Result = array();
$tpl = templateInit();
$http = eZHTTPTool::instance();

$tpl->setVariable( 'langCurrent',(eZLocale::instance()->localeFullCode()=='fre-FR')?'':'/en');
$tpl->setVariable('user_id', eZUser::currentUserID());

$Result['content'] = $tpl->fetch( "design:profile/yourwhoswhodataconfirm.tpl" );
$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => 'Votre fiche Who\'s Who' ) );