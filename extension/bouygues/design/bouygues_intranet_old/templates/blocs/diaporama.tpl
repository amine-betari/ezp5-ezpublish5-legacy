
	{def $blocs = fetch('content','list',hash( 'parent_node_id', $node.node_id,
														  'class_filter_type','include',
														  'class_filter_array',array('bouygues_diapo', 'bouygues_video', 'bouygues_galerie_vid'),
														  'sort_by', array( array( 'priority' ) )  ))}
	{foreach $blocs as $data}
		
		<div class="boxA">
			<div class="top">
				<div class="left"></div>
				<div class="right"></div>
				<div class="middle"></div>
			</div>
			<div class="content">
				{if eq($data.class_identifier,'bouygues_diapo')}
					{if is_set($view_parameters.nodeid)}
						{node_view_gui content_node=$data view="diaporama" includemode=1 nodeid=$view_parameters.nodeid}
					{else}
						{node_view_gui content_node=$data view="diaporama" includemode=1}
					{/if}
				{elseif eq($data.class_identifier,'bouygues_video')}
					{node_view_gui content_node=$data view="video" includemode=1}
				{elseif eq($data.class_identifier, 'bouygues_galerie_vid')}
					{if is_set($view_parameters.nodeid)}
						{node_view_gui content_node=$data view="video" includemode=1 nodeid=$view_parameters.nodeid}
					{else}
						{node_view_gui content_node=$data view="video" includemode=1}
					{/if}
				{/if}
				{if and(is_unset($lightbox),is_unset($includemode))}
				<div class="user colorDefault1">

					<em>{attribute_view_gui attribute=$node.data_map.author}</em>{if and($node.data_map.author.has_content,$node.data_map.date_pub_cb.value|eq(1))} - {/if}{if $node.data_map.date_pub_cb.value|eq(1)}{"published"|i18n("design/bouygues/dossier")} {$node.data_map.date_pub.data_int|datetime( 'custom', '%d/%m/%Y' )}{/if}

				</div>
				{/if}
			</div>
			<div class="bottom">
				<div class="left"></div>
				<div class="right"></div>
				<div class="middle"></div>
			</div>
		</div>
		
	{/foreach}
