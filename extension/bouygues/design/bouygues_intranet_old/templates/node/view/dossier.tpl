<div class="default file">
	{def $paramsArray=$params|explode('§')}
	{foreach $paramsArray as $paramKeyValue}{def $paramKeyValueArray=$paramKeyValue|explode('/')}{if $paramKeyValueArray[0] == 'subFileId'}{def $subFileId=$paramKeyValueArray[1]}{/if}{/foreach}{if and(is_unset($lightbox), is_unset($include_mode),is_unset($parent))}{include uri="design:blocs/tools.tpl"}{/if}
	<a name="top_{$node.node_id}">&nbsp;</a>
	{if is_unset($parent)}
		<div class="content1">
				<div class="middle">
				<div class="top"></div>
				<div class="bottom">
					{if is_unset($parent)}
						<div class="dossIe6"><h1>{$node.data_map.titre.content|wash()}</h1></div>
					{/if}{if is_unset($url_pagination)}{def $url_pagination = $node.url_alias}{else}{def $url_pagination = concat( $url_pagination,"/(folderId)/", $node.node_id )}{/if}
					{if is_unset($subFileId)}{def $subFileId=''}{/if}{def
						$datas = fetch( 'content', 'list', hash( 
							'parent_node_id', $node.node_id,
							'class_filter_type','include',
							'class_filter_array', array(
								'article',
								'bouygues_diapo',
								'bouygues_galerie_vid',
								'bouygues_video'
							),
							'sort_by', array( array( 'priority' ) )
							))
						$articleCount=$datas|count()
					}{if $node.data_map.tpl_select.content.0|eq(0)}
						<ul>{def $data_count = 0}
							{foreach $datas as $data}{if or(
										and($data_count|eq(0), 
											is_unset($view_parameters.subFileId), 
											$subFileId|eq('')), 
										
										$data.node_id|eq($view_parameters.subFileId), 
										
										$data.node_id|eq($subFileId))}{def $currentOffset = $data_count}
									<li><a class="on" title="{$data.name}">{$data.name}</a>{def $prevOffset=$datas[$data_count|sub(1)].node_id}{def $nextOffset=$datas[$data_count|inc(1)].node_id}
								{else}
									<li><a href="{concat($url_pagination|ezurl(no),'/(subFileId)/',$data.node_id)}" class="off" title="{$data.name}">{$data.name}</a>{/if}
								{if and($data_count|eq(0), $subFileId|eq(''))}{set $subFileId = $data.node_id}{/if}
								{* mini site*}
								{if is_set($parent)}{def $sub_datas = fetch('content','list',hash( 'parent_node_id', $data.node_id,
																  'class_filter_type','include',
																  'class_filter_array',array('article','bouygues_diapo','bouygues_galerie_vid','bouygues_video'),
																  'sort_by', array( array( 'priority' ) )
																  ))}{if $sub_datas|count()|gt(0)}
										<ul>{foreach $sub_datas as $sub_data}
												<li>
													<a href="{concat($url_pagination|ezurl(no),'/(subFileId)/',$sub_data.node_id)}" class="{if $sub_data.node_id|eq($view_parameters.subFileId)}on{else}off{/if}" title="{$sub_data.name}">
														{$sub_data.name}
													</a>
												</li>{/foreach}
										</ul>{/if}{/if}{set $data_count = inc($data_count)}		
								</li>{/foreach}{undef $data_count}
						</ul>{elseif $node.data_map.tpl_select.content.0|eq(1)}
						<ul>{foreach $datas as $data}
								<li><a href="#v_{$data.node_id}" class="off" title="{$data.name}">{$data.name}</a>{if is_set($parent)}{def $sub_datas = fetch('content','list',hash( 'parent_node_id', $data.node_id,
																  'class_filter_type','include',
																  'class_filter_array',array('article','bouygues_diapo','bouygues_galerie_vid','bouygues_video'),
																  'sort_by', array( array( 'priority' ) )
																  ))}{if $sub_datas|count()|gt(0)}
										<ul>{foreach $sub_datas as $sub_data}
												<li><a href="#v_{$sub_data.node_id}" class="off" title="{$sub_data.name}">{$sub_data.name}</a></li>{/foreach}
										</ul>{/if}{/if}
								</li>{/foreach}
						</ul>{/if}{undef $datas}
			</div>
		</div>
		
	</div>
	{/if}{if $node.data_map.chapeau.has_content}
	<div class="content2">
		<div class="intro">
			{$node.data_map.chapeau.content.output.output_text}
		</div>
	</div>
	{/if}
	<div class="content3">{def $numberOfObjects=1}{if is_set($view_parameters.subFileId)}{set $subFileId=$view_parameters.subFileId}{/if}{if $node.data_map.tpl_select.content.0|eq(0)}{def $data = fetch('content','node',hash( 'node_id', $subFileId))}{else}{def $datas = fetch('content','list',hash( 'parent_node_id', $node.node_id,
															  'class_filter_type','include',
															  'class_filter_array',array('article','bouygues_diapo','bouygues_galerie_vid','bouygues_video','bouygues_dossier'),
															  'sort_by', array( array( 'priority' ) )
															  ))}{/if}{def $data_count = 0}{if $node.data_map.tpl_select.content.0|eq(1)}
			{foreach $datas as $data}
			<div class="file-item {if $data_count|gt(0)}others{/if}" {if $node.data_map.tpl_select.content.0|eq(1)}id="v_{$data.node_id}"{/if}>
			{if $node.data_map.tpl_select.content.0|eq(1)}
				<a name="v_{$data.node_id}">&nbsp;</a>
			{/if}
			{if $data.class_identifier|eq('article')}
				{node_view_gui content_node=$data view="article" parent=1}
			{elseif $data.class_identifier|eq('bouygues_dossier')}
				{node_view_gui content_node=$data view="dossier" parent=1}
			{elseif $data.class_identifier|eq('bouygues_diapo')}
				{node_view_gui content_node=$data view="diaporama" parent=1}			
			{elseif $data.class_identifier|eq('bouygues_video')}
				{node_view_gui content_node=$data view="video" parent=1}
			{elseif eq($data.class_identifier, 'bouygues_galerie_vid')}
				{if is_set($view_parameters.nodeid)}
					{node_view_gui content_node=$data view="video" ancre=$data.node_id nodeid=$view_parameters.nodeid parent=1 currentOffset=$currentOffset}
				{else}
					{node_view_gui content_node=$data view="video" ancre=$data.node_id parent=1 currentOffset=$subFileId}
				{/if}
			{/if}
			{if and(is_unset($include_mode),$node.data_map.tpl_select.content.0|eq(1))}
			<a href="#top_{$node.node_id}" class="btn-top-page" tile="">{"top"|i18n("design/bouygues/dossier")}</a>
			{/if}
			</div>
		{set $data_count=$data_count|inc()}
			{/foreach}
		{else}
		
			{if $data.class_identifier|eq('article')}
				{node_view_gui content_node=$data view="article" parent=1}
			{elseif $data.class_identifier|eq('bouygues_diapo')}
				{node_view_gui content_node=$data view="diaporama" parent=1}			
			{elseif $data.class_identifier|eq('bouygues_video')}
				{node_view_gui content_node=$data view="video" parent=1}
			{elseif eq($data.class_identifier, 'bouygues_galerie_vid')}
				{if is_set($view_parameters.nodeid)}
					{node_view_gui content_node=$data view="video" ancre=$data.node_id nodeid=$view_parameters.nodeid parent=1 currentOffset=$subFileId}
				{else}
					{node_view_gui content_node=$data view="video" ancre=$data.node_id parent=1 currentOffset=$subFileId}
				{/if}
			{/if}	
			
		{/if}
		{undef $data_count}
	</div>
</div>
	{*pagination*}
	{if and($node.data_map.tpl_select.content.0|eq(0),is_unset($parent))}
		<div class="pagenavigator">
			{if is_set($prevOffset)}
				<a class="previous" href="{concat($url_pagination|ezurl(no),'/(subFileId)/',$prevOffset)}">
					<span class="text">{"previous"|i18n("design/bouygues/dossier")}</span>
				</a>
			{/if}
			
			{if is_set($nextOffset)}
				<a class="next" href="{concat($url_pagination|ezurl(no),'/(subFileId)/',$nextOffset)}">
					<span class="text">{"next"|i18n("design/bouygues/dossier")}</span>
				</a>
			{/if}
		</div>
	{/if}
	<div class="plus">		
		{if and($node.data_map.enable_comments.value|eq(1),is_unset($include_mode),is_unset($parent))}
			{include uri="design:blocs/comments.tpl"}
		{/if}
	</div>