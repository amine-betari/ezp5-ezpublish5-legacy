<?php
/**
 * This file is used to export the who's who subscribers
 */

ini_set('memory_limit', '528M');
/** PHPExcel */
include_once( "extension/bouygues/classes/PHPExcel.php" );

/** PHPExcel_RichText */
include_once( "extension/bouygues/classes/PHPExcel/RichText.php" );

/** PHPExcel_IOFactory */
include_once( "extension/bouygues/classes/PHPExcel/IOFactory.php" );

include_once( "extension/bouygues/classes/ebyuseraccess.php" );
include_once( "extension/bouygues/classes/ebywhoswho.php" );
 

$oUsr = new ebyUserAccess();
$section = $oUsr->getListSection();
$arrWw = $oUsr->getListWw();

//print_r($section);
$arrCol = array( 'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
				 'AA','AB','AC');
$rowColName = 3;

if($section != null){
	
	if(count($section)>1){
		//tous les champs
		$allFieds = true;
	}else{
		//uniquement les champs sélectionnés
		$allFieds = false; 
	}

	//récupération des champs à afficher
	$oWw = new ebyWhoswho();
	$fieldsList = $oWw->getAllFields();//print_r($fieldsList);
	if(!$allFieds){
		$fieldsListSelect = $oWw->getWwFields($arrWw[0]);
		$fieldsList = array_intersect_key($fieldsList, $fieldsListSelect);
	}
	$fieldsList['ww_name']=array(
						            'parent_type' => 'class',
						            'parent_nom' => 'bouygues_whoswho',
						            'titre' => 'Who\'s Who'
						        );
	
	//récupération des utilisateurs	
	$usersList = ebyWhoswho::getUsersList(ebyWhoswho::WW_USER_STATUS_ACCEPTED,$arrWw);
	

}else{
	$Module->redirectTo( '/whoswho/userlist' );
	return;
}
	

// Create new PHPExcel object
$objPHPExcel = new PHPExcel();

// Set properties

// Create a first sheet, representing sales data
$objPHPExcel->setActiveSheetIndex(0);
$objPHPExcel->getActiveSheet()->setCellValue('B1', 'Liste des utilisateurs membre des Who s Who');
$objPHPExcel->getActiveSheet()->setCellValue('C1', 'Date de création');
$objPHPExcel->getActiveSheet()->setCellValue('D1', PHPExcel_Shared_Date::PHPToExcel( gmmktime(0,0,0,date('m'),date('d'),date('Y')) ));
$objPHPExcel->getActiveSheet()->getStyle('D1')->getNumberFormat()->setFormatCode(PHPExcel_Style_NumberFormat::FORMAT_DATE_XLSX15);
//$objPHPExcel->getActiveSheet()->setCellValue('E1', '#12566');

$objPHPExcel->getActiveSheet()->setCellValue('A3', 'Email');
$i=1;
foreach($fieldsList as $key => $val){
	$objPHPExcel->getActiveSheet()->setCellValue($arrCol[$i].$rowColName, $val['titre']);
	$i++;
}

$i=1;
$row = $rowColName+1;
foreach($usersList as $key1 => $val1){
	$i=1;
	$userData = ebyWhoswho::getUserData($val1['user_id'],true);
	//get email
	$current_user = eZUser::fetch( $val1['user_id'] );
	$email = $current_user->attribute('email');
	unset($current_user);
	if(count($val1['ww']) > 0){
		$userData['ww_name']='';
		foreach($val1['ww'] as $val3){
			$userData['ww_name'].= $val3['name']."\n";	
		}
	}
	$objPHPExcel->getActiveSheet()->setCellValue('A'.$row, $email);
	foreach($fieldsList as $key2 => $val2){
		$objPHPExcel->getActiveSheet()->setCellValue($arrCol[$i].$row, $userData[$key2]);
		$i++;
	}
	
	unset($userData);	
	$row++; 
}
unset($usersList);


//Excel 2007
$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
$objWriter->setPreCalculateFormulas(false);
header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
header('Content-Disposition: attachment;filename="myfile.xlsx"');
header('Cache-Control: max-age=0');
$objWriter->save('php://output');

//Excel 2005
/*
$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
header('Content-type: application/vnd.ms-excel');                   
header('Content-Disposition:inline;filename=Fichier.xls ');
$objWriter->save('php://output');
*/

//CSV
/*
$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'CSV');
$objWriter->setDelimiter(',');
$objWriter->setEnclosure('');
$objWriter->setLineEnding("\r\n");
$objWriter->setSheetIndex(0);
*/ 