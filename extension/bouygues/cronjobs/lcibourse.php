<?
include_once 'kernel/classes/ezcontentobject.php';
include_once( "extension/bouygues/classes/ebysoap.php" );

//Get the MetierGpe.xml file and save it in the following directory
//  => external/bin/

$ini = eZINI::instance('site.ini');
$iniBouygues = eZINI::instance('bouygues.ini');
$urlBourse = $iniBouygues->variable( 'WidgetBourse','CronUrl');
$urlLci = $iniBouygues->variable( 'LCI','CronUrl');

$bourseContent = file_get_contents($urlBourse);
$lciContent = file_get_contents($urlLci);

//Create bourse file
$f = fopen('external/bin/xml_quote.phtml', 'w+');
if(fwrite($f, $bourseContent))
	$cli->output("Création du nouveau fichier réussi");
else
	$cli->output("Echec de la création du nouveau fichier");
fclose($f);

//Create bourse file
$f = fopen('external/bin/lci.rss', 'w+');
if(fwrite($f, $lciContent))
	$cli->output("Création du nouveau fichier réussi");
else
	$cli->output("Echec de la création du nouveau fichier");
fclose($f);