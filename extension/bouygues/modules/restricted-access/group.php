<?php

include_once( "kernel/common/template.php" );
include_once( "extension/bouygues/classes/ebyrestrictedarea.php" );


$Module = $Params["Module"];
$Result = array();
$tpl = templateInit();
$http = eZHTTPTool::instance();
$UserParameters = $Module->UserParameters;



$action='list';

$oRA = new ebyRestrictedArea();
$arrSectionAvailable = $oRA->arrSection;
$tpl->setVariable( 'arr_section', $arrSectionAvailable );

$oUsr = new ebyUserAccess();
$arrSection = $oUsr->getListSection();
$tpl->setVariable( 'arr_section', $arrSection );

if ( isset($Params['id']) )
{
	$action='edit';
	$groupData = $oRA->getGroupData($Params['id']);
	$groupUserList = $oRA->getGroupUserList($Params['id']);


	/* Tri sur nom ou prenom */
	$sortBy = isset($UserParameters['sort_by']) ? $UserParameters['sort_by'] : '';
	if(isset($sortBy) && in_array($sortBy , array('name_asc', 'name_desc', 'first_name_asc' , 'first_name_desc', 'email_asc' , 'email_desc') ) )
	{
		$orderedGroupList = array();
		foreach ($groupUserList as $userID)
		{
				$user = eZContentObject::fetch($userID, true);

				if(!is_object($user))
					continue;

				$datamap = $user->datamap();

				$first_name = strtolower($datamap['first_name']->content());
				$last_name = strtolower($datamap['last_name']->content());
				$email = strtolower($datamap['user_account']->content()->Email);
				
				if( in_array($sortBy , array('name_asc', 'name_desc')))
				{
					$orderedGroupList[$userID] = $last_name;
				}
				if( in_array($sortBy , array( 'first_name_asc' , 'first_name_desc')))
				{
					$orderedGroupList[$userID] = $first_name;
				}
				if( in_array($sortBy , array( 'email_asc' , 'email_desc')))
				{
					$orderedGroupList[$userID] = $email;
				}
		}

				if( in_array($sortBy , array('name_asc', 'first_name_asc', 'email_asc')))
				{
					asort($orderedGroupList);
				}
				if( in_array($sortBy , array( 'name_desc' , 'first_name_desc', 'email_desc')))
				{
					arsort($orderedGroupList);
				}

		$groupUserList = array_keys($orderedGroupList);
	}

	/* Fin du tri */


	$tpl->setVariable( 'user_list', $groupUserList );
	$tpl->setVariable( 'group_data', $groupData );
	$tpl->setVariable( 'group_id', $Params['id'] );

}


if ( $Module->isCurrentAction( 'ValiderButton' ) )
{
	$id = null;
	$section_id =  null;
	$action='edit';

	if ( $http->hasPostVariable( 'Id' ) && $http->postVariable( 'Id' )!= '' )
	{
		$id = $http->postVariable( 'Id' );
	}

	if ( $http->hasPostVariable( 'SectionId' ) && $http->postVariable( 'SectionId' )> 0 )
	{
		$section_id = $http->postVariable( 'SectionId' );
	}



	if ( $http->hasPostVariable( 'Group' ) && $http->postVariable( 'Group' )!= '')
	{
		$group_id = $oRA->setGroup($id, $http->postVariable( 'Group' ),$section_id);
		$groupUserList = $oRA->getGroupUserList($group_id);
		$groupData = $oRA->getGroupData($group_id);

		$tpl->setVariable( 'user_list', $groupUserList );
		$tpl->setVariable( 'group_data', $groupData );
		$tpl->setVariable( 'group_id', $group_id );
		$tpl->setVariable( 'section_id', $section_id );

	}

}


if ( $Module->isCurrentAction( 'CreateButton' ) )
{
	$action='edit';

}



if ( $Module->isCurrentAction( 'RemoveUserButton' ) )
{
	$action='edit';

	if ( $http->hasPostVariable( 'ActionIDArray' ) && $http->hasPostVariable( 'Id' ))
	{

		if(!$oRA->delGroupUser( $http->postVariable( 'Id' ), $http->postVariable( 'ActionIDArray' )))
		{
			eZDebug::writeNotice( 'Erreur RemoveUserButton', 'bouygues:restricted-access/group.php');
		}

	}

	$Module->redirectTo( '/restricted-access/group/'.$http->postVariable( 'Id' ));

}



if ( $Module->isCurrentAction( 'SelectButton' ) )
{
	$action='edit';

	$selectedUserIDArray = eZContentBrowse::result( 'AddRelatedMultipleUser' );

	if ( is_array( $selectedUserIDArray ) && isset($Params['id']))
    {
     	$oRA->setUserGroup($Params['id'], $selectedUserIDArray);

		$groupUserList = $oRA->getGroupUserList($Params['id']);
        $tpl->setVariable( 'user_list', $groupUserList );

    }


}


if ( $Module->isCurrentAction( 'BrowseForUsers' ) )
{

	eZContentBrowse::browse( array( 'action_name' => 'AddRelatedMultipleUser',
                                    'from_page' => $Module->redirectionURI( 'restricted-access', 'group' ,array( $http->postVariable( 'Id' ))) ),
                             $Module );
}


if ( $Module->isCurrentAction( 'RemoveButton' ) )
{
	$action='list';

	if ( $http->hasPostVariable( 'ActionIDArray' ) )
	{

		if(!$oRA->delGroup( $http->postVariable( 'ActionIDArray' )))
		{
			eZDebug::writeNotice( 'Erreur RemoveButton', 'bouygues:restricted-access/group.php');
		}

	}

	$Module->redirectTo( '/restricted-access/group/'.$http->postVariable( 'Id' ));

}

if($Params['id'])
{
	$groupData = $oRA->getGroupData($Params['id']);
	$tpl->setVariable( 'section_id', $groupData['section_id'] );
}

if($action=='list')
{
	$groupList = $oRA->getGroupList();
    $tpl->setVariable( 'group_list', $groupList );
}


if($action=='edit')
{
	$Result['content'] = $tpl->fetch( "design:restricted-access/group.tpl" );
}else{
	$Result['content'] = $tpl->fetch( "design:restricted-access/group_list.tpl" );
}

$Result['left_menu'] = 'design:restricted-access/menu.tpl';
$Result['path'] = array(
                        array(  'url'   => false,
                                'text'  => 'Gestion des restrictions d\'accès' ) );

