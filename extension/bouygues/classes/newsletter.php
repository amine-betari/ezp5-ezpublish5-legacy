<?php
/**
 * API de gestion drag and drop
 *
 * @author J. Leger
 * @version $Id: ebyperso.php
 * @copyright (C) J. Leger 2009
 *
 */

class newsletter
{
   
    var $userId;    
    protected $db;
	
    
	public function __construct()
	{
		
		$this->userId = eZUser::currentUserID();
		$this->db = eZDB::instance();

	}
	
	public function getSubscription($userId = null, $newsletter = null){
		if(is_null($userId))
			$userId = $this->userId;

		if(is_null($newsletter)){
			return eZSubscription::fetchListByUserID($userId,eZSubscription::VersionStatusPublished,eZSubscription::StatusApproved);
		
		}else{

			
			$subscription = eZSubscription::fetchByUserSubscriptionListID($userId,$newsletter);
			if($subscription->Status == eZSubscription::StatusApproved)
				return $subscription;
	    	else return null;
		}
	}
	
	public function addSubscription($newsletter, $userId = null){
		if(is_null($userId))
			$userId = $this->userId;
		$user = new eZUser( $userId );
		$subscription = eZSubscription::fetchByUserSubscriptionListID($userId, $newsletter);
		
		if(count($subscription) == 1){
			//Update status
			
			$subscription->setAttribute( 'output_format', eZSubscription::OutputFormatText.','.eZSubscription::OutputFormatHTML );
			$subscription->setAttribute( 'status', eZSubscription::StatusApproved );
        	$subscription->publish();
        	
		}else{
			$subscriptionList = eZSubscriptionList::fetch( $newsletter);
			$subscriptionNew = eZSubscription::fetchByUserSubscriptionListID( $user->attribute( 'contentobject_id' ), $subscriptionList->attribute( 'id' ) );
			$subscriptionNew = $subscriptionList->registerUser( $user->attribute( 'contentobject_id' ) );
			
			$subscription = eZSubscription::fetchByUserSubscriptionListID($userId, $newsletter);
			$subscription->setAttribute( 'output_format', eZSubscription::OutputFormatText.','.eZSubscription::OutputFormatHTML );
			$subscription->setAttribute( 'status', eZSubscription::StatusApproved );
        	$subscription->publish();
		}
	}
	
	public function delSubscription($newsletter, $userId = null){
		if(is_null($userId))
			$userId = $this->userId;
		
		$user = eZUser::currentUser();
			
		$subscriptionList = eZSubscriptionList::fetch( $newsletter);
		$subscription = eZSubscription::fetchByUserSubscriptionListID( $user->attribute( 'contentobject_id' ), $subscriptionList->attribute( 'id' ) );
		$subscription = $subscriptionList->unsubscribeUser( $user->attribute( 'contentobject_id' ) );
		
	}
	
	public function setSubscription($whoswho, $status, $userId = null){
		if(is_null($userId))
			$userId = $this->userId;
		
		$sql = "UPDATE INTO eby_ww_user_link SET etat = ".$status." WHERE user_id = ".$userId." AND ww_id = ".$whoswho." ";
	    
		if($this->db->query( $sql )) return true;
	}

	public function getData($userId = null){
		if(is_null($userId))
			$userId = $this->userId;
		
	    $sql = "SELECT * FROM eby_ww_user WHERE user_id = '".$userId."'";
	    
		$resArray = $this->db->arrayQuery( $sql );
		
		if(count($resArray) > 0)
			return $resArray[0];
		else
			return array();
	}
}

?>