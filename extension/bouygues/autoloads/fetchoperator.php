<?php
class FetchOperator
{
    function FetchOperator()
    {
        $this->Operators= array( 'fetchclasses','fetchmenu');
        $this->Debug = false;
    }

    function operatorList()
    {
        return $this->Operators;
    }

    function namedParameterPerOperator()
    {
        return true;
    }

    function namedParameterList()
    {
        return array(
        	'fetchmenu' => array(
	            'params' => array(
	                'type' => 'array',
	                'required' => true
	             ),
	         ),
        	
			'fetchclasses' => array(
	        	'classes' => array(
	                'type' => 'array',
	                'required' => true
	             ),
	             'parent_node_id' => array(
	                'type' => 'int',
	                'required' => true,
	             	'default' => 2
	             ),
	             'limit' => array(
	             	'type' => 'int',
	             	'required' => false,
	             	'default' => 0
	             ),
	             'depth' => array(
	             	'type' => 'int',
	             	'required' => false,
	             	'default' => 1
	             ),
	           	  'offset' => array(
	             	'type' => 'int',
	             	'required' => false,
	             	'default' => 0
	             ),
	             'sort' => array(
	             	'type' => 'int',
	             	'required' => false,
	             	'default' => 0
	             )
	         )   
        );
    }

    function modify( $tpl, $operatorName, $operatorParameters, $rootNamespace, $currentNamespace, &$operatorValue, $namedParameters )
    {
        switch ( $operatorName )
        {
            case 'fetchclasses':
            {
            	
                $operatorValue = $this->fetchClasses($namedParameters);
                
            }
         	 break;
            case 'fetchmenu':
            {
            	
                $operatorValue = $this->fetchMenu($namedParameters);
              
            }
             break;
            
        }
    }
	
    function fetchMenu($namedParameters){
    	
    	
    		$arrConditions = array(
		    		'ClassFilterType' => $namedParameters['params']['ClassFilterType'],
		    		'ClassFilterArray' => $namedParameters['params']['ClassFilterArray'],
    				'AttributeFilter' => $namedParameters['params']['AttributeFilter'],
		    		'Depth' => $namedParameters['params']['Depth'],
		    		'SortBy' => $namedParameters['params']['SortBy']
		    	);
    			
		    	echo '---------PARAMS---------'.'<br />';;
		    	echo '1 : '.$namedParameters['params']['parent_node_id'].'<br />';
		    	echo '2 : '.$namedParameters['params']['Depth'].'<br />';
		    	echo '3 : '.$namedParameters['params']['ClassFilterType'].'<br />';
		    	echo '4 : '.$namedParameters['params']['ClassFilterArray'].'<br />';
		    	echo '5 : '.$namedParameters['params']['AttributeFilter'].'<br />';
		    	echo '6 : '.$namedParameters['params']['SortBy'].'<br />';
	
    	$nodes = eZContentObjectTreeNode::subTreeByNodeID($arrConditions, $namedParameters['params']['parent_node_id']);
    	
    	$result = array(); $resultTemp = array();  	
    	if(count($nodes)>0){
	    	foreach($nodes as $node){
	    		
	    		$object = $node->attribute('object');
	    		$urlAlias = $node->attribute('url_alias');
	    		$dataMap = $node->attribute('data_map');
	    		
	    		$id = $node->PathIdentificationString;
				$keys = explode('/', $id);
				
				$keysNumber = count($keys);
				
				$i=1;
				$level1 = $level2 = $level3 = $level4 = $level5 = $level6 = '';
				foreach($keys as $key){
					
					/*print_r($resultTemp);
					echo '---------<br />';*/
					if ($i == 1)		$level1 = $key;
					elseif ($i == 2)	$level2 = $key;
					elseif ($i == 3)	$level3 = $key;
					elseif ($i == 4)	$level4 = $key;
					elseif ($i == 5)	$level5 = $key;
					elseif ($i == 6)	$level6 = $key;
					
					
					if($keysNumber == $i){
						
						$arrInfo = array('id'=>$node->PathIdentificationString);
						
						if ($i == 1)		$resultTemp[$level1] = $arrInfo;
						elseif ($i == 2)	$resultTemp[$level1][$level2] = $arrInfo;
						elseif ($i == 3)	$resultTemp[$level1][$level2][$level3] = $arrInfo;
						elseif ($i == 4)	$resultTemp[$level1][$level2][$level3][$level4] = $arrInfo;
						elseif ($i == 5)	$resultTemp[$level1][$level2][$level3][$level4][$level5] = $arrInfo;
						elseif ($i == 6)	$resultTemp[$level1][$level2][$level3][$level4][$level5][$level6] = $arrInfo;
						
						//$resultTemp[$key] = array($key=>array('id'=>$node->PathIdentificationString));
						
						/*$resultTemp[$key]['depth'] = $node->Depth;
				    	$resultTemp[$key]['name'] = $node->Name;
				    	$resultTemp[$key]['url'] = $urlAlias;
				    	$resultTemp[$key]['id'] = $node->PathIdentificationString;
				    		
				    	if(is_object($dataMap['menu_cb'])){
				    		$resultTemp[$key]['menu_cb'] =  $dataMap['menu_cb']->Content;
				    	}else{	
				    		$resultTemp[$key]['menu_cb'] = 0;
				    	}
				    	*/
				    	//$result = $resultTemp;

				   		
					}
					
					//$resultTemp &= array($key=>'');
					
				
				
			    	$i++;
				}
				
				

	    	}
    	}
    	
    	
    	
    				echo '<pre>';
	    		print_r($resultTemp);
	    		echo '</pre>';	
    	
    	return $result;
    	
    }
    
    function fetchClasses($namedParameters)
    {
	/*	
    {def $datas = fetch( 'content', 'list',hash( 'parent_node_id', 6900,
            								'class_filter_type', 'include',
            								'class_filter_array', array('article', 'bouygues_dossier', 'bouygues_diapo', 'bouygues_element_liste', 'bouygues_galerie_vid', 'bouygues_video', 'bouygues_mini_site', 'file'),
            								'limit', $maxItems,
            								'depth', $depth,
            								'sort_by',array($tri, false()) ))}
    	*/
    	
    	$arrResultsTmp = array(); $i = 0;
    	
    	foreach($namedParameters['classes'] as $class){
    		
    		
    		if($class['sort_by'] != '')
	    		$arrConditions = array(
		    		'ClassFilterType' => 'include',
		    		'ClassFilterArray' => array($class['name']),
		    		'Depth' => $namedParameters['depth'],
		    		'SortBy' => array('attribute', $class['sort_type'], $class['name'].'/'.$class['sort_by'] )
		    	);
		    else
		    	$arrConditions = array(
		    		'ClassFilterType' => 'include',
		    		'ClassFilterArray' => array($class['name']),
		    		'Depth' => $namedParameters['depth'],
		    		'SortBy' => array($class['type'], $class['sort_type'] )
		    	);
	    	
	    	$nodes = eZContentObjectTreeNode::subTreeByNodeID($arrConditions, $namedParameters['parent_node_id']);
	    	if(count($nodes) > 0)
		    	foreach($nodes as $node){

		    		$object = $node->attribute('object');
		    		$data_map = $object->attribute('data_map');
	
		    		if($class['sort_by'] == 'date_pub') 
		    			$sortby = $data_map['date_pub']->attribute('data_int');
		    		elseif($class['type'] == 'published') 
		    			$sortby = $object->Published;
		    		elseif($class['type'] == 'modified') 
		    			$sortby = $object->Modified;
		    		elseif($class['type'] == 'name')
		    			$sortby = self::cleanChar($object->Name);
		    		elseif($class['type'] == 'priority') 
		    			$sortby = $node->Priority;
		    				    		
		    		$arrSortby[$i] = $sortby;
		 
			    	$arrResultsTmp[$i]['sort_by'] = $sortby;
			    	$arrResultsTmp[$i]['sort_by_attibute'] = $class['sort_by'];
			    	$arrResultsTmp[$i]['sort_by_type'] = $class['type'];
			    	$arrResultsTmp[$i]['sort_by_class'] = $class['name'];
		    		$arrResultsTmp[$i]['node'] = $node;
			    	$i++;	
		    	}
    	}

		if ($namedParameters['sort']){
    		array_multisort($arrSortby, SORT_ASC, $arrResultsTmp);
		}else{
			array_multisort($arrSortby, SORT_DESC, $arrResultsTmp);
		}
		
    	$arrResults = array(); 
    	
    	if($namedParameters['offset']>0){
    			
    		
    		$i = 0; $j = 0;
	    	foreach($arrResultsTmp as $arr){
				if($j >= $namedParameters['offset']){
	    			if($i < $namedParameters['limit'])
		    			$arrResults[$i++] = $arr['node'];
		    		else
		    			break;
				}
				$j++;
	    	}
    		
    		
    		/*$i = $namedParameters['offset'];
    		$offset = ($namedParameters['limit']+$namedParameters['offset']);
    		
    		foreach($arrResultsTmp as $arr){
				if($i < $offset && $i < count($arrResultsTmp))
	    			$arrResults[$i++] = $arr['node'];
	    		else
	    			break;
	    	}*/
    	}else{
    		$i = 0;
	    	foreach($arrResultsTmp as $arr){
	    		if($namedParameters['limit'] > 0)
					if($i < $namedParameters['limit'])
		    			$arrResults[$i++] = $arr['node'];
		    		else
		    			break;
				else
					$arrResults[$i++] = $arr['node'];
	    	}
    	}
    	
    	
      	return $arrResults;
    }
    
    static function cleanChar($str){
    	$str = str_replace('î', 'i', $str);
    	$str = str_replace('Î', 'I', $str);
    	$str = str_replace('é', 'e', $str);
    	$str = str_replace('É', 'E', $str);
    	$str = str_replace('È', 'E', $str);
    	$str = str_replace('è', 'e', $str);
    	$str = str_replace('à', 'a', $str);
    	$str = str_replace('À', 'A', $str);
    	$str = str_replace('ô', 'o', $str);
    	$str = str_replace('Ô', 'o', $str);
    	
    	return $str;
    }

    var $Operators;
    var $Debug;

}

?>
