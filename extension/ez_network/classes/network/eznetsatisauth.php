<?php
/**
 * File containing eZNetSatisAuth class
 *
 * @copyright Copyright (C) 1999-2014 eZ Systems AS. All rights reserved.
 * @license http://ez.no/software/proprietary_license_options/ez_proprietary_use_license_v1_0
 * @version 5.3.0
 * @package ez_network
 */

/*!
  \class eZNetSatisAuth eznetsatisauth.php
  \brief The class eZNetSatisAuth contains secrets used for authenticating downloads of
         Network packages via Composer/Satis

  Ref    https://jira.ez.no/browse/EZP-22503: Implement Network patching with Composer/Satis
*/
include_once( 'kernel/common/i18n.php' );

class eZNetSatisAuth extends eZPersistentObject
{
    /*!
     Constructor
    */
    function eZNetSatisAuth( $row = array() )
    {
        $this->eZPersistentObject( $row );
    }

    /*!
     \reimp
    */
    static function definition()
    {
        return array( "fields" => array( "id" => array( 'name' => 'ID',
                                                        'datatype' => 'integer',
                                                        'default' => 0,
                                                        'required' => true ),
                                         "network_key" => array( 'name' => 'NetworkKey',
                                                                 'datatype' => 'string',
                                                                 'default' => '',
                                                                 'required' => true ),
                                         "password_hash" => array( 'name' => 'PasswordHash',
                                                                   'datatype' => 'string',
                                                                   'default' => '',
                                                                   'required' => true ),
                                         "key_label" => array( 'name' => 'KeyLabel',
                                                               'datatype' => 'string',
                                                               'default' => '',
                                                               'required' => true ),
                                       ),
                      "keys" => array( 'id', 'network_key' ),
                      "increment_key" => 'id',
                      "class_name" => 'eZNetSatisAuth',
                      "sort" => array( 'key_label' => 'asc' ),
                      "name" => 'ezx_ezpnet_satis_auth' );
    }

    /*!
     \static

     Create new eZNetSatisAuth item
    */
    static function create( $networkKey, $password, $keyLabel )
    {
        return new eZNetSatisAuth( array( 'network_key' => $networkKey,
                                          'password_hash' => hash( 'sha512', $networkKey . $password ),
                                          'key_label' => $keyLabel ) );
    }

    /*!
     \static
     Get auth token count by network key

     \param $networkKey Network key

     \return auth token count for the given installation.
    */
    static function countByNetworkKey( $networkKey )
    {
        $resultSet = self::fetchObjectList( self::definition(),
                                            array(),
                                            array( 'network_key' => $networkKey ),
                                            null,
                                            null,
                                            false,
                                            false,
                                            array( array( 'operation' => 'count( network_key )',
                                                          'name' => 'count' ) ) );
        return $resultSet[0]['count'];
    }

    /*!
     \reimp
    */
    static function fetch( $id, $asObject = true )
    {
        return self::fetchObject( self::definition(),
                                  null,
                                  array( 'id' => $id ),
                                  $asObject );
    }

    /*!
     \static
     Fetch auth tokens by network key

     \param $networkKey Network key
    */
    static function fetchListByNetworkKey( $networkKey, $asObject = true )
    {
        return eZPersistentObject::fetchObjectList( self::definition(),
                                                    null,
                                                    array( 'network_key' => $networkKey ),
                                                    $asObject );
    }
}

?>
