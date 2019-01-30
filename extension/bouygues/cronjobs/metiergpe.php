<?
include_once 'kernel/classes/ezcontentobject.php';
include_once( "extension/bouygues/classes/ebysoap.php" );

//Get the MetierGpe.xml file and save it in the following directory
//  => external/bin/

$ini = eZINI::instance('site.ini');
$iniBouygues = eZINI::instance('bouygues.ini');
$instance = $ini->variable( 'Instance','Serveur');

$url = $iniBouygues->variable('METIER_GPE', $instance );
$cli->output("URL : $url");

$cli->output("Connexion CURL en cours...");	

// create cURL resource
$ch = curl_init();
 
// set options
curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
 
// grab URL and pass it to the browser
$result = curl_exec($ch);

if(!$result){
	$cli->output("Erreur lors de la connexion");		
}else{
	
	$cli->output("Connexion établie, contenu XML récupéré");	
	
	$cli->output("Suppression du fichier existant");
	if(file_exists('external/bin/MetierGpe.xml'))
		unlink('external/bin/MetierGpe.xml');
	$f = fopen('external/bin/MetierGpe.xml', 'w+');
	if(fwrite($f, $result))
		$cli->output("Création du nouveau fichier réussi");
	else
		$cli->output("Echec de la création du nouveau fichier");
	fclose($f);
}

// close cURL resource, and free up system resources
curl_close($ch);

//Now we check the connexion between easynet and each webservices
$annuairArray = MySOAP::getAnnuaireXml(); $arrAvailability = array();
$cli->output("Disponibilite des annuaires ... ");
foreach($annuairArray['metier'] as $key => $value){
	$strContent = '<?xml version="1.0" encoding="utf-8"?>
	<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:tns="http://www.bouygues.com/wsdl/AnnuaireGroupe" xmlns:types="http://www.bouygues.com/wsdl/AnnuaireGroupe/encodedTypes" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
	  <soap:Body soap:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
	    <tns:getCollaborator>
	      <name xsi:type="xsd:string">'.$value['nomTest'].'</name>
	      <givenName xsi:type="xsd:string"></givenName>
	      <initials xsi:type="xsd:string"></initials>
	      <company xsi:type="xsd:string"></company>
	      <maxResults xsi:type="xsd:int">1</maxResults>
	    </tns:getCollaborator>
	  </soap:Body>
	</soap:Envelope>';
	
	if(!$resultXML = MySOAP::callCurl($value['url'], $strContent, ''))
		$arrAvailability[$key] = 0;
	else
		$arrAvailability[$key] = 1;
	
	$cli->output(">>> ".$key."");
}


$iniAnnuaire = eZINI::instance('annuaire.ini');

foreach($arrAvailability as $key => $value)
	$iniAnnuaire->setVariable( 'DISPONIBILITE', $key, $value);

$iniAnnuaire->save(false, false, false, false, 'extension/bouygues/settings/');
