<form id="formSearch" method="get" action="{$node.url|ezurl(no)}" name="whoswhoSearchForm">
	<input type="hidden" name="status" value="1"/>
	<input type="hidden" name="pg" value="1"/>
	{def $counter = 1}{def $field_options = ''}
	{foreach $searchFields as $key => $searchField}{if eq($counter, 3)}{set $counter = 1}{/if}
	<span class="col{$counter}">
	<label for="select-{$key}">{$key|i18n("extension/bouygues/whoswho")} {if eq($searchField.mandatory, true())}*{/if}</label>
	{if eq($searchField.searchType, 'select')}{set $field_options = fetch('whoswho', 'search_options', hash('type', $key, 'section_id', $section_id))}
	<select id="select-{$key}" name="{$key}" class="{if eq($searchField.mandatory, true())}required{/if}" style="{if $key|eq('filiale')}text-transform: uppercase{/if}" onKeyPress="eby.checkEnter(event, $('#formSearch'))"> 
		<option value=""> --- </option>
		{foreach $field_options as $field_option}<option value="{$field_option.id}" {if ezhttp($key,'get')|eq($field_option.id)}selected{/if} title="{$field_option.valeur}">{$field_option.valeur}</option>{/foreach}
	</select>{else}<input type="text" id="select-{$key}" value="{ezhttp($key,'get')}" name="{$key}" {if eq($searchField.mandatory, true())}class="required"{/if} onKeyPress="eby.checkEnter(event, $('#formSearch'))"  style="{if $key|eq('filiale_autre')}text-transform: uppercase{/if}"/>{/if}</span>
	{set $counter = inc($counter)}{/foreach}

	<div class="submit">
			<span class="displayNoneAccesibility"><input type="submit" value="{"whoswho_search_submit"|i18n("design/bouygues/accessibility")}"/></span>
		<a class="submit-btn-go" style="float: right;" onclick="$('#formSearch').submit(); return false;" href="/#" title="{"whoswho_search_submit"|i18n("design/bouygues/accessibility")}"></a>
		<!--<span class='btn_mandatory'>{"obligatory_fields"|i18n("design/bouygues/whoswho")}</span>-->
	</div>
</form>
{undef $counter $field_options} 