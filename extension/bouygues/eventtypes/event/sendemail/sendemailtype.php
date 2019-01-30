<?php
include_once( "extension/bouygues/classes/ebyuseraccess.php" );
include_once( "kernel/common/template.php" );
class SendEmailType extends eZWorkflowEventType
{
    const WORKFLOW_TYPE_STRING = 'sendemail';

    /*!
     Constructor
    */
    function SendEmailType()
    {
        $this->eZWorkflowEventType( self::WORKFLOW_TYPE_STRING, ezpI18n::tr( 'kernel/workflow/event', "Send a simple email after publish" ) );
        $this->setTriggerTypes( array( 'content' => array( 'publish' => array ( 'after' ) ) ) );
    }

    function execute( $process, $event )
    {
        // get object being published
        $parameters = $process->attribute( 'parameter_list' );
        $objectId = $parameters['object_id'];

        eZDebug::writeDebug( 'Published and try to send email for object ' . $objectId, __METHOD__ );
        $object = eZContentObject::fetch( $objectId );
        $author_array = $object->attribute('author_array');
        $parentNode = eZContentObjectTreeNode::fetch($object->attribute('main_parent_node_id'));
		
		if($parentNode){
			$parentNodeObject = $parentNode->attribute('object');

        	$class = $object->attribute('class_identifier');
        	if($class == 'comment'){
        		$creator = $author_array[0];
        		$email = $creator->attribute('email');
        		//Get the user who posted the content
				$oUsr = eZUser::fetchByEmail($email);
				$oContentUser = eZContentObject::fetch($oUsr->ContentObjectID);
				$dataMapEmail = $oContentUser->attribute('data_map');
				
        		$tpl = templateInit();
				
				include_once( "extension/convenientclasses/classes/locales/SGLocaleSwitcher.class.php" );
				$oLocaleSwitcher = new SGLocaleSwitcher();
				$oLocaleSwitcher->setUserLang($email);
			
				$tpl->setVariable( 'article', $parentNodeObject->attribute('name') );
				$title = ezpI18n::tr( 'design/bouygues/comment', 'publication_confirm1' );
				$subtitle = ezpI18n::tr( 'design/bouygues/comment', 'publication_confirm2' );
				$tpl->setVariable( 'title', $title );
				$tpl->setVariable( 'subtitle', $subtitle );
				$tpl->setVariable( 'url_alias',$parentNode->attribute('url_alias'));
				$tpl->setVariable( 'first_name', $dataMapEmail['first_name']->content() );
				$tpl->setVariable( 'last_name', $dataMapEmail['last_name']->content() );
				
				$templateResult = $tpl->fetch( 'design:emails/commentapproved.tpl' );
			
				if($templateResult){
			
					$mail = new eZMail();
				
					$ini = eZINI::instance();
					if ( $tpl->hasVariable( 'content_type' ) )
						$mail->setContentType( $tpl->variable( 'content_type' ) );
				
					$emailSender = $ini->variable( 'MailSettings', 'EmailSender' );
					if ( !$emailSender )
						$emailSender = $ini->variable( 'MailSettings', 'AdminEmail' );
				
					$mail->setSender( ezpI18n::tr( 'design/bouygues/comment', 'contact_email' ) );
					$mail->addReceiver( $email );
				
					$mail->setSubject( ezpI18n::tr( 'design/bouygues/comment', 'comment_published' ) );
					$mail->setBody( $templateResult );
				
					$mailResult = eZMailTransport::send( $mail );
				}
        	
				unset($oLocaleSwitcher);
       		}
	   }
       return eZWorkflowType::STATUS_ACCEPTED;
    }
}

eZWorkflowEventType::registerEventType( SendEmailType::WORKFLOW_TYPE_STRING, "SendEmailType" );

?>
