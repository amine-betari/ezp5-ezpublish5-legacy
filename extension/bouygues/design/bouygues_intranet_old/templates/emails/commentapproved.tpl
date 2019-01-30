{def $currentLocale=fetch( 'content', 'locale' ) $lang=''}
{if $currentLocale.locale_code|eq('eng-US')}{set $lang='/en'}{/if}

{include uri="design:emails/global/header.tpl"}

{def 
	$img_path_bouygues  = 'extension/bouygues/design/bouygues_intranet/images/'
	$host_path = eZDefaultHostname()
	$image_host_path = eZDefaultHostname(1)
	$sys_path  = ezsys('sitedir')
}   
    				
		
{"email_request_hello"|i18n("design/bouygues/whoswho")} {$first_name} {$last_name},<br/><br/>

{"mail_collaborator1"|i18n("design/bouygues/comment")|nl2br()} <em>
<strong>{$article}</strong></em> 
{"mail_collaborator2"|i18n("design/bouygues/comment")|nl2br()}
<br /><br />
<img src="{concat($image_host_path, '/', $img_path_bouygues,'emails/link.png')}" align="absmiddle"/>&nbsp;<a href="{concat($host_path, $lang, '/',$url_alias)}" target="_blank" style="color: #2576c7; text-decoration: none">{"mail_collaborator3"|i18n("design/bouygues/comment")}</a>


    			
{include uri="design:emails/global/footer.tpl"}