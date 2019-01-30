			<div class="boxA smallbloc">
				<div class="top">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
				<div class="content texte">
				<strong class="title">{$object.data_map.titre_bloc.content}</strong>
					<div class="overview">
					<strong class="subTitle color2">{$object.data_map.titre_texte.content}</strong>
						
								{if $object.data_map.lien_eby.has_content}
							
								{if $object.data_map.lien_eby.content.current.class_identifier|eq('file')}
									{def $url=concat('content/download/',
									$object.data_map.lien_eby.content.current.data_map.file.contentobject_id, '/',
									$object.data_map.lien_eby.content.current.data_map.file.id,'/version/',
									$object.data_map.lien_eby.content.current.data_map.file.version , '/file/',
									$object.data_map.lien_eby.content.current.data_map.file.content.original_filename|urlencode)|ezurl(no)}
								{elseif $object.data_map.lien_eby.content.current.class_identifier|eq('link')}
									{def $url=$object.data_map.lien_eby.content.current.data_map.lien.content|ezurl(no)}
									{def $urlTitle=$object.data_map.lien_eby.content.current.data_map.lien.data_text}
									{def $urlTarget='_blank'}
								{elseif or($object.data_map.lien_eby.has_content, $object.data_map.lien_ext.has_content)}
										{if $object.data_map.lien_eby.has_content}
											{def $url=$object.data_map.lien_eby.value.main_node.url_alias|ezurl(no)}
										{elseif $object.data_map.lien_ext.has_content}
											{def $url=$object.data_map.lien_ext.content|ezurl(no)}
											{def $urlTitle=$object.data_map.lien_ext.data_text}
											{def $urlTarget='_blank'}
										{else}
											{def $url = ''}
										{/if}
								{else}
									{def $url=$object.data_map.lien_ext.content.url_alias|ezurl(no)}
								{/if}
							{/if}
						
							{if$object.data_map.image_texte.has_content}
								<div class="thumb">
									{if $url|eq('')|not }
									<a href="{$url}" class="{if $column|eq(1)}image_small{else}image_medium{/if}" {if is_set($urlTarget)}target="{$urlTarget}"{/if}>
									{else}
									<span class="image_small">
									{/if}	
										<img src="{if $column|eq(1)}{$object.data_map.image_texte.content.thumbtexte.url|ezroot(no)}{else}{$object.data_map.image_texte.content.mediumtexte.url|ezroot(no)}{/if}" alt="{$object.data_map.image_texte.content.alternative_text}" border="0" />
									
									{if $url|eq('')|not }
									</a>
									{else}
									</span>
									{/if}
									
								</div>
							{/if}
						
				
						<div class="text">
							{$object.data_map.contenu_texte.content.output.output_text}
						</div>
						<div class="clear">
						
							{if $object.data_map.lien_eby.has_content}
							
								<a href="{$url}" class="btn-grey-arrow-left" {if is_set($urlTarget)}target="{$urlTarget}"{/if}>{if $object.data_map.url_text_link.has_content}{$object.data_map.url_text_link.content}{else}{$object.data_map.lien_eby.content.name}{/if}</a>
								
							{elseif $object.data_map.url_ext.has_content}
							
								<a href="{$object.data_map.url_ext.content}" class="btn-grey-arrow-left" target="_blank">{if $object.data_map.url_text_link.has_content}{$object.data_map.url_text_link.content}{else}{$object.data_map.url_ext.data_text}{/if}</a>
								
							{/if}
						</div>
					</div>
				</div>
				<div class="bottom">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
			</div>
			{undef}