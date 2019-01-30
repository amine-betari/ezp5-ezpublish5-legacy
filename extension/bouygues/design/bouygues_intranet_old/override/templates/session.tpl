<div class="default list post">
	{include uri="design:blocs/tools.tpl"}
	<h1>{$node.data_map.titre.content|wash()}</h1>
	<div class="content1">
			{if $node.data_map.image.has_content}	
			<div class="thumb">
				<img src="{$node.data_map.image.content.thumblistheader.url|ezroot(no)}" alt="{if $node.data_map.image.content.alternative_text}{$node.data_map.image.content.alternative_text}{elseif $node.data_map.legende.has_content}{$node.data_map.legende.content}{else}{$node.data_map.titre.content|wash()}{/if}" title="{if $node.data_map.image.content.alternative_text}{$node.data_map.image.content.alternative_text}{elseif $node.data_map.legende.has_content }{$node.data_map.legende.content}{else}{$node.data_map.titre.content|wash()}{/if}"/><br />
			</div>
			{/if}
			<div class="text">
				<div class="intro">
					{if $node.data_map.intro.has_content}
						{attribute_view_gui attribute=$node.data_map.intro}
					{/if}
				</div>
			</div>
	</div>
	<div class="content2">
				{def $section_id = $node.object.section_id}
				{def $whoswhos = fetch( 'content', 'tree', hash(
													  'parent_node_id', 2,
				              						  'class_filter_type',  'include',
				              						  'class_filter_array', array( 'bouygues_whoswho'),
				              						  'depth', 3,
				              						  'limitation', array()
				              						  ))}
				{foreach $whoswhos as $whoswho}{if eq($whoswho.object.section_id, $section_id)}{def $ww_id = $whoswho.object.id}{/if}{/foreach}
				{set $whoswhos = fetch( 'content', 'tree', hash(
									  'parent_node_id', 2,
              						  'class_filter_type',  'include',
              						  'class_filter_array', array( 'bouygues_whoswho_search'),
              						  'depth', 3,
              						  'limitation', array()
              						  ))}
				{foreach $whoswhos as $whoswho}{if eq($whoswho.object.section_id, $section_id)}{def $url_whoswho = $whoswho.url_alias}{/if}{/foreach}			
				{def $main_lists = fetch('content', 'list',
														hash('parent_node_id', $node.node_id,
														'class_filter_type','include',
														'class_filter_array',array('bouygues_session'),
														'sort_by', array( array( 'priority', false() ) ) ))}
				{def $i=0}
				{foreach $main_lists as $main_list}
				<div class="item {if $i|eq(0)}first{/if}">

					<h2 class="noColor">{$main_list.name}</h2>								  	
					{include uri="design:blocs/session.tpl" children=$sub_list}
					{undef $sub_list}{undef $sub_list_total_count}
				</div>
				{set $i=inc($i)}	
				{/foreach}{undef $main_lists $section_id $whoswhos $url_whoswho}{undef $i}
	</div>	

</div>

<div class="plus default">{include uri="design:blocs/annexe.tpl"}</div>