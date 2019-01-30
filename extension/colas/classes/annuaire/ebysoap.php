<?php

/**
 * This class is used to call all Bouygues webservices
 */
class MySOAP{
 
	/**
	 * Call the url with the XML and method passed in parameters
	 * Use of the CURL php library
	 */
    public static function callCurl($url,$strContent,$method)
    {
    	echo 'StrContent -->'.$strContent;
		$ini = eZINI::instance('site.ini');
		$instance = $ini->variable( 'Instance','Serveur');
		if(!in_array($instance, array('dev', 'integ'))){
		
	    	$curl=curl_init(); 
			curl_setopt($curl,CURLOPT_URL,$url); 
			curl_setopt($curl,CURLOPT_POST,1); 
			
			curl_setopt($curl, CURLOPT_TIMEOUT, 5);
			curl_setopt($curl,CURLOPT_POSTFIELDS,$strContent);
			curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, FALSE);
			curl_setopt($curl,CURLOPT_HEADER,false); 
			curl_setopt($curl,CURLOPT_HTTPHEADER,array('Content-Type: text/xml; charset=utf-8','Content-Length: '.strlen($strContent),'SOAPAction:"'.$method.'"')); 
			curl_setopt($curl,CURLOPT_RETURNTRANSFER,1); 
			
			if( curl_errno( $curl ) != CURLE_OK ) return false;
			$result=curl_exec($curl);
			$CurlErr  = curl_error($curl);
			curl_close( $curl );
			
			if($CurlErr) return false;
			
			$dom = new DOMDocument;
	       	$dom->preserveWhiteSpace = FALSE;
	       	$dom->loadXML( $result);

			$count = 'ko';
			if($method == ''){
				$count = 0;
				$elementMulti = $dom->getElementsByTagName('multiRef');
				$isMultiref = $elementMulti->item(0);
				
				if($isMultiref)
					return $result;
				else
					foreach($dom->getElementsByTagName('nbResults') as $nbesult) $count = $nbesult->nodeValue;
				
			}
			if($count == 'ko' || $count > 0)
				return $result;
			else
				return false;
				
    	}else			
			return IntegBouchon::callCurl($method, true);
    }

	/**
	 * Used to call the CLICKTOCALL functionality
	 */
	public static function makeCall($company,  $domain, $login, $tel, $date = null){
		$ini = eZINI::instance('site.ini');
		$path = $ini->variable( 'Instance','Chemin');
		
		if(is_null($date))
			$date = date('m/d/Y H :m :i :000');  //	12/06/2009 15 :53 :00 :000 (standard)
			
		$initAnnuaire = self::getAnnuaireXml();

		$key = $initAnnuaire[$domain]['key'];
		$clicktocall = $initAnnuaire[$domain]['clicktocall'];

		if(is_null($clicktocall) || $clicktocall == 'False')
			return 'Click to call non actif';
		// =====================================================================================================

		//Formatage du numéro de téléphone
		$tel = str_replace("</b>","", $tel);
		$tel = str_replace("<b>","",$tel);
		$tel = str_replace("&nbsp;","",$tel);
		$tel = str_replace("&nbsp","",$tel);
		$tel = str_replace(" ","",$tel);
		$tel = str_replace(".","",$tel);
		$tel = str_replace("\\","",$tel);
		$tel = str_replace("/","",$tel);
		$tel = str_replace("(","",$tel);
		$tel = str_replace(")","",$tel);
		$tel = str_replace("/","",$tel);
		$tel = str_replace("+","00",$tel);
		

		
		$parametersTemp = (string)"$domain;$login;$tel;$date";
		$encryptedData = exec("java -jar ".$path."/external/java/JavaAESCrypto.jar encrypt '".$parametersTemp."' ".$key);
		
		$strContent = '<?xml version="1.0" encoding="utf-8"?>
		<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:tns="http://www.bouygues.com/wsdl/AnnuaireGroupe" xmlns:types="http://www.bouygues.com/wsdl/AnnuaireGroupe/encodedTypes" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
		  <soap:Body soap:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
		    <tns:makeCall>
		      <parameters xsi:type="xsd:string">'.$encryptedData.'</parameters>
		    </tns:makeCall>
		  </soap:Body>
		</soap:Envelope>';

		$resultXML = self::callCurl($initAnnuaire[$domain]['url'], $strContent, 'makeCall');		
		$dom = new DOMDocument;
	   	$dom->preserveWhiteSpace = FALSE;
    	$dom->loadXML( $resultXML);
		
		return true;

	}
 
	/**
	 * Used to get the directories' array in order to generate all the necessary parameters
	 */
	public static function getAnnuaireXml(){
		
		if(file_exists("external/bin/MetierGpe.xml"))
        {
            $resultXML = file_get_contents("external/bin/MetierGpe.xml");
        }

		else
			$resultXML = file_get_contents("external/bin/MetierGpe.example.xml");
			
		$dom = new DOMDocument;
		$dom->preserveWhiteSpace = FALSE;
		
		if(!$dom->loadXML( $resultXML)){
			return false;
		}else{
			
			$iniAnnuaire = eZINI::instance('annuaire.ini');
			$annuaireArray = array(); $i = 0;
			$lang = (eZLocale::instance()->localeFullCode()=='fre-FR')?'':'_en';
			$arrDomainTemp = array();	
			foreach ($dom->getElementsByTagName('metier') as $element) {
				
				
				$annuaireArray['metier'][$element->getAttribute('id')]['libelleLong'] = $element->getAttribute('libelleLong');
				$annuaireArray['metier'][$element->getAttribute('id')]['pardefaut'] = strtolower($element->getAttribute('pardefaut'));
				
				$annuaireArray['metier'][$element->getAttribute('id')]['clicktocall'] = $element->getAttribute('clickToCall');
				foreach($element->getElementsByTagName('serviceAnnuaire') as $serviceAnnuaire){
					$annuaireArray['metier'][$element->getAttribute('id')]['indisponible'] = strtolower($serviceAnnuaire->getAttribute('indisponible'));
					$annuaireArray['metier'][$element->getAttribute('id')]['enMaintenance'] = strtolower($serviceAnnuaire->getAttribute('enMaintenance'));
					
					foreach($serviceAnnuaire->getElementsByTagName('url') as $url){
						$annuaireArray['metier'][$element->getAttribute('id')]['url'] = $url->nodeValue;
					}
					
					foreach($serviceAnnuaire->getElementsByTagName('nomTest') as $nomtest){
						$annuaireArray['metier'][$element->getAttribute('id')]['nomTest'] = $nomtest->nodeValue;
					}
				}

				
				foreach($element->getElementsByTagName('key') as $key){
					$annuaireArray['metier'][$element->getAttribute('id')]['key'] = $key->nodeValue;
				}
				
				$annuaireArray['metier'][$element->getAttribute('id')]['easynetDispo'] = $iniAnnuaire->variable( 'DISPONIBILITE', $element->getAttribute('id'));
				
				foreach ($dom->getElementsByTagName('indisponible_long'.$lang) as $indispo)
					$annuaireArray['metier'][$element->getAttribute('id')]['indisponible_long'] = $indispo->nodeValue;
					
				foreach ($dom->getElementsByTagName('maintenance_long'.$lang) as $indispo)
					$annuaireArray['metier'][$element->getAttribute('id')]['maintenance_long'] = $indispo->nodeValue;

				
				foreach($element->getElementsByTagName('domaines') as $domaines){
					foreach($domaines->getElementsByTagName('domaine') as $domaine){
						if(!in_array($domaine->nodeValue, $arrDomainTemp)){
							$arrDomainTemp[] = $domaine->nodeValue;
							$annuaireArray[$domaine->nodeValue]['key'] = $annuaireArray['metier'][$element->getAttribute('id')]['key'];
							$annuaireArray[$domaine->nodeValue]['clicktocall'] = $annuaireArray['metier'][$element->getAttribute('id')]['clicktocall'];
							$annuaireArray[$domaine->nodeValue]['url'] = $annuaireArray['metier'][$element->getAttribute('id')]['url'];
						}
					}
				}

				$i++;
				
			}				
		}

		//Reorder the array
		ksort($annuaireArray['metier']);
		return $annuaireArray;
	}


	/**
	 * Check if the email is in Galby
	 */
    public static function isGalbyEmailValid($email){
    	
		$ini = eZINI::instance('site.ini');
		$instance = $ini->variable( 'Instance','Serveur');

		if(!in_array($instance, array('dev', 'integ'))){

   			$strContent = '<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
			  <soap:Body>
			    <IsValidAccount xmlns="http://tempuri.org/">
			      <p_UserEMail>'.$email.'</p_UserEMail>
			    </IsValidAccount>
			  </soap:Body>
			</soap:Envelope>';
   			
        	
        	$url='http://10.4.3.24/WSGalby/WSAskAnnuaire.asmx'; 
        	$method='http://tempuri.org/IsValidAccount';
        	
			$res = self::callCurl($url,$strContent,$method);

			if(!$res){
				eZLog::write ( 'erreur MySOAP Call : ', 'bouygues_galbycheck.log', 'var/log'); 
				return false;
			}else{
				
       			$dom = new DOMDocument;
       			$dom->preserveWhiteSpace = FALSE;
       			
       			if(!$dom->loadXML( $res)){
       				eZLog::write ( 'loadXML : erreur', 'bouygues_galbycheck.log', 'var/log');
       			}else{
       				eZLog::write ( 'loadXML : ok', 'bouygues_galbycheck.log', 'var/log');
       			}	 
       				
				if ( !empty( $dom ) ){
			        $results=''; 
			        foreach ($dom->getElementsByTagName('IsValidAccountResult') as $element) {
			        	return $element->nodeValue;
			    	}	
					
				} 
			
			
				return false;
			}
    	}else
			return IntegBouchon::isGalbyEmailValid($email);
    }
    
	/**
	 * Get the name and firstname of a collaborator
	 */
   	public static function getContactByMailOnly($email){
    	
		$ini = eZINI::instance('site.ini');
		$instance = $ini->variable( 'Instance','Serveur');

		if(!in_array($instance, array('dev', 'integ'))){
		
			$strContent = '<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
			  <soap:Body>
			    <GetContactByMailOnly xmlns="http://tempuri.org/">
			      <p_sMail>'.$email.'</p_sMail>
			    </GetContactByMailOnly>
			  </soap:Body>
			</soap:Envelope>';
			
        	
        	$url='http://10.4.3.24/WSGalby/WSAskAnnuaire.asmx'; 
        	$method='http://tempuri.org/GetContactByMailOnly';
        	
			$res = self::callCurl($url,$strContent,$method);
			
			if(!$res){
				eZLog::write ( 'erreur MySOAP Call : ', 'bouygues_ebyidentification.log', 'var/log'); 
				return false;
			}else{
				
       			$dom = new DOMDocument;
       			$dom->preserveWhiteSpace = FALSE;
       			
       			if(!$dom->loadXML( $res)){
       				eZLog::write ( 'loadXML : erreur', 'bouygues_ebyidentification.log', 'var/log');
       			}else{
       				eZLog::write ( 'loadXML : ok', 'bouygues_ebyidentification.log', 'var/log');
       			}	 
       			
			    	
				if ( !empty( $dom ) ){
			        foreach ($dom->getElementsByTagName('Contact') as $element) {
			        	foreach ($element->getElementsByTagName('GivenName') as $givenName) {
			    			$arrayUser['first_name'] = $givenName->nodeValue;
			    		}
			        	foreach ($element->getElementsByTagName('Sn') as $Sn) {
			    			$arrayUser['last_name'] = $Sn->nodeValue;
			    		} 
			    	}          
					if(isset($arrayUser['first_name']) && isset($arrayUser['last_name'])){
						return $arrayUser;  
					}else{
						eZLog::write ( 'ebysoap : first_name &&  last_name => undefined', 'bouygues_ebyidentification.log', 'var/log');
						return false;
					}	
					
				}
			
			
				return false;
			}
    	}else
			return IntegBouchon::getContactByMailOnly($email);
    }
    
	/**
	 * Search collaborators in directories
	 */
    public static function searchCollaborator($lastname, 
				$firstname = null, 
				$company = null, 
				$initial = null, 
				$email = null, 
				$enlarge = 0, 
				$nbresult = 20)
	{
    	
    	if(strlen($nbresult) == 0){
	 		$nbresult = 20;
		}
		
    	if(strlen($enlarge) == 0) 	$enlarge = 0;
		if(is_null($company))		$enlarge = 1;
		
    	$initAnnuaire = self::getAnnuaireXml();

		$strContent = '<?xml version="1.0" encoding="utf-8"?>
		<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:tns="http://www.bouygues.com/wsdl/AnnuaireGroupe" xmlns:types="http://www.bouygues.com/wsdl/AnnuaireGroupe/encodedTypes" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
		  <soap:Body soap:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
		    <tns:getCollaborator>
		      <name xsi:type="xsd:string">'.$lastname.'</name>
		      <givenName xsi:type="xsd:string">'.$firstname.'</givenName>
		      <initials xsi:type="xsd:string">'.$initial.'</initials>
		      <company xsi:type="xsd:string"></company>
		      <maxResults xsi:type="xsd:int">'.$nbresult.'</maxResults>
		    </tns:getCollaborator>
		  </soap:Body>
		</soap:Envelope>';

		$pos = strpos($lastname, '\'');
		
		if($pos)
			$strContent2 = '<?xml version="1.0" encoding="utf-8"?>
			<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:tns="http://www.bouygues.com/wsdl/AnnuaireGroupe" xmlns:types="http://www.bouygues.com/wsdl/AnnuaireGroupe/encodedTypes" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
			  <soap:Body soap:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
			    <tns:getCollaborator>
			      <name xsi:type="xsd:string">'.str_replace('\'', ' ', $lastname).'</name>
			      <givenName xsi:type="xsd:string">'.str_replace('\'', ' ', $firstname).'</givenName>
			      <initials xsi:type="xsd:string">'.$initial.'</initials>
			      <company xsi:type="xsd:string"></company>
			      <maxResults xsi:type="xsd:int">'.$nbresult.'</maxResults>
			    </tns:getCollaborator>
			  </soap:Body>
			</soap:Envelope>';
		else
			$strContent2 = false;

        //echo 'url call curl -->'.$initAnnuaire['metier'][$company]['url'];

		if($enlarge == 0){
			$resultXML = self::callCurl($initAnnuaire['metier'][$company]['url'], $strContent, '');
			if(!$resultXML && $strContent2){
				$resultXML = self::callCurl($initAnnuaire['metier'][$company]['url'], $strContent2, '');
			}
			$dom = new DOMDocument;
	       	$dom->preserveWhiteSpace = FALSE;
	       	$dom->loadXML( $resultXML);

			if ( !empty( $dom ) ){				
				$arrResult = array(); $i = 0;
				
				$elementMulti = $dom->getElementsByTagName('multiRef');
				$isMultiref = $elementMulti->item(0);
				
				if($isMultiref){
					
					foreach ($dom->getElementsByTagName('multiRef') as $element) {
						if($element->nodeValue == 'true' || $element->nodeValue == 'false') 							$arrResult['isMax'] = $element->nodeValue;
						foreach($element->getElementsByTagName('title') as $elementAttribute) 							$arrResult['result'][$company]['users'][$i]['title'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('workSite') as $elementAttribute) 						$arrResult['result'][$company]['users'][$i]['workSite'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('location') as $elementAttribute) 						$arrResult['result'][$company]['users'][$i]['location'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('name') as $elementAttribute) 							$arrResult['result'][$company]['users'][$i]['name'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('givenName') as $elementAttribute) 						$arrResult['result'][$company]['users'][$i]['givenName'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('maidenName') as $elementAttribute) 						$arrResult['result'][$company]['users'][$i]['maidenName'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('penName') as $elementAttribute) 						$arrResult['result'][$company]['users'][$i]['penName'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('initials') as $elementAttribute) 						$arrResult['result'][$company]['users'][$i]['initials'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('personalTitle') as $elementAttribute) 					$arrResult['result'][$company]['users'][$i]['personalTitle'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('photo') as $elementAttribute) 							$arrResult['result'][$company]['users'][$i]['photo'] = str_replace(' ', '', (str_replace('\n','',$elementAttribute->nodeValue)));
			        	foreach($element->getElementsByTagName('telephoneNumber') as $elementAttribute) 				$arrResult['result'][$company]['users'][$i]['telephoneNumber'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('mobile') as $elementAttribute) 							$arrResult['result'][$company]['users'][$i]['mobile'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('facsimileTelephonenumber') as $elementAttribute) 		$arrResult['result'][$company]['users'][$i]['facsimileTelephonenumber'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('mail') as $elementAttribute) 							$arrResult['result'][$company]['users'][$i]['mail'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('secretaryName') as $elementAttribute) 					$arrResult['result'][$company]['users'][$i]['secretaryName'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('secretaryPhone') as $elementAttribute) 					$arrResult['result'][$company]['users'][$i]['secretaryPhone'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('company') as $elementAttribute) 						$arrResult['result'][$company]['users'][$i]['company'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('organizationalUnit') as $elementAttribute) 				$arrResult['result'][$company]['users'][$i]['organizationalUnit'] = $elementAttribute->nodeValue;
						foreach($element->getElementsByTagName('streetAddress') as $elementAttribute) 					$arrResult['result'][$company]['users'][$i]['streetAddress'] = $elementAttribute->nodeValue;
						foreach($element->getElementsByTagName('city') as $elementAttribute) 							$arrResult['result'][$company]['users'][$i]['city'] = $elementAttribute->nodeValue;
						foreach($element->getElementsByTagName('country') as $elementAttribute) 						$arrResult['result'][$company]['users'][$i]['country'] = $elementAttribute->nodeValue;
			
						
							
						if(isset($arrResult['result'][$company]['users'][$i])){
							if(strtolower($initAnnuaire['metier'][$company]['clicktocall']) == 'true')
								$arrResult['result'][$company]['users'][$i]['clicktocall'] = true;
							else
								$arrResult['result'][$company]['users'][$i]['clicktocall'] = false;	
							
							$arrResult['result'][$company]['users'][$i] = MySOAP::saveData($company,$arrResult['result'][$company]['users'][$i]);
							$arrResult['sort'][$i] = $arrResult['result'][$company]['users'][$i]['name'];
							$i++;
						}
			        	
					}
					$arrResult['count'] = $i;
				}else{

					foreach($dom->getElementsByTagName('nbResults') as $nbesult)										$arrResult['count'] = $nbesult->nodeValue;
					foreach($dom->getElementsByTagName('isMax') as $isMax) 												$arrResult['isMax'] = $isMax->nodeValue;
					if($arrResult['count'] < $nbresult) 																$arrResult['isMax'] = 'true';
					
			        foreach ($dom->getElementsByTagName('Collaborator') as $element) {
			        	
			        	foreach($element->getElementsByTagName('title') as $elementAttribute) 							$arrResult['result'][$company]['users'][$i]['title'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('workSite') as $elementAttribute) 						$arrResult['result'][$company]['users'][$i]['workSite'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('location') as $elementAttribute) 						$arrResult['result'][$company]['users'][$i]['location'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('name') as $elementAttribute) 							$arrResult['result'][$company]['users'][$i]['name'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('givenName') as $elementAttribute) 						$arrResult['result'][$company]['users'][$i]['givenName'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('maidenName') as $elementAttribute) 						$arrResult['result'][$company]['users'][$i]['maidenName'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('penName') as $elementAttribute) 						$arrResult['result'][$company]['users'][$i]['penName'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('initials') as $elementAttribute) 						$arrResult['result'][$company]['users'][$i]['initials'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('personalTitle') as $elementAttribute) 					$arrResult['result'][$company]['users'][$i]['personalTitle'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('photo') as $elementAttribute) 							$arrResult['result'][$company]['users'][$i]['photo'] = str_replace(' ', '', (str_replace('\n','',$elementAttribute->nodeValue)));
			        	foreach($element->getElementsByTagName('telephoneNumber') as $elementAttribute) 				$arrResult['result'][$company]['users'][$i]['telephoneNumber'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('mobile') as $elementAttribute) 							$arrResult['result'][$company]['users'][$i]['mobile'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('facsimileTelephonenumber') as $elementAttribute) 		$arrResult['result'][$company]['users'][$i]['facsimileTelephonenumber'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('mail') as $elementAttribute) 							$arrResult['result'][$company]['users'][$i]['mail'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('secretaryName') as $elementAttribute) 					$arrResult['result'][$company]['users'][$i]['secretaryName'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('secretaryPhone') as $elementAttribute) 					$arrResult['result'][$company]['users'][$i]['secretaryPhone'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('company') as $elementAttribute) 						$arrResult['result'][$company]['users'][$i]['company'] = $elementAttribute->nodeValue;
			        	foreach($element->getElementsByTagName('organizationalUnit') as $elementAttribute) 				$arrResult['result'][$company]['users'][$i]['organizationalUnit'] = $elementAttribute->nodeValue;
						foreach($element->getElementsByTagName('streetAddress') as $elementAttribute) 					$arrResult['result'][$company]['users'][$i]['streetAddress'] = $elementAttribute->nodeValue;
						foreach($element->getElementsByTagName('city') as $elementAttribute) 							$arrResult['result'][$company]['users'][$i]['city'] = $elementAttribute->nodeValue;
						foreach($element->getElementsByTagName('country') as $elementAttribute) 						$arrResult['result'][$company]['users'][$i]['country'] = $elementAttribute->nodeValue;
			
						if(strtolower($initAnnuaire['metier'][$company]['clicktocall']) == 'true')
							$arrResult['result'][$company]['users'][$i]['clicktocall'] = true;
						else
							$arrResult['result'][$company]['users'][$i]['clicktocall'] = false;
			
			        	$arrResult['result'][$company]['users'][$i] = MySOAP::saveData($company,$arrResult['result'][$company]['users'][$i]);
			
						$arrResult['sort'][$i] = $arrResult['result'][$company]['users'][$i]['name'];
			        	$i++;
			        }
				}			        	
			}
			
			
			unset($dom);

		}else{
			$arrResult = array(); $i = 0; $arrResult['count'] = 0; $arrResult['isMax'] = 'true';
			foreach($initAnnuaire['metier'] as $key => $annuaire){
				$resultXML = self::callCurl($annuaire['url'], $strContent, '');
				
				if(!$resultXML && $strContent2)
					$resultXML = self::callCurl($annuaire['url'], $strContent2, '');
				
				$dom = new DOMDocument;
		       	$dom->preserveWhiteSpace = FALSE;
		       	$dom->loadXML( $resultXML);
				if ( !empty( $dom ) ){				
					
					$elementMulti = $dom->getElementsByTagName('multiRef');
					$isMultiref = $elementMulti->item(0);
					
					if($isMultiref){
						foreach ($dom->getElementsByTagName('multiRef') as $element) {								
							
							if($nbresult == 20 && $i == 20){
								$arrResult['isMax'] = 'false';
								break;
							}elseif($nbresult == 100 && $i == 100){
								$arrResult['isMax'] = 'false';
								break;
							}
							
							if($element->nodeValue == 'false') 																$arrResult['isMax'] = 'false';
							foreach($element->getElementsByTagName('title') as $elementAttribute) 							$arrResult['result'][$key]['users'][$i]['title'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('workSite') as $elementAttribute) 						$arrResult['result'][$key]['users'][$i]['workSite'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('location') as $elementAttribute) 						$arrResult['result'][$key]['users'][$i]['location'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('name') as $elementAttribute) 							$arrResult['result'][$key]['users'][$i]['name'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('givenName') as $elementAttribute) 						$arrResult['result'][$key]['users'][$i]['givenName'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('maidenName') as $elementAttribute) 						$arrResult['result'][$key]['users'][$i]['maidenName'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('penName') as $elementAttribute) 						$arrResult['result'][$key]['users'][$i]['penName'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('initials') as $elementAttribute) 						$arrResult['result'][$key]['users'][$i]['initials'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('personalTitle') as $elementAttribute) 					$arrResult['result'][$key]['users'][$i]['personalTitle'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('photo') as $elementAttribute) 							$arrResult['result'][$key]['users'][$i]['photo'] = str_replace(' ', '', (str_replace('\n','',$elementAttribute->nodeValue)));
				        	foreach($element->getElementsByTagName('telephoneNumber') as $elementAttribute) 				$arrResult['result'][$key]['users'][$i]['telephoneNumber'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('mobile') as $elementAttribute) 							$arrResult['result'][$key]['users'][$i]['mobile'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('facsimileTelephonenumber') as $elementAttribute) 		$arrResult['result'][$key]['users'][$i]['facsimileTelephonenumber'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('mail') as $elementAttribute) 							$arrResult['result'][$key]['users'][$i]['mail'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('secretaryName') as $elementAttribute) 					$arrResult['result'][$key]['users'][$i]['secretaryName'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('secretaryPhone') as $elementAttribute) 					$arrResult['result'][$key]['users'][$i]['secretaryPhone'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('company') as $elementAttribute) 						$arrResult['result'][$key]['users'][$i]['company'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('organizationalUnit') as $elementAttribute) 				$arrResult['result'][$key]['users'][$i]['organizationalUnit'] = $elementAttribute->nodeValue;
							foreach($element->getElementsByTagName('streetAddress') as $elementAttribute) 					$arrResult['result'][$key]['users'][$i]['streetAddress'] = $elementAttribute->nodeValue;
							foreach($element->getElementsByTagName('city') as $elementAttribute) 							$arrResult['result'][$key]['users'][$i]['city'] = $elementAttribute->nodeValue;
							foreach($element->getElementsByTagName('country') as $elementAttribute) 						$arrResult['result'][$key]['users'][$i]['country'] = $elementAttribute->nodeValue;
				
							if(isset($arrResult['result'][$key]['users'][$i])){
								$arrResult['count'] ++;
								
								if(strtolower($initAnnuaire['metier'][$company]['clicktocall']) == 'true')
									$arrResult['result'][$key]['users'][$i]['clicktocall'] = true;
								else
									$arrResult['result'][$key]['users'][$i]['clicktocall'] = false;
								
								$arrResult['result'][$key]['users'][$i] = MySOAP::saveData($key,$arrResult['result'][$key]['users'][$i]);
								$arrResult['sort'][$i] = $arrResult['result'][$key]['users'][$i]['name'];
								$i++;
							}
							
							
						}
						
					}else{
						
						foreach($dom->getElementsByTagName('nbResults') as $nbesult) 										$arrResult['count'] += $nbesult->nodeValue;
						foreach($dom->getElementsByTagName('isMax') as $isMax)												if($isMax->nodeValue == 'false' && $nbesult->nodeValue >= $nbresult)	$arrResult['isMax'] = 'false';
				        foreach ($dom->getElementsByTagName('Collaborator') as $element) {
				        	
							if($nbresult == 20 && $i == 20){
								$arrResult['isMax'] = 'false';
								break;
							}elseif($nbresult == 100 && $i == 100){
								$arrResult['isMax'] = 'false';
								break;
							}
				
				        	foreach($element->getElementsByTagName('title') as $elementAttribute) 							$arrResult['result'][$key]['users'][$i]['title'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('workSite') as $elementAttribute) 						$arrResult['result'][$key]['users'][$i]['workSite'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('location') as $elementAttribute) 						$arrResult['result'][$key]['users'][$i]['location'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('name') as $elementAttribute) 							$arrResult['result'][$key]['users'][$i]['name'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('givenName') as $elementAttribute) 						$arrResult['result'][$key]['users'][$i]['givenName'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('maidenName') as $elementAttribute) 						$arrResult['result'][$key]['users'][$i]['maidenName'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('penName') as $elementAttribute) 						$arrResult['result'][$key]['users'][$i]['penName'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('initials') as $elementAttribute) 						$arrResult['result'][$key]['users'][$i]['initials'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('personalTitle') as $elementAttribute) 					$arrResult['result'][$key]['users'][$i]['personalTitle'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('photo') as $elementAttribute) 							$arrResult['result'][$key]['users'][$i]['photo'] = str_replace(' ', '', (str_replace('\n','',$elementAttribute->nodeValue)));
				        	foreach($element->getElementsByTagName('telephoneNumber') as $elementAttribute) 				$arrResult['result'][$key]['users'][$i]['telephoneNumber'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('mobile') as $elementAttribute) 							$arrResult['result'][$key]['users'][$i]['mobile'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('facsimileTelephonenumber') as $elementAttribute) 		$arrResult['result'][$key]['users'][$i]['facsimileTelephonenumber'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('mail') as $elementAttribute) 							$arrResult['result'][$key]['users'][$i]['mail'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('secretaryName') as $elementAttribute) 					$arrResult['result'][$key]['users'][$i]['secretaryName'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('secretaryPhone') as $elementAttribute) 					$arrResult['result'][$key]['users'][$i]['secretaryPhone'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('company') as $elementAttribute) 						$arrResult['result'][$key]['users'][$i]['company'] = $elementAttribute->nodeValue;
				        	foreach($element->getElementsByTagName('organizationalUnit') as $elementAttribute) 				$arrResult['result'][$key]['users'][$i]['organizationalUnit'] = $elementAttribute->nodeValue;
							foreach($element->getElementsByTagName('streetAddress') as $elementAttribute) 					$arrResult['result'][$key]['users'][$i]['streetAddress'] = $elementAttribute->nodeValue;
							foreach($element->getElementsByTagName('city') as $elementAttribute) 							$arrResult['result'][$key]['users'][$i]['city'] = $elementAttribute->nodeValue;
							foreach($element->getElementsByTagName('country') as $elementAttribute) 						$arrResult['result'][$key]['users'][$i]['country'] = $elementAttribute->nodeValue;
				        	
							if(strtolower($initAnnuaire['metier'][$company]['clicktocall']) == 'true')
								$arrResult['result'][$key]['users'][$i]['clicktocall'] = true;
							else
								$arrResult['result'][$key]['users'][$i]['clicktocall'] = false;
					
							$arrResult['result'][$key]['users'][$i] = MySOAP::saveData($key,$arrResult['result'][$key]['users'][$i]);
							$arrResult['sort'][$i] = $arrResult['result'][$key]['users'][$i]['name'];
				        	$i++;
								
							
				        }
			
						
					}
				}
				if($i == 20 || $i == 100){
				
					$arrResult['isMax'] = 'false';
					break;
				}
				unset($dom);
			}			
		}
		

    	
		
		return $arrResult;
    }
    
	/**
	 * Save collaborators data in order to use them for the favorite functionality
	 */
	public static function saveData($entreprise_search, $data){
		$db = eZDB::instance();
		
		$sql = "SELECT * FROM eby_annuaire WHERE 
							givenName = '".addslashes($data['givenName'])."' AND 
							name = '".addslashes($data['name'])."' AND 
							mail = '".$data['mail']."' AND 
							entreprise_search = '".$entreprise_search."'";

		$resArray = $db->arrayQuery( $sql );

		if(count($resArray) > 0){
			$arrReturn = array(); $i = 0;
		    foreach($resArray as $res) {
		    	//if($res['photo'] != $data['photo']){
		    		//Update the picture
		    		$sql2 = "UPDATE eby_annuaire SET 
		    			entreprise_search = '".addslashes($entreprise_search)."',
						title = '".addslashes($data['title'])."',
						workSite = '".addslashes($data['workSite'])."',
						location = '".addslashes($data['location'])."',
						name = '".addslashes($data['name'])."',
						givenName = '".addslashes($data['givenName'])."',
						maidenName = '".addslashes($data['maidenName'])."',
						penName = '".addslashes($data['penName'])."',
						initials = '".addslashes($data['initials'])."',
						personalTitle = '".addslashes($data['personalTitle'])."',
						photo = '".addslashes($data['photo'])."',
						telephoneNumber = '".addslashes($data['telephoneNumber'])."',
						mobile = '".addslashes($data['mobile'])."',
						facsimileTelephonenumber = '".addslashes($data['facsimileTelephonenumber'])."',
						mail = '".addslashes($data['mail'])."',
						secretaryName = '".addslashes($data['secretaryName'])."',
						secretaryPhone = '".addslashes($data['secretaryPhone'])."',
						company = '".addslashes($data['company'])."',
						organizationalUnit = '".addslashes($data['organizationalUnit'])."',
						streetAddress = '".addslashes($data['streetAddress'])."',
						city = '".addslashes($data['city'])."',
						country = '".addslashes($data['country'])."' 
						WHERE id = ".$res['id'];
					$db->query( $sql2 );
		    	//}
		    	$arrReturn = $data;
		    	$arrReturn['id'] = $res['id'];
		    }
		}else{
			$arrReturn = array();
			$sql2 = "INSERT INTO eby_annuaire (
									entreprise_search,
									title,
									workSite,
									location,
									name,
									givenName,
									maidenName,
									penName,
									initials,
									personalTitle,
									photo,
									telephoneNumber,
									mobile,
									facsimileTelephonenumber,
									mail,
									secretaryName,
									secretaryPhone,
									company,
									organizationalUnit,
									streetAddress,
									city,
									country
									) 
								VALUES ('".addslashes($entreprise_search)."',
									'".addslashes($data['title'])."',
									'".addslashes($data['workSite'])."',
									'".addslashes($data['location'])."',
									'".addslashes($data['name'])."',
									'".addslashes($data['givenName'])."',
									'".addslashes($data['maidenName'])."',
									'".addslashes($data['penName'])."',
									'".addslashes($data['initials'])."',
									'".addslashes($data['personalTitle'])."',
									'".addslashes($data['photo'])."',
									'".addslashes($data['telephoneNumber'])."',
									'".addslashes($data['mobile'])."',
									'".addslashes($data['facsimileTelephonenumber'])."',
									'".addslashes($data['mail'])."',
									'".addslashes($data['secretaryName'])."',
									'".addslashes($data['secretaryPhone'])."',
									'".addslashes($data['company'])."',
									'".addslashes($data['organizationalUnit'])."',
									'".addslashes($data['streetAddress'])."',
									'".addslashes($data['city'])."',
									'".addslashes($data['country'])."') ";
			
			
	    	$db->query( $sql2 );
	    	$arrReturn = $data;	    	
		    $arrReturn['id'] = $db->lastSerialID( 'eby_annuaire', 'id' );
	    	
		}
	    return $arrReturn;
		
	}
	
	/**
	 * Check if the current user is in galby or not and update the status
	 */
	static function isEmailGalbyError(){
		$db = eZDB::instance();
		$userId = eZUser::currentUserID();
		$oUser = eZContentObject::fetch($userId);
		$data_map = $oUser->attribute('data_map');
		$no_galby_sync = $data_map['no_galby_sync'];
		
		if($no_galby_sync->attribute('data_int') == 0){
		
			$sql = "SELECT * FROM eby_galby_error WHERE 
							user_id = ".$userId." AND etat = 0";

			$resArray = $db->arrayQuery( $sql );
			
			if(count($resArray) > 0)
				return true;
		}else{
			$sql = "SELECT * FROM eby_galby_error WHERE 
							user_id = ".$userId." AND etat = 0";

			$resArray = $db->arrayQuery( $sql );
			
			if(count($resArray) > 0){
			
				$sqlUpdate = "UPDATE eby_galby_error SET etat=1, date=NOW() WHERE user_id=".$userId;
				$resArray = $db->query( $sqlUpdate );
				
			}
		}
		
		return false;
	}
	
	/**
	 * Get all the email in error in Galby
	 */	
	static function getEmailGalbyError(){
		$db = eZDB::instance();
		$whoswho = new whoswho();
		
		$sql = "SELECT * FROM eby_galby_error WHERE etat = 0";
		$resArray = $db->arrayQuery( $sql );
		
		$arrReturn = array(); $i=0;
		foreach($resArray as $user){

			$oContentUser = eZContentObject::fetch($user['user_id']);			
			if($oContentUser){
			
				$dataMap = $oContentUser->attribute('data_map');
				
				$whoswhoShubscriptions = $whoswho->getSubscription($user['user_id']);
				$arrWhoswho = array(); $j=0;
				foreach($whoswhoShubscriptions as $whoswhoShubscription){
					$oContentWhoswho = eZContentObject::fetch($whoswhoShubscription['ww_id']);
					$arrWhoswho[$j] = $whoswhoShubscription;
					$arrWhoswho[$j]['name'] = $oContentWhoswho->attribute('name');
					$j++;
				}
				
				$arrReturn[$i] = $user;
				$arrReturn[$i]['first_name'] = $dataMap['first_name']->content();
				$arrReturn[$i]['last_name'] = $dataMap['last_name']->content();
				$arrReturn[$i]['whoswho'] = $arrWhoswho;
			}
			$i++;
		}
	
		return $arrReturn;
	}

	/**
	 * 
	 */
	static function isCTCActivated($domain){
		$initAnnuaire = self::getAnnuaireXml();
		$clicktocall = $initAnnuaire[$domain]['clicktocall'];
		if(is_null($clicktocall) || $clicktocall == 'False')
			return false;
			
		return true;
	}
}
?>