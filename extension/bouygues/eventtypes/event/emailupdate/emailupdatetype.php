<?php

class EmailUpdateType extends eZWorkflowEventType
{
    const WORKFLOW_TYPE_STRING = 'emailupdate';

    /**
     * Déclaration au système de l'évènement
     */
    function EmailUpdateType()
    {
        $this->eZWorkflowEventType(self::WORKFLOW_TYPE_STRING, ezpI18n::tr('kernel/workflow/event', 'Change user mail in newsletter before update'));
        $this->setTriggerTypes(array('content' => array( 'publish' => array ( 'before' ))));
    }

    /**
     * Execution du code
     * Récupère l'ancienne adresse mail pour retrouver les inscriptions à la newsletter et changer pour la nouvelle adresse mail
     *
     * @see eZWorkflowType::execute()
     */
    function execute($process, $event)
    {
        // get object being published
        $parameters = $process->attribute('parameter_list');
        $objectId = $parameters['object_id'];
        $user = eZUser::fetch($objectId);
        
        if ($user && is_object($user)) {
            
            $emailNew = $user->attribute('email');
            
            $subscriptions = eZSubscription::fetchListByUserID($objectId);
            foreach ($subscriptions as $key => $subscription) {
                $subscription->setAttribute('email', $emailNew);
            }
        }
        
        return eZWorkflowType::STATUS_ACCEPTED;
       
    }
}

eZWorkflowEventType::registerEventType(EmailUpdateType::WORKFLOW_TYPE_STRING, 'EmailUpdateType');