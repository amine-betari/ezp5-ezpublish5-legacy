<?php
include_once 'kernel/classes/ezcontentobject.php';
include_once( "extension/bouygues/classes/ebysoap.php" );
include_once( "extension/bouygues/classes/ebywhoswho.php" );

$cli->output("Starting Galby checking");	
eZLog::write ( 'Début cron galby checking...', 'bouygues_galby.log', 'var/log');

$admin_user = eZUser::fetch( 14 );
eZUser::setCurrentlyLoggedInUser($admin_user,14);

$db = eZDB::instance();
$db->begin();

//Get all the users objects
$cli->output("Checking if collaborators are still in GALBY");	
$users = eZUser::fetchContentList();

$ebyWhoswho = new ebyWhoswho();
foreach($users as $user){
	
	$oUser = eZContentObject::fetch($user['id']);
	$data_map = $oUser->attribute('data_map');
	$no_galby_sync = $data_map['no_galby_sync'];
	$current_user = eZUser::fetch( $user['id']);
	$email = $current_user->attribute('email');
	$cli->output(" >> Utilisateur : " . $current_user->attribute('email'));
	
	if ($no_galby_sync->attribute('data_int') == 0) {
		
		$isEmailValid = MySOAP::isGalbyEmailValid($email);
		
		if ($isEmailValid == 'true') {
		  
		  $cli->output(">> " .$email." is in GALBY");
		  
		  $sqlCheck = "SELECT etat, date FROM eby_galby_error WHERE user_id = ".$user['id']." AND email = '".addslashes($email)."' AND etat = 0";
		  $recDb = $db->arrayQuery( $sqlCheck );
		  	
		  if (count($recDb) > 0) {
		    
		    $query = "UPDATE eby_galby_error SET etat = 1, date = NOW() WHERE user_id = ".$user['id']." AND email = '".addslashes($email)."' AND etat = 0";
		    $db->arrayQuery( $query );
		    
		  }
		}
		else {
		  
			$cli->output(">> " .$email." not in GALBY anymore");
			
			$sqlCheck = "SELECT etat, date FROM eby_galby_error WHERE user_id = ".$user['id']." AND email = '".addslashes($email)."' AND etat = 0";
			$recDb = $db->arrayQuery( $sqlCheck );
			
			if (count($recDb) == 0) {
				$sql = "INSERT INTO eby_galby_error (user_id, email, etat, date) VALUE ('".$user['id']."', '".addslashes($email)."', 0, NOW())";
				$db->query($sql);
			}
			else {
				// Check if the email is in the error list for more than 6months
				$cli->output(">> Date : ". $recDb[0]['date']);
				$val = explode(" ",$recDb[0]['date']);
				$date = explode("-",$val[0]);
				$time = explode(":",$val[1]);
				$dateTimestamp = mktime($time[0],$time[1],$time[2],$date[1],$date[2],$date[0]);
				$dateNow = time();
				
				$nbjours = round(($dateNow - $dateTimestamp)/(60*60*24));
				$cli->output(">> Nombre de jours : " . $nbjours);	
				
				if($nbjours > 180){
					//Delete user
					$cli->output(">> Utilisateur supprimé");	
					$ebyWhoswho->delUser($user['id']);
				}
			}
		}
	}
	unset($oUser);
	unset($userObject);
	unset($no_galby_sync);
	unset($data_map);
	unset($current_user);
	unset($email);
}
unset($ebyWhoswho);
$db->commit();
