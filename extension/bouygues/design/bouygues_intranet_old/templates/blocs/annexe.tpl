
	{def $bloc_annexes = fetch('content','list',hash( 'parent_node_id', $node.node_id,
														  'class_filter_type','include',
														  'class_filter_array',array('bouygues_annexe'),
														  'sort_by', array( array( 'priority' ) )  ))}	
	{foreach $bloc_annexes as $bloc_annexe}													 
		<div class="boxA">
			<div class="top">
				<div class="left"></div>
				<div class="right"></div>
				<div class="middle"></div>
			</div>
			<div class="content">
				<strong class="title">{$bloc_annexe.data_map.titre.content}</strong>
				{attribute_view_gui attribute=$bloc_annexe.data_map.texte}
			</div>
			<div class="bottom">
				<div class="left"></div>
				<div class="right"></div>
				<div class="middle"></div>
			</div>
		</div>
	
	{/foreach}
