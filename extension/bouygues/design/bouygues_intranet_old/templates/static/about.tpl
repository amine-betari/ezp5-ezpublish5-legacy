<div class="default static">
{include uri="design:blocs/tools.tpl" light=1}
		{def $my_node=fetch( 'content', 'node', hash( 'node_id', 11386 ) )}
												  
		<h1>{$my_node.data_map.title.content}</h1>
	
		{$my_node.data_map.content.content.output.output_text}
</div>