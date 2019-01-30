<div class="list">
	{def $collaborators = orderByLastname($node.data_map.collaborator.content.relation_list)}
	{def $picEntreprise = 'bouyguesSA'}
	{def $result='' $entreprise='' $filiale='' $service='' $userObj=''}

	<span class="title color3">{"collaborator_list"|i18n("design/bouygues/whoswho")}</span>
	<span class="result_num">{count($collaborators)} {if gt(count($collaborators),1)}{"collaborators"|i18n("design/bouygues/whoswho")}{else}{"collaborator"|i18n("design/bouygues/whoswho")}{/if}</span>

	{foreach $collaborators as $collaborator}
	{set $userObj  = fetch('content', 'node', hash('node_id', $collaborator.node_id))}
	{set $result = fetch('whoswho', 'whoswho_fetch', hash('user_id', $collaborator.contentobject_id, 'ww_id', $ww_id))}

	{if is_set($result.0)}
	
	{set $entreprise = fetch('whoswho', 'search_option_value', hash('id', $result.0.entreprise))}
	{if eq($entreprise|upcase(), 'BOUYGUES CONSTRUCTION')}{set $picEntreprise = 'bouyguesC'}
	{elseif eq($entreprise|upcase(), 'COLAS')}{set $picEntreprise = 'colas'}
	{elseif eq($entreprise|upcase(), 'FINAGESTION')}{set $picEntreprise = 'bouyguesSA'}
	{elseif eq($entreprise|upcase(), 'TF1')}{set $picEntreprise = 'tf1'}
	{elseif eq($entreprise|upcase(), 'BOUYGUES TELECOM')}{set $picEntreprise = 'bouyguesT'}
	{elseif eq($entreprise|upcase(), 'BOUYGUES SA')}{set $picEntreprise = 'bouyguesSA'}
	{elseif eq($entreprise|upcase(), 'BOUYGUES IMMOBILIER')}{set $picEntreprise = 'bouyguesI'}
	{elseif eq($entreprise|upcase(), 'C2S')}{set $picEntreprise = 'c2s'}{/if}
	{set $filiale = fetch('whoswho', 'search_option_value', hash('id',$result.0.filiale))}
	{set $service = fetch('whoswho', 'search_option_value', hash('id',$result.0.service))}
	<div class="lineHr"></div>

	<div class="item">
		<span class="icon"><img src="{concat('images/pictos/collab','.gif')|ezdesign(no)}" align="absmiddle"/></span>
		<span class="collaborator">
			<a href="{concat($node.url,'/(userId)/',$collaborator.contentobject_id)|ezurl(no)}">{$userObj.data_map.first_name.content} {$userObj.data_map.last_name.content}</a>
			<img src="{concat('images/logos/',$picEntreprise,'.gif')|ezdesign(no)}" align="absmiddle"/>	
		</span>
		<span class="function">
			<span class="small">{if eq($filiale, '')|not()}<span style="text-transform: uppercase">{$filiale}</span><br/>{elseif eq($entreprise,'')|not()}{$entreprise}<br/>{/if}
			{if and(eq($service, ''), eq($result.0.direction, '')|not())}{$result.0.direction}<br/>{elseif eq($service, '')|not()}{$service}<br/>{/if}</span>
			<span class="big">{$result.0.fonction}&nbsp;</span>
		</span>
		<span class="email color2">
			{if $result.0.pro_tel|eq('')|not()}<img src="{concat('images/pictos/phone','.gif')|ezdesign(no)}" align="absmiddle"/>&nbsp;&nbsp;{$result.0.pro_tel}<br/>{/if}
			<span class="small"><a href="mailto:{$userObj.data_map.user_account.content.email}">{$userObj.data_map.user_account.content.email}</a></span>
		</span>
		<a href="{concat($node.url,'/(userId)/',$collaborator.contentobject_id)|ezurl(no)}" class="more"><img src="{concat('images/pictos/more','.gif')|ezdesign(no)}" alt="{"more_link"|i18n("design/bouygues/whoswho")} {$userObj.data_map.first_name.content} {$userObj.data_map.last_name.content}" title="{"more_link"|i18n("design/bouygues/whoswho")} {$userObj.data_map.first_name.content} {$userObj.data_map.last_name.content}"/></a>
	</div>
	{/if}
	{/foreach}
	{undef $collaborator $collaborators $entreprise $result $userObj $picEntreprise $filiale $service}
</div>