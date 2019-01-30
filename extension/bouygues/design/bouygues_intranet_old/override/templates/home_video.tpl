{def $filiere_node_id = 2}
{def $tri = array('published', 0)}
{def $mode_tri = 'date_desc'}

{if is_set($view_parameters.filiere)}{set $filiere_node_id = $view_parameters.filiere}{/if}
{if is_set($view_parameters.tri)}
	{set $mode_tri = $view_parameters.tri }
	{if eq($view_parameters.tri, 'date_desc')}{set $tri = array('published', 0)}{/if}
	{if eq($view_parameters.tri, 'date_asc')}{set $tri = array('published', 1)}{/if}
	{if eq($view_parameters.tri, 'alpha_asc')}{set $tri = array('name', 1)}{/if}
	{if eq($view_parameters.tri, 'alpha_desc')}{set $tri = array('name', 0)}{/if}
{/if}

{def $filieres = fetch( 'content', 'list',	 hash( 	'parent_node_id', 2,
                              'sort_by',        array( 'name', false() ),
                              'class_filter_type',  'include',
                              'class_filter_array', array( 'bouygues_master_page' )

                                      ) )}


{def $limit = 12}
{def $offset = 0}
{if is_set($view_parameters.offset)}{set $offset = $view_parameters.offset}{/if}

{def $videos_count = fetch( 'content', 'tree_count', hash( 	'parent_node_id',  $filiere_node_id,
                              'class_filter_type',  'include',
                              'main_node_only', true(),
                              'attribute_filter' , array( array( 'bouygues_video/do_not_display_in_video_homepage', '=', 0)),
                              'class_filter_array', array( 'bouygues_video'),
               ) )}


{def $videos = fetch( 'content', 'tree',	 hash( 	'parent_node_id', $filiere_node_id,
                              'sort_by',        array( 'published', false() ),
                              'class_filter_type',  'include',
                              'sort_by',  $tri,
                              'main_node_only', true(),
                              'attribute_filter' , array( array( 'bouygues_video/do_not_display_in_video_homepage', '=', 0)),
                              'class_filter_array', array( 'bouygues_video' ),
                              'limit', $limit,
                              'offset', $offset
                                      ) )}

{literal}
<script language="JavaScript" type="text/javascript">
<!--
function video_url()
{


	var url = {/literal}{$node.url|ezurl()}{literal}

	var filiere = $('#filterFiliere option:selected').val();
	var tri = $('#filterMode option:selected').val();

	var redirect_url = url + '/(filiere)/'+ filiere + '/(tri)/' + tri;

	window.location.replace(redirect_url);
}
//-->
</script>
{/literal}


            <div class="default list">
              <div class="tools">
                <div class="box">
                  <div class="information">
                    <a href="#" class="decreaseFont" onclick="return false" title="{'tools_decrease_font'|i18n('design/bouygues/accessibility')}"></a>
                    <a href="#" class="increaseFont" onclick="return false" title="{'tools_increase_font'|i18n('design/bouygues/accessibility')}"></a><br />
                    <a href={""|ezurl()}  class="btn"    >
                      <span class="leftBtn">&nbsp;</span> <span class="labelBtn ">{'back_to_homepage'|i18n('extension/bouygues/homevideo')}</span> <span class="rightBtn">&nbsp;</span> </a> </div>
                </div>
              </div>


             <h1>{"eby_portal_video" |i18n("extension/bouygues/homevideo")}</h1>

              <p>{'access_video'|i18n('extension/bouygues/homevideo')}</p>
              <div class="content2">
                  <div class="filterVideos">
                    <span class="rndL"></span><span class="rndR"></span>
                    <p class="col1">
                      <label for="filterFiliere">{'channels'|i18n('extension/bouygues/homevideo')} : </label>
                      <select id="filterFiliere" >
                        <option value="2">{'all_channels'|i18n('extension/bouygues/homevideo')}</option>
						{def $nb_videos = 0}
                        {foreach $filieres as $filiere}
                        	{set $nb_videos = fetch( 'content', 'tree_count', hash( 	'parent_node_id',  $filiere.node_id,  'class_filter_type',  'include', 'class_filter_array', array( 'bouygues_video') , 'attribute_filter' , array( array( 'bouygues_video/do_not_display_in_video_homepage', '=', 0)) ) )}
                        	{if ne( $nb_videos  , 0 )}
	                           <option value="{$filiere.node_id}" {if eq($filiere_node_id, $filiere.node_id)} selected=selected {/if} >{$filiere.name}</option>
                        	{/if}

                        {/foreach}
                      </select>
                    </p>
                    <p class="col2">
                      <label for="filterMode">{'sort_by'|i18n('extension/bouygues/homevideo')} : </label>
                      <select id="filterMode" >
                        <option value="date_desc" {if eq($mode_tri, 'date_desc')} selected=selected {/if}>{'most_recent'|i18n('extension/bouygues/homevideo')} </option>
                        <option value="date_asc" {if eq($mode_tri, 'date_asc')} selected=selected {/if}>{'oldest'|i18n('extension/bouygues/homevideo')} </option>
                        <option value="alpha_asc" {if eq($mode_tri, 'alpha_asc')} selected=selected {/if}>A -&gt; Z</option>
                        <option value="alpha_desc" {if eq($mode_tri, 'alpha_desc')} selected=selected {/if}>Z -&gt; A</option>
                      </select>
                    </p>
 					<p class="col2" >
						<a class="homeVideoBtn" href="javascript:void(null);" onclick='video_url();'>&nbsp;
						</a>
					</p>
                  </div>

                <ul id="listVideos">

					{foreach $videos as $key => $video}

				          <li class="{$video.path.1.path_identification_string} {if eq( inc($key)|mod(4) ,0)} last {/if}">
		                    <a href={$video.url|ezurl()}>
		                    <span class="videoCat">{$video.path.1.name}</span>
		                    {if eq($video.data_map.video_wat.content.display, '')}
			                    {if $video.data_map.video_vignette.has_content}
									{attribute_view_gui attribute=$video.data_map.video_vignette image_class=mediummaster}
			                    {else}
									{attribute_view_gui attribute=$video.data_map.first_image image_class=mediummaster}
			                    {/if}
			                {else}
			                	<img width="214" border="0" height="119" title="{$video.data_map.titre.content}" alt="{$video.data_map.titre.content}" src="{$video.data_map.video_wat.content.thumb_normal}" />
			                {/if}
		                    </a>
		                    <h2 class="videoTitle">{$video.name}</h2>
		                    <p class="videoDetails">{$video.data_map.accroche_liste.content.output.output_text|strip_tags|shorten(50)}<br />
		                    {if $node.object.default_language|eq('fre-FR')}{$video.data_map.date_pub.data_int|datetime('custom','%l %d %F %Y')|downcase}{else}{$video.data_map.date_pub.data_int|datetime('custom','%l %d')} {$video.data_map.date_pub.data_int|datetime('custom','%F')} {$video.data_map.date_pub.data_int|datetime('custom','%Y')|downcase}{/if}
		                    </p>
		                  </li>
					{/foreach}


                </ul>

                <div class="clear"></div>
              </div>
</div>
		{include
			name=navigator
			uri='design:navigator/google.tpl'
			page_uri=$node.url
			item_count=$videos_count
			view_parameters=$view_parameters
			item_limit=$limit
			page=$view_parameters.offset|div($videos_count)|inc()
		}




