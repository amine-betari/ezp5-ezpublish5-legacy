<?php
//
// ## BEGIN COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
// SOFTWARE NAME: eZ Tika
// SOFTWARE RELEASE: 1.1-final
// COPYRIGHT NOTICE: Copyright (C) 2008-2009 Paul Borgermans and eZ Systems AS
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

/*! \file ezinfo.php
*/

/*!
  \class eZFindInfo ezinfo.php
  \brief The class eZFindInfo does

*/

class eZTikaInfo
{
    static function info()
    {
        return array(
            'Name' => "eZ Tika",
            'Version' => "1.1",
            'Copyright' => "Copyright © 2008-2009 Paul Borgermans",
            'Info_url' => "http://projects.ez.no/eztika",
            'License' => "GNU General Public License v2.0",
            '3rdparty_software' =>
            array ( 'name' => 'Tika',
                    'Version' => '0.5-svn (rev  814142)',
                    'copyright' => 'The Apache Software Foundation.',
                    'license' => 'Apache License, Version 2.0',
                    'info_url' => 'http://lucene.apache.org/tika/' ) );
    }
}

?>
