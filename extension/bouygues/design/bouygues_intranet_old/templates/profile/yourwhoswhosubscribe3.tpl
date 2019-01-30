{def $object=fetch( 'content', 'object', hash( 'node_id', $nodeId ) )}

{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}
{if is_set($arrCssSubStructure[$object.object.section_id])}{def $classCss = $arrCssSubStructure[$object.section_id]}
{else}{def $classCss = 'default'}{/if}
{def $object=fetch( 'content', 'object', hash( 'object_id', $nodeId ) )}

{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}
{if is_set($arrCssSubStructure[$object.object.section_id])}{def $classCss = $arrCssSubStructure[$object.section_id]}
{else}{def $classCss = 'default'}{/if}
			
<div class="default">
<h1>{"subscribe_title"|i18n('design/bouygues/whoswho')}</h1>

<h2>{"subscribe_message4"|i18n("design/bouygues/whoswho")|nl2br()} {$whowho_name}.<br/> {"subscribe_message5"|i18n("design/bouygues/whoswho")|nl2br()}</h2>
<div class="notification-footer">
<span class="notification-all"><img src="{'images/arrows/arrowB.png'|ezdesign(no)}"/> <a href={concat($langCurrent,"/profile/yourwhoswho")|ezroot()} title="{"subscribe_link"|i18n("design/bouygues/whoswho")}" class="color2" onclick="Lightbox.close(); return false;">{"subscribe_link"|i18n("design/bouygues/whoswho")}</a></span>
</div>
</div>