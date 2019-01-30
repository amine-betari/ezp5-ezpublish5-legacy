<div class="pagination">
		
		{if is_unset($url_pagination)}
			{def $url_pagination = $node.url_alias}
		{/if}		
		
		{* DO NOT EDIT THIS FILE! Use an override template instead. *}
		
		{default page_uri_suffix=false()
		         left_max=3
		         right_max=3}
		{default name=ViewParameter
		         page_uri_suffix=false()
		         left_max=$left_max
		         right_max=$right_max}
		
		{let page_count=int( ceil( div( $results.SearchCount,10 ) ) )
		      current_page=min($:page_count,
		                       int( ceil( div( first_set( $offset, 0 ),
		                                      10 ) ) ) )
		      item_previous=sub( mul( $:current_page, 10 ),
		                         10 )
		      item_next=sum( mul( $:current_page, 10 ),
		                     10 )
		
		      left_length=min($ViewParameter:current_page,$:left_max)
		      right_length=max(min(sub($ViewParameter:page_count,$ViewParameter:current_page,1),$:right_max),0)
		      view_parameter_text=""
		      
		      offset_text=eq( ezini( 'ControlSettings', 'AllowUserVariables', 'template.ini' ), 'true' )|choose( '/offset/', '/(offset)/' )}
		      
		{* Create view parameter text with the exception of offset *}
		{section loop=$view_parameters}
		 {section-exclude match=eq($:key,offset)}
		  {section-exclude match=eq($:key,folderId)}
		 {section-exclude match=$:item|not}
		 {set view_parameter_text=concat($:view_parameter_text,'/(',$:key,')/',$:item)}
		{/section}
		
		
		{section show=$:page_count|gt(1)}
		
		<div class="pagenavigator">
		<p>
		
		     {switch match=$:item_previous|lt(0) }
		       {case match=0}
		      <a href={concat($url_pagination,$:item_previous|gt(0)|choose('',concat($:offset_text,$:item_previous)),$:view_parameter_text,$url_pagination_suffix)|ezurl} class="previous" onclick="$('#searchForm input[name=pg]').val('{$:current_page}');$('#searchForm').submit();return false;"><span class="text">{"Previous"|i18n("design/bouygues/navigator")}</span></a>
		       {/case}
		       {case match=1}
		       {/case}
		     {/switch}
		
		<span class="pages">
		{section show=$:current_page|gt($:left_max)}
		<span class="other"><a href={concat($url_pagination,$:view_parameter_text,$url_pagination_suffix)|ezurl} onclick="$('#searchForm input[name=pg]').val('1');$('#searchForm').submit();return false;">1</a></span>
		{section show=sub($:current_page,$:left_length)|gt(1)}
		<span class="other">...</span>
		{/section}
		{/section}
		
		    {section loop=$:left_length}
		        {let page_offset=sum(sub($ViewParameter:current_page,$ViewParameter:left_length),$:index)}
		          <span class="other"><a href={concat($url_pagination,$:page_offset|gt(0)|choose('',concat($:offset_text,mul($:page_offset,10))),$ViewParameter:view_parameter_text,$url_pagination_suffix)|ezurl} onclick="$('#searchForm input[name=pg]').val('{$:page_offset|inc}');$('#searchForm').submit();return false;">{$:page_offset|inc}</a></span>
		        {/let}
		    {/section}
		
		        <span class="current">{$:current_page|inc}</span>
		        {def $nextpag = $:current_page|inc}
		
		    {section loop=$:right_length}
		        {let page_offset=sum($ViewParameter:current_page,1,$:index)}
		          <span class="other"><a href={concat($url_pagination,$:page_offset|gt(0)|choose('',concat($:offset_text,mul($:page_offset,10))),$ViewParameter:view_parameter_text,$url_pagination_suffix)|ezurl} onclick="$('#searchForm input[name=pg]').val('{$:page_offset|inc}');$('#searchForm').submit();return false;">{$:page_offset|inc}</a></span>
		        {/let}
		    {/section}
		
		{section show=$:page_count|gt(sum($:current_page,$:right_max,1))}
		{section show=sum($:current_page,$:right_max,2)|lt($:page_count)}
		<span class="other">...</span>
		{/section}
		<span class="other"><a href={concat($url_pagination,$:page_count|dec|gt(0)|choose('',concat($:offset_text,mul($:page_count|dec,10))),$:view_parameter_text,$url_pagination_suffix)|ezurl} onclick="$('#searchForm input[name=pg]').val('{$:page_count}');$('#searchForm').submit();return false;">{$:page_count}</a></span>
		{/section}
		
		</span>
		
		    {switch match=$:item_next|lt($results.SearchCount)}
		      {case match=1}
		        <a href={concat($url_pagination,$:offset_text,$:item_next,$:view_parameter_text,$url_pagination_suffix)|ezurl} class="next" onclick="$('#searchForm input[name=pg]').val('{$nextpag|inc}');$('#searchForm').submit();return false;"><span class="text">{"Next"|i18n("design/bouygues/navigator")}</span></a>
		      {/case}
		      {case}
		      {/case}
		    {/switch}
		
		</p>
		<div class="break"></div>
		</div>
		
		{/section}
		
		 {/let}
		{/default}
		{/default}

		
		

</div>