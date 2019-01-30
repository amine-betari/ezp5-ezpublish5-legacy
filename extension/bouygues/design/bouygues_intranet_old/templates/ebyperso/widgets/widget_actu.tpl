{def $displaySettings = true()
	 $class=''
}
{if $id|eq('1')}
	{set $displaySettings = false()}
{/if}

{def $host_path = concat('https://',ezsys('hostname'))}
{def $count_host_path = $host_path|count_chars}


<li class="widget actu color-default" id="widget{$id}">

	<form id="form{$id}">
	<div class="widget-head"></div>
	<div class="edit-box" {if $displaySettings}style="display:none;"{/if}>
	<div class="widget-edit-content">
	<fieldset>
		<legend>{'widget_news_title'|i18n('design/bouygues/ebyperso')}</legend>
			<p>
			<label>{'widget_news_select'|i18n('design/bouygues/ebyperso')} </label>
			<select id="filiere{$id}" class="select" name="filiere{$id}" >
				{foreach $exportList as $export}

					{def $filieres = fetch( 'content', 'list', hash( 'parent_node_id', 2,
												'class_filter_type',  'include',
												'class_filter_array', array( 'bouygues_master_page' ),
												'attribute_filter',  array(array('section','=',$export.item_list.0.source_node.object.section_id)),
												'limit', 1,
												'depth', 1)
												)}

					{def $filiere=$filieres.0}
					{if $section_id|eq($export.item_list.0.source_node.object.section_id)}{def $currentExport=$export}{/if}
					{def $isUserWidget=isUserWidget($userId, $filiereINI[$export.item_list.0.source_node.object.section_id][0])}
					{if and(
							eq($filiereINI[$export.item_list.0.source_node.object.section_id][1],'enable'),
							and(

								or(
									and($section_id|eq($export.item_list.0.source_node.object.section_id)|not(),
										$isUserWidget|not()),
									and($section_id|eq($export.item_list.0.source_node.object.section_id),
										$isUserWidget))
							)
						)}
						<option value="{$filiereINI[$export.item_list.0.source_node.object.section_id][0]}" {if $section_id|eq($export.item_list.0.source_node.object.section_id)}selected{/if}>{$filiereINI[$export.item_list.0.source_node.object.section_id][3]|wash}</option>
					{/if}
					{if eq($filiereINI[$export.item_list.0.source_node.object.section_id][0],$id)}
						{if $filiereINI[$export.item_list.0.source_node.object.section_id][2]|eq('eby')}{set $class=concat('-','eby')}
						{else}{set $class = concat('-',$filiereINI[$export.item_list.0.source_node.object.section_id][2])}
						{/if}
					{/if}
					{undef $isUserWidget}


				{/foreach}
			</select>
			</p>
			<p>
			<label>{'widget_news_display'|i18n('design/bouygues/ebyperso')} </label><select id="nbnews{$id}"  name="nbnews{$id}" >
			{for 1 to $nbNewsMax as $i}
				<option value="{$i}" {if $i|eq($nbNewsInit)}selected{/if}>{$i}</option>
			{/for}
			</select>
			{"widget_pages_content"|i18n("design/bouygues/ebyperso")}
			</p>
			<p>
			<label>{'widget_news_display_picture'|i18n('design/bouygues/ebyperso')} </label>
				<input type="radio" name="imgnews{$id}" value="1" checked="checked" /> {'widget_news_yes'|i18n('design/bouygues/ebyperso')}  <input type="radio" name="imgnews{$id}" value="2" /> {'widget_news_no'|i18n('design/bouygues/ebyperso')}
			</p>

			{include uri="design:blocs/btn.tpl" label='widget_cancel'|i18n('design/bouygues/ebyperso') url='#' onclick='return false;' class=concat('closeActuWidget',$id) align='right'}
			{include uri="design:blocs/btn.tpl" label='widget_validate'|i18n('design/bouygues/ebyperso') url='#' submit=concat('form',$id) align='right'}

		</fieldset>
	</div>
	<div class="widget-edit-bottom"></div>
	</div>

	{cache-block keys=array( concat(widget,$id), $nbnews, $imgnews) ignore_content_expiry expiry=3600}

	<div class="widget-title">
		<h3 class="bgColor3{$class}">{$title}</h3>
	</div>
	<div class="widget-content">
	<div class="widget-overview">

{if and(is_set( $param ) , is_array( $param ))}


	{if $currentRssNodes}

		{def $title=''}
		{def $description=''}
		{def $enclosure=''}
		{def $filesize=''}
		{def $mime_type=''}
		{def $pub_date=''}
		{def $category=''}
		{def $short_title=''}
		{def $url=''}
		{def $urlTarget=''}
		{def $my_node=''}
		{def $counterRssFeed=0}

		{foreach $currentRssNodes as $item}
			{set $counterRssFeed=inc($counterRssFeed)}
			{* title par défaut => Titre du contenu *}
			{if is_set($item.data_map.titre)}
	        	{set $title=$item.data_map.titre.content}
			{else}
				{set $title=$item.object.name}
	        {/if}

			{* Short title*}
			{if is_set($item.data_map.short_title)}
	        	{set $short_title=$item.data_map.short_title.content}
			{else}
				{set $short_title=''}
	        {/if}


			{* Date de publication => Date du contenu
			   Par défaut la date de modification
			 *}

			{set $pub_date = $item.object.modified}
			{if and(is_set($item.data_map.date_pub_cb), $item.data_map.date_pub_cb.value|eq(1))}
				{set $pub_date = $item.data_map.date_pub.content.timestamp}
			{else}
				{set $pub_date = ''}
			{/if}


			{* description par défaut => Accroche du contenu *}
	        {if and(is_set($item.data_map.accroche_liste),$item.data_map.accroche_liste.has_content)}
	        	{set $description = $item.data_map.accroche_liste.content.output.output_text}
	        {* si pas d'accroche_liste => chapeau  *}
	        {elseif and(is_set($item.data_map.chapeau),$item.data_map.chapeau.content.has_content)}
				{set $description=$item.data_map.chapeau.content.output.output_text}
			{* si pas de cahpeau => description (Texte) *}
	        {elseif and(is_set($item.data_map.description),$item.data_map.description.has_content)}
				{set $description=$item.data_map.description.content.output.output_text}
			{else}
				{set $description=''}
			{/if}


	        {* enclosure par défaut => Vignette du contenu *}

	        {if is_set($item.data_map.file)}
				{if eq($item.data_map.file.content.original_filename|extract_right(4)|downcase(), 'pptx')}
				{def $pictoType='ppt'}
					{elseif eq($item.data_map.file.content.original_filename|extract_right( 4 )|downcase(), 'xlsx')}
					{def $pictoType='xls'}
					{elseif eq($item.data_map.file.content.original_filename|extract_right(4)|downcase(), 'docx')}
					{def $pictoType='doc'}
					{elseif and(or(eq($item.data_map.file.content.original_filename|extract_right( 3 )|downcase(), 'doc'),
					eq($item.data_map.file.content.original_filename|extract_right( 3 )|downcase(), 'ppt'),
					eq($item.data_map.file.content.original_filename|extract_right( 3 )|downcase(), 'xls'),
					eq($item.data_map.file.content.original_filename|extract_right( 3 )|downcase(), 'pdf')))}
					{def $pictoType=$item.data_map.file.content.original_filename|extract_right( 3 )|downcase()}
					{else}{def $pictoType='other'}
				{/if}
			{/if}


	        {if and($item.class_identifier|eq('file'),$item.data_map.image_vignette.has_content|not)}
				{set $enclosure = concat('images/pictos/file/xsmall/',$pictoType,'.gif')|ezdesign(no)}
				{def $modeimage=1}
	        {elseif $item.data_map.liste_vignette.has_content}
				{set $enclosure=$item.data_map.liste_vignette.content.rss_small.url}
				{set $filesize = $item.data_map.liste_vignette.content.rss_small.filesize}
				{set $mime_type = $item.data_map.liste_vignette.content.rss_small.mime_type}
			{elseif $item.data_map.image_vignette.has_content}
				{set $enclosure=$item.data_map.image_vignette.content.rss_small.url}
				{set $filesize = $item.data_map.image_vignette.content.rss_small.filesize}
				{set $mime_type = $item.data_map.image_vignette.content.rss_small.mime_type}
			{elseif $item.data_map.image_main.has_content}
				{set $enclosure=$item.data_map.image_main.content.rss_small.url}
				{set $filesize = $item.data_map.image_main.content.rss_small.filesize}
				{set $mime_type = $item.data_map.image_main.content.rss_small.mime_type}
			{elseif $item.data_map.image.has_content}
				{set $enclosure=$item.data_map.image.content.rss_small.url}
				{set $filesize = $item.data_map.image.content.rss_small.filesize}
				{set $mime_type = $item.data_map.image.content.rss_small.mime_type}
			{else}
				{set $enclosure=''}
			{/if}


			{* category par défaut => Surtitre du contenu *}
			{if $item.data_map.liste_surtitre.content|ne('')}
				{set $category = $item.data_map.liste_surtitre.content}
			{/if}


			{* Link*}
			{if $item.class_identifier|eq('file')}
					{set $url=concat('content/download/',
					$item.data_map.file.contentobject_id, '/',
					$item.data_map.file.id,'/version/',
					$item.data_map.file.version , '/file/',
					$item.data_map.file.content.original_filename|urlencode)|ezurl(no)}
			{elseif $item.class_identifier|eq('newsletter_issue')}
					{set $url=$item.url_alias|ezurl(no)}
					{def $urlTarget='_blank'}
			{elseif $item.class_identifier|eq('link')}
					{set $url=$item.data_map.lien.content|ezurl(no)}
					{set $urlTarget='_blank'}
			{elseif $item.class_identifier|eq('bouygues_element_liste')|not()}

					{set $url=$item.url_alias|ezurl(no)}

			{elseif and($item.class_identifier|eq('bouygues_element_liste'),or($item.data_map.lien_eby.has_content, $item.data_map.lien_ext.has_content))}
					{if $item.data_map.lien_eby.has_content}
						{set $url=$item.data_map.lien_eby.value.main_node.url_alias|ezurl(no)}
					{elseif $item.data_map.lien_ext.has_content}
						{set $url=$item.data_map.lien_ext.content|ezurl(no)}
						{set $urlTarget='_blank'}
					{else}{set $url = ''}{/if}
			{else}{set $url = ''}
			{/if}


	        {* traitement des cas particuliers en fonction des classes *}
	       {switch match=$item.class_identifier}
				{case match='article'}
	        		{set $title=$item.data_map.title.content}
	        		{if $item.data_map.intro.has_content}
	        			{set $description=$item.data_map.intro.content.output.output_text}
	        		{/if}
	        		{if $item.data_map.image_vignette.has_content}
	        			{set $enclosure=$item.data_map.image_vignette.content.rss_small.url}
	        			{set $filesize = $item.data_map.image_vignette.content.rss_small.filesize}
	        			{set $mime_type = $item.data_map.image_vignette.content.rss_small.mime_type}
	        		{/if}
	    		{/case}

	    		{case match='bouygues_categorie'}
	        		{set $title=$item.data_map.nom.content}
	    		{/case}

	    		{case match='bouygues_element_liste'}
	        	    {if $item.data_map.accroche.content.output.output_text|ne('')}
			        	{set $description = $item.data_map.accroche.content.output.output_text}
			        {/if}
			        {if $item.data_map.date_pub.content.timestamp|ne('')}
						{set $pub_date = $item.data_map.date_pub.content.timestamp}
					{/if}
	        		{set $category = $item.data_map.surtitre.content}
	        		{if $item.data_map.vignette.has_content}
	        			{set $enclosure=$item.data_map.vignette.content.rss_small.url}
	        			{set $filesize = $item.data_map.vignette.content.rss_small.filesize}
	        			{set $mime_type = $item.data_map.vignette.content.rss_small.mime_type}
	        		{/if}
	    		{/case}

		 	{/switch}


			{*set $description = $description|strip_tags|shorten( 300 )|simplify|trim*}

		    	<div class="actu-ebyperso overview{$class}">
			    	{if or(and($imgnews|eq('1'),$enclosure|eq('')|not),$modeimage|eq('1'))}
					<img src={$enclosure|ezroot(,'full')} alt="{$title}" align="left" hspace="5" />
					{/if}
					<span class="actu-ebypersoSmall">{if $short_title|eq('')|not()}<strong>{$short_title}</strong><br />{/if}
					{if $pub_date|eq('')|not}{$pub_date|datetime( 'custom', '%d/%m/%Y' )}<br />{/if}</span>
				    {if and($url|eq('')|not(), $url|eq('/')|not())}<a href="{$url}" title="{$title}" target='{$urlTarget}'>{/if}
					<strong>{$title}</strong>
					{if and($url|eq('')|not(), $url|eq('/')|not())}</a>{/if}
					<br />

				    {$description}
		    	</div>
		    	<br />
		    	{if $counterRssFeed|eq($nbnews)}{break}{/if}
		    	{undef $modeimage}
		{/foreach}

			{undef $title}
		  	{undef $description}
		  	{undef $enclosure}
			{undef $filesize}
		  	{undef $mime_type}
		  	{undef $pub_date}
		  	{undef $category}
			{undef $short_title}
			{undef $url}
			{undef $urlTarget}

	{/if}
{/if}
		</div>
	</div>
		<div class="widget-bottom"></div>
		{/cache-block}
	</form>
</li>

<script type="text/javascript">
	$().ready(function(){literal}{

		$('#filiere{/literal}{$id}{literal}').live( 'keyup', function(e) {
			if(e.keyCode == 13) {
				$('#form{/literal}{$id}{literal}').submit();
			}
		});

		$('#nbnews{/literal}{$id}{literal}').live( 'keyup', function(e) {
			if(e.keyCode == 13) {
				$('#form{/literal}{$id}{literal}').submit();
			}
		});

		$('input[name=imgnews{/literal}{$id}{literal}]').live( 'keyup', function(e) {
			if(e.keyCode == 13) {
				$('#form{/literal}{$id}{literal}').submit();
			}
		});
	});
	{/literal}
	$("form#form{$id}").submit(function(){ldelim}
		updSettings({$id});
		return false;
	{rdelim});

	$("#filiere{$id}").val({$id});
	$("#nbnews{$id}").val({$nbnews});
	$("input[name='imgnews{$id}']").filter('[value={$imgnews}]').attr('checked', true);

	$(".closeActuWidget{$id}").click(function(){literal}{{/literal}
		$('#widget{$id} a.edit').css({literal}{{/literal}backgroundPosition: '', width: ''{literal}}{/literal})
		$('#widget{$id} .edit-box').hide();
		$("#widget{$id} .widget-head").removeClass("widget-edit-head");
	{literal}}{/literal});
</script>

{undef $section_id}