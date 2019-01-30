<div class="default sitemap">
	{include uri="design:blocs/tools.tpl" light=1}
	<h1>{'sitemap_title'|i18n('design/bouygues/static')}</h1>
	
	{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}
	{include uri="design:blocs/menutop.tpl" mode="sitemap" arrCssSubStructure=$arrCssSubStructure}

	
	
</div>
{undef}