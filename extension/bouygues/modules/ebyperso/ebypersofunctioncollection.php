<?php

class ebypersoFunctionCollection
{
	var $widgets;
    var $userId;
    var $settingsINI;
    var $positionDefaut;
    var $widget_list;
    var $ini;
    
    protected $db;
    /*!
     Constructor
    */
    function __construct()
    {
		$this->db = eZDB::instance();
		$this->ini = eZINI::instance('bouygues.ini');
    }

    function bourse(){
    	
    	$cotations = array();
		$iniChemin = eZINI::instance('site.ini');

		$xmlURLBourse = $nbNewsMax=$this->ini->variable( 'WidgetBourse','URL');	
		
		if ((file_exists($iniChemin->variable('Instance', 'Chemin').$xmlURLBourse)) && $xmlContent = file_get_contents( $iniChemin->variable('Instance', 'Chemin').$xmlURLBourse )) {
			
			$dom = new DOMDocument();
			if(!$dom->loadXML( $xmlContent )) echo 'erreur load xml';
	
			
	
			$valeurs = $dom->getElementsByTagName('valeur');
			$cotationsTemp = array();
			foreach ( $valeurs as $val )
			{	
				$cotationsTemp[] = array('nom' => strtolower($val->getAttribute('nom')), 'cotation' => $val->getAttribute('cotation'));
				
			}
			$cotations[0] = $cotationsTemp[1];
			$cotations[1] = $cotationsTemp[2];
			$cotations[2] = $cotationsTemp[0];
			
		}
		
	    return array('result' => $cotations); 
	    
    }
}