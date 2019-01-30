{def $annuaireMenu=getAnnuaireAvailability()}
<form action="{'/annuaire'|ezurl(no)}" method="get" class="contactForm">
	<fieldset>
	<legend>{'header_menu_contactgroup'|i18n('design/bouygues/accessibility')}</legend>
	<input type="hidden" name="search" value="1" />
	<input type="hidden" name="enlarge" value="0" />
	<input type="hidden" name="nbresult" value="20" />
	<label for="userNom">{"search_lastname"|i18n("design/bouygues/annuaire")} </label><input type="text" name="userNom" id="userNom" class="text" value="" title="{"search_error"|i18n("design/bouygues/annuaire")}"/><br />
	<label for="userPrenom">{"search_firstname"|i18n("design/bouygues/annuaire")} </label><input type="text" name="userPrenom" id="userPrenom" class="text" value="" /><br />
	<label for="userInitiales">{"search_initial"|i18n("design/bouygues/annuaire")} </label><input type="text" name="userInitiales" id="userInitiales" class="initials text" value="" title="{"search_initial_error"|i18n("design/bouygues/annuaire")}" maxlength="5"/><br />
	<label for="userEntreprise">{"search_entreprise"|i18n("design/bouygues/annuaire")} </label><select id="userEntreprise"  name="userEntreprise" >
		{foreach $annuaireMenu.metier as $key => $value}
		<option value="{$key}"  {if or(and(eq($entreprise,$key), is_set($entreprise)), and($value.pardefaut|eq('true'), is_unset($entreprise)))}selected="selected"{/if} {if or($value.indisponible|eq('true'),$value.easynetDispo|eq('0'), $value.enMaintenance|eq('true'))}disabled="disabled"{/if}>{$value.libelleLong|i18n('design/bouygues/annuaire')} {if or($value.indisponible|eq('true'),$value.easynetDispo|eq('0'))}{$value.indisponible_long}{elseif $value.enMaintenance|eq('true')}{$value.maintenance_long}{/if}</option>
		{/foreach}		
	</select><br />
	<span class="displayNoneAccesibility"><input type="submit" value="{"contact_search_submit"|i18n("design/bouygues/accessibility")}"/></span>
	<a href="#" onclick="$(this).parents('form').submit(); return false;" class="submit-btn-go" title="{"contact_search_submit"|i18n("design/bouygues/accessibility")}"></a>
	</fieldset>
</form>
{undef $annuaireMenu}