{def $currentLocale=fetch( 'content', 'locale' ) $lang=''}
{if $currentLocale.locale_code|eq('eng-US')}{set $lang='/en'}{/if}

{include uri="design:emails/global/header.tpl"}

{def 
	$img_path_bouygues  = 'extension/bouygues/design/bouygues_intranet/images/'
	$host_path = eZDefaultHostname()
	$image_host_path = eZDefaultHostname(1)
	$sys_path  = ezsys('sitedir')
}    				

{"email_content1"|i18n("design/bouygues/sendtofriend")}<br/><br/>

{$sender} {"email_content2"|i18n("design/bouygues/sendtofriend")} <a href="{$fullURL}" target="_blank" style="color: #2576c7; text-decoration: none">{$url}</a> {"email_content3"|i18n("design/bouygues/sendtofriend")}<br/><br/>
{if $content|eq('')|not()}
{"email_content4"|i18n("design/bouygues/sendtofriend")}<br/>
{$content}<br/><br/>
{/if}

<img src="{concat($image_host_path, '/', $img_path_bouygues,'emails/link.png')}" align="absmiddle"/>&nbsp;<a href="{$fullURL}" target="_blank" style="color: #2576c7; text-decoration: none">{"email_link"|i18n("design/bouygues/sendtofriend")}</a>

{include uri="design:emails/global/footer.tpl"}