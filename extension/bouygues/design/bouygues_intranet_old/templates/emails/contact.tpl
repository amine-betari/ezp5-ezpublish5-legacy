{def $img_path_bouygues  = 'extension/bouygues/design/bouygues_intranet/images/'}
{def $host_path = eZDefaultHostname()}
{def $image_host_path = eZDefaultHostname(1)}
{def $sys_path  = ezsys('sitedir')}
{def $currentLocale=fetch( 'content', 'locale' ) $lang=''}
{if $currentLocale.locale_code|eq('eng-US')}{set $lang='/en'}{/if}
{include uri="design:emails/global/header.tpl"}

				
{"mail_hello"|i18n("design/bouygues/contact")} {$groupName},<br/><br/>

{"mail_description"|i18n("design/bouygues/contact")}<br/>
{"mail_user"|i18n("design/bouygues/contact")} {$email}<br/>
{"mail_subject"|i18n("design/bouygues/contact")} {$subject}<br/>
{"mail_message"|i18n("design/bouygues/contact")}<br/>
<em>{$message|nl2br()}</em><br/><br/>

{"mail_see_you_soon"|i18n("design/bouygues/contact")} 

    			
{include uri="design:emails/global/footer.tpl"}