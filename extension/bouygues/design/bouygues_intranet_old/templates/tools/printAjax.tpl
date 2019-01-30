
	{if is_set($ids)}
		{def $object = '' $arrp = ''}
		{foreach $ids as $key=>$id}
			{set $object=fetch( 'content', 'object', hash( 'object_id', $id ) )}
			{if $object.section_id|eq('7')}{def $classCss = 'communication'}
			{elseif $object.section_id|eq('6')}{def $classCss = 'consolidation'}
			{elseif $object.section_id|eq('8')}{def $classCss = 'controle_interne'}
			{elseif $object.section_id|eq('9')}{def $classCss = 'developpement_durable'}
			{elseif $object.section_id|eq('10')}{def $classCss = 'europe'}
			{elseif $object.section_id|eq('11')}{def $classCss = 'finance'}
			{elseif $object.section_id|eq('15')}{def $classCss = 'imb'}
			{elseif $object.section_id|eq('12')}{def $classCss = 'informatique'}
			{elseif $object.section_id|eq('13')}{def $classCss = 'innovation'}
			{elseif $object.section_id|eq('18')}{def $classCss = 'juridique'}
            {elseif $object.section_id|eq('14')}{def $classCss = 'rh'}
			{/if}

			{def $arrp = $object.main_node.url_alias|explode( '/' )}{def $stringTitle = ''}{def $parentNode = ''}{def $count = 0}{def $parentPath = ''}
			{def $balBegin='' $baEnd=''}
			{foreach $arrp as $p}
			
				{if $parentPath|eq('')|not()}{set $p = concat($parentPath,'/',$p)}{/if}
				{set $parentPath = $p}
				{set $parentNode=fetch( 'content', 'node', hash( 'node_path', $p ) )}
				
				
				{if eq(count($arrp), inc($count))}
					{set $balBegin = concat('color2-',$classCss)}
					{set $balEnd = ''}
				{/if}
				
				{if $parentNode}
					{if gt($count,0)}{set $stringTitle = concat($stringTitle, ' > ', '<span class="', $balBegin, '">', $parentNode.name, '</span>')}
					{else}{set $stringTitle = concat($stringTitle, '<span class="', $balBegin, '">', $parentNode.name, '</span>')}{/if}
				{/if}
				{set $count = inc($count)}
			{/foreach}
		
			{def $printLink = concat('/',$object.main_node.url_alias,'/', $params[$key],'/(print)/1')}
			{def $deleteLink = concat('javascript:eby.printBagDelete(\'',$id,'\',\'',$params[$key],'\')')}
			<div class="print-item">
				<span class="page-title">
					<img src="{concat('images/pictos/puce',$object.section_id,'.gif')|ezdesign(no)}"/> {$stringTitle}
				</span></span>
				<span class="print-button">
					{include uri="design:blocs/btn.tpl" label="delete"|i18n("design/bouygues/print") url=$deleteLink align='right'}
					{include uri="design:blocs/btn.tpl" label="print"|i18n("design/bouygues/print") url=concat($langCurrent,'/imprimer/?pageId=',$id,'&param=',$params[$key]) align='right' target='_blank'}
				</span>
			</div>
			
			{undef $arrp $parentNode $stringTitle $classCss $balBegin $balEnd $printLink $deleteLink}
		{/foreach}
		{undef $object}
	{/if}