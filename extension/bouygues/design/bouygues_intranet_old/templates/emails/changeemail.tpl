{def 
	$img_path_bouygues  = 'extension/bouygues/design/bouygues_intranet/images/'
	$host_path = eZDefaultHostname()
	$image_host_path = eZDefaultHostname(1)
	$sys_path  = ezsys('sitedir')
}
{def $currentLocale=fetch( 'content', 'locale' ) $lang=''}
{if $currentLocale.locale_code|eq('eng-US')}{set $lang='/en'}{/if}
{include uri="design:emails/global/header.tpl"}


{'registration_changeemail_hir'|i18n('extension/bouygues/ebyidentification')} {$object.name},<br/><br/>

{'registration_changeemail_justsubscribed'|i18n('extension/bouygues/ebyidentification')|nl2br()}<br/><br/>

<a href="{$host_path}{concat( 'user/activate/', $hash, '/', $object.main_node_id )|ezurl(no)}">{$host_path}{concat( 'user/activate/', $hash, '/', $object.main_node_id )|ezurl(no)}</a><br/><br/>

{'registration_email_bye'|i18n('extension/bouygues/ebyidentification')}.


    			
{include uri="design:emails/global/footer.tpl"}

