{def $userData = fetch('whoswho', 'whoswho_fetch', hash('user_id', $userId, 'ww_id', $ww_id))}
{def $userSearched = fetch('content', 'object', hash('object_id', $userId))}
{def $searchFields = fetch('whoswho', 'whoswho_settings_search',  hash('ww_id', $ww_id ))}
{def $viewableFields = fetch('whoswho', 'whoswho_settings_fields',  hash('ww_id', $ww_id ))}
{def $entreprise = fetch('whoswho', 'search_option_value', hash('id',$userData.0.entreprise))}
{def $secteur=fetch('whoswho', 'search_option_value', hash('id',$userData.0.secteur))}
{def $filiale=fetch('whoswho', 'search_option_value', hash('id',$userData.0.filiale))}
{def $picEntreprise = ''}

{if eq($entreprise|upcase(), 'BOUYGUES CONSTRUCTION')}{set $picEntreprise = 'bouyguesC'}
{elseif eq($entreprise|upcase(), 'COLAS')}{set $picEntreprise = 'colas'}
{elseif eq($entreprise|upcase(), 'FINAGESTION')}{set $picEntreprise = ''}
{elseif eq($entreprise|upcase(), 'TF1')}{set $picEntreprise = 'tf1'}
{elseif eq($entreprise|upcase(), 'BOUYGUES TELECOM')}{set $picEntreprise = 'bouyguesT'}
{elseif eq($entreprise|upcase(), 'BOUYGUES SA')}{set $picEntreprise = 'bouyguesSA'}
{elseif eq($entreprise|upcase(), 'BOUYGUES IMMOBILIER')}{set $picEntreprise = 'bouyguesI'}
{elseif eq($entreprise|upcase(), 'C2S')}{set $picEntreprise = 'c2s'}{/if}

{if eq($hideSearch, 1)|not()}
<div class="search">
	{include uri="design:blocs/whoswhosearchform.tpl"}	
</div>
{/if}

<div class="user">
	<div class="user-top"></div>
	<div class="user-middle">
		{if is_set($viewableFields['image'])}
		{if and($userSearched.data_map.image.has_content, $userSearched.data_map.image.content.whoswho_user|null()|not())}{def $imgUrl = $userSearched.data_map.image.content.whoswho_user.url|ezroot(no)}
		{else}{def $imgUrl = concat('images/general/default-whoswho.jpg')|ezdesign(no)}{/if}
		<span class="pic"><img src="{$imgUrl}" title="{$userSearched.data_map.first_name.content} {$userSearched.data_map.last_name.content}" alt="{$userSearched.data_map.first_name.content} {$userSearched.data_map.last_name.content}"/></span>{/if}
		<p class="details">
			<span class="title color2">{$userSearched.data_map.first_name.content} {$userSearched.data_map.last_name.content}</span>
			<span class="age">{if and(is_null($userData.0.age)|not(),is_set($viewableFields['date_naissance']))}
					{$userData.0.age} {"ans"|i18n("design/bouygues/whoswho")} - {/if}
					{if and(is_null($userData.0.age_by)|not(),is_set($viewableFields['date_entree']))}
						{if $userData.0.age_by|eq(0)}{"less_than_one_in_group"|i18n("design/bouygues/whoswho")}
						{else}{$userData.0.age_by} {"more_than_one_in_group"|i18n("design/bouygues/whoswho")}
						{/if}
					{/if}</span>
			{if is_set($viewableFields['fonction'])}<span class="function">{$userData.0.fonction}</span>{/if}
			
			{if is_set($viewableFields['entreprise'])}
			<span class="enterprise">	
				{if eq($entreprise,'')|not()}{def $entrFiliale = $entreprise}{/if}
				{if eq($filiale, '')|not()}{def $entrFiliale = $filiale}{/if}
				{if eq($userData.0.filiale_autre,'')|not()}{def $entrFiliale = $userData.0.filiale_autre}{/if}	
				<span style="text-transform: uppercase">{$entrFiliale}</span>
			</span>
			{/if}
				
			{if is_set($viewableFields['direction'])}<span class="department">{if eq($userData.0.direction, '')|not()}{$userData.0.direction}{else}{fetch('whoswho', 'search_option_value', hash('id',$userData.0.service))}{/if}</span>{/if}
		</p>
		{if $picEntreprise|eq('')|not()}<span class="logo"><img src="{concat('images/logos/',$picEntreprise,'.gif')|ezdesign(no)}" align="absmiddle"/>	</span>{/if}
	</div>
	<div class="user-bottom"></div>
	
	<div class="user-item">
		<span class="title">{"contact_details"|i18n("design/bouygues/whoswho")}</span>
		<p class="details">
			{if is_set($viewableFields['pro_adresse'])}<span class="text">{$userData.0.pro_adresse|nl2br()}</span>{/if}
			{if and(eq($userData.0.emplacement,'')|not(),is_set($viewableFields['emplacement']))}<span class="text">{$userData.0.emplacement|nl2br()}</span>{/if}
			<span class="email"><a href="mailto:{$userSearched.data_map.user_account.content.email}">{$userSearched.data_map.user_account.content.email}</a></span>
			<span class="telfaxmobile">
				{if and($userData.0.pro_tel|eq('')|not(),is_set($viewableFields['pro_tel']))}<span class="tel"><span  class="clicktocalllink" onclick="eby.annuaireMakeCall('', '{$userData.0.pro_tel}')" style="cursor: pointer"><img src="{concat('images/pictos/phone','.gif')|ezdesign(no)}" align="absmiddle"/>&nbsp;&nbsp;<span class="color2"><strong>{$userData.0.pro_tel}</strong></span></span></span>{/if}
				{if and($userData.0.pro_fax|eq('')|not(),is_set($viewableFields['pro_fax']))}<span class="fax">{"fax"|i18n("extension/bouygues/whoswho")} : <span class="color2"><strong>{$userData.0.pro_fax}</strong></span></span>{/if}
				{if and($userData.0.pro_mobile|eq('')|not(), is_set($viewableFields['pro_mobile']))}<span class="mobile"><span  class="clicktocalllink" onclick="eby.annuaireMakeCall('', '{$userData.0.pro_mobile}')" style="cursor: pointer">{"mobile"|i18n("design/bouygues/whoswho")} : <span class="color2"><strong>{$userData.0.pro_mobile}</strong></span></span></span>{/if}
			</span>
		</p>
	</div>
	
	<div class="lineHr"></div>
	{if and(eq($userData.0.service,'')|not(),is_set($viewableFields['service']))}<div class="user-item"><span class="title">{"service"|i18n("extension/bouygues/whoswho")}</span><p class="details"><span class="title">{$userData.0.service}</span></p></div><div class="lineHr"></div>{/if}
	{if and(eq($entreprise,'')|not(),is_set($viewableFields['entreprise']))}<div class="user-item"><span class="title">{"entreprise"|i18n("extension/bouygues/whoswho")}</span><p class="details"><span class="title">{$entreprise}</span></p></div><div class="lineHr"></div>{/if}
	{if and(eq($secteur,'')|not(),is_set($viewableFields['secteur']))}<div class="user-item"><span class="title">{"secteur"|i18n("extension/bouygues/whoswho")}</span><p class="details"><span class="title">{$secteur}</span></p></div><div class="lineHr"></div>{/if}
	{if and(eq($userData.0.assistante_nom,'')|not(),is_set($viewableFields['assistante_nom']))}<div class="user-item"><span class="title">{"assistante_nom"|i18n("extension/bouygues/whoswho")}</span><p class="details"><span class="title">{$userData.0.assistante_nom} <br/>{$userData.0.assistante_tel}</span></p></div><div class="lineHr"></div>{/if}
	{if and(eq($userData.0.diplome,'')|not(),is_set($viewableFields['diplome']))}<div class="user-item"><span class="title">{"diplome"|i18n("extension/bouygues/whoswho")}</span><p class="details"><span class="title">{$userData.0.diplome|nl2br()}</span></p></div><div class="lineHr"></div>{/if}
	{if and(eq($userData.0.parcours_pro,'')|not(),is_set($viewableFields['parcours_pro']))}<div class="user-item"><span class="title">{"parcours_pro"|i18n("extension/bouygues/whoswho")}</span><p class="details"><span class="title">{$userData.0.parcours_pro|nl2br()}</span></p></div><div class="lineHr"></div>{/if}
	{if and(eq($userData.0.mission_actuelle,'')|not(),is_set($viewableFields['mission_actuelle']))}<div class="user-item"><span class="title">{"mission_actuelle"|i18n("extension/bouygues/whoswho")}</span><p class="details"><span class="title">{$userData.0.mission_actuelle|nl2br()}</span></p></div><div class="lineHr"></div>{/if}
	{if and(eq($userData.0.mission_precedente,'')|not(),is_set($viewableFields['mission_precedente']))}<div class="user-item"><span class="title">{"mission_precedente"|i18n("extension/bouygues/whoswho")}</span><p class="details"><span class="title">{$userData.0.mission_precedente|nl2br()}</span></p></div><div class="lineHr"></div>{/if}
	{if and(eq($userData.0.competences,'')|not(),is_set($viewableFields['competences']))}<div class="user-item"><span class="title">{"competences"|i18n("extension/bouygues/whoswho")}</span><p class="details"><span class="title">{$userData.0.competences|nl2br()}</span></p></div><div class="lineHr"></div>{/if}
	{if and(eq($userData.0.centres_interet,'')|not(),is_set($viewableFields['centres_interet']))}<div class="user-item"><span class="title">{"centres_interet"|i18n("extension/bouygues/whoswho")}</span><p class="details"><span class="title">{$userData.0.centres_interet|nl2br()}</span></p></div><div class="lineHr"></div>{/if}
	
	<div class="user colorDefault1">
		<em>{'file_updated'|i18n("design/bouygues/whoswho")}{$userData.0.dt_etat|datetime('custom','%d/%m/%Y')|downcase}</em>
	</div>
	
	<div class="button">
	{include uri="design:blocs/btn.tpl" arrow=1 label="back_to_list"|i18n("design/bouygues/prestataire") url='javascript:history.go(-1);' align='right'}
	{if $currentUser.contentobject_id|eq($userId)}{include uri="design:blocs/btn.tpl" arrow=1 label="update_data"|i18n("design/bouygues/whoswho") url='/profile/yourwhoswhodata'|ezurl(no) align='right'}{/if}
	</div>
	
	<div class="legal">{"legal"|i18n("design/bouygues/whoswho")}</div>
</div>
{undef $userData $userSearched $searchFileds $viewableFields $entreprise $service $filiale $entreprise $picEntreprise}