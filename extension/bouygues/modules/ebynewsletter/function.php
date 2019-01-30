<?php

include_once( "kernel/common/template.php" );

$module = $Params["Module"];
$result = array();
$tpl = templateInit();
$http = eZHTTPTool::instance();
$hostname = eZSys::serverURL();

function getImageData($path) {

    preg_match('#^https?://[^/]*/(.*)#', $path, $pathInfo);
    $path = $pathInfo[1];

    if (preg_match('#var/#', $path)) {
        
        $db = eZDB::instance();
        $path = mysql_real_escape_string($path);
        
        $sql = "SELECT filedata, offset FROM ezdbfile_data WHERE name_hash = MD5('$path') ORDER BY offset";
        $res = $db->query($sql);
        
        $return = '';
        while ( $row = mysql_fetch_row( $res ) )
            $return .= $row[0];
        
        mysql_free_result($res);
        
    }
    else {

        $return = file_get_contents(eZSys::rootDir().'/'.$path);
        
    }
    
    return $return;
    
}

$sendMailSettings = eZINI::instance( 'ezsendmailsettings.ini' );
$replaceMsgIDHost = $sendMailSettings->variable( 'SendNewsletter', 'ReplaceMessageIDHost' );
$newSendHost = $sendMailSettings->variable( 'SendNewsletter', 'Host' );
$hostSettings['replace'] = $replaceMsgIDHost;
$hostSettings['host'] = $newSendHost;

if ((empty($Params['newsletterid'])) || (!is_numeric($Params['newsletterid']))) {
    header('Location: /newsletter/');
    die();
}

/**
 * Crée une archive avec la newsletter & ses images
 * et demande a l'utilisateur de le télécharger
 */
$newsletter_id = $Params['newsletterid'];

$newsletter = eZNewsletter::fetch($newsletter_id, eZNewsletter::StatusPublished);

if (empty($newsletter)) {
    header('Location: /newsletter/');
    die();
}

$newsletter_parts = $newsletter->generateNewsletter( eZNewsletter::OutputFormatHTML );
$body = $newsletter_parts['body'];
preg_match_all('#<img[^>]*src="([^"]*)"[^>]*>#iU', $body, $matches);
$images = array_unique($matches[1]);

// Génère l'archive ZIP
$zip = new ZipArchive();
$zipfilename = sys_get_temp_dir().'/zip-newsletter-'.mt_rand(0, 999999999);
if ($zip->open($zipfilename, ZipArchive::CREATE) !== true) {
    throw new Exception('Impossible de créer l\'archive');
}

// Ajoute toutes les images & corrige les URL
$zip->addEmptyDir('images/');
foreach ($images as $image) {
    
    $image_name = explode('/', $image);
    $image_name = $image_name[count($image_name) - 2].'-'.$image_name[count($image_name) - 1];
    
    $zip->addFromString('images/'.$image_name, getImageData($image));
    
    $body = preg_replace('#'.$image.'#i', './images/'.$image_name, $body);
    
}

// Fixe le HTML et l'ajoute a l'archive
$body = preg_replace('#charset=windows-1250#i', 'charset=utf-8', $body);

$zip->addFromString($newsletter_parts['subject'].'.html', trim($body));
$zip->close();

$display_name = str_replace('.', '', $newsletter_parts['subject']);
header('Content-Description: File Transfer');
header('Content-Type: application/zip');
header('Content-Transfer-Encoding: none');
header('Expires: 0');
header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
header('Pragma: public');
header('Content-Disposition: attachment; filename="'.$display_name.'.zip'.'"');
header('Content-Length: '.filesize($zipfilename));

readfile($zipfilename);

eZExecution::cleanExit();
