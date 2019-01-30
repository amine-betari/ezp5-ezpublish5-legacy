<?php

include_once( 'kernel/common/template.php' );
include_once( 'extension/bouygues/classes/ebywhoswho.php' );
include_once( 'extension/bouygues/classes/ebyuseraccess.php');

$Module = $Params['Module'];
$Result = array();
$tpl = templateInit();
$http = eZHTTPTool::instance();
$db = eZDB::instance();

function searchUser($email, $lastname, $firstname, $count = false, $nbresults = 20, $offset = 0) {

	$query = '
	               SELECT
						';

	if ($count) {

		$query .= '
									COUNT(1) AS total
		           		';

	}
	else {

		$query .= '
									u.*,
									co.*,
									us.*
		           		';

	}


	$query .= '
	               FROM
	                 ezuser u
	               LEFT JOIN
	                 ezcontentobject co
	                 ON u.contentobject_id = co.id
	               LEFT JOIN
	                 ezuser_setting us
	                 ON u.contentobject_id = us.user_id
	               LEFT JOIN
	                 ezcontentclass_attribute cca
	                 ON co.contentclass_id = cca.contentclass_id AND cca.identifier IN (\'first_name\', \'last_name\')
	               LEFT JOIN
	                 ezcontentobject_attribute coa
	                 ON cca.id = coa.contentclassattribute_id AND coa.contentobject_id = u.contentobject_id AND coa.version = co.current_version
	               WHERE
			';

	$where = array();

	if (!empty($email)) {
		$where[] = 'u.email LIKE \'%'.$email.'%\'';
		$where[] = 'u.login LIKE \'%'.$email.'%\'';
	}

	if (!empty($lastname)) {
		$where[] = 'co.name LIKE \'%'.$lastname.'%\'';
		$where[] = 'coa.data_text LIKE \'%'.$lastname.'%\'';
	}

	if (!empty($firstname)) {
		$where[] = 'co.name LIKE \'%'.$firstname.'%\'';
		$where[] = 'coa.data_text LIKE \'%'.$firstname.'%\'';
	}


	$query .= implode(' OR ', $where);

	if (!$count) {

		$query .=	'
								 GROUP BY u.contentobject_id
								 ORDER BY u.email
	               -- LIMIT '.$nbresults.' OFFSET '.$offset.'
	               ';

	}

	return $GLOBALS['db']->arrayQuery( $query );

}

if ((!empty($_POST)) && (count($_POST) > 0)) {

  try {

    // Check the validity of the email adress in Galby
    // -> return if the email adress exist
    // -> return the last_name and the first_name
    if (!empty($_POST['GalbyButton'])) {

      $tpl->setVariable( 'email', $_POST['email'] );

      if (!eZMail::validate($_POST['email'])) {
        $tpl->setVariable( 'mailerror', 'L\'adresse mail est invalide, le format doit être de la forme : nom@host.ext' );
        throw new exception('');
      }

      $soap = new MySOAP();
      $r1 = ($soap->isGalbyEmailValid( $_POST['email'] ) === 'true');
      $r2 = ($r1?$soap->getContactByMailOnly( $_POST['email'] ):$r2=false);

      $tpl->setVariable( 'galby_r1', $r1 );
      $tpl->setVariable( 'galby_r2', $r2 );

    }
    elseif (!empty($_POST['SearchButton'])) {

    	$error = false;

      $tpl->setVariable( 'firstname', $_POST['firstname'] );
      $tpl->setVariable( 'lastname', $_POST['lastname'] );
      $tpl->setVariable( 'email', $_POST['email'] );

      if ((!empty($_POST['firstname'])) && (!preg_match('#[a-z]{3,}#siuU', $_POST['firstname']))) {
        $tpl->setVariable( 'firstnameerror', 'Le prénom doit faire 3 caractères ou plus' );
        $error = true;
      }

      if  ((!empty($_POST['lastname'])) && (!preg_match('#[a-z]{3,}#siuU', $_POST['lastname']))) {
      	$tpl->setVariable( 'lastnameerror', 'Le nom doit faire 3 caractères ou plus' );
      	$error = true;
      }

      if  ((!empty($_POST['email'])) && (!preg_match('#[a-z]{3,}#siuU', $_POST['email']))) {
      	$tpl->setVariable( 'mailerror', 'L\'adresse mail doit faire 3 caractères ou plus' );
      	$error = true;
      }

      if ($error) {
      	throw new exception('');
      }

      if (!((empty($_POST['firstname'])) && (empty($_POST['lastname'])) && (empty($_POST['email'])))) {

	      $count = searchUser($_POST['email'], $_POST['lastname'], $_POST['firstname'], true);
	      $count = $count[0]['total'];
	      $tpl->setVariable( 'count', $count );

	      if ($count <= 50) {

		      $rows = searchUser($_POST['email'], $_POST['lastname'], $_POST['firstname'], false);
		      $tpl->setVariable( 'rows', $rows );

	      }
	      else {
	      	$tpl->setVariable( 'rows', array() );
	      }
      }
    }
  }
  catch (exception $e) {
  }
}


if ((!empty($_GET)) && (count($_GET) > 0)) {
	if ((!empty($_GET['id'])) && (is_numeric($_GET['id']))) {

		// Bouton de suppression de la partie de vérification de l'utilisateur
		if (!empty($_GET['del'])) {
			switch ($_GET['del']) {

			  case 'whoswho':

			  	$query = 'DELETE FROM eby_ww_user WHERE user_id = '.$_GET['id'];
			  	$GLOBALS['db']->arrayQuery( $query );

			  	$query = 'DELETE FROM eby_ww_user_link WHERE user_id = '.$_GET['id'];
			  	$GLOBALS['db']->arrayQuery( $query );

			  	$tpl->setVariable( 'message', 'Les données Who\'s Who de l\'utilisateur ont été effacées.' );

			  	break;

			  case 'perso':

			  	$query = 'DELETE FROM eby_ebyperso WHERE user_id = '.$_GET['id'];
			  	$GLOBALS['db']->arrayQuery( $query );

			  	$query = 'DELETE FROM eby_favorite_user WHERE user_id = '.$_GET['id'];
			  	$GLOBALS['db']->arrayQuery( $query );

			  	$tpl->setVariable( 'message', 'Les données eby perso de l\'utilisateur ont été effacées.' );

			  	break;

			}
		}
		elseif (!empty($_GET['update'])) {
			switch ($_GET['update']) {

			  case 'syncgalby':

			  	$query = 'SELECT login FROM ezuser u WHERE contentobject_id = '.$_GET['id'];
			  	$datas = $db->arrayQuery( $query );

			  	$soap = new MySOAP();
			  	$r1 = ($soap->isGalbyEmailValid( $datas[0]['login'] ) === 'true');
			  	
			  	$query = 'DELETE FROM eby_galby_error WHERE user_id = '.$_GET['id'];
			  	$db->arrayQuery( $query );
			  	
			  	if (!$r1) {
			  	  $query = 'INSERT INTO eby_galby_error VALUE ('.$_GET['id'].',\''.$datas[0]['login'].'\',0,NOW())';
			  	  $db->arrayQuery( $query );
			  	}
			  	
			  	$tpl->setVariable( 'message', 'Les données de synchronisation Galby pour cet utilisateur ont été mise à jour.' );

			  	break;

			}
		}

		$tpl->setVariable( 'firstname', $_GET['firstname'] );
		$tpl->setVariable( 'lastname', $_GET['lastname'] );
		$tpl->setVariable( 'email', $_GET['email'] );

		$count = searchUser($_GET['email'], $_GET['lastname'], $_GET['firstname'], true);
		$count = $count[0]['total'];
		$rows = searchUser($_GET['email'], $_GET['lastname'], $_GET['firstname'], false);

		$tpl->setVariable( 'count', $count );
		$tpl->setVariable( 'rows', $rows );

		// Effectue les vérifications sur l'utilisateur

		$query = '
								SELECT
									*
								FROM
	                 ezuser u
	               LEFT JOIN
	                 ezcontentobject co
	                 ON u.contentobject_id = co.id
	               LEFT JOIN
	                 ezuser_setting us
	                 ON u.contentobject_id = us.user_id
	               LEFT JOIN
	                 ezcontentclass_attribute cca
	                 ON co.contentclass_id = cca.contentclass_id AND cca.identifier IN (\'first_name\', \'last_name\', \'no_galby_sync\')
	               LEFT JOIN
	                 ezcontentobject_attribute coa
	                 ON cca.id = coa.contentclassattribute_id AND coa.contentobject_id = u.contentobject_id AND coa.version = co.current_version
	               WHERE
									 u.contentobject_id = '.$_GET['id']
								;

			$datas = $db->arrayQuery( $query );

			foreach ($datas as $key => $data) {
				if ($data['identifier'] != 'no_galby_sync') {
					$datas[0][$data['identifier']] = $data['data_text'];
				}
				else {
					$datas[0][$data['identifier']] = (bool)$data['data_int'];
				}
			}

			$datas = $datas[0];

			$query = 'SELECT * FROM ezuser u LEFT JOIN ezcontentobject_version cov ON u.contentobject_id = cov.contentobject_id WHERE u.contentobject_id = '.$_GET['id'].' ORDER BY cov.version DESC';
			$versions = $db->arrayQuery( $query );

			$query = 'SELECT etat, date FROM eby_galby_error WHERE etat = 0 AND user_id = '.$_GET['id'].' AND email = \''.addslashes($datas['email']).'\'';
			$galbystate = $db->arrayQuery( $query );
			
			if (count($galbystate) == 0) {
			  
			  // L'utilisateur existait lors de la synchro
			  $galbystatus = true;
			  $galbydaysfrom = '';
			  $galbydaysleft = '';
			  
			}
			else {
			  
			  $galbystatus = false;
			  
			  $val = explode(" ",$galbystate[0]['date']);
			  $date = explode("-",$val[0]);
			  $time = explode(":",$val[1]);
			  $dateTimestamp = mktime($time[0],$time[1],$time[2],$date[1],$date[2],$date[0]);
			  $dateNow = time();
			  $nbjours = abs(round(($dateNow - $dateTimestamp)/(60*60*24)));
			  
			  $galbydaysfrom = $nbjours;
			  $galbydaysleft = 180 - $nbjours;
			  
			}
			
			$soap = new MySOAP();
			$r1 = ($soap->isGalbyEmailValid( $datas['login'] ) === 'true');
			$r2 = (($r1 == 'true')?$soap->getContactByMailOnly( $datas['login'] ):$r2=false);

			$tpl->setVariable( 'data', $datas );
			$tpl->setVariable( 'versions', $versions );
			$tpl->setVariable( 'datagalbyr1', $r1 );
			$tpl->setVariable( 'datagalbyr2', $r2 );
			$tpl->setVariable( 'galbystatus', $galbystatus );
			$tpl->setVariable( 'galbydaysfrom', $galbydaysfrom );
			$tpl->setVariable( 'galbydaysleft', $galbydaysleft );

	}
}

// Menu data for Whos Who stats
include_once( 'extension/bouygues/modules/whoswho/menu.inc.php' );

$Result['content']   = $tpl->fetch( 'design:whoswho/usercheck.tpl' );
$Result['left_menu'] = 'design:whoswho/menu.tpl';
$Result['path']      = array(array('url' => false, 'text' => 'Whos Who vérification utilisateur'));