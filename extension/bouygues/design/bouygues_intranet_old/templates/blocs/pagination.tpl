<div class="pagination">
	{if is_unset($url_pagination)}
		{def $url_pagination = $node.url_alias}
	{/if}
		
	{if is_unset($articleCount)}
		{def $articleCount = fetch( 'content', 'list_count',hash( 'parent_node_id', $node.node_id ) )}
	{/if}
	
	{if $articleCount}	
		{def 
			$aArticleList = fetch( 'content', 'list', hash( 
				'parent_node_id', $node.node_id,
				'sort_by', $node.sort_array,
				'offset', $view_parameters.offset,
				'limit', $numberOfObjects
			))
		}
		{foreach $aArticleList as $oArticle}    
			{node_view_gui view=element content_node=$oArticle} 
		{/foreach}
		
		{include 
			name=navigator 
			uri='design:navigator/google.tpl' 
			page_uri=$url_pagination
			item_count=$articleCount 
			view_parameters=$view_parameters 
			item_limit=$numberOfObjects
			page=$view_parameters.offset|div($numberOfObjects)|inc()
		}
		
		{undef $aArticleList} 
	{/if} 

</div>