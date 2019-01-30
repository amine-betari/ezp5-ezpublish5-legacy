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
    				
				
{"email_request_hello"|i18n("design/bouygues/whoswho")} {$admin_first_name} {$admin_last_name},<br/><br/>

{"email_request_content2"|i18n("design/bouygues/whoswho")|nl2br()} {$whoswho}{if $currentLang|eq('fre-FR')} :{else}:{/if} <br/><br/>

<strong>{"email_request_last_name"|i18n("design/bouygues/whoswho")}</strong> {$last_name}<br/>
<strong>{"email_request_first_name"|i18n("design/bouygues/whoswho")}</strong> {$first_name}<br/>
<strong>{"email_request_email"|i18n("design/bouygues/whoswho")}</strong> {$email}<br/>
<strong>{"email_request_message"|i18n("design/bouygues/whoswho")}</strong><br/>
<em>{$message}</em><br/><br/>

{"email_request_content3"|i18n("design/bouygues/whoswho")|nl2br()}
<a href="http://{$urlSiteAccess}{"whoswho/userstate/"|ezroot( no )}" style="color: #2576c7; text-decoration: none">{"email_request_content4"|i18n("design/bouygues/whoswho")|nl2br()}</a><br/><br/>

{"email_request_content5"|i18n("design/bouygues/whoswho")|nl2br()}

{include uri="design:emails/global/footer.tpl"}