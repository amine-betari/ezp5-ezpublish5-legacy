<?php
$Module = array('name' => 'annuaire');

$ViewList = array();

/*
 * Annuaire
 */
$ViewList['search'] = array(
    'functions' => array( 'search' ),
    'script' => 'annuaire.php',
    'params' => array('action'),
    'unordered_params' => array()
);

$FunctionList['search'] = array();