<?php
/**
 * Created by PhpStorm.
 * User: bpinchede
 * Date: 10/3/14
 * Time: 3:06 PM
 */

namespace Colas\IntranetSocleBundle;

use eZContentObjectTreeNode;
use eZPendingActions;

class RemoveHandler
{
    public function notify($contentObject)
    {
        $newPendingAction = new eZPendingActions(array(
            'action' => 'notify',
            'created' => time(),
            'param' => json_encode(array(
                'type' => 'content_remove',
                'contentobject_id' => $contentObject->ID,
            )),
        ));

        $newPendingAction->store();

        $contentIds = array();

        foreach($contentObject->attribute('parent_nodes') as $nodeId){

            $node = eZContentObjectTreeNode::fetch($nodeId);

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
                    'contentobject_id' => $contentId,
                )),
            ));

            $newPendingAction->store();
        }


    }
}