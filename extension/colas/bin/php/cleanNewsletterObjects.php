<?php

require 'autoload.php';

$cli    = eZCLI::instance();
$script = eZScript::instance(array(
    'description'   => "Removes ghosts newsletter objects from db\n",
    'use-session'   => false,
    'use-modules'   => true,
    'use-extensions'=> true
));

$script->startup();

$db = eZDB::instance();

$query = "SELECT * FROM ezcontentobject where contentclass_id=17";


$rows=$db->arrayQuery($query);

if( !$rows )
{
    $cli->output( "MYSQL ERROR : could not execute query" );
}
else
{
    foreach ($rows as $k => $row)
    {
        $objectId = $row['id'];

        $objectToDelete = eZContentObject::fetch($objectId);
        if(is_object($objectToDelete)) {
            $cli->output('Removing object id -->'.$objectId);
            $objectToDelete->purge();
        }

        unset($rows[$k]);
    }
}

$script->shutdown();