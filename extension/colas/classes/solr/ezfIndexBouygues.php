<?php

class ezfIndexBouygues implements ezfIndexPlugin
{
    public function modify(eZContentObject $contentObject, &$docList)
    {
        //eZLog::write ("Indexing object -->".$contentObject->attribute('id'),'index_solr.log');
        $bouyguesSolrUtils = new BouyguesSolrUtils();
        $bouyguesSolrUtils->createMenuField($contentObject, $docList);
    }
}
