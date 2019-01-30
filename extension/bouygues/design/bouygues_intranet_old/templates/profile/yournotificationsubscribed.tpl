{def $object=fetch( 'content', 'node', hash( 'node_id', $nodeId ) )}

{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}
{if is_set($arrCssSubStructure[$object.object.section_id])}{def $classCss = $arrCssSubStructure[$object.object.section_id]}
{else}{def $classCss = 'default'}{/if}

{def $arrp = $object.object.assigned_nodes.0.url_alias|explode( '/' )}{def $stringTitle = ''}{def $parentNode = ''}{def $count = 0}{def $parentPath = ''}
{def $balBegin='' $baEnd=''}
{foreach $arrp as $p}

	{if $parentPath|eq('')|not()}{set $p = concat($parentPath,'/',$p)}{/if}
	{set $parentPath = $p}
	{set $parentNode=fetch( 'content', 'node', hash( 'node_path', $p ) )}
	
	
	{if eq(count($arrp), inc($count))}
		{set $balBegin = concat('color2-',$classCss)}
		{set $balEnd = ''}
	{/if}
	
	{if $parentNode}
		{if gt($count,0)}{set $stringTitle = concat($stringTitle, ' / ', '<span class="', $balBegin, '">', $parentNode.name, '</span>')}
		{else}{set $stringTitle = concat($stringTitle, '<span class="', $balBegin, '">', $parentNode.name, '</span>')}{/if}
	{/if}
	{set $count = inc($count)}
{/foreach}

<h2>{"message_confirm2"|i18n("design/bouygues/notification")|nl2br()}</h2>
<span class="notification-path"><img src="{concat('images/breadcrumb/',$classCss,'/start_hard.gif')|ezdesign(no)}"/>  {$stringTitle}</span>
<div class="notification-bloc">
	<h2>{"message_confirm3"|i18n("design/bouygues/notification")|nl2br()}</h2>
</div>
<div class="notification-footer">
<span class="notification-all"><img src="{'images/arrows/arrowB.png'|ezdesign(no)}"/> <a href={concat($langCurrent,"/profile/yournotification")|ezroot()} title="{"all_notifications"|i18n("design/bouygues/notification")}" class="color2">{"all_notifications"|i18n("design/bouygues/notification")}</a></span>
</div>