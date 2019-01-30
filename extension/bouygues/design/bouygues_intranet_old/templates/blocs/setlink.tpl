{*
	Create the link *}

{if $linkedNode.class_identifier|eq('file')}
	{set $url=concat('content/download/',
	$linkedNode.data_map.file.contentobject_id, '/',
	$linkedNode.data_map.file.id,'/version/',
	$linkedNode.data_map.file.version , '/file/',
	$linkedNode.data_map.file.content.original_filename|urlencode)|ezurl(no)}
{elseif $linkedNode.class_identifier|eq('newsletter_issue')}
	{set $url=concat('newsletter/previewfull/',
	$linkedNode.contentobject_id, '/',
	$linkedNode.contentobject_version)|ezurl(no)}
	{set $urlTarget='_blank'}
{elseif $linkedNode.class_identifier|eq('link')}
	{set $url=$linkedNode.data_map.lien.content|ezurl(no)}
	{set $urlTarget='_blank'}
{elseif $linkedNode.class_identifier|eq('user')}
	
{elseif $linkedNode.class_identifier|eq('bouygues_element_liste')|not()}
	{if $linkedNode.url_alias}
		{set $url=$linkedNode.url_alias|ezurl(no)}
	{else}
		{set $url=$linkedNode.main_node.url_alias|ezurl(no)}
	{/if}
{elseif and($linkedNode.class_identifier|eq('bouygues_element_liste'), 
		or($linkedNode.data_map.lien_eby.has_content, $linkedNode.data_map.lien_ext.has_content))}
	{if $linkedNode.data_map.lien_eby.has_content}
		{set $url=$linkedNode.data_map.lien_eby.value.main_node.url_alias|ezurl(no)}
	{elseif $linkedNode.data_map.lien_ext.has_content}
		{set $url=$linkedNode.data_map.lien_ext.content|ezurl(no)}
		{set $urlTarget='_blank'}
	{else}{set $url = ''}{/if}
	
{else}
	{set $url = ''}
{/if}
