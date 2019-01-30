{def $img_path_bouygues  = 'extension/bouygues/design/bouygues_intranet/images/'}
{def $host_path = eZDefaultHostname()}
{def $image_host_path = eZDefaultHostname(1)}
{def $sys_path  = ezsys('sitedir')}
{def $currentLocale=fetch( 'content', 'locale' ) $lang=''}
{if $currentLocale.locale_code|eq('eng-US')}{set $lang='/en'}{/if}

{def $urlsMapping = ezini('SiteAccessSettings', 'HostMatchMapItems', 'site.ini') $urlTemp=''}
{foreach $urlsMapping as $urlAccess}
	{set $urlTemp=$urlAccess|explode(';')}
	{if $urlTemp.1|eq('bouygues_gestion')}{def $urlSiteAccess=$urlTemp.0}{/if}
{/foreach}
{undef $urlTemp $urlsMapping}

{include uri="design:emails/global/header.tpl"}
    				

{"email_update_hi"|i18n("design/bouygues/whoswho")} {$admin_first_name} {$admin_last_name},<br/><br/>

{"email_update_content1"|i18n("design/bouygues/whoswho")|nl2br()}<br/>
{foreach $wwList as $wwname}- {$wwname}<br/>{/foreach}
<br/>

<strong>{"email_request_last_name"|i18n("design/bouygues/whoswho")}</strong> {$last_name}<br/>
<strong>{"email_request_first_name"|i18n("design/bouygues/whoswho")}</strong> {$first_name}<br/>
<strong>{"email_request_email"|i18n("design/bouygues/whoswho")}</strong> {$email}<br/>
{foreach $dataUpdated as $dataWhoswho}<strong>{$dataWhoswho.label}{"two_points"|i18n("design/bouygues/static")}</strong> {$dataWhoswho.value|nl2br()}<br/>{/foreach}<br/>

{"email_update_content2"|i18n("design/bouygues/whoswho")|nl2br()} <a href="http://{$urlSiteAccess}{concat("whoswho/userform/",$user_id)|ezroot( no )}" style="color: #2576c7; text-decoration: none">{"email_update_content3"|i18n("design/bouygues/whoswho")|nl2br()}</a><br/><br/>

{"email_update_content4"|i18n("design/bouygues/whoswho")|nl2br()}

    			
{include uri="design:emails/global/footer.tpl"}