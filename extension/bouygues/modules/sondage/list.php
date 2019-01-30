<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebysondage.php" );

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

$INI = eZINI::instance('bouygues.ini');
$pageLimit = $INI->variable( 'WWAdminSettings','NbPagesMax');

$oSondage = new ebySondage();


if ( $Module->isCurrentAction( 'DeleteButton' ) )
{
	
	if ( $http->hasPostVariable( 'ActionIDArray' ) ){
		$actionIDArray = $http->postVariable( 'ActionIDArray' );
		
		if(!$oSondage->deleteSondage($actionIDArray)){
			eZDebug::writeNotice( 'Erreur deleteSondage', 'bouygues:sondage/list.php');	
		}
		
	}
}

if ( $Module->isCurrentAction( 'ExportUsers' ) )
{
	/** PHPExcel */
	include_once( "extension/bouygues/classes/PHPExcel.php" );

	/** PHPExcel_RichText */
	include_once( "extension/bouygues/classes/PHPExcel/RichText.php" );

	/** PHPExcel_IOFactory */
	include_once( "extension/bouygues/classes/PHPExcel/IOFactory.php" );
	
	
	$usersList = ebySondage::listAllResponses($http->variable('idSondage'));
	
	// Create new PHPExcel object
	$objPHPExcel = new PHPExcel();

	// Set properties
	// Create a first sheet, representing sales data
	$objPHPExcel->setActiveSheetIndex(0);
	$objPHPExcel->getActiveSheet()->setCellValue('B1', 'Liste des utilisateurs ayant répondu au sondage');
	$objPHPExcel->getActiveSheet()->setCellValue('D1', 'Date de création');
	$objPHPExcel->getActiveSheet()->setCellValue('E1', PHPExcel_Shared_Date::PHPToExcel( gmmktime(0,0,0,date('m'),date('d'),date('Y')) ));
	$objPHPExcel->getActiveSheet()->getStyle('E1')->getNumberFormat()->setFormatCode(PHPExcel_Style_NumberFormat::FORMAT_DATE_XLSX15);

	$objPHPExcel->getActiveSheet()->setCellValue('B3', 'Question');
	$objPHPExcel->getActiveSheet()->setCellValue('B3', $usersList[0]['question']);
	
	$objPHPExcel->getActiveSheet()->setCellValue('B5', 'Collaborateur');
	$objPHPExcel->getActiveSheet()->setCellValue('C5', 'Réponse');
	$objPHPExcel->getActiveSheet()->setCellValue('D5', 'Date de la réponse');
	
	
	$i = 6;
	foreach($usersList as $value){

		$objPHPExcel->getActiveSheet()->setCellValue('B'.$i, $value['user']);
		$objPHPExcel->getActiveSheet()->setCellValue('C'.$i, $value['reponse_str']);
		$objPHPExcel->getActiveSheet()->setCellValue('D'.$i, $value['dte_reponse']);
		$i++;
		
	}
	unset($usersList);
	
	
	$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
	$objWriter->setPreCalculateFormulas(false);
	header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
	header('Content-Disposition: attachment;filename="sondage-eby.xlsx"');
	header('Cache-Control: max-age=0');
	$objWriter->save('php://output');
	
	eZDB::checkTransactionCounter();
	eZExecution::cleanExit();
}

if($http->hasVariable('idSondage')){
	$currentSondage = ebySondage::fetchLast($http->variable('idSondage'));
	$tpl->setVariable('currentSondage', $currentSondage);
}


$sondageList = $oSondage->getSondageList();
$tpl->setVariable( 'sondage_list', $sondageList );





$Result['content'] = $tpl->fetch( "design:sondage/list.tpl" );
$Result['left_menu'] = 'design:sondage/menu.tpl';
$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => 'Liste des sondages') );

