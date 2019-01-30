{def $object = '' $countPrintPage=0}

{foreach $ids as $key=>$id}
		{def $stringTitle = ''}{def $parentNode = ''}{def $count = 0}
		{if $id|eq('annuaire')}
			
			{def $balBegin='' $baEnd=''}
			{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}
			{def $classCss = 'default'}
			{set $balBegin = concat('color2-',$classCss)}
			{set $stringTitle = concat($stringTitle, '<span class="', $balBegin, '">', "header_menu_contactgroup"|i18n("design/bouygues/accessibility"), '</span>')}
			{def $keyvalue=$params[$key]}
	
		{else}
			
			{set $object=fetch( 'content', 'object', hash( 'object_id', $id ) )}

			{def $arrp = $object.assigned_nodes.0.url_alias|explode( '/' )}{def $stringTitle = ''}{def $parentNode = ''}{def $count = 0}{def $parentPath = ''}
			{def $balBegin='' $baEnd=''}
			{foreach $arrp as $p}

				{if $parentPath|eq('')|not()}{set $p = concat($parentPath,'/',$p)}{/if}
				{set $parentPath = $p}
				{set $parentNode=fetch( 'content', 'node', hash( 'node_path', $p ) )}

				{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}
				{if is_set($arrCssSubStructure[$object.section_id])}{def $classCss = $arrCssSubStructure[$object.section_id]}
				{else}{def $classCss = 'default'}{/if}

				{if eq(count($arrp), inc($count))}
					{set $balBegin = concat('color2-',$classCss)}
					{set $balEnd = ''}
				{/if}

				{if $parentNode}
					{if gt($count,0)}{set $stringTitle = concat($stringTitle, ' / ', '<span class="', $balBegin, '">', $parentNode.name, '</span>')}
					{else}{set $stringTitle = concat($stringTitle, '<span class="', $balBegin, '">', $parentNode.name, '</span>')}{/if}
				{/if}
				{set $count = inc($count)}
			{/foreach}
			
		{/if}
	
		<div class="printAll-container">
		<div class="{$classCss}">
			<div class="breadcrumbs-print"><img src="{concat('images/breadcrumb/',$classCss,'/start.gif')|ezdesign(no)}"/> {$stringTitle}</div>
			{if $id|eq('annuaire')}
			
				{def $paramsArray=$params[$key]|explode('!!') $search=1 $enlarge=0 $nbresult=20 $userNom='' $userPrenom='' $userInitiales='' $userEntreprise=''}
		
				{foreach $paramsArray as $paramKeyValue}
					{def $paramKeyValueArray=$paramKeyValue|explode('/')}
					{if $paramKeyValueArray[0]|eq('userPrenom')}
						{set $userPrenom=$paramKeyValueArray[1]}
					{elseif $paramKeyValueArray[0]|eq('userNom')}	
						{set $userNom=$paramKeyValueArray[1]}
					{elseif $paramKeyValueArray[0]|eq('userInitiales')}	
						{set $userInitiales=$paramKeyValueArray[1]}
					{elseif $paramKeyValueArray[0]|eq('nbresult')}	
						{set $nbresult=$paramKeyValueArray[1]}	
					{elseif $paramKeyValueArray[0]|eq('enlarge')}	
						{set $enlarge=$paramKeyValueArray[1]}
					{elseif $paramKeyValueArray[0]|eq('search')}	
						{set $search=$paramKeyValueArray[1]}
					{elseif $paramKeyValueArray[0]|eq('userEntreprise')}	
						{set $userEntreprise=$paramKeyValueArray[1]}						
					{/if}
					{undef $paramKeyValueArray}
				{/foreach}
				{def $stringParam=concat('search=',$search,
											'&enlarge=',$enlarge,
											'&nbresult=',$nbresult,
											'&userNom=',$userNom,
											'&userPrenom=',$userPrenom,
											'&userInitiales=',$userInitiales,
											'&userEntreprise=',$userEntreprise)}
											
				{*include uri="design:tools/annuaire.tpl"*}
				<div id="annuairePrintAjax{$countPrintPage}"></div>
				
				{literal}
				<script type="text/javascript">

					$().ready(function(){
						$.ajax({
							
							url:currentLang+'/layout/set/ajax2/annuaire?{/literal}{$stringParam}{literal}',
							type:'GET',
							async:false,
							success: function(data){
								$('#annuairePrintAjax{/literal}{$countPrintPage}{literal}').html(data);
								$('.results .item').addClass('on');
							}
							
						});
					});
				</script>
				{/literal}
				{set $countPrintPage=$countPrintPage|inc()}
				{undef $stringParam}
			{else}			
				{node_view_gui content_node=$object.assigned_nodes.0 view="full" keyvalue=$params[$key]}
			{/if}
			
			
		</div>
		</div>

	<div class="separator"><img src={"/boxes/print/separator.gif"|ezimage} /></div>
	{undef $arrp $parentNode $stringTitle $classCss $balBegin $balEnd $printLink $deleteLink}
{/foreach}
{undef $object}
