<?php 
/*
$db = eZDB::instance();


$date_naissance = array('parent_type'=>'table','parent_nom'=>'eby_ww_user','titre'=> $db->escapeString( "Date de naissance" ) );
$sql = "REPLACE INTO eby_settings (id,type,cle,valeur) VALUE 				(NULL,'ww_field','date_naissance','".base64_encode(serialize(array('parent_type'=>'table','parent_nom'=>'eby_ww_user','titre'=>'Date de naissance')))."')";
$db->query($sql);

$source_file = 'extension/data_import/dataSource/users/users_date_naissance.csv';
$delimiter =';';
$enclosure = '"';

$row = 0;
$rowUpd = 0;
$handle = fopen($source_file, "r");
while (($data = fgetcsv($handle, 100000, $delimiter, $enclosure)) !== FALSE) {
    $num = count($data);
    
    $oUser = eZUser::fetchByEmail(trim($data[1]));
    if($oUser)
    {
    	$cli->output( 'user obj:'.$oUser->ContentObjectID. ' date de naissance :'. $data[21]);
    	$sql = "UPDATE eby_ww_user SET date_naissance = '".$data[21]."' WHERE user_id =".$oUser->ContentObjectID ;
    	if($db->query($sql))
    		$rowUpd++;
    }else{
    	$cli->output('Pas trouvé : '.$data[1]);
    }
    
    $row++;
}

fclose($handle);

$cli->output('terminé...row:'.$row.' rowUpd:'.$rowUpd);	
		*/			
?>