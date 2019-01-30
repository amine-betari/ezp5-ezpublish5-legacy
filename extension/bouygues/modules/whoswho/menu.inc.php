<?php
//affichage valeur du menu 

$oUsrMenu = new ebyUserAccess();
$arrWwMenu = $oUsrMenu->getListWw();
$arrSection = $oUsrMenu->getListSection();
$tpl->setVariable( 'arr_section', $arrSection );

$itemCountPending = ebyWhoswho::getWwUsersList(ebyWhoswho::WW_USER_STATUS_PENDING,$arrWwMenu,$arrPagination=null,$total='count');
$itemCountAccepted = ebyWhoswho::getWwUsersList(ebyWhoswho::WW_USER_STATUS_ACCEPTED,$arrWwMenu,$arrPagination=null,$total='count');
$messages_count = ebyWhoswho::getWwEmailCount();

$tpl->setVariable( 'item_count_pending', $itemCountPending );
$tpl->setVariable( 'item_count_accepted', $itemCountAccepted );
$tpl->setVariable( 'messages_count', $messages_count );