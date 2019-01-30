{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}
{def $currentUser = fetch( 'user', 'current_user' )}

{if or(is_set($light),$arrCssSubStructure[$node.object.section_id]|eq('default'))}
{def $arrp = $node.url_alias|explode( '/' )}
{def $parentNode=fetch( 'content', 'node', hash( 'node_path', $arrp[0] ) )}

{if $parentNode.node_id|eq(11612)|not()}{def $booSites=false()}{else}{def $booSites=true()}{/if}

<div class="tools">		
	<div class="box">
		<div class="information">
			<a href="#" class="decreaseFont" onclick="return false" title="{'tools_decrease_font'|i18n('design/bouygues/accessibility')}"></a> <a href="#" class="increaseFont" onclick="return false" title="{'tools_increase_font'|i18n('design/bouygues/accessibility')}"></a><br />
			{if or(is_set($btn_history),and($node.object.section_id|eq(16),$booSites|eq(false())))}
				{include uri="design:blocs/btn.tpl" label="btn_history_text"|i18n("design/bouygues/tools") url='/static/actu-history'|ezurl(no)}
			{/if}

			{if or(is_set($btn_back),and($node.object.section_id|eq(16),$booSites|eq(false())))}
				{if is_set($btn_back_text)|not}{def $btn_back_text = "btn_back_text"|i18n("design/bouygues/tools")} {/if}
				{if is_set($btn_back_url)|not}{def $btn_back_url = '/'|ezurl(no)} {/if}
				{include uri="design:blocs/btn.tpl" label=$btn_back_text url=$btn_back_url}
			{/if}
			
			{if is_set($btn_auth)}
			<div class="boxA">
				<div class="top">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
				<div class="content">
					<span class="ebyperso-title">{'ebyperso_login_desc'|i18n('design/bouygues/static')}</span>
					{include uri="design:blocs/btn.tpl" label='authenticate'|i18n('design/bouygues/comment') class="UserConnect fromEbyperso" url="/user/login" onclick="return false;"}
				</div>
				<div class="bottom">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
			</div>
			{/if}
			
		</div>
	</div>
</div>
{elseif is_set($annuaire)}
{def $urlParam = ''}
{foreach $view_parameters as $key => $val}{set $urlParam=concat($urlParam, $key,'/',$val,'!!')}{/foreach}
<div class="tools">		
	<div class="box">
		<div class="information">
			<a href="#" class="decreaseFont" title="{'tools_decrease_font'|i18n('design/bouygues/accessibility')}" onclick="return false"></a> <a href="#" class="increaseFont" title="{'tools_increase_font'|i18n('design/bouygues/accessibility')}" onclick="return false"></a><br />
			<div class="links">
				<a href="/tools/print/add/annuaire" rel="{$urlParam}" title="" class="print" onclick="return false; ">{"print"|i18n("design/bouygues/tools")}</a> |
				<a href="/tools/print/" title=""  class="printBag" onclick="return false; ">{"print_basket"|i18n("design/bouygues/tools")}</a>				
			</div>			
		</div>
			
	</div>
</div>


{else}

{def $urlAliasEn = getUrlAliasBylang($node.node_id, 'eng-US')}
{def $urlAliasFr = getUrlAliasBylang($node.node_id, 'fre-FR')}
{if $urlAliasEn|eq('')}{set $urlAliasEn=$urlAliasFr}{/if}

{def $urlParam = ''}
{foreach $view_parameters as $key => $val}{if $val}{set $urlParam=concat($urlParam, $key,'/',$val,'§')}{/if}{/foreach}

<div class="tools">		
	<div class="box">
		<div class="information">
		<span class="date color2">{"update"|i18n("design/bouygues/tools")} <span>{if $node.object.default_language|eq('fre-FR')}{$node.object.modified|datetime('custom','%l %d %F %Y')|downcase}{else}{$node.object.modified|datetime('custom','%l %d')} {$node.object.modified|datetime('custom','%F')} {$node.object.modified|datetime('custom','%Y')|downcase}{/if}</span> </span> <a href="#" class="decreaseFont" title="{'tools_decrease_font'|i18n('design/bouygues/accessibility')}" onclick="return false"></a> <a href="#" class="increaseFont" title="{'tools_increase_font'|i18n('design/bouygues/accessibility')}" onclick="return false"></a><br />
			<div class="links">
				<a href="/tools/print/add/{$node.object.id}" rel="{$urlParam}" title="" class="print" onclick="return false; ">{"print"|i18n("design/bouygues/tools")}</a> |
				<a href="/tools/print/" title=""  class="printBag" onclick="return false; ">{"print_basket"|i18n("design/bouygues/tools")}</a> |
				<a href="#" title="{"send"|i18n("design/bouygues/tools")}" class="sendtofriend" onclick="return false;" >{"send"|i18n("design/bouygues/tools")}</a><br />
				{if $currentUser.is_logged_in}
				<a href="/profile/yournotification/subscribe/{$node.node_id}" class="notification-subscribe" onclick="return false;">{"follow_notification"|i18n("design/bouygues/tools")}</a>
				{else}
				<a href="/profile/yournotification/subscribe/{$node.node_id}" class="UserConnect fromMaj" onclick="return false;" rel="{$node.url_alias|ezurl(no)}">{"follow_notification"|i18n("design/bouygues/tools")}</a>
				{/if}
				
			</div>			
			{if and(is_set($node.object.all_languages.eng-US),$node.object.default_language|eq('fre-FR'))}<a href="/en{$urlAliasEn}" title="" class="link-lang">{"content_english"|i18n("design/bouygues/tools")}</a> <img src={"pictos/englishFlag.gif"|ezimage} alt="" border="0" />
			{elseif and(is_set($node.object.all_languages.eng-US),$node.object.default_language|eq('eng-US'))}<a href="{$urlAliasFr}" title="" class="link-lang">{"content_french"|i18n("design/bouygues/tools")}</a> <img src={"pictos/frenchFlag.gif"|ezimage} alt="" border="0" />
			{elseif and(is_set($node.object.all_languages.eng-US)|not(),$node.object.default_language|eq('eng-US'))}<a href="{$urlAliasFr}" title="" class="link-lang">{"content_french_only"|i18n("design/bouygues/tools")}</a> <img src={"pictos/frenchFlag.gif"|ezimage} alt="" border="0" />{/if}
		</div>
		

			{if or(is_set($btn_history),$node.object.section_id|eq(1))}
				{include uri="design:blocs/btn.tpl" label="btn_history_text"|i18n("design/bouygues/tools") url='/static/actu-history'}
			{/if}
			
			{if or(is_set($btn_back),$node.object.section_id|eq(1))}
				{if is_set($btn_back_text)|not}{def $btn_back_text = "btn_back_text"|i18n("design/bouygues/tools")} {/if}
				{if is_set($btn_back_url)|not}{def $btn_back_url = '/'} {/if}
				{include uri="design:blocs/btn.tpl" label=$btn_back_text url=$btn_back_url}
			{/if}
			
	</div>
</div>
{/if}