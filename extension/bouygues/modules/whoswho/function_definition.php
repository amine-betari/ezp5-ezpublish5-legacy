<?php
//
// Created on: <05-Dec-2005 15:11:38 oms>
//
// ## BEGIN COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
// COPYRIGHT NOTICE: Copyright (C) 1999-2006 eZ systems AS
// SOFTWARE LICENSE: GNU General Public License v2.0
// NOTICE: >
//   This program is free software; you can redistribute it and/or
//   modify it under the terms of version 2.0  of the GNU General
//   Public License as published by the Free Software Foundation.
//
//   This program is distributed in the hope that it will be useful,
//   but WITHOUT ANY WARRANTY; without even the implied warranty of
//   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//   GNU General Public License for more details.
//
//   You should have received a copy of version 2.0 of the GNU General
//   Public License along with this program; if not, write to the Free
//   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
//   MA 02110-1301, USA.
//
//
// ## END COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
//

/*! \file function_definition.php
*/

$extension = 'whoswho';
$base = eZExtension::baseDirectory().'/bouygues';
$baseDir = "$base/modules/$extension/";

$FunctionList = array();

$FunctionList['whoswho_search'] = array( 'name' => 'whoswho_search',
                                             'call_method' => array( 'include_file' => $baseDir . 'whoswhofunctioncollection.php',
                                                                     'class' => 'whoswhoFunctionCollection',
                                                                     'method' => 'search' ),
											 'operation_types' => array( 'read' ),	
                                             'parameter_type' => 'standard',
                                             'parameters' => array( array( 'name' => 'first_name', 'type' => 'string', 'required' => false, 'default' => '' ),
                                                                    array( 'name' => 'last_name', 'type' => 'string', 'required' => false, 'default' => '' ),
                                                                    array( 'name' => 'civilite', 'type' => 'string', 'required' => false, 'default' => '' ),
                                                                    array( 'name' => 'fonction', 'type' => 'string', 'required' => false, 'default' => '' ),
                                                                    array( 'name' => 'direction', 'type' => 'string', 'required' => false, 'default' => '' ),
                                                                    array( 'name' => 'service', 'type' => 'int', 'required' => false, 'default' => 0 ),
                                                                    array( 'name' => 'entreprise', 'type' => 'int', 'required' => false, 'default' => 0 ),
                                                                    array( 'name' => 'filiale', 'type' => 'int', 'required' => false, 'default' => 0 ),
                                                                    array( 'name' => 'secteur', 'type' => 'string', 'required' => false, 'default' => '' ),
                                                                    array( 'name' => 'pro_adresse', 'type' => 'string', 'required' => false, 'default' => '' ),
                                                                    array( 'name' => 'emplacement', 'type' => 'string', 'required' => false, 'default' => '' ),
                                                                    array( 'name' => 'pro_tel', 'type' => 'string', 'required' => false, 'default' => '' ),
                                                                    array( 'name' => 'pro_mobile', 'type' => 'string', 'required' => false, 'default' => '' ),
                                                                    array( 'name' => 'pro_fax', 'type' => 'string', 'required' => false, 'default' => '' ),
                                                                    array( 'name' => 'assistante_nom', 'type' => 'string', 'required' => false, 'default' => '' ),
                                                                    array( 'name' => 'assistante_tel', 'type' => 'string', 'required' => false, 'default' => '' ),
                                                                    array( 'name' => 'date_naissance', 'type' => 'string', 'required' => false, 'default' => '' ),
                                                                    array( 'name' => 'date_entree', 'type' => 'string', 'required' => false, 'default' => '' ),
                                                                    array( 'name' => 'diplome', 'type' => 'string', 'required' => false, 'default' => '' ),
                                                                    array( 'name' => 'parcours_pro', 'type' => 'string', 'required' => false, 'default' => '' ),
                                                                    array( 'name' => 'mission_actuelle', 'type' => 'string', 'required' => false, 'default' => '' ),
                                                                    array( 'name' => 'mission_precedente', 'type' => 'string', 'required' => false, 'default' => '' ),
                                                                    array( 'name' => 'competences', 'type' => 'string', 'required' => false, 'default' => '' ),
                                                                    array( 'name' => 'centres_interet', 'type' => 'string', 'required' => false, 'default' => '' ),
                                                                    array( 'name' => 'limit', 'type' => 'int', 'required' => false, 'default' => 0 ),
                                                                    array( 'name' => 'offset', 'type' => 'int', 'required' => false, 'default' => 0 ),
                                                                    array( 'name' => 'ww_id', 'type' => 'id', 'required' => false, 'default' => 0 )) );

$FunctionList['search_options'] = array( 'name' => 'search_options',
                                             'call_method' => array( 'include_file' => $baseDir . 'whoswhofunctioncollection.php',
                                                                     'class' => 'whoswhoFunctionCollection',
                                                                     'method' => 'listSearchOptions' ),
											'operation_types' => array( 'read' ),
                                             'parameter_type' => 'standard',
                                             'parameters' => array( array( 'name' => 'type',
                                                                           'type' => 'string',
                                                                           'required' => false,
                                                                           'default' => 'secteur' ),
																	array( 'name' => 'section_id',
                                                                           'type' => 'int',
                                                                           'required' => false,
                                                                           'default' => 0 )) );

$FunctionList['search_option_value'] = array( 'name' => 'search_option_value',
                                             'call_method' => array( 'include_file' => $baseDir . 'whoswhofunctioncollection.php',
                                                                     'class' => 'whoswhoFunctionCollection',
                                                                     'method' => 'fetchOptionValue' ),
                                             'operation_types' => array( 'read' ),
                                             'parameter_type' => 'standard',
                                             'parameters' => array( array( 'name' => 'id',
                                                                           'type' => 'int',
                                                                           'required' => true,
                                                                           'default' => 0 )) );

$FunctionList['whoswho_settings_search'] = array( 'name' => 'whoswho_settings_search',
                                             'call_method' => array( 'include_file' => $baseDir . 'whoswhofunctioncollection.php',
                                                                     'class' => 'whoswhoFunctionCollection',
                                                                     'method' => 'fetchSettingsSearch' ),
'operation_types' => array( 'read' ),
                                             'parameter_type' => 'standard',
                                             'parameters' => array( array( 'name' => 'ww_id',
                                                                           'type' => 'int',
                                                                           'required' => true,
                                                                           'default' => 0 )) );

$FunctionList['whoswho_settings_fields'] = array( 'name' => 'whoswho_settings_fields',
                                             'call_method' => array( 'include_file' => $baseDir . 'whoswhofunctioncollection.php',
                                                                     'class' => 'whoswhoFunctionCollection',
                                                                     'method' => 'fetchSettingsFields' ),
'operation_types' => array( 'read' ),
                                             'parameter_type' => 'standard',
                                             'parameters' => array( array( 'name' => 'ww_id',
                                                                           'type' => 'int',
                                                                           'required' => true,
                                                                           'default' => 0 )) );

$FunctionList['whoswho_fetch'] = array( 'name' => 'whoswho_fetch',
                                             'call_method' => array( 'include_file' => $baseDir . 'whoswhofunctioncollection.php',
                                                                     'class' => 'whoswhoFunctionCollection',
                                                                     'method' => 'fetch' ),
'operation_types' => array( 'read' ),
                                             'parameter_type' => 'standard',
                                             'parameters' => array( array( 'name' => 'user_id',
                                                                           'type' => 'id',
                                                                           'required' => true,
                                                                           'default' => 0 ),
																	array( 'name' => 'ww_id',
                                                                           'type' => 'id',
                                                                           'required' => false,
                                                                           'default' => 0 )) );


$FunctionList['whoswho_user'] = array( 'name' => 'whoswho_fetch',
									         'call_method' => array( 'include_file' => $baseDir . 'whoswhofunctioncollection.php',
									                                 'class' => 'whoswhoFunctionCollection',
									                                 'method' => 'fetchWhoswhoByUser' ),
						   	 			     'operation_types' => array( 'read' ),
						                     'parameter_type' => 'standard',
											 'parameters' => array( array( 'name' => 'user_id',
											 								'type' => 'id',
											 								'required' => false,
											 								'default' => 0 )) );

$FunctionList['whoswho_user_subscribed_once'] = array( 'name' => 'whoswho_user_subscribed_once',
							         		'call_method' => array( 'include_file' => $baseDir . 'whoswhofunctioncollection.php',
																	'class' => 'whoswhoFunctionCollection',
																	'method' => 'hasSubscribedAtLeastOnce' ),
											'operation_types' => array( 'read' ),
											'parameter_type' => 'standard',
											'parameters' => array( array( 'name' => 'user_id',
																		'type' => 'id',
																		'required' => false,
																		'default' => null )) );
?>
