<?php

include_once( "kernel/common/template.php" );

$http = eZHTTPTool::instance();

$Module = $Params["Module"];
$Result = array();
$tpl = templateInit();
$http = eZHTTPTool::instance();

$tpl->setVariable( 'langCurrent',(eZLocale::instance()->localeFullCode()=='fre-FR')?'':'/en');

$Result['content'] = $tpl->fetch( "design:profile/yournewslettersubscribed.tpl" );
$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => ezpI18n::tr( 'design/bouygues/tools', 'menu_left_newsletter' ) ) );