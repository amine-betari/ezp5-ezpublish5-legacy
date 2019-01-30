<?php

$result = array();

try {
	
	// Initialisations
	$bini = eZINI::instance('bylink.ini');
	$page = ((empty($_GET['page']) || (!is_numeric($_GET['page'])))?1:$_GET['page']);
	$url = $bini->variable( 'WAT', 'flux' );

	if (empty($url)) {
		throw new exception('Url malformatted');
	}
	
	// Récupère le flux de données
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $url.$page);
	curl_setopt($ch, CURLOPT_HEADER, FALSE);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
	
	$flux = curl_exec($ch);
	
	$code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
	curl_close($ch);
	
	if ($code != 200) {
		throw new exception('Fail to connect to WAT');
	}
	
	if ((empty($flux)) || (!$flux)) {
		throw new exception('Fail to get XML data');
	}
	
	// Convertit le XML en tableau PHP
	$flux = simplexml_load_string($flux);
	
	if ((empty($flux))) {
		throw new exception('Fail to read XML data');
	}
	
	$flux = json_decode(json_encode($flux));
	
	if ((empty($flux->video))) {
		throw new exception('Fail to read XML data');
	}
	
	// Filtre les vidéos
	// active
	
	$result = array('action' => 1, 'videos' => $flux->video);
	
}
catch (exception $e) {
	$result = array('action' => 0, 'message' => $e->getMessage());
}

echo json_encode($result);

eZDB::checkTransactionCounter();
eZExecution::cleanExit();
