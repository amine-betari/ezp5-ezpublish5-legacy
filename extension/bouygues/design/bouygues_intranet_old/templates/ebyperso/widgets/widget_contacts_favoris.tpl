{def $annuaireMenu=getAnnuaireAvailability()}

<li class="widget contact" id="widget{$id}">  
	
	<div class="widget-head"></div>
	
	<div class="edit-box" style="display:none;">
		<div class="widget-edit-content">

				<fieldset>
				<legend><img src={"pictos/ebyperso_contact.gif"|ezimage} alt="" /> {'widget_contact_title'|i18n('design/bouygues/ebyperso')}</legend>
				
				<div class="block result" id="annuaireListActionsAjax">
					
					{include uri="design:tools/favorite-list-actions-ajax.tpl"}
					
				</div>
				
				
				<div class="block search">
				<form action="/annuaire" method="get" id="annuaireSearchAjax">
					<input type="hidden" name="search" value="1" />
					<input type="hidden" name="enlarge" value="0" />
					<input type="hidden" name="nbresult" value="20" />
					<input type="hidden" name="ajax" value="1" />
					<strong>{'widget_contact_search_title'|i18n('design/bouygues/ebyperso')}</strong><br /><br />
					
					<label for="userNom">{"search_lastname"|i18n("design/bouygues/annuaire")} </label><input type="text" name="userNom" id="userNom" class="text" value="" title="{"search_error"|i18n("design/bouygues/annuaire")}"/><br />
					<label for="userPrenom">{"search_firstname"|i18n("design/bouygues/annuaire")} </label><input type="text" name="userPrenom" id="userPrenom" class="text" value="" /><br />
					<label for="userInitiales">{"search_initial"|i18n("design/bouygues/annuaire")} </label><input type="text" name="userInitiales" id="userInitiales" class="initials text" value="" title="{"search_initial_error"|i18n("design/bouygues/annuaire")}" maxlength="5"/><br />
					<label for="userEntreprise">{"search_entreprise"|i18n("design/bouygues/annuaire")} </label><select id="userEntreprise"  name="userEntreprise" >
						{foreach $annuaireMenu.metier as $key => $value}
						<option value="{$key}"  {if or(and(eq($entreprise,$key), is_set($entreprise)), and($value.pardefaut|eq('true'), is_unset($entreprise)))}selected="selected"{/if} {if or($value.indisponible|eq('true'),$value.easynetDispo|eq('0'), $value.enMaintenance|eq('true'))}disabled="disabled"{/if}>{$value.libelleLong|i18n('design/bouygues/annuaire')} {if or($value.indisponible|eq('true'),$value.easynetDispo|eq('0'))}{$value.indisponible_long}{elseif $value.enMaintenance|eq('true')}{$value.maintenance_long}{/if}</option>
						{/foreach}		
					</select><br />
					<span class="displayNoneAccesibility"><input type="submit" value="{"contact_search_submit"|i18n("design/bouygues/accessibility")}"/></span>
					<a href="#" onclick="$('#annuaireSearchAjax').submit(); return false;" class="submit-btn-go" title="{"contact_search_submit"|i18n("design/bouygues/accessibility")}"></a>
				</form>
				<p class="legal" id="activeXInfo" style="display: none">{"activex_install1"|i18n("design/bouygues/annuaire")|nl2br()} <a href="{'/static/webmaster'|ezurl(no)}">{"activex_install2"|i18n("design/bouygues/annuaire")|nl2br()}</a>.<br/><br/>
					{"activex_install3"|i18n("design/bouygues/annuaire")|nl2br()} <a href="{'/annuaire'|ezurl(no)}" onclick="return eby.getActiveX();">{"activex_install4"|i18n("design/bouygues/annuaire")|nl2br()}</a>.</p>
				<div class="result" id="annuaireResultAjax"></div>
						
				</div>
				

			</fieldset>

		</div>	
		<div class="widget-edit-bottom">	
		</div>
	</div>
	
	
	<div class="widget-title">
		<h3><img src={"pictos/ebyperso_contact.gif"|ezimage} alt="" /> {'widget_contact_title'|i18n('design/bouygues/ebyperso')}</h3>
	</div>
	<div class="widget-content">
		<div class="widget-overview" id="annuaireFavoriteList">{include uri="design:tools/favorite-list-ajax.tpl" }</div>

	</div>
<div class="widget-bottom"></div>	
</li>
<div id="activx"></div>
{undef $annuaireMenu}
	{literal}
	<script type="text/javascript">
		$().ready(function(){
				
				var options = {
					url :currentLang+'/layout/set/ajax2/annuaire',
					success : function(msg) {
						$("#annuaireResultAjax").fadeOut( function() {
							$("#annuaireResultAjax").html(msg).fadeIn();
						});
					}
				}
				
				$("#annuaireSearchAjax").validate( {
					errorElement: "span",
					submitHandler : function(error) {
						$("#annuaireSearchAjax").ajaxSubmit(options);
					}
				});

		});
	</script>
	{/literal}
