<?php
/**
 * File containing the updateviewcount_bylink.php cronjob
 *
 */

set_time_limit( 0 );
$cli->output( "Update content view count..."  );

$dt = new eZDateTime();
$startTime = $dt->day() . "/" . date( 'M', time() ) . "/" . $dt->year() . ":" . $dt->hour() . ":" . $dt->minute() . ":" . $dt->second();

$cli->output( "Started at " . $dt->toString() . "\n"  );

eZDB::instance()->setIsSQLOutputEnabled( false );

$startLine = "";
$hasStartLine = false;

$updateViewLogPath = eZSys::instance()->varDirectory() . "/" . eZINI::instance()->variable( 'FileSettings', 'LogDir' ) . "/updateview.log";
if ( is_file( $updateViewLogPath ) )
{
    $fh = fopen( $updateViewLogPath, "r" );
    if ( $fh )
    {
        while ( !feof ( $fh ) )
        {
            $line = fgets( $fh, 1024 );
            if ( preg_match( "/\[/", $line ) )
            {
                $startLine = $line;
                $hasStartLine = true;
            }
        }
        fclose( $fh );
    }
}

$cli->output( "Start line:\n" . $startLine );
$lastLine = "";
$logFileIni = eZINI::instance( 'logfile.ini' );
$logFilePath = $logFileIni->variable( 'AccessLogFileSettings', 'StorageDir' ) . '/' . $logFileIni->variable( 'AccessLogFileSettings', 'LogFileName' );
$prefixes = $logFileIni->variable( 'AccessLogFileSettings', 'SitePrefix' );
$pathPrefixes = $logFileIni->variable( 'AccessLogFileSettings', 'PathPrefix' );
$pathPrefixesCount = count( $pathPrefixes );

$nodeIDHashCounter = array();
$pathHashCounter = array();
$contentHash = array();
$nonContentHash = array();

if ( is_file( $logFilePath ) )
{
    $handle = fopen( $logFilePath, "r" );
    if ( $handle )
    {
        $startParse = false;
        $stopParse = false;
        while ( !feof ($handle) and !$stopParse )
        {
            $line = fgets($handle, 1024);
            if ( empty( $line ) )
            {
                continue;
            }

            if ( $line != "" )
                $lastLine = $line;

            if ( $startParse or !$hasStartLine )
            {
                $logPartArray = preg_split( "/[\"]+/", $line );
                list( $ip, $timePart ) = explode( '[', $logPartArray[0] );
                list( $time, $rest ) = explode( ' ', $timePart );

                if ( $time == $startTime )
                    $stopParse = true;

                list( $requireMethod, $url ) = explode( ' ', $logPartArray[1] );

                $posPictoTracking =strpos( $url, 'picto_onepx.jpg?node_id=' );

                if ( $posPictoTracking !== false )
                {
                    $urlSplit = explode('picto_onepx.jpg?node_id=',$url);
                    $nodeID = $urlSplit[1];

                    if ( $nodeID )
                    {
                        if ( !isset( $nodeIDHashCounter[$nodeID] ) )
                        {
                            $nodeIDHashCounter[$nodeID] = 1;
                        }
                        else
                        {
                            $nodeIDHashCounter[$nodeID] += 1;
                        }
                    }
                }
            }
            if ( $line == $startLine )
            {
                $startParse = true;
            }
        }
        fclose( $handle );
    }
    else
    {
        $cli->output( "Warning: Cannot open apache log-file '$logFilePath' for reading, please check permissions and try again." );
    }
}
else
{
    $cli->output( "Warning: apache log-file '$logFilePath' doesn't exist, please check your ini-settings and try again." );
}


foreach ( $nodeIDHashCounter as $nodeID => $count )
{
    if ( eZContentObjectTreeNode::fetch( $nodeID ) != null )
    {
        $counter = eZViewCounter::fetch( $nodeID );
        if ( $counter == null )
        {
            $counter = eZViewCounter::create( $nodeID );
            $counter->setAttribute( 'count', $count );
            $counter->store();
        }
        else
        {
            $counter->increase( $count );
        }
    }
}

$dt = new eZDateTime();

$fh = fopen( $updateViewLogPath, "w" );
if ( $fh )
{
    fwrite(
        $fh,
        "# Finished at " . $dt->toString() . "\n" .
        "# Last updated entry:" . "\n" .
        $lastLine . "\n"
    );
    fclose( $fh );
}

$cli->output( "Finished at " . $dt->toString() . "\n"  );
$cli->output( "View count have been updated!\n" );

?>
