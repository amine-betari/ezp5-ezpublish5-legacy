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




// Create new PHPExcel object
$objPHPExcel = new PHPExcel();

// Set properties

// Create a first sheet, representing sales data
$objPHPExcel->setActiveSheetIndex(0);
$objPHPExcel->getActiveSheet()->setCellValue('B1', 'Liste de diffusion');
$objPHPExcel->getActiveSheet()->setCellValue('C1', 'Date de création');
$objPHPExcel->getActiveSheet()->setCellValue('D1', PHPExcel_Shared_Date::PHPToExcel( gmmktime(0,0,0,date('m'),date('d'),date('Y')) ));
$objPHPExcel->getActiveSheet()->getStyle('D1')->getNumberFormat()->setFormatCode(PHPExcel_Style_NumberFormat::FORMAT_DATE_XLSX15);
//$objPHPExcel->getActiveSheet()->setCellValue('E1', '#12566');

$objPHPExcel->getActiveSheet()->setCellValue('A3', 'Id');
$objPHPExcel->getActiveSheet()->setCellValue('B3', 'Email');
$objPHPExcel->getActiveSheet()->setCellValue('C3', 'Nom');
$objPHPExcel->getActiveSheet()->setCellValue('D3', 'Prénom');

$objPHPExcel->getActiveSheet()->setCellValue('E3', 'Origine');




$row = 4;
foreach($usersExport as $key => $val)
{
	//eZLog::write ( 'exporusrlist.inc.php : $$val => ' .  $val , 'eby_admin.log', 'var/log');
	
	
	$objPHPExcel->getActiveSheet()->setCellValue('A'.$row, $val['user_id']);
	$objPHPExcel->getActiveSheet()->setCellValue('B'.$row, $val['email']);
	$objPHPExcel->getActiveSheet()->setCellValue('C'.$row, $val['last_name']);
	$objPHPExcel->getActiveSheet()->setCellValue('D'.$row, $val['first_name']);
	$objPHPExcel->getActiveSheet()->setCellValue('E'.$row, $val['diffusion_name']);
		
	$row++; 
}


//Excel 2007
$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
$objWriter->setPreCalculateFormulas(false);
header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
header('Content-Disposition: attachment;filename="liste_diffusion.xlsx"');
header('Cache-Control: max-age=0');
$objWriter->save('php://output');

