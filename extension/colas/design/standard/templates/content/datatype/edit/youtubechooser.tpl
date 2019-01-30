<div class="block youtubedisplay">
	<table cellspacing="0" class="list">
		<tbody>
			<tr id="youtubevideoheaders">
			    <th class="tight">Prévisualisation</th>
			    <th>Date de création</th>
			    <th>Titre</th>
			    <th>Description</th>
			</tr>
			<tr id="youtubenovideo">
			    <td colspan="4">Aucune vidéo sélectionnée</td>
			</tr>
			<tr id="youtubevideorow">
			    <td class="youtubecellpreview"></td>
			    <td class="youtubecelldate"></td>
			    <td class="youtubecelltitle"></td>
			    <td class="youtubecelldescription"></td>
			</tr>
		</tbody>
	</table>
</div>
<div id="youtubebuttonchoose_{$attribute.id}" class="youtubebuttonchoose">
	<input id="youtubechooser_hidden_data_text_{$attribute.id}" type="hidden" name="{$attribute_base}_youtubechooser_data_text_{$attribute.id}" value="{$attribute.content.json|wash( xhtml )}" />
	<input type="submit" value="Choisir une vidéo" id="youtubechooser_button_{$attribute.id}" name="youtubechooser_{$attribute.id}" class="button" onclick="youtube.init();return false;" />
	<input type="submit" value="Supprimer la vidéo" id="youtuberemover_button_{$attribute.id}" name="youtuberemover_{$attribute.id}" class="button-disabled" onclick="javascript:return false;" />
</div>


{def $googleapis = ez5_get_parameter("googleapis")}

<script>
	var youtube_api_request_playlistItems = '{concat($googleapis.api.youtube.url,$googleapis.api.youtube.request.playlistItems,'&key=',$googleapis.key)}';
	var youtube_api_request_videos = '{concat($googleapis.api.youtube.url,$googleapis.api.youtube.request.videos,'&key=',$googleapis.key)}';
	var youtube = new youtubemanager({ldelim}'playlistItemsApiUrl':youtube_api_request_playlistItems,'videosApiUrl':youtube_api_request_videos,'attributeId':'{$attribute.id}'{rdelim});
</script>

{undef $googleapis}