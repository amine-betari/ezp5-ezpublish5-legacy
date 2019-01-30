<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebysoap.php" );
include_once( "extension/bouygues/classes/annuaire.php" );

$annuaire = new annuaire();

$Module = $Params["Module"];
$Result = array();
$tpl = templateInit();
$http = eZHTTPTool::instance();
$view = 'annuaire';
if(isset($Params['action'])) $action = $Params['action'];

//Get the user information
$usrObj = eZUser::currentUser();
if($usrObj->isLoggedIn()){
	$tpl->setVariable( 'currentUser', $usrObj );
}

if($action == 'print'){
	
	$tpl->setVariable( 'id', $http->getVariable( 'id' ) );
	$result['isMax'] = 'true';
	$result['count'] = 1;
	
	$user = annuaire::getCollaborator($http->getVariable( 'id' ));
	$result['result'][$user['entreprise_search']]['users'][] = $user;
	
	$tpl->setVariable( 'results', $result );
	
	$view = 'annuaire-print';
	
}elseif ( $http->getVariable( 'search' ) ){
	
	$firstname = $http->getVariable( 'userPrenom' );
	$lastname = $http->getVariable( 'userNom' );
	$initial = $http->getVariable( 'userInitiales' );
	$entreprise = $http->getVariable( 'userEntreprise' );
	$enlarge = $http->getVariable( 'enlarge' );
	$nbresult = $http->getVariable( 'nbresult' );
	
	if($nbresult == 20)
		$nbresultNext = 100;
	elseif($nbresult == 100)
		$nbresultNext = 500;

	$tpl->setVariable( 'firstname', $firstname );
	$tpl->setVariable( 'lastname', $lastname );
	$tpl->setVariable( 'initial', $initial );
	$tpl->setVariable( 'entreprise', $entreprise );
	$tpl->setVariable( 'enlarge', $enlarge );
	$tpl->setVariable( 'nbresult', $nbresult );
	$tpl->setVariable( 'nbresultNext', $nbresultNext );
	
	if(strlen($firstname) > 0 || strlen($lastname) > 0)
		$resultTmp = MySOAP::searchCollaborator($lastname, $firstname, $entreprise, $initial, null, $enlarge, $nbresult);
	
	$sortArray = $resultTmp['sort'];
	unset($resultTmp['sort']);

	$result = array();
	$result['isMax'] = $resultTmp['isMax'];
	$result['count'] = $resultTmp['count'];
	foreach($resultTmp['result'] as $company => $value){
		$result['result'][$company]['users'] = $value['users'];
		array_multisort($sortArray, SORT_ASC, $result['result'][$company]['users']);
	}
	
	$ini = eZINI::instance('site.ini');
	$instance = $ini->variable( 'Instance','Serveur');
	
	if(!in_array($instance, array('dev', 'integ'))){
		if(isset($result['count']) && $result['count'] > 0){

			if($nbresult > 20 && $result['count'] <= 20)
				$result['isMax'] = 'true';
			elseif($nbresult > 100 && $result['count'] <= 100)
				$result['isMax'] = 'true';
			$tpl->setVariable( 'results', $result );
		}
	}else{
		if(isset($result['count']) && $result['count'] > 0){
			$arrTemp = array(); $i = 0; $max = $result['count']; $j=0;
			while($i < $max){
				if($i == $nbresult) break;
				
				$arrTemp['isMax'] = $result['isMax'];
				$arrTemp['count'] = $result['count'];
				$arrTemp['result'][$entreprise]['users'][] = $result['result'][$entreprise]['users'][0];
				if($j == 0) $j++;
				else $j=0;
				$i++;
			}
			$tpl->setVariable( 'results', $arrTemp );
		}

		
		
	}
	
	if($http->hasGetVariable( 'ajax' )){
		$view = 'annuaire-ajax';
		$tpl->setVariable( 'userFavorites', $annuaire->getFavorite() );
	}
	
}elseif ( $http->hasPostVariable( 'base64' ) ){
    /* Set cache time out to 10 minutes, this should be good enough to work around an IE bug */
    // Output image data.
    //Disable the template :: ajax request
	eZDB::checkTransactionCounter();
	eZExecution::cleanExit();
}elseif($http->hasPostVariable( 'addfavorite' )){

	$annuaire->addFavorite($http->postVariable( 'user_id' ), $http->postVariable( 'annuaire_user_id' ));
	$tpl->setVariable( 'userFavorites', $annuaire->getFavorite($http->postVariable( 'user_id' )) );
	$view = 'favorite-list-ajax';
}elseif($http->hasPostVariable( 'delfavorite' )){

	$annuaire->delFavorite($http->postVariable( 'user_id' ), $http->postVariable( 'annuaire_user_id' ));
	$tpl->setVariable( 'userFavorites', $annuaire->getFavorite($http->postVariable( 'user_id' )) );
	$view = 'favorite-list-ajax';
		
}elseif($http->hasPostVariable( 'setOrderFavorite' )){

	$annuaire->setOrder($http->postVariable( 'user_id' ), $http->postVariable( 'annuaire_user_id' ), $http->postVariable( 'type' ));
	$tpl->setVariable( 'userFavorites', $annuaire->getFavorite($http->postVariable( 'user_id' )) );
	$view = 'favorite-list-ajax';

}elseif($http->hasPostVariable( 'listFavoriteActions' )){

	$tpl->setVariable( 'userFavorites', $annuaire->getFavorite($http->postVariable( 'user_id' )) );
	$view = 'favorite-list-actions-ajax';
		
}


$tpl->setVariable('annuaireMenu', MySOAP::getAnnuaireXml());

$Result['content'] = $tpl->fetch( "design:tools/".$view.".tpl" );
	$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => ezpI18n::tr( 'design/bouygues/annuaire', 'annuaire_title' ) ) );