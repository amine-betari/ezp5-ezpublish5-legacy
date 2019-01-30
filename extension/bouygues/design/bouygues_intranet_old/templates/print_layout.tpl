<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
     <title>{$module_result.path.0.text}</title>
     <meta name="keywords" lang="fr" content="motcle1,mocle2" />
     <meta name="description" content="Description de ma page web." />
     <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
     <meta http-equiv="Content-Language" content="fr" />

{def $aCSS = ezini( 'StylesheetSettings', 'CSSFileList', 'design.ini' )
	 $aJS = ezini( 'JavaScriptSettings', 'JavaScriptList', 'design.ini' )

	 $SiteCurrentURL = ezini( 'SiteSettings', 'SiteURL', 'site.ini' )
	 $SiteFreURL = ezini( 'SiteSettings', 'SiteURL', 'site.ini','extension/bouygues/settings/siteaccess/fre/' )
	 $SiteEngURL = ezini( 'SiteSettings', 'SiteURL', 'site.ini','extension/bouygues/settings/siteaccess/eng/' )

	 $SessionNamePerSiteAccess = ezini( 'Session', 'SessionNamePerSiteAccess', 'site.ini' )
	 $SessionNamePrefix = ezini( 'Session', 'SessionNamePrefix', 'site.ini' )

	 $currentUser = fetch( 'user', 'current_user' )
}

{if $site.http_equiv.Content-language|eq('en-US')}{def $logLang='en'}{else}{def $logLang=''}{/if}

{* CSS *}
{foreach $aCSS as $css}
	<link type="text/css" rel="stylesheet" href={concat('stylesheets/', $css)|ezdesign} />
{/foreach}

{def $sid = $module_result.section_id}

{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}


<link type="text/css" rel="stylesheet" href="{concat("stylesheets/print.css")|ezdesign(no)}"/>


<link type="text/css" rel="stylesheet" href="{concat("stylesheets/langs/_fra/lang.css")|ezdesign(no)}" />

<link type="text/css" rel="stylesheet" href="{concat("stylesheets/ebyperso.js.css")|ezdesign(no)}" />

{* JS *}
<script type="text/javascript">var currentLang=''</script>
{foreach $aJS as $js}
	<script type="text/javascript" src={concat('javascript/', $js)|ezdesign}></script>
{/foreach}

</head>
<body style="background-color:#D0E1F3;height:100%">
<div>

	<div id="container" class="printAll">
		<div class="print-all-button">{include uri="design:blocs/btn.tpl" label="print_all"|i18n("design/bouygues/print") url='javascript:window.print()'}</div>
		<div class="header-print"><img src="{concat('images/boxes/print/','header', $logLang,'.gif')|ezdesign(no)}"/></div>

		<!-- middle -->
			<div id="middle">
				{$module_result.content}
			</div>
		<!-- middle -->

	</div>
</div>

{if is_set($view_parameters.print)}
{literal}
<script type="text/javascript">
	$().ready(function(){
		window.print();
	});
</script>
{/literal}
{/if}
<!--DEBUG_REPORT-->
</body>
</html>