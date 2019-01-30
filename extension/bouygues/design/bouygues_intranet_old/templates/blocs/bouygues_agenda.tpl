			{def $numberOfObjects = $object.data_map.remontees_select.class_content.options[$object.data_map.remontees_select.value[0]].name}
			{def $timestamp = currentdate()}
			{set $timestamp = $timestamp|sub(86401)}
			{if $object.data_map.events_futur_cb.value|eq(1)}
			
			
			{def $datas = fetch( 'content', 'list',hash( 
									  'parent_node_id', $node.node_id,
              						  'class_filter_type',  'include',
              						  'class_filter_array', array( 'bouygues_entree_agenda'),
              						  'attribute_filter', array(or,
												array( 'bouygues_entree_agenda/date_debut','>',$timestamp),
												array( 'bouygues_entree_agenda/date_fin','>=',$timestamp)
									   ),
              						  'sort_by', array('attribute' ,true(),'bouygues_entree_agenda/date_debut') ))}
			{else}
			{def $datas = fetch( 'content', 'list',hash( 'parent_node_id', $node.node_id,
              						  'class_filter_type',  'include',
              						  'class_filter_array', array( 'bouygues_entree_agenda'),
              						  'sort_by', array('attribute' ,true(),'bouygues_entree_agenda/date_debut') ))}
			{/if}
		
				{if and(is_array($datas),$datas|count|gt(0))}
			<div class="boxA smallbloc">
				<div class="top">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
				<div class="content agenda">


				<div id="agenda_carousel_{$object.id}" class="agenda_carousel">
				
					<div style="position:absolute;right:5px;">
						<a class="mycarousel slide-prev btn-previous-page" onclick="return false;"></a>
						<a class="mycarousel slide-next btn-next-page" onclick="return false;"></a>
					</div>
					
					<strong class="title">{$object.name|shorten(30,'...')}</strong>
				
			

			
					<div class="mycarousel global">
					<div class="mycarousel container">	

						
				{def $count_items = 0}	
					{foreach $datas as $data}								
						{if or($count_items|mod($numberOfObjects)|eq(0),$count_items|eq(0))}<div class="item {if $column|eq(1)}item_small{else}item_medium{/if}">{/if}
					
						<div class="overview">
							<div class="date">
									{if $data.data_map.date_fin.has_content}
									du
									{/if}
									
									{$data.data_map.date_debut.data_int|datetime( 'custom', '%d/%m/%Y' )}
									
									{if $data.data_map.date_fin.has_content}
									au
									{$data.data_map.date_fin.data_int|datetime( 'custom', '%d/%m/%Y' )}
									{/if}
							</div>
							<div class="text">
								{def $url=""}
								{if $data.data_map.url_ext.has_content}
									{set $url=$data.data_map.url_ext.content}
									{def $urlTarget='_blank'}
								{elseif $data.data_map.lien_eby.has_content}
									{def $child=$data.data_map.lien_eby.content.main_node}
									
									{if $child.class_identifier|eq('file')}
											{set $url=concat('content/download/',
											$child.data_map.file.contentobject_id, '/',
											$child.data_map.file.id,'/version/',
											$child.data_map.file.version , '/file/',
											$child.data_map.file.content.original_filename|urlencode)|ezurl(no)}
										{elseif $child.class_identifier|eq('newsletter_issue')}
											{set $url=$child.url_alias|ezurl(no)}
											{def $urlTarget='_blank'}
										{elseif $child.class_identifier|eq('link')}
											{set $url=$child.data_map.lien.content|ezurl(no)}
											{def $urlTitle=$child.data_map.lien.data_text}
											{def $urlTarget='_blank'}
										{elseif $child.class_identifier|eq('bouygues_element_liste')|not()}
											{set $url=$child.url_alias|ezurl(no)}
										{elseif and($child.class_identifier|eq('bouygues_element_liste'),or($child.data_map.lien_eby.has_content, $child.data_map.lien_ext.has_content))}
											{if $data.data_map.lien_eby.has_content}
												{set $url=$child.data_map.lien_eby.value.main_node.url_alias|ezurl(no)}
											{elseif $child.data_map.lien_ext.has_content}
												{set $url=$child.data_map.lien_ext.content|ezurl(no)}
												{def $urlTitle=$child.data_map.lien_ext.data_text}
												{def $urlTarget='_blank'}
											{else}{def $url = ''}{/if}
										{else}{def $url = ''}
									{/if}
									
									
								{/if}
								
								{if $url}
								<a href="{$url}" {if is_set($urlTarget)}target="{$urlTarget}"{/if}>{$data.data_map.titre.content|shorten(100,'...')}</a>
								{else}
								<span class="color2">{$data.data_map.titre.content|shorten(100,'...')}</span>
								{/if}
								
							</div>
							<div class="contact">
								{$data.data_map.description.content.output.output_text}
							</div>
						</div>
						
						{if or($count_items|inc($numberOfObjects)|mod($numberOfObjects)|eq(0),$count_items|eq($datas|count|sub(1)))}</div>{/if}
						
						{set $count_items=inc($count_items)}
						
						{undef $url $urlTarget}
					{/foreach}
					{undef $datas}
					</div>
					</div>

						</div>

				</div>
				<div class="bottom">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
			</div>
			
					
	{literal}
       <script type="text/javascript">
		$().ready(function(){
			$('#agenda_carousel_{/literal}{$object.id}{literal}').slideMajes({'numElementDisplayed':'1', 'type':'horizontal', 'includeMargin':false,'animateDuration':0});			
		});
		</script>
		{/literal}
			
			{undef}
								{/if}	