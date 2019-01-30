{set-block scope=global variable=cache_ttl}0{/set-block}
{def $paramsArray=$params|explode('§') $userId=''}
{foreach $paramsArray as $paramKeyValue}{def $paramKeyValueArray=$paramKeyValue|explode('/')}{if $paramKeyValueArray[0]|eq('userId')}{set $userId=$paramKeyValueArray[1]}{/if}{/foreach}
{if and($userId|eq(''),is_set($view_parameters.userId))}{set $userId=$view_parameters.userId}{/if}
{def $whoswho_list = fetch('content', 'tree', hash(
								'parent_node_id', 2,
								'class_filter_type', 'include',
								'class_filter_array', array('bouygues_whoswho'),
								'depth', 2,
								'limitation', array()
								)
							)}
{foreach $whoswho_list as $data}{if eq($data.object.section_id, $node.object.section_id)}{def $ww_id = $data.object.id}{/if}{/foreach}
{* Whos who - Node view *}
	{def $currentUser = fetch( 'user', 'current_user' )}
	<div class="default post whoswho">

		{if and(is_unset($lightbox), is_unset($include_mode),is_unset($parent))}
			{include uri="design:blocs/tools.tpl"}
		{/if}
		
		<div class="column">
						
			<div class="box">
				<div class="second plus">

					<div class="boxA">
						<div class="top">
							<div class="left"></div>
							<div class="right"></div>
							<div class="middle"></div>
						</div>
						<div class="content">
							{if $currentUser.is_logged_in}
								<strong class="title">{"subscribe_how"|i18n("design/bouygues/whoswho")}</strong>
								{"whoswho_desc"|i18n("design/bouygues/whoswho")}
								<ul><li>
									<a href="/profile/yourwhoswho/subscribe/{$ww_id}" class='whoswho-subscribe' onclick='return false;'>{"whoswho_link"|i18n("design/bouygues/whoswho")}</a>
								</li></ul>
							{else}
								<strong class="title">{"subscribe_how"|i18n("design/bouygues/whoswho")}</strong>
								{"whoswho_desc"|i18n("design/bouygues/whoswho")}
								<ul><li>
									<a href="{"/user/login"|ezurl(no)}" onclick="return false;" title="" class="UserConnect normal fromWhoswho" rel="{$node.url_alias|ezurl(no)}">{"whoswho_link"|i18n("design/bouygues/whoswho")}</a>
								</li></ul>
							{/if}
						</div>
						<div class="bottom">
							<div class="left"></div>
							<div class="right"></div>
							<div class="middle"></div>
						</div>
					</div>
		
				</div>
			</div>

		</div>
		
        <h1>{$node.name}</h1>
        
        <h2 class="color2">{$node.data_map.sub_title.content}</h2>
        
        {$node.data_map.description.content.output.output_text}
        
        {$node.data_map.body.content.output.output_text}
		
		{def $section_id = $node.object.section_id}
        {if and($userId|eq(''), eq($node.class_identifier,'bouygues_whoswho_list'))}{include uri="design:blocs/whoswholist.tpl" }
        {elseif $userId|eq('')|not()}{if eq($node.class_identifier,'bouygues_whoswho_list')}{def $hideSearch = 1}{/if}{include uri="design:blocs/whoswhouser.tpl"}
        {elseif and($userId|eq(''), eq($node.class_identifier,'bouygues_whoswho_search'))}{include uri="design:blocs/whoswhosearch.tpl"}
        {/if}
        
        	
	 </div>
	 {undef $currentUser}
	<div id="activx"></div>
	{literal}
	<script type="text/javascript">
		eby.loadActiveX();
		$().ready(function(){
			eby.checkClickToCall();
		});
	</script>
	{/literal}
		