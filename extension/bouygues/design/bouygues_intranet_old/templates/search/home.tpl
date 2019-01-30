{set-block scope=global variable=cache_ttl}0{/set-block}
{def $count=fetch( 'content', 'tree_count', hash( 'parent_node_id', 2 , 'depth', 10, 'class_filter_type', 'include', 'class_filter_array', 
			array('article',
			'bouygues_dossier',
			'bouygues_diapo',
			'bouygues_element_liste',
			'bouygues_galerie_vid',
			'bouygues_video',
			'bouygues_mini_site',
			'newsletter_issue',
			'bouygues_liste',
			'bouygues_page_sessions',
			'bouygues_liste_thema',
			'bouygues_prestataire',
			'bouygues_master_page')) )}

<link type="text/css" rel="stylesheet" href={'stylesheets/datePicker.css'|ezdesign} />
<script type="text/javascript" src={'javascript/date.js'|ezdesign}></script>
<script type="text/javascript" src={'javascript/jquery.datePicker.js'|ezdesign}></script>
<script type="text/javascript" src={'javascript/date_fr.js'|ezdesign}></script>
<div class="ezsearch">

	<div class="boxA">
		<div class="content">
			{include uri="design:blocs/tools.tpl" light=1}
			
			<div class="bloc-search">
				<form action="{'/recherche'|ezurl(no)}" method="get" id="searchForm" class="{if or(
																								and(is_set($beginDate), $beginDate|eq('')|not()), 
																								and(is_set($endDate), $endDate|eq('')|not()),
																								and(is_set($class_id), $class_id|eq('')|not()), is_set(ezhttp('adv','get')))}advanced{else}{/if}">
				<h2><img src="{concat("images/","boxes/annuaire/pictoSearch.png")|ezdesign(no)}" alt="{"search_label"|i18n("design/bouygues/search")}" /> {"search_label"|i18n("design/bouygues/search")}</h2>
				<strong class="subTitle">{$count|l10n( 'number')|substr(0,count_chars($count|l10n( 'number'))|sub(3))} {"search_content_published"|i18n("design/bouygues/search")}</strong>
				<div id="" class="searchGroup">
					<input type="hidden" name="search" value="1" />
					<input type="hidden" name="nbresult" value="10" />
					
					<input type="hidden" name="pg" value="1" />
					<input type="text" name="terms" id="" class="text required" value="{$terms|wash()}" title="{"search_terms_error"|i18n("design/bouygues/search")}"/>
					<p>
					<select name="class_id">
						<option value="">{"search_filetype"|i18n("design/bouygues/search")}</option>
						<option value="file" {if and(is_set($class_id),$class_id|eq('file'))}selected{/if}>{"search_file"|i18n("design/bouygues/search")}</option>
						<option value="diaporama" {if and(is_set($class_id),$class_id|eq('diaporama'))}selected{/if}>{"search_picture"|i18n("design/bouygues/search")}</option>
						<option value="video" {if and(is_set($class_id),$class_id|eq('video'))}selected{/if}>{"search_video"|i18n("design/bouygues/search")}</option>
					</select>
					</p>
					<p>
					<em>{"search_datebegin"|i18n("design/bouygues/search")}</em>
					<input type="text" name="beginDate" id="" class="text date isValidDate" value="{$beginDate}" title="{"search_date_error1"|i18n("design/bouygues/search")}"/>
					</p>
					<p>
					<em>{"search_dateend"|i18n("design/bouygues/search")}</em>
					<input type="text" name="endDate" id="" class="text date isValidDate" value="{$endDate}" title="{"search_date_error2"|i18n("design/bouygues/search")}"/>
					</p>
					<div id="searchFormError" style="display: none"><ol></ol></div>
					<a href="#" class="btn-grey-arrow-left advancedSearchButton" onclick="$('#searchForm').addClass('advanced');return false;">{"search_advanced"|i18n("design/bouygues/search")}</a>
					<a href="" onclick="$('#searchForm').submit(); return false;" class="submit-btn-go" title="{'header_search_submit'|i18n('design/bouygues/accessibility')}" ></a>
					<span class="displayNoneAccesibility"><input type="submit" title="{'header_search_submit'|i18n('design/bouygues/accessibility')}"/></span></a>
				</div>
				
				{if $results.SearchCount|eq(0)|not()}
				<div class="filiereGroup">
					<h3>{"result_filiere_label"|i18n("design/bouygues/search")}</h3>
					{def $filiere='' $classCss='' $filiereTitle='' $section_id=''}
					{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}
					{foreach $resultsFacet.SearchExtras.facet_queries as $facet}
						{if is_set($arrCssSubStructure[$facet.fieldValue])}{set $classCss = $arrCssSubStructure[$facet.fieldValue]}
						{else}{set $classCss = 'default'}{/if}
						
						{set $filiere = fetch( 'content', 'list',hash( 'parent_node_id', 2,
												'class_filter_type', 'include',
												'class_filter_array', array( 'bouygues_master_page' ),
												'attribute_filter',array(array('section','=',$facet.fieldValue))
												))}

					{if int($facet.count)|gt(0)}
					{if is_set($filiere.0)}{set $filiereTitle=$filiere.0.name}{else}{set $filiereTitle='section_default'|i18n('extension/bouygues')}{/if}
					<input type="checkbox" name="section_id[]" value="{$facet.fieldValue}" style="display: none" {if and(is_set(ezhttp('section_id', 'get')),ezhttp('section_id', 'get')|contains($facet.fieldValue))}checked{/if}/>
					<a href="#" onclick="setFiliere($('input[name=section_id[]][value={$facet.fieldValue}]')); $('#searchForm').submit(); return false;" class="btn-list{if and(is_set(ezhttp('section_id', 'get')),ezhttp('section_id', 'get')|contains($facet.fieldValue))}-on{/if}">
						<span class="left"></span>
						<span class="middle color2-{$classCss}">{if and(is_set(ezhttp('section_id', 'get')),ezhttp('section_id', 'get')|contains($facet.fieldValue))}<img src={"listes/search/checked.gif"|ezimage} border=0 />{/if} {$filiereTitle} <strong class="number">{int($facet.count)} {"found"|i18n("design/bouygues/search")}</strong></span>
						<span class="right"></span>
					</a>
					{/if}
					{/foreach}
					{if is_set(ezhttp('section_id', 'get'))}
					<a href="{concat('recherche?search=1&nbresult=10&pg=',$pg,'&terms=',$terms,'&class_id=',$class_id,'&beginDate=',$beginDate,'&endDate=',$endDate)|ezurl(no)}" class="btn-grey-arrow-left">{"result_all_result"|i18n("design/bouygues/search")}</a>
					{/if}
				</div>
				{/if}
				</form>	
			</div>
		
		
			{def $finalResult = $results.SearchResult}
			{if and(or(is_unset($pg), $pg|eq(1)),
					or(
				   		and(is_set($beginDate), $beginDate|eq('')|not()), 
				   		and(is_set($endDate), $endDate|eq('')|not()),
				   		and(is_set($class_id), $class_id|eq('')|not())
					)
			)}
				{def $limit = min( ezpreference( 'ezfind_elevate_preview_configurations' ), 3)|choose( 10, 10, 25, 50 )
				     $params = hash( 'offset', $viewParameters.offset,
				                     'limit',  $limit )
				     $paramsForCount = hash( 'countOnly', true() )}
            	
				{* Searching for elevate configurations for a given search query, alter the fetch parameters *}
				{if is_set( $viewParameters.search_query )}
            	
				    {def $searchQueryHash = hash( 'searchQuery', $viewParameters.search_query )}
				    {if is_set( $viewParameters.fuzzy_filter )}
				        {set $searchQueryHash = $searchQueryHash|merge( hash( 'fuzzy', true() ) )}
				    {/if}
            	
				    {set $params = $params|merge( hash( 'searchQuery', $searchQueryHash ) )}
				    {set $paramsForCount = $paramsForCount|merge( hash( 'searchQuery', $searchQueryHash ) )}
				{/if}
            	
				{* Searching for elevate configurations, filtering on a given languageCode, alter the fetch parameters *}
				{if is_set( $viewParameters.language )}
				    {set $params = $params|merge( hash( 'languageCode', $viewParameters.language ) )}
				    {set $paramsForCount = $paramsForCount|merge( hash( 'languageCode', $viewParameters.language ) )}
				{/if}
            	
				{def $configurations = fetch( 'ezfind', 'elevateConfiguration',  $params )}
				
				{def $elevatedObjects = hash()}{def $nodeTemp=''}
				{foreach $configurations as $elevateContent}
					{set $elevatedObjects=$elevatedObjects|insert(count($elevatedObjects),$elevateContent.main_node)}
				{/foreach}
	        	
            	
				
				{foreach $elevatedObjects as $elevatedObject}
					{set $finalResult=$finalResult|insert(0,$elevatedObject)}
				{/foreach}
				{undef $elevatedObjects}
			{/if}
			<div class="bloc-result">
				<h2>{"result_label"|i18n("design/bouygues/search")} <span class="nbresult" style="padding-left: 20px;">{$results.SearchCount|sum(count($configurations))|l10n( 'number')|substr(0,count_chars($results.SearchCount|sum(count($configurations))|l10n( 'number'))|sub(3))} {"found"|i18n("design/bouygues/search")}</span></h2>
				
				
				{if count($finalResult)|eq(0)}
					<div class="result-error">
						<strong>{"result_none_title"|i18n("design/bouygues/search")}</strong>
						<p>{"result_none_content"|i18n("design/bouygues/search")}</p>
					</div>
				{else}			

					
					{def 	$object = '' 
							$arrCssSubStructure=ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' ) 
							$classCss='' 
							$filieres='' 
							$filiere=''}
							
					
					{foreach $finalResult as $result}
						
						{set $filiere=''}
						{set $object=fetch( 'content', 'object', hash( 'object_id', $result.contentobject_id ) )}
						{set $filieres=fetch('content', 'list', hash('parent_node_id', 2, 
										'class_filter_type', 'include', 'class_filter_array', array('bouygues_master_page')
										))}
						
						
						{*
							Get the filiere corresponding to the object 
							
							*}
						{foreach $filieres as $filiereTp}
							{if $filiereTp.object.section_id|eq($result.object.section_id)}{set $filiere=$filiereTp}{/if}
						{/foreach}
				
						{*
							Get the CSS style
							
							*}
						{if is_set($arrCssSubStructure[$object.section_id])}
							{set $classCss = $arrCssSubStructure[$object.section_id]}
						{else}
							{set $classCss = 'default'}
						{/if}
			
			
						{*
							Get the final link and picto if needed
							First the link
							
							*}
									
						{def $arrp = $object.assigned_nodes.0.url_alias|explode( '/' )}
						{def $numPage=count($arrp)|dec()}
						{def $stringTitle = ''}
						{def $count = 0}
						{def $parentPath = ''
								$parentNode=''}
						
						{def $linkedNode = '' $url=''}
						
						{include uri="design:blocs/setlinkednode.tpl"}
						
						{def $isMiniSiteOrDossier=false()}
						
						
						{* Specific treatment when whoswho*}

						{if $linkedNode.class_identifier|eq('user')}

							{def $whoswhos = fetch( 'content', 'tree', hash(
										  'parent_node_id', 2,
	              						  'class_filter_type',  'include',
	              						  'class_filter_array', array( 'bouygues_whoswho_search', 'bouygues_whoswho_list'),
										  'attribute_filter', array(array( 'section', '=', $linkedNode.object.section_id)),
	              						  'depth', 10,
										  'limit', 1,
	              						  'limitation', array()
	              						  ))}
	
							{foreach $whoswhos as $whoswho}
								{set $url = concat($whoswho.url_alias, '/(userId)/', $linkedNode.object.id)|ezurl(no)}
							{/foreach}
							
							{set $arrp=$whoswho.url_alias|explode('/')}
							{set $arrp = $arrp|insert(count($arrp), $linkedNode.object.name)}
							{set $numPage=count($arrp)|dec()}
							{undef $whoswho}
						{/if}
						{foreach $arrp as $p}
							{def $pTemp=$p}					
							{if $parentPath|eq('')|not()}{set $p = concat($parentPath,'/',$p)}{/if}
							{set $parentPath = $p}
							{set $parentNode=fetch( 'content', 'node', hash( 'node_path', $p ) )}
							
							{if $parentNode}{def $urlName=$parentNode.name}{else}{def $urlName=$pTemp}{/if}
							{undef $pTemp}
							{if $isMiniSiteOrDossier|eq(false())}
								{if $parentNode.class_identifier|eq('bouygues_mini_site')}
									{set $isMiniSiteOrDossier=true()}
									{set $linkedNode=$parentNode}	
								{elseif $parentNode.class_identifier|eq('bouygues_dossier')}
									{set $isMiniSiteOrDossier=true()}
									{set $linkedNode=$parentNode}
								{/if}
								
								{def $params='' $counterParam=0}
							{else}
								
								{*MINISITE
									. folderId
									. subFileId
									. parentId *}
								{if $linkedNode.class_identifier|eq('bouygues_mini_site')}
									{if $counterParam|eq(0)}{set $params=concat($params,'/(folderId)/',$parentNode.node_id)}
									{elseif $counterParam|eq(1)}
										{if $count|eq($numPage)}
											{set $params=concat($params,'/(subFileId)/',$parentNode.node_id)}
										{else}
											{set $params=concat($params,'/(parentId)/',$parentNode.node_id)}
										{/if}
									{elseif $counterParam|eq(2)}{set $params=concat($params,'/(subFileId)/',$parentNode.node_id)}
									{/if}
								{/if}
								{*DOSSIER
									. folderId
									. subFileId *}
								{if $linkedNode.class_identifier|eq('bouygues_dossier')}
									{if $counterParam|eq(0)}{set $params=concat($params,'/(subFileId)/',$parentNode.node_id)}
									{elseif $counterParam|eq(1)}{set $params=concat($params,'/(subFileId)/',$parentNode.node_id)}
									{/if}
								{/if}
								{set $counterParam=inc($counterParam)}
							{/if}
							
							{if $count|lt($numPage)}
								{if $count|eq(0)}
									{set $stringTitle=concat($urlName)}
								{else}
									{set $stringTitle=concat($stringTitle, ' / ', $urlName)}
								{/if}
							{else}
								{def $urlTarget=''}
								{include uri="design:blocs/setlink.tpl"}
								
								{if $count|eq(0)}
								
									{if $url|eq('')|not()}
										{set $stringTitle=concat('<a href="', 
															$url , $params, 
															'"><span class="color3-',
															$classCss,
															'" target="', $urlTarget,'">' , 
															$urlName,
															'</span></a>' )}
									{else}
									
										{set $stringTitle=concat('<span class="color3-',
														$classCss,
														'" target="', $urlTarget,'">' , 
														$urlName,
														'</span>' )}
									{/if}
								{else}
									{if $url|eq('')|not()}
										{set $stringTitle=concat($stringTitle, 
															' / <a href="', 
															$url , $params, '" target="', $urlTarget,'">', 
															$urlName,
															'</a>' )}
									{else}
										{set $stringTitle=concat($stringTitle, ' / ', 
															$urlName)}
									{/if}
								{/if}
								
							{/if}
							{set $count=inc($count)}
							{undef $urlName}
						{/foreach}
						{undef $isMiniSiteOrDossier}

						{* Get the picto *}

						{if $linkedNode.class_identifier|eq('file')}
						
							{if eq($linkedNode.data_map.file.content.original_filename|extract_right(4)|downcase(), 'pptx')}
								{def $pictoType='ppt'}
							
							{elseif eq($linkedNode.data_map.file.content.original_filename|extract_right( 4 )|downcase(), 'xlsx')}
								{def $pictoType='xls'}	
							
							{elseif eq($linkedNode.data_map.file.content.original_filename|extract_right(4)|downcase(), 'docx')}
								{def $pictoType='doc'}
							
							{elseif and(or(eq($linkedNode.data_map.file.content.original_filename|extract_right( 3 )|downcase(), 'doc'),
								eq($linkedNode.data_map.file.content.original_filename|extract_right( 3 )|downcase(), 'ppt'),
								eq($linkedNode.data_map.file.content.original_filename|extract_right( 3 )|downcase(), 'xls'),
								eq($linkedNode.data_map.file.content.original_filename|extract_right( 3 )|downcase(), 'pdf')))}	
								{def $pictoType=$linkedNode.data_map.file.content.original_filename|extract_right( 3 )|downcase()}
							
							{else}{def $pictoType='other'}
							{/if}
							
							{if $url|eq('')|not()}
								{def $picto = concat('<a href="',$url, $params, '" target="', $urlTarget,'"><img src="',concat('images/pictos/file/xsmall/',$pictoType,'.gif')|ezdesign(no),'" border="0" /></a>')}
							{else}
								{def $picto = concat('<img src="',concat('images/pictos/file/xsmall/',$pictoType,'.gif')|ezdesign(no),'" border="0" />')}
							{/if}
							
						{elseif or($linkedNode.class_identifier|eq('bouygues_video'), 
									$linkedNode.class_identifier|eq('bouygues_galerie_vid'))}
									
							{if $url|eq('')|not()}
								{def $picto = concat('<a href="',$url,$params,'" target="', $urlTarget,'"><img src="',concat('images/pictos/file/xsmall/video.gif')|ezdesign(no),'" border="0" /></a>')}
							{else}
								{def $picto = concat('<img src="',concat('images/pictos/file/xsmall/video.gif')|ezdesign(no),'" border="0" />')}
							{/if}
						{elseif $linkedNode.class_identifier|eq('bouygues_diapo')}
						
							{if $url|eq('')|not()}
								{def $picto = concat('<a href="',$url,$params,'" target="', $urlTarget,'"><img src="',concat('images/pictos/file/xsmall/pic.gif')|ezdesign(no),'" border="0" /></a>')}
							{else}
								{def $picto = concat('<img src="',concat('images/pictos/file/xsmall/pic.gif')|ezdesign(no),'" border="0" />')}
							{/if}
						{else}
							{def $picto=''}
									
						{/if}
						
						
						<div class="item">
							<div class="date">
								{"result_published"|i18n("design/bouygues/search")} 
								{if and(is_set($result.data_map.date_pub),and(is_set($result.data_map.date_pub_cb),$result.data_map.date_pub_cb.content|eq(1)))}
								{$result.data_map.date_pub.data_int|datetime( 'custom', '%d/%m/%Y' )}
								{else}
								{$result.object.current.modified|datetime( 'custom', '%d/%m/%Y' )}
								{/if}</div>
							{$picto} <strong class="title color3-{$classCss}">{if is_set($filiere.object)}{$filiere.object.name}{else}{'section_default'|i18n('extension/bouygues')}{/if}</strong>

							<div class="search-intro">
							{if $url|eq('')|not()}	
								<a href="{concat($url,$params)}" class="title color1-{$classCss}" target="{$urlTarget}"><span class="color1-{$classCss}">{$result.object.name}</span></a>
							{else}
								<span class="color1-{$classCss}">{$result.object.name}</span>
							{/if}
							</div>

							<div class="text">
							
								{if $result.data_map.accroche_liste.has_content}
									{$result.data_map.accroche_liste.content.output.output_text}
								{elseif $result.data_map.intro.has_content}
									{$result.data_map.intro.content.output.output_text|strip_tags()|shorten(300,'...')}
								{elseif $result.data_map.chapeau.has_content}
									{$result.data_map.chapeau.content.output.output_text|strip_tags()|shorten(300,'...')}
								{elseif $result.data_map.description.has_content}
									{$result.data_map.description.content.output.output_text|strip_tags()|shorten(300,'...')}
								{elseif $result.data_map.body.has_content}
									{$result.data_map.body.content.output.output_text|strip_tags()|shorten(300,'...')}
								{/if}
							
							</div>
							<div class="path overview-{$classCss}">{$stringTitle}</div>
						</div>
						{undef $arrp $stringTitle $count $parentPath $picto $pictoType $numPage $url $linkedNode $parentNode}
					{/foreach}
				{/if}	
			</div>
		</div>
		<div class="bottom">
			<div class="left"></div>
			<div class="right"></div>
			<div class="middle"></div>
		</div>
	</div>
</div>
{include uri="design:blocs/pagination_search.tpl"}

{literal}
<script type="text/javascript">
	$().ready(function(){
		
		
		jQuery.validator.addMethod("datesBetween", function(datesBetween, element) {
			if(datesBetween != ''){

			
				var date2 = $('input[name=beginDate]').val();
				var date1 = datesBetween;
				date1 = date1.split("/");
				date2 = date2.split("/");
				var sDate = new Date(date1[1]+"/"+date1[0]+"/"+date1[2]);
				var eDate = new Date(date2[1]+"/"+date2[0]+"/"+date2[2]);
				var daysApart = Math.round((sDate-eDate)/86400000);

				if(daysApart <= 0)
					return false;
			    else
					return true;

			}else{
				return true
			}

		}, "dede");
		
		jQuery.validator.addMethod("isValidDate", function(value, element) {
			if(value != ""){
				var params = value.split('/');
				var day=params[0]; var year=params[2]; var month=params[1]-1;

				var dteDate;
				dteDate=new Date(year,month,day);
				return ((day==dteDate.getDate()) && (month==dteDate.getMonth()) && (year==dteDate.getFullYear()));
			}else{
				return true;
			}
		}, "La date n'existe pas");
		
		$.dpText = {
						TEXT_PREV_YEAR		:	'Année précédente',
						TEXT_PREV_MONTH		:	'Mois précédent',
						TEXT_NEXT_YEAR		:	'Année suivante',
						TEXT_NEXT_MONTH		:	'Mois suivant',
						TEXT_CLOSE			:	'Fermer',
						TEXT_CHOOSE_DATE	:	'Choisir cette date'
					}
		
		$('#searchForm').validate({
			errorContainer: $('#searchFormError'),
			errorLabelContainer: $("ol", $('#searchFormError')),
			wrapper: 'li',
			rules: {
				endDate: {
					datesBetween: true
				}
			},
			messages: {
				endDate: {
					datesBetween: '{/literal}{'search_date_error2'|i18n('design/bouygues/search')}{literal}'
				}
			}
			
		});
		
		$('input[name=beginDate]').datePicker({startDate:'01/01/1996'});
		$('input[name=endDate]').datePicker({startDate:'01/01/1996'});
		
		
		{/literal}{if $terms|eq('')|not()}{literal}
		$('.ezsearch .bloc-result .item .text').highlight('{/literal}{$terms|wash()|addslashes()}{literal}');
		$('.ezsearch .bloc-result .item .search-intro').highlight('{/literal}{$terms|wash()|addslashes()}{literal}');
		{/literal}{/if}{literal}
		
		
	});
	
	function setFiliere(domElement){
		if(domElement.attr('checked'))
			domElement.attr('checked', false);
		else
			domElement.attr('checked', true);
	}
</script>
{/literal}

{undef $object $results $arrCssSubStructure $classCss $filieres}