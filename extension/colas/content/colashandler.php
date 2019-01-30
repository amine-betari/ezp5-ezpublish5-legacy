<?php

class ColasHandler extends eZContentObjectEditHandler
{

    function publish($contentObjectId, $contentObjectVersion)
    {

        $contentIds = array($contentObjectId);
        $contentObject = eZContentObject::fetch($contentObjectId);
        $isActuality = false;
        $container = ezpKernel::instance()->getServiceContainer();
        $remoteIdsActualites = array();
        $db = eZDB::instance();

        $ini = eZINI::instance('site.ini');
        $params = $ini->variable( 'Parameters_ez5','RemoteIds');
        foreach($params as $param){
            $remoteIdsActualites[] =  $container->getParameter($param);
        }


        // NOTIFICATIONS
        foreach($contentObject->attribute('parent_nodes') as $nodeId){

            $node = eZContentObjectTreeNode::fetch($nodeId);

            // Check if it's news
            if($contentObject->ClassIdentifier == "article") {
                if (in_array($node->ContentObject->RemoteID, $remoteIdsActualites)) {
                    $isActuality = true;
                }
            }
            if($node->attribute('class_identifier') == 'ecolas_dossier') {
                $contentIds[] = $node->attribute('contentobject_id');
                $parentNode = eZContentObjectTreeNode::fetch($node->attribute('parent_node_id'));

                if($parentNode->attribute('class_identifier') == 'ecolas_dossier'){
                    $contentIds[] = $parentNode->attribute('contentobject_id');
                    $parentParentNode = eZContentObjectTreeNode::fetch($parentNode->attribute('parent_node_id'));

                    if($parentParentNode->attribute('class_identifier') == 'ecolas_mini_site'){
                        $contentIds[] = $parentParentNode->attribute('contentobject_id');
                    }
                } elseif($parentNode->attribute('class_identifier') == 'ecolas_mini_site'){
                    $contentIds[] = $parentNode->attribute('contentobject_id');
                }
            }
        }

        foreach($contentIds as $contentId) {
            $newPendingAction = new eZPendingActions(array(
                'action' => 'notify',
                'created' => time(),
                'param' => json_encode(array(
                    'type' => 'content_publish',
                    'contentobject_id' => $contentId
                )),
            ));

            $newPendingAction->store();
        }


        // PUSH ACTUALITE
        if($contentObject->ClassIdentifier == "article"){
            $datamap = $contentObject->attribute('data_map');

            if($isActuality && $contentObject->CurrentVersion == 1) {
                $groupsIds = array();
                //Groups not use
                //$groupsIds = array('8030154', '8040767', '8040783', '8041200', '8041217', '8041220');
                if (isset($datamap['send_yammer']) && $datamap['send_yammer']->hasContent()) {
                    if ($datamap['send_yammer']->content() == 1) {
                        $newPendingActionNews = new eZPendingActions(array(
                            'action' => 'news',
                            'created' => time(),
                            'param' => json_encode(array(
                                'contentobject_id' => $contentObject->ID,
                                'group_ids' => $groupsIds
                            )),
                        ));
                        $newPendingActionNews->store();
                    }
                }
            }


            //Multipositionnement automatique
            $parentNodeIds = $contentObject->attribute('parent_nodes');
            $newNodeIds = array();

            if (isset($datamap['send_filiale']) && $datamap['send_filiale']->hasContent()) {
                $arrayLocationIds = array();
                foreach($datamap['send_filiale']->content() as $filialeRemoteId) {
                    //toutes les filiales
                    if ($filialeRemoteId == '0') {
                        foreach($remoteIdsActualites as $remoteId){
                            $filialeContent = eZContentObject::fetchByRemoteID($remoteId);
                            $filialeMainNodeId = $filialeContent->mainNodeID();
                            if(!in_array($filialeMainNodeId,$parentNodeIds)) {
                                $arrayLocationIds[] = $filialeMainNodeId;
                            }
                        }
                        break;
                    } else {
                        $filialeContent = eZContentObject::fetchByRemoteID($filialeRemoteId);
                        $filialeMainNodeId = $filialeContent->mainNodeID();
                        if(!in_array($filialeMainNodeId,$parentNodeIds)){
                            $arrayLocationIds[] = $filialeMainNodeId;
                        }
                    }
                }

                $db->begin();
                foreach($arrayLocationIds as $locationId) {
                    $newNode = $contentObject->addLocation($locationId, true);
                    $newNode->setAttribute( 'contentobject_is_published', 1 );
                    // Make sure the url alias is set updated.
                    $newNode->updateSubTreePath();
                    $newNode->sync();
                }
                $db->commit();

                eZContentCacheManager::clearContentCacheIfNeeded( $contentObject->attribute('id') );

            }

        }
    }

}
