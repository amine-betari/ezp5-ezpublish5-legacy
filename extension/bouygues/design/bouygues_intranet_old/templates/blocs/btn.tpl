{def $type_url = $url|extract_left(10)}

<a href="{if and(is_set($url), $url|eq('#'))}#{elseif and(is_set($url), $type_url|eq('javascript')|not())}{$url|ezroot(no)}{elseif eq($type_url,'javascript')}{$url}{/if}" {if is_set($submit)}onclick="$('#{$submit}').submit(); return false;"{elseif is_set($onclick)}onclick="{$onclick}"{/if} class="btn{if is_set($class)} {$class}{/if}" {if $align|eq('right')}style="float:right"{/if} {if is_set($target)}target="{$target}"{/if} {if is_set($nameBtn)}name="{$nameBtn}"{/if} {if is_set($rel)}rel="{$rel}"{/if}>
	<span class="leftBtn">&nbsp;</span>
	<span class="labelBtn {if is_set($arrow)}label-text-right{/if}">{$label}</span>
	<span class="right{if is_set($arrow)}-arrow{else}Btn{/if}">&nbsp;</span>
</a>

{if is_set($submit)}<div class="displayNoneAccesibility"><input type="submit" value="{$label}"/></div>{/if}
{undef $type_url}