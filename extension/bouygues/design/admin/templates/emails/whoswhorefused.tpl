{def $img_path_bouygues  = 'extension/bouygues/design/bouygues_intranet/images/'}
{def $host_path = eZDefaultHostname()}
{def $image_host_path = eZDefaultHostname(1)}
{def $sys_path  = ezsys('sitedir')}
{def $currentLocale=fetch( 'content', 'locale' ) $lang=''}
{if $currentLocale.locale_code|eq('eng-US')}{set $lang='/en'}{/if}
{include uri="design:emails/global/header.tpl"}
    				

{"email_refused_hello"|i18n("design/bouygues/whoswho")} {$name},<br/><br/>

{"email_refused_content2"|i18n("design/bouygues/whoswho")|nl2br()} 

{$whoswho_name}. {"email_refused_content3"|i18n("design/bouygues/whoswho")|nl2br()} <a href="{concat($host_path, $lang,'/static/webmaster')}" style="color: #2576c7; text-decoration: none">{"email_refused_content4"|i18n("design/bouygues/whoswho")|nl2br()}</a><br/><br/>

{"email_refused_content5"|i18n("design/bouygues/whoswho")|nl2br()}

    			
{include uri="design:emails/global/footer.tpl"}