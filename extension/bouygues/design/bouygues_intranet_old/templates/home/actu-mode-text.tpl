				<div class="mode-text">
					<div class="middle">
					<div class="carrousel">
					{def $actus = $array}
					
					{foreach $actus as $data}	
					
					{*def $data = fetch( 'content', 'node', hash('node_id', $actu.node_id ) )*}
				
					{if $data.class_identifier|eq('file')}
								{def $url=concat('content/download/',
								$data.data_map.file.contentobject_id, '/',
								$data.data_map.file.id,'/version/',
								$data.data_map.file.version , '/file/',
								$data.data_map.file.content.original_filename|urlencode)|ezurl(no)}
							{elseif $data.class_identifier|eq('link')}
								{def $url=$data.data_map.lien.content|ezurl(no)}
								{def $urlTitle=$data.data_map.lien.data_text}
								{def $urlTarget='_blank'}
							{elseif or($data.class_identifier|eq('bouygues_element_liste'),
										   $data.class_identifier|eq('bouygues_element_mea'))}
									
								{if $data.data_map.lien_eby.has_content}
									{def $url=$data.data_map.lien_eby.value.main_node.url_alias|ezurl(no)}
								{elseif $data.data_map.lien_ext.has_content}
									{def $url=$data.data_map.lien_ext.content|ezurl(no)}
									{def $urlTitle=$data.data_map.lien_ext.data_text}
									{def $urlTarget='_blank'}
								{else}
									{def $url = ''}
								{/if}
							{else}
								{def $url=$data.url_alias|ezurl(no)}
							{/if}

						<div class="overview">
							{if $data.object.section_id|eq(16)|not}
								<img src="{concat("breadcrumb/",$arrCssSubStructure[$data.object.section_id],"/start_hard.gif")|ezimage(no)}" alt="" />
							{/if}
							{if $url|eq('')|not()}<a href="{$url}" title="{$data.name}" {if is_set($urlTarget)}target="{$urlTarget}"{/if}>{/if}{$data.name}{if $url|eq('')|not()}</a>{/if}
							
							{if and(is_set($data.data_map.date_pub),and(is_set($data.data_map.date_pub_cb),$data.data_map.date_pub_cb.content|eq(1)))}
							<span class="date">{$data.data_map.date_pub.data_int|datetime( 'custom', '%d/%m/%Y' )}</span>
							{else}
							<span class="date">{$data.object.current.modified|datetime( 'custom', '%d/%m/%Y' )}</span>
							{/if}
						</div>
						
					{undef $data $url $urlTarget}
					{/foreach}
						</div>
					</div>
				</div>	
