{set-block scope=global variable=cache_ttl}0{/set-block}
{def $user=fetch( 'user', 'current_user' )}

<div style="clear: both;margin-top: 15px"></div>
<strong>{'widget_contact_result'|i18n('design/bouygues/ebyperso')}</strong><br /><br />

<div id="contact_carousel" class="contact_carousel">

	<div class="mycarousel global">
	<div class="mycarousel container">	
{def $count_items=0}	
{foreach $results.result as $key => $value}
	{def $picEntreprise = ''}
	{if eq($key, 'BYCONST')}{set $picEntreprise = 'bouyguesC'}
	{elseif eq($key, 'COLAS')}{set $picEntreprise = 'colas'}
	{elseif eq($key, 'FINA')}{set $picEntreprise = ''}
	{elseif eq($key, 'TF1')}{set $picEntreprise = 'tf1'}
	{elseif eq($key, 'BYTEL')}{set $picEntreprise = 'bouyguesT'}
	{elseif eq($key, 'BYSA')}{set $picEntreprise = 'bouyguesSA'}
	{elseif eq($key, 'BYIMMO')}{set $picEntreprise = 'bouyguesI'}
	{elseif eq($key, 'C2S')}{set $picEntreprise = 'c2s'}{/if}
	
			{foreach $value.users as $result}
				{def $isFavorite = isUserFavorite($user.contentobject_id, $result.id)}
				{if or($count_items|mod(3)|eq(0),$count_items|eq(0))}<div class="item">{/if}
				<span class="overview">
					{if $picEntreprise|eq('')|not()}<span class="item-left">
						<img src="{concat('images/logos/',$picEntreprise,'.gif')|ezdesign(no)}" align="absmiddle" class="picto"/>	
					</span>{/if}
					<span class="item-middle">
						{$result.name} {$result.givenName}
					</span>
					
					{if $isFavorite|eq(false())}
					<span class="item-right">
						{include uri="design:blocs/btn.tpl" label="widget_add"|i18n("design/bouygues/ebyperso") url='#' onclick=concat('eby.addFavorite(\'',$user.contentobject.id,'\'',',\'',$result.id,'\');return false;')}
					</span>
					{/if}
				</span>
				{if or($count_items|inc(3)|mod(3)|eq(0),$count_items|eq($value.users|count|sub(1)))}</div>{/if}
							
				{set $count_items=inc($count_items)}
			{/foreach}
			
{/foreach}
		</div>
	</div>
	{if $count_items|gt(3)}
	<div class="pagination-ajax-contact">
		{include uri="design:blocs/btn.tpl" label="Previous"|i18n("design/bouygues/navigator") url='#' onclick='return false;' class='mycarousel slide-prev'}
		{include uri="design:blocs/btn.tpl" label="Next"|i18n("design/bouygues/navigator") url='#' onclick='return false;' class='mycarousel slide-next'}
	</div>
	{/if}
</div>

{literal}
<script type="text/javascript">
	$().ready(function(){
		$('#contact_carousel').slideMajes({'numElementDisplayed':'1', 'type':'horizontal','animateDuration':500});			
	});
</script>
{/literal}