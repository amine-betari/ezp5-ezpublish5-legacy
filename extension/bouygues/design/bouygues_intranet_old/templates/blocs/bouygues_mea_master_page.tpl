			{def $datas = $object.current.data_map.lien_eby.content.relation_list}
			
			<div class="boxA largebloc">
				<div class="top">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
				<div class="content mea">
				
				{if $datas|count|gt(0)}
				<strong class="title">{$object.name}</strong>

					{foreach $datas as $data}
					
					{def $my_node=fetch( 'content', 'node', hash( 'node_id', $data.node_id ) )}
					
					{*$my_node.data_map|attribute(show,1)*}
					
							{if $my_node.class_identifier|eq('file')}
								{def $url=concat('content/download/',
								$my_node.data_map.file.contentobject_id, '/',
								$my_node.data_map.file.id,'/version/',
								$my_node.data_map.file.version , '/file/',
								$my_node.data_map.file.content.original_filename|urlencode)|ezurl(no)}
							{elseif $my_node.class_identifier|eq('link')}
								{def $url=$my_node.data_map.lien.content|ezurl(no)}
								{def $urlTitle=$my_node.data_map.lien.data_text}
								{def $urlTarget='_blank'}
							{elseif and(or($my_node.class_identifier|eq('bouygues_element_liste'),
										   $my_node.class_identifier|eq('bouygues_element_mea')),
									or($my_node.data_map.lien_eby.has_content, $my_node.data_map.lien_ext.has_content))}
								{if $my_node.data_map.lien_eby.has_content}
									{def $url=$my_node.data_map.lien_eby.value.main_node.url_alias|ezurl(no)}
								{elseif $my_node.data_map.lien_ext.has_content}
									{def $url=$my_node.data_map.lien_ext.content|ezurl(no)}
									{def $urlTitle=$my_node.data_map.lien_ext.data_text}
									{def $urlTarget='_blank'}
								{else}
									{def $url = ''}
								{/if}
							{elseif and(or($my_node.class_identifier|eq('bouygues_element_liste'),$my_node.class_identifier|eq('bouygues_element_mea')), $my_node.data_map.lien_eby.has_content|not(), $my_node.data_map.lien_ext.has_content|not())}
								{def $url=''}
							{else}
								{def $url=$my_node.url_alias|ezurl(no)}
							{/if}
					
					<div class="overview">

						{if $my_node.data_map.image_vignette.has_content}
							<div class="thumb">
								{if eq($url,'')|not()}<a href="{$url}" class="{if $column|eq(1)}image_small{else}image_medium{/if}" {if $urlTarget}target="{$urlTarget}"{/if}>{else}<span class="{if $column|eq(1)}image_small_no-link{else}image_medium_no-link{/if}">{/if}
									<img src="{if $column|eq(1)}{$my_node.data_map.image_vignette.content.thumbmea.url|ezroot(no)}{else}{$my_node.data_map.image_vignette.content.mediummea.url|ezroot(no)}{/if}" alt="{$my_node.data_map.image_vignette.content.alternative_text}" align="middle" border=0/>
								{if eq($url,'')|not()}</a>{else}</span>{/if}
							</div>
						{elseif $my_node.data_map.image_main.has_content}
							<div class="thumb">
								{if eq($url,'')|not()}<a href="{$url}" class="{if $column|eq(1)}image_small{else}image_medium{/if}" {if $urlTarget}target="{$urlTarget}"{/if}>{else}<span class="{if $column|eq(1)}image_small_no-link{else}image_medium_no-link{/if}">{/if}
									<img src="{if $column|eq(1)}{$my_node.data_map.image_main.content.thumbmea.url|ezroot(no)}{else}{$my_node.data_map.image_main.content.mediummea.url|ezroot(no)}{/if}" alt="{$my_node.data_map.image_vignette.content.alternative_text}" align="middle" border=0/>
								{if eq($url,'')|not()}</a>{else}</span>{/if}
							</div>
						{elseif and($my_node.class_identifier|eq('bouygues_video'),not(eq($my_node.data_map.video_wat.content.display, '')))}
							<div class="thumb">
								{if eq($url,'')|not()}<a href="{$url}" class="{if $column|eq(1)}image_small{else}image_medium{/if}" {if $urlTarget}target="{$urlTarget}"{/if}>{else}<span class="{if $column|eq(1)}image_small_no-link{else}image_medium_no-link{/if}">{/if}
									<img width="130" height="63" src="{$my_node.data_map.video_wat.content.thumb_medium}" alt="{$my_node.data_map.image_vignette.content.alternative_text}" align="middle" border=0/>
								{if eq($url,'')|not()}</a>{else}</span>{/if}
							</div>
						{/if}

						<div class="text{if eq($url,'')} noArrow{/if}">
						
							
								{if eq($url,'')|not()}<a href="{$url}" title="{if is_set($urlTitle)}{$urlTitle}{else}{$my_node.name}{/if}" class="subTitle color2" {if $urlTarget}target="{$urlTarget}"{/if}>
								{else}
									<span class="subTitle color2">
								{/if}
							
								{if $my_node.short_title.has_content}
									{$my_node.short_title.content}
								{else}
									{$my_node.name}
								{/if}
							
								{if eq($url,'')|not()}</a>{else}</span>{/if}

							
							{if $my_node.data_map.date_pub.has_content}
								<span class="date">{$my_node.data_map.date_pub.data_int|datetime('custom', '%d/%m/%Y' )}</span>
							{/if}
							
							{undef $urlTitle}
							{undef $urlTarget}
							
						</div>
						<div class="clear">
							{if $my_node.data_map.accroche_liste.has_content}
								{$my_node.data_map.accroche_liste.content.output.output_text}
							{elseif $my_node.data_map.intro.has_content }
								<p>{$my_node.data_map.intro.content.output.output_text|strip_tags()|shorten(300,'...')}</p>
							{elseif $my_node.data_map.chapeau.has_content }
								<p>{$my_node.data_map.chapeau.content.output.output_text|strip_tags()|shorten(300,'...')}</p>
							{elseif $my_node.data_map.body.has_content }
								<p>{$my_node.data_map.body.content.body.content.output.output_text|strip_tags()|shorten(300,'...')}</p>
							{/if}
						</div>
					</div>
					
						{undef $url}
					{/foreach}
					{undef $datas}
					{/if}		
				</div>
				<div class="bottom">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
			</div>
			
		
			{undef}
			
