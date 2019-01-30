<?php

class BouyguesSolrUtils
{
    public function __construct()
    {

    }


    protected function addValueToDoc( &$docList, $key, $value, $isMultivalue = false, $deleteIfEmpty = false )
    {
        foreach( $docList as $languageCode => $doc )
        {
            if( $deleteIfEmpty && isset( $doc->Doc[$key]['content'] ) )
            {
                foreach( $doc->Doc[$key]['content'] as $k => $v )
                {
                    if( trim($v) == '' )
                        unset( $docList[$languageCode]->Doc[$key]['content'][$k] );
                }
            }

            if(     $isMultivalue
                ||  !isset( $doc->Doc[$key] )
                ||  empty( $doc->Doc[$key] )
            ){
                if( !is_array($value) )
                    $value = array( $value );
                foreach( $value as $v )
                    $docList[$languageCode]->addField( $key, $v );
            }
        }
    }

    /*
    * Create meta_menu_visible_b field for all objects
    * @param $contentObject
    * @param $docList
    */

    public function createMenuField($contentObject,&$docList)
    {
        $dataMap = $contentObject->dataMap();

        $isVisible=true;

        if(array_key_exists('menu_cb',$dataMap))
        {
            $menuAttribute=$dataMap['menu_cb'];
            if($menuAttribute->hasContent()) {
                $isVisible=$menuAttribute->attribute('data_int');
                //eZLog::write ("Setting field visible with -->".$isVisible . ' for object -->'.$contentObject->attribute('id'),'index_solr.log');
            }
        }

        $attributeFieldName='meta_menu_visible_b';
        $this->addValueToDoc($docList, $attributeFieldName, $isVisible, false);
    }

}
