<div class="default">
	<h1>{"print_basket"|i18n("design/bouygues/print")}</h1>
	{if is_set($action)}<h2>{"page_added"|i18n("design/bouygues/print")}</h2>
	{include uri="design:blocs/btn.tpl" label="print_now"|i18n("design/bouygues/print") url=concat($langCurrent,'/imprimer/?pageId=',$idCurrent, '&param=', $paramCurrent) align='left' target='_blank'}{/if}
	
	{if count($ids)|gt(0)}
	<h2>{"contents_added"|i18n("design/bouygues/print")}</h2>
	{else}<h2>{"empty_basket"|i18n("design/bouygues/print")}</h2>
	{/if}
	{if is_set($ids)}	
	<div class="print-bag-list">
		{def $object = '' $arrp = ''}{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}
		{foreach $ids as $key=>$id}
			{def $id_section=7 $id_section_string=''}
			{def $balBegin='' $baEnd=''}
			{if $id|eq('annuaire')}
				{def $classCss = 'communication'}{def $stringTitle = ''}
				{set $balBegin = concat('color4-',$classCss)}
				{set $stringTitle = concat($stringTitle, '<span class="', $balBegin, '">', "header_menu_contactgroup"|i18n("design/bouygues/accessibility"), '</span>')}
				{set $id_section=7}
				{set $id_section_string='communication'}
				
				{def $printLink = concat('/','annuaire','/', $params[$key],'/(print)/1')}
				{def $deleteLink = concat('javascript:eby.printBagDelete(\'',$id,'\',\'',$params[$key],'\')')}
				
			{else}
				{set $object=fetch( 'content', 'object', hash( 'object_id', $id ) )}
				{set $id_section=$object.section_id}
				{set $id_section_string=$arrCssSubStructure[$object.section_id]}
				{if is_set($arrCssSubStructure[$id_section])}{def $classCss = $arrCssSubStructure[$object.section_id]}
				{else}{def $classCss = 'default'}{/if}
            	
				{def $arrp = $object.assigned_nodes.0.url_alias|explode( '/' )}{def $stringTitle = ''}{def $parentNode = ''}{def $count = 0}{def $parentPath = ''}
				{foreach $arrp as $p}
				
					{if $parentPath|eq('')|not()}{set $p = concat($parentPath,'/',$p)}{/if}
					{set $parentPath = $p}
					{set $parentNode=fetch( 'content', 'node', hash( 'node_path', $p ) )}
					
					
					{if eq(count($arrp), inc($count))}
						{set $balBegin = concat('color4-',$classCss)}
						{set $balEnd = ''}
					{/if}
					
					{if $parentNode}
						{if gt($count,0)}{set $stringTitle = concat($stringTitle, ' / ', '<span class="', $balBegin, '">', $parentNode.name, '</span>')}
						{else}{set $stringTitle = concat($stringTitle, '<span class="', $balBegin, '">', $parentNode.name, '</span>')}{/if}
					{/if}
					{set $count = inc($count)}
				{/foreach}
		    	
				{def $printLink = concat('/',$object.main_node.url_alias,'/', $params[$key],'/(print)/1')}
				{def $deleteLink = concat('javascript:eby.printBagDelete(\'',$id,'\',\'',$params[$key],'\')')}
			{/if}
			<div class="print-item" id="print-item-{$id}">
				<span class="page-title">
					{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}
					<img src="{concat('images/breadcrumb/',$id_section_string,'/start.gif')|ezdesign(no)}"/> {$stringTitle}
				</span>
				<span class="print-button">
					{include uri="design:blocs/btn.tpl" label="delete"|i18n("design/bouygues/print") url=$deleteLink align='right'}
					{include uri="design:blocs/btn.tpl" label="print"|i18n("design/bouygues/print") url=concat($langCurrent,'/imprimer/?pageId=',$id,'&param=',$params[$key]) align='right' target='_blank'}
				</span>
			</div>
			
			{undef $arrp $parentNode $stringTitle $classCss $balBegin $balEnd $printLink $deleteLink $stringTitle $id_section $id_section_string}
		{/foreach}
		{undef $object}
	</div>
	
	<div class="print-button print-bottom">
		{include uri="design:blocs/btn.tpl" label="delete_all"|i18n("design/bouygues/print") url='javascript:eby.printBagDelete()' align='right' }
		{include uri="design:blocs/btn.tpl" label="print_all"|i18n("design/bouygues/print") url=concat($langCurrent,'/imprimer') align='right' target='_blank'}
	</div>
	{/if}
</div>
