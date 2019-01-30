<?php
$Module = array('name' => 'static');

$ViewList = array();

/*
 * Valeurs du groupe
 */
$ViewList['group'] = array(
		'functions' => array( 'view' ),
		'script' => 'group.php',
        'params' => array( 'action', 'group'),
        'unordered_params' => array()
);

/*
 * A propos d'E.BY
 */
$ViewList['about'] = array(
		'functions' => array( 'view' ),
		'script' => 'about.php',
        'params' => array( 'action', 'about'),
        'unordered_params' => array()
);

/*
 * Contact webmaster
 */
$ViewList['webmaster'] = array(
		'functions' => array( 'view' ),
		'script' => 'webmaster.php',
        'params' => array( 'action', 'webmaster'),
        'unordered_params' => array()
);

$ViewList['webmastersubmitted'] = array(
		'functions' => array( 'view' ),
		'script' => 'webmastersubmitted.php',
        'params' => array(),
        'unordered_params' => array()
);

/*
 * Mentions légales
 */
$ViewList['legals'] = array(
		'functions' => array( 'view' ),
		'script' => 'legals.php',
        'params' => array( 'action', 'legals'),
        'unordered_params' => array()
);

/*
 * Plan du site
 */
$ViewList['sitemap'] = array(
		'functions' => array( 'view' ),
		'script' => 'sitemap.php',
        'params' => array( 'action', 'sitemap'),
        'unordered_params' => array()
);

/*
 * Actualités
 */
$ViewList['actu-history'] = array(
		'functions' => array( 'view' ),
		'script' => 'actu-history.php',
        'params' => array(),
        'unordered_params' => array('offset'=>'offset')
);

/*
 * RSS
 */
$ViewList['rss'] = array(
		'functions' => array( 'view' ),
		'script' => 'rss.php',
        'params' => array(),
        'unordered_params' => array()
);



/*
 * E.by perso
 */
$ViewList['ebyperso'] = array(
		'functions' => array( 'view' ),
		'script' => 'ebyperso.php',
        'params' => array(),
        'unordered_params' => array()
);

/*
 * Newsletter
 */
$ViewList['newsletter'] = array(
		'functions' => array( 'view' ),
		'script' => 'newsletter.php',
        'params' => array(),
        'unordered_params' => array()
);


/*
 * Newsletter
 */
$ViewList['restrictedarea'] = array(
		'functions' => array( 'view' ),
		'script' => 'restrictedarea.php'
);

$FunctionList = array();
$FunctionList['view'] = array();