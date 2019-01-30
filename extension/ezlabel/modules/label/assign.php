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

$label = array();
$template = 'design:label/create.tpl';

if ( $http->hasVariable('LinkButton') ) {
    $labelId = 0;
    $objectId = 0;
    if( $http->hasVariable('ObjectId') )
    {
        $objectId = $http->variable('ObjectId');
    }
    if( $http->hasVariable('LabelId') )
    {
        $labelId = $http->variable('LabelId');
    }
    if( $objectId && $labelId )
    {
        eZLabel::createRelation( $labelId, $objectId );
    }

    if ( $http->hasSessionVariable( "LastAccessesURI" ) )
    {
        $module->redirectTo( $http->sessionVariable( "LastAccessesURI" ) );
    }
    else
    {
        $module->redirectTo( '/label/list' );
    }
    return true;
}


$tpl = templateInit();
$tpl->setVariable( "module", $module );
$tpl->setVariable( "label", $label );

$Result['content'] = $tpl->fetch( $template );
$Result['path'] = array( array( 'url' => false,
                                'text' => 'Label' ),
                         array( 'url' => false,
                                'text' => 'Edit' ) );

?>