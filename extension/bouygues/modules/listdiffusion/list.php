<?php

include_once( "kernel/common/template.php" );

$Module = $Params["Module"];
$Result = array();
$tpl = templateInit();
$http = eZHTTPTool::instance();

$Offset = $Params['Offset'];
if ( $Offset )
    $Offset = (int) $Offset;
    
if ( !is_numeric( $Offset ) )
    $Offset = 0;
    
$viewParameters = array( 'offset' => $Offset);
$template = "list.tpl";
$limit = 20;
$usersExport = array();
$wwExport = array();
$nlExport = array();
$raExport = array();
$exportFlag = false;


$oUsr = new ebyUserAccess();
$oListDiff = new ebyListDiffusion();
$arrSection = $oUsr->getListSection();
$oRA = new ebyRestrictedArea();

//$tpl->setVariable( 'arr_section', $arrSection );

//EXPORT
if ( $Module->isCurrentAction( 'ExportWwButton' ) ||  $Module->isCurrentAction( 'ExportAllButton' ) )
{
			
	if ( $http->hasPostVariable( 'ww' ))
	{
		$wwExport = $http->postVariable( 'ww' );
		$exportFlag = true;
	}
}

if ( $Module->isCurrentAction( 'ExportNlButton' ) ||  $Module->isCurrentAction( 'ExportAllButton' ) )
{
			
	if ( $http->hasPostVariable( 'nl' ))
	{
		$nlExport = $http->postVariable( 'nl' );
		$exportFlag = true;
	}
}

if ( $Module->isCurrentAction( 'ExportRaButton' ) ||  $Module->isCurrentAction( 'ExportAllButton' ) )
{
			
	if ( $http->hasPostVariable( 'ra' ))
	{
		$raExport = $http->postVariable( 'ra' );
		$exportFlag = true;
	}
}

if($exportFlag)
{
  
	if(count($wwExport)>0)
	{
		$usersWw = $oListDiff->getWwUsers($etat=1,$wwExport);
		$usersExport = array_merge($usersExport,$usersWw);
	}

	if(count($nlExport)>0)
	{
		$usersNl= $oListDiff->getNlUsers($nlExport);
		$usersExport = array_merge($usersExport,$usersNl);
	}
	
	if(count($raExport)>0)
	{
	  $raExportById = array();
	  foreach ($raExport as $checkbox) {
	      $raExportById[] = array('id' => $checkbox);
	  }
		$usersRa= $oListDiff->getRaUsers($raExportById);
		$usersExport = array_merge($usersExport,$usersRa);
	}
	
	include_once( "extension/bouygues/modules/listdiffusion/exportusrlist.inc.php" );
	eZDB::checkTransactionCounter();
	eZExecution::cleanExit();
	
}


//IMPORT
if ( $Module->isCurrentAction( 'ImportWwButton' ))
{
		
	
	if ( eZHTTPFile::canFetch( 'ImportWwFile' ) && $http->hasPostVariable( 'wwImport' ))
	{
	    $binaryFile = eZHTTPFile::fetch( 'ImportWwFile' );
	
	    $parser = new ebyCSVParser( $binaryFile->attribute( 'filename' ), false, ';', 1 , true);
	    if($data = $parser->data())
	    {
//eZDebug::writeNotice( '$data :' . print_r($data,1), 'eby:listdiffusion/list.php');
			$WwID = $http->postVariable( 'wwImport' );
		    if($userImport = $oListDiff->checkDiffusionUsers($data, array('type' => 'ww', 'id'=> $WwID )))
			{
				
				$coWw = eZContentObject::fetch($WwID);
				$dataMapWw = $coWw->dataMap();
//eZDebug::writeNotice( '$dataMapWw :' . $dataMapWw['titre']->content(), 'eby:listdiffusion/list.php');
				
				$tpl->setVariable( 'diffusion', array('id' => $WwID ,'type'=> 'ww','name'=>  $dataMapWw['titre']->content()));
				
				$tpl->setVariable( 'user_import', $userImport );
				$template = "user_import.tpl";
				
			}else{
				eZDebug::writeNotice( 'Erreur import user :' . print_r($userImport,1), 'eby:listdiffusion/list.php');
			}
	    }else{
	    	eZDebug::writeNotice( 'Erreur import fichier:' . $binaryFile->attribute( 'filename' ), 'eby:listdiffusion/list.php');
	    }
//eZDebug::writeNotice( 'data:' . print_r($data,1), 'eby:listdiffusion/list.php');
	}
	
}


if ( $Module->isCurrentAction( 'ImportNlButton' ))
{
	
	if ( eZHTTPFile::canFetch( 'ImportNlFile' ) && $http->hasPostVariable( 'nlImport' ))
	{
	    $binaryFile = eZHTTPFile::fetch( 'ImportNlFile' );
	
	    $parser = new ebyCSVParser( $binaryFile->attribute( 'filename' ), false, ';', 1 , true);
	    if($data = $parser->data())
	    {
//eZDebug::writeNotice( '$data:' . print_r($data,1), 'eby:listdiffusion/list.php');

			$NlID = $http->postVariable( 'nlImport' );
		    if($userImport = $oListDiff->checkDiffusionUsers($data, array('type' => 'nl', 'id'=> $NlID )))
			{
				
				//$coNl = eZContentObject::fetch($NlID);
				$coNl = eZSubscriptionList::fetch( $NlID );
//eZDebug::writeNotice( '$coNl:' . print_r($coNl,1), 'eby:listdiffusion/list.php');
				//$dataMapNl = $coNl->dataMap();
				
				$tpl->setVariable( 'diffusion', array('id' => $NlID ,'type'=> 'nl','name'=>  $coNl->attribute('name')));
				
				$tpl->setVariable( 'user_import', $userImport );
				$template = "user_import.tpl";
				
			}else{
				eZDebug::writeNotice( 'Erreur import user :' . print_r($userImport,1), 'eby:listdiffusion/list.php');
			}
	    }else{
	    	eZDebug::writeNotice( 'Erreur import fichier:' . $binaryFile->attribute( 'filename' ), 'eby:listdiffusion/list.php');
	    }
//eZDebug::writeNotice( 'data:' . print_r($data,1), 'eby:listdiffusion/list.php');
	}
	
}



if ( $Module->isCurrentAction( 'ImportRaButton' ))
{
	
	if ( eZHTTPFile::canFetch( 'ImportRaFile' ) && $http->hasPostVariable( 'raImport' ))
	{
	    $binaryFile = eZHTTPFile::fetch( 'ImportRaFile' );
	
	    $parser = new ebyCSVParser( $binaryFile->attribute( 'filename' ), false, ';', 1 , true);
	    if($data = $parser->data())
	    {

			$RaID = $http->postVariable( 'raImport' );
		    if($userImport = $oListDiff->checkDiffusionUsers($data, array('type' => 'ra', 'id'=> $RaID )))
			{
				
				$dataRA = $oRA->getGroupData($RaID);
//eZDebug::writeNotice( '$$dataRA:' . print_r($dataRA,1), 'eby:listdiffusion/list.php');
				
				$tpl->setVariable( 'diffusion', array('id' => $RaID ,'type'=> 'ra','name'=>  $dataRA['nom']));
				
				$tpl->setVariable( 'user_import', $userImport );
				$template = "user_import.tpl";
				
			}else{
				eZDebug::writeNotice( 'Erreur import user :' . print_r($userImport,1), 'eby:listdiffusion/list.php');
			}
	    }else{
	    	eZDebug::writeNotice( 'Erreur import fichier:' . $binaryFile->attribute( 'filename' ), 'eby:listdiffusion/list.php');
	    }
//eZDebug::writeNotice( 'data:' . print_r($data,1), 'eby:listdiffusion/list.php');
	}
	
}



if ( $Module->isCurrentAction( 'ImportValidationButton' ))
{
	if($http->hasPostVariable( 'diffusionId' ) && $http->hasPostVariable( 'diffusionType' ) && $http->hasPostVariable( 'userImport' ))
	{
		$diffusionType = $http->postVariable( 'diffusionType' );
		$diffusionId = $http->postVariable( 'diffusionId' );
		$diffusionName = $http->postVariable( 'diffusionName' );
		$userImport = $http->postVariable( 'userImport' );
		$arrNewUsers = array();
		if($http->hasPostVariable( 'userImportEmail' ) && $http->hasPostVariable( 'userImportFirstName' ) && $http->hasPostVariable( 'userImportLastName' ) )
		{
			$arrNewUsers['email'] = $http->postVariable( 'userImportEmail' );
			$arrNewUsers['first_name'] = $http->postVariable( 'userImportFirstName' );
			$arrNewUsers['last_name'] = $http->postVariable( 'userImportLastName' );
		}
		
		$userImport = $oListDiff->setDiffusionUsers($diffusionType,$diffusionId,$userImport,$arrNewUsers);
		if($userImport)
			$resultat = true;
		else
			$resultat = false;

		$userImportData = $oListDiff->getDiffusionUsers($diffusionType,$diffusionId,$userImport);
		$tpl->setVariable( 'user_import', $userImportData );
		
		$tpl->setVariable( 'diffusion', array('id' => $diffusionId ,'type'=> $diffusionType,'name'=>  $diffusionName));
		$tpl->setVariable( 'resultat', $resultat );
		$template = "user_import.tpl";
		
		
	}
}


if ( $Module->isCurrentAction( 'AnnulerButton' ))
{
	$Module->redirectTo( '/listdiffusion/list');
}




if ( isset($Params['type']) )
{
	$tpl->setVariable( 'type', $Params['type'] );
}
	
	
	
$subscriptionListArray = eZSubscriptionList::fetchList( $Offset, $limit );

$groupList = $oRA->getGroupList();

$ww_hash = array(	'parent_node_id' 	=> 2,
					'depth' 			=> 2,
					'class_filter_type'	=> 'include',
					'class_filter_array'=> array( 'bouygues_whoswho' )
				);

if(is_array($arrSection))
{
	$ww_hash['limitation'] = array( array( 'Section' => $arrSection ));
	
}

//eZDebug::writeNotice( '$totalSubscribers' . print_r($totalSubscribers,1), 'eby:listdiffusion/list.php');




$tpl->setVariable( 'view_parameters', $viewParameters );
$tpl->setVariable( 'ww_hash', $ww_hash );
$tpl->setVariable( 'item_limit', $limit );

$tpl->setVariable( 'newsletter_list', $subscriptionListArray );
$tpl->setVariable( 'ra_list', $groupList );


$Result['content'] = $tpl->fetch( "design:listdiffusion/" . $template );
$Result['left_menu'] = 'design:listdiffusion/menu.tpl';
$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => 'Liste de diffusion' ) );

