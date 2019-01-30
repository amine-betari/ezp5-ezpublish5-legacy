{* Diaporama - Full view *}

<div class="default diaporama post" id="diaporamaPhotoLb">

		{if and(is_unset($lightbox), is_unset($includemode),is_unset($parent))}
			{include uri="design:blocs/tools.tpl"}
		{/if}
			
			
        <h1>{$node.data_map.titre.content|wash()}</h1>
        
        {if is_unset($lightbox)}
        <h2>{$node.data_map.sous_titre.content|wash()}</h2>
        <div class="intro">
        	{$node.data_map.description.content.output.output_text}
        </div>
        {/if}
        
        <div id="diaporama{if is_set($lightbox)}_lb{/if}{if is_set($includemode)}_inc{/if}">
			<img src="{'images/diaporama/default.png'|ezdesign(no)}" title="" class="diaporama_large" alt=""/>
			<a href="#" class="diaporama_previous" onclick="return false;" title="Précédent"><span style="display: none">Précédent</span></a>
			<a href="#" class="diaporama_play" title="Play" onclick="return false;"></a>
			{if is_unset($lightbox)}<a href="#" class="diaporama_zoom" title="Zoom" onclick="return false;"><span style="display: none">Zoom</span></a>{/if}
			<a href="#" class="diaporama_next" onclick="return false;" title="Suivant"><span style="display: none">Suivant</span></a>
		</div>
		
		<span class="diaporama{if is_set($lightbox)}_lb{/if}{if is_set($includemode)}_inc{/if}_copyright pic_copyright"></span>
		
		<h4 class="diaporama{if is_set($lightbox)}_lb{/if}{if is_set($includemode)}_inc{/if}_title"></h4>
		
		<p class="diaporama{if is_set($lightbox)}_lb{/if}{if is_set($includemode)}_inc{/if}_legend"></p>
		
		{def $children = fetch( 'content', 'list',hash( 'parent_node_id', $node.node_id,
              						  'class_filter_type',  'include',
              						  'class_filter_array', array( 'bouygues_diapo_image'), 
              						  'sort_by', array( array( 'priority' ) )))}
	
		{if and(eq($node.data_map.carroussel_vignette_cb.value,1),is_unset($lightbox))}
		<div  id="diaporama_carousel{if is_set($includemode)}_inc{/if}" {if is_set($includemode)}class="inc"{/if}>
			<div class="mycarousel slide-prev"></div>
			<div class="mycarousel global">
			
				<div class="mycarousel container">					
					{foreach $children as $child }
					<div class="item diaporama{if is_set($includemode)}_inc{/if}_load" id="diaporama_item_{$child.node_id}">
						{if and(is_unset($includemode),is_unset($parent))}
						<a href="/{$node.url_alias}/(nodeid)/diaporama_item_{$child.node_id}" onclick="return false;">
						{else}
						<a href="/{$node.parent.url_alias}/(nodeid)/diaporama_item_{$child.node_id}" onclick="return false;">
						{/if}
					
						<span class="item_small{if and(is_set($nodeid), eq($nodeid, concat('diaporama_item_',$child.node_id)))} on{/if}"></span>
						{if $child.data_map.vignette.has_content}<img src="{$child.data_map.vignette.content.thumbdiaporama.url|ezroot(no)}" title="{if $child.data_map.vignette.content.alternative_text|eq('')|not()}{$child.data_map.vignette.content.alternative_text}{else}{$child.data_map.titre.content}{/if}" alt="{if $child.data_map.vignette.content.alternative_text|eq('')|not()}{$child.data_map.vignette.content.alternative_text}{else}{$child.data_map.titre.content}{/if}"/>
						{else}<img src="{$child.data_map.image.content.thumbdiaporama.url|ezroot(no)}" title="{if $child.data_map.image.content.alternative_text|eq('')|not()}{$child.data_map.image.content.alternative_text}{else}{$child.data_map.titre.content}{/if}" alt="{if $child.data_map.image.content.alternative_text|eq('')|not()}{$child.data_map.image.content.alternative_text}{else}{$child.data_map.titre.content}{/if}"/>{/if}</a>
					</div>
					{/foreach}
				</div>
			
			</div>
			<div class="mycarousel slide-next"></div>
		</div>		
		{/if}

	   {literal}
     <script type="text/javascript">
		$().ready(function(){
			{/literal}
				{if is_set($includemode)}{def $numitemsperpage=5}{else}{def $numitemsperpage=6}{/if}
				{literal}
				var diaporamaItems ={
					{/literal}
					{def $i=0}{def $num_objects=count($children)}{def $numpg=1}
					{foreach $children as $key => $child }
					{if $i|eq(0)} {def $tmp_first_diap=$child.node_id} {/if}{set $i=inc($i)}
					diaporama_item_{$child.node_id}:{literal}{{/literal}
						path:'{if is_set($lightbox)}{$child.data_map.image.content.zoomdiaporama.url|ezroot(no)}{elseif is_set($includemode)}{$child.data_map.image.content.includediaporama.url|ezroot(no)}{else}{$child.data_map.image.content.largediaporama.url|ezroot(no)}{/if}',
						title:'{$child.data_map.titre.content|addslashes}',
						alt:'{$child.data_map.image.content.alternative_text|addslashes}',
						legend:'{$child.data_map.legende.content.output.output_text|explode("\n")|implode("")|explode("/layout/set/lightbox/")|implode("/")|addslashes}',
						copyright:'{if $child.data_map.copyright.has_content}&#169; {$child.data_map.copyright.content}{elseif $node.data_map.copyright.has_content}&#169; {$node.data_map.copyright.content|addslashes}{/if}',
						width:'{if is_set($lightbox)}{$child.data_map.image.content.zoomdiaporama.width}{elseif is_set($includemode)}{$child.data_map.image.content.includediaporama.width}{else}{$child.data_map.image.content.largediaporama.width}{/if}',
						height:'{if is_set($lightbox)}{$child.data_map.image.content.zoomdiaporama.height}{elseif is_set($includemode)}{$child.data_map.image.content.includediaporama.height}{else}{$child.data_map.image.content.largediaporama.height}{/if}',
						next:'{if is_object($children[inc($key)])}{concat('diaporama_item_',$children[inc($key)].node_id)}{else}{concat('diaporama_item_',$children[0].node_id)}{/if}',
						previous:'{if is_object($children[dec($key)])}{concat('diaporama_item_',$children[dec($key)].node_id)}{else}{concat('diaporama_item_',$children[dec($num_objects)].node_id)}{/if}',
						numpage:'{$numpg}'
					{literal}}{/literal}{if $i|mod($numitemsperpage)|eq(0)}{set $numpg=inc($numpg)}{/if}{delimiter},{/delimiter}{continue}
					{/foreach}{literal}
				};
				{/literal}
				
				{if and(eq($node.data_map.carroussel_vignette_cb.value,1),is_unset($lightbox))}
				{literal}
				$('#diaporama_carousel{/literal}{if is_set($includemode)}_inc{/if}{literal}').slideMajes({'diaporamaItems':diaporamaItems,'currentId': '{/literal}{if is_unset($nodeid)}{concat('diaporama_item_',$tmp_first_diap)}{else}{$nodeid}{/if}{literal}', 'numElementDisplayed':'{/literal}{$numitemsperpage}{literal}'});{/literal}	
				{/if}{literal}

				$('#diaporama{/literal}{if is_set($lightbox)}_lb{/if}{if is_set($includemode)}_inc{/if}{literal}').diaporamaMajes({
					'dom':'diaporama{/literal}{if is_set($lightbox)}_lb{/if}{literal}', 
					'currentId': '{/literal}{if is_unset($nodeid)}{concat('diaporama_item_',$tmp_first_diap)}{else}{$nodeid}{/if}{literal}', 
					'diaporamaItems':diaporamaItems,
					'timePlay':'{/literal}{mul($node.data_map.transition.class_content.options[$node.data_map.transition.value[0]].name,1000)}{literal}',
					'path':'/extension/bouygues/design/bouygues_intranet/images/btns/',
					'url_zoom':'/layout/set/lightbox/{/literal}{$node.url_alias}{literal}/(lightbox)/1/',
					'carousel':'diaporama_carousel{/literal}{if is_set($includemode)}_inc{/if}{literal}'
				});



		});



		</script>
		{/literal}

		
		{undef $children}
		{undef $num_objects}
		{undef $tmp_first_diap}
		{undef $i}
</div>
	
{if and(is_unset($lightbox),is_unset($includemode))}
<div class="user colorDefault1">
	
	<em>{attribute_view_gui attribute=$node.data_map.author}</em>{if and($node.data_map.author.has_content,$node.data_map.date_pub_cb.value|eq(1))} - {/if}{if $node.data_map.date_pub_cb.value|eq(1)}{"published"|i18n("design/bouygues/dossier")} {$node.data_map.date_pub.data_int|datetime( 'custom', '%d/%m/%Y' )}{/if}

</div>
{/if}

<div class="plus">		
	{if and($node.data_map.enable_comments.value|eq(1),is_unset($includemode),is_unset($lightbox))}
		{include uri="design:blocs/comments.tpl"}
	{/if}
</div>
