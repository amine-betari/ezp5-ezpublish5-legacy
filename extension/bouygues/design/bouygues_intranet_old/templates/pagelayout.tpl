<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
{def $sid = $module_result.section_id}{def $count=0}{if $module_result.node_id|eq(2)|not()}{def $pageTitle = hash()}{foreach $module_result.path as $path}{if or($count|gt(0),$module_result.path|count|eq(1))}{if is_set($path.title)}{def $balise_title = $path.title}{else}{def $balise_title = $path.text}{/if}{set $pageTitle = $pageTitle|insert($pageTitle|count(),$balise_title)}{undef $balise_title}{/if}{set $count = $count|inc()}{/foreach}{set $pageTitle = concat("accueil fil"|i18n("design/bouygues/master"),' / ',$pageTitle|implode(' / '))}{else}{def $pageTitle = "accueil fil welcome"|i18n("design/bouygues/metadata")}{/if}{def $aCSS = ezini( 'StylesheetSettings', 'CSSFileList', 'design.ini' )
	 $aJS = ezini( 'JavaScriptSettings', 'JavaScriptList', 'design.ini' )

	 $SiteCurrentURL = ezini( 'SiteSettings', 'SiteURL', 'site.ini' )
	 $SiteFreURL = ezini( 'SiteSettings', 'SiteURL', 'site.ini','extension/bouygues/settings/siteaccess/fre/' )
	 $SiteEngURL = ezini( 'SiteSettings', 'SiteURL', 'site.ini','extension/bouygues/settings/siteaccess/eng/' )

	 $SessionNamePerSiteAccess = ezini( 'Session', 'SessionNamePerSiteAccess', 'site.ini' )
	 $SessionNamePrefix = ezini( 'Session', 'SessionNamePrefix', 'site.ini' )

	 $currentUser = fetch( 'user', 'current_user' )

	 $actu_node_id = ezini('NODE_ID', 'actu_groupe', 'site.ini')
	 $site_node_id = ezini('NODE_ID', 'site_groupe', 'site.ini')
}{def $currentLanguage=''}{if $site.http_equiv.Content-language|eq('fr-FR')}{set $currentLanguage=''}{elseif $site.http_equiv.Content-language|eq('en-US')}{set $currentLanguage='/en'}{/if}{* Management of the language URL *}

{if is_set($module_result.node_id)}
	{def $urlAliasEn = getUrlAliasBylang($module_result.node_id, 'eng-US')}
	{def $urlAliasFr = getUrlAliasBylang($module_result.node_id, 'fre-FR')}
	{if $urlAliasEn|eq('')}{set $urlAliasEn=$urlAliasFr}{/if}
{else}
	{if $site.http_equiv.Content-language|eq('fr-FR')}
		{def $urlAliasEn=$module_result.uri}
		{def $urlAliasFr=$module_result.uri}
	{elseif $site.http_equiv.Content-language|eq('en-US')}
		{def $urlAliasEn=$module_result.uri|extract(3)}
		{def $urlAliasFr=$module_result.uri|extract(3)}
	{/if}
{/if}{* Check if restricted access*}{def $isRestricted = isRestrictedArea($sid, $module_result.uri, $currentUser.contentobject_id, $currentLanguage)}
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
     <title>{$pageTitle}{if is_set(ezhttp('pgacc', 'get'))} / {ezhttp('pgacc', 'get')}{/if}</title>
     <meta name="keywords" lang="fr" content="motcle1,mocle2" />
     <meta name="description" content="Description de ma page web." />
     <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
     <meta http-equiv="Content-Language" content="fr" />

{* CSS *}
{foreach $aCSS as $css}
	<link type="text/css" rel="stylesheet" href={concat('stylesheets/',$css)|ezdesign} />
{/foreach}
{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}
{if and(is_set($arrCssSubStructure[$sid]),$arrCssSubStructure[$sid]|eq('default'))}
	<link type="text/css" rel="stylesheet" href="{concat("stylesheets/substructures/default.css")|ezdesign(no)}" />
{elseif and(is_set($arrCssSubStructure[$sid]),$arrCssSubStructure[$sid]|eq('default')|not)}
	<link type="text/css" rel="stylesheet" href="{concat("stylesheets/substructures/",$arrCssSubStructure[$sid],"/substructure.css")|ezdesign(no)}" />
{else}
	<link type="text/css" rel="stylesheet" href="{concat("stylesheets/substructures/default.css")|ezdesign(no)}" />
{/if}
{if $site.http_equiv.Content-language|eq('fr-FR')}
	<link type="text/css" rel="stylesheet" href="{concat("stylesheets/langs/_fra/lang.css")|ezdesign(no)}" />
{elseif $site.http_equiv.Content-language|eq('en-US')}
	<link type="text/css" rel="stylesheet" href="{concat("stylesheets/langs/_en/lang.css")|ezdesign(no)}" />
{/if}
<link type="text/css" rel="stylesheet" href="{concat("stylesheets/ebyperso.js.css")|ezdesign(no)}" />
{* JS *}
<script type="text/javascript">var currentLang='{$currentLanguage}'</script>
{foreach $aJS as $js}
	<script type="text/javascript" src={concat('javascript/', $js)|ezdesign}></script>
{/foreach}

<!--[if lt IE 7]>
	<link rel="stylesheet" type="text/css" href="{concat("stylesheets/structureIE6.css")|ezdesign(no)}" />
	<script type="text/javascript" src={concat('javascript/DD_belatedPNG_0.0.8a-min.js')|ezdesign(no)}></script>
	<script type="text/javascript" src={concat('javascript/ie6.js')|ezdesign(no)}></script>
<![endif]-->

<!--[if lt IE 8]>
	<script type="text/javascript">window.attachEvent("onload", ativaOptionsDisabled);</script>
<![endif]-->
<link rel="shortcut icon" href={'/extension/bouygues/design/bouygues_intranet/images/favicon.ico'} type="image/x-icon" />
</head>
<body>
	<noscript>Veuillez activer le javascript pour profiter pleinement de la navigation / Please activate javascript to fully enjoy navigation</noscript>
<!-- Image preload -->
{*include uri="design:blocs/preloadImage.tpl"*}
<!-- END Image preload -->
<div id="base">
<div id="base-top">
<div id="base-bottom">

	<div id="container">

	<!-- Header -->
		<div id="header">

			<ul class="displayNoneAccesibility">
					<li><a href="#middle" name="header" rel="" title="{'header_menu_goto_content'|i18n('design/bouygues/accessibility')}">{'header_menu_goto_content'|i18n('design/bouygues/accessibility')}</a></li>
					<li><a href="#navigation" rel="" title="{'header_menu_goto_navigation'|i18n('design/bouygues/accessibility')}">{'header_menu_goto_navigation'|i18n('design/bouygues/accessibility')}</a></li>
					<li><a href="#footer" rel="" title="{'header_menu_goto_footer'|i18n('design/bouygues/accessibility')}">{'header_menu_goto_footer'|i18n('design/bouygues/accessibility')}</a></li>
			</ul>
			<div id="logo">
				<a href="{'/'|ezurl(no)}" rel="" title="{'logo_header'|i18n('design/bouygues/accessibility')}">{'logo_header'|i18n('design/bouygues/accessibility')}</a>
			</div>
			<div id="tools">
				<ul id="lang">
					<li class="li1"><a href="{$urlAliasFr}" {if $site.http_equiv.Content-language|eq('fr-FR')}onclick="return false"{/if} rel="" title="{'header_lang_fr'|i18n('design/bouygues/accessibility')}">{'header_lang_fr'|i18n('design/bouygues/accessibility')}</a></li>
					<li class="separator">&nbsp;</li>
					<li class="li2"><a href="/en{$urlAliasEn}" {if $site.http_equiv.Content-language|eq('en-US')}onclick="return false"{/if} rel="" title="{'header_lang_en'|i18n('design/bouygues/accessibility')}">{'header_lang_en'|i18n('design/bouygues/accessibility')}</a></li>
				</ul>
				<ul id="auth">
				{if $currentUser.is_logged_in}
					<li class="li1"><a href="{"/ebyidentification/update"|ezurl(no)}" rel="" title="{'header_auth_profil'|i18n('design/bouygues/accessibility')}" class="on">{'header_auth_profil'|i18n('design/bouygues/accessibility')}</a></li>
					<li class="li2"><a href="{"/user/logout"|ezurl(no)}" rel="{'header_auth_disconnect'|i18n('design/bouygues/accessibility')}" title="{'header_auth_disconnect'|i18n('design/bouygues/accessibility')}" class="on">{'header_auth_disconnect'|i18n('design/bouygues/accessibility')}</a></li>
				{else}
					<li class="li1"><a href="{"/user/login"|ezurl(no)}" onclick="return false;" rel="" title="{'header_auth_connect'|i18n('design/bouygues/accessibility')}" class="UserConnect normal">{'header_auth_connect'|i18n('design/bouygues/accessibility')}</a></li>
					<li class="li2"><a href="{"ebyidentification/inscription"|ezurl(no)}" rel="" title="{'header_auth_register'|i18n('design/bouygues/accessibility')}" class="normal">{'header_auth_register'|i18n('design/bouygues/accessibility')}</a></li>
				{/if}
				</ul>
			</div>
			<div id="menu">
			<div class="contactGroup displayNone">
					<a href="{"/"|ezurl(no)}" onclick="return false" class="btn-close-box" title="{"btn_close_contact"|i18n('design/bouygues/accessibility')}" tabindex="5">{"btn_close_contact"|i18n('design/bouygues/accessibility')}</a>
					<div class="top"></div>
					<div class="middle">
						<div class="middleTop">
							{include uri="design:blocs/contactgroup.tpl"}
						</div>
					</div>
					<div class="bottom">

					</div>
				</div>

				<div id="pagesView" class="displayNone" tabindex="0">
					<a href="{"/"|ezurl(no)}" onclick="return false" class="btn-close-box" title="{"btn_close_page"|i18n('design/bouygues/accessibility')}" tabindex="2">{"btn_close_page"|i18n('design/bouygues/accessibility')}</a>
					<div class="top"></div>
					<div class="middle">
						<div class="middleTop">
							{include uri="design:blocs/pagesview.tpl" nbpages=5}
						</div>

					</div>
					<div class="bottom"></div>
				</div>
				<ul>
					<li class="li1"><a href="{'/'|ezurl(no)}" rel="" title="{'header_menu_home'|i18n('design/bouygues/accessibility')}">{'header_menu_home'|i18n('design/bouygues/accessibility')}</a></li>
					<li class="li2"><a href={if $currentUser.is_logged_in}{"ebyperso/home"|ezurl}{else}{"static/ebyperso"|ezurl}{/if} rel="" title="{'header_menu_ebyperso'|i18n('design/bouygues/accessibility')}">{'header_menu_ebyperso'|i18n('design/bouygues/accessibility')}</a></li>
					<li class="li3"><a href="#" rel="" title="{'header_menu_contactgroup'|i18n('design/bouygues/accessibility')}" onclick="return false" class="aContactGroup">{'header_menu_contactgroup'|i18n('design/bouygues/accessibility')}</a></li>
					<li class="li4"><a href="#" rel="" title="{'header_menu_pageview'|i18n('design/bouygues/accessibility')}" onclick="return false" class="aPageView">{'header_menu_pageview'|i18n('design/bouygues/accessibility')}</a></li>
				</ul>
			</div>
			<div id="message">
				{def $timestamp = currentdate()}

				{if $site.http_equiv.Content-language|eq('fr-FR')}
					<strong>{$timestamp|datetime('custom','%l %d')} {$timestamp|datetime('custom','%F')|downcase} {$timestamp|datetime('custom','%Y')|downcase} - {$timestamp|datetime('custom','%H:%i')} (CET)</strong>
				{else}
					<strong>{$timestamp|datetime('custom','%l %d')} {$timestamp|datetime('custom','%F')} {$timestamp|datetime('custom','%Y')|downcase} - {$timestamp|datetime('custom','%H:%i')} (CET)</strong>
				{/if}

				<br />{'header_eby'|i18n('design/bouygues/tools')}
			</div>
			<div id="search">
				<form id="ldap-search" action="{'/recherche'|ezurl(no)}" method="get">
					<fieldset>
					<legend>{'header_search_legend'|i18n('design/bouygues/accessibility')}</legend>
					<input type="hidden" name="search" value="1" />
					<input type="hidden" name="nbresult" value="10" />
					<input type="hidden" name="pg" value="1" />
					<a href="{'/recherche/?adv=1'|ezurl(no)}" class="btnAdvancedSearch" title="{'header_search_legend_more'|i18n('design/bouygues/accessibility')}"></a>
					<label for="terms">{'header_search_legend'|i18n('design/bouygues/accessibility')}</label>
					<input type="text" id="terms" name="terms" class="inputSearch" value="{'search_value'|i18n('design/bouygues/tools')}" onclick="if($(this).val() == '{'search_value'|i18n('design/bouygues/tools')}') $(this).val('')" onblur="if($(this).val() == '') $(this).val('{'search_value'|i18n('design/bouygues/tools')}')" />
					<span class="displayNoneAccesibility"><input type="submit" value="{'header_search_submit'|i18n('design/bouygues/accessibility')}" /></span>
					<a href="{'/recherche/'|ezurl(no)}" onclick="$('#ldap-search').submit();return false;" class="inputSubmit" title="{'header_search_submit'|i18n('design/bouygues/accessibility')}"><span class="displayNone"><input type="submit"/></span></a>
					</fieldset>
				</form>
			</div>
			<div id="navigation">
				<a name="navigation" class="displayNoneAccesibility">{'header_text_navigation'|i18n('design/bouygues/accessibility')}</a>
				{cache-block keys=array( $extra_cache_key, $sid ) ignore_content_expiry expiry=86400 }
							{include uri="design:blocs/menutop.tpl"}
				{/cache-block}
			</div>
		</div>
		<!-- Header -->

		<!-- Center -->
		<div id="center">

		<!-- left -->
		{if and($module_result.ui_component|eq("static"),$module_result.static_mode|eq("footer"))}
			<!-- menu static footer -->
			<div id="left">
			<a name="left-menu" class="displayNoneAccesibility">{'left_text_navigation'|i18n('design/bouygues/accessibility')}</a>
				<ul id="lmenu" class="user">
					<li><a href="{"/static/group"|ezurl(no)}" class="{if $module_result.static_identifier|eq('group')}linkOn{else}linkOff{/if} colorDefault1 border4" {if $module_result.static_identifier|eq('group')}onclick="return false"{/if}>{'menu_left_group_values'|i18n('design/bouygues/tools')}</a></li>
					<li><a href="{"/static/about"|ezurl(no)}" class="{if $module_result.static_identifier|eq('about')}linkOn{else}linkOff{/if} colorDefault1 border4" {if $module_result.static_identifier|eq('about')}onclick="return false"{/if}>{'menu_left_about_eby'|i18n('design/bouygues/tools')}</a></li>
					<li><a href="{"/static/webmaster"|ezurl(no)}" class="{if $module_result.static_identifier|eq('webmaster')}linkOn{else}linkOff{/if} colorDefault1 border4" {if $module_result.static_identifier|eq('webmaster')}onclick="return false"{/if}>{'menu_left_contact'|i18n('design/bouygues/tools')}</a></li>
					<li><a href="{"/static/legals"|ezurl(no)}" class="{if $module_result.static_identifier|eq('legals')}linkOn{else}linkOff{/if} colorDefault1 border4" {if $module_result.static_identifier|eq('legals')}onclick="return false"{/if}>{'menu_left_group_mention'|i18n('design/bouygues/tools')}</a></li>
					<li><a href="{"/static/sitemap"|ezurl(no)}" class="{if $module_result.static_identifier|eq('sitemap')}linkOn{else}linkOff{/if} colorDefault1 border4" {if $module_result.static_identifier|eq('sitemap')}onclick="return false"{/if}>{'menu_left_sitemap'|i18n('design/bouygues/tools')}</a></li>
				</ul>
			</div>
		{/if}

		{if and(or($module_result.ui_component|eq("profile"), $module_result.uri|contains("/ebyidentification/update")), $module_result.uri|contains("/ebyidentification/inscription")|not, $currentUser.is_logged_in)}
			{def $user_whoswho_boo=fetch('whoswho', 'whoswho_user_subscribed_once')}
			<!-- menu user connecté -->
			<div id="left">
			<a name="left-menu" class="displayNoneAccesibility">{'left_text_navigation'|i18n('design/bouygues/accessibility')}</a>
				<ul id="lmenu" class="user">
					<li><a href="{"/ebyidentification/update"|ezurl(no)}" class="{if $module_result.uri|eq('/ebyidentification/update')}linkOn{else}linkOff{/if} colorDefault1 border4"  {if $module_result.uri|eq('/ebyidentification/update')}onclick="return false"{/if}>{'menu_left_profile'|i18n('design/bouygues/tools')}</a></li>
					<li><a href="{"/ebyperso/home"|ezurl(no)}" class="{if $module_result.uri|eq('/ebyperso/home')}linkOn{else}linkOff{/if} colorDefault1 border4"  {if $module_result.uri|eq('/ebyperso/home')}onclick="return false"{/if}>{'menu_left_ebyperso'|i18n('design/bouygues/tools')}</a></li>
					<li><a href="{"/profile/yourwhoswho"|ezurl(no)}" class="{if $module_result.uri|eq('/profile/yourwhoswho')}linkOn{else}linkOff{/if} colorDefault1 border4"  {if $module_result.uri|eq('/profile/yourwhoswho')}onclick="return false"{/if}>{'menu_left_whoswho'|i18n('design/bouygues/tools')}</a></li>
					{if $user_whoswho_boo|eq(true())}<li><a href="{"/profile/yourwhoswhodata"|ezurl(no)}" class="{if $module_result.uri|eq('/profile/yourwhoswhodata')}linkOn{else}linkOff{/if} colorDefault1 border4"  {if $module_result.uri|eq('/profile/yourwhoswhodata')}onclick="return false"{/if}>{'menu_left_whoswhodata'|i18n('design/bouygues/tools')}</a></li>{/if}
					<li><a href="{"/profile/yournewsletter"|ezurl(no)}" class="{if $module_result.static_identifier|eq('yournewsletter')}linkOn{else}linkOff{/if} colorDefault1 border4"  {if $module_result.static_identifier|eq('yournewsletter')}onclick="return false"{/if}>{'menu_left_newsletter'|i18n('design/bouygues/tools')}</a></li>
					<li><a href="{"/profile/yournotification"|ezurl(no)}" class="{if $module_result.uri|eq('/profile/yournotification')}linkOn{else}linkOff{/if} colorDefault1 border4"  {if $module_result.uri|eq('/profile/yournotification')}onclick="return false"{/if}>{'menu_left_notification'|i18n('design/bouygues/tools')}</a></li>
				</ul>
			</div>
		{/if}

		{def $arrp = $module_result.uri|explode( '/' )}

		{if $site.http_equiv.Content-language|eq('en-US')}
			{def $parentNode=fetch( 'content', 'node', hash( 'node_path', $arrp[2] ) )}
		{else}
			{def $parentNode=fetch( 'content', 'node', hash( 'node_path', $arrp[1] ) )}
		{/if}

		{if and(is_set($arrCssSubStructure[$sid]), $parentNode.node_id|eq($actu_node_id)|not())}

			{cache-block keys=array( $module_result.uri, $current_user.contentobject_id, $extra_cache_key, $sid )  ignore_content_expiry }
		<!-- menu section -->
			<div id="left">
			<a name="left-menu" class="displayNoneAccesibility">{'left_text_navigation'|i18n('design/bouygues/accessibility')}</a>
			{include uri="design:blocs/menuleft.tpl"}
			</div>
			{/cache-block}

		{/if}
		<!-- left -->

		<!-- middle -->
			<div id="middle">
			<a name="middle" class="displayNoneAccesibility">{'middle_text_navigation'|i18n('design/bouygues/accessibility')}</a>
				{if or($module_result.node_id|eq(2)|not())}
					<div id="breadcrumb">
						{include uri="design:parts/path.tpl" accueil=1}
					</div>
				{elseif or($module_result.ui_component|eq("ebyidentification"),$module_result.ui_component|eq("error"),$module_result.ui_component|eq('static'),$module_result.ui_component|eq('user'),$module_result.ui_component|eq('ebyperso'),$module_result.ui_component|eq('profile'))}
					<div id="breadcrumb">
						{include uri="design:parts/path.tpl" accueil=1}
					</div>
				{/if}
					{$module_result.content}
			</div>
		<!-- middle -->
		</div>
		<!-- Center -->
{def $is_fr_home=0}
{if eq($module_result.uri,'/')}{set $is_fr_home=1}{/if}
{cache-block keys=array($currentLanguage,$is_home)  ignore_content_expiry }
		<!-- Footer -->
		<a name="footer" class="displayNoneAccesibility">{'footer_text_navigation'|i18n('design/bouygues/accessibility')}</a>
		<div id="footer" class="footer{if eq($module_result.uri,'/')}Home{/if}" >
			<div class="links">
				<a href="{"/static/group"|ezurl(no)}" title="{'footer_group'|i18n('design/bouygues/tools')}">{'footer_group'|i18n('design/bouygues/tools')}</a> |
				<a href="{"/static/about"|ezurl(no)}" title="{'footer_about_eby'|i18n('design/bouygues/tools')}" >{'footer_about_eby'|i18n('design/bouygues/tools')}</a> |
				<a href="{"/static/sitemap"|ezurl(no)}" title="{'footer_sitemap'|i18n('design/bouygues/tools')}" >{'footer_sitemap'|i18n('design/bouygues/tools')}</a> |
				<a href="{"/static/rss"|ezurl(no)}" title="{'footer_rss'|i18n('design/bouygues/tools')}">{'footer_rss'|i18n('design/bouygues/tools')}</a> |
				<a href="{"/static/webmaster"|ezurl(no)}" title="{'footer_contact'|i18n('design/bouygues/tools')}">{'footer_contact'|i18n('design/bouygues/tools')}</a> |
				<a href="{"/static/legals"|ezurl(no)}" title="{'footer_mention'|i18n('design/bouygues/tools')}">{'footer_mention'|i18n('design/bouygues/tools')}</a>

			</div>
			{if $site.http_equiv.Content-language|eq('en-US')}
				<div class="logos">
					<a href="http://www.bouygues.com/en/home" target="_blank" title="Bouygues SA"><img src={"logos/bouyguesSA.gif"|ezimage} alt="Bouygues SA" border="0" /></a>
					<a href="http://www.bouygues-construction.com/2i.html"  target="_blank" title="Bouygues Construction"><img src={"logos/bouyguesC.gif"|ezimage} alt="Bouygues Construction" border="0" /></a>
					<a href="http://www.bouygues-immobilier-corporate.com/"  target="_blank" title="Bouygues Immobilier"><img src={"logos/bouyguesI.gif"|ezimage} alt="Bouygues Immobilier" border="0" /></a>
					<a href="http://www.colas.com/en-950096.html"  target="_blank" title="Colas"><img src={"logos/colas.gif"|ezimage} alt="Colas" border="0" /></a>
					<a href="http://www.groupe-tf1.fr/en/"  target="_blank" title="TF1"><img src={"logos/tf1.gif"|ezimage} alt="TF1" border="0" /></a>
					<a href="http://www.bouyguestelecom.fr/" target="_blank" title="Bouygues Télécom"><img src={"logos/bouyguesT.gif"|ezimage} alt="Bouygues Télécom" border="0" /></a>
				</div>

			{else}
				<div class="logos">
					<a href="http://www.bouygues.com" target="_blank" title="Bouygues SA"><img src={"logos/bouyguesSA.gif"|ezimage} alt="Bouygues SA" border="0" /></a>
					<a href="http://www.bouygues-construction.com"  target="_blank" title="Bouygues Construction"><img src={"logos/bouyguesC.gif"|ezimage} alt="Bouygues Construction" border="0" /></a>
					<a href="http://www.bouygues-immobilier-corporate.com/"  target="_blank" title="Bouygues Immobilier"><img src={"logos/bouyguesI.gif"|ezimage} alt="Bouygues Immobilier" border="0" /></a>
					<a href="http://www.colas.com"  target="_blank" title="Colas"><img src={"logos/colas.gif"|ezimage} alt="Colas" border="0" /></a>
					<a href="http://www.groupe-tf1.fr"  target="_blank" title="TF1"><img src={"logos/tf1.gif"|ezimage} alt="TF1" border="0" /></a>
					<a href="http://www.bouyguestelecom.fr"  target="_blank" title="Bouygues Télécom"><img src={"logos/bouyguesT.gif"|ezimage} alt="Bouygues Télécom" border="0" /></a>
				</div>
			{/if}
			<div class="links">
				<a href="{'/les-sites-du-groupe'|ezurl(no)}">{'footer_sites'|i18n('design/bouygues/tools')}</a>
			</div>
		</div>
		<!-- Footer -->
			<ul class="displayNoneAccesibility">
					<li><a href="#header" rel="" title="{'header_menu_goto_header'|i18n('design/bouygues/accessibility')}">{'header_menu_goto_header'|i18n('design/bouygues/accessibility')}</a></li>
			</ul>
	</div>
</div>
</div>
</div>
{/cache-block}


{if is_set($view_parameters.print)}
{literal}
<script type="text/javascript">
	$().ready(function(){
		window.print();
	});
</script>
{/literal}
{/if}


{if is_set(ezhttp('check', 'get'))}
{def $galbyeError=isEmailGalbyError()}
{if $galbyeError|eq('true')}
{literal}
<script type="text/javascript">
	$().ready(function(){
		eby.errorGalby();
	});
</script>
{/literal}
{/if}
{/if}

{if is_set(ezhttp('callback', 'get'))}
{literal}
<script type="text/javascript">
	$().ready(function(){
		eby.loginCallback('{/literal}{ezhttp('callback', 'get')}{literal}');
	});
</script>
{/literal}
{/if}
{if and(
		eq($module_result.uri,'/')|not(),
		eq($module_result.uri,'/en/')|not(),
		eq($module_result.uri,'/en')|not(),
		$module_result.uri|contains('/ebyperso/home')|not()
	)
}
	{def $cook1=cookieset()}
{/if}

{include uri="design:blocs/googleanalytics.tpl"}
<!--DEBUG_REPORT-->

</body>
</html>