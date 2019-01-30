{def $testNewsletters = fetch('newsletter' , 'newsletter_type_list')}{def $filiere = ''}
{foreach $testNewsletters as $testNewsletter}
	{set $filiere = fetch( 'content', 'object',hash( 'object_id', $testNewsletter.article_pool_object_id, 'sort_by', array('published')))}
	{if $filiere.main_parent_node_id|eq($node.node_id)}

		{def $newsletterId = $testNewsletter.id}
		
	{/if}
{/foreach}

{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}
{def $currentUser = fetch( 'user', 'current_user' )}

<div class="default masterPage">  						  
	
	{include uri="design:blocs/tools.tpl"}

	<h1 class="color2"> {$node.data_map.titre.content} </h1>
	
	<div class="content1">
		<div class="one 	{if and($node.data_map.newsletter_cb.value|eq(0), $node.data_map.rss_cb.value|eq(0)) } full {/if}">
			<div class="boxA">
				<div class="content">
				{attribute_view_gui attribute=$node.data_map.description}
				{if $node.data_map.description_filiere.has_content}
					<a href="{$node.data_map.description_filiere.content.main_node.url_alias}" class="btn-filiere-arrow-left" title="{$node.data_map.intitule_description_filiere.content}">{$node.data_map.intitule_description_filiere.content}</a>
				{/if}
				</div>
			</div>
		</div>
		{if or($node.data_map.newsletter_cb.value|eq(1),$node.data_map.rss_cb.value|eq(1))}
		<div class="two">
			<div class="boxA smallbloc">
				<div class="top">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
				<div class="content">
					<strong class="title">{"sabonner"|i18n("design/bouygues/master")}</strong>
					
					{if $node.data_map.newsletter_cb.value|eq(1)}
					
					{def $lastnewsletter = fetch('content', 'list', hash('parent_node_id', $node.node_id, 'class_filter_type', 'include', 'class_filter_array', array('newsletter_issue'), 'depth', '2', 'limit', 1, 'sort_by', array('published', false()) ))}

					<div class="overview">
						<div class="thumb">
							<img src={concat("pictos/newsletter/small/",$arrCssSubStructure[$node.object.section_id],".gif")|ezimage} alt="" />
						</div>
						<div class="text">
							{if $currentUser.is_logged_in}
							<a href="/profile/yournewsletter/subscribe/{$newsletterId}" onclick="return false;" class="btn-grey-arrow-right newsletter-subscribe">{$node.data_map.intitule_newsletter.content}</a>
							{else}<a href="/profile/yournewsletter/subscribe/{$newsletterId}" onclick="return false;" class="btn-grey-arrow-right UserConnect fromNewsletter" rel="{$node.url_alias|ezurl(no)}">{$node.data_map.intitule_newsletter.content}</a>{/if}
							
							
							{$node.data_map.description_inscription.content}
						</div>
						{if is_set($lastnewsletter.0)}<div class="clear">
								<a href="{concat("/layout/set/newsletter/",$lastnewsletter.0.url_alias)|ezurl(no)}" class="btn-grey-arrow-left" target="_blank">{"last_newsletter"|i18n("design/bouygues/master")}</a>
						</div>{/if}
					</div>
					{/if}
					
					{if $node.data_map.rss_cb.value|eq(1)}
					
					{def $arrRss = ezini( 'Rss', 'RssSection', 'bouygues.ini' )}
					{if is_set($arrRss[$node.object.section_id])}{def $classCss = $arrCssSubStructure[$node.object.section_id]}
					
					<div class="overview">
						<div class="thumb">
							<img src={"pictos/rss.gif"|ezimage} alt="" />
						</div>
						<div class="text">
							<a href="{concat('/static/rss')|ezurl(no)}" class="btn-grey-arrow-right" target="_blank">{$node.data_map.rss_titre.content}</a>
							{$node.data_map.description_flux.content}
						</div>
						<div class="clear">
								<a href="{$arrRss[$node.object.section_id]|ezurl(no)}" class="btn-grey-arrow-left" target="_blank">{"Lire le flux RSS"|i18n("design/bouygues/master")}</a>
						</div>
					</div>
					
					{/if}
					
					{/if}
					
				</div>
				<div class="bottom">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
			</div>
		</div>
		{/if}
	</div>
	{if or($node.data_map.actu_titre.has_content,$node.data_map.actu_contenu.has_content)}
	<div class="content2">
			<div class="boxA">
				<div class="top">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
				<div class="content actu">
				<strong class="title">{$node.data_map.actu_titre.content}</strong>
					<div class="overview">

							{*lien*}
							
								{*$node.data_map.actu_contenu.content|attribute(show,1)*}

								{if $node.data_map.actu_contenu.has_content}
								
										{*def $url=$node.data_map.actu_contenu.content.main_node.url_alias|ezurl(no)*}
										
										{def $child = $node.data_map.actu_contenu.content.main_node}
										
										{if $child.class_identifier|eq('file')}
											{def $url=concat('content/download/',
											$child.data_map.file.contentobject_id, '/',
											$child.data_map.file.id,'/version/',
											$child.data_map.file.version , '/file/',
											$child.data_map.file.content.original_filename|urlencode)|ezurl(no)}
										{elseif $child.class_identifier|eq('newsletter_issue')}
											{def $url=$child.url_alias|ezurl(no)}
											{def $urlTarget='_blank'}
										{elseif $child.class_identifier|eq('link')}
											{def $url=$child.data_map.lien.content|ezurl(no)}
											{def $urlTitle=$child.data_map.lien.data_text}
											{def $urlTarget='_blank'}
										{elseif $child.class_identifier|eq('bouygues_element_liste')|not()}
											{def $url=$child.url_alias|ezurl(no)}
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
									
									{if $node.data_map.actu_intitule_url.has_content}
										{def $textLink=$node.data_map.actu_intitule_url.content}
									{else}
										{def $textLink=$node.data_map.actu_contenu.content.name}
									{/if}
								{elseif $node.data_map.actu_url.has_content}
								
									{def $url=$node.data_map.actu_url.content}
									
									{if $node.data_map.actu_intitule_url.has_content}
										{def $textLink=$node.data_map.actu_intitule_url.content}
									{else}
										{def $textLink=$node.data_map.actu_url.data_text}
									{/if}
									
									{def $target="_blank"}
								{/if}
							
							{*image*}
							
							{if $node.data_map.actu_image.has_content}
							
								{if $node.data_map.actu_image.content.alternative_text}
								 	{def $titreImage=$node.data_map.actu_image.content.alternative_text}
								{else}
								 	{def $titreImage=$node.data_map.actu_titre.content}
							 	{/if}
								<div class="thumb">
									<a href="{$url}" class="image_medium">
										<img src="{$node.data_map.actu_image.content.mediummaster.url|ezroot(no)}" alt="{$titreImage}" border="0"/>
									</a>
								</div>
							{elseif $node.data_map.actu_contenu.content.data_map.image_main.has_content}

							 	{if is_set($node.data_map.actu_image.content.mediummaster.content.alternative_text)}
								 	{def $titreImage=$node.data_map.actu_image.content.mediummaster.content.alternative_text}
								{else}
									{def $titreImage=$node.data_map.actu_contenu.content.name}
								{/if}
								<div class="thumb">
									<a href="{$url}" class="image_medium">
										<img src="{$node.data_map.actu_contenu.content.data_map.image_main.content.mediummaster.url|ezroot(no)}" alt="{$titreImage}"  border="0"/>
									</a>
								</div>
							{elseif $node.data_map.actu_contenu.content.data_map.image_vignette.has_content}

							 	{if $node.data_map.actu_image.content.mediummaster.content.alternative_text}
								 	{def $titreImage=$node.data_map.actu_image.content.mediummaster.content.alternative_text}
								{else}
									{def $titreImage=$node.data_map.actu_contenu.content.name}
								{/if}
								<div class="thumb">
									<a href="{$url}" class="image_medium">
										<img src="{$node.data_map.actu_contenu.content.data_map.image_vignette.content.mediummaster.url|ezroot(no)}" alt="{$titreImage}"  border="0"/>
									</a>
								</div>
							{/if}

						<div class="text">
						<strong class="subTitle color2">
								{if is_set($textLink)}
									<a href="{$url}" {if is_set($target)}target="{$target}"{/if} title="{$textLink}">
								{/if}
								{if $node.data_map.actu_principale.has_content}
									{$node.data_map.actu_principale.content|wash()}
								{elseif $node.data_map.actu_contenu.content.data_map.title.has_content}
									{$node.data_map.actu_contenu.content.data_map.title.content|wash()}
								{elseif $node.data_map.actu_contenu.content.data_map.titre.has_content}
									{$node.data_map.actu_contenu.content.data_map.titre.content|wash()}
								{/if}
								{if is_set($textLink)}
									</a>
								{/if}
							</strong>
							
							{*date*}
							<span class="date">
								{if $node.data_map.actu_date.has_content}
									{$node.data_map.actu_date.data_int|datetime( 'custom', '%d/%m/%Y' )}
								{elseif $node.data_map.actu_contenu.content.data_map.date_pub.has_content}
									{$node.data_map.actu_contenu.content.data_map.date_pub.content.timestamp|datetime( 'custom', '%d/%m/%Y' )}
								{/if}
							</span>
							
							<p>
							{*accroche*}
								{if $node.data_map.actu_accroche.has_content}
									{attribute_view_gui attribute=$node.data_map.actu_accroche}
								{elseif $node.data_map.actu_contenu.content.data_map.accroche_liste.has_content }
									{$node.data_map.actu_contenu.content.data_map.accroche_liste.content.output.output_text}
								{elseif $node.data_map.actu_contenu.content.data_map.intro.has_content }
									{$node.data_map.actu_contenu.content.data_map.intro.content.output.output_text|strip_tags()|shorten(300,'...')}
								{elseif $node.data_map.actu_contenu.content.data_map.chapeau.has_content }
									{$node.data_map.actu_contenu.content.data_map.chapeau.content.output.output_text|strip_tags()|shorten(300,'...')}
								{elseif $node.data_map.actu_contenu.content.data_map.body.has_content }
									{$node.data_map.actu_contenu.content.data_map.body.content.output.output_text|strip_tags()|shorten(300,'...')}
								{elseif $node.data_map.actu_contenu.content.data_map.description.has_content }
									{$node.data_map.actu_contenu.content.data_map.description.content.output.output_text|strip_tags()|shorten(300,'...')}
								{/if}
							
							</p>
			
							{if is_set($textLink)}
							<p><a href="{$url}" class="btn-grey-arrow-left" title="{$textLink}" {if is_set($target)}target="{$target}"{/if}>{$textLink}</a></p>
							{/if}
							
						</div>
					</div>
				</div>
				<div class="bottom">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
			</div>
	</div>
	{undef $url}
	{/if}
	
	<div class="content3">
		<div class="one">
			{include uri="design:blocs/columns/master.tpl" column=0}
		</div>
		<div class="two">
			{include uri="design:blocs/columns/master.tpl" column=1}
		</div>
		<div class="clear">
			{include uri="design:blocs/bouygues_texte_footer.tpl"}
		</div>
	</div>
	
	<div class="content4">
		<strong class="title">{"contact"|i18n("design/bouygues/master")}</strong>
		{attribute_view_gui attribute=$node.data_map.contact}
	</div>
	
</div>

	

{undef}