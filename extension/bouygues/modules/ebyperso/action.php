<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebyperso.php" );

$http = eZHTTPTool::instance();
$Module = $Params['Module'];

//mise à jour du layout
if ($Module->isCurrentAction('LayoutUpd'))
{
	
	$myLayout = $Module->actionParameter('MyLayout');
	
	$oEby = new ebyPerso();	
	$oEby->setLayout($myLayout);
	
}

//ajout d'un widget
if ($Module->isCurrentAction('WidgetAdd'))
{
	
	$widgetSel = $Module->actionParameter('WidgetSel');
	$oEby = new ebyPerso();
	if($oEby->setWidget($widgetSel)){
		echo 'ok';
	}
	
}

//mise à jour des settings d'un widget
if ($Module->isCurrentAction('WidgetUpd'))
{

	$widgetId = $Module->actionParameter('WidgetId');
	//switch
	$widgetConf = $Module->actionParameter('WidgetConf');
	$oEby = new ebyPerso();
	$oEby->updWidget($widgetId,$widgetConf);
}

//ajax ajout ville météo
if ($Module->isCurrentAction('WidgetGetVille'))
{
	
	$q = $Module->actionParameter('q');
	$oEby = new ebyPerso();
	echo $oEby->getVilleMeteo($q);	

}

//ajax ajout contact
if ($Module->isCurrentAction('WidgetGetContact'))
{
	
	$q = $Module->actionParameter('q');
	$oEby = new ebyPerso();
	echo $oEby->getContact($q);	

}

eZDB::checkTransactionCounter();
eZExecution::cleanExit();

?>