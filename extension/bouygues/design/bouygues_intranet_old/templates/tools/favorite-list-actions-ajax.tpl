{def $user=fetch( 'user', 'current_user' )}
{def $nbResult=count($userFavorites)}{def $counterResult=0}
{foreach $userFavorites as $key => $userFavorite}

<div class="overview">	
	
	<div class="item-left">
		{if $counterResult|eq(0)}<a href="#" class="btn-top-form-off" onclick="return false;"></a>
		{else}<a href="#" class="btn-top-form-on" onclick="eby.setOrderFavorite('{$user.contentobject.id}','{$userFavorite.id}','up');return false;"></a>{/if}
		{if $counterResult|eq(dec($nbResult))}<a href="#" class="btn-bottom-form-off" onclick="return false;"></a>
		{else}<a href="#" class="btn-bottom-form-on" onclick="eby.setOrderFavorite('{$user.contentobject.id}','{$userFavorite.id}','down');return false;"></a>{/if}
	</div>
	
	<div class="item-middle">
		{$userFavorite.name} {$userFavorite.givenName}
	</div>

	<div class="item-right">
		{include uri="design:blocs/btn.tpl" label='widget_contact_delete'|i18n('design/bouygues/ebyperso') url='#' onclick=concat('eby.delFavorite(\'',$user.contentobject.id,'\'',',\'',$userFavorite.id,'\');return false;')}
	</div>

</div>
{set $counterResult=inc($counterResult)}
{/foreach}