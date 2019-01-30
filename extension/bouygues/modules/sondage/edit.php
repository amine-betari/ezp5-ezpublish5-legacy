<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebysondage.php" );

$Module = $Params["Module"];
$Result = array();
$tpl = templateInit();
$http = eZHTTPTool::instance();

$oSondage = new ebySondage();

if ( isset($Params['id']) )
{
	$sondageId = $Params['id'];
	$sondageData = $oSondage->getSondageData($sondageId);

	$tpl->setVariable( 'id', $sondageId );
	$tpl->setVariable( 'sondage_data', $sondageData );
	
}

if ( $Module->isCurrentAction( 'ValidateButton' ) )
{
		$sondageId=null;
		
		$arrPostData = array(
								"question"				=> $http->postVariable( 'question' ),
								"reponse1"				=> $http->postVariable( 'reponse1' ),
								"reponse2"				=> $http->postVariable( 'reponse2' ),
								"reponse3"				=> $http->postVariable( 'reponse3' ),
								"question_eng"			=> $http->postVariable( 'question_eng' ),
								"reponse1_eng"			=> $http->postVariable( 'reponse1_eng' ),
								"reponse2_eng"			=> $http->postVariable( 'reponse2_eng' ),
								"reponse3_eng"			=> $http->postVariable( 'reponse3_eng' ),
								"etat"					=> $http->postVariable( 'etat' )								
							);
							
		if ( $http->hasPostVariable( 'SondageId' ) ) 	$sondageId = $http->postVariable( 'SondageId' );		

		if ( $http->hasPostVariable( 'ActionIDArray' ) )
		{
			
			$arrPostData['ActionIDArray'] = $http->postVariable( 'ActionIDArray' );
			
			
			
			if(!$oSondage->setSondage($sondageId,$arrPostData)){
				eZDebug::writeNotice( 'Erreur setSondage', 'bouygues:sondage/edit.php');	
			}
		
		}

		$Module->redirectTo( '/sondage/list' );
		return;
		
}

if ( $Module->isCurrentAction( 'CancelButton' ) )
{
	$Module->redirectTo( '/sondage/list' );
	return;
}


$Result['content'] = $tpl->fetch( "design:sondage/edit.tpl" );
$Result['left_menu'] = 'design:sondage/menu.tpl';
$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => 'Editer un sondage') );

