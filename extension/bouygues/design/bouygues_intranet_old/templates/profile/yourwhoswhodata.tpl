<link type="text/css" rel="stylesheet" href={'stylesheets/datePicker.css'|ezdesign} />
<script type="text/javascript" src={'javascript/date.js'|ezdesign}></script>
<script type="text/javascript" src={'javascript/jquery.datePicker.js'|ezdesign}></script>
<script type="text/javascript" src={'javascript/date_fr.js'|ezdesign}></script>
<div class="profile whoswho">

	{include uri="design:blocs/tools.tpl" light=1}
	
	<h1>{'whoswhodata_title'|i18n('design/bouygues/whoswho')}</h1>
	
	<h3>{'whoswhodata_desc'|i18n('design/bouygues/whoswho')|nl2br()}</h3>
	
	<p class="whoswhodata">{'whoswhodata_higlight'|i18n('design/bouygues/whoswho')|nl2br()}</p>
	
	{foreach $whoswholist as $whoswho}
		{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}
		{if is_set($arrCssSubStructure[$whoswho.parent.object.section_id])}{def $classCss = $arrCssSubStructure[$whoswho.parent.object.section_id]}
		{else}{def $classCss = 'default'}{/if}
	
	<span class="overview-{$arrCssSubStructure[$whoswho.parent.object.section_id]}"><a href="#" class="whoswho-item" onclick="highlightFields('{$whoswho.object.id}', '{$classCss}');return false;"><img src="{concat('images/breadcrumb/',$arrCssSubStructure[$whoswho.parent.object.section_id],'/start.gif')|ezdesign(no)}"/>{$whoswho.parent.object.data_map.titre.content}</a></span>
	{/foreach}
	{def $field_options = ''}
	<form method="POST" id="formWhoswho" enctype="multipart/form-data">
	<input type="hidden" name="action" value="update"/>
	<input type="hidden" name="email_old" value="{if is_set($currentUser)}{$currentUser.email}{/if}"/>
	
	<div class="group communication">
		
		<span class="title">{$obj_co.data_map.first_name.content|wash} {$obj_co.data_map.last_name.content|wash}</span>
		
		<span class="line"><label>{'civiliy'|i18n('extension/bouygues/whoswho')}</label><span class="input">
		{include uri='design:profile/datatype/edit/ezselection.tpl' attribute=$obj_co.data_map.civilite}
		</span></span>
		<span class="line"><label>{'picture'|i18n('extension/bouygues/whoswho')}</label><span class="input">{if $obj_co.data_map.image.has_content}<img src="{$obj_co.data_map.image.content.whoswho_user.url|ezurl(no)}" title="" alt=""/> <br/>{/if}<input type="file" name="picture" class="border4"/></span></span>

	</div>
	
	<div class="group-separator"></div>
	
	<div class="group">
		
		<span class="title">{'whoswhodata_group_details'|i18n('design/bouygues/whoswho')}</span>
		
		<span class="line"><label>{'fonction'|i18n('extension/bouygues/whoswho')} *</label><span class="input"><input type="text" name="fonction" class="required border4" title="{'whoswho_madatory'|i18n('design/bouygues/whoswho')}" value="{$whoswhodata.fonction}"/></span></span>
		<span class="line"><label>{'direction'|i18n('extension/bouygues/whoswho')}</label><span class="input"><input type="text" name="direction" value="{$whoswhodata.direction}" class="border4"/></span></span>
		<span class="line"><label>{'service'|i18n('extension/bouygues/whoswho')}</label><span class="input"><input type="text" name="service" value="{$whoswhodata.service}" class="border4"/></span></span>
		<span class="line"><label>{'entreprise'|i18n('extension/bouygues/whoswho')} *</label><span class="input">
		
		{set $field_options = fetch('whoswho', 'search_options', hash('type', 'entreprise'))}
		<select name="entreprise" class="required border4" title="{'whoswho_madatory'|i18n('design/bouygues/whoswho')}">
			<option value="">---</option>
			{foreach $field_options as $field_option}<option value="{$field_option.id}" {if $whoswhodata.entreprise|eq($field_option.id)}selected{/if}>{$field_option.valeur}</option>{/foreach}
		</select>

		</span></span>
		<span class="line"><label>{'filiale'|i18n('extension/bouygues/whoswho')}</label><span class="input">
		
		{set $field_options = fetch('whoswho', 'search_options', hash('type', 'filiale'))}
		<select name="filiale" class="border4" style="text-transform: uppercase">
			<option value="">---</option>
		<!-- 	<option value="">{*'filiale_default'|i18n('extension/bouygues/whoswho')*}</option> -->
			{foreach $field_options as $field_option}<option value="{$field_option.id}" {if $whoswhodata.filiale|eq($field_option.id)}selected{/if}>{$field_option.valeur}</option>{/foreach}
		</select>
		
		</span></span>
		<span class="line"><label>{'filiale_autre'|i18n('extension/bouygues/whoswho')}</label><span class="input"><input type="text" name="filiale_autre" value="{$whoswhodata.filiale_autre}" class="border4" style="text-transform: uppercase"/></span></span>
		
		<span class="line"><label>{'secteur'|i18n('extension/bouygues/whoswho')}</label><span class="input">{set $field_options = fetch('whoswho', 'search_options', hash('type', 'secteur'))}
		<select name="secteur" class="border4">
			<option value="">---</option>
			{foreach $field_options as $field_option}<option value="{$field_option.id}" {if $whoswhodata.secteur|eq($field_option.id)}selected{/if}>{$field_option.valeur}</option>{/foreach}
		</select></span></span>


	</div>

	<div class="group-separator"></div>
	
	<div class="group">
		
		<span class="title">{'whoswhodata_funtion'|i18n('design/bouygues/whoswho')}</span>
		
		<span class="line-textarea"><label>{'pro_adresse'|i18n('extension/bouygues/whoswho')}</label><span class="input"><textarea name="pro_adresse" class="border4">{$whoswhodata.pro_adresse}</textarea></span></span>
		<span class="line"><label>{'emplacement'|i18n('extension/bouygues/whoswho')}</label><span class="input"><input type="text" name="emplacement" value="{$whoswhodata.emplacement}" class="border4"/></span></span>
		<span class="line"><label>{'email'|i18n('extension/bouygues/whoswho')} *</label><span class="input"><input type="text" name="email" class="required border4" title="{'whoswho_madatory'|i18n('design/bouygues/whoswho')}" value="{if is_set($currentUser)}{$currentUser.email}{/if}" disabled/></span></span>
		<span class="line"><label>{'pro_tel'|i18n('extension/bouygues/whoswho')} *</label><span class="input"><input type="text" name="pro_tel" class="required border4" title="{'whoswho_madatory'|i18n('design/bouygues/whoswho')}" value="{$whoswhodata.pro_tel}"/><span class="whoswho-form-help">{'pro_tel_help'|i18n('extension/bouygues/whoswho')}</span></span></span>
		<span class="line"><label>{'pro_mobile'|i18n('extension/bouygues/whoswho')}</label><span class="input"><input type="text" name="pro_mobile" value="{$whoswhodata.pro_mobile}" class="border4"/></span></span>
		<span class="line"><label>{'pro_fax'|i18n('extension/bouygues/whoswho')}</label><span class="input"><input type="text" name="pro_fax" value="{$whoswhodata.pro_fax}" class="border4"/></span></span>
		<span class="line"><label>{'assistante_nom'|i18n('extension/bouygues/whoswho')}</label><span class="input"><input type="text" name="assistante_nom" value="{$whoswhodata.assistante_nom}" class="border4"/></span></span>
		<span class="line"><label>{'assistante_tel'|i18n('extension/bouygues/whoswho')}</label><span class="input"><input type="text" name="assistante_tel" value="{$whoswhodata.assistante_tel}" class="border4"/></span></span>

	</div>
	
	<div class="group-separator"></div>

	<div class="group">
		
		<span class="title">{'whoswhodata_background'|i18n('design/bouygues/whoswho')}</span> 
		<span class="line-desc"></span>
		
		<span class="line"><label>{'date_naissance'|i18n('extension/bouygues/whoswho')}</label><span class="input"><input type="text" class="date border4" name="date_naissance" value="{$whoswhodata.date_naissance}"/><span class="whoswho-form-help">{'date_naissance_help'|i18n('extension/bouygues/whoswho')}</span></span></span>
		<span class="line"><label>{'date_entree'|i18n('extension/bouygues/whoswho')}</label><span class="input"><input type="text" class="date border4" name="date_entree" value="{$whoswhodata.date_entree}"/><span class="whoswho-form-help">{'date_entree_help'|i18n('extension/bouygues/whoswho')}</span></span></span>
		<span class="line-textarea"><label>{'diplome'|i18n('extension/bouygues/whoswho')}</label><span class="input"><textarea name="diplome" class="border4">{$whoswhodata.diplome}</textarea><span class="whoswho-form-help">{'diplome_help'|i18n('extension/bouygues/whoswho')}</span></span></span>
		<span class="line-textarea"><label>{'parcours_pro'|i18n('extension/bouygues/whoswho')}</label><span class="input"><textarea name="parcours_pro" class="border4">{$whoswhodata.parcours_pro}</textarea><span class="whoswho-form-help">{'parcours_pro_help'|i18n('extension/bouygues/whoswho')}</span></span></span>
		<span class="line-textarea"><label>{'mission_actuelle'|i18n('extension/bouygues/whoswho')}</label><span class="input"><textarea name="mission_actuelle" class="border4">{$whoswhodata.mission_actuelle}</textarea></span></span>
		<span class="line-textarea"><label>{'mission_precedente'|i18n('extension/bouygues/whoswho')}</label><span class="input"><textarea name="mission_precedente" class="border4">{$whoswhodata.mission_precedente}</textarea></span></span>
		<span class="line-textarea"><label>{'competences'|i18n('extension/bouygues/whoswho')}</label><span class="input"><textarea name="competences" class="border4">{$whoswhodata.competences}</textarea></span></span>
	</div>
	<div class="group">
		
		<span class="title">{'whoswhodata_more_details'|i18n('design/bouygues/whoswho')}</span> 
		<span class="line-textarea"><label>{'centres_interet'|i18n('extension/bouygues/whoswho')}</label><span class="input"><textarea name="centres_interet" class="border4">{$whoswhodata.centres_interet}</textarea></span></span>
	</div>
	
	<div class="submit">
		{include uri="design:blocs/btn.tpl" label='whoswho_validate'|i18n('design/bouygues/whoswho') url='#' submit='formWhoswho' align='right'}
		<span class='btn_mandatory'>{'whoswhodata_mandatory'|i18n('design/bouygues/whoswho')}</span>
	</div>
	
	<div class="group"><a href="{'/static/legals/#whoswho'|ezurl(no)}">{'whoswhodata_mentions'|i18n('design/bouygues/whoswho')|nl2br()}</a></div>
	</form>
</div>


{literal}
<script type="text/javascript">
	$().ready(function(){
		eby.formWhoswho();
	});
	
	var oldClass = '';
	var viewableFields = new Array();
	{/literal}
	{def $viewableFields=''}
	{foreach $whoswholist as $whoswho}
		viewableFields[{$whoswho.object.id}] = {literal}new Array();{/literal}
		{set $viewableFields = fetch('whoswho', 'whoswho_settings_fields',  hash('ww_id', $whoswho.object.id ))}
		viewableFields[{$whoswho.object.id}] = [{foreach $viewableFields as $key => $viewableField}'{$key}'{delimiter},{/delimiter}{/foreach}];
		
	{/foreach}
	
	{if is_set($updateData)}eby.formWhoswhoSubmitted();{/if}
	{literal}
	
	function highlightFields(ww_id, css){
		if(oldClass != ''){
			$('input').removeClass(oldClass);
			$('select').removeClass(oldClass);
			$('textarea').removeClass(oldClass);
		}
		oldClass = 'border4-'+css;
		
		for(i = 0; i < viewableFields[ww_id].length; i++){

			if(viewableFields[ww_id][i] == 'user_account'){
				$('[name=email]').addClass('border4-'+css);
				$('[name=civilite[]]').addClass('border4-'+css);
			}else
				$('[name='+viewableFields[ww_id][i]+']').addClass('border4-'+css);
		}
	}
	
	$.dpText = {
					TEXT_PREV_YEAR		:	'Année précédente',
					TEXT_PREV_MONTH		:	'Mois précédent',
					TEXT_NEXT_YEAR		:	'Année suivante',
					TEXT_NEXT_MONTH		:	'Mois suivant',
					TEXT_CLOSE			:	'Fermer',
					TEXT_CHOOSE_DATE	:	'Choisir cette date'
				}
	
	$('input[name=date_naissance]').datePicker({startDate:'01/01/1920'});
	$('input[name=date_entree]').datePicker({startDate:'01/01/1950'});
	
</script>
{/literal}