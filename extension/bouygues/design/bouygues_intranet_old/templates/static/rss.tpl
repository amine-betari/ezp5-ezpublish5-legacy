{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}
<div class="default rssPage static">
{include uri="design:blocs/tools.tpl" light=1 btn_back=1}

	{def $my_node=fetch( 'content', 'node', hash( 'node_id', 11396 ) )}
												  
	<h1>{$my_node.data_map.title.content}</h1>
	
	{$my_node.data_map.content.content.output.output_text}
	
	
	{*def $filieres = fetch( 'content', 'list', hash( 'parent_node_id', 2,
									'class_filter_type',  'include',
									'class_filter_array', array( 'bouygues_master_page' ), 
									'sort_by', array( array( 'priority' ) )
									))*}
	
	{def $url='https://'}
	
	
		
	{undef $url}
	{def $count_items = 0}	
	
	{foreach $exportList as $export}
	{*$export|attribute(show,1)*}
	{*foreach $filieres as $filiere*}
	
	{def $filieres = fetch( 'content', 'list', hash( 'parent_node_id', 2,
									'class_filter_type',  'include',
									'class_filter_array', array( 'bouygues_master_page' ),
									'attribute_filter',  array(array('section','=',$export.item_list.0.source_node.object.section_id)),
									'limit', 1,
									'depth', 1)
									)}
	{def $filiere=$filieres.0}
	
	{if $count_items|mod(5)|eq(0)}
		<div class="rssItems">
	{/if}

	{def $urlTemp=concat('rss/feed/',$export.access_url)|ezurl(no)}
	{def $url = concat('https://',$host_path,$urlTemp)}
	


	<div class="item">
		<a href="{$url}" class="title btn-plus color3-{$arrCssSubStructure[$export.item_list.0.source_node.object.section_id]}" target="_blank" ><img src="{concat("images/breadcrumb/",$arrCssSubStructure[$export.item_list.0.source_node.object.section_id],"/start_hard.gif")|ezdesign(no)}" alt="" border=0 /> {$export.title}</a>
		<div class="sub-item-desc">
			<strong class="color3-{$arrCssSubStructure[$export.item_list.0.source_node.object.section_id]}">{$export.description}</strong>
		</div>
		<!-- 
		<div class="sub-item">
			<strong class="color3-{$arrCssSubStructure[$export.item_list.0.source_node.object.section_id]}">{'rss_filiere_know_all'|i18n('design/bouygues/static')} {$filiere.name}</strong>
			<div class="sub-sub-item">
				<a href="#" class="btn-grey-arrow-left" onclick="return false;">{'rss_subscribe_agregator'|i18n('design/bouygues/static')}</a>
			
				<p class="sub-sub-sub-item">
					<a href="http://add.my.yahoo.com/rss?url={$url}"><img src={"pictos/rss/yahoo.gif"|ezimage} border=0 /></a>
					<a href="http://www.netvibes.com/subscribe.php?feed={$url}"><img src={"pictos/rss/netvibes.gif"|ezimage} border=0 /></a>
					<a href="http://my.msn.com/addtomymsn.armx?id=rss&ut={$url}"><img src="{"pictos/rss/msn.gif"|ezimage} border=0 /></a>
					<br />
					
					<a href="http://fusion.google.com/add?source=atgs&moduleurl={$url}"><img src={"pictos/rss/google.gif"|ezimage} border=0 /></a>
					<a href="http://www.wikio.fr/subscribe?url={$url}"><img src={"pictos/rss/wikio.gif"|ezimage} border=0 /></a>
					<a href="http://www.voila.fr/Rss/?url={$url}"><img src={"pictos/rss/voila.gif"|ezimage} border=0 /></a>
				</p>
			
			</div>
			<div class="sub-sub-item">
				<a href="#" class="btn-grey-arrow-left" onclick="return false;">{'rss_copy_paste'|i18n('design/bouygues/static')}</a>
			
				<p class="sub-sub-sub-item">
					<a href="{$url}" target="_blank"><img src={"pictos/rss/small.gif"|ezimage} border=0 /></a>
					<input type="text" value="{$url}"/>
				</p>
			
			</div>
			
		</div>
		-->
	</div>
	

	<div class="clear"></div>
	{if or($count_items|inc(5)|mod(5)|eq(0),$count_items|eq($filieres|count|sub(1)))}</div>{/if}

	
	{set $count_items = $count_items|inc($count_items)}
	{undef $url $filiere $filieres $urlTemp}
	{/foreach}
</div>