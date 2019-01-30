<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebymeasearch.php" );

$Module = $Params["Module"];
$Result = array();
$tpl = templateInit();
$http = eZHTTPTool::instance();

$oMeasearch = new ebyMeaSearch();


if ( isset($Params['obj_id']) )
{
	
	$keywordList = $oMeasearch->getKeywordList($Params['obj_id']);
	$keywordListEn = $oMeasearch->getKeywordList($Params['obj_id'],'eng-US');
	
	$tpl->setVariable( 'keyword_list_en', $keywordListEn);
	$tpl->setVariable( 'keyword_list', $keywordList);
	$tpl->setVariable( 'object_id', $Params['obj_id'] );
	
}


if ( isset($Params['id']) )
{	
	$keyword = $oMeasearch->getKeyword($Params['id']);
	$tpl->setVariable( 'keyword', $keyword );
	
}


if ( $Module->isCurrentAction( 'UpdKeyWordButton' ) && $http->hasPostVariable( 'Id' ) ){
	
	if ( $http->hasPostVariable( 'KeyWord' ) && $http->postVariable( 'KeyWord' )!= '' && $http->postVariable( 'Id' )!= '')
	{
		if(!$oMeasearch->setKeyword($http->postVariable( 'Id' ), $http->postVariable( 'ObjectId' ), $http->postVariable( 'Langue' ), $http->postVariable( 'KeyWord' )))
		{
			eZDebug::writeDebug( "Erreur method setKeyword AddKeyWordButton", 'bouygues:mea-search/edit.php'); 
		}
		
		$keywordList = $oMeasearch->getKeywordList($http->postVariable( 'ObjectId' ));
		$keywordListEn = $oMeasearch->getKeywordList($http->postVariable( 'ObjectId' ),'eng-US');
		
		$tpl->setVariable( 'keyword_list_en', $keywordListEn);
		$tpl->setVariable( 'keyword_list', $keywordList);
		$tpl->setVariable( 'object_id', $http->postVariable( 'ObjectId' ) );
		
	}
		
}



if ( $Module->isCurrentAction( 'AddKeyWordButton' ) )
{
	if ( $http->hasPostVariable( 'KeyWord' ) && $http->postVariable( 'KeyWord' )!= '')
	{
		if(!$oMeasearch->setKeyword($id=null, $http->postVariable( 'ObjectId' ), $http->postVariable( 'Langue' ), $http->postVariable( 'KeyWord' )))
		{
			eZDebug::writeDebug( "Erreur method setKeyword AddKeyWordButton", 'bouygues:mea-search/edit.php'); 
		}
		
		$keywordList = $oMeasearch->getKeywordList($http->postVariable( 'ObjectId' ));
		$keywordListEn = $oMeasearch->getKeywordList($http->postVariable( 'ObjectId' ),'eng-US');
		
		$tpl->setVariable( 'keyword_list_en', $keywordListEn);
		$tpl->setVariable( 'keyword_list', $keywordList);
		$tpl->setVariable( 'object_id', $http->postVariable( 'ObjectId' ) );
		
	}	
}




if ( $Module->isCurrentAction( 'RemoveKeywordButton' )  )
{
			
	if ( $http->hasPostVariable( 'ActionIDArray' ))
	{
		$actionIDArray = $http->postVariable( 'ActionIDArray' );
		
		if(!$oMeasearch->delKeywordEntry($actionIDArray))
		{
			eZDebug::writeNotice( 'Erreur RemoveKeywordButton', 'bouygues:mea-search/edit.php'); 
		}
		if($http->hasPostVariable( 'ObjectId' ))
		{	
			if($oMeasearch->boolObjectExist($http->postVariable( 'ObjectId' ))){
				$keywordList = $oMeasearch->getKeywordList($http->postVariable( 'ObjectId' ));
				$keywordListEn = $oMeasearch->getKeywordList($http->postVariable( 'ObjectId' ),'eng-US');
		
				$tpl->setVariable( 'keyword_list_en', $keywordListEn);
				$tpl->setVariable( 'keyword_list', $keywordList);
				$tpl->setVariable( 'object_id', $http->postVariable( 'ObjectId' ) );
			}else{
				$Module->redirectTo( '/mea-search/list');
			}	
		
		}
		
	}
}




if ( $Module->isCurrentAction( 'SelectButton' ) )
{
        $selectedObjectIDArray = eZContentBrowse::result( 'AddRelatedSingleObject' );
       
        if ( is_array( $selectedObjectIDArray ) )
        {
        	foreach ( $selectedObjectIDArray as $selectedObjectID )
            {
            $keywordList = $oMeasearch->getKeywordList($selectedObjectID);
                if(count($keywordList)>0) $tpl->setVariable( 'keyword_lit', $keywordList );
                $tpl->setVariable( 'object_id', $selectedObjectID );
            }
           
        }

      
}


if ( $Module->isCurrentAction( 'BrowseForObject' ) )
{
       
	eZContentBrowse::browse( array( 'action_name' => 'AddRelatedSingleObject',
                                    'from_page' => $Module->redirectionURI( 'mea-search', 'edit' ) ),
                             $Module );
}





$Result['content'] = $tpl->fetch( "design:mea-search/edit.tpl" );
$Result['left_menu'] = 'design:mea-search/menu.tpl';
$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => 'MEA Search' ) );

