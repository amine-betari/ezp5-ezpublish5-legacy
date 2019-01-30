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

include_once('kernel/common/template.php');
#include_once('extension/ezlabel/classes/ezlabel.php');

$module = $Params["Module"];
$http = eZHttpTool::instance();

$label_id = $Params['LabelID'];
$label = array();

$template = 'design:label/edit.tpl';

if ($http->hasVariable('Submit')) {
    $label_id = $http->variable( 'Id' );
    if( $label_id )
    {
        $labelObject = eZLabel::fetch( $label_id );
        $label_name = $http->variable( 'Name' );

        if( is_object( $labelObject ) )
        {
            $labelObject->setAttribute( 'name', $label_name );
            $labelObject->store();
        }
    }
    $module->redirectTo( '/label/list' );
    return true;
}

if( $label_id ) {
    $labelObject = eZLabel::fetch( $label_id );
    $label['id'] = $labelObject->ID;
    $label['name'] = $labelObject->Name;
}

$tpl = templateInit();
$tpl->setVariable( "module", $Params['Module'] );

$tpl->setVariable( "label", $label );

$Result['content'] = $tpl->fetch( $template );
$Result['path'] = array( array( 'url' => false,
                                'text' => 'Label' ),
                         array( 'url' => false,
                                'text' => 'Edit' ) );
?>
