<?php
/*
include_once( "extension/bouygues/classes/ebywhoswho.php" );

$admin_user = eZUser::fetch( 14 );
eZUser::setCurrentlyLoggedInUser($admin_user,14);


$ebyWhoswho = new ebyWhoswho();

$sql = "SELECT user_id   
		FROM  eby_ww_user_link 
		WHERE etat=1";
$db = eZDB::instance();
$recDb = $db->arrayQuery( $sql );
	
$cli->output("Starting section updates");
$cli->output("Nombre de user : ".count($recDb));			
foreach ( $recDb as $row )
{
	$cli->output("USER ID : ".$row['user_id']);
	$ebyWhoswho->setUserSection($row['user_id']);
}
*/



