<?php 
/*
$db = eZDB::instance();
$source_file = 'extension/data_import/dataSource/liste_filiales 12_10_09.csv';
$delimiter =';';
$enclosure = '"';

$user = eZUser::fetch( 14 ); //Administrator user_id = 14
eZUser::setCurrentlyLoggedInUser( $user, $user->attribute( 'contentobject_id' ) );
		
$flag=true;
$row = 0;
$rowUpd = 0;
$rowInsert = 0;
$rowDoublon = 0;
$rowDelete = 0;
$handle = fopen($source_file, "r");
while (($data = fgetcsv($handle, 100000, $delimiter, $enclosure)) !== FALSE) {
	
	$data[3]=utf8_decode($data[3]);
	switch($data[4])
	{
		case 'A':
			//ajouter
			$sql = "INSERT INTO eby_settings (type,cle,valeur) VALUE ('filiale','".$db->escapeString(strtoupper($data[3]))."','".base64_encode(serialize($data[3]))."')";
			if(!$db->query($sql))$flag=false;
			
			$rowInsert++;
			
		break;
		
		case 'M':
			//modifier
			if(trim($data[0])!='' && is_numeric($data[0]))
			{
				$sql = "UPDATE eby_settings SET cle = '".$db->escapeString(strtoupper($data[3]))."',
												valeur = '".base64_encode(serialize($data[3]))."'
						WHERE id = ".$data[0];
				if(!$db->query($sql))$flag=false;
				
				 $rowUpd++;
			}	 
		break;
		
		case 'S':
			//supprimer
			if(trim($data[0])!='' && is_numeric($data[0]))
			{
				if(trim($data[5])!='' && is_numeric($data[5]))
				{ 
					$sql = "UPDATE eby_ww_user SET filiale = ".$data[5]." WHERE filiale = ".$data[0];
					if(!$db->query($sql))$flag=false;
					$rowDoublon++;
				}
				
				if($flag)
				{
					$sql = "DELETE FROM eby_settings WHERE id = ".$data[0];
					if(!$db->query($sql))$flag=false;
				}
				
				$rowDelete++;
			}
			
		break;
		
		default:
		//rien	
		
	}

		
	if(!$flag) break;
    $row++;
}

fclose($handle);
if($flag){
	$cli->output('terminé...row:'.$row.' rowUpd:'.$rowUpd.' rowInsert:'.$rowInsert.' rowDelete:'.$rowDelete.' rowDoublon:'.$rowDoublon);
}else{
	$cli->output('ERREUR...data:'.print_r($data,true).' sql:'.$sql);
}
*/
	
					
?>