{def $img_path_bouygues  = 'extension/bouygues/design/bouygues_intranet/images/'}
{def $host_path = eZDefaultHostname()}
{def $image_host_path = eZDefaultHostname(1)}
{def $sys_path  = ezsys('sitedir')}
{def $userData = fetchUserByEmail($email)}
{def $hash = $userData.password_hash}
{def $currentLocale=fetch( 'content', 'locale' ) $lang=''}
{if $currentLocale.locale_code|eq('eng-US')}{set $lang='/en'}{/if}

{include uri="design:emails/global/header.tpl"}

{def $whoswho_search = fetch( 'content', 'tree', hash(
			  'parent_node_id', 2,
			  'class_filter_type',  'include',
			  'class_filter_array', array( 'bouygues_whoswho_search'),
			  'attribute_filter', array(array('section', '=', $section_id)),
			  'limit', 1,
			  'offset', 0,
			  'depth', 2,
			  'limitation', array()
			  ))}
    				
	
{"email_accepted_hello"|i18n("design/bouygues/whoswho")} {$name},<br/><br/>

{"email_accepted_content2"|i18n("design/bouygues/whoswho")|nl2br()} {$whoswho_name}. {"email_accepted_content3"|i18n("design/bouygues/whoswho")|nl2br()} <a href="{concat($host_path, $lang, '/ebyidentification/login/', $hash, '/yourwhoswhodata/', $email)}" style="color: #2576c7; text-decoration: none">{"email_accepted_content4"|i18n("design/bouygues/whoswho")|nl2br()}</a><br/><br/>

{"email_accepted_content5"|i18n("design/bouygues/whoswho")|nl2br()}

    			
{include uri="design:emails/global/footer.tpl"}