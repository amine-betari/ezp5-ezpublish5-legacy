<?php
include_once( "extension/bouygues/classes/ebysondage.php" );
class sondageFunctionCollection
{
	protected $db;
    /*!
     Constructor
    */
    function __construct()
    {
    	$this->db = eZDB::instance();
    }

    function fetchLast(){
	    return array('result' => ebySondage::fetchLast()); 
    }
    
    function fetchUserResponse($sondage_id, $user_id = null){
    	if($user_id == 10)	$user_id = null;
    	return array('result' => ebySondage::hasResponded($sondage_id, $user_id));
    }
}

?>
