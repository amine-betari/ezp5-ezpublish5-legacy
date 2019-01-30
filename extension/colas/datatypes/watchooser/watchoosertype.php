<?php

/**
 * Datatype for eZPublish4
 * 
 * Type permettant de choisir une vidéo dans le flux de WAT
 */

class watDatatypeChooserType extends eZDataType {
	
	const DATA_TYPE_STRING = 'watchooser';
	
	public function __construct() {
		parent::__construct( watDatatypeChooserType::DATA_TYPE_STRING, 'WAT Chooser' );
	}
	
	/**
	 * Sets the default value.
	 * 
	 * (non-PHPdoc)
	 * @see eZDataType::initializeObjectAttribute()
	 */
    function initializeObjectAttribute( $contentObjectAttribute, $currentVersion, $originalContentObjectAttribute ) {
    }
    
    /**
     * Validation des données 
     * 
     * (non-PHPdoc)
     * @see eZDataType::validateObjectAttributeHTTPInput()
     */
    function validateObjectAttributeHTTPInput( $http, $base, $contentObjectAttribute )
    {
    	$data = $http->postVariable( $base . '_watchooser_data_text_' . $contentObjectAttribute->attribute( 'id' ));
    	if (!empty($data)) {
    		$data = json_decode($data);
    		if (empty($data)) {
    			return eZInputValidator::STATE_INVALID;
    		}
    		if (!is_numeric($data->id)) {
    			return eZInputValidator::STATE_INVALID;
    		}
    	}
    	return eZInputValidator::STATE_ACCEPTED;
    }
    
    /**
     * Fetches the http post var string input and stores it in the data instance.
     * 
     * (non-PHPdoc)
     * @see eZDataType::fetchObjectAttributeHTTPInput()
     */
    function fetchObjectAttributeHTTPInput( $http, $base, $contentObjectAttribute )
    {
    	if ( $http->hasPostVariable( $base . '_watchooser_data_text_' . $contentObjectAttribute->attribute( 'id' ) ) )
    	{
    		$watChooser = new watChooser($http->postVariable( $base . '_watchooser_data_text_' . $contentObjectAttribute->attribute( 'id' ) ));
    		$contentObjectAttribute->setAttribute( 'data_text', serialize($watChooser));
    		return true;
    	}
    	return false;
    }
    
    function objectAttributeContent( $contentObjectAttribute )
    {
    	return unserialize($contentObjectAttribute->attribute('data_text'));
    }
    
    function hasObjectAttributeContent( $contentObjectAttribute )
    {
    	return trim( $contentObjectAttribute->attribute( 'data_text' ) ) != '';
    }
}

eZDataType::register( watDatatypeChooserType::DATA_TYPE_STRING, 'watDatatypeChooserType' );
