{def $img_path_bouygues  = 'extension/bouygues/design/bouygues_intranet/images/'}
{def $host_path = eZDefaultHostname()}
{def $image_host_path = eZDefaultHostname(1)}
{def $sys_path  = ezsys('sitedir')}
{def $currentLocale=fetch( 'content', 'locale' ) $lang=''}
{if $currentLocale.locale_code|eq('eng-US')}{set $lang='en/'}{/if}

{include uri="design:emails/global/header.tpl"}

{'registration_email_hir'|i18n('extension/bouygues/ebyidentification')} {$object.name},<br/><br/>

{'registration_email_justsubscribed'|i18n('extension/bouygues/ebyidentification')|nl2br()}<br/><br/>

<a href="https://{$hostname}{concat( $lang, 'user/activate/', $hash, '/', $object.main_node_id )|ezroot(no)}">https://{$hostname}{concat( $lang, 'user/activate/', $hash, '/', $object.main_node_id )|ezroot(no)}</a><br/><br/>

{'registration_email_bye'|i18n('extension/bouygues/ebyidentification')}.
	
{include uri="design:emails/global/footer.tpl"}

