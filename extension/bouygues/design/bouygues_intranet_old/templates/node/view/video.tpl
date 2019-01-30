{* Video - Full view *}
<div class="default diaporama post">
		
		{if and(is_unset($lightbox), is_unset($includemode), is_unset($parent))}
			{include uri="design:blocs/tools.tpl"}
		{/if}
			
			
        <h1>{$node.name|wash()}</h1>
        
   		{if and(is_unset($lightbox), is_unset($include_mode), eq($node.class_identifier, 'bouygues_galerie_vid'))}
        <h2>{$node.data_map.sous_titre.content|wash()}</h2>
        <div class="intro-video">
        	{$node.data_map.description.content.output.output_text}
        </div>
        {/if}
        
        {if eq($node.class_identifier, 'bouygues_galerie_vid')}
			{def $children = fetch( 'content', 'list',hash( 'parent_node_id', $node.node_id,
	      						  'class_filter_type',  'include',
	      						  'class_filter_array', array( 'bouygues_video'),
	      						  'sort_by', array( array( 'priority' ) ) ))}
      		
	      	{if is_set($nodeid)}{def $currentVideo = fetch( 'content', 'node',hash( 'node_id', $nodeid))}{/if}
		
			{def $i=0}			
	        {foreach $children as $child }
			{if and(is_unset($currentVideo), eq($i,0))}{def $currentVideo = $child}{/if}{set $i=inc($i)}
			{/foreach}
       	{else}
        	{def $currentVideo = $node}
        {/if}
        {def $numElementDisplayed = 4}
        
        <div id="video">
			<div class="col1">
				
				{if eq($currentVideo.data_map.video_wat.content.display, '')}
					
					{def $instance = ezini( 'Instance', 'Serveur', 'site.ini' )}
					
					{if $instance|eq('preprod')}{def $servId=ezini( 'IPEDIS', 'preprod', 'bouygues.ini' )}
					{elseif $instance|eq('prod')}{def $servId=ezini( 'IPEDIS', 'prod', 'bouygues.ini' )}
					{else}{def $servId=ezini( 'IPEDIS', 'integ', 'bouygues.ini' )}{/if}
					
					{def $autoplay='false' $langPlayer='FRA' $versionPlayer='light' $transcriptUrl='' $first_image=''}
					
					{if and(is_set($node.object.all_languages.eng-US),$node.object.default_language|eq('eng-US'))}{set $langPlayer='ANG'}{/if}
					
					{if $currentVideo.data_map.autoplay.content|eq(1)}{set $autoplay='true'}{/if}
					{if $currentVideo.data_map.transcript.has_content|eq(1)}{set $transcriptUrl=concat('content/download/',
																						$currentVideo.data_map.transcript.contentobject_id, '/',
																						$currentVideo.data_map.transcript.id,'/version/',
																						$currentVideo.data_map.transcript.version , '/file/',
																					$currentVideo.data_map.transcript.content.original_filename|urlencode)|ezurl(no) $versionPlayer='subtitled'}{/if}
					{if $currentVideo.data_map.first_image.has_content}{set $first_image=$currentVideo.data_map.first_image.content.video_image.url|ezroot(no)}{else}{set $first_image=concat('images/videos/default/background.jpg')|ezdesign(no)}{/if}
					{literal}
					
					<script type="text/javascript">
			            var flashvars = {{/literal}
			                servId:'{$servId}',
							xmlBulleURL : '/extension/bouygues/design/bouygues_intranet/swf/players/XML/Bulle.xml',
							xmlAccessibilityURL : '/extension/bouygues/design/bouygues_intranet/swf/players/XML/Accessibility.xml',
							xmlAideURL : '/extension/bouygues/design/bouygues_intranet/swf/players/XML/Aide.xml',{if $versionPlayer|eq('subtitled')}
							VideoImgURL : '{$first_image}',
							VideoAutorun : '{$autoplay}',
			                VideoURL_ST : '/{$currentVideo.data_map.video.content.filepath}',
			                PlayerLang : '{$langPlayer}',
			                VideoSizeWidth : '{$currentVideo.data_map.video_width.content}',
			                VideoSizeHeight : '{$currentVideo.data_map.video_height.content}',
							TranscriptURL : '{$transcriptUrl}',
							sizePDF : '{$currentVideo.data_map.video.content.filesize}Ko'{else}
							videoImgURL : '{$first_image}',
							videoAutorun : '{$autoplay}',
			                videoURL_ST : '/{$currentVideo.data_map.video.content.filepath}',
			                playerLang : '{$langPlayer}',
			                videoSizeWidth : '{$currentVideo.data_map.video_width.content}',
			                videoSizeHeight : '{$currentVideo.data_map.video_height.content}'{/if}		
			            {literal}};
			            var params = {	
			                allowScriptAccess : 'always',
			                allowFullScreen : 'true',
			                scale : 'noscale',
			                bgcolor : '#FFFFFF',
							wmode : 'window',
			                salign : 'lt'
			            };
			            var attributes = {
			                id : 'Player Bouygues',
			                name : 'Player Bouygues'
			            };
						{/literal}
			            swfobject.embedSWF("/extension/bouygues/design/bouygues_intranet/swf/players/{$versionPlayer}/BouyguesPlayer.swf", "divFlash", "630", "434", "9.0.0", "expressInstall.swf", flashvars, params, attributes);  {literal}
			        </script>
					
					{/literal}
					<div id="divFlash">
			            <p>Le flash ne peut &ecirc;tre affich&eacute;. Allez sur le <a href="http://get.adobe.com/fr/flashplayer/">site d'Adobe et t&eacute;l&eacute;chargez le plugin flash</a> pour votre navigateur.</p>
			        </div>
		        {else}
		        	<iframe name="watvideo" id="watvideo" frameborder="0" src="{$currentVideo.data_map.video_wat.content.display|explode('http:')|implode('')|explode('?')|implode('#')}" width="640" height="360" style="border: none;"></iframe>
		        {/if}
			</div>
			
			<div class="col2">
				{if eq($node.class_identifier, 'bouygues_galerie_vid')}
				<div id="vid_carousel">
					<div class="mycarousel slide-prev"></div>
					<div class="mycarousel global">
					
						<div class="mycarousel container">	
							{def $i=1 $numpageslide=1}
							{foreach $children as $child }
							<div class="item carouselItem">
								{if $child.node_id|eq($currentVideo.node_id)|not()}
									{if and(is_unset($include_mode),is_unset($parent))}
									<a href="{$node.url_alias|ezurl(no)}/(nodeid)/{$child.node_id}">
									{else}
									<a href="{$node.parent.url_alias|ezurl(no)}{if is_set($currentOffset)}/(subFileId)/{$currentOffset}{/if}/(nodeid)/{$child.node_id}{if is_set($ancre)}/#v_{$ancre}{/if}">
									{/if}
								{/if}
								<span class="item_small {if $child.node_id|eq($currentVideo.node_id)}{def $gotopage=$numpageslide}on{/if}"></span>
								<img src="{if eq($child.data_map.video_wat.content.display, '')}{if $child.data_map.video_vignette.has_content}{$child.data_map.video_vignette.content.thumbvideo.url|ezroot(no)}{else}{concat('/extension/bouygues/design/bouygues_intranet/images/pictos/video.gif')|ezroot(no)}{/if}{else}{$child.data_map.video_wat.content.thumb_medium}{/if}" title="{$child.data_map.titre.content}" alt="{$child.data_map.titre.content}" style="height: 98px; width: 127px;" />
								<span class="desc">{$child.data_map.titre.content}</span>
								{if $child.node_id|eq($currentVideo.node_id)|not()}
								</a>
								{/if}
							</div>
							{if $i|mod($numElementDisplayed)|eq(0)}{set $numpageslide=$numpageslide|inc()}{/if}
							{set $i=inc($i)}
							{/foreach}
						</div>
					
					</div>
					<div class="mycarousel slide-next"></div>
				</div>
				{else}
					{if eq($node.class_identifier, 'bouygues_galerie_vid')}
			        <h2>{$node.data_map.sous_titre.content|wash()}</h2>
			        {/if}
			        {$node.data_map.description.content.output.output_text}
					
				{/if}
			</div> 
		</div>

		{if eq($node.class_identifier, 'bouygues_galerie_vid')}
		<h4>{$currentVideo.data_map.titre.content}</h4>
		
		{$currentVideo.data_map.description.content.output.output_text}	
		{/if}
		
		<div class="user colorDefault1">
	
			{if $currentVideo.data_map.auteur.has_content}<em>{attribute_view_gui attribute=$currentVideo.data_map.auteur}</em>{/if}{if and($currentVideo.data_map.auteur.has_content,$currentVideo.data_map.date_pub_cb.value|eq(1))} - {/if}{if $currentVideo.data_map.date_pub_cb.value|eq(1)}{"published"|i18n("design/bouygues/dossier")} {$currentVideo.data_map.date_pub.data_int|datetime( 'custom', '%d/%m/%Y %H:%i' )}{/if}
		
		</div>

		
	   {literal}
       <script type="text/javascript">
		$().ready(function(){
			$('#vid_carousel').slideMajes({'numElementDisplayed':'{/literal}{$numElementDisplayed}{literal}', 'includeMargin':true, 'gotopage':'{/literal}{$gotopage}{literal}'});			
		});
		</script>
		{/literal}
 </div>
        
	<div class="plus">		
		{if and($node.data_map.enable_comments.value|eq(1),is_unset($include_mode))}
			{include uri="design:blocs/comments.tpl"}
		{/if}
	</div>
        


{undef $currentVideo $autoplay $langPlayer $versionPlayer $transcriptUrl $first_image}
{undef $i}
{undef $children}