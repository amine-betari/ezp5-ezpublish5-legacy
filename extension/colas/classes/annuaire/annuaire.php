<?php
/**
 * API de gestion drag and drop
 *
 * @author J. Leger
 * @version $Id: ebyperso.php
 * @copyright (C) J. Leger 2009
 *
 */

class BouyguesAnnuaire
{
   
    private $userId;
    protected $db;
	
    
	public function __construct()
	{
		
		$this->userId = eZUser::currentUserID();
		$this->db = eZDB::instance();

	}
	
	/**
	 * Add a collaborator to the favorite of a user
	 */
	public function addFavorite($userId, $annuaire_id){
		if(is_null($userId))
			$userId = $this->userId;
		
		$sqlOrder = "SELECT MAX(intorder) as intorder from eby_favorite_user WHERE user_id = ".$userId." GROUP BY user_id";
		$resArray = $this->db->arrayQuery( $sqlOrder );

		if(count($resArray) > 0)
			$order = $resArray[0]['intorder']+1;
		else
			$order = 0;

		if(!self::isFavorite($userId, $annuaire_id)){
			$sql = "INSERT INTO eby_favorite_user (user_id, annuaire_id, date, intorder) VALUES (".$userId.", ".$annuaire_id.", NOW(), ".$order.") ";

		}else
			return false;
			
		if($this->db->query( $sql )){
			
			
		}
	}
	
	/**
	 * Check if a user is already a favorite
	 */
	static function isFavorite($userId, $annuaire_id){

		$annuaireObj = new self();
		if(is_null($userId))
			$userId = $annuaireObj->userId;
		
		$sql = "SELECT * FROM eby_favorite_user WHERE user_id = ".$userId." AND annuaire_id = ".$annuaire_id; 
	    
		$resArray = $annuaireObj->db->arrayQuery( $sql );
		
		if(count($resArray) == 0)
			return false;
			
		return true;
		
	}
	
	/**
	 * Delete a favorite from the favorite list of a user
	 */
	public function delFavorite($userId, $annuaire_id){
		if(is_null($userId))
			$userId = $this->userId;
		
		$sql = "DELETE FROM eby_favorite_user WHERE user_id = ".$userId." AND annuaire_id = ".$annuaire_id." ";
	    
		if($this->db->query( $sql )){
			
		}
	}
	
	/**
	 * Change the order of the favorite within ebyperso
	 */
	public function setOrder($userId, $annuaire_id, $type = 'up'){

		$favorites = $favoritesTemp = self::getFavorite($userId);
		$current = array(); $current = current($favoritesTemp);
		foreach($favorites as $favorite){

			if($annuaire_id == $favorite['id'])
				break;
			$current = next($favoritesTemp);

		}

		if($type=='up'){
			$nearby = prev($favoritesTemp);
			//Update the two rows
			$sql1 = "UPDATE eby_favorite_user SET intorder = (intorder+1) WHERE user_id = ".$userId." AND annuaire_id = ".$nearby['id'];
			$sql2 = "UPDATE eby_favorite_user SET intorder = (intorder-1) WHERE user_id = ".$userId." AND annuaire_id = ".$current['id'];
		}elseif($type=='down'){
			$nearby = next($favoritesTemp);
			//Update the two rows
			$sql1 = "UPDATE eby_favorite_user SET intorder = (intorder-1) WHERE user_id = ".$userId." AND annuaire_id = ".$nearby['id'];
			$sql2 = "UPDATE eby_favorite_user SET intorder = (intorder+1) WHERE user_id = ".$userId." AND annuaire_id = ".$current['id'];

		}
		
		$this->db->query( $sql1 );
		$this->db->query( $sql2 );
		
	}
	
	/**
	 * Get all the favorites of a user
	 */
	static function getFavorite($userId = null){
		$annuaireObj = new self();
		
		if(is_null($userId))
			$userId = $annuaireObj->userId;
		
		$sql = "SELECT * FROM eby_favorite_user a, eby_annuaire b WHERE a.user_id = ".$userId." AND a.annuaire_id = b.id ORDER BY a.intorder ASC"; 
		$resArray = $annuaireObj->db->arrayQuery( $sql );

		if(count($resArray) == 0)
			return false;
			
		return $resArray;
		
	}
	
	static function getCollaborator($id){
		$annuaireObj = new self();
		$sql = "SELECT * FROM eby_annuaire WHERE id = ".$id.""; 
		$resArray = $annuaireObj->db->arrayQuery( $sql );
		if(count($resArray) == 0)
			return false;
			
		return $resArray[0];
	}
	
}
?>