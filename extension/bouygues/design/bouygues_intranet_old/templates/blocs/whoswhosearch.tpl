{def $searchFields = fetch('whoswho', 'whoswho_settings_search',  hash('ww_id', $ww_id ))}

<div class="search">
	
	{include uri="design:blocs/whoswhosearchform.tpl"}
	
</div>

{if and(is_set(ezhttp('status','get')),eq(ezhttp('status','get'), '1'))}
{def $offset = mul(ezhttp('pg','get')|sub(1),10)}
{def $search_result = fetch('whoswho', 'whoswho_search', hash(
			'first_name', ezhttp('first_name','get'),
			'last_name', ezhttp('last_name','get'),
			'fonction', ezhttp('fonction','get'),
			'direction', ezhttp('direction','get'),
			'service', ezhttp('service','get'),
			'entreprise', ezhttp('entreprise','get'),
			'filiale', ezhttp('filiale','get'),
			'secteur', ezhttp('secteur','get'),
			'pro_adresse', ezhttp('pro_adresse','get'),
			'emplacement', ezhttp('emplacement','get'),
			'pro_tel', ezhttp('pro_tel','get'),
			'pro_mobile', ezhttp('pro_mobile','get'),
			'pro_fax', ezhttp('pro_fax','get'),
			'assistante_nom', ezhttp('assistante_nom','get'),
			'assistante_tel', ezhttp('assistante_tel','get'),
			'date_naissance', ezhttp('date_naissance','get'),
			'date_entree', ezhttp('date_entree','get'),
			'diplome', ezhttp('diplome','get'),
			'parcours_pro', ezhttp('parcours_pro','get'),
			'mission_actuelle', ezhttp('mission_actuelle','get'),
			'mission_precedente', ezhttp('mission_precedente','get'),
			'competences', ezhttp('competences','get'),
			'centres_interet', ezhttp('centres_interet','get'),
			'limit', 10,
			'offset', $offset,
			'ww_id', $ww_id))}
{/if}
{if is_set($search_result)}
<div class="list">
	{if count($search_result)|eq(0)|not()}
		{if $search_result.nbResult|eq(0)}
			{*no result*}
			<span class="title color6">{"search_result_empty"|i18n("design/bouygues/whoswho")}</span>
		{else}
			<span class="title color3">{"search_result"|i18n("design/bouygues/whoswho")}</span>
			<span class="result_num">{$search_result.nbResult} {"search_answer"|i18n("design/bouygues/whoswho")}</span>
			
			{def $picEntreprise = ''}
			
			{foreach $search_result as $result}
			{if is_set($result.id)}

			{def $entreprise = fetch('whoswho', 'search_option_value', hash('id', $result.whoswho.entreprise))}
	
			{if eq($entreprise|upcase(), 'BOUYGUES CONSTRUCTION')}{set $picEntreprise = 'bouyguesC'}
			{elseif eq($entreprise|upcase(), 'COLAS')}{set $picEntreprise = 'colas'}
			{elseif eq($entreprise|upcase(), 'FINAGESTION')}{set $picEntreprise = ''}
			{elseif eq($entreprise|upcase(), 'TF1')}{set $picEntreprise = 'tf1'}
			{elseif eq($entreprise|upcase(), 'BOUYGUES TELECOM')}{set $picEntreprise = 'bouyguesT'}
			{elseif eq($entreprise|upcase(), 'BOUYGUES SA')}{set $picEntreprise = 'bouyguesSA'}
			{elseif eq($entreprise|upcase(), 'BOUYGUES IMMOBILIER')}{set $picEntreprise = 'bouyguesI'}
			{elseif eq($entreprise|upcase(), 'C2S')}{set $picEntreprise = 'c2s'}{/if}
			{def $filiale = fetch('whoswho', 'search_option_value', hash('id',$result.whoswho.filiale))}
			{def $service = fetch('whoswho', 'search_option_value', hash('id',$result.whoswho.service))}
			<div class="lineHr"></div>
		
			<div class="item">
				<span class="icon"><img src="{concat('images/pictos/collab','.gif')|ezdesign(no)}" align="absmiddle"/></span>
				<span class="collaborator">
					<a href="{concat($node.url,'/(userId)/',$result.id)|ezurl(no)}">{$result.first_name} {$result.last_name}</a>
					{if $picEntreprise|eq('')|not()}<img src="{concat('images/logos/',$picEntreprise,'.gif')|ezdesign(no)}" align="absmiddle"/>{/if}
				</span>
				<span class="function">
					<span class="small">{if eq($filiale, '')|not()}<span style="text-transform: uppercase">{$filiale}</span><br/>{elseif eq($entreprise,'')|not()}{$entreprise}<br/>{/if}
					{if and(eq($service, ''), eq($result.whoswho.direction, '')|not())}{$result.whoswho.direction}<br/>{elseif eq($service, '')|not()}{$service}<br/>{/if}</span>
					<span class="big">{$result.whoswho.fonction}&nbsp;</span>
				</span>
				<span class="email color2">
					{if $result.whoswho.pro_tel|eq('')|not()}<span  class="clicktocalllink" onclick="eby.annuaireMakeCall('', '{$result.whoswho.pro_tel}')" style="cursor: pointer"><img src="{concat('images/pictos/phone','.gif')|ezdesign(no)}" align="absmiddle"/>&nbsp;&nbsp;{$result.whoswho.pro_tel}</span><br/>{/if}
					<span class="small"><a href="mailto:{$result.email}">{$result.email}</a></span>
				</span>
				<a href="{concat($node.url,'/(userId)/',$result.id)|ezurl(no)}" class="more"><img src="{concat('images/pictos/more','.gif')|ezdesign(no)}" alt="{"more_link"|i18n("design/bouygues/whoswho")} {$result.first_name} {$result.last_name}" title="{"more_link"|i18n("design/bouygues/whoswho")} {$result.first_name} {$result.last_name}"/></a>
			</div>
			{undef $entreprise}
			{/if}
			{/foreach}
		{/if}
	{/if}
</div>

{include uri="design:blocs/pagination_whoswho.tpl"}
{/if}