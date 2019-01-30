<?php

include_once( "kernel/common/template.php" );

$Module = $Params["Module"];
$Result = array();
$tpl = templateInit();
$http = eZHTTPTool::instance();

$tpl->setVariable( 'langCurrent',(eZLocale::instance()->localeFullCode()=='fre-FR')?'':'/en');

//Get the user information
$usrObj = eZUser::currentUser();
if($usrObj->isLoggedIn()){
	$tpl->setVariable( 'currentUser', $usrObj );
}

$id = null; $action = null;
if(isset($Params['id'])) $id = $Params['id'];
if(isset($Params['action'])) $action = $Params['action'];
if(isset($Params['params'])) $param = $Params['params'];
else 						 $param = $http->variable('param');


$view = 'print';

if(!is_null($action)){

	if($action == 'add'){

		if(!isset($_COOKIE['print'])){
			setcookie('print', $id.'|'.$param, time()+2592000, '/', '', false, true);
			$arrIds[0] = $id;
			$arrParam[0] = $param;
		}else{
			$arrIdsTp = explode(';',$_COOKIE['print']);

			if(!in_array($id.'|'.$param,$arrIdsTp)){		
				setcookie('print',$_COOKIE['print'].';'.$id.'|'.$param, time()+2592000, '/', '', false, true);
				$arrPrintPage = explode(';',$_COOKIE['print'].';'.$id.'|'.$param);
			}else
				$arrPrintPage = explode(';',$_COOKIE['print']);
				
			foreach($arrPrintPage as $value){

				$idTemp = explode('|', $value);
				$arrIds[] = $idTemp[0];
				$arrParam[] = $idTemp[1];
			}
			
		}
		
		$tpl->setVariable( 'idCurrent', $id );
		$tpl->setVariable( 'paramCurrent', $param );
		
	}elseif($action == 'delete'){
		
		if(!is_null($id)){
		
			$arrIdsTemp = explode(';',$_COOKIE['print']);
	
			foreach($arrIdsTemp as $keyTp => $idTemp){
				if($id.'|'.$param == $idTemp){
					$key = $keyTp;
					break;
				}
			}
			
			if(isset($arrIdsTemp[$key+1]) && $key >= 0)				$strCookie = str_replace($id.'|'.$param.';','',$_COOKIE['print']);
			elseif(!isset($arrIdsTemp[$key+1]) && $key == 0)		$strCookie = '';
			elseif(!isset($arrIdsTemp[$key+1]) && $key > 0)			$strCookie = str_replace(';'.$id.'|'.$param,'',$_COOKIE['print']);
			
			
		}else{
			$strCookie = '';
		}
		
		setcookie('print',$strCookie, time()+2592000, '/', '', false, true);
		$view = 'printAjax';
		
		$arrPrintPage = explode(';',$strCookie);
		foreach($arrPrintPage as $value){
			$id = explode('|', $value);
			$arrIds[] = $id[0];
			$arrParam[] =  $id[1];
		}
	}elseif($action == 'see'){
		if($http->hasGetVariable('pageId')){
			$id = $http->getVariable( 'pageId' );
			$param = $http->getVariable( 'param' );
			unset($arrIds);
			$arrIds[0] = $id;
			$arrParam[0] = $param;
		}
		
		$view = 'printAll';
	}
	
	
	
	$tpl->setVariable( 'action', $action );
}

if(!isset($arrIds)){
	$arrPrintPage = explode(';',$_COOKIE['print']);

	foreach($arrPrintPage as $value){
		$id = explode('|', $value);
		$arrIds[] = $id[0];
		$arrParam[] = $id[1];
	}
}

if(count($arrIds) > 0 && strlen($arrIds[0]) > 0){
	$tpl->setVariable( 'ids', array_reverse( $arrIds ) );
	$tpl->setVariable( 'params', array_reverse( $arrParam ) );
}



$Result['content'] = $tpl->fetch( "design:tools/".$view.".tpl" );
	$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => ezpI18n::tr( 'design/bouygues/tools', 'print_title' ) ) );