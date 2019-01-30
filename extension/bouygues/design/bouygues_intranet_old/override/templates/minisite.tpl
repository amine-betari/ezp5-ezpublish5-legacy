{def $paramsArray=$keyvalue|explode('§')}
{foreach $paramsArray as $paramKeyValue}	
	{def $paramKeyValueArray=$paramKeyValue|explode('/')}

	{if $paramKeyValueArray[0]|eq('subFileId')}
		{def $subFileIdPrint=$paramKeyValueArray[1]}
	{elseif $paramKeyValueArray[0]|eq('parentId')}
		{def $parentIdPrint=$paramKeyValueArray[1]}
	{elseif $paramKeyValueArray[0]|eq('folderId')}
		{def $folderIdPrint=$paramKeyValueArray[1]}
	{/if}
	{undef $paramKeyValueArray}
{/foreach}

<div class="default minisite">
	{if and(is_unset($lightbox), is_unset($include_mode),is_unset($parent))}
			{include uri="design:blocs/tools.tpl"}
	{/if}
	{if $node.data_map.short_title.has_content}
		<strong class="title">{$node.data_map.short_title.content}</strong>
	{/if}
	 <h1><a href="{$node.url_alias|ezurl(no)}" class="color1">{$node.data_map.titre.content|wash()}</a></h1>
	 {def $datas = fetch('content','list',hash( 'parent_node_id', $node.node_id,
																  'class_filter_type','include',
																  'class_filter_array',array('article','bouygues_diapo','bouygues_galerie_vid','bouygues_video','bouygues_dossier'),
																  'limit', 6,
																  'sort_by', array( array( 'priority' ) ) ))}
	{def $url_pagination=$node.url_alias}
	
	{if $node.data_map.image_header.has_content}			
	<div class="header_pic">
		<a href="{$node.url_alias|ezurl(no)}"  title="retour à l'accueil">
		<img src="{$node.data_map.image_header.content.minisiteheader.url|ezroot(no)}" title="{$note.data_map.titre.content}" alt="retour à l'accueil" border="0"/>
		</a>
	</div>
	{/if}													  
	<div class="mMenu {if $datas|count|eq(5)}mMenu4{elseif $datas|count|eq(4)}mMenu3{elseif $datas|count|eq(3)}mMenu2{/if}">
		<ul>	
			{def $data_count = 0}
			{foreach $datas as $data}{* NIV 1 : DOSSIER DU MINI SITE*}{if or(
						and($data_count|eq(0),is_unset($view_parameters.folderId), is_unset($folderIdPrint)),
						$view_parameters.folderId|eq($data.node_id),
						$folderIdPrint|eq($data.node_id)
				)}{if $data_count|eq(1)}
						<li><a class="on-first">{$data.name|shorten(35,'...')}</a></li>
					{elseif $data_count|eq($datas|count|sub(1))}
						<li><a class="on-last">{$data.name|shorten(35,'...')}</a></li>
					{elseif $data_count|gt(0)}
						<li><a class="on">{$data.name|shorten(35,'...')}</a></li>
					{/if}{def $folderId=$data.node_id}{def $currentFolderNumber = $data_count}
				{else}{if $data_count|gt(0)}
					<li><a href="{concat($url_pagination|ezurl(no),'/(folderId)/',$data.node_id)}" class="{if $data_count|eq(1)}off-first{elseif $data_count|eq($datas|count|sub(1))}off-last{/if}">{$data.name|shorten(35,'...')}</a></li>{/if}
				{/if}
				{if or(
						$data.node_id|eq($view_parameters.folderId),
						and($data_count|eq(0),is_unset($view_parameters.folderId),  is_unset($folderIdPrint)),
						$folderIdPrint|eq($data.node_id)
					)}{def $prevOffset=$datas[$data_count|sub(1)].node_id}{if $prevOffset}{def $prevOffsetURL=concat($url_pagination|ezurl(no),'/(folderId)/',$datas[$data_count|sub(1)].node_id)}{/if}{def $nextOffset=$datas[$data_count|inc(1)].node_id}{if $nextOffset}{def $nextOffsetURL=concat($url_pagination|ezurl(no),'/(folderId)/',$datas[$data_count|inc(1)].node_id)}{/if}{/if}{set $data_count = inc($data_count)}{/foreach}{undef $data_count}
		</ul>
	</div>
		{def $data_count = 0}
						
						{def $sub_datas = fetch('content','list',hash( 'parent_node_id', $folderId,
																  'class_filter_type','include',
																  'class_filter_array',array('article','bouygues_dossier'),
																  'sort_by', array( array( 'priority' ) )
																  ))}
	<div class="file">

			<div class="content1">
				<div class="{if $sub_datas|count()|gt(0)}top{else}top2{/if}">&nbsp;</div>
	{if $sub_datas|count()|gt(0)}
	
					<div class="middle">
					<div class="bottom">
							<ul>
							
							{foreach $sub_datas as $sub_data}	
								{if $sub_data.parent.data_map.tpl_select.content.0|eq(0)}
									{if $data_count|eq(0)}
										{def $subFileId = $sub_data.node_id}
									{/if}	
								{/if}{if $sub_data.parent.data_map.tpl_select.content.0|eq(0)}{if or($sub_data.node_id|eq($view_parameters.parentId),
											$sub_data.node_id|eq($parentIdPrint),
											$sub_data.node_id|eq($view_parameters.subFileId),
											$sub_data.node_id|eq($subFileIdPrint),
											and($data_count|eq(0),is_unset($view_parameters.subFileId), is_unset($subFileIdPrint)))}{def $prevOffset=$sub_datas[$data_count|sub(1)].node_id}{if $prevOffset}
											{def $prevOffsetURL=concat($url_pagination|ezurl(no),'/(folderId)/',$folderId,'/(subFileId)/',$sub_datas[$data_count|sub(1)].node_id)}
										{/if}{def $nextOffset=$sub_datas[$data_count|inc(1)].node_id}
										{if $nextOffset}
											{def $nextOffsetURL=concat($url_pagination|ezurl(no),'/(folderId)/',$folderId,'/(subFileId)/',$sub_datas[$data_count|inc(1)].node_id)}
										{/if}{/if}{/if}
									<li>
										<a href="{if $sub_data.parent.data_map.tpl_select.content.0|eq(1)}#v_{$sub_data.node_id}{else}{concat($url_pagination|ezurl(no),'/(folderId)/',$folderId,'/(subFileId)/',$sub_data.node_id)}{/if}" class="{if or($sub_data.node_id|eq($view_parameters.parentId),$sub_data.node_id|eq($view_parameters.subFileId),and($data_count|eq(0),is_unset($view_parameters.subFileId)))}on{else}off{/if}" title="{$sub_data.name}">
											{$sub_data.name}
										</a>{* Niveau du dossier : *}{def $sub_sub_datas = fetch('content','list',hash( 'parent_node_id', $sub_data.node_id,
																  'class_filter_type','include',
																  'class_filter_array',array('article','bouygues_diapo','bouygues_galerie_vid','bouygues_video'),
																  'sort_by', array( array( 'priority' ) )
																  ))}					  
											<ul>{if $sub_sub_datas|count|gt(0)}{if or(
														and($sub_data.class_identifier|eq('bouygues_dossier'), 
															or(is_set($view_parameters.folderId), is_set($folderIdPrint)), 
															$data_count|eq(0),
															and(is_unset($view_parameters.subFileId), is_unset($subFileIdPrint)),
															and(is_unset($view_parameters.parentId), is_unset($parentIdPrint))),
													   
														and($sub_data.class_identifier|eq('bouygues_dossier'),
															or($sub_data.node_id|eq($view_parameters.subFileId), $sub_data.node_id|eq($subFileIdPrint))),
													   
														and($sub_data.class_identifier|eq('bouygues_dossier'),
															or($sub_data.node_id|eq($view_parameters.parentId), $sub_data.node_id|eq($parentIdPrint)))
												)}{if $sub_data.parent.data_map.tpl_select.content.0|eq(0)}
														{if $sub_data.data_map.tpl_select.content.0|eq(1)}
															{def $subFileId2 = $sub_data.node_id}
														{else}
															{def $subFileId2 = $sub_sub_datas[0].node_id}
														{/if}
													{/if}{def $data_count_sub = 0}
														{foreach $sub_sub_datas as $sub_sub_data}{if or(
																	$data_count_sub|eq(0),
																	or($sub_sub_data.node_id|eq($view_parameters.subFileId), $sub_sub_data.node_id|eq($subFileIdPrint))
															)}{def $prevOffset=$sub_sub_datas[$data_count_sub|sub(1)].node_id}{if $prevOffset}{def $prevOffsetURL=concat($url_pagination|ezurl(no),'/(folderId)/',$folderId,'/(subFileId)/',$sub_sub_datas[$data_count_sub|sub(1)].node_id,'/(parentId)/',$sub_data.node_id)}{elseif $sub_datas[$data_count|sub(1)].node_id}{def $prevOffsetURL=concat($url_pagination|ezurl(no),'/(folderId)/',$folderId,'/(subFileId)/',$sub_datas[$data_count|sub(1)].node_id)}{else}{def $prevOffsetURL=concat($url_pagination|ezurl(no),'/(folderId)/',$datas[$currentFolderNumber|sub(1)].node_id)}{/if}{def $nextOffset=$sub_sub_datas[$data_count_sub|inc(1)].node_id}{if $subFileId2|eq($sub_data.node_id)|not()}{if $nextOffset}{def $nextOffsetURL=concat($url_pagination|ezurl(no),'/(folderId)/',$folderId,'/(subFileId)/',$sub_sub_datas[$data_count_sub|inc(1)].node_id,'/(parentId)/',$sub_data.node_id)}{elseif $sub_datas[$data_count|inc(1)].node_id}{def $nextOffsetURL=concat($url_pagination|ezurl(no),'/(folderId)/',$folderId,'/(subFileId)/',$sub_datas[$data_count|inc(1)].node_id)}{else}{def $nextOffsetURL=concat($url_pagination|ezurl(no),'/(folderId)/',$datas[$currentFolderNumber|inc(1)].node_id)}{/if}{/if}{/if}
														<li>
															<a href="{if $sub_data.data_map.tpl_select.content.0|eq(1)}#v_{$sub_sub_data.node_id}{else}{concat($url_pagination|ezurl(no),'/(folderId)/',$folderId,'/(subFileId)/',$sub_sub_data.node_id,'/(parentId)/',$sub_data.node_id)}{/if}" class="{if or(or($sub_sub_data.node_id|eq($view_parameters.subFileId),$sub_sub_data.node_id|eq($subFileIdPrint)),and($subFileId2|eq($sub_sub_data.node_id),is_unset($view_parameters.parentId),is_unset($parentIdPrint)))}on{else}off{/if}" title="{$sub_sub_data.name}">
																{$sub_sub_data.name}
															</a>
														</li>{set $data_count_sub = inc($data_count_sub)}{/foreach}{undef $data_count_sub}{/if}{/if}					
											</ul>				
									</li>
							{set $data_count = inc($data_count)}
							{/foreach}
							{undef $data_count}
							{undef $datas}
						</ul>
				</div>
			</div>
		{/if}
		</div>
		</div>
		{undef $datas}		
		{* PARAMS *}
		{if is_unset($view_parameters.folderId)|not}
			{set $folderId = $view_parameters.folderId}
		{elseif is_unset($folderIdPrint)|not}
			{set $folderId = $folderIdPrint}
		{/if}
		
		{if and(is_set($subFileId2),is_unset($view_parameters.parentId),is_unset($parentIdPrint))}
			{set $subFileId=$subFileId2}
		{elseif  is_set($view_parameters.subFileId)}
			{set $subFileId=$view_parameters.subFileId}
		{elseif  is_set($subFileIdPrint)}
			{set $subFileId=$subFileIdPrint}
		{/if}
			
		{def $my_node_folder=fetch( 'content', 'node', hash( 'node_id', $folderId)  )}
		
		{if is_set($subFileId)}
			{def $my_node=fetch( 'content', 'node', hash( 'node_id',$subFileId)  )}
		{else}
			{def $my_node=$my_node_folder}
		{/if}
		
		{if $my_node.class_identifier|eq('article')}
			{def $view='article'}
		{elseif $my_node.class_identifier|eq('bouygues_diapo')}	
			{def $view='diaporama'}
		{elseif $my_node.class_identifier|eq('bouygues_galerie_vid')}	
			{def $view='video'}
		{elseif $my_node.class_identifier|eq('bouygues_video')}	
			{def $view='video'}
		{elseif $my_node.class_identifier|eq('bouygues_dossier')}	
			{def $view='dossier'}
		{/if}
		
		{*$node|attribute(show,1)*}
		
		{if $my_node_folder.priority|eq(0)}
			{def $firstpage=1}
		{else}
			{def $firstpage=0}
		{/if}
		
		{node_view_gui 
			idminisite=$node.node_id 
			firstpage=$firstpage 
			content_node=$my_node 
			view=$view 
			parent=1 
			include_mode=1
			url_pagination=$url_pagination 
			view_parameters=$view_parameters}
</div>

		{*pagination*}
		
		<div class="pagenavigator">
		
			{if is_set($prevOffsetURL)}
				<a class="previous" href="{$prevOffsetURL}">
					<span class="text">{"previous"|i18n("design/bouygues/dossier")}</span>
				</a>
			{/if}
			
			{if is_set($nextOffsetURL)}
				<a class="next" href="{$nextOffsetURL}">
					<span class="text">{"next"|i18n("design/bouygues/dossier")}</span>
				</a>
			{/if}
		
		</div>