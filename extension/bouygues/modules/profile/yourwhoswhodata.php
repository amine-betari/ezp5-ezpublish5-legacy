<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/whoswho.php" );

$http = eZHTTPTool::instance();

$Module = $Params["Module"];
$Result = array();
$localCurrent = eZLocale::instance()->localeFullCode();
$lang = (eZLocale::instance()->localeFullCode()=='fre-FR')?'':'/en';
$whoswhoObj = new whoswho();
$updateData = false;
if ( $http->hasPostVariable( 'action' ) ) 
{
	$action = $http->postVariable( 'action' );
	if($action == 'update'){
		//Disable the template :: ajax request
		$data['civilite'] = 					$http->postVariable( 'civilite' );
		
		$data['pro_adresse'] = 					$http->postVariable( 'pro_adresse' );
		$data['emplacement'] = 					$http->postVariable( 'emplacement' );
		$data['email'] = 						$http->postVariable( 'email' );
		$data['pro_tel'] = 						$http->postVariable( 'pro_tel' );
		$data['pro_mobile'] = 					$http->postVariable( 'pro_mobile' );
		$data['pro_fax'] = 						$http->postVariable( 'pro_fax' );
		$data['assistante_nom'] = 				$http->postVariable( 'assistante_nom' );
		$data['assistante_tel'] = 				$http->postVariable( 'assistante_tel' );
		$data['fonction'] = 					$http->postVariable( 'fonction' );
		$data['direction'] = 					$http->postVariable( 'direction' );
		$data['service'] = 						$http->postVariable( 'service' );
		$data['secteur'] = 						$http->postVariable( 'secteur' );
		$data['entreprise'] = 					$http->postVariable( 'entreprise' );
		$data['filiale'] = 						$http->postVariable( 'filiale' );
		$data['filiale_autre'] = 				$http->postVariable( 'filiale_autre' );
		$data['mission_actuelle'] = 			$http->postVariable( 'mission_actuelle' );
		$data['date_naissance'] = 				$http->postVariable( 'date_naissance' );
		$data['date_entree'] = 					$http->postVariable( 'date_entree' );
		$data['diplome'] = 						$http->postVariable( 'diplome' );
		$data['parcours_pro'] = 				$http->postVariable( 'parcours_pro' );
		$data['mission_actuelle'] = 			$http->postVariable( 'mission_actuelle' );
		$data['mission_precedente'] = 			$http->postVariable( 'mission_precedente' );
		$data['competences'] = 					$http->postVariable( 'competences' );
		$data['centres_interet'] = 				$http->postVariable( 'centres_interet' );
		
		if(isset($_FILES['picture']) && $_FILES['picture']['size']>0)
		{
			$data['picture'] = $_FILES['picture'];
		}
		
		$whoswhoObj->setData($data);
		$updateData = true;
	}
}

	include_once( "extension/convenientclasses/classes/locales/SGLocaleSwitcher.class.php" );
	$oLocaleSwitcher = new SGLocaleSwitcher();
	$oLocaleSwitcher->switchToLocale($localCurrent);

	$tpl = templateInit();
	$tpl->setVariable( 'langCurrent', $lang);

	if($updateData)
		$tpl->setVariable( 'updateData', 'ok');

	//Get the user information
	$usrObj = eZUser::currentUser();
	if($usrObj->isLoggedIn()){
		$tpl->setVariable( 'currentUser', $usrObj );
		$oContentUser = eZContentObject::fetch($usrObj->id());
		$tpl->setVariable( 'obj_co', $oContentUser );
	}

	$nodes = eZContentObjectTreeNode::subTreeByNodeID(  array(	'Depth' => 2,
																   	'ClassFilterType' => 'include',
															       	'ClassFilterArray' => array( 'bouygues_whoswho' ),
																	'Limitation' => array(),
																	'SortBy' => array(array('name'))
																), 2 );
	$tpl->setVariable( 'whoswholist', $nodes );
	$wwData = $whoswhoObj->getData();
	if($wwData['date_naissance']!=null)
	{
		$arrTmp = explode('-',$wwData['date_naissance']);
		$wwData['date_naissance'] =  $arrTmp[2].'/'.$arrTmp[1].'/'.$arrTmp[0];
	} 	
	
	if($wwData['date_entree']!=null)
	{
		$arrTmp = explode('-',$wwData['date_entree']);
		$wwData['date_entree'] =  $arrTmp[2].'/'.$arrTmp[1].'/'.$arrTmp[0];
	}
	
	
	$tpl->setVariable( 'whoswhodata', $wwData );
	
	$Result['content'] = $tpl->fetch( "design:profile/yourwhoswhodata.tpl" );
	$Result['path'] = array(
	                        array(  'url'   => false,
	                                'text'  => ezpI18n::tr( 'design/bouygues/tools', 'menu_left_whoswhodata' ) ));
	
	unset($oLocaleSwitcher);
