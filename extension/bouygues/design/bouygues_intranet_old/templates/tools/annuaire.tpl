{set-block scope=global variable=cache_ttl}0{/set-block}

<script type="text/javascript">var varErrorMakeCall='{"makecall_error"|i18n("design/bouygues/annuaire")}';</script>
<div class="annuaire">

	<div class="boxA">
		<div class="content">
			
			{if is_set(ezhttp('userPrenom','get'))}
			{def $viewparameters=hash('userPrenom', ezhttp('userPrenom','get'),
									'userNom',ezhttp('userNom','get'),
									'userInitiales',ezhttp('userInitiales','get'),
									'userEntreprise',ezhttp('userEntreprise','get'),
									'enlarge',ezhttp('enlarge','get'),
									'nbresult',ezhttp('nbresult','get'))}{/if}
							
			{include uri="design:blocs/tools.tpl" annuaire=1 view_parameters=$viewparameters}
			
			<div class="bloc-search">
				<h2><img src="{concat("images/","boxes/annuaire/pictoSearch.png")|ezdesign(no)}" alt="Rechercher dans l'annuaire" /> {"search_label"|i18n("design/bouygues/annuaire")}</h2>
				<div id="" class="contactGroup">
				<form action="{'/annuaire'|ezurl(no)}" method="get" id="annuaireForm">
					<input type="hidden" name="search" value="1" />
					<input type="hidden" name="enlarge" value="0" />
					<input type="hidden" name="nbresult" value="20" />
					<label>{"search_lastname"|i18n("design/bouygues/annuaire")} </label><input type="text" name="userNom" id="userNom" class="text" value="{$lastname}" title="{"search_error"|i18n("design/bouygues/annuaire")}"/><br />
					<label>{"search_firstname"|i18n("design/bouygues/annuaire")} </label><input type="text" name="userPrenom" id="userPrenom" class="text" value="{$firstname}" /><br />
					<label>{"search_initial"|i18n("design/bouygues/annuaire")} </label><input type="text" name="userInitiales" id="userInitiales" class="text initials" value="{$initial}" title="{"search_initial_error"|i18n("design/bouygues/annuaire")}" maxlength="5"/><br />
					<label>{"search_entreprise"|i18n("design/bouygues/annuaire")} </label><select id="userEntreprise"  name="userEntreprise" >			
						
						{foreach $annuaireMenu.metier as $key => $value}
						<option value="{$key}"  {if or(and(eq($entreprise,$key), is_set($entreprise)), and($value.pardefaut|eq('true'), is_unset($entreprise)))}selected="selected"{/if} {if or($value.indisponible|eq('true'),$value.easynetDispo|eq('0'), $value.enMaintenance|eq('true'))}disabled="disabled"{/if}>{$value.libelleLong|i18n('design/bouygues/annuaire')} {if or($value.indisponible|eq('true'),$value.easynetDispo|eq('0'))}{$value.indisponible_long}{elseif $value.enMaintenance|eq('true')}{$value.maintenance_long}{/if}</option>
						{/foreach}
						
					</select><br />
							
					<span class="mandatoryfields"><span></span></span>
					<span class="displayNoneAccesibility"><input type="submit" value="{"contact_search_submit"|i18n("design/bouygues/accessibility")}"/></span>
					<a href="#" onclick="$(this).parents('form').submit(); return false;" class="submit-btn-go" title="{"contact_search_submit"|i18n("design/bouygues/accessibility")}"></a>
					<p class="legal" id="activeXInfo" style="display: none">{"activex_install1"|i18n("design/bouygues/annuaire")|nl2br()} <a href="{'/static/webmaster'|ezurl(no)}">{"activex_install2"|i18n("design/bouygues/annuaire")|nl2br()}</a>.<br/><br/>
						{"activex_install3"|i18n("design/bouygues/annuaire")|nl2br()} <a href="{'/annuaire'|ezurl(no)}" onclick="return eby.getActiveX();">{"activex_install4"|i18n("design/bouygues/annuaire")|nl2br()}</a>.</p>
				</form>	
				</div>
			</div>
		
			<div class="bloc-result">
				<h2>{"result_label"|i18n("design/bouygues/annuaire")}</h2>
				
				{if is_set($results)}
				
				{if and(eq($results.isMax, 'true')|not(), $nbresult|lt(100))}
				<p class="noresult">
					<strong>{"result_more"|i18n("design/bouygues/annuaire")}</strong>
				</p>
				{/if}
				
				<div class="results">
					{def $countResult=0 $paginationStart=1}{def $divClass=0}
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
						{if $paginationStart|eq(1)}{set $divClass=$divClass|inc()}<div id="divPage{$divClass}" {if $nbresult|gt(20)}style="display: none"{/if}>{/if}
						<div class="item">
							<span class="icon"></span>
							<span class="collaborator">
								{$result.name} {$result.givenName}
								
								{if eq($result.photo, '')|not()}<img src="{'/annuaire/photo/?id='|ezroot(no)}{$result.id}" align="absmiddle" alt="{$result.givenName} {$result.name}" width="95" class="collaborator_pic"/>{/if}
								{if $picEntreprise|eq('')|not()}<img src="{concat('images/logos/',$picEntreprise,'.gif')|ezdesign(no)}" align="absmiddle" class="picto"/>{/if}	
							
							</span>
							<span class="function">
								<span class="big">{$result.company}<br/>
								<span class="blue">{$result.title}</span><br/></span>
								{if eq($result.organizationalUnit, '')|not()}<span class="small">{$result.organizationalUnit}&nbsp;</span>{/if}
								{if eq($result.mail, '')|not()}<p class="mail">{$result.mail}</p>{/if}
								{if eq($result.workSite, '')|not()}<span class="adresse">{$result.workSite}<br/>
								{$result.location}{if eq($result.streetAddress, '')|not()}<br/> {$result.streetAddress}<br/> {$result.city} /  {$result.country}<br/>{/if}</span>{/if}
								<span class="assistante">
									{if eq($result.secretaryName, '')|not()}{"assistante"|i18n("design/bouygues/annuaire")} {$result.secretaryName}<br/>
									{"assistante_tel"|i18n("design/bouygues/annuaire")} <span class="clicktocalllink" onclick="eby.annuaireMakeCall('{$key}', '{$result.secretaryPhone}')" style="cursor: pointer">{$result.secretaryPhone}</span>{/if}
								</span>
								
							</span>
							<span class="phone">
								{if eq($result.telephoneNumber, '')|not()}<span class="orange clicktocalllink" onclick="eby.annuaireMakeCall('{$key}', '{$result.telephoneNumber}')" style="cursor: pointer"><strong><img src="{concat('images/pictos/phone','.png')|ezdesign(no)}" align="absmiddle" />&nbsp;&nbsp; {$result.telephoneNumber}</strong></span><br/>{/if}
								{if eq($result.mobile, '')|not()}<span class="mobile clicktocalllink" onclick="eby.annuaireMakeCall('{$key}', '{$result.mobile}')" style="cursor: pointer">Mobile : {$result.mobile}</span>{/if}
								{if eq($result.facsimileTelephonenumber, '')|not()}<span class="fax">Fax : {$result.facsimileTelephonenumber}</span>{/if}
							
							</span>
							
							<div style="float: right; height: 60px;width: 25px">{if or(eq($result.mobile, '')|not(),
										eq($result.facsimileTelephonenumber, '')|not(),
										eq($result.secretaryName, '')|not(),
										eq($result.photo, '')|not(),
										eq($result.workSite, '')|not())}<a href="#" class="more" ></a><br/>{/if}
										</div>
		<a href="{'/annuaire/imprimer/?id='|ezroot(no)}{$result.id}" class="printIcon" target="_blank" onclick="return true;"></a>

						</div>
						{if $paginationStart|eq(20)}{set $paginationStart=1}</div>{else}{set $paginationStart=$paginationStart|inc()}{/if}
						{set $countResult=$countResult|inc()}
						{/foreach}
					{/foreach}
				</div>
				{def $nbPage=$countResult|div(20)|ceil()}
				{if and(eq($results.isMax, 'true')|not(), $nbresult|lt(500))}
				
				<div style="clear: both"></div>
				<p class="noresult" style="display: none" id="searchNextDiv">
					<strong>{"search_more2"|i18n("design/bouygues/annuaire")} {$nbresultNext} {"search_more2bis"|i18n("design/bouygues/annuaire")}</strong> <br/><br/>{include uri="design:blocs/btn.tpl" label="result_more_search"|i18n("design/bouygues/annuaire") url='#' onclick=concat("$('input[name=nbresult]').val('",$nbresultNext,"'); $('input[name=enlarge]').val('",$enlarge,"'); $('#annuaireForm').submit();return false;")}
				</p>
				{/if}
				{if and($countResult|gt(20), $nbresult|gt(20))}
					
					<div style="clear: both"></div>
					<div class="pagination">	
						<div class="pagenavigator">
							<p>   	
							<a onclick="return false;" class="divPageButtonPrevious previous" href="#" rel=""><span class="text">{"Previous"|i18n("design/bouygues/navigator")}</span></a>	
							<span class="pages">
									{def $counterPage=0}
									{while $counterPage|lt($nbPage) }

									    <span class="other"><a onclick="return eby.annuairePagination($(this), '{$nbPage}')" href="#"  rel="divPage{$counterPage|inc()}" class="divPageButton">{$counterPage|inc()}</a></span>
									    {set $counterPage=inc( $counterPage )}

									{/while}
							</span>
							<a onclick="return false;" class="divPageButtonNext next" href="#" rel="divPage2"><span class="text">{"Next"|i18n("design/bouygues/navigator")}</span></a>		
							</p>
							<div class="break"/>

						</div>
					</div>
	
				
				{/if}
				
				{else}
				
				<p class="noresult">
					<strong>
					{if $enlarge|eq('1')}
						{"result_none_title"|i18n("design/bouygues/annuaire")}
					{else}
						{"result_none_title_1"|i18n("design/bouygues/annuaire")}
					{/if}</strong>
					<br/><br/>
					{if $enlarge|eq('1')|not()}
					{"result_none_content1"|i18n("design/bouygues/annuaire")|nl2br()}<br/>
					<a href="#" onclick="$('input[name=enlarge]').val('1'); $('#annuaireForm').submit(); return false;">{"result_none_content2"|i18n("design/bouygues/annuaire")|nl2br()}</a><br/>
					{"result_none_content3"|i18n("design/bouygues/annuaire")|nl2br()}
					{/if}
				</p>				
				{/if}
			</div>
		
		</div>
		<div class="bottom">
			<div class="left"></div>
			<div class="right"></div>
			<div class="middle"></div>
		</div>
	</div>
</div>
<div id="activx"></div>
{literal}
<script type="text/javascript">
	var currentPage = 'divPage1';
	var currentPageInt = 1;
	var nextPage = 'divPage2';
	var previousPage = null;
	
	eby.loadActiveX();
	
	$().ready(function(){
		
		eby.checkClickToCall();
				
		{/literal}{if and(eq($results.isMax, 'true')|not(), $nbresult|lt(100))}{literal}
			$('#searchNextDiv').css('display', 'block');
		{/literal}{/if}{literal}
		
		{/literal}{if and($counterPage,$nbresult|gt(20), $counterPage|gt(0))}{literal}
	
		
		$('.divPageButtonPrevious').click(function(){
			$('a.divPageButton[rel='+previousPage+']').trigger('click');
		});
		
		$('.divPageButtonNext').click(function(){
			$('a.divPageButton[rel='+nextPage+']').trigger('click');
		});
		
		eby.annuairePagination($('a.divPageButton[rel=divPage1]'), '{/literal}{$counterPage}{literal}');
		
		{/literal}{else}$('#divPage1').css('display', 'block');{/if}{literal}
		
		$("#annuaireForm").validate({
			errorContainer: $('.mandatoryfields'),
			errorLabelContainer: $("span", $('.mandatoryfields')),
			errorElement: "span",
			wrapper: '',
			rules: {
				userNom: {
					required: function(element) {
						if($("#annuaireForm input[name=userInitiales]").val() == '')
							return true;
						else
							return false;
		      		}
				}
			}
		});
		
		
	});
	
	{/literal}{if and($counterPage,$nbresult|gt(20), $counterPage|gt(0))}{/if}{literal}
</script>
{/literal}