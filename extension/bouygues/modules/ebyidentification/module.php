<?php

$Module = array( 'name' => 'Module eby identification' );



$ViewList = array();
$ViewList['inscription'] =  array( 
		'functions' => array( 'register' ),
		'script' => 'inscription.php',
        'params' => array(),
        'unordered_params' => array() 
);
$ViewList['update'] =  array( 
		'functions' => array( 'update' ),
		'script' => 'update.php',
        'params' => array(),
        'unordered_params' => array() 
);
$ViewList['password'] =  array( 
		'functions' => array( 'register' ),
		'script' => 'password.php',
        'params' => array(),
        'unordered_params' => array() 
);

$ViewList['login'] =  array( 
		'functions' => array( 'register' ),
		'script' => 'login.php',
        'params' => array('hash', 'uri', 'email'),
        'unordered_params' => array() 
);

$ViewList['error'] =  array( 
		'functions' => array( 'register' ),
		'script' => 'error.php',
        'params' => array(),
        'unordered_params' => array() 
);

$ViewList['setuserdata'] =  array( 
		'functions' => array( 'register' ),
		'script' => 'setuserdata.php',
        'params' => array(),
        'unordered_params' => array() 
);

$ViewList['setuserdataemail'] =  array( 
		'functions' => array( 'register' ),
		'script' => 'setuserdataemail.php',
        'params' => array(),
        'unordered_params' => array() 
);

$ViewList['checkemail'] =  array( 
		'functions' => array( 'register' ),
		'script' => 'checkemail.php',
        'params' => array('email')
);

$ViewList['emailexists'] =  array( 
		'functions' => array( 'register' ),
		'script' => 'emailexists.php'
);

$ViewList['passwordok'] =  array( 
		'functions' => array( 'register' ),
		'script' => 'passwordok.php'
);

$ViewList['forgotpassword'] = array(
    'functions' => array( 'register' ),
    'script' => 'forgotpassword.php',
    'params' => array( ),
    'single_post_actions' => array( 'GenerateButton' => 'Generate' ),
    'post_action_parameters' => array( 'Generate' => array( 'Login' => 'UserLogin',
                                                            'Email' => 'UserEmail' ) ),
    'params' => array( 'HashKey' ) );

$ViewList['forgotpasswordemail'] =  array( 
		'functions' => array( 'register' ),
		'script' => 'forgotpasswordemail.php'
);

$FunctionList = array();
$FunctionList['register'] = array();
$FunctionList['update'] = array();
?>