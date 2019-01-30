{set-block scope=global variable=cache_ttl}0{/set-block}		
            {def $children_node_id = $object.current.data_map.rub_parente_breves.content.main_node.node_id}
            {def $maxItems = $object.current.data_map.remontees_select.class_content.options[$object.current.data_map.remontees_select.value.0].name}
            
            {def $tri = 'published'}
            {if $object.current.data_map.tri.value.0|eq(1)}
            	{set $tri = 'modified'}
            {else}
            	{set $tri = 'published'}
            {/if}
			
			{def $filter_after_fetch=0}
			{def $filter_items=$maxItems}
            {if $object.current.data_map.rub_children_cb.value|eq(1)}
            
            {def $depth = 10}
            	{* added by LIU Bin, limit 50 items, and filter last 10 items not in dossier mini_site diapo*}
            	{set $maxItems=50}
            	{set $filter_after_fetch=1}
            {else}{def $depth = 1}{/if}		
			
			{def $datas=fetch('content','list',hash(
											'parent_node_id',$children_node_id,
											'class_filter_type',  'include',
											'class_filter_array', array(    'article',
																			'bouygues_dossier',
																			'bouygues_diapo',
																			'bouygues_element_liste', 
																			'bouygues_galerie_vid',
																			'bouygues_video', 
																			'bouygues_mini_site',
																			'file'
																		),
											'depth',$depth,
											'offset',0,
											'limit',$maxItems,
											'sort_by', array( array( $tri, false() ))
											)
			)}
			
			<div class="boxA smallbloc">
				<div class="top">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
				<div class="content brief">
				<strong class="title">{$object.current.data_map.titre.content}</strong>
				
				{$object.current.data_map.description.content.output.output_text}

              	  <ul>
              	  {def $counter=1}
	              {foreach $datas as $data}
	              		{if $filter_after_fetch|eq(1)}
	              			{*counter : {$counter}<br>
	              			filter_after_fetch : {$filter_after_fetch}<br>
	              			class : {$data.parent.class_identifier}<br>
	              			*}
	              			{if $data.parent.class_identifier|eq('bouygues_dossier')}
	              				{continue}
	              			{elseif $data.parent.class_identifier|eq('bouygues_diapo')}
	              				{continue}
	              			{elseif $data.parent.class_identifier|eq('bouygues_mini_site')}
	              				{continue}
	              			{/if}
	              			{if $counter|gt($filter_items)}{break}{/if}
	              			{set $counter=$counter|inc()}
	              		{/if}
	              		
									{if $data.class_identifier|eq('file')}
											{def $url=concat('content/download/',
											$data.data_map.file.contentobject_id, '/',
											$data.data_map.file.id,'/version/',
											$data.data_map.file.version , '/file/',
											$data.data_map.file.content.original_filename|urlencode)|ezurl(no)}
									{elseif $data.class_identifier|eq('newsletter_issue')}
										{def $url=$data.url_alias|ezurl(no)}
										{def $urlTarget='_blank'}
									{elseif $data.class_identifier|eq('link')}
										{def $url=$data.data_map.lien.content|ezurl(no)}
										{def $urlTitle=$data.data_map.lien.data_text}
										{def $urlTarget='_blank'}
									{elseif $data.class_identifier|eq('bouygues_element_liste')|not()}
										{def $url=$data.url_alias|ezurl(no)}
									{elseif and($data.class_identifier|eq('bouygues_element_liste'),or($data.data_map.lien_eby.has_content, $data.data_map.lien_ext.has_content))}
										{if $data.data_map.lien_eby.has_content}
											{def $url=$data.data_map.lien_eby.value.main_node.url_alias|ezurl(no)}
										{elseif $data.data_map.lien_ext.has_content}
											{def $url=$data.data_map.lien_ext.content|ezurl(no)}
											{def $urlTitle=$data.data_map.lien_ext.data_text}
											{def $urlTarget='_blank'}
										{else}{def $url = ''}{/if}
									{else}{def $url = '#'}
									{/if}
						<li>
		    				<span class="date">{$data.data_map.date_pub.content.timestamp|datetime( 'custom', '%d/%m/%Y' )}</span> 
		    				{if eq($url,'#')|not()}<a href="{$url}" title="{if is_set($urlTitle)}{$urlTitle}{else}{$data.name}{/if}" {if is_set($urlTarget)}target="{$urlTarget}"{/if} >{/if}{$data.name}{if eq($url,'#')|not()}</a>{/if}
						</li>
				
  					{undef $url}
				  {/foreach}
				  {undef $datas }
				  </ul>
				
				{if $object.current.data_map.lien_liste_cb.value|eq(1)}
					<a href="{$object.current.data_map.rub_parente_breves.content.main_node.url_alias|ezurl(no)}" class="btn-grey-arrow-left">{$object.current.data_map.lib_ts_elem.content}</a>				
				{/if}
				
				</div>

				<div class="bottom">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
			</div>
			{undef}