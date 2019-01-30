<?php

include_once( "kernel/common/template.php" );

$Module = $Params["Module"];
$Result = array();
$tpl = templateInit();
$http = eZHTTPTool::instance();

$Result['content'] = $tpl->fetch( "design:faq/list.tpl" );
$Result['left_menu'] = 'design:faq/menu.tpl';
$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => 'FAQ' ) );

