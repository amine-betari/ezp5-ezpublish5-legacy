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
// ## END COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
//
/*
include_once( 'kernel/classes/ezpersistentobject.php' );
include_once( 'lib/ezutils/classes/ezdebug.php' );
*/

class eZLabel extends eZPersistentObject {

    const ACCESS_LIMIT_NONE = 0;
    const ACCESS_LIMIT_GLOBAL = 1;
    const ACCESS_LIMIT_PRIVATE = 2;
    const ACCESS_LIMIT_ALL = 3;

    function __construct( $row = array() )
    {
        parent::__construct( $row );
    }

    static function definition() {
        return array( 'fields' => array( 'id' => array( 'name' => 'ID',
                                                        'datatype' => 'integer',
                                                        'default' => 0,
                                                        'required' => true ),
                                         'owner_id' => array( 'name' => 'Owner',
                                                                 'datatype' => 'integer',
                                                                 'default' => 0,
                                                                 'required' => true ),
                                         'creator_id' => array( 'name' => 'Creator',
                                                                 'datatype' => 'integer',
                                                                 'default' => 0,
                                                                 'required' => true ),
                                         'created' => array( 'name' => 'Created',
                                                                 'datatype' => 'integer',
                                                                 'default' => 0,
                                                                 'required' => true ),
                                         'name' => array( 'name' => 'Name',
                                                                 'datatype' => 'string',
                                                                 'default' => '',
                                                                 'required' => true ) ),
                      'function_attributes' => array( 'is_private' => 'isPrivate',
                                                      'is_creator' => 'isCreator',
                                                      'can_edit' => 'canEdit',
                                                      'can_view' => 'canView',
                                                      'can_assign' => 'canAssign',
                                                      'can_unassign' => 'canUnassign',
                                                      'can_remove' => 'canRemove',
                                                      'scope' => 'scope',
                                                      'is_global' => 'isGlobal' ),
                      'keys' => array( 'id' ),
                      'increment_key' => 'id',
                      'sort' => array ( 'name' => 'desc' ),
                      'class_name' => 'eZLabel',
                      'name' => 'ezlabel' );
    }

    static function fetch( $id, $asObject = true ) {
        $user = eZUser::currentUser();
        $user_id = $user->attribute( 'contentobject_id' );
        $conds['id'] = array( '=', $id  );

        $persObject =  eZPersistentObject::fetchObject( eZLabel::definition(),
                                                null,
                                                $conds,
                                                $asObject );
        if( !$persObject )
            return -1;
        if( $persObject->attribute('owner_id') == 0 || $persObject->attribute('owner_id') == $user_id  )
            return $persObject;
        else
            return -2;
    }

    static function fetchList( $scope = false, $offset = false, $limit = false )
    {
        $accessResult = eZLabel::checkAccess( 'view' );
        if( $scope == 'global' && $accessResult == eZLabel::ACCESS_LIMIT_ALL
                                    || $accessResult == eZLabel::ACCESS_LIMIT_GLOBAL )
        {
            $conds['owner_id'] = array( '=', 0  );
        }
        if( $scope == 'private' && $accessResult == eZLabel::ACCESS_LIMIT_ALL
                                    || $accessResult == eZLabel::ACCESS_LIMIT_PRIVATE )
        {
            $user = eZUser::currentUser();
            $user_id = $user->attribute( 'contentobject_id' );
            $conds['owner_id'] = array( '=', $user_id  );
        }
        elseif( $scope == 'all' )
        {
            if( $accessResult == eZLabel::ACCESS_LIMIT_ALL )
            {
                $user = eZUser::currentUser();
                $user_id = $user->attribute( 'contentobject_id' );
                $conds['owner_id'] = array( array( 0, $user_id ) );
            }
            elseif( $accessResult == eZLabel::ACCESS_LIMIT_PRIVATE )
            {
                $user = eZUser::currentUser();
                $user_id = $user->attribute( 'contentobject_id' );
                $conds['owner_id'] = array( '=', $user_id  );
            }
            elseif( $accessResult == eZLabel::ACCESS_LIMIT_GLOBAL )
            {
                $conds['owner_id'] = array( '=', 0  );
            }
        }
        else {
            return false;
        }
        return eZPersistentObject::fetchObjectList( eZLabel::definition(),
                                                    null, // field filters
                                                    $conds, // conds
                                                    array('name' => 'asc'),
                                                    ( $limit )? array( 'offset' => $offset, 'length' => $limit ): null );

    }

    static function fetchObjectListEx( $object, $scope, $offset = false, $limit = false )
    {
        $accessResult = eZLabel::checkAccess( 'view' );
        $cond = '';
        if( $scope == 'global' ) {
            $conds[] = 0;
        }
        elseif( $scope == 'private' ) {
            $user = eZUser::currentUser();
            $user_id = $user->attribute( 'contentobject_id' );
            $conds[] = $user_id;
        }
        else {
            $user = eZUser::currentUser();
            $user_id = $user->attribute( 'contentobject_id' );
            $conds[] = $user_id;
            $conds[] = 0;
        }
        $cond = ' WHERE ezlabel.owner_id IN ( ' . implode(', ',$conds ). ' ) ';

        $user = eZUser::currentUser();
        $user_id = $user->attribute( 'contentobject_id' );
        if( $object ) {
             $cond .= 'AND ezlabel_object.contentobject_id = ' . $object . ' ';
        }
        $sql = 'SELECT ezlabel_object.contentobject_id, ezlabel.*
                  FROM ezlabel JOIN ezlabel_object ON ( ezlabel.id=ezlabel_object.label_id ) ' . $cond . '';

        $db = ezDB::instance();
        $result = $db->arrayQuery( $sql );

        $objectList = eZPersistentObject::handleRows( $result, 'ezlabel', true );
        
        return $objectList;
    }

    static function fetchListCount( $scope = false, $offset = false, $limit = false )
    {
        $accessResult = eZLabel::checkAccess( 'view' );
        if( $scope == 'global' && $accessResult == eZLabel::ACCESS_LIMIT_ALL
                                    || $accessResult == eZLabel::ACCESS_LIMIT_GLOBAL )
        {
            $conds[] = 0;
        }
        if( $scope == 'private' && $accessResult == eZLabel::ACCESS_LIMIT_ALL
                                    || $accessResult == eZLabel::ACCESS_LIMIT_PRIVATE )
        {
            $user = eZUser::currentUser();
            $user_id = $user->attribute( 'contentobject_id' );
            $conds[] = $user_id;
        }
        elseif( $scope == 'all' )
        {
            if( $accessResult == eZLabel::ACCESS_LIMIT_ALL )
            {
                $user = eZUser::currentUser();
                $user_id = $user->attribute( 'contentobject_id' );
                $conds[] = $user_id;
                $conds[] = 0;
            }
            elseif( $accessResult == eZLabel::ACCESS_LIMIT_PRIVATE )
            {
                $user = eZUser::currentUser();
                $user_id = $user->attribute( 'contentobject_id' );
                $conds[] = $user_id;
            }
            elseif( $accessResult == eZLabel::ACCESS_LIMIT_GLOBAL )
            {
                $conds[] = 0;
            }
        }
        else {
            return false;
        }
        $where = 'WHERE owner_id in ( '.implode( ', ', $conds ).' ) ';

        $db = ezDB::instance();
        $resultArray = $db->arrayQuery( 'SELECT count(*) AS count FROM ezlabel ' . $where );
        return $resultArray[0]['count'];
    }


    static function createNew( $user_id, $name, $private = true, $object_id = false ) {
        $db = eZDB::instance();
        $db->begin();
        if( $private == true )
        {
            $owner_id = $user_id;
        }
        else
        {
            $owner_id = 0;
        }
        $label = new eZLabel( array( 'name' => $name,
                                      'owner_id' => $owner_id,
                                      'creator_id' => $user_id,
                                      'created' => time() ) );
        $label->store();
        $db->commit();

        if( $object_id ) {
            eZLabel::createRelation( $label->ID, $object_id );
        }
        return $label;
    }
    
    static function relationExists( $label_id, $object_id  ) {
        $db = eZDB::instance();
        if( !$db->arrayQuery( 'SELECT * from ezlabel_object where label_id='.$db->escapeString( $label_id ).
                                                              ' AND contentobject_id='.$db->escapeString( $object_id ) ) )
        {
            return false;
        }
        return true;
    }

    static function createRelation( $label_id, $object_id ) {
        if( !eZLabel::relationExists( $label_id, $object_id  ) )
        {
            $db = eZDB::instance();
            $db->begin();
            $db->arrayQuery( 'INSERT INTO ezlabel_object(label_id, contentobject_id) values('.$db->escapeString( $label_id ).', '.$db->escapeString( $object_id ).')' );
            $db->commit();
        }
        return true;
    }

    static function removeRelation( $label_id, $object_id ) {
        $db = eZDB::instance();
        $db->begin();
        $db->arrayQuery( 'DELETE FROM ezlabel_object WHERE label_id='.$db->escapeString( $label_id ).' AND contentobject_id='.$db->escapeString( $object_id ) );
        $db->commit();
        return true;
    }

    static function removeLabel( $label_id ) {
        $db = eZDB::instance();
        $db->begin();
        $db->arrayQuery( 'DELETE FROM ezlabel WHERE id='.$db->escapeString( $label_id ) );
        $db->commit();

        $db->begin();
        $db->arrayQuery( 'DELETE FROM ezlabel_object WHERE label_id='.$db->escapeString( $label_id ) );
        $db->commit();
        return true;
    }

    function createSqlParts( $params ) {
        $user = eZUser::currentUser();
        $user_id = $user->attribute( 'contentobject_id' );

        $sqlTables= ', ezlabel_object, ezlabel ';

        $sqlJoins = ' ezlabel.id = ezlabel_object.label_id 
                        AND ezcontentobject.id = ezlabel_object.contentobject_id AND ';

        if ( isset( $params['label'] ) ) {
             $label = $params['label'];
        }
        else {
             return false;
        }
        $conds = array();
        if ( isset( $params['scope'] ) ) {
            $scope = $params['scope'];
            if( $scope == 'global' ) {
                $conds[] = 0;
            }
            elseif( $scope == 'private' ) {
                $user = eZUser::currentUser();
                $user_id = $user->attribute( 'contentobject_id' );
                $conds[] = $user_id;
            }
            elseif( $scope == 'all' ) {
                $user = eZUser::currentUser();
                $user_id = $user->attribute( 'contentobject_id' );
                $conds[] = $user_id;
                $conds[] = 0;
            }
            else {
                return false;
            }
        }
        else {
            $user = eZUser::currentUser();
            $user_id = $user->attribute( 'contentobject_id' );
            $conds[] = $user_id;
            $conds[] = 0;
        }
        $sqlJoins = $sqlJoins.' ezlabel.owner_id IN (' . implode(', ',$conds).') AND ';

        $sqlCond = 'ezlabel_object.label_id = ' . $label . ' AND ' . $sqlJoins;;

        return array( 'tables' => $sqlTables, 'joins'  => $sqlCond );
    }

    function isGlobal()
    {
        $retVal = ( $this->attribute( 'owner_id' ) == 0 );
        return $retVal;
    }

    function isPrivate()
    {
        $retVal = ( $this->attribute( 'owner_id' ) != 0 );
        return $retVal;
    }

    function scope()
    {
        $label = eZLabel::fetch( $this->attribute( 'id' ) );
        if( $label->attribute( 'owner_id' ) == 0 )
        {
            $retVal = 'global';
        }
        else
        {
            $retVal = 'private';
        }
        return $retVal;
    }

    function isCreator()
    {
        $user = eZUser::currentUser();
        $user_id = $user->attribute( 'contentobject_id' );
        $retVal = ( $this->attribute( 'creator_id' ) == $user_id );
        return $retVal;
    }

    static function canEdit( $scope = "all")
    {
        $accessResult = eZLabel::checkLabelAccess( "edit", $scope );
        return $accessResult;
    }

    static function canAssign( $scope = "all")
    {
        $accessResult = eZLabel::checkLabelAccess( "assign", $scope );
        return $accessResult;
    }

    static function canCreate( $scope = "all")
    {
        $accessResult = eZLabel::checkLabelAccess( "create", $scope );
        return $accessResult;
    }

    static function canUnassign( $scope = "all")
    {
        $accessResult = eZLabel::checkLabelAccess( "unassign", $scope );
        return $accessResult;
    }

    static function canRemove( $scope = "all")
    {
        $accessResult = eZLabel::checkLabelAccess( "remove", $scope );
        return $accessResult;
    }

    static function canView( $scope = "all")
    {
        $accessResult = eZLabel::checkLabelAccess( "remove", $scope );
        return $accessResult;
    }


    static function checkAccess( $functionName )
    {
        $user = eZUser::currentUser();
        $userID = $user->attribute( 'contentobject_id' );
        $accessResult = $user->hasAccessTo( 'label' , $functionName );
        $accessWord = $accessResult['accessWord'];
        if( $accessWord == 'yes' )
        {
            return eZLabel::ACCESS_LIMIT_ALL;
        }
        if( $accessWord == 'limited' )
        {
            foreach($accessResult['policies'] as $key => $value )
            {
                foreach($value as $key => $val )
                {
                    if( $key == 'Scope')
                    {
                        if( count($val) == 1 )
                        {
                            if( $val[0] == 'global')
                            {
                                return eZLabel::ACCESS_LIMIT_GLOBAL;
                            }
                            if( $val[0] == 'private')
                            {
                                return eZLabel::ACCESS_LIMIT_PRIVATE;
                            }
                            else
                            {
                                return eZLabel::ACCESS_LIMIT_NONE;
                            }
                        }
                        elseif( count($val) == 2 )
                        {
                            return eZLabel::ACCESS_LIMIT_ALL;
                        }
                        else
                        {
                            return eZLabel::ACCESS_LIMIT_NONE;
                        }
                    }
                }
            }
        }
        return eZLabel::ACCESS_LIMIT_NONE;
    }

    static function checkLabelAccess( $functionName, $scope )
    {
        $accessResult = eZLabel::checkAccess( $functionName );
        if( $scope == "global" && ( $accessResult == eZLabel::ACCESS_LIMIT_ALL
                                    || $accessResult == eZLabel::ACCESS_LIMIT_GLOBAL ) )
        {
            return true;
        }
        if( $scope == 'private' && ( $accessResult == eZLabel::ACCESS_LIMIT_ALL
                                    || $accessResult == eZLabel::ACCESS_LIMIT_PRIVATE ) )
        {
            return true;
        }
        elseif( $scope == 'all' && $accessResult != eZLabel::ACCESS_LIMIT_NONE )
        {
            return true;
        }
        return false;
    }

    function setPermissions( $permissionArray )
    {
        $this->Permissions = $permissionArray;
    }

    function permissions( )
    {
        return $this->Permissions;
    }

    function fetchAssignPolicy()
    {
        $accessResult = $this->checkAccess( 'assign' );
        $policy = array();
        if( $this->canAssign('global') == true )
        {
            $policy[] = 'global';
        }
        if( $this->canAssign('private') == true )
        {
            $policy[] = 'private';
        }
        return $policy;
    }

    function fetchCreatePolicy()
    {
        $policy = array();
        if( $this->canCreate("global") == true )
        {
            $policy[] = "global";
        }
        if( $this->canCreate("private") == true )
        {
            $policy[] = "private";
        }
        return $policy;
    }

    var $Permissions = array();
}

?>
