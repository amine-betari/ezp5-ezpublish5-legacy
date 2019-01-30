<div class="default list {if or($node.parent.parent_node_id|eq(11612),$node.parent_node_id|eq(11612))}list-special{/if} post">
	{* à voir supprimer les choix non utiles*}
	{if $node.data_map.ordre_select.content.0|eq(0)}{def $orderField='published'}{def $orderBoo=false()}
	{elseif $node.data_map.ordre_select.content.0|eq(1)}{def $orderField='published'}{def $orderBoo=true()}
	{elseif $node.data_map.ordre_select.content.0|eq(2)}{def $orderField='modified'}{def $orderBoo=true()}
	{elseif $node.data_map.ordre_select.content.0|eq(3)}{def $orderField='modified'}{def $orderBoo=false()}
	{elseif $node.data_map.ordre_select.content.0|eq(4)}{def $orderField='published'}{def $orderBoo=true()}
	{elseif $node.data_map.ordre_select.content.0|eq(5)}{def $orderField='published'}{def $orderBoo=false()}
	{elseif $node.data_map.ordre_select.content.0|eq(6)}{def $orderField='name'}{def $orderBoo=true()}
	{elseif $node.data_map.ordre_select.content.0|eq(7)}{def $orderField='name'}{def $orderBoo=false()}
	{elseif $node.data_map.ordre_select.content.0|eq(8)}{def $orderField='priority'}{def $orderBoo=true()}
	{elseif $node.data_map.ordre_select.content.0|eq(9)}{def $orderField='priority'}{def $orderBoo=false()}
	{/if}

	{if eq($node.data_map.lien_thema_cb.value,1)}
		{def $numberOfObjects = $node.data_map.element_select.class_content.options[$node.data_map.element_select.value[0]].name}
	{else}
		{def $numberOfObjects = 10}
	{/if}
	
	
	{def $offset=0}
	{if is_set($view_parameters.offset)}{set $offset=$view_parameters.offset}{/if}
	
	{if $node.class_identifier|eq('bouygues_liste_thema')}
	
		{def $lists=fetch('content','list',hash(
												'parent_node_id',$node.node_id,
												'class_filter_type',  'include',
												'class_filter_array', array( 'bouygues_liste','bouygues_liste_thema' ),
												'depth',1,
												'offset',$offset,
												'limit',10,
												'sort_by',  array( $orderField, $orderBoo )
												)
						)}
	{/if}


	{include uri="design:blocs/tools.tpl"}
	
	<h1>{$node.data_map.titre.content|wash()}</h1>
	
	<div class="content1">
		
			{if $node.data_map.image.has_content}	
			<div class="thumb">
				<img src="{$node.data_map.image.content.thumblistheader.url|ezroot(no)}" alt="{if $node.data_map.image.content.alternative_text}{$node.data_map.image.content.alternative_text}{elseif $node.data_map.legende.has_content}{$node.data_map.legende.content}{else}{$node.data_map.titre.content|wash()}{/if}" title="{if $node.data_map.image.content.alternative_text}{$node.data_map.image.content.alternative_text}{elseif $node.data_map.legende.has_content }{$node.data_map.legende.content}{else}{$node.data_map.titre.content|wash()}{/if}"/><br />
				{if or($node.data_map.legende.has_content,$node.data_map.copyright.has_content)}	
					<span class="legende">{$node.data_map.legende.content}{if and($node.data_map.copyright.has_content,$node.data_map.legende.has_content)}-{/if}{if $node.data_map.copyright.has_content}© {$node.data_map.copyright.content}{/if}</span>
				{/if}
			</div>
			{/if}
			
			<div class="text">
				{if $node.data_map.description.has_content}
					<div class="intro">
						{attribute_view_gui attribute=$node.data_map.description}
					</div>
				{/if}	
				{if and($node.class_identifier|eq('bouygues_liste_thema'),$node.data_map.sommaire_cb.content|eq(1))}
				<ul>
					{foreach $lists as $list}
						<li><a href="#v_{$list.node_id}" title="{$list.name}">{$list.name}</a></li>
					{/foreach}
				</ul>
				{/if}
			</div>
		
	</div>
	
	<div class="content2">
			
			{if $node.data_map.tpl_select.content.0|eq(1)}
				<div class="sub_item">
			{/if}

			{if $node.class_identifier|eq('bouygues_liste_thema')}
			

				{def $articleCount = fetch('content','list_count',hash( 'parent_node_id', $node.node_id,
										'class_filter_type','include',
										'class_filter_array',array('bouygues_liste','bouygues_liste_thema')
									  	))}										
				
				{def $i=0 $sub_list_total_count=0 $sub_list='' $orderField2='' $orderBoo2='' $numberOfObjects2=''}
				
				{foreach $lists as $main_list}
				
				
				
				{if $main_list.data_map.ordre_select.content.0|eq(0)}{set $orderField2='published'}{set $orderBoo2=false()}
				{elseif $main_list.data_map.ordre_select.content.0|eq(1)}{set $orderField2='published'}{set $orderBoo2=true()}
				{elseif $main_list.data_map.ordre_select.content.0|eq(2)}{set $orderField2='modified'}{set $orderBoo2=true()}
				{elseif $main_list.data_map.ordre_select.content.0|eq(3)}{set $orderField2='modified'}{set $orderBoo2=false()}
				{elseif $main_list.data_map.ordre_select.content.0|eq(4)}{set $orderField2='published'}{set $orderBoo2=true()}
				{elseif $main_list.data_map.ordre_select.content.0|eq(5)}{set $orderField2='published'}{set $orderBoo2=false()}
				{elseif $main_list.data_map.ordre_select.content.0|eq(6)}{set $orderField2='name'}{set $orderBoo2=true()}
				{elseif $main_list.data_map.ordre_select.content.0|eq(7)}{set $orderField2='name'}{set $orderBoo2=false()}
				{elseif $main_list.data_map.ordre_select.content.0|eq(8)}{set $orderField2='priority'}{set $orderBoo2=true()}
				{elseif $main_list.data_map.ordre_select.content.0|eq(9)}{set $orderField2='priority'}{set $orderBoo2=false()}
				{/if}

				<div class="item {if $i|eq(0)}first{/if}">											  
					<a name="v_{$main_list.node_id}">&nbsp;</a>
						{set $sub_list=fetch('content','list',hash(
												'parent_node_id',$main_list.node_id,
												'class_filter_type',  'include',
												'class_filter_array', array(    'article',
																				'bouygues_dossier',
																				'bouygues_diapo',
																				'bouygues_element_liste', 
																				'bouygues_galerie_vid',
																				'bouygues_video', 
																				'bouygues_mini_site',
																				'newsletter_issue',
																				'bouygues_liste',
																				'bouygues_page_sessions',
																				'bouygues_liste_thema',
																				'bouygues_prestataire',
																				'link',
																				'file',
																				'bouygues_whoswho_list'
																			),
												'depth',1,
												'offset',0,
												'limit',$numberOfObjects,
												'sort_by', array( array( $orderField2, $orderBoo2 ))
												)
						)}
															  
						{set $sub_list_total_count = fetch('content','list_count',hash( 'parent_node_id', $main_list.node_id,
														'class_filter_type','include',
														'class_filter_array', array('article', 'bouygues_dossier', 'bouygues_mini_site', 'bouygues_diapo', 'bouygues_galerie_vid', 'bouygues_video', 'file', 'newsletter_issue', 'bouygues_element_liste', 'bouygues_liste', 'bouygues_liste_thema', 'link', 'bouygues_prestataire')
															  ))}

					{if and($node.data_map.lien_thema_cb.value|eq(1),$node.parent_node_id|eq(11612)|not)}		  
						<h2 class="noColor">
							{if and($sub_list_total_count|gt($sub_list|count()), eq($node.data_map.lien_thema_cb.value,1))}
								<a class="noColor" href="{$main_list.url_alias|ezurl(no)}">
								{$main_list.name}
								{* Les sites internet du groupe *}
								{if and($i|eq(1),$node.parent_node_id|eq(11612))}
								 - {$sub_list_total_count} {"title_other_website"|i18n("design/bouygues/liste")}
								{/if}	
								</a>
							{else}
								{$main_list.name}
								{* Les sites internet du groupe *}
								{if and($i|eq(1),$node.parent_node_id|eq(11612))}
								 - {$sub_list_total_count} {"title_other_website"|i18n("design/bouygues/liste")}
								{/if}	
							{/if}
						</h2>
						
						{undef $url}
						{undef $urlTitle}
						{undef $urlTarget}
						
					{else}
						<h2 class="noColor">
						
							{$main_list.name}
						
							{* Les sites internet du groupe *}
							{def $site_node_id = ezini('NODE_ID', 'site_groupe', 'site.ini')}
							{if and($i|eq(1),$node.parent_node_id|eq($site_node_id))}
							 - {$sub_list_total_count} {"title_other_website"|i18n("design/bouygues/liste")}
							{/if}	
						
						</h2>
					{/if}
										  						
					{include uri="design:blocs/liste.tpl" children=$sub_list}

					{if and($sub_list_total_count|gt($sub_list|count()), eq($node.data_map.lien_thema_cb.value,1))}
						<a href="{$main_list.url_alias|ezurl(no)}" class="btn-grey-arrow-left" title="{if $main_list.data_map.lib_ts_elem.has_content}{$main_list.data_map.lib_ts_elem.content}{else}Tous les articles{/if}">{if $main_list.data_map.lib_ts_elem.has_content}{$main_list.data_map.lib_ts_elem.content}{else}Tous les articles{/if}</a>
					{/if}
				</div>
				
				{set $i=inc($i)}	
				{/foreach}
				{undef $sub_list}
				{undef $sub_list_total_count}
				
				{undef $main_lists}
				{undef $i $orderField2 $orderBoo2}

			{else}

				{set $numberOfObjects = $node.data_map.elem_page_select.class_content.options[$node.data_map.elem_page_select.value[0]].name}
			  										  
				{def $children=fetch('content','list',hash(
										'parent_node_id',$node.node_id,
										'class_filter_type',  'include',
										'class_filter_array', array('article','bouygues_dossier','bouygues_mini_site','bouygues_diapo','bouygues_galerie_vid','bouygues_video','file','newsletter_issue','bouygues_element_liste','bouygues_liste','bouygues_liste_thema','link','bouygues_prestataire', 'bouygues_whoswho_list'),
										'depth',1,
										'offset',$view_parameters.offset,
										'limit',$numberOfObjects,
										'sort_by', array( array( $orderField, $orderBoo ))
										)
				)}
				
				
				{def $articleCount = fetch('content','list_count',hash( 'parent_node_id', $node.node_id,
															  'class_filter_type','include',
															  'class_filter_array',array('article','bouygues_dossier','bouygues_mini_site','bouygues_diapo','bouygues_galerie_vid','bouygues_video','file','newsletter_issue','bouygues_element_liste','bouygues_liste','bouygues_liste_thema','link','bouygues_prestataire', 'bouygues_whoswho_list')
															  ))}			
			
				{include uri="design:blocs/liste.tpl" children=$children}
				
				{undef $i $orderField $orderBoo}
			{/if}
			
			{if $node.data_map.tpl_select.content.0|eq(1)}
				</div>
			{/if}
		
	</div>	

</div>


{if or($node.data_map.pagination.content|eq(1), $node.class_identifier|eq('bouygues_liste_thema'))}
	{if  $node.class_identifier|eq('bouygues_liste_thema')}{set $numberOfObjects = 10}{/if}
	{include uri="design:blocs/pagination.tpl"}
{/if}

<div class="plus default">{include uri="design:blocs/annexe.tpl"}</div>
{undef $orderBoo2 $orderBoo $numberOfObjects}