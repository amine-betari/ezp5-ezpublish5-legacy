<?php

/**
 * Pour certains attributs de type relation d'objets, un traitement spécifique est fait
 * afin de facilité la création des filtres de recherche en rajoutant des subattribute
 * dans l'index Solr
 */
class SolrDocumentFieldBoolean extends ezfSolrDocumentFieldBase {

    public static $subattributesDefinition = array(
        self::DEFAULT_SUBATTRIBUTE => 'text',
        self::DEFAULT_SUBATTRIBUTE_TYPE => 'mstring'
    );

    const DEFAULT_SUBATTRIBUTE = 'full_text_field';

    const DEFAULT_SUBATTRIBUTE_TYPE = 'mstring';

    /*
     * Traitement par defaut des attribut de type relation d'objets
     * Création du champ servant à faire les filtres de recherche
     * @return array
     */
    public function getAttributeData() {
        $returnArray = array();

        $contentClassAttribute = $this->ContentObjectAttribute->attribute('contentclass_attribute');
        $content = $this->ContentObjectAttribute->content();
        //eZLog::write ("Found menu cb with value -->".$content,'index_solr.log');

        if($this->ContentObjectAttribute->contentClassAttributeIdentifier() == 'menu_cb') {
            $returnArray['meta_menu_visible_b'] = $content;

            //eZLog::write ("Found menu cb with value -->".$content . ' for object -->'.$this->ContentObjectAttribute->attribute('contentobject_id'),'index_solr.log');
        }


        return $returnArray;
    }

    /**
     * Surcharge le traitement par defaut pour des attribute_identifier spécifique
     * @return array
     */
    public function getData() {
        $contentClassAttribute = $this->ContentObjectAttribute->attribute('contentclass_attribute');
        $returnArray = array();

        switch ($contentClassAttribute->attribute('data_type_string')) {

            case 'ezboolean' : {
                //eZLog::write ('Attribute is ezobjectboolean','index_solr.log');
                $returnArray = $this->getAttributeData();
                break;
            }
            default: {
            break;
            }
        }

        return $returnArray;
    }


}