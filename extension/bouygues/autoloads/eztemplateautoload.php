<?php


$eZTemplateOperatorArray = array();
$eZTemplateOperatorArray[] = array( 'script' => 'extension/bouygues/autoloads/cookieoperator.php',
                                    'class' => 'CookieOperator',
                                    'operator_names' => array( 'cookieset', 'cookieget' ) );

$eZTemplateOperatorArray[] = array( 'script' => 'extension/bouygues/autoloads/fetchoperator.php',
                                    'class' => 'FetchOperator',
                                    'operator_names' => array( 'fetchclasses' ) );

$eZTemplateOperatorArray[] = array( 'script' => 'extension/bouygues/autoloads/fetchoperator.php',
                                    'class' => 'FetchOperator',
                                    'operator_names' => array( 'fetchmenu' ) );

$eZTemplateOperatorArray[] = array( 'script' => 'extension/bouygues/autoloads/fetchsection.php',
                                    'class' => 'FetchSection',
                                    'operator_names' => array( 'setSection', 'getSection' ) );

$eZTemplateOperatorArray[] = array( 'script' => 'extension/bouygues/autoloads/helper.php',
                                    'class' => 'HelperEby',
                                    'operator_names' => array( 'orderByLastname' ) );

$eZTemplateOperatorArray[] = array( 'script' => 'extension/bouygues/autoloads/helper.php',
									'class' => 'HelperEby',
									'operator_names' => array( 'fetchUserByEmail' ) );
									
$eZTemplateOperatorArray[] = array( 'script' => 'extension/bouygues/autoloads/helper.php',
									'class' => 'HelperEby',
									'operator_names' => array( 'isEmailGalbyError' ) );
									
$eZTemplateOperatorArray[] = array( 'script' => 'extension/bouygues/autoloads/helper.php',
									'class' => 'HelperEby',
									'operator_names' => array( 'isRestrictedArea' ) );

$eZTemplateOperatorArray[] = array( 'script' => 'extension/bouygues/autoloads/helper.php',
									'class' => 'HelperEby',
									'operator_names' => array( 'getNodeByUrlAlias' ) );
									
$eZTemplateOperatorArray[] = array( 'script' => 'extension/bouygues/autoloads/helper.php',
									'class' => 'HelperEby',
									'operator_names' => array( 'getAnnuaireAvailability' ) );
									
$eZTemplateOperatorArray[] = array( 'script' => 'extension/bouygues/autoloads/helper.php',
									'class' => 'HelperEby',
									'operator_names' => array( 'isUserWidget' ) );
									
									
$eZTemplateOperatorArray[] = array( 'script' => 'extension/bouygues/autoloads/helper.php',
									'class' => 'HelperEby',
									'operator_names' => array( 'isUserFavorite' ) );
									
$eZTemplateOperatorArray[] = array( 'script' => 'extension/bouygues/autoloads/helper.php',
									'class' => 'HelperEby',
									'operator_names' => array( 'getUrlAliasBylang' ) );	
									
$eZTemplateOperatorArray[] = array( 'script' => 'extension/bouygues/autoloads/helper.php',
									'class' => 'HelperEby',
									'operator_names' => array( 'caidParameter' ) );								
									
?>