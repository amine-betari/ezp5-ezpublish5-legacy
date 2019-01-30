{def $object=fetch( 'content', 'object', hash( 'node_id', $nodeId ) )}

{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}
{if is_set($arrCssSubStructure[$object.object.section_id])}{def $classCss = $arrCssSubStructure[$object.section_id]}
{else}{def $classCss = 'default'}{/if}

<h2>{"unsubscribed_desc"|i18n("design/bouygues/whoswho")|nl2br()} {$whowho_name}.</h2>
<div class="notification-footer">
<span class="notification-all"><img src="{'images/arrows/arrowB.png'|ezdesign(no)}"/> <a href={concat($langCurrent,"/profile/yourwhoswho")|ezroot()} title="{"subscribe_link"|i18n("design/bouygues/whoswho")}" class="color2">{"subscribe_link"|i18n("design/bouygues/whoswho")}</a></span>
</div>