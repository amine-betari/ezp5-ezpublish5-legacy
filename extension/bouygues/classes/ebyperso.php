<?php

/**
 * API de gestion drag and drop
 *
 * @author J. Leger
 * @version $Id: ebyperso.php
 * @copyright (C) J. Leger 2009
 *
 */
include_once( "extension/bouygues/classes/ebycookie.php" );

class ebyPerso
{
   
    var $widgets;
    var $userId;
    var $settingsINI;
    var $positionDefaut;
    var $widget_list;
    var $ini;
    
    
    protected $db;
	
    
	public function __construct()
	{
		
		$this->userId = eZUser::currentUserID();
		$this->db = eZDB::instance();
		$this->ini = eZINI::instance('bouygues.ini');
		$this->settingsINI = $this->ini->variableArray( 'EbyPersoSettings','Widgets'); 
		
		$this->widgets = array();
		$this->widget_list = array();	
		$arrPos = array();
		foreach ($this->settingsINI as $key => $widget) {
			if($widget[1]=='enable'){

				//si actu
				if($widget[0] == 1){
					$filiere = $this->ini->variableArray( 'WidgetActu','Filiere');
					foreach ($filiere as $fil) {
						if($fil[1]=='enable'){
							$this->widgets['widget'.$fil[0]] = $this->getWidget('red', $fil[3], $fil[0], array('uri'=>$fil[2]));
							$arrPos[1][1]='widget'.$fil[0];
						}
					}
				}
				
				
				$booUserWidget = self::isUserWidget($this->userId, $widget[0]);
				
				if($booUserWidget)
					$this->widget_list[]= array($widget[0],$widget[4], 1);
				else
					$this->widget_list[]= array($widget[0],$widget[4], 0);
								
				$this->widgets['widget'.$widget[0]] = $this->getWidget('green', $widget[4], $widget[0]);
				$arrPos[$widget[2]][$widget[3]]='widget'.$widget[0];
				
			}
		}		
		
		$arr2 = array();
		foreach ($arrPos as $arr1) {
			$arr2[]= implode(',', $arr1);
		}		
		
		$this->positionDefaut = implode('|', $arr2);
		

	}
	
	public function getPosition(){
		$layoutDb = $this->getLayout($this->userId); 
		if(is_array($layoutDb) && count($layoutDb)>0){
			$position = '';
			$blo_col = $layoutDb[0]['bloc_col'];
			
			foreach ($layoutDb as $wid) {
				if($wid['bloc_col']!=$blo_col){
					$position.= '|';	
				}
				$position.='widget'.$wid['bloc_type'].',';
				$blo_col = $wid['bloc_col'];
				
			}						
		}else{
			
			$position = $this->positionDefaut;
			
		}
		
		return $position;
	}
	
	
	
	
	
	
	
	public function getColonne( $id ){
		
		$layoutDb = $this->getLayout($this->userId,$id); 
		$strColumn='';
		if(is_array($layoutDb) && count($layoutDb)>0){
			foreach ($layoutDb as $wid) {
				
				$strColumn.=  $this->widgets['widget'.$wid['bloc_type']] ;
			
			}
		}
		
		return $strColumn;		
	}
	
	
	public function getWidget($color, $title, $id, $param='')
	{
		$tpl = templateInit();
		
		$filiereINI = $this->ini->variableArray( 'WidgetActu','Filiere'); 
		$arrFiliereIni = array();
		$arrFiliereIni[]=1;
		foreach ($filiereINI as $filiereId)
		{
			$arrFiliereIni[]=$filiereId[0];
		}	
		
		$widgetContent='';
		$widget='';
		
		$sql = 'SELECT bloc_config FROM  eby_ebyperso 
						WHERE user_id = '.$this->userId.'
						AND bloc_type = '.$id;		
		$blocConfSer = $this->db->arrayQuery( $sql );
		if(count($blocConfSer)>0)
		{				
			$blocConfStr = unserialize($blocConfSer[0]['bloc_config']);		
			parse_str($blocConfStr);

			switch($id)
			{
			
			//RSS Actualités LCI

				case in_array($id,$arrFiliereIni): 
				
				
					$nbNewsInit=$this->ini->variable( 'WidgetActu','NbNewsInit');
					$nbNewsMax=$this->ini->variable( 'WidgetActu','NbNewsMax');
									
					if(isset($nbnews)&& $nbnews>0) $nbNewsInit=$nbnews;			

					if($id>=1){
						$nbnews = 'nbnews'.$id;
						$imgnews = 'imgnews'.$id;
						
						if($$nbnews > 0)
							$tpl->setVariable( 'nbnews', $$nbnews );
						else
							$tpl->setVariable( 'nbnews', $nbNewsInit );
						$tpl->setVariable( 'imgnews', $$imgnews );
						$tpl->setVariable( 'param', $param );	
	
					
					}else{					
						$tpl->setVariable( 'nbnews', '2' );		
						$tpl->setVariable( 'imgnews', '1' );
						$tpl->setVariable( 'param', $param );
					}				
	
					$tpl->setVariable( 'id', $id );
					$tpl->setVariable( 'title', $title );
					$tpl->setVariable( 'filiereINI', $filiereINI );
					$tpl->setVariable( 'nbNewsMax', $nbNewsMax );	
					$tpl->setVariable( 'nbNewsInit', $nbNewsInit );
					
		
					
					$section_id = 'ko';
					foreach($filiereINI as $key => $value){
						if($param['uri'] == $value[2]){
							$section_id = $key;
						
						}
					}
					
					
					// Get all RSS Exports
					$exportArray = eZRSSExport::fetchList();
					$exportList = array(); $arrSection = array(); $i = 0;
					foreach( $exportArray as $export )
					{
						$itemList = $export->attribute('item_list'); //source_node.object.section_id
						$sourceNode = $itemList[0]->attribute('source_node');
						$sourceObject = $sourceNode->attribute('object');
						$section_id2 = $sourceObject->attribute('section_id');
						if(!in_array($section_id2, $arrSection)){
							$arrSection[] = $section_id2;
					    	$exportList[$export->attribute( 'id' )] = $export;
					
							if($section_id == $section_id2)
								$currentRssNodes = self::getRssNode($export->attribute('access_url'));
						}
					}
				
					
					$tpl->setVariable( 'exportList', $exportList );	
					$tpl->setVariable( 'userId',  $this->userId );
		
					$tpl->setVariable( 'section_id', $section_id );
					$tpl->setVariable( 'currentRssNodes', $currentRssNodes );
					$tpl->setVariable( 'widgetList', $this->widget_list );
					$widget = $tpl->fetch( "design:ebyperso/widgets/widget_actu.tpl" );
					break;
				
					
				//widget Annuaire	
				case '2':
					$tpl->setVariable( 'id', $id );
					$tpl->setVariable( 'title', $title );
						
					$widget = $tpl->fetch( "design:ebyperso/widgets/widget_annuaire.tpl" );	
			 						        
					break;	
					
					
				//widget Bourse	
				case '3':
					$tpl->setVariable( 'id', $id );
					$tpl->setVariable( 'title', $title );
					
					$iniChemin = eZINI::instance('site.ini');
					
					$xmlURLBourse = $nbNewsMax=$this->ini->variable( 'WidgetBourse','URL');	
					$xmlFilename = $iniChemin->variable('Instance', 'Chemin').$xmlURLBourse;
					
					if (file_exists($xmlFilename)) {
					
						if ( !$xmlContent = file_get_contents($xmlFilename))
						{
							eZLog::write ( 'XML Bourse contenu non lisible', 'bouygues_ebyperso.log', 'var/log');	
						}				
					
						$dom = new DOMDocument();
						if(!$dom->loadXML( $xmlContent )) echo 'erreur load xml';			
						
		
						$valeurs = $dom->getElementsByTagName('valeur');
						$cotationsTemp = array(); $nom = '';
						foreach ( $valeurs as $val )
						{	
							if(strtolower($val->getAttribute('nom')) == 'tf1')
								$nom = strtoupper($val->getAttribute('nom'));
							else
								$nom = ucfirst(strtolower($val->getAttribute('nom')));
							$cotationsTemp[] = array('nom' => $nom, 'cotation' => $val->getAttribute('cotation'));
							
						}
		
						$cotations[0] = $cotationsTemp[1];
						$cotations[1] = $cotationsTemp[2];
						$cotations[2] = $cotationsTemp[0];
							
						$tpl->setVariable( 'cotations', $cotations );
										
						$widget = $tpl->fetch( "design:ebyperso/widgets/widget_bourse.tpl" );
						
					}
					else {
						$widget = '';
					}
			 						        
					break;	
					
					
					
				//widget Contact Favoris	
				case '4':
						include_once( "extension/bouygues/classes/annuaire.php");
						$annuaire = new annuaire();
						$tpl->setVariable( 'userFavorites', $annuaire->getFavorite() );
						$tpl->setVariable( 'id', $id );
						$tpl->setVariable( 'title', $title );
						
						if( isset($contacts) && count($contacts)>0 ){
		 				
						}
			 			
						$widget = $tpl->fetch( "design:ebyperso/widgets/widget_contacts_favoris.tpl" );
				        
					break;
					
					
				//widget Pages Consultées	
				case '5':
					$nbPagesVuesMax = $this->ini->variable( 'WidgetPagesVues','NbPagesVuesMax');
					$nbPagesVuesInit = $this->ini->variable( 'WidgetPagesVues','NbPagesVuesInit');
					
					$nbPagesVue = $nbPagesVuesInit;
					if( isset($nbpages) && $nbpages>0 ){
						$nbPagesVue = $nbpages;
					}
					
					$tpl->setVariable( 'id', $id );
					$tpl->setVariable( 'title', $title );
					$tpl->setVariable( 'nbPagesVuesMax', $nbPagesVuesMax );
					$tpl->setVariable( 'nbpages', $nbPagesVue );
					
						
					$widget = $tpl->fetch( "design:ebyperso/widgets/widget_pages_vues.tpl" );	
			 						        
					break;	
					
					
					
					
					
				//widget Meteo	
				case '6':
						
						$nbCityMax = $this->ini->variable( 'WidgetMeteo','NbCityMax');
						$listeVille = self::getAllVilleMeteo();
						
						try
				        {
				        	$arrVilles = array();
				        	
				        	if( isset($ville1) && !empty($ville1)) array_push($arrVilles,$ville1);
				        	if( isset($ville2) && !empty($ville2)) array_push($arrVilles,$ville2); 
							if( isset($ville3) && !empty($ville3)) array_push($arrVilles,$ville3);
				        	if( isset($ville4) && !empty($ville4)) array_push($arrVilles,$ville4);
							if( isset($ville5) && !empty($ville5)) array_push($arrVilles,$ville5);
				        	if( isset($ville6) && !empty($ville6)) array_push($arrVilles,$ville6);
				        	
				        	if( count($arrVilles)>0  )
				        	{
								$cpt = 0;
								$arrVillesSel = array();		        	
								
				        		foreach($arrVilles as $vil)
				        		{
				        			
				        			$arrVillesSel[$cpt] = $this->getWeatherCityData($vil, $listeVille[$vil]);
				        			$cpt++;
				        			
				        		}
				        	}
				        	
				        	$tpl->setVariable( 'id', $id );
							$tpl->setVariable( 'title', $title );
							
							$v = array();
							foreach ($listeVille as $id => $city) {
								$v[$id] = $city['city'];
							}
							
							$tpl->setVariable( 'liste_ville', $v );	
											
				        	if(isset($arrVillesSel))
								$tpl->setVariable( 'arrVillesSel', $arrVillesSel );
									
							$widget = $tpl->fetch( "design:ebyperso/widgets/widget_meteo.tpl" );
				        }
	
				        catch( Exception $e )
				        {
				            eZDebug::writeError( 'Unabled to parse feed : ' . $e->getMessage(), __METHOD__ );
				            return array( 'error' => array( 'error_type' => 'kernel',
				                                            'error_code' => eZError::KERNEL_NOT_AVAILABLE ) );
				        }
					break;
				
				
			 	}
			
		
			}
		
		
		return $widget;
	}
	
	
	

	public function setLayout( $myLayout ){
		$layoutDb = $this->getLayout($this->userId); 
		if(is_array($layoutDb) && count($layoutDb)>0){
			$this->deleteLayout ($this->userId);
		}	
		
		if($myLayout!=''){
			$sql = 'INSERT INTO eby_ebyperso (user_id,bloc_type,bloc_col,bloc_row,bloc_config) VALUE ';
			
			$columns = explode('|', $myLayout);
			$i=0;
			foreach ($columns as $col) {
				if($col!=''){
					$colx = $i+1;
				    $widgets = explode(',', $col);
				    
				    $j=0;
				    if(count($widgets)>0){		    	
					    foreach ($widgets as $wid) {
							$coly = $j+1;
					    	$bloc_type = substr($wid,6,strlen($wid));
					    	$bloc_config='';
					    	for($k=0;$k<count($layoutDb);$k++){
					    		if($layoutDb[$k]['bloc_type']==$bloc_type)
					    			$bloc_config = $layoutDb[$k]['bloc_config'];
					    	}
					    	$arrSql[]='('.$this->userId.','.$bloc_type.','.$colx.','.$coly.',\''.$bloc_config.'\')';
						    $j++;
						}
				    }		   	
				    $i++;
				}
			}
			$sql.= implode(',',$arrSql);							   
			
			$this->db->query($sql);
		}	
		
		return true;
		
	}
	
	protected function getLayout($user_id,$col=0)
	{
		
		$sql = 'SELECT * FROM  eby_ebyperso WHERE user_id = '.$user_id;
		
		if($col>0){
			$sql.= ' AND bloc_col='.$col;
		}
		
		$sql.= ' ORDER BY bloc_col, bloc_row';
		
		$aLayout = $this->db->arrayQuery($sql);
		
		return $aLayout;
	}
	
	protected function deleteLayout($user_id)
	{
		$sql = 'DELETE FROM  eby_ebyperso WHERE user_id = '.$user_id;
		$this->db->query($sql);
		
		return true;
	}
	
	public function setWidget( $id ){
		
		
		$sql = 'SELECT count(*) AS count FROM  eby_ebyperso 
				WHERE user_id = '.$this->userId.'
				AND bloc_type = '.$id;
		
		$countArray = $this->db->arrayQuery( $sql );
		
		$existWidget = isset( $countArray[0]['count'] ) ? $countArray[0]['count'] : 0;
		
		if($existWidget==0){
				$sql = 'SELECT MAX(bloc_row) as rowMax FROM  eby_ebyperso WHERE user_id = '.$this->userId.' AND bloc_col = 1 ';	
				
				$maxRowArr = $this->db->arrayQuery($sql);
				$bloc_row = $maxRowArr[0]['rowMax']+1;
				$sql = 'INSERT INTO eby_ebyperso SET 
							user_id = '.$this->userId.',
							bloc_type = '.$id.',
							bloc_col = 1,
							bloc_row= '.$bloc_row;	
				$this->db->query($sql);
			
				return true;
			
		}else{
			return false;
		}
		
		
	}
	
	
	public function updWidget( $id,$conf ){

		$bloc_config = $conf;
		parse_str($conf);
		
		if($id==1){
			$bloc_config = str_replace("filiere1", "filiere".$filiere1, $bloc_config);
			$bloc_config = str_replace("nbnews1", "nbnews".$filiere1, $bloc_config);
			$bloc_config = str_replace("imgnews1", "imgnews".$filiere1, $bloc_config);			
			
			$sql = 'UPDATE eby_ebyperso SET
							bloc_type = '.$filiere1.', 
							bloc_config = \''.serialize($bloc_config).'\'
					WHERE user_id = '.$this->userId.'
					AND bloc_type = '.$id;
			
		}else{
			$bloc_type = $id;
			$filiere = 'filiere'.$id;
			if((!empty($$filiere)) && $$filiere!=$id){
				$bloc_type = $$filiere;
				$bloc_config = str_replace("filiere".$id, "filiere".$$filiere, $bloc_config);
				$bloc_config = str_replace("nbnews".$id, "nbnews".$$filiere, $bloc_config);
				$bloc_config = str_replace("imgnews".$id, "imgnews".$$filiere, $bloc_config);		
			}	 
			
			$sql = 'UPDATE eby_ebyperso SET 
							bloc_config = \''.serialize($bloc_config).'\',
							bloc_type = '.$bloc_type.' 
					WHERE user_id = '.$this->userId.'
					AND bloc_type = '.$id;
		}
		$this->db->query($sql);
		
		return true;
		
		
	}
	
	public function getContact( $q ){
		if (!$q) return;
		
		 eZPersistentObject::fetchObject( eZUser::definition(),
                                               null,
                                                 array( 'LOWER( login )' => strtolower( $login ) ),
                                                 true );
		
	    $sql = "SELECT * FROM eby_weather WHERE city LIKE '%".$q."%'";
		$resArray = $this->db->arrayQuery( $sql );
		$retour='';
	    // Affichage des résultats en HTML
	    foreach($resArray as $res) {
	          $retour.= $res["city"]."|".trim($res["id"])."\n";
	    }
	    
	    if($retour=='')return;
	    return $retour; 
	    
	}
	
	public function getUserWidgets($user_id){

		$widgetIds = array();
		foreach($this->settingsINI as $ini){
			$widgetIds[] = $ini[0];
		}
		
		
		$sql = 'SELECT bloc_type FROM  eby_ebyperso WHERE user_id = '.$user_id;
		$arrWidget = $this->db->arrayQuery($sql);
		
		$arrReturn = array();
		foreach($arrWidget as $widget){
			if(in_array($widget['bloc_type'], $widgetIds))
				$arrReturn[] = $widget['bloc_type'];
		}
		
		
		return $arrReturn;
	}
	
	static function isUserWidget($user_id, $bloc_type){
		$db = eZDB::instance();
		
		if($bloc_type == 1){
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
			
			$countRss = count($exportList);
			$sql = "SELECT bloc_type FROM eby_ebyperso WHERE user_id = ".$user_id." AND bloc_type > 99 ";
			$recDb = $db->arrayQuery( $sql );

			if(count($recDb) >= $countRss)
				return true;
			else
				return false;
				
		}else{
	
			$sql = "SELECT bloc_type FROM eby_ebyperso WHERE user_id = ".$user_id." AND bloc_type = ".$bloc_type;
        	$recDb = $db->arrayQuery( $sql );
			if(count($recDb) > 0)
				return true;
			else
				return false;
				
		}
		
	}
	
	static function getRssNode($name){
		$RSSExport = eZRSSExport::fetchByName( $name );
	    $cond = array(
	                'rssexport_id'  => $RSSExport->ID,
	                'status'        => $RSSExport->Status
	                );
	
		if($RSSExport){
	    	$rssSources = eZRSSExportItem::fetchFilteredList( $cond );
	    	$nodeArray = eZRSSExportItem::fetchNodeList( $rssSources, $RSSExport->getObjectListFilter() );

	    	if ( is_array( $nodeArray ) && count( $nodeArray ) )
	    	{
				return $nodeArray;
	    	}
		}
	    return false;
	}
	
	/**
	 * Gestion du plugin météo
	 */
	public function getVilleMeteo() {
		$sql = "SELECT * FROM eby_weather ORDER BY city";
		$resArray = $this->db->arrayQuery( $sql );
		$arrRetour= array();
		foreach ($resArray as $res) {
			$arrRetour[trim($res["id"])] = $res["city"];
		}	
		return $arrRetour;
	}
	
	public function getAllVilleMeteo() {
		$sql = "SELECT * FROM eby_weather ORDER BY city";
		$resArray = $this->db->arrayQuery( $sql );
		$arrRetour= array();
		foreach ($resArray as $res) {
			$arrRetour[trim($res['id'])] = $res;
		}
		return $arrRetour;
	}
	
	/**
	 * Retourne les infos du flux météo & time zone pour l'heure
	 * 
	 * @param string $url
	 * @return DOMDocument
	 */
	public function getWeatherCityData($idcity, $city){
		
		$return = array();
		
		$return['id'] = $idcity;
		$return['nom'] = $city['city'];
		
		// Url pour la TZ (c'est moche, mais c'est le bordel)
		$cityurl = urlencode(mb_strtolower($city['city']));
		switch ($cityurl) {
			case 'bruxelles':
				$cityurl .= '+belgique';
				break;
			case 'berne':
				$cityurl .= '+suisse';
				break;
			case 'chypre':
				$cityurl = 'nicosia+cyprus';
				break;
			case 'londres':
				$cityurl = 'london,united+kingdom';
				break;
			case 'singapour':
				$cityurl = 'singapore,singapore';
				break;
			case 's%C3%A9oul':
				$cityurl = 'seoul,south+korea';
				break;
			case 'trinit%C3%A9-et-tobago':
				$cityurl = '10.66,-61.52';
				break;
		}
		$urlTz = $this->ini->variable('WidgetMeteo', 'UrlTz').$cityurl;
		
		$return['time'] = '';
		$return['now']['icon'] = '';
		$return['now']['text'] = '';
		$return['now']['high'] = 0;
		$return['now']['low'] = 0;
		$return['futur']['high'] = 0;
		$return['futur']['low'] = 0;
		$return['futur']['text'] = '';
		
		$code = array();
		$code[0] = 'tornado';
		$code[1] = 'tropical storm';
		$code[2] = 'hurricane';
		$code[3] = 'severe thunderstorms';
		$code[4] = 'thunderstorms';
		$code[5] = 'mixed rain and snow';
		$code[6] = 'mixed rain and sleet';
		$code[7] = 'mixed snow and sleet';
		$code[8] = 'freezing drizzle';
		$code[9] = 'drizzle';
		$code[10] = 'freezing rain';
		$code[11] = 'showers';
		$code[12] = 'showers';
		$code[13] = 'snow flurries';
		$code[14] = 'light snow showers';
		$code[15] = 'blowing snow';
		$code[16] = 'snow';
		$code[17] = 'hail';
		$code[18] = 'sleet';
		$code[19] = 'dust';
		$code[20] = 'foggy';
		$code[21] = 'haze';
		$code[22] = 'smoky';
		$code[23] = 'blustery';
		$code[24] = 'windy';
		$code[25] = 'cold';
		$code[26] = 'cloudy';
		$code[27] = 'mostly cloudy (night)';
		$code[28] = 'mostly cloudy (day)';
		$code[29] = 'partly cloudy (night)';
		$code[30] = 'partly cloudy (day)';
		$code[31] = 'clear (night)';
		$code[32] = 'sunny';
		$code[33] = 'fair (night)';
		$code[34] = 'fair (day)';
		$code[35] = 'mixed rain and hail';
		$code[36] = 'hot';
		$code[37] = 'isolated thunderstorms';
		$code[38] = 'scattered thunderstorms';
		$code[39] = 'scattered thunderstorms';
		$code[40] = 'scattered showers';
		$code[41] = 'heavy snow';
		$code[42] = 'scattered snow showers';
		$code[43] = 'heavy snow';
		$code[44] = 'partly cloudy';
		$code[45] = 'thundershowers';
		$code[46] = 'snow showers';;
		$code[47] = 'isolated thundershowers';
		$code[3200] = 'not available';
		
		// API Weather
		$weather = eZHTTPTool::getDataByURL($this->ini->variable('WidgetMeteo', 'UrlWeather').$city['woeid']);
		
		if ((preg_match('#<description><!\[CDATA\[(?:[^\]]*)([^\]]*)\]\]></description>#iU', $weather, $data)) && (preg_match_all('#(.*)<br />#iU', $data[1], $data))) {
			
			preg_match('#<img src="([^"]*)"/>#iU', $data[1][0], $subdata);
			$return['now']['icon'] = $subdata[1];
			
			preg_match('#^(.*) - (.*)\. High: ([0-9]*) Low: ([0-9]*)$#iU', $data[1][5], $subdata);
			$return['now']['high'] = $subdata[3];
			$return['now']['low'] = $subdata[4];
			
		}
		
		if (preg_match('#<yweather:condition.*code="([^"]*)".*/>#iU', $weather, $data)) {
			$return['now']['text'] = $code[$data[1]];
		}
		
		if (preg_match('#<yweather:forecast.*low="([^"]*)".*high="([^"]*)".*code="([^"]*)".*/>#iU', $weather, $data)) {
			$return['futur']['low'] = $data[1];
			$return['futur']['high'] = $data[2];
			$return['futur']['text'] = $code[$data[3]];
		}
		
		// API TimeZone (au format JSON)
		$tz = eZHTTPTool::getDataByURL($urlTz);
		$tz = json_decode($tz);
		$return['time'] = date('H:i'/* d/m/Y'*/, strtotime($tz->data->time_zone[0]->localtime));
		
		return $return;
	}
}
