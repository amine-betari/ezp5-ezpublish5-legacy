{if $module_result.section_id}
	{def $start = $module_result.section_id}
	{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}
	{if is_set($arrCssSubStructure[$start])}
		{def $section_name = $arrCssSubStructure[$start]}
	{else}
		{def $section_name = 'default'}
	{/if}
{else}
	{def $section_name = 'default'}
{/if}
<a name="top"></a>
<img src="{concat("breadcrumb/",$section_name,"/start.gif")|ezimage(no)}" alt="" />

{if is_set($accueil)}
	<a href="{'/'|ezurl(no)}">{"accueil fil"|i18n("design/bouygues/master")}</a> /
{/if}

{foreach $module_result.path as $path}
	
	{if $path.url|is_string}
		{def $nodeO=fetch('content', 'node', hash('node_id', $path.node_id))}
	
		{if and($path.url_alias|is_string, $nodeO.class_identifier|eq('bouygues_categorie')|not())}
		 <a href={$path.url_alias|ezurl}>{$path.text|wash|shorten(60,'...')}</a> /
		{elseif and($path.url_alias|is_string|not(), $nodeO.class_identifier|eq('bouygues_categorie')|not())}
		 <a href={$path.url|ezurl}>{$path.text|wash|shorten(60,'...')}</a> /
		{else}
		 <a style="cursor:default">{$path.text|wash|shorten(60,'...')}</a> /
		{/if}
	{else}
		<span class="color4">{$path.text|wash|shorten(60,'...')}</span>
	{/if}
	{undef $nodeO}	
{/foreach}