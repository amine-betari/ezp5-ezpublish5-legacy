{default attribute_base='ContentObjectAttribute'}
{let attribute_content=$attribute.content}
{* Current image. *}
<div class="block">
<label>{'Current image'|i18n( 'design/standard/content/datatype' )}:</label>
{section show=$attribute_content.original.is_valid}

<table cellspacing="0">
<tr>
    <th ><!--{'Preview'|i18n( 'design/standard/content/datatype' )}--></th>
<!--    
<th>{'Filename'|i18n( 'design/standard/content/datatype' )}</th>
    <th>{'MIME type'|i18n( 'design/standard/content/datatype' )}</th>
    <th>{'Size'|i18n( 'design/standard/content/datatype' )}</th>
-->
</tr>
<tr>
    <td>{attribute_view_gui image_class='whoswho_user' attribute=$attribute}</td>
<!--    
<td>{$attribute.content.original.original_filename|wash( xhtml )}</td>
    <td>{$attribute.content.original.mime_type|wash( xhtml )}</td>
    <td>{$attribute.content.original.filesize|si( byte )}</td>
-->
</tr>
</table>
{section-else}
<p>{'There is no image file.'|i18n( 'design/standard/content/datatype' )}</p>
{/section}
{*section show=$attribute_content.original.is_valid}
<!--
<input class="button" type="submit" name="ActionButtonDeleteImage" value="{'Remove image'|i18n( 'design/standard/content/datatype' )}" />
{section-else}
<input class="button-disabled" type="submit" name="ActionButtonDeleteImage" value="{'Remove image'|i18n( 'design/standard/content/datatype' )}" disabled="disabled" />
-->
{/section*}
</div>

{* New image file for upload. *}
<div class="block">
    <input type="hidden" name="MAX_FILE_SIZE" value="{$attribute.contentclass_attribute.data_int1|mul( 1024, 1024 )}" />
    <label>{'New image file for upload'|i18n( 'design/standard/content/datatype' )}:</label><br/>
    <input name="{$attribute.contentclass_attribute_identifier}" type="file" />
</div>
{/let}
{/default}


