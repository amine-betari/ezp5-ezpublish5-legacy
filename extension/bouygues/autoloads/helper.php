<?php

class HelperEby
{
    function HelperEby()
    {
        $this->Operators= array( 'orderByLastname', 'fetchUserByEmail', 'isEmailGalbyError', 'isRestrictedArea', 'getAnnuaireAvailability','getNodeByUrlAlias', 'isUserWidget', 'isUserFavorite', 'getUrlAliasBylang', 'caidParameter');
        $this->Debug = false;
    }

    function operatorList()
    {
        return $this->Operators;
    }

    function namedParameterPerOperator()
    {
        return true;
    }

    function namedParameterList()
    {
        return array(

        	'orderByLastname' => array(
	        	'arrObjects' => array(
	                'type' => 'array',
	                'required' => true
	             )
	         ),

			'fetchUserByEmail' => array(
	        	'email' => array(
	                'type' => 'string',
	                'required' => true
	             )
	         ),

			'isEmailGalbyError' => array()
             ,

			'isRestrictedArea' => array(
	        	'section_id' => array(
	                'type' => 'integer',
	                'required' => true
	             ),
				'url_alias' => array(
	                'type' => 'string',
	                'required' => true
	             ),
				'user_id' => array(
	                'type' => 'integer',
	                'required' => true
	             )	,
				'lang' => array(
		        	'type' => 'string',
					'required' => true
		         )
	         ),

	        'getNodeByUrlAlias' => array(
	        	'params' => array(
	                'type' => 'array',
	                'required' => true
	             ),
	         ),

			'getAnnuaireAvailability' => array(),

			'isUserWidget' => array(
				'user_id' => array(
	                'type' => 'integer',
	                'required' => true
	             ),
				'bloc_type' => array(
	                'type' => 'integer',
	                'required' => true
	             )
			),
			'isUserFavorite' => array(
				'user_id' => array(
	                'type' => 'integer',
	                'required' => true
	             ),
				'annuaire_id' => array(
	                'type' => 'integer',
	                'required' => true
	             )
			),
			'getUrlAliasBylang' => array(
				'node_id' => array(
		            'type' => 'integer',
		            'required' => true
		         ),
				'lang_code' => array(
					'type' => 'string',
					'required' => true
					)
			),
			'caidParameter' => array()




        );
    }

    function modify( $tpl, $operatorName, $operatorParameters, $rootNamespace, $currentNamespace, &$operatorValue, $namedParameters )
    {
        switch ( $operatorName )
        {
            case 'orderByLastname':
            {

                $operatorValue = $this->orderByLastname($namedParameters);
            }
            break;

			case 'fetchUserByEmail':
            {

                $operatorValue = $this->fetchUserByEmail($namedParameters);
            }
            break;

			case 'isEmailGalbyError':
            {

                $operatorValue = $this->isEmailGalbyError($namedParameters);
            }
            break;

			case 'isRestrictedArea':
            {

                $operatorValue = $this->isRestrictedArea($namedParameters);
            }
            break;
			case 'getAnnuaireAvailability':
			{
				$operatorValue = $this->getAnnuaireAvailability($namedParameters);
			}
			break;
			case 'getNodeByUrlAlias':
			{
				$operatorValue = $this->getNodeByUrlAlias($namedParameters);
			}
			break;
			case 'isUserWidget':
			{
				$operatorValue = $this->isUserWidget($namedParameters);
			}
			break;
			case 'isUserFavorite':
			{
				$operatorValue = $this->isUserFavorite($namedParameters);
			}
			break;
			case 'getUrlAliasBylang':
			{
				$operatorValue = $this->getUrlAliasBylang($namedParameters);
			}
			break;
			case 'caidParameter':
			{
				$operatorValue = $this->caidParameter($namedParameters);
			}
			break;



        }
    }

    function orderByLastname($namedParameters)
    {


    	$arrResults = array(); $i = 0; $limitTemp=0; $arrSortby = array();
		foreach($namedParameters['arrObjects'] as $node){

			$userObj = eZContentObject::fetch($node['contentobject_id']);
			$objDataMap = $userObj->attribute('data_map');

			$arrResults[$i] = $node;
			$arrSortby[$i] = trim($objDataMap['last_name']->attribute('content'));
			$i++;
		}

		array_multisort($arrSortby, SORT_ASC, $arrResults);
      	return $arrResults;
    }

	function fetchUserByEmail($namedParameters){

		return eZUser::fetchByEmail($namedParameters['email']);

	}

	function isEmailGalbyError(){
		if(MySOAP::isEmailGalbyError())
			return 'true';

		return 'false';
	}

	function isRestrictedArea($namedParameters){
		include_once( "extension/bouygues/classes/ebyrestrictedarea.php" );
		$ra = new ebyRestrictedArea();

		if($isRestricted = $ra->isRestricted($namedParameters['section_id'], $namedParameters['url_alias'], $namedParameters['lang']))
			if($ra->isRestrictedUser($namedParameters['user_id'], $isRestricted))
				Header("Location: ".$namedParameters['lang']."/acces-restreint");

		return false;


	}

	function getNodeIdByUrlAlias(){



	}

	function getAnnuaireAvailability(){
		return MySOAP::getAnnuaireXml();
	}

	function getNodeByUrlAlias($namedParameters){

		$url = $namedParameters['params']['url'];

		$arrConditions = array(
    			/*'parent_node_id' => $namedParameters['params']['AttributeFilter'],*/
		  );

		$nodes = eZContentObjectTreeNode::subTreeByNodeId($arrConditions,$namedParameters['params']['parent_node_id']);

		foreach ($nodes as $node){

			$node_url =  $node->attribute('url_alias');

			if($node_url == $url){

				return $node;
				break;
			}

		}

		return true;

	}

	function isUserWidget($namedParameters){
		$user_id = $namedParameters['user_id'];
		$bloc_type = $namedParameters['bloc_type'];
		include_once( "extension/bouygues/classes/ebyperso.php" );
		return ebyPerso::isUserWidget($user_id, $bloc_type);

	}

	function isUserFavorite($namedParameters){
		$user_id = $namedParameters['user_id'];
		$annuaire_id = $namedParameters['annuaire_id'];
		include_once( "extension/bouygues/classes/annuaire.php" );
		return annuaire::isFavorite($user_id, $annuaire_id);
	}

	function getUrlAliasBylang($namedParameters){
		$node = eZContentObjectTreeNode::fetch( $namedParameters['node_id'], $namedParameters['lang_code'] );
		$originalPrioritizedLanguages = eZContentLanguage::prioritizedLanguageCodes();
		eZContentLanguage::setPrioritizedLanguages( array( $namedParameters['lang_code'] ) );
		$urlAlias = '';
		if(is_object($node))
			$urlAlias = '/'.$node->urlAlias();
		eZContentLanguage::setPrioritizedLanguages( $originalPrioritizedLanguages );

		return $urlAlias;
	}

	function caidParameter(){
		$ini = eZINI::instance('bouygues.ini');
		$key = $ini->variable( 'CAID','key');
		// On passe l'annee en automatique
		//$year = $ini->variable( 'CAID','year');
		$year = date('Y');


		$string = $key.'|'.date('d/m/Y').'|'.$year.'|';
		$stringBase64 = base64_encode($string);
		$stringMd5 = md5($stringBase64);

		return $stringMd5;
	}

    var $Operators;
    var $Debug;

}

?>
