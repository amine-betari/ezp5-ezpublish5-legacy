{def 
	$aContainers = fetch( 'content', 'list', hash(
		'parent_node_id', $node.node_id, 
		'class_filter_type', 'include',
		'class_filter_array', array('bouygues_master_container'),
		'sort_by', array( array( 'priority' ) )
	))}
	{foreach $aContainers as $oContainer}
		{def 
			$aBlocs = fetch( 'content', 'list', hash( 
				'parent_node_id', $oContainer.node_id,
				'class_filter_type', 'include',
				'class_filter_array', array( 
					'bouygues_agenda',
					'bouygues_portrait',
					'bouygues_texte',
					'bouygues_remontees_auto',
					'bouygues_mea_master_page'
				),
				'sort_by', array( array( 'priority' ) ) 
			))
		}
		{foreach $aBlocs as $oBloc}
			{if $oBloc.data_map.colonne.value.0|eq($column)}
				{include 
					uri=concat("design:blocs/",$oBloc.class_identifier,".tpl") 
					column=$column 
					object=$oBloc.object 
					node=$oBloc
				}
			{/if}	
		{/foreach}
		{undef $aBlocs}
	{/foreach}
{undef $aContainers}