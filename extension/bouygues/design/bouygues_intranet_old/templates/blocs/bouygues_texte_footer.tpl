		
	{def $containers = fetch( 'content', 'list', hash('parent_node_id', $node.node_id, 
										'class_filter_type', 'include',
										'class_filter_array', array('bouygues_master_container')
										))}
	
	{foreach $containers as $container}								
		{def $bloc_texte_footer = fetch( 'content', 'list',hash( 'parent_node_id', $container.node_id,
	              				  'class_filter_type',  'include',
	              				  'class_filter_array', array( 'bouygues_texte_footer') ))}

		{foreach $bloc_texte_footer as $bloc_texte}
			<div class="boxA footer_texte">
				<div class="top">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
				<div class="content">
				
					<strong class="title">{$bloc_texte.data_map.titre_bloc.content}</strong>

					{if and($bloc_texte.data_map.titre_texte_1.has_content,$bloc_texte.data_map.titre_texte_2.has_content|not,$bloc_texte.data_map.titre_texte_3.has_content|not)}
						{def $classe = 'one-item'}
					{elseif and($bloc_texte.data_map.titre_texte_1.has_content,$bloc_texte.data_map.titre_texte_2.has_content,$bloc_texte.data_map.titre_texte_3.has_content)}
						{def $classe = 'three-item'}
					{else}
						{def $classe = 'two-item'}
					{/if}
				
					{*bloc1*}
					<div class="overview {$classe}">
					<strong class="subTitle color2">{$bloc_texte.data_map.titre_texte_1.content}</strong>
						
								{if $bloc_texte.data_map.lien_eby_1.has_content}
							
								{if $bloc_texte.data_map.lien_eby_1.content.current.class_identifier|eq('file')}
									{def $url=concat('content/download/',
									$bloc_texte.data_map.lien_eby_1.content.current.data_map.file.contentobject_id, '/',
									$bloc_texte.data_map.lien_eby_1.content.current.data_map.file.id,'/version/',
									$bloc_texte.data_map.lien_eby_1.content.current.data_map.file.version , '/file/',
									$bloc_texte.data_map.lien_eby_1.content.current.data_map.file.content.original_filename|urlencode)|ezurl(no)}
								{elseif $bloc_texte.data_map.lien_eby_1.content.current.class_identifier|eq('link')}
									{def $url=$bloc_texte.data_map.lien_eby_1.content.current.data_map.lien.content|ezurl(no)}
									{def $urlTitle=$bloc_texte.data_map.lien_eby_1.content.current.data_map.lien.data_text}
									{def $urlTarget='_blank'}
								{elseif or($bloc_texte.data_map.lien_eby_1.has_content, $bloc_texte.data_map.url_ext_1.has_content)}
										{if $bloc_texte.data_map.lien_eby_1.has_content}
											{def $url=$bloc_texte.data_map.lien_eby_1.value.main_node.url_alias|ezurl(no)}
										{elseif $bloc_texte.data_map.url_ext_1.has_content}
											{def $url=$bloc_texte.data_map.url_ext_1.content|ezurl(no)}
											{def $urlTitle=$bloc_texte.data_map.url_ext_1.data_text}
											{def $urlTarget='_blank'}
										{else}
											{def $url = '"#"'}
										{/if}
								{else}
									{def $url=$bloc_texte.data_map.url_ext_1.content.url_alias|ezurl(no)}
								{/if}
							{/if}
				
						<div class="text">
							{$bloc_texte.data_map.contenu_texte_1.content.output.output_text}
						</div>
						
						<div class="clear">
						
							{if $bloc_texte.data_map.lien_eby_1.has_content}
							
								<a href="{$url}" class="btn-grey-arrow-left" {if is_set($urlTarget)}target="{$urlTarget}"{/if}>{if $bloc_texte.data_map.url_text_link_1.has_content}{$bloc_texte.data_map.url_text_link_1.content}{else}{$bloc_texte.data_map.lien_eby_1.content.name}{/if}</a>
								
							{elseif $bloc_texte.data_map.url_ext_1.has_content}
							
								<a href="{$bloc_texte.data_map.url_ext_1.content}" class="btn-grey-arrow-left" target="_blank">{if $bloc_texte.data_map.url_text_link_1.has_content}{$bloc_texte.data_map.url_text_link_1.content}{else}{$bloc_texte.data_map.url_ext_1.data_text}{/if}</a>
								
							{/if}
						</div>
						
					</div>
					{*bloc1*}
					
					
						{*bloc2*}
					<div class="overview {$classe}">
					<strong class="subTitle color2">{$bloc_texte.data_map.titre_texte_2.content}</strong>
						
								{if $bloc_texte.data_map.lien_eby_2.has_content}
							
								{if $bloc_texte.data_map.lien_eby_2.content.current.class_identifier|eq('file')}
									{def $url=concat('content/download/',
									$bloc_texte.data_map.lien_eby_2.content.current.data_map.file.contentobject_id, '/',
									$bloc_texte.data_map.lien_eby_2.content.current.data_map.file.id,'/version/',
									$bloc_texte.data_map.lien_eby_2.content.current.data_map.file.version , '/file/',
									$bloc_texte.data_map.lien_eby_2.content.current.data_map.file.content.original_filename|urlencode)|ezurl(no)}
								{elseif $bloc_texte.data_map.lien_eby_2.content.current.class_identifier|eq('link')}
									{def $url=$bloc_texte.data_map.lien_eby_2.content.current.data_map.lien.content|ezurl(no)}
									{def $urlTitle=$bloc_texte.data_map.lien_eby_2.content.current.data_map.lien.data_text}
									{def $urlTarget='_blank'}
								{elseif or($bloc_texte.data_map.lien_eby_2.has_content, $bloc_texte.data_map.url_ext_2.has_content)}
										{if $bloc_texte.data_map.lien_eby_2.has_content}
											{def $url=$bloc_texte.data_map.lien_eby_2.value.main_node.url_alias|ezurl(no)}
										{elseif $bloc_texte.data_map.url_ext_2.has_content}
											{def $url=$bloc_texte.data_map.url_ext_2.content|ezurl(no)}
											{def $urlTitle=$bloc_texte.data_map.url_ext_2.data_text}
											{def $urlTarget='_blank'}
										{else}
											{def $url = '"#"'}
										{/if}
								{else}
									{def $url=$bloc_texte.data_map.url_ext_2.content.url_alias|ezurl(no)}
								{/if}
							{/if}
				
						<div class="text">
							{$bloc_texte.data_map.contenu_texte_2.content.output.output_text}
						</div>
						
						<div class="clear">
						
							{if $bloc_texte.data_map.lien_eby_2.has_content}
							
								<a href="{$url}" class="btn-grey-arrow-left" {if is_set($urlTarget)}target="{$urlTarget}"{/if}>{if $bloc_texte.data_map.url_text_link_2.has_content}{$bloc_texte.data_map.url_text_link_2.content}{else}{$bloc_texte.data_map.lien_eby_2.content.name}{/if}</a>
								
							{elseif $bloc_texte.data_map.url_ext_2.has_content}
							
								<a href="{$bloc_texte.data_map.url_ext_2.content}" class="btn-grey-arrow-left" target="_blank">{if $bloc_texte.data_map.url_text_link_2.has_content}{$bloc_texte.data_map.url_text_link_2.content}{else}{$bloc_texte.data_map.url_ext_2.data_text}{/if}</a>
								
							{/if}
						</div>
						
					</div>
					{*bloc2*}
					
					{*bloc3*}
					<div class="overview {$classe}">
					<strong class="subTitle color2">{$bloc_texte.data_map.titre_texte_3.content}</strong>
						
								{if $bloc_texte.data_map.lien_eby_3.has_content}
							
								{if $bloc_texte.data_map.lien_eby_3.content.current.class_identifier|eq('file')}
									{def $url=concat('content/download/',
									$bloc_texte.data_map.lien_eby_3.content.current.data_map.file.contentobject_id, '/',
									$bloc_texte.data_map.lien_eby_3.content.current.data_map.file.id,'/version/',
									$bloc_texte.data_map.lien_eby_3.content.current.data_map.file.version , '/file/',
									$bloc_texte.data_map.lien_eby_3.content.current.data_map.file.content.original_filename|urlencode)|ezurl(no)}
								{elseif $bloc_texte.data_map.lien_eby_3.content.current.class_identifier|eq('link')}
									{def $url=$bloc_texte.data_map.lien_eby_3.content.current.data_map.lien.content|ezurl(no)}
									{def $urlTitle=$bloc_texte.data_map.lien_eby_3.content.current.data_map.lien.data_text}
									{def $urlTarget='_blank'}
								{elseif or($bloc_texte.data_map.lien_eby_3.has_content, $bloc_texte.data_map.url_ext_3.has_content)}
										{if $bloc_texte.data_map.lien_eby_3.has_content}
											{def $url=$bloc_texte.data_map.lien_eby_3.value.main_node.url_alias|ezurl(no)}
										{elseif $bloc_texte.data_map.url_ext_3.has_content}
											{def $url=$bloc_texte.data_map.url_ext_3.content|ezurl(no)}
											{def $urlTitle=$bloc_texte.data_map.url_ext_3.data_text}
											{def $urlTarget='_blank'}
										{else}
											{def $url = '"#"'}
										{/if}
								{else}
									{def $url=$bloc_texte.data_map.url_ext_3.content.url_alias|ezurl(no)}
								{/if}
							{/if}
				
						<div class="text">
							{$bloc_texte.data_map.contenu_texte_3.content.output.output_text}
						</div>
						
						<div class="clear">
						
							{if $bloc_texte.data_map.lien_eby_3.has_content}
							
								<a href="{$url}" class="btn-grey-arrow-left" {if is_set($urlTarget)}target="{$urlTarget}"{/if}>{if $bloc_texte.data_map.url_text_link_3.has_content}{$bloc_texte.data_map.url_text_link_3.content}{else}{$bloc_texte.data_map.lien_eby_3.content.name}{/if}</a>
								
							{elseif $bloc_texte.data_map.url_ext_3.has_content}
							
								<a href="{$bloc_texte.data_map.url_ext_3.content}" class="btn-grey-arrow-left" target="_blank">{if $bloc_texte.data_map.url_text_link_3.has_content}{$bloc_texte.data_map.url_text_link_3.content}{else}{$bloc_texte.data_map.url_ext_3.data_text}{/if}</a>
								
							{/if}
						</div>
						
					</div>
					{*bloc3*}
					
				</div>
				<div class="bottom">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
			</div>
		
			{/foreach}
	{/foreach}
			{undef}