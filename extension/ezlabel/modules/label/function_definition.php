<?php
//
// Created on: <30-Oct-2005 11:11:11 dis>
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

$FunctionList = array();
$FunctionList['list'] = array( 'operation_types' => array( 'read' ),
                               'call_method' => array( 'include_file' => 'extension/ezlabel/modules/label/ezlabelfunctioncollection.php',
                                                       'class' => 'eZLabelFunctionCollection',
                                                       'method' => 'fetchList' ),
                               'parameter_type' => 'standard',
                               'parameters' => array( array( 'name' => 'scope',
                                                             'type' => 'string',
                                                             'required' => false,
                                                             'default' => 'all' ),
                                                      array( 'name' => 'offset',
                                                             'type' => 'integer',
                                                             'required' => false,
                                                             'default' => false ),
                                                      array( 'name' => 'limit',
                                                             'type' => 'integer',
                                                             'required' => false,
                                                             'default' => false ) ) );

$FunctionList['object_list'] = array( 'operation_types' => array( 'read' ),
                               'call_method' => array( 'include_file' => 'extension/ezlabel/modules/label/ezlabelfunctioncollection.php',
                                                       'class' => 'eZLabelFunctionCollection',
                                                       'method' => 'fetchObjectList' ),
                               'parameter_type' => 'standard',
                               'parameters' => array( array( 'name' => 'object_id',
                                                             'type' => 'integer',
                                                             'required' => true,
                                                             'default' => false ),
                                                      array( 'name' => 'scope',
                                                             'type' => 'string',
                                                             'required' => false,
                                                             'default' => 'all' ),
                                                     array( 'name' => 'offset',
                                                             'type' => 'integer',
                                                             'required' => false,
                                                             'default' => false ),
                                                      array( 'name' => 'limit',
                                                             'type' => 'integer',
                                                             'required' => false,
                                                             'default' => false ) ) );

$FunctionList['list_count'] = array( 'operation_types' => array( 'read' ),
                               'call_method' => array( 'include_file' => 'extension/ezlabel/modules/label/ezlabelfunctioncollection.php',
                                                       'class' => 'eZLabelFunctionCollection',
                                                       'method' => 'fetchListCount' ),
                               'parameter_type' => 'standard',
                               'parameters' => array( array( 'name' => 'scope',
                                                             'type' => 'string',
                                                             'required' => false,
                                                             'default' => 'all' ),
                                                      array( 'name' => 'offset',
                                                             'type' => 'integer',
                                                             'required' => false,
                                                             'default' => false ),
                                                      array( 'name' => 'limit',
                                                             'type' => 'integer',
                                                             'required' => false,
                                                             'default' => false ) ) );

$FunctionList['can_assign_labels'] = array( 'operation_types' => array( 'read' ),
                               'call_method' => array( 'include_file' => 'extension/ezlabel/modules/label/ezlabelfunctioncollection.php',
                                                       'class' => 'eZLabelFunctionCollection',
                                                       'method' => 'getAssignLabelPolicy' ),
                               'parameter_type' => 'standard' );

$FunctionList['can_create_labels'] = array( 'operation_types' => array( 'read' ),
                               'call_method' => array( 'include_file' => 'extension/ezlabel/modules/label/ezlabelfunctioncollection.php',
                                                       'class' => 'eZLabelFunctionCollection',
                                                       'method' => 'getCreateLabelPolicy' ),
                               'parameter_type' => 'standard' );

?>
