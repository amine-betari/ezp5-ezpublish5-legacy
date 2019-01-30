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

$Module = array( 'name' => 'label' );

$ViewList = array();

$ViewList['list'] = array(
    'script' => 'list.php',
    'functions' => array( 'view' ) );

$ViewList['create'] = array(
    'script' => 'create.php',
    'functions' => array( 'create', 'assign' ) );

$ViewList['assign'] = array(
    'script' => 'assign.php',
    'functions' => array( 'assign' ) );

$ViewList['edit'] = array(
    'script' => 'edit.php',
     'params' => array('LabelID'),
    'functions' => array( 'edit' ) );

$ViewList['view'] = array(
    'script' => 'view.php',
     'params' => array('LabelID'),
    'functions' => array( 'view' ) );

$ViewList['remove'] = array(
    'script' => 'remove.php',
     'params' => array('LabelID'),
    'functions' => array( 'remove' ) );

$ViewList['unassign'] = array(
    'script' => 'unassign.php',
     'params' => array('LabelID','ObjectID'),
    'functions' => array( 'unassign' ) );


$Scope = array(
    'name'=> 'Scope',
    'values'=> array(
        array(
            'Name' => 'Global',
            'value' => 'global'),
        array(
            'Name' => 'Private',
            'value' => 'private')
        )
    );

$FunctionList['create']   = array( 'Scope' => $Scope );
$FunctionList['assign']   = array( 'Scope' => $Scope );
$FunctionList['unassign'] = array( 'Scope' => $Scope );
$FunctionList['view']     = array( 'Scope' => $Scope );
$FunctionList['remove']   = array( 'Scope' => $Scope );
$FunctionList['edit']     = array( 'Scope' => $Scope );

?>
