<div class="default prestataire">		
	{if and(is_unset($lightbox), is_unset($include_mode),is_unset($parent))}
		{include uri="design:blocs/tools.tpl"}
	{/if}
	
	<h1>{$node.data_map.nom.content|wash}</h1>
	
	<h2>{$node.data_map.domaine.content|wash}</h2>
	
	<div class="content1">
		<div class="boxA">
			<div class="top">
				<div class="left"></div>
				<div class="right"></div>
				<div class="middle"></div>
			</div>
			<div class="content">					
				<div class="left"><strong>{"contact_details"|i18n("design/bouygues/prestataire")}</strong></div>
				<div class="right">

						{$node.data_map.adresse.content|nl2br()}
					<p>
						<a href="mailto:{$node.data_map.email.content|wash}">{$node.data_map.email.content|wash}</a><br />
						<a href="{$node.data_map.site.content|wash}" target="_blank">{if $node.data_map.site.data_text}{$node.data_map.site.data_text|wash}{else}{$node.data_map.site.content|wash}{/if}</a>
					</p>
					{if or($node.data_map.tel.has_content,$node.data_map.fax.has_content,$node.data_map.mobile.has_content)}
						<p class="phones">
							{if $node.data_map.tel.has_content}<img src={"pictos/ebyperso_contact.gif"|ezimage} alt="" height="20"/> <span class="phone">{$node.data_map.tel.content|wash}</span>{/if}
							{if $node.data_map.fax.has_content}{"fax"|i18n("design/bouygues/whoswho")} <span class="phone">{$node.data_map.fax.content|wash}</span>{/if}
							{if $node.data_map.mobile.has_content}{"mobile"|i18n("design/bouygues/whoswho")} <span class="phone">{$node.data_map.mobile.content|wash}</span>{/if}
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
	
	<div class="content1">
	
		{*def $projects = $node.data_map.projets.content.relation_list*}
		
		{def $projects = fetch('content','list',hash( 'parent_node_id', $node.node_id,
													  'class_filter_type','include',
													  'class_filter_array',array('bouygues_prestataire_projet'),
													  'sort_by', array( array( 'priority' )) ))}

		{foreach $projects as $project}
		
			{def $datas = fetch( 'content', 'node', hash('node_id', $project.node_id ) )}
			
			<div class="prj-item">
				<div class="left">
					<strong>{$datas.data_map.titre.content}</strong>
				</div>
				<div class="right">
					{$datas.data_map.prestation.content.output.output_text}
				</div>	
			</div>
		{/foreach}
		
	</div>
	
	{include uri="design:blocs/btn.tpl" arrow=1 label="back_to_list"|i18n("design/bouygues/prestataire") url=$node.parent.url_alias align='right'}
	
	<br /><br />
	{undef}
	
</div>