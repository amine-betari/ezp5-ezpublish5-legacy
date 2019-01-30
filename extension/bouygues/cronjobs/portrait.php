<?php
include_once( "extension/bouygues/classes/whoswho.php" );
include_once( 'kernel/classes/datatypes/ezobjectrelationlist/ezobjectrelationlisttype.php' );
$db = eZDB::instance();
$db->begin();

$whoswhoInstance = new whoswho();

$cli->output("Starting Portrait updates");	

$admin_user = eZUser::fetch( 14 );
eZUser::setCurrentlyLoggedInUser($admin_user,14);

//Get all the portrait objects
$cli->output("Getting portraits Nodes");	
$objectNodes = eZContentObjectTreeNode::subTreeByNodeID(  array('Depth' => 5,
														   	'ClassFilterType' => 'include',
													       	'ClassFilterArray' => array( 'bouygues_portrait' )
													), 2 );
													
$cli->output("Getting whoswho Nodes");											
$whoswhoNodes = eZContentObjectTreeNode::subTreeByNodeID(  array('Depth' => 3,
														   	'ClassFilterType' => 'include',
													       	'ClassFilterArray' => array( 'bouygues_whoswho' )
													), 2 );

$i = 0; $arrWhoswho = array();
foreach($whoswhoNodes as $whoswhoNode){
	$whoswho = $whoswhoNode->attribute( 'object' );
	$section_id = $whoswho->attribute('section_id');
	
	$arrWhoswho[$section_id] = $whoswho->attribute('id');
}

$i = 0; unset($section_id);
foreach($objectNodes as $objectNode){
	
	$obj = $objectNode->attribute( 'object' );
	$dataMap = $obj->attribute('data_map');
	
	$cli->output("Bloc portrait #".$obj->attribute('id'));	
	$cli->output(">>>>> ".$objectNode->attribute('name'));	
	
	$frequence = $dataMap['frequence']->attribute('data_text');
	$fiches_collaborOld = $dataMap['fiches_collabor']->content();
	
	$cli->output(">>>>> Frequence : ".$frequence);	

	if($frequence == 1) 		$numDays = 7;
	elseif($frequence == 2) 	$numDays = 14;
	elseif($frequence == 3) 	$numDays = 30;
	
	if(isset($numDays)){
	
		$dateModified = $obj->attribute('modified');
		$dateNow = time();
		$nbjours = round(($dateNow - $dateModified)/(60*60*24));

		$cli->output(">>>>> Date de modification : ".$dateModified);	
		$cli->output(">>>>> Nombre de jour : ".$nbjours);
		
		if($nbjours >= $numDays || count($fiches_collaborOld['relation_list']) == 0){
			$cli->output(">>>>> Modification du portrait actuel");
			$section_id = $obj->attribute('section_id');
			
			$whoswhoId = $arrWhoswho[$section_id];
			
			if(isset($whoswhoId)){
				$cli->output(">>>>> Whos who correspondant : ".$whoswhoId);
				$collab_id = $whoswhoInstance->getRandomUser($whoswhoId);
				$cli->output(">>>>> Récupération d'un collaborateur : ".$collab_id);
				
				
				$version = $obj->createNewVersion( false, false, 'fre-FR' );
				$datamapNewVersion = $version->datamap();
				$fiches_collabor = $datamapNewVersion['fiches_collabor'];
				
				$content = $fiches_collabor->content();
				$relationList =& $content['relation_list'];
				
				$newRelationList = array();
				$cli->output(">>>>> Suppression des fiches existantes");
				for ( $i = 0; $i < count( $relationList ); ++$i )
                {
                    $relationItem = $relationList[$i];
                    eZObjectRelationListType::removeRelationObject( $fiches_collabor, $relationItem );
                }
				
				
				$cli->output(">>>>> Ajout de la nouvelle fiche");
				//Set the object
                $content['relation_list'] =& $newRelationList;
                $fiches_collabor->setContent( $content );
                $fiches_collabor->store();
					
				$fiches_collabor->fromString( $collab_id );
				$fiches_collabor->store();
				
				$obj->store();
				$result = eZOperationHandler::execute( 'content', 'publish', array( 'object_id' => $obj->attribute( 'id' ),
				                                                                               'version'   => $version->attribute( 'version' ) ) );
				
			}else{
				$cli->output(">>>>> Aucun whos who correspondant");
			}
		}
		
	}
	unset($numDays);	
	$i++;
}

$db->commit();