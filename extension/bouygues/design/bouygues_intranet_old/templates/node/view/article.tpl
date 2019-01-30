{* Article - Node view *}
	<div class="default post">
		
		{if and(is_unset($lightbox), is_unset($include_mode),is_unset($parent))}
			{include uri="design:blocs/tools.tpl"}
		{/if}
		
		{if or($node.data_map.image_main.has_content,$node.data_map.titre_encadre.has_content)}
				<div class="column">
					<div class="box">
						<div class="summary">
							{if $node.data_map.image_main.has_content}
								<img src="{if $node.data_map.image_main.has_content}{$node.data_map.image_main.content.articlesummary.url|ezroot(no)}{/if}" title="{if $node.data_map.image_main.content.alternative_text}{$node.data_map.image_main.content.alternative_text}{else}{$node.data_map.title.content|wash()}{/if}" alt="{if is_set($node.data_map.image_main.content.alternative_text)}{$node.data_map.image_main.content.alternative_text}{else}{$node.data_map.title.content|wash()}{/if}"/>
								<p class="legend">
								{if $node.data_map.image_legende.has_content}{$node.data_map.image_legende.content}{/if} {if and($node.data_map.image_copyright.has_content,$node.data_map.image_legende.has_content)} - {/if}{if $node.data_map.image_copyright.has_content}© {$node.data_map.image_copyright.content}{/if} 
								</p>
							{/if}
						</div>
						{if $node.data_map.titre_encadre.has_content}
						<div class="second">

							<div class="boxA">
								<div class="top">
									<div class="left"></div>
									<div class="right"></div>
									<div class="middle"></div>
								</div>
								<div class="content">
									<strong class="title color4">{$node.data_map.titre_encadre.content|wash()}</strong>
									{$node.data_map.contenu_encadre.content.output.output_text}
								</div>
								<div class="bottom">
									<div class="left"></div>
									<div class="right"></div>
									<div class="middle"></div>
								</div>
							</div>
				
						</div>
						{/if}
					</div>
				</div>
			{/if}
		
			{if and(is_set($idminisite),$firstpage|eq(1))}
				<div class="column">	
						<div class="box minisite-sommaire">	
						<div class="second">
							<div class="boxA">
								<div class="top">
									<div class="left"></div>
									<div class="right"></div>
									<div class="middle"></div>
								</div>
								<div class="content">
									<strong class="title">{"Sommaire"|i18n("design/bouygues/mini")}</strong>
									
									
									{def $datas = fetch('content','list',hash( 'parent_node_id', $idminisite,
																  'class_filter_type','include',
																  'class_filter_array',array('article','bouygues_diapo','bouygues_galerie_vid','bouygues_video','bouygues_dossier'),
																  'limit', 5,
																  'offset',1,
																  'sort_by', array( array( 'priority' ) ) ))}
									
									{foreach $datas as $data}
										<strong><a href="{concat($url_pagination|ezurl(no),'/(folderId)/',$data.node_id)}" class="title-sommaire">{$data.name}</a></strong>
										
										
									
									{def $sub_datas = fetch('content','list',hash( 'parent_node_id', $data.node_id,
																  'class_filter_type','include',
																  'class_filter_array',array('article','bouygues_dossier'),
																  'sort_by', array( array( 'priority' ) )
																  ))}
										
										<ul>						  
										{foreach $sub_datas as $sub_data}
											
												<li><a href="{concat($url_pagination|ezurl(no),'/(folderId)/',$data.node_id,'/(subFileId)/',$sub_data.node_id)}">{$sub_data.name}</a></li>
												
										{/foreach}
										</ul>	
										<br />		  
														  
																  
										
									{/foreach}
									
								</div>
								<div class="bottom">
									<div class="left"></div>
									<div class="right"></div>
									<div class="middle"></div>
								</div>
							</div>
						</div>
					</div>
					</div>
			{/if}
					
			{if $node.data_map.titre_colonne.has_content}
				<div class="column">	
					<div class="box sBox">	
						<div class="second">
							<div class="boxA">
								<div class="top">
									<div class="left"></div>
									<div class="right"></div>
									<div class="middle"></div>
								</div>
								<div class="content">
									<strong class="title color4">{$node.data_map.titre_colonne.content|wash()}</strong>
									{$node.data_map.texte_colonne.content.output.output_text}
								</div>
								<div class="bottom">
									<div class="left"></div>
									<div class="right"></div>
									<div class="middle"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			{/if}
					
        <h1>{$node.data_map.title.content|wash()}</h1>
        
        {if $node.data_map.sub_title.has_content}
        	<h2>{$node.data_map.sub_title.content|wash()}</h2>
        {/if}
		
		{if $node.data_map.intro.has_content}
	        <div class="intro">
	        	{$node.data_map.intro.content.output.output_text}
	        </div>
        {/if}
        
        {$node.data_map.body.content.output.output_text}
        
 </div>

<div class="plus-iframe">
	{include uri="design:blocs/iframe.tpl"}
</div>

<div class="plus-diaporama">
	{include uri="design:blocs/diaporama.tpl"}
</div>

<div class="plus">
	{include uri="design:blocs/annexe.tpl"}
</div>

{if or($node.data_map.author.has_content,$node.data_map.date_pub_cb.value|eq(1))}
	<div class="user colorDefault1">
		<em>{attribute_view_gui attribute=$node.data_map.author}</em>{if and($node.data_map.author.has_content,$node.data_map.date_pub_cb.value|eq(1))} - {/if}{if $node.data_map.date_pub_cb.value|eq(1)}{"published"|i18n("design/bouygues/dossier")} {$node.data_map.date_pub.data_int|datetime( 'custom', '%d/%m/%Y' )}{/if}
	</div>
{/if}


	{if and($node.data_map.enable_comments.value|eq(1),is_unset($include_mode),is_unset($parent))}
	<div class="plus plus-comments">
			{include uri="design:blocs/comments.tpl"}
	</div>
	{/if}


