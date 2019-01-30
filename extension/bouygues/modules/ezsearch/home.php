<?php
include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebymeasearch.php" );

include_once( "extension/bouygues/classes/ebywhoswho.php" );

$http = eZHTTPTool::instance();
$Module = $Params['Module'];
$tpl = templateInit();

/*$tpl->setVariable( 'widget_list', $widgetList );*/

if($http->hasGetVariable( 'search' )){
	
	$param['terms'] = 			(strlen($http->getVariable( 'terms' )) > 0)?$http->getVariable( 'terms' ):null;
	$param['class_id'] = 		$http->getVariable( 'class_id' );
	$param['beginDate'] = 		(strlen($http->getVariable( 'beginDate' )) > 0)?explode("/",$http->getVariable( 'beginDate' )):false;
	$param['endDate'] = 		(strlen($http->getVariable( 'endDate' )) > 0)?explode("/",$http->getVariable( 'endDate' )):false;
	$param['pg'] = 				$http->getVariable( 'pg' );
	$param['section_id'] = 		($http->getVariable( 'section_id' )=='')?null:$http->getVariable( 'section_id' );

	if(!is_null($param['terms'])){
	
		$limit = 10;
		$offset = ($param['pg']-1)*$limit;
		
		$filter[0] = array('OR', 
			'section_id:7', 
			'section_id:6', 
			'section_id:8', 
			'section_id:9', 
			'section_id:10', 
			'section_id:11', 
			'section_id:15', 
			'section_id:12', 
			'section_id:13', 
			'section_id:14', 
			'section_id:16');
		
		if($param['beginDate'] && !$param['endDate']){
			$dateBegin = date('c', mktime(0,0,0, $param['beginDate'][1], $param['beginDate'][0], $param['beginDate'][2]) );
			$filter[1] = array('published:['.$dateBegin.'Z TO *]');
		}elseif($param['endDate'] && !$param['beginDate']){
			$dateEnd = date('c', mktime(0,0,0, $param['endDate'][1], $param['endDate'][0], $param['endDate'][2]) );
			$filter[1] = array('published:[* TO '.$dateEnd.'Z]');
		}elseif($param['endDate'] && $param['beginDate']){
			$dateEnd = date('c', mktime(0,0,0, $param['endDate'][1], $param['endDate'][0], $param['endDate'][2]) );
			$dateBegin = date('c', mktime(0,0,0, $param['beginDate'][1], $param['beginDate'][0], $param['beginDate'][2]) );
			$filter[1] = array('published:['.$dateBegin.'Z TO '.$dateEnd.'Z]');
		}
		
		$filterFacet = $filter;
		
		if(count($param['section_id']) > 0){
    	
			unset($filter[0]);
			$filter[0][0] = 'OR';
			foreach($param['section_id'] as $section_id){
				$filter[0][] = 'section_id:'.$section_id;
				unset($section_id);
			}
    	
		}
			
    	
		
		if($param['class_id'] == '')
			$classArray = array(
					'article',
					'bouygues_dossier',
					'bouygues_diapo',
					'bouygues_diapo_image',
					'bouygues_element_liste',
					'bouygues_galerie_vid',
					'bouygues_video',
					'bouygues_mini_site',
					/*'newsletter_issue',*/
					'bouygues_liste',
					'bouygues_page_sessions',
					'bouygues_session',
					'bouygues_session_element',
					'bouygues_liste_thema',
					'bouygues_prestataire',
					'bouygues_prestataire_projet',
					'link',
					'file',
					'user',
					'bouygues_master_page');
		elseif($param['class_id'] == 'file'){
			$classArray = array('file');
		}elseif($param['class_id'] == 'diaporama'){
			$classArray = array('bouygues_diapo', 'bouygues_diapo_image');
		}elseif($param['class_id']){
			$classArray = array('bouygues_video', 'bouygues_galerie_vid');
		}
			
		$solrSearch = new eZSolr();
    	
    	
		//FACET OPTIONS
		$params = array( 'SearchType' => 'fulltext', 
						'SearchOffset' => $offset,
    	                 'SearchLimit' => $limit,
						 'SearchContentClassID' => $classArray,
						 'Filter' => $filterFacet,
    	                 'Limitation' => array(),
						 'Facet' => array( 
										array( 'query' => 'section_id:7' ),
										array( 'query' => 'section_id:6' ),
										array( 'query' => 'section_id:8' ),
										array( 'query' => 'section_id:9' ),
										array( 'query' => 'section_id:10' ),
										array( 'query' => 'section_id:11' ),
										array( 'query' => 'section_id:15' ),
										array( 'query' => 'section_id:12' ),
										array( 'query' => 'section_id:13' ),
										array( 'query' => 'section_id:14' ),
										array( 'query' => 'section_id:16' )) );
    	
		$resultFacet = eZSearch::search( $param['terms'], $params );
    	
		//REAL SEARCH
		$params = array( 'SearchType' => 'fulltext', 
						'SearchOffset' => $offset,
    	                 'SearchLimit' => $limit,
						 'SearchContentClassID' => $classArray,
						 'Filter' => $filter,
    	                 'Limitation' => array() );
   		$result = eZSearch::search( $param['terms'], $params );
    	
		//Look for mea search words
		$viewParameters = array();
    	$searchQuery = htmlspecialchars( $param['terms'], ENT_QUOTES );
    	// Pass the search query on to the template, search will occur there.
    	$viewParameters = array_merge( $viewParameters, array( 'search_query' => $searchQuery ) );
		$viewParameters = array_merge( $viewParameters, array( 'language' => htmlspecialchars( eZLocale::instance()->localeFullCode(), ENT_QUOTES ) ) );
		
		$tpl->setVariable( 'viewParameters', $viewParameters );
   		$tpl->setVariable('results', $result);
		$tpl->setVariable('resultsFacet', $resultFacet);
		$tpl->setVariable('terms', $param['terms']);
		$tpl->setVariable('class_id', $param['class_id']);
		$tpl->setVariable('beginDate', $http->getVariable( 'beginDate' ));
		$tpl->setVariable('endDate', $http->getVariable( 'endDate' ));
		$tpl->setVariable('section_id', $param['section_id']);
		$tpl->setVariable('offset', $offset);
		$tpl->setVariable('pg', $param['pg']);
		$tpl->setVariable('search', $param['search']);
	}
}

$searchTitle = '';
if($param['terms'] != '')
	$searchTitle = " / ".$param['terms']." - ".$param['pg'];

$Result = array();
$Result['content'] = $tpl->fetch( "design:search/home.tpl" );
$Result['path'] = array( 
			array( 'url' => false, 'text' => ezpI18n::tr( 'design/bouygues/metadata', 'metadata_search' ).$searchTitle)
);