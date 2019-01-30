{def $img_path_bouygues  = 'extension/bouygues/design/bouygues_intranet/images/'}
{def $host_path = eZDefaultHostname()}
{def $image_host_path = eZDefaultHostname(1)}
{def $sys_path  = ezsys('sitedir')}
{def $currentLocale=fetch( 'content', 'locale' ) $lang=''}
{if $currentLocale.locale_code|eq('eng-US')}{set $lang='/en'}{/if}

{include uri="design:emails/global/header.tpl"}
    				
				
{"email_unsubscribe_hello"|i18n("design/bouygues/whoswho")} {$admin_first_name} {$admin_last_name},<br/><br/>

{"email_unsubscribe_content2"|i18n("design/bouygues/whoswho")|nl2br()} {$whoswho}{"two_points"|i18n("design/bouygues/static")}<br/><br/>

<strong>{"email_unsubscribe_last_name"|i18n("design/bouygues/whoswho")}</strong> {$last_name}<br/>
<strong>{"email_unsubscribe_first_name"|i18n("design/bouygues/whoswho")}</strong> {$first_name}<br/>
<strong>{"email_unsubscribe_email"|i18n("design/bouygues/whoswho")}</strong> {$email}<br/><br/>

{"email_unsubscribe_content3"|i18n("design/bouygues/whoswho")|nl2br()}
    			
{include uri="design:emails/global/footer.tpl"}