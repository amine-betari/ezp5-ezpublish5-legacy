<form id="form-comment" enctype="multipart/form-data" method="post" action={concat( "/content/edit/", $object.id, "/", $edit_version, "/", $edit_language|not|choose( concat( $edit_language, "/" ), '' ) )|ezurl}>

    {include uri="design:content/edit_validation.tpl"}

    <div class="block">
     {let attribute=$object.data_map.subject}
       <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
       <input type="hidden" name="ContentObjectAttribute_ezstring_data_text_{$attribute.id}" value="commentaire n°{$object.id}" />
       {/let}
    {let user=fetch( user, current_user )
         attribute=$object.data_map.author}
    <input type="hidden" name="ContentObjectAttribute_ezstring_data_text_{$attribute.id}" value="{$user.contentobject.name|wash}" />
     {/let}
       {let attribute=$object.data_map.message}
       <label for="{$attribute.id}">{$attribute.contentclass_attribute.name}</label> <label for="ContentObjectAttribute_data_text_{$attribute.id}" class="error displayNone" style="clear: both; display: none">{"no_content"|i18n("design/bouygues/comment")}</label><br />
       <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
       <textarea class="required box" title="{"no_content"|i18n("design/bouygues/comment")}" cols="70" rows="10" name="ContentObjectAttribute_data_text_{$attribute.id}"></textarea>
       {/let}
    </div>

    <div class="buttonBlock">
        {include uri="design:blocs/btn.tpl" label="validate"|i18n("design/bouygues/comment") nameBtn='submitButtonComment' url='#' submit=concat('form-comment')}
        <input type="hidden" name="PublishButton" value="{"validate"|i18n("design/bouygues/comment")}" />
        <input type="hidden" name="MainNodeID" value="{$main_node_id}" />
        <input type="hidden" name="ContentLanguageCode" value="{ezini( 'RegionalSettings', 'Locale', 'site.ini')}" />
        <input type="hidden" name="DiscardConfirm" value="0" />
    </div>

</form>