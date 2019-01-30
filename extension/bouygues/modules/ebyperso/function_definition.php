<?php

$extension = 'ebyperso';
$base = eZExtension::baseDirectory().'/bouygues';
$baseDir = "$base/modules/$extension/";

$FunctionList = array();

$FunctionList['ebyperso_bourse'] = array( 'name' => 'ebyperso_bourse',
                                             'call_method' => array( 'include_file' => $baseDir . 'ebypersofunctioncollection.php',
                                                                     'class' => 'ebypersoFunctionCollection',
                                                                     'method' => 'bourse' ),
                                             'parameter_type' => 'standard',
                                             'parameters' => array( ) );
?>