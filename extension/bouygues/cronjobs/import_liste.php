<?php 
/*
$db = eZDB::instance();

$source_file = 'extension/data_import/dataSource/eby_bouygues_list2.csv';
$delimiter =';';
$enclosure = '"';

$user = eZUser::fetch( 14 ); //Administrator user_id = 14
eZUser::setCurrentlyLoggedInUser( $user, $user->attribute( 'contentobject_id' ) );
		

$row = 0;
$rowUpd = 0;
$handle = fopen($source_file, "r");
while (($data = fgetcsv($handle, 100000, $delimiter, $enclosure)) !== FALSE) {
    $num = count($data);
//maj content object user
	$oContentObject = eZContentObject::fetch($data[0]);
	if($oContentObject)
    {
			$version = $oContentObject->createNewVersion();
			$datamap = $version->datamap();
			
			if ( $data[1]!='')
			{
				$datamap['short_title']->fromString($data[1]);
				$datamap['short_title']->store();
			}	
			
			if ( $data[2]!='')
			{
				$data[2]=stripslashes($data[2]);
				$parser = new eZSimplifiedXMLInputParser( $data[2], false, 0 );
                $document = $parser->process( $data[2] );
                $dataString = eZXMLTextType::domString( $document );
				
				$datamap['accroche_liste']->fromString($dataString);
				$datamap['accroche_liste']->store();
				
				
			}
			
			
			$result = eZOperationHandler::execute( 'content', 'publish', array( 'object_id' => $oContentObject->attribute( 'id' ),
			                                                                    'version'   => $version->attribute( 'version' ) ) );	
			

			
			
			$cli->output( 'obj:'.$data[0]. ' short_title :'. $data[1]. ' accroche_liste :'. $data[2]);
    		$rowUpd++;
    }else{
    	$cli->output('Pas trouvé : '.$data[0]);
    }
    
    $row++;
}

fclose($handle);
$cli->output('terminé...row:'.$row.' rowUpd:'.$rowUpd);	
*/		
?>