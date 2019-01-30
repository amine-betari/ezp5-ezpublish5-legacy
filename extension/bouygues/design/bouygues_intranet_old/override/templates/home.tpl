{set-block scope=root variable=cache_ttl}0{/set-block}
{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )
	 $datas = fetch('content','list',hash( 'parent_node_id', $node.node_id,
																  'class_filter_type','include',
																  'class_filter_array',array('bouygues_home_page'),
																  'sort_by', array( array('priority' )),
																  'limit',1
																  ))
	 $lciUrl = ezini( 'LCI', 'Url', 'bouygues.ini' )
	 $serverPath = ezini( 'Instance', 'Chemin', 'site.ini' )
	 $lciLimit = ezini( 'LCI', 'Limit', 'bouygues.ini' )
	 $actu_node_id = ezini('NODE_ID', 'actu_groupe', 'site.ini')
}

{def $currentUser = fetch('user', 'current_user')}

{set-block variable=$bourseOutput}
{def $bourse = fetch('ebyperso', 'ebyperso_bourse')}
{if is_array($bourse)}
	{foreach $bourse as $cot}
		<span class="company">{$cot.nom}</span> <span class="value">{$cot.cotation} €</span>
	{/foreach}
{/if}
{/set-block}

{set-block variable=$lciFeed}
{def $feed = fetch( 'feed', 'parse', hash( 'rss_url', $serverPath|concat($lciUrl) ))}

{if $feed}
		{def $counterRss=0}
        {foreach $feed.item as $item max $lciLimit}
                <span class="rssItem" id="rssItem{$counterRss}">{$item.title.text|wash}</span>
				{set $counterRss=$counterRss|inc()}
        {/foreach}
{/if}
{undef $feed}
{/set-block}
<script type="text/javascript" src={'/extension/bouygues/design/bouygues_intranet/javascript/jquery.ticker.js'}></script>
<div class="default homePage">

	<div class="topHeader">
		<div class="column1">
			<div class="picto"><img src={"pictos/cac.gif"|ezimage} alt="cac40" border="0"/></div>
			<div class="text">
				{$bourseOutput}
			</div>
		</div>
		<div class="column2">
			<div class="picto"><img src={"logos/tf1news.gif"|ezimage} alt="TF1 News" border="0"/></div>
			<div class="text" id="lciCarrousel">
				<div class="mycarousel global">
					<div class="mycarousel container" id="ticker">
						{$lciFeed}
					</div>
				</div>
			{undef $feed}
			</div>

			<div id="lciPagination">
				{def $counter = 0}
				{while ne( $counter, $counterRss )}

				    <a href="#" class="page{if $counter|eq(0)} on{/if}" rel="{inc($counter)}">{inc($counter)}</a>
				    {set $counter=inc( $counter )}

				{/while}
			</div>
			{undef $counter}

		</div>
		<div class="column3">
			<div class="picto"><img src={"logos/metronews.gif"|ezimage} alt="MetroNews" border="0"/></div>
			<div class="text">
				<a href="http://readmetro.metronews.fr/" target="_blank">{"read_the_news"|i18n("design/bouygues/home")}</a>
			</div>
		</div>
	</div>

	{cache-block keys='home-topleft'  ignore_content_expiry expiry=7200 }
	<div class="topLeft">
		<div class="information">
			<div class="top">
				{def $urlPlus = ''}
					{def $mode= ''}
					{def $rub= ''}


					{*actu groupe*}

					{def $numberOfGroupObjects = $datas.0.data_map.element_group_select.class_content.options[$datas.0.data_map.element_group_select.value[0]].name}

					{def $goup_datas = fetch('content','list',hash( 'parent_node_id', $actu_node_id,
									'attribute_filter',array(array('section','=',16)),
									'limit',$numberOfGroupObjects,
									'sort_by', array( array( 'priority',false() ) ) ))}

					{*actu filiere*}

					{def $numberOfFiliereObjects = $datas.0.data_map.element_filiere_select.class_content.options[$datas.0.data_map.element_filiere_select.value[0]].name}

					{def $filieres_datas = fetch('content','list',hash( 'parent_node_id', $actu_node_id,
									'attribute_filter',array(array('section','!=',16)),
									'limit',$numberOfFiliereObjects,
									'sort_by', array( array( 'priority',false() ) ) ))}

					{if is_set($view_parameters.rub)}
						{set $urlPlus = concat('/(rub)/',$view_parameters.rub)}
						{set $rub=$view_parameters.rub}
					{elseif or($goup_datas|count|gt(0)|not,$numberOfGroupObjects|eq(0))}
						{set $rub='filiere'}
					{else}
						{set $rub='groupe'}
					{/if}

					{if is_set($view_parameters.mode)}
						{set $mode=$view_parameters.mode}
					{else}
						{set $mode='image'}
					{/if}


				<strong class="{if or($numberOfGroupObjects|eq(''),$numberOfGroupObjects|eq(false()), $numberOfGroupObjects|eq(0))}title-only-filiere{else}title{/if}">{if or($numberOfGroupObjects|eq(''),$numberOfGroupObjects|eq(false()), $numberOfGroupObjects|eq(0))}{"only_filiere_text"|i18n("design/bouygues/accessibility")}{else}{"text_actu"|i18n("design/bouygues/accessibility")}{/if}</strong>
			{if or($numberOfGroupObjects|eq(''),$numberOfGroupObjects|eq(false()), $numberOfGroupObjects|eq(0))}{else}
				<ul>
					{if and($goup_datas|count|gt(0),$numberOfGroupObjects|gt(0)|gt(0))}
						<li><a href="{concat($node.url_alias,'/(rub)/','groupe')|ezurl(no)}" class="{if $rub|eq('groupe')}on{/if} btn-actu-groupe" onclick="return false;" title="{"group_label"|i18n("design/bouygues/home")}">{"group_label"|i18n("design/bouygues/home")}</a></li>
					{/if}

					{if and($filieres_datas|count|gt(0),$goup_datas|count|gt(0))}
						<li><a href="{concat($node.url_alias,'/(rub)/','filiere')|ezurl(no)}" onclick="return false;" class="{if or($goup_datas|count|gt(0)|not,$rub|eq('filiere'))}on{/if} btn-actu-filiere" title="{"filiere_label"|i18n("design/bouygues/home")}">{"filiere_label"|i18n("design/bouygues/home")}</a></li>
					{/if}

				</ul>
			{/if}
				<div class="tools">
					<a href="{concat($node.url_alias,'/(mode)/','text',$urlPlus)|ezurl(no)}" class="btn-mode-text" onclick="return false;" title="{"btn_mode_texte"|i18n('design/bouygues/accessibility')}"></a>
					<a href="{concat($node.url_alias,'/(mode)/','image',$urlPlus)|ezurl(no)}" class="btn-mode-image-on" onclick="return false;" title="{"btn_mode_image"|i18n('design/bouygues/accessibility')}"></a>
				</div>

			</div>

				{if and($goup_datas|count|gt(0),$numberOfGroupObjects|gt(0))}
				<div class="groupe {if $rub|eq('filiere')}displayNone{/if}">

					<div class="show-mode-image {if or($mode|eq('text'),$rub|eq('filiere') )}displayNone{/if}">
						{include uri="design:home/actu-mode-image.tpl" array=$goup_datas groupe=1}
					</div>

					<div class="show-mode-text {if or($mode|eq('image'),$rub|eq('filiere') )}displayNone{/if}">
						{include uri="design:home/actu-mode-text.tpl" array=$goup_datas groupe=1}
					</div>
				</div>
				{/if}

				{if $filieres_datas|count|gt(0)}

				<div class="filiere {if $rub|eq('groupe')}displayNone{/if}">

					<div class="show-mode-image {if or($mode|eq('text'),$rub|eq('groupe') )}displayNone{/if}">
						{include uri="design:home/actu-mode-image.tpl" array=$filieres_datas}
					</div>

					<div class="show-mode-text {if or($mode|eq('image'),$rub|eq('groupe') )}displayNone{/if}">
						{include uri="design:home/actu-mode-text.tpl" array=$filieres_datas}
					</div>
				</div>
				{/if}


			<div class="bottom">
				<a href="{concat('/static/actu-history/')|ezurl(no)}" class="btn-orange-arrow-left link">{"all_news_label"|i18n("design/bouygues/home")}</a>

				{if eq(ceil(div(count($filieres_datas),3)), div(count($filieres_datas),3))}
				{def $count_actu = div(count($filieres_datas),3)}
				{else}{def $count_actu = ceil(div(count($filieres_datas),3))}{/if}
				<div class="pages {if $rub|eq('groupe')}displayNone{/if}" id="mycarousel-pagination">
					{def $counter = 0}
					{while ne( $counter, $count_actu )}

					    <a href="#" class="page{if $counter|eq(0)} on{/if}" rel="{inc($counter)}">{inc($counter)}</a>
					    {set $counter=inc( $counter )}

					{/while}
				</div>
				{undef $counter}
				{undef $count_actu}

			</div>
		</div>


	</div>
	{/cache-block}
	<div class="topRight">
		<div class="boxes">

		<div class="column1">
			<div class="boxA small first">
				<div class="top">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>

				<div class="content">
							<strong class="title">
							<img src="{concat("images/","uploads/180-40.jpg")|ezdesign(no)}" alt="logo - challenger"/>
							</strong>
							<div class="text">
								{*<p>{$datas.0.data_map.challenger_description.content|wash|shorten(150,'...')}</p>*}
								<span class="date">
									{if $node.object.default_language|eq('fre-FR')}
										{$datas.0.data_map.challenger_date.data_int|datetime('custom','%d %F %Y')|downcase} -  &Agrave; la une  :
									{else}
										{$datas.0.data_map.challenger_date.data_int|datetime('custom','%d')} {$datas.0.data_map.challenger_date.data_int|datetime('custom','%F')}  {$datas.0.data_map.challenger_date.data_int|datetime('custom','%Y')|downcase}  -  News :
									{/if}
								</span>
									<div class="picto">
										<img src={"pictos/read.gif"|ezimage} alt=""/>
									</div>
							<div class="text">
								{def $urlLastChallenger=concat('content/download/',
									$datas.0.data_map.challenger_last.content.main_node.data_map.file.contentobject_id, '/',
									$datas.0.data_map.challenger_last.content.main_node.data_map.file.id,'/version/',
									$datas.0.data_map.challenger_last.content.main_node.data_map.file.version , '/file/',
									$datas.0.data_map.challenger_last.content.main_node.data_map.file.content.original_filename|urlencode)|ezurl(no)}
								<a href="{$urlLastChallenger}" target="_blank">
									{if $datas.0.data_map.challenger_derniere_edition_titre.has_content}
										{$datas.0.data_map.challenger_derniere_edition_titre.content|wash()}
									{else}
										{$datas.0.data_map.challenger_last.content.main_node.name}</a><br/>
									{/if}
								<a href="{$datas.0.data_map.challenger_all.content.main_node.url_alias|ezurl(no)}" class="btn-small-blue" target="_blank">{"challenger_see_all"|i18n("design/bouygues/home")}</a>

							</div>
							</div>
				</div>
				<div class="bottom small">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
			</div>

				<div class="boxA small second">
				<div class="top">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
				<div class="content">
					<strong class="title">{"communique_label"|i18n("design/bouygues/home")}</strong>
					<div class="picto">
						<img src={"pictos/read.gif"|ezimage} alt="" />
					</div>
					<div class="text">
						<a href="{$datas.0.data_map.communique_titre_fichier.content.filepath}" target="_blank">{$datas.0.data_map.communique_titre.content|wash|shorten(150,'...')}</a>
						<br />
						<span class="date">

						{if $node.object.default_language|eq('fre-FR')}
							{$datas.0.data_map.communique_date.data_int|datetime('custom','%d %F %Y')|downcase}
						{else}
							{$datas.0.data_map.communique_date.data_int|datetime('custom','%d')} {$datas.0.data_map.communique_date.data_int|datetime('custom','%F')} {$datas.0.data_map.communique_date.data_int|datetime('custom','%Y')|downcase}
						{/if}

						</span>
					</div>
					<a href="{$datas.0.data_map.communique_url.content|ezurl(no)}" class="btn-small-blue" target="_blank">{"communique_see_all"|i18n("design/bouygues/home")}</a>
				</div>
				<div class="bottom">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
			</div>
		</div>
		<div class="column2">

			<div class="boxA large first">
				<div class="top">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
				<div class="content">
						<strong class="title">{"group_library"|i18n("design/bouygues/home")}</strong>
						<div class="overview">
							{def $bibliotheque_liens = $datas.0.data_map.bibliotheque_liens.content.relation_list}
							<ul>
								{foreach $bibliotheque_liens as $bibliotheque_lien}

									{def $data = fetch( 'content', 'node', hash('node_id', $bibliotheque_lien.node_id ))}

										{if $data.class_identifier|eq('file')}
											{def $url=concat('content/download/',
											$data.data_map.file.contentobject_id, '/',
											$data.data_map.file.id,'/version/',
											$data.data_map.file.version , '/file/',
											$data.data_map.file.content.original_filename|urlencode)|ezurl(no)}
										{elseif $data.class_identifier|eq('newsletter_issue')}
											{def $url=concat('newsletter/previewfull/',
											$data.contentobject_id, '/',
											$data.contentobject_version)|ezurl(no)}
											{def $urlTarget='_blank'}
										{elseif $data.class_identifier|eq('link')}
											{def $url=$child.data_map.lien.content|ezurl(no)}
											{def $urlTitle=$child.data_map.lien.data_text}
											{def $urlTarget='_blank'}
										{elseif $data.class_identifier|eq('bouygues_element_liste')|not()}
											{if $data.url_alias}
												{def $url=$data.url_alias|ezurl(no)}
											{else}
												{def $url=$data.main_node.url_alias|ezurl(no)}
											{/if}
										{elseif and($data.class_identifier|eq('bouygues_element_liste'),or($data.data_map.lien_eby.has_content, $data.data_map.lien_ext.has_content))}
											{if $data.data_map.lien_eby.has_content}
												{def $url=$data.data_map.lien_eby.value.main_node.url_alias|ezurl(no)}
											{elseif $data.data_map.lien_ext.has_content}
												{def $url=$data.data_map.lien_ext.content|ezurl(no)}
												{def $urlTitle=$data.data_map.lien_ext.data_text}
												{def $urlTarget='_blank'}
											{else}{def $url = ''}{/if}
										{else}{def $url = '#'}
										{/if}

									<li><a href="{$url}" title="{if is_set($urlTitle)}{$urlTitle}{else}{$data.name}{/if}" {if is_set($urlTarget)}target="{$urlTarget}"{/if}  >{$data.name|shorten(100,0)}</a></li>

								{undef $data $urlTarget $url}
								{/foreach}
							</ul>
						</div>
				</div>
				<div class="bottom">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
			</div>

			<div class="boxA large second">
				<div class="top">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
				<div class="content orange">
						<strong class="title">{"i_subscribe"|i18n("design/bouygues/home")}</strong>
						<ul>
							<li><a href="{if $currentUser.is_logged_in}{'/profile/yournewsletter'|ezurl(no)}{else}{'/static/newsletter'|ezurl(no)}{/if}">{"i_subscribe_eby"|i18n("design/bouygues/home")}</a></li>
							<li><a href="{concat('/static/rss')|ezurl(no)}">{"i_subscribe_rss"|i18n("design/bouygues/home")}</a></li>
							{if $datas.0.data_map.lien_annuaire_pda_imode.has_content}
								<li><a href="{$datas.0.data_map.lien_annuaire_pda_imode.content.main_node.url_alias|ezurl(no)}">{if $datas.0.data_map.titre_lien_annuaire_pda_imode.has_content}{$datas.0.data_map.titre_lien_annuaire_pda_imode.content}{else}{$datas.0.data_map.lien_annuaire_pda_imode.content.name|shorten(15,'...')}{/if}</a></li>
							{/if}
						</ul>
				</div>
				<div class="bottom">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
			</div>

			<div class="small_block" {* Mantis 9310 -- onclick="window.open('{$datas.0.data_map.small_block_lien.content|ezurl(no)}','_blank')" *} >
				{if $datas.0.data_map.small_block_image.has_content}<div class="thumb">{if $datas.0.data_map.small_block_lien.has_content}<a href="{$datas.0.data_map.small_block_lien.content|ezurl(no)}" target="_blank">{/if}<img src="{$datas.0.data_map.small_block_image.content.home_small_block.url|ezroot(no)}" border="0" alt="{$datas.0.data_map.small_block_description.content}"/>{if $datas.0.data_map.small_block_lien.has_content}</a>{/if}</div>{/if}
				{if $datas.0.data_map.small_block_description.has_content}<div class="description">{if $datas.0.data_map.small_block_lien.has_content}<a href="{$datas.0.data_map.small_block_lien.content|ezurl(no)}" target="_blank">{/if}{$datas.0.data_map.small_block_description.content}{if $datas.0.data_map.small_block_lien.has_content}</a>{/if}</div>{/if}
			</div>

		</div>


		</div>



	</div>
	<div class="clear">
		<div class="column1">
			<strong class="title">{$datas.0.data_map.media_titre.content}</strong>
						{cache-block keys=array( $extra_cache_key, $datas.0.data_map.media_titre.content )}
						<div class="medias">
							{def $medias = fetch('content', 'list', hash(
												'parent_node_id', $datas.0.node_id,
												'class_filter_type','include',
							  					'class_filter_array', array('bouygues_home_media'),
												'limit', 7,
												'sort_by', array(array('priority')),
												'limitation', array()
												))}

							{if count($medias)|gt(0)}
								{def $langPage=''}
								{if and(is_set($datas.0.object.all_languages.eng-US),$datas.0.object.default_language|eq('eng-US'))}{set $langPage='_en/'}{/if}
							{literal}
							<script language="JavaScript" type="text/javascript">

							/*
							* Vide la liste des appel js
							*/
							function clearEventList(){
								$('#calledFromFlash').html('')
							}

							var refreshFlash = function() {
							    $('#flash').empty();
								$('#flash').flash(
									{
										src: '/extension/bouygues/design/bouygues_intranet/swf/coverflow.swf',
										width: 332,
										height: 138,
										quality: 'high',
										allowScriptAccess: 'always',
										allowFullScreen:'true',
										bgColor:'FFFFFF',
										wmode: 'transparent',
										flashvars: {
											allowFullScreen:'true',
											transition: 2000,
											wait: 2000,
											autoplay: 0,
											xmlFeed: '{/literal}<?xml version="1.0" encoding="utf-8"?><covers>{foreach $medias as $data}{if $data.data_map.lien_eby.has_content}{def $media = $data.data_map.lien_eby.content}{def $mediaUrl=$data.data_map.lien_eby.value.main_node.url_alias|ezurl(no)}{elseif $data.data_map.lien_ext.has_content}{def $mediaUrl=$data.data_map.lien_ext.content|ezurl(no)}{else}{def $mediaUrl=''}{/if}{if $data.data_map.vignette_text_charte_color.content|eq(1)}{def $typeVignette=''}{else}{def $typeVignette='_light'}{/if}<cover><img><![CDATA[{if $data.data_map.vignette.has_content}{$data.data_map.vignette.content.home_blocmedia.url|ezroot(no)}{else}{concat("images/","home/",$arrCssSubStructure[$data.object.section_id],'.jpg')|ezdesign(no)}{/if}]]></img><title><![CDATA[{if $data.data_map.type.has_content}{$data.data_map.type.content|upcase()|addslashes()} | {/if}{if $data.data_map.titre.has_content}{$data.data_map.titre.content|upcase()|addslashes()}{else}{$data.name|shorten(40,'...')|upcase()|addslashes()}{/if}]]></title><url{if $data.data_map.lien_ext.has_content} target="_blank"{/if}><![CDATA[{$mediaUrl}]]></url><img2><![CDATA[{if $data.data_map.lien_eby.has_content}{concat("images/","pictos/media/", $langPage ,$arrCssSubStructure[$data.data_map.lien_eby.value.section_id],$typeVignette,'.png')|ezdesign(no)}{/if}]]></img2></cover>{undef $data $media $mediaUrl}{/foreach}</covers>{literal}'
										}
									},
									{ version: 9 }
								);
							}

							$(document).ready(function(){
							    refreshFlash();
							});
							</script>
							{/literal}

							<div id="flash" class="hideFlashLB"></div>
							<div id="flashAternative" style="display: none">

								<div class="bckimage">

													<div class="carousel">


														{foreach $medias as $data}
															{if $data.data_map.lien_eby.has_content}
																{def $media = $data.data_map.lien_eby.content}
																{def $mediaUrl=$data.data_map.lien_eby.value.main_node.url_alias|ezurl(no)}
															{elseif $data.data_map.lien_ext.has_content}{def $mediaUrl=$data.data_map.lien_ext.content|ezurl(no)}
															{else}{def $mediaUrl=''}{/if}{if $data.data_map.vignette_text_charte_color.content|eq(1)}{def $typeVignette=''}{else}{def $typeVignette='_light'}
															{/if}

															<div class="media-item">
																<div class="image">
																	<a href="" class="mediaPlay"></a>
																	<a href="{$mediaUrl}" >

																		<img src="{if $data.data_map.vignette.has_content}{$data.data_map.vignette.content.home_blocmedia.url|ezroot(no)}{else}{concat("images/","home/",$arrCssSubStructure[$data.object.section_id],'.jpg')|ezdesign(no)}{/if}"  alt="{$data.name}" title="{$data.name}"/>

																	</a>
																</div>

																<span class="type_titre">{if $data.data_map.type.has_content}{$data.data_map.type.content|upcase()|addslashes()} | {/if}{if $data.data_map.titre.has_content}{$data.data_map.titre.content|upcase()|addslashes()}{else}{$data.name|shorten(40,'...')|upcase()|addslashes()}{/if}</span>


															{undef $data}
															</div>
														{/foreach}



													</div>
								</div>

							</div>

							{/if}
							{/cache-block}
						</div>
            <a href={"videos"|ezurl()} class="btn-small-blue">{"access_video"|i18n("design/bouygues/home")}</a>
		</div>
		<div class="column3">
			{if $datas.0.data_map.sondage_display.value|eq(1)}
				<div id="sondage-ajax-content">
				{include uri="design:home/sondage.tpl" current_language=$node.object.default_language}
				</div>
			{else}
			<strong class="title">{"nomination"|i18n("design/bouygues/home")}</strong>
			{def $url = $datas.0.data_map.nomination_lien_interne.content.main_node.parent.url_alias}
			<p>
				{$datas.0.data_map.nomination_description.content}
			</p>
			<span class="date">
				{"nomination_date"|i18n("design/bouygues/home")} :

				{if $node.object.default_language|eq('fre-FR')}
					{$datas.0.data_map.nomination_date.data_int|datetime('custom','%d %F %Y')|downcase}
				{else}
					{$datas.0.data_map.nomination_date.data_int|datetime('custom','%d')} {$datas.0.data_map.nomination_date.data_int|datetime('custom','%F')} {$datas.0.data_map.nomination_date.data_int|datetime('custom','%Y')|downcase}
				{/if}
			</span>
			<br />

			{def $nomination_lien_interne = $datas.0.data_map.nomination_lien_interne.content.main_node}
			{def $nomination_lien_interne_download = concat('content/download/',
															$nomination_lien_interne.data_map.file.contentobject_id, '/',
															$nomination_lien_interne.data_map.file.id,'/version/',
															$nomination_lien_interne.data_map.file.version , '/file/',
															$nomination_lien_interne.data_map.file.content.original_filename|urlencode)|ezurl(no)}




			<a href={concat($datas.0.data_map.nomination_lien_interne.content.main_node.parent.url, '#v_', $datas.0.data_map.nomination_lien_interne.content.main_node.node_id)|ezurl()}>{$datas.0.data_map.nomination_lien_interne.content.main_node.name}</a>
			{/if}
			<br/><br/>
			<a href="{$url}" class="btn-small-blue" title="{"nomination_see_all"|i18n("design/bouygues/home")}" />{"read_more"|i18n("design/bouygues/home")}</a>

		</div>
		<div class="column2">
			<strong class="title">{$datas.0.data_map.evenement_titre.content|shorten(45,'...')}</strong>
				{def $url=''}
				{if $datas.0.data_map.evenement_lien_interne.has_content}
					{set $url = $datas.0.data_map.evenement_lien_interne.content.main_node.url_alias}
				{elseif $datas.0.data_map.evenement_lien_externe.has_content}
					{set $url = $datas.0.data_map.evenement_lien_externe.content}
				{/if}

			<div class="image">
				<a href="{$url|ezurl(no)}" {if $datas.0.data_map.evenement_type_de_lien.value.0|eq(1)} target="_blank" {/if} >
					<img src="{$datas.0.data_map.evenement_image.content.home_blocevenement.url|ezroot(no)}" alt="{$datas.0.data_map.evenement_balise_alt.content}" title="{$datas.0.data_map.evenement_balise_title.content}" border="0" />
				</a>
			</div>
			{undef $url}
		</div>
	</div>
</div>

{undef $datas $medias}

{literal}
<script language="JavaScript" type="text/javascript">
	$().ready(function(){
		eby.isHome = true;
		$('html').css('font-size', 16);

		$('#rssItem0').fadeIn();
		
		var rssTickerCurrent = 1;
		var rssTickerPast = 0;
		var rssCount = $('#ticker .rssItem').length - 1;
		var timerRssTicker = '';


		function playTicker(){
	   		timerRssTicker = setTimeout(function(){

	   			$('#rssItem'+rssTickerPast).fadeOut(function(){
					$('#rssItem'+rssTickerCurrent).fadeIn(function(){
						if(rssCount > rssTickerCurrent){
							rssTickerPast = rssTickerCurrent;
		   					rssTickerCurrent = rssTickerCurrent+1;
		   				}else{
		   					rssTickerPast = rssCount;
							rssTickerCurrent = 0;
						}
					});
				});


				playTicker();
	   		}, '7000');
		}
		playTicker();
	
		

		if($('.filiere').css('display') != 'none') {
			var nbElementsDisplay = 3;
			var enablePager = $("#carousel-actu .item").length >  nbElementsDisplay;
			slideMajesActuFiliere = $("#carousel-actu").slideMajes( {
				numElementDisplayed: nbElementsDisplay,
				controls: false,
				pagination: enablePager,
				paginationId: 'mycarousel-pagination',
				timePlay: '10000'
			} );
		};

	});

</script>
{/literal}