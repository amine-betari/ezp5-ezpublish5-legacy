<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebywhoswho.php" );
include_once( "extension/bouygues/classes/ebyuseraccess.php" );

$Module = $Params["Module"];
$Result = array();
$tpl = templateInit();
$http = eZHTTPTool::instance();



$entrepriseListe = ebyWhoswho::getEbySettings(null,'entreprise');
$filialeListe = ebyWhoswho::getEbySettings(null,'filiale');
$secteurListe = ebyWhoswho::getEbySettings(null,'secteur');

$tpl->setVariable( 'entreprise_liste', $entrepriseListe );
$tpl->setVariable( 'filiale_liste', $filialeListe );
$tpl->setVariable( 'secteur_liste', $secteurListe );


if ( isset($Params['userid']) && $Params['userid']!='' )
{
	
	$userData = ebyWhoswho::getUserData($Params['userid']);	
	

}


if ( $Module->isCurrentAction( 'ActionButtonDeleteImage' ) )
{
	if ( $http->hasPostVariable( 'UserId' ) ){
		if(!ebyWhoswho::deleteUserImage($http->postVariable( 'UserId' ))){
			eZDebug::writeError( "Erreur setUsersWwData user_id :".$http->postVariable( 'UserId' ), 'bouygues:whoswho/userform.php');	
		}else{
			if($http->hasVariable( "SearchUser"))
				$Module->redirectTo( '/whoswho/userform/'. $http->postVariable( 'UserId' ).'/?SearchUser='.$http->variable( "SearchUser" ));
			else
				$Module->redirectTo( '/whoswho/userform/'. $http->postVariable( 'UserId' ));
		}
	}
	
}

if ( $Module->isCurrentAction( 'ModifierButton' ) )
{
	if ( $http->hasPostVariable( 'UserId' ) ){
		$arrPostData = array(
								"user_id"				=> $http->postVariable( 'UserId' ),
								"filiale_autre"			=> $http->postVariable( 'filiale_autre' ),
								"filiale"				=> $http->postVariable( 'FilialeID' ),
								"fonction"				=> $http->postVariable( 'fonction' ),
								"service"				=> $http->postVariable( 'service' ),
								"direction"				=> $http->postVariable( 'direction' ),
								"pro_adresse"			=> $http->postVariable( 'pro_adresse' ),
								"emplacement"			=> $http->postVariable( 'emplacement' ),
								"pro_tel"				=> $http->postVariable( 'pro_tel' ),
								"pro_mobile"			=> $http->postVariable( 'pro_mobile' ),
								"pro_fax"				=> $http->postVariable( 'pro_fax' ),
								"assistante_nom"		=> $http->postVariable( 'assistante_nom' ),
								"assistante_tel"		=> $http->postVariable( 'assistante_tel' ),
								"date_entree_date_year"	=> $http->postVariable( 'date_entree_date_year' ),
								"date_entree_date_month"=> $http->postVariable( 'date_entree_date_month' ),
								"date_entree_date_day"	=> $http->postVariable( 'date_entree_date_day' ),
								
								"diplome"				=> $http->postVariable( 'diplome' ),
								"parcours_pro"			=> $http->postVariable( 'parcours_pro' ),
								"mission_actuelle"		=> $http->postVariable( 'mission_actuelle' ),
								"mission_precedente"	=> $http->postVariable( 'mission_precedente' ),
								"competences"			=> $http->postVariable( 'competences' ),
								"centres_interet"		=> $http->postVariable( 'centres_interet' ),
								
								"last_name"					=> $http->postVariable( 'last_name' ),
								"first_name"				=> $http->postVariable( 'first_name' ),
								
								"user_password"				=> $http->postVariable( 'user_password' ),
								"user_password_confirm"		=> $http->postVariable( 'user_password_confirm' ),
								"user_email"				=> $http->postVariable( 'user_email' ),
								"civilite"					=> $http->postVariable( 'civilite' ),
								"langue"					=> $http->postVariable( 'langue' ),
								"date_naissance_date_day"	=> $http->postVariable( 'date_naissance_date_day' ),
								"date_naissance_date_month"	=> $http->postVariable( 'date_naissance_date_month' ),
								"date_naissance_date_year"	=> $http->postVariable( 'date_naissance_date_year' ),
							);
		
		
		
		if ( $http->hasPostVariable( 'is_enabled' ) ){					
			$arrPostData['is_enabled'] = 1;
		}else{
			$arrPostData['is_enabled'] = 0;
		}					

		
		if ( $http->hasPostVariable( 'no_galby_sync' ) ){					
			$arrPostData['no_galby_sync'] = 1;
		}else{
			$arrPostData['no_galby_sync'] = 0;
		}	
		
		if ( $http->hasPostVariable( 'EntrepriseID' ) ){	
			eZDebug::writeNotice( "EntrepriseID : ".$http->postVariable( 'EntrepriseID' ), 'bouygues:classes/ebywhoswho.php');				
			$arrPostData['entreprise_id'] = $http->postVariable( 'EntrepriseID' );
		}
		if ( $http->hasPostVariable( 'FilialeID' ) ){					
			$arrPostData['filiale_id'] = $http->postVariable( 'FilialeID' );
		}
		if ( $http->hasPostVariable( 'SecteurID' ) ){					
			$arrPostData['secteur_id'] = $http->postVariable( 'SecteurID' );
		}
		
		if(isset($_FILES['image']) && $_FILES['image']['size']>0){
			$arrPostData['image']=$_FILES['image'];
		}
		

		if(!ebyWhoswho::setUsersWwData($arrPostData)){
			eZDebug::writeError( "Erreur setUsersWwData user_id :".$http->postVariable( 'UserId' ), 'bouygues:whoswho/userform.php');	
				
		}
		$userData = ebyWhoswho::getUserData($http->postVariable( 'UserId' ));
	}		
	
}	


if ( $Module->isCurrentAction( 'CancelButton' ) )
{
	if($http->hasVariable( "SearchUser"))
		return $Module->redirectTo( '/whoswho/userlist/?SearchUser='.$http->variable( "SearchUser" ));
	else
		return $Module->redirectTo( '/whoswho/userlist/');
}

if(isset($userData)) $tpl->setVariable( 'user_data', $userData );

if($http->hasVariable( "SearchUser"))
	$tpl->setVariable( "SearchUser", $http->variable( "SearchUser" ) );

//affichage valeur du menu
include_once( "extension/bouygues/modules/whoswho/menu.inc.php" );

$Result['content'] = $tpl->fetch( "design:whoswho/userform.tpl" );
$Result['left_menu'] = 'design:whoswho/menu.tpl';
$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => 'Who s Who - Formulaire' ) );

