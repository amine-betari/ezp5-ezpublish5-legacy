	{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}
	{if and(or($node.data_map.tpl_select.content.0|eq(0),$node.class_identifier|eq('bouygues_liste_thema')),$mode|eq('static')|not) }

		<div class="boxA">
			<div class="top">
				<div class="left"></div>
				<div class="right"></div>
				<div class="middle"></div>
			</div>
			<div class="content">

	{/if}
	
	{def $nb_children = $children|count()}
	{def $count_child=1 $datas='' $filiere=''}
	
	{foreach $children as $child }
		{if $node.data_map.tpl_select.content.0|eq(1)}
	
				<div class="boxA">
					<div class="top">
						<div class="left"></div>
						<div class="right"></div>
						<div class="middle"></div>
					</div>
					<div class="content">
	
		{/if}
			
		<div class="overview {if $nb_children|eq($count_child)}last{/if} {if $mode|eq('static')}overview-{if $arrCssSubStructure[$child.object.section_id]}{$arrCssSubStructure[$child.object.section_id]}{else}default{/if}{/if}">
						
		<div class="hOverview">
		{if is_set($child.data_map.file)}
			{if eq($child.data_map.file.content.original_filename|extract_right(4)|downcase(), 'pptx')}
				{def $pictoType='ppt'}
				{elseif eq($child.data_map.file.content.original_filename|extract_right( 4 )|downcase(), 'xlsx')}
					{def $pictoType='xls'}	
				{elseif eq($child.data_map.file.content.original_filename|extract_right(4)|downcase(), 'docx')}
					{def $pictoType='doc'}
				{elseif and(or(eq($child.data_map.file.content.original_filename|extract_right( 3 )|downcase(), 'doc'),
					eq($child.data_map.file.content.original_filename|extract_right( 3 )|downcase(), 'ppt'),
					eq($child.data_map.file.content.original_filename|extract_right( 3 )|downcase(), 'xls'),
					eq($child.data_map.file.content.original_filename|extract_right( 3 )|downcase(), 'pdf')))}	
					{def $pictoType=$child.data_map.file.content.original_filename|extract_right( 3 )|downcase()}
				{else}{def $pictoType='other'}
			{/if}
		{/if}
		
		{if $child.class_identifier|eq('file')}
			{def $url=concat('content/download/',
			$child.data_map.file.contentobject_id, '/',
			$child.data_map.file.id,'/version/',
			$child.data_map.file.version , '/file/',
			$child.data_map.file.content.original_filename|urlencode)|ezurl(no)}
		{elseif $child.class_identifier|eq('newsletter_issue')}
			{def $url=concat('newsletter/previewfull/',
			$child.contentobject_id, '/',
			$child.contentobject_version)|ezurl(no)}
			{def $urlTarget='_blank'}
		{elseif $child.class_identifier|eq('link')}
			{def $url=$child.data_map.lien.content|ezurl(no)}
			{def $urlTitle=$child.data_map.lien.data_text}
			{def $urlTarget='_blank'}
		{elseif $child.class_identifier|eq('bouygues_element_liste')|not()}
			{if $child.url_alias}
				{def $url=$child.url_alias|ezurl(no)}
			{else}
				{def $url=$child.main_node.url_alias|ezurl(no)}
			{/if}
		{elseif and($child.class_identifier|eq('bouygues_element_liste'),or($child.data_map.lien_eby.has_content, $child.data_map.lien_ext.has_content))}
			{if $child.data_map.lien_eby.has_content}
				{def $url=$child.data_map.lien_eby.value.main_node.url_alias|ezurl(no)}
			{elseif $child.data_map.lien_ext.has_content}
				{def $url=$child.data_map.lien_ext.content|ezurl(no)}
				{def $urlTitle=$child.data_map.lien_ext.data_text}
				{def $urlTarget='_blank'}
			{else}{def $url = ''}{/if}
		{else}{def $url = '#'}
		{/if}
				
				
					
				{if and($child.class_identifier|eq('file'),$child.data_map.image_vignette.has_content|not)}

					<!--  no_default:  $child.data_map.no_default_picture.content  -->
					 {if ne($child.data_map.no_default_picture.content,1)}

					{if $node.data_map.vignette_select.content.0|eq(0)}
						<a class="medium border4" {if $url|eq('#')|not}href="{$url}"{/if} {if is_set($urlTarget)}target="{$urlTarget}"{/if}><img src="{concat('images/pictos/file/medium/',$pictoType,'.gif')|ezdesign(no)}" alt="{$child.name|wash('xhtml')}" title="{$child.name|wash('xhtml')}" border="0" /></a>
					{elseif $node.data_map.vignette_select.content.0|eq(1)}
						<a class="big border4" {if $url|eq('#')|not}href="{$url}"{/if} {if is_set($urlTarget)}target="{$urlTarget}"{/if}><img src="{concat('images/pictos/file/big/',$pictoType,'.gif')|ezdesign(no)}" alt="{$child.name|wash('xhtml')}" title="{$child.name|wash('xhtml')}" border="0" /></a>
					{elseif $node.data_map.vignette_select.content.0|eq(2)}
						<a class="thumb border4" {if $url|eq('#')|not}href="{$url}"{/if} {if is_set($urlTarget)}target="{$urlTarget}"{/if}><img src="{concat('images/pictos/file/small/',$pictoType,'.gif')|ezdesign(no)}" alt="{$child.name|wash('xhtml')}" title="{$child.name|wash('xhtml')}" border="0" /></a>	
					{/if}
					{/if}
				{elseif or($node.data_map.vignette_select.content.0|eq(4)|not(),$mode|eq('static'))}
					{if $child.data_map.image_vignette.has_content}
						{if or($node.data_map.vignette_select.content.0|eq(0),$mode|eq('static'))}
							<a class="medium border4{if $mode|eq('static')}{if $arrCssSubStructure[$child.section_id]}-{$arrCssSubStructure[$child.section_id]}{else}-default{/if}{/if}" {if $url|eq('#')|not}href="{$url}"{/if} {if is_set($urlTarget)}target="{$urlTarget}"{/if}><img src="{$child.data_map.image_vignette.content.mediumlist.url|ezroot(no)}" alt="{if $child.data_map.image_vignette.content.alternative_text}{$child.data_map.image_vignette.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" title="{if $child.data_map.image_vignette.content.alternative_text}{$child.data_map.image_vignette.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" /></a>
						{elseif $node.data_map.vignette_select.content.0|eq(1)}
							<a class="big border4" {if $url|eq('#')|not}href="{$url}"{/if} {if is_set($urlTarget)}target="{$urlTarget}"{/if}><img src="{$child.data_map.image_vignette.content.largelist.url|ezroot(no)}" alt="{if $child.data_map.image_vignette.content.alternative_text}{$child.data_map.image_vignette.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" title="{if $child.data_map.image_vignette.content.alternative_text}{$child.data_map.image_vignette.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" /></a>
						{elseif $node.data_map.vignette_select.content.0|eq(2)}
							{if $url|eq('#')|not}<a class="thumb border4" href="{$url}" {if is_set($urlTarget)}target="{$urlTarget}"{/if}>
							{else}<div class="thumb border4">{/if}
							<img src="{$child.data_map.image_vignette.content.thumblist.url|ezroot(no)}" alt="{if $child.data_map.image_vignette.content.alternative_text}{$child.data_map.image_vignette.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" title="{if $child.data_map.image_vignette.content.alternative_text}{$child.data_map.image_vignette.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" />{if $url|eq('#')|not}</a>{else}</div>{/if}
						{/if}
					{elseif $child.data_map.image_main.has_content}
						{if or($node.data_map.vignette_select.content.0|eq(0),$mode|eq('static'))}
							<a class="medium border4{if $mode|eq('static')}{if $arrCssSubStructure[$child.section_id]}-{$arrCssSubStructure[$child.section_id]}{else}-default{/if}{/if}" {if $url|eq('#')|not}href="{$url}"{/if} {if is_set($urlTarget)}target="{$urlTarget}"{/if}><img src="{$child.data_map.image_main.content.mediumlist.url|ezroot(no)}" alt="{if $child.data_map.image_main.content.alternative_text}{$child.data_map.image_main.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" title="{if $child.data_map.image_main.content.alternative_text}{$child.data_map.image_main.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" /></a>
						{elseif $node.data_map.vignette_select.content.0|eq(1)}
							<a class="big border4" {if $url|eq('#')|not}href="{$url}"{/if} {if is_set($urlTarget)}target="{$urlTarget}"{/if}><img src="{$child.data_map.image_main.content.largelist.url|ezroot(no)}" alt="{if $child.data_map.image_main.content.alternative_text}{$child.data_map.image_main.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" title="{if $child.data_map.image_main.content.alternative_text}{$child.data_map.image_main.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" /></a>
						{elseif $node.data_map.vignette_select.content.0|eq(2)}
							<a class="thumb border4" {if $url|eq('#')|not}href="{$url}"{/if} {if is_set($urlTarget)}target="{$urlTarget}"{/if}><img src="{$child.data_map.image_main.content.thumblist.url|ezroot(no)}" alt="{if $child.data_map.image_main.content.alternative_text}{$child.data_map.image_main.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" title="{if $child.data_map.image_main.content.alternative_text}{$child.data_map.image_main.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" /></a>
						{/if}
					{elseif $child.data_map.image.has_content}
						{if or($node.data_map.vignette_select.content.0|eq(0),$mode|eq('static'))}
							<a class="medium border4{if $mode|eq('static')}{if $arrCssSubStructure[$child.section_id]}-{$arrCssSubStructure[$child.section_id]}{else}-default{/if}{/if}" {if $url|eq('#')|not}href="{$url}"{/if} {if is_set($urlTarget)}target="{$urlTarget}"{/if}><img src="{$child.data_map.image.content.mediumlist.url|ezroot(no)}" alt="{if $child.data_map.image.content.alternative_text}{$child.data_map.image.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" title="{if $child.data_map.image.content.alternative_text}{$child.data_map.image.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" /></a>
						{elseif $node.data_map.vignette_select.content.0|eq(1)}
							<a class="big border4" {if $url|eq('#')|not}href="{$url}"{/if} {if is_set($urlTarget)}target="{$urlTarget}"{/if}><img src="{$child.data_map.image.content.largelist.url|ezroot(no)}" alt="{if $child.data_map.image.content.alternative_text}{$child.data_map.image.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" title="{if $child.data_map.image.content.alternative_text}{$child.data_map.image.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" /></a>
						{elseif $node.data_map.vignette_select.content.0|eq(2)}
							<a class="thumb border4" {if $url|eq('#')|not}href="{$url}"{/if} {if is_set($urlTarget)}target="{$urlTarget}"{/if}><img src="{$child.data_map.image.content.thumblist.url|ezroot(no)}" alt="{if $child.data_map.image.content.alternative_text}{$child.data_map.image.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" title="{if $child.data_map.image.content.alternative_text}{$child.data_map.image.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" /></a>
						{/if}
					{elseif and($child.class_identifier|eq('bouygues_element_liste'),$child.data_map.lien_eby.content.data_map.image_vignette.has_content)}
						{if or($node.data_map.vignette_select.content.0|eq(0),$mode|eq('static'))}
							<a class="medium border4{if $mode|eq('static')}{if $arrCssSubStructure[$child.section_id]}-{$arrCssSubStructure[$child.section_id]}{else}-default{/if}{/if}" {if $url|eq('#')|not}href="{$url}"{/if} {if is_set($urlTarget)}target="{$urlTarget}"{/if}><img src="{$child.data_map.lien_eby.content.data_map.image_vignette.content.mediumlist.url|ezroot(no)}" alt="{if $child.data_map.lien_eby.content.data_map.image_vignette.content.alternative_text}{$child.data_map.lien_eby.content.data_map.image_vignette.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" title="{if $child.data_map.image.content.alternative_text}{$child.data_map.image.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" /></a>
						{elseif $node.data_map.vignette_select.content.0|eq(1)}
							<a class="big border4" {if $url|eq('#')|not}href="{$url}"{/if} {if is_set($urlTarget)}target="{$urlTarget}"{/if}><img src="{$child.data_map.lien_eby.content.data_map.image_vignette.content.largelist.url|ezroot(no)}" alt="{if $child.data_map.lien_eby.content.data_map.image_vignette.content.alternative_text}{$child.data_map.lien_eby.content.data_map.image_vignette.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" title="{if $$child.data_map.lien_eby.content.data_map.image_vignette.content.alternative_text}{$child.data_map.lien_eby.content.data_map.image_vignette.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" /></a>
						{elseif $node.data_map.vignette_select.content.0|eq(2)}
							<a class="thumb border4" {if $url|eq('#')|not}href="{$url}"{/if} {if is_set($urlTarget)}target="{$urlTarget}"{/if}><img src="{$child.data_map.lien_eby.content.data_map.image_vignette.content.thumblist.url|ezroot(no)}" alt="{if $child.data_map.lien_eby.content.data_map.image_vignette.content.alternative_text}{$child.data_map.lien_eby.content.data_map.image_vignette.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" title="{if $child.data_map.lien_eby.content.data_map.image_vignette.content.alternative_text}{$child.data_map.lien_eby.content.data_map.image_vignette.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" /></a>
						{/if}	
					{elseif and($child.class_identifier|eq('bouygues_video'),not(eq($child.data_map.video_wat.content.display, '')))}
						<a class="medium border4" {if $url|eq('#')|not}href="{$url}"{/if} {if is_set($urlTarget)}target="{$urlTarget}"{/if}><img width="115" height="74" src="{$child.data_map.video_wat.content.thumb_mini}" alt="{if $child.data_map.lien_eby.content.data_map.image_vignette.content.alternative_text}{$child.data_map.lien_eby.content.data_map.image_vignette.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" title="{if $child.data_map.lien_eby.content.data_map.image_vignette.content.alternative_text}{$child.data_map.lien_eby.content.data_map.image_vignette.content.alternative_text}{else}{$child.name|wash('xhtml')}{/if}" /></a>
					{/if}
				{/if}
						
								<div class="text">
									
									{if and(or($child.data_map.short_title.has_content,$child.data_map.liste_surtitre.has_content),eq($node.data_map.sur_titre_cb.value,1))}
										<strong class="title {if $mode|eq('static')}color2-{$arrCssSubStructure[$child.section_id]}{/if}">{if $child.data_map.short_title.has_content}{$child.data_map.short_title.content}{else}{$child.data_map.liste_surtitre.content}{/if}</strong>
									{/if}
									
									{if $mode|eq('static')}
										{if $child.object.section_id|eq(16)|not()}

										
										{set $filiere=fetch('content', 'tree', hash('parent_node_id', 2, 
															'class_filter_type', 'include',
															'class_filter_array', array('bouygues_master_page'),
															'depth', 1,
															'limit', 1,
															'offset', 0,
															'attribute_filter', array(array('section', '=', $child.object.section_id))))}
										
										<strong class="title">{$filiere.0.object.name}</strong>

										{else}
										<strong class="title">{'section_default'|i18n('extension/bouygues')}</strong>
										{/if}
									{/if}
									
									{if or($node.parent.parent_node_id|eq(11612),$node.parent_node_id|eq(11612))|not}	
										{if and(or($child.class_identifier|eq('link')|not(),$child.class_identifier|eq('newsletter_issue')|not()),eq($url,'#')|not())}
											<a href="{$url}" title="{if is_set($urlTitle)}{$urlTitle}{else}{$child.name|wash('xhtml')}{/if}" {if is_set($urlTarget)}target="{$urlTarget}"{/if} class="subTitle {if $mode|eq('static')}color2-{$arrCssSubStructure[$child.object.section_id]}{/if}">{$child.name}</a>
										{elseif and(or($child.class_identifier|eq('link'),$child.class_identifier|eq('newsletter_issue')),eq($url,'#')|not())}
											<a href="{$url}" title="{if is_set($urlTitle)}{$urlTitle}{else}{$child.name|wash('xhtml')}{/if}" class="subTitle {if $mode|eq('static')}color2-{$arrCssSubStructure[$child.section_id]}{/if}" target="_blank">{$child.name}</a>
										{else}
											<span class="subTitle color2">{$child.name}</span>
										{/if}
									{/if}
									
									<br />
									{if or($node.data_map.date_select.content.0|eq(1),$mode|eq('static'))}
										{if $child.data_map.date_pub.has_content}
										<span class="date">{$child.data_map.date_pub.data_int|datetime( 'custom', '%d/%m/%Y' )}</span>
										{/if}
									{elseif $node.data_map.date_select.content.0|eq(2)}
										<span class="date">{$child.object.current.modified|datetime( 'custom', '%d/%m/%Y' )}</span>
									{/if}
								</div>
								
								{if eq($url,'#')|not()}
									<div class="arrow"><a href="{$url}" title="{if is_set($urlTitle)}{$urlTitle}{else}{$child.name|wash('xhtml'))}{/if}" {if is_set($urlTarget)}target="{$urlTarget}"{/if}></a></div>
								{elseif or($child.class_identifier|eq('link'),$child.class_identifier|eq('newsletter_issue'))}
									<div class="arrow"><a href="{$url}" title="{if is_set($urlTitle)}{$urlTitle}{else}{$child.name|wash('xhtml')}{/if}" target="_blank"></a></div>
								{/if}
						
									{def $url_link = $url}
									
									{if is_set($urlTarget)}
										{def $url_link_target = $urlTarget}
										{undef $urlTarget}
									{/if}
								
									{if is_set($urlTitle)}
										{undef $urlTitle}
									{/if}
									
									{undef $url}
								
								</div>
							
								<div class="clear">
									
									{if or($node.parent.parent_node_id|eq(11612),$node.parent_node_id|eq(11612))}
											<span class="subTitle">{$child.name}</span>
									{/if}
									
									{if or($node.data_map.accroche_cb.content|eq(1),$mode|eq('static'))}
										{if $child.data_map.accroche_liste.has_content}
											{$child.data_map.accroche_liste.content.output.output_text}
										{elseif $child.data_map.intro.has_content}
											<p>{$child.data_map.intro.content.output.output_text|strip_tags()|shorten(300,'...')}</p>
										{elseif $child.data_map.chapeau.has_content}
											<p>{$child.data_map.chapeau.content.output.output_text|strip_tags()|shorten(300,'...')}</p>
										{elseif $child.data_map.description.has_content}
											<p>{$child.data_map.description.content.output.output_text|strip_tags()|shorten(300,'...')}</p>
										{elseif $child.data_map.body.has_content}
											<p>{$child.data_map.body.content.output.output_text|strip_tags()|shorten(300,'...')}</p>
										{elseif $child.class_identifier|eq('bouygues_element_liste')}
											{if $child.data_map.lien_eby.content.data_map.accroche_liste.has_content}
												{$child.data_map.lien_eby.content.data_map.accroche_liste.content.output.output_text}
											{elseif $child.data_map.lien_eby.content.data_map.intro.has_content}
												<p>{$child.data_map.lien_eby.content.data_map.intro.content.output.output_text|strip_tags()|shorten(300,'...')}</p>
											{elseif $child.data_map.lien_eby.content.data_map.chapeau.has_content}
												<p>{$child.data_map.lien_eby.content.data_map.chapeau.content.output.output_text|strip_tags()|shorten(300,'...')}</p>
											{elseif $child.data_map.lien_eby.content.data_map.description.has_content}
												<p>{$child.data_map.lien_eby.content.data_map.description.content.output.output_text|strip_tags()|shorten(300,'...')}</p>
											{elseif $child.data_map.lien_eby.content.data_map.body.has_content}
												<p>{$child.data_map.lien_eby.content.data_map.body.content.output.output_text|strip_tags()|shorten(300,'...')}</p>
											{/if}
										{/if}
									{/if}

									{if and(eq($node.class_identifier,'bouygues_liste_thema'), $node.data_map.liste_n_2_cb.value|eq(1))}
					
										
										{if $child.data_map.ordre_select.content.0|eq(0)}{set $orderField2='published'}{set $orderBoo2=false()}
										{elseif $child.data_map.ordre_select.content.0|eq(1)}{set $orderField2='published'}{set $orderBoo2=true()}
										{elseif $child.data_map.ordre_select.content.0|eq(2)}{set $orderField2='modified'}{set $orderBoo2=true()}
										{elseif $child.data_map.ordre_select.content.0|eq(3)}{set $orderField2='modified'}{set $orderBoo2=false()}
										{elseif $child.data_map.ordre_select.content.0|eq(4)}{set $orderField2='published'}{set $orderBoo2=true()}
										{elseif $child.data_map.ordre_select.content.0|eq(5)}{set $orderField2='published'}{set $orderBoo2=false()}
										{elseif $child.data_map.ordre_select.content.0|eq(6)}{set $orderField2='name'}{set $orderBoo2=true()}
										{elseif $child.data_map.ordre_select.content.0|eq(7)}{set $orderField2='name'}{set $orderBoo2=false()}
										{elseif $child.data_map.ordre_select.content.0|eq(8)}{set $orderField2='priority'}{set $orderBoo2=true()}
										{elseif $child.data_map.ordre_select.content.0|eq(9)}{set $orderField2='priority'}{set $orderBoo2=false()}
										{/if}
									
										{if eq($child.data_map.lien_thema_cb.content,1)}
											{set $numberOfObjects = $child.data_map.element_select.class_content.options[$child.data_map.element_select.value[0]].name}
										{elseif eq($node.data_map.lien_thema_cb.value,1)}
											{set $numberOfObjects = $node.data_map.element_select.class_content.options[$node.data_map.element_select.value[0]].name}
										{else}
											{set $numberOfObjects = 20}
										{/if}
										
										{set $datas=fetch('content','list',hash(
												'parent_node_id',$child.node_id,
												'class_filter_type',  'include',
												'class_filter_array', array(    'article',
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
																				'link',
																				'file',
																				'bouygues_whoswho_list'
																			),
												'depth',1,
												'offset',0,
												'limit',$numberOfObjects,
												'sort_by', array( array( $orderField2, $orderBoo2 ))
												)
										)}	
										
										{undef $pictoType}
										{if $datas|count()|gt(0)}
										<ul>
											{foreach $datas as $data}
											
												
											{if $data.class_identifier|eq('file')}
												{def $url=concat('content/download/',
												$data.data_map.file.contentobject_id, '/',
												$data.data_map.file.id,'/version/',
												$data.data_map.file.version , '/file/',
												$data.data_map.file.content.original_filename|urlencode)|ezurl(no)}
											{elseif $data.class_identifier|eq('link')}
												{def $url=$data.data_map.lien.content|ezurl(no)}
												{def $urlTitle=$data.data_map.lien.data_text}
												{def $urlTarget='_blank'}
											{elseif $data.class_identifier|eq('bouygues_element_liste')|not()}
												{def $url=$data.url_alias|ezurl(no)}
											{elseif and($data.class_identifier|eq('bouygues_element_liste'),or($data.data_map.lien_eby.has_content, $data.data_map.lien_ext.has_content))}
												{if $data.data_map.lien_eby.has_content}
													{def $url=$data.data_map.lien_eby.value.main_node.url_alias|ezurl(no)}
												{elseif $data.data_map.lien_ext.has_content}
													{def $url=$data.data_map.lien_ext.content|ezurl(no)}
													{def $urlTitle=$data.data_map.lien_ext.data_text}
													{def $urlTarget='_blank'}
												{else}{def $url = '"#"'}{/if}	
											{else}
												{def $url=$data.url_alias|ezurl(no)}
											{/if}
											
											{if $data.data_map.file.content.original_filename}
												{if eq($data.data_map.file.content.original_filename|extract_right( 4 )|downcase(), 'pptx')}
													{def $pictoType='ppt'}
												{elseif eq($data.data_map.file.content.original_filename|extract_right( 4 )|downcase(), 'xlsx')}
													{def $pictoType='xls'}	
												{elseif eq($data.data_map.file.content.original_filename|extract_right( 4 )|downcase(), 'docx')}
													{def $pictoType='doc'}
												{elseif and(or(eq($data.data_map.file.content.original_filename|extract_right( 3 )|downcase(), 'doc'),
													eq($data.data_map.file.content.original_filename|extract_right( 3 )|downcase(), 'ppt'),
													eq($data.data_map.file.content.original_filename|extract_right( 3 )|downcase(), 'xls'),
													eq($data.data_map.file.content.original_filename|extract_right( 3 )|downcase(), 'pdf')))}
												{def $pictoType=$data.data_map.file.content.original_filename|extract_right( 3 )|downcase()}
												{else}{def $pictoType='other'}
												{/if}
											{/if}
											
											<li>{if is_set($pictoType)}<img src="{concat('images/pictos/file/xsmall/',$pictoType,'.gif')|ezdesign(no)}" alt="" />{/if} <a href="{$url}" {if is_set($urlTarget)}target="{$urlTarget}"{/if} title="{if is_set($urlTitle)}{$urlTitle}{else}{$data.name}{/if}">{$data.name}</a></li>
											
												{undef $urlTitle}
												{undef $urlTarget}
												{undef $url}
											
											{/foreach}
										</ul>
										{/if}
										
									{/if}
									
									{if or($node.parent.parent_node_id|eq(11612),$node.parent_node_id|eq(11612))}
										<ul>
											<li><a href="{$url_link}" {if is_set($url_link_target)}target="{$url_link_target}"{/if} title="{"link_other_website"|i18n("design/bouygues/liste")} - {$child.name|wash('xhtml')}">{"link_other_website"|i18n("design/bouygues/liste")}</a></li>
										</ul>
									{/if}
									
									{undef $url_link}	
									{undef $url_link_target}	
								
								</div>
							
						</div>
						
			{if $node.data_map.tpl_select.content.0|eq(1)}
							
					</div>
					<div class="bottom">
						<div class="left"></div>
						<div class="right"></div>
						<div class="middle"></div>
					</div>
				</div>
				
			{/if}
			
			{if and($node.data_map.tpl_select.content.0|eq(1),$count_child|mod(2)|eq(0))}<div style="clear:both;"></div>{/if}
			{set $count_child=inc($count_child)}
			
		{/foreach}
			
		{undef $count_child}
			
		{if and(or($node.data_map.tpl_select.content.0|eq(0),$node.class_identifier|eq('bouygues_liste_thema')),$mode|eq('static')|not)}
				
			</div>
			<div class="bottom">
				<div class="left"></div>
				<div class="right"></div>
				<div class="middle"></div>
			</div>
		</div>
				
		{/if}
{undef $datas $filiere}