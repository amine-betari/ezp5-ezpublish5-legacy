<?php

/**
 * Datatype for eZPublish4
 *
 * Type permettant de choisir une vidéo dans l'API de YouTube
 */

class youtubeDatatypeChooserType extends eZDataType {

    const DATA_TYPE_STRING = 'youtubechooser';

    public function __construct() {
        parent::__construct( youtubeDatatypeChooserType::DATA_TYPE_STRING, 'YouTube Chooser' );
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
        $data = $http->postVariable( $base . '_youtubechooser_data_text_' . $contentObjectAttribute->attribute( 'id' ));
        if (!empty($data)) {
            $data = json_decode($data);
            if (empty($data)) {
                return eZInputValidator::STATE_INVALID;
            }
            if (empty($data->resourceId)) {
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
        if ( $http->hasPostVariable( $base . '_youtubechooser_data_text_' . $contentObjectAttribute->attribute( 'id' ) ) )
        {
            $youtubeChooser = new youtubeChooser($http->postVariable( $base . '_youtubechooser_data_text_' . $contentObjectAttribute->attribute( 'id' ) ));
            $contentObjectAttribute->setAttribute( 'data_text', serialize($youtubeChooser));
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

eZDataType::register( youtubeDatatypeChooserType::DATA_TYPE_STRING, 'youtubeDatatypeChooserType' );
