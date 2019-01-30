<div class="block watdisplay">
	<table cellspacing="0" class="list">
		<tbody>
			<tr>
			    <th class="tight">Prévisualisation</th>
			    <th>Date de création</th>
			    <th>Nom du fichier</th>
			</tr>
			<tr id="watnovideo">
			    <td colspan="3">Aucune vidéo sélectionnée</td>
			</tr>
			<tr id="watvideorow">
			    <td class="watcellpreview"></td>
			    <td class="watcelldate"></td>
			    <td class="watcellname"></td>
			</tr>
		</tbody>
	</table>
</div>
<div class="watbuttonchoose">
	<input id="watchooser_hidden_data_text_{$attribute.id}" type="hidden" name="{$attribute_base}_watchooser_data_text_{$attribute.id}" value="{$attribute.content.json|wash( xhtml )}" />
	<input type="submit" value="Choisir une vidéo" id="watchooser_button_{$attribute.id}" name="watchooser_{$attribute.id}" class="button" onclick="wat.init();return false;" />
</div>

<script>
	var wat = new watmanager('{$attribute.id}');
</script>