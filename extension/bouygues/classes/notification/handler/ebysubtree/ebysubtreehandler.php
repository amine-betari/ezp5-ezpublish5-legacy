<?php

/* Created on: <02-Jan-2010>
 *
 * @author LIU Bin <robin_liu79@yahoo.fr>
 *
 */

class eBySubTreeHandler extends eZNotificationEventHandler
{
    const NOTIFICATION_HANDLER_ID = 'ebysubtree';
    const TRANSPORT = 'ezmail';

    /*!
     Constructor
    */
    function eBySubTreeHandler()
    {
        $this->eZNotificationEventHandler( self::NOTIFICATION_HANDLER_ID, "Subtree Handler" );
    }

    function attributes()
    {
        return array_merge( array( 'subscribed_nodes',
                                   'rules' ),
                            eZNotificationEventHandler::attributes() );
    }

    function hasAttribute( $attr )
    {
        return in_array( $attr, $this->attributes() );
    }

    function attribute( $attr )
    {
        if ( $attr == 'subscribed_nodes' )
        {
            $user = eZUser::currentUser();
            return $this->subscribedNodes( $user );
        }
        else if ( $attr == 'rules' )
        {
            $user = eZUser::currentUser();
            return $this->rules( $user );
        }
        return eZNotificationEventHandler::attribute( $attr );
    }

    function handle( $event )
    {
        eZDebugSetting::writeDebug( 'kernel-notification', $event, "trying to handle event" );
        if ( $event->attribute( 'event_type_string' ) == 'ezpublish' )
        {
            $parameters = array();
            $status = $this->handlePublishEvent( $event, $parameters );
            if ( $status == eZNotificationEventHandler::EVENT_HANDLED )
                $this->sendMessage( $event, $parameters );
            else
                return false;
        }
        return true;
    }

    function handlePublishEvent( $event, &$parameters )
    {



        $versionObject = $event->attribute( 'content' );
        if ( !$versionObject )
            return eZNotificationEventHandler::EVENT_SKIPPED;
        $contentObject = $versionObject->attribute( 'contentobject' );
        if ( !$contentObject )
            return eZNotificationEventHandler::EVENT_SKIPPED;
        $contentNode = $contentObject->attribute( 'main_node' );
        if ( !$contentNode )
            return eZNotificationEventHandler::EVENT_SKIPPED;

        if ( $contentNode->attribute('name')  == '' )
            return eZNotificationEventHandler::EVENT_SKIPPED;

        // Notification should only be sent out when the object is published (is visible)
        if ( $contentNode->attribute( 'is_invisible' ) == 1 )
           return eZNotificationEventHandler::EVENT_SKIPPED;
        $contentClass = $contentObject->attribute( 'content_class' );
        if ( !$contentClass )
            return eZNotificationEventHandler::EVENT_SKIPPED;
        /**************************************************
        exclude custom class into eznotification event
        * ****************************************************/

        $notification_ini = eZINI::instance('notification.ini.append.php');
        if( $notification_ini->hasVariable( 'ebysubtree','exclude_classes') )
        {
        	$exclude_classes = $notification_ini->variable( 'ebysubtree','exclude_classes');
        }
        else
        {
        	$exclude_classes = array();
        }

        if( $exclude_classes && in_array($contentClass->attribute( 'identifier' ),$exclude_classes) )
        {
        	return eZNotificationEventHandler::EVENT_SKIPPED;
        }


         /*
         * Exclude some subtrees
         */
        if( $notification_ini->hasVariable( 'ebysubtree','exclude_subtree') )
        {
        	$exclude_subtree = $notification_ini->variable( 'ebysubtree','exclude_subtree');
        }
        else
        {
        	$exclude_subtree = array();
        }


        if( $exclude_subtree && in_array($contentObject->attribute('main_parent_node_id'),$exclude_subtree) )
        {
        	return eZNotificationEventHandler::EVENT_SKIPPED;
        }



        if ( // $versionObject->attribute( 'version' ) != 1 ||
             $versionObject->attribute( 'version' ) != $contentObject->attribute( 'current_version' ) )
        {
            return eZNotificationEventHandler::EVENT_SKIPPED;
        }

        /*
         * filtrer les objects doublons avant saisie dans la table eZNotificationEvent
         * si l'object ID existe déjà, on skip.
        */
		/*
		//method ez, mais manque eznotificationcollection. à supprimer
		$conds = array( 'event_type_string' => 'ezpublish',
                     'data_int1' => $contentObject->attribute( 'id' ) );
        $nb_event = eZPersistentObject::count( eZNotificationEvent::definition(), $conds, "id");
    	if( $nb_event > 0)
        {
            return eZNotificationEventHandler::EVENT_SKIPPED;
        }*/

        $sql = "select count(e.id) as nb_event from eznotificationevent e, eznotificationcollection n
        		where e.id = n.event_id and e.data_int1 = " . $contentObject->attribute( 'id' ) . "
        		and e.event_type_string = 'ezpublish' and n.handler = 'ebysubtree'
        		";

        $db = eZDB::instance();
        $res = $db->arrayQuery( $sql );
        if( isset( $res[0]["nb_event"] ) && $res[0]["nb_event"] > 0 )
        {
        	return eZNotificationEventHandler::EVENT_SKIPPED;
        }

        require_once( 'kernel/common/template.php' );
        $tpl = templateInit();
        $tpl->resetVariables();

        $parentNode = $contentNode->attribute( 'parent' );
		if ( !$parentNode )
		           return eZNotificationEventHandler::EVENT_SKIPPED;


        $parentContentObject = $parentNode->attribute( 'object' );
        $parentContentClass = $parentContentObject->attribute( 'content_class' );

        $res = eZTemplateDesignResource::instance();
        $res->setKeys( array( array( 'object', $contentObject->attribute( 'id' ) ),
                              array( 'node', $contentNode->attribute( 'node_id' ) ),
                              array( 'class', $contentObject->attribute( 'contentclass_id' ) ),
                              array( 'class_identifier', $contentClass->attribute( 'identifier' ) ),
                              array( 'parent_node', $contentNode->attribute( 'parent_node_id' ) ),
                              array( 'parent_class', $parentContentObject->attribute( 'contentclass_id' ) ),
                              array( 'parent_class_identifier', ( $parentContentClass != null ? $parentContentClass->attribute( 'identifier' ) : 0 ) ),
                              array( 'depth', $contentNode->attribute( 'depth' ) ),
                              array( 'url_alias', $contentNode->attribute( 'url_alias' ) )
                              ) );

        $tpl->setVariable( 'object', $contentObject );

        $notificationINI = eZINI::instance( 'notification.ini' );
        $emailSender = $notificationINI->variable( 'MailSettings', 'EmailSender' );
        $ini = eZINI::instance();
        if ( !$emailSender )
            $emailSender = $ini->variable( 'MailSettings', 'EmailSender' );
        if ( !$emailSender )
            $emailSender = $ini->variable( "MailSettings", "AdminEmail" );
        $tpl->setVariable( 'sender', $emailSender );

        $result = $tpl->fetch( 'design:notification/handler/ebysubtree/view/plain.tpl' );
        $subject = $tpl->variable( 'subject' );
        if ( $tpl->hasVariable( 'message_id' ) )
            $parameters['message_id'] = $tpl->variable( 'message_id' );
        if ( $tpl->hasVariable( 'references' ) )
            $parameters['references'] = $tpl->variable( 'references' );
        if ( $tpl->hasVariable( 'reply_to' ) )
            $parameters['reply_to'] = $tpl->variable( 'reply_to' );
        if ( $tpl->hasVariable( 'from' ) )
            $parameters['from'] = $tpl->variable( 'from' );
        if ( $tpl->hasVariable( 'content_type' ) )
            $parameters['content_type'] = $tpl->variable( 'content_type' );

        $collection = eZNotificationCollection::create( $event->attribute( 'id' ),
                                                        self::NOTIFICATION_HANDLER_ID,
                                                        self::TRANSPORT );

        $collection->setAttribute( 'data_subject', $subject );
        $collection->setAttribute( 'data_text', $result );
        $collection->store();

        $assignedNodes = $contentObject->parentNodes( true );
        $nodeIDList = array();
        foreach( $assignedNodes as $node )
        {
            if ( $node )
            {
                $pathString = $node->attribute( 'path_string' );
                $pathString = ltrim( rtrim( $pathString, '/' ), '/' );
                $nodeIDListPart = explode( '/', $pathString );
                $nodeIDList = array_merge( $nodeIDList, $nodeIDListPart );
            }
        }
        $nodeIDList[] = $contentNode->attribute( 'node_id' );
        $nodeIDList = array_unique( $nodeIDList );

        $userList = eZSubtreeNotificationRule::fetchUserList( $nodeIDList, $contentObject );

        $locale = eZLocale::instance();
        $weekDayNames = $locale->attribute( 'weekday_name_list' );
        $weekDaysByName = array_flip( $weekDayNames );

        foreach( $userList as $subscriber )
        {
            $item = $collection->addItem( $subscriber['address'] );
            if ( $subscriber['use_digest'] == 0 )
            {
                $settings = eZGeneralDigestUserSettings::fetchForUser( $subscriber['address'] );
                if ( !is_null( $settings ) && $settings->attribute( 'receive_digest' ) == 1 )
                {
                    $time = $settings->attribute( 'time' );
                    $timeArray = explode( ':', $time );
                    $hour = $timeArray[0];

                    if ( $settings->attribute( 'digest_type' ) == eZGeneralDigestUserSettings::TYPE_DAILY )
                    {
                        eZNotificationSchedule::setDateForItem( $item, array( 'frequency' => 'day',
                                                                              'hour' => $hour ) );
                    }
                    else if ( $settings->attribute( 'digest_type' ) == eZGeneralDigestUserSettings::TYPE_WEEKLY )
                    {
                        $weekday = $weekDaysByName[ $settings->attribute( 'day' ) ];
                        eZNotificationSchedule::setDateForItem( $item, array( 'frequency' => 'week',
                                                                              'day' => $weekday,
                                                                              'hour' => $hour ) );
                    }
                    else if ( $settings->attribute( 'digest_type' ) == eZGeneralDigestUserSettings::TYPE_MONTHLY )
                    {
                        eZNotificationSchedule::setDateForItem( $item,
                                                                array( 'frequency' => 'month',
                                                                       'day' => $settings->attribute( 'day' ),
                                                                       'hour' => $hour ) );
                    }
                    $item->store();
                }
            }
        }

        return eZNotificationEventHandler::EVENT_HANDLED;
    }

    function sendMessage( $event, $parameters )
    {
        $collection = eZNotificationCollection::fetchForHandler( self::NOTIFICATION_HANDLER_ID,
                                                                 $event->attribute( 'id' ),
                                                                 self::TRANSPORT );

        if ( !$collection )
            return;

        $items = $collection->attribute( 'items_to_send' );

        if ( !$items )
        {
            eZDebugSetting::writeDebug( 'kernel-notification', "No items to send now" );
            return;
        }
        
        // Envoie les mails personnalisé
        $transport = eZNotificationTransport::instance( 'ezmail' );
        foreach ( $items as $item )
        {
            $email = $item->attribute( 'address' );
            $user = eZUser::fetchByEmail($email);
            if ($user) {
            	$text = $collection->attribute( 'data_text' );
            	$text = preg_replace('#@@HASH@@#', $user->PasswordHash, $text);
            	$text = preg_replace('#@@EMAIL@@#', $email, $text);
            	$transport->send( array($email), $collection->attribute( 'data_subject' ), $text, null, $parameters );
            }
            $item->remove();
        }
        
        if ( $collection->attribute( 'item_count' ) == 0 )
        {
            $collection->remove();
        }
    }

    function subscribedNodes( $user = false )
    {
        if ( $user === false )
        {
            $user = eZUser::currentUser();
        }
        $userID = $user->attribute( 'contentobject_id' );

        return eZSubtreeNotificationRule::fetchNodesForUserID( $userID );
    }

    static function rules( $user = false, $offset = false, $limit = false )
    {
        if ( $user === false )
        {
            $user = eZUser::currentUser();
        }
        $userID = $user->attribute( 'contentobject_id' );

        return eZSubtreeNotificationRule::fetchList( $userID, true, $offset, $limit );
    }

    static function rulesCount( $user = false )
    {
        if ( $user === false )
        {
            $user = eZUser::currentUser();
        }
        $userID = $user->attribute( 'contentobject_id' );

        return eZSubtreeNotificationRule::fetchListCount( $userID );
    }

    function fetchHttpInput( $http, $module )
    {
        if ( $http->hasPostVariable( 'NewRule_' . self::NOTIFICATION_HANDLER_ID  ) )
        {
            eZContentBrowse::browse( array( 'action_name' => 'AddSubtreeSubscribingNode',
                                            'from_page' => '/notification/settings/' ),
                                     $module );

        }
        else if ( $http->hasPostVariable( 'RemoveRule_' . self::NOTIFICATION_HANDLER_ID  ) and
                  $http->hasPostVariable( 'SelectedRuleIDArray_' . self::NOTIFICATION_HANDLER_ID ) )
        {
            $user = eZUser::currentUser();
            $userList = eZSubtreeNotificationRule::fetchList( $user->attribute( 'contentobject_id' ), false );
            foreach ( $userList as $userRow )
            {
                $listID[] = $userRow['id'];
            }
            $ruleIDList = $http->postVariable( 'SelectedRuleIDArray_' . self::NOTIFICATION_HANDLER_ID );
            foreach ( $ruleIDList as $ruleID )
            {
                if ( in_array( $ruleID, $listID ) )
                    eZPersistentObject::removeObject( eZSubtreeNotificationRule::definition(), array( 'id' => $ruleID ) );
            }
        }
        else if ( $http->hasPostVariable( "BrowseActionName" ) and
                  $http->postVariable( "BrowseActionName" ) == "AddSubtreeSubscribingNode" and
                  !$http->hasPostVariable( 'BrowseCancelButton' ) )
        {
            $selectedNodeIDArray = $http->postVariable( "SelectedNodeIDArray" );
            $user = eZUser::currentUser();

            $existingNodes = eZSubtreeNotificationRule::fetchNodesForUserID( $user->attribute( 'contentobject_id' ), false );

            foreach ( $selectedNodeIDArray as $nodeID )
            {
                if ( ! in_array( $nodeID, $existingNodes ) )
                {
                    $rule = eZSubtreeNotificationRule::create( $nodeID, $user->attribute( 'contentobject_id' ) );
                    $rule->store();
                }
            }
//            $Module->redirectTo( "//list/" );
        }

    }

    function cleanup()
    {
        eZSubtreeNotificationRule::cleanup();
    }
}
