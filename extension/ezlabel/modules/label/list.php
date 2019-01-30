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

#include_once( 'lib/ezutils/classes/ezhttptool.php' );
include_once( 'kernel/common/template.php' );
#include_once( 'kernel/classes/ezpersistentobject.php' );
#include_once( 'lib/ezlocale/classes/eztime.php');

$http = eZHTTPTool::instance();
$tpl = templateInit();
$tpl->setVariable( 'file_list', false );
$tpl->setVariable( 'error_msg', false );

$Module = $Params["Module"];
$filePath = $Params['Parameters'];

$Result = array();
$Result['content'] = $tpl->fetch( 'design:label/list.tpl' );
$Result['path'] = array( array( 'url' => false,
                                'text' => 'Label' ),
                         array( 'url' => false,
                                'text' => 'List' ) );
?>
