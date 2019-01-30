<div class="default static static-group">
	{include uri="design:blocs/tools.tpl" light=1}
	{def $my_node=fetch( 'content', 'node', hash( 'node_id', 11385 ) )}
												  
	<h1>{$my_node.data_map.title.content}</h1>
	
	{$my_node.data_map.content.content.output.output_text}
	
</div>