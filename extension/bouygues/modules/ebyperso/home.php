<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebyperso.php" );
include_once( "extension/bouygues/classes/ebysoap.php" );

$http = eZHTTPTool::instance();
$Module = $Params['Module'];
$tpl = templateInit();

$oEby = new ebyPerso();
$col1 = $oEby->getColonne(1);
$col2 = $oEby->getColonne(2);
$col3 = $oEby->getColonne(3);
 	
$usrObj = eZContentObject::fetch( $oEby->userId );	
$widgetList = $oEby->widget_list;

$tpl->setVariable( 'widget_list', $widgetList );
$tpl->setVariable( 'col1', $col1 );
$tpl->setVariable( 'col2', $col2 );
$tpl->setVariable( 'col3', $col3 );
$tpl->setVariable( 'user_obj', $usrObj );

if(MySOAP::isEmailGalbyError())
	$tpl->setVariable( 'galbyWarning', '1' );

// Get all RSS Exports
$exportArray = eZRSSExport::fetchList();
$exportList = array(); $arrSection = array();
foreach( $exportArray as $export )
{
	$itemList = $export->attribute('item_list'); //source_node.object.section_id
	$sourceNode = $itemList[0]->attribute('source_node');
	$sourceObject = $sourceNode->attribute('object');
	$section_id = $sourceObject->attribute('section_id');
	if(!in_array($section_id, $arrSection)){
		$arrSection[] = $section_id;
    	$exportList[$export->attribute( 'id' )] = $export;
	}
}
$tpl->setVariable( 'exportList', $exportList );


$Result = array();
$Result['content'] = $tpl->fetch( "design:ebyperso/home.tpl" );
$Result['path'] = array( 
			array( 'url' => false, 'text' => ezpI18n::tr( 'design/bouygues/ebyperso', 'ebyperso_title' ) )
);
?>