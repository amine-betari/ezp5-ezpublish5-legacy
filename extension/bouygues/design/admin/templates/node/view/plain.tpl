{* Default object view template for read-only views
   Displays object content only with no buttons or children *}
{default content_object=$node.object
         content_version=$node.contentobject_version_object
         node_name=$node.name|wash}
{set-block scope=root variable=cache_ttl}0{/set-block}
{literal}
<script>
function show_edit_it()
{
	$("#edit_bloc").show();
	$("#show_it").hide();
}
function hide_edit_it()
{
	$("edit_bloc").hide();
	$("show_it").show();	
}
</script>
{/literal}

</form>
<form id="edit_it" enctype="multipart/form-data" method="post"  action={concat("boaction/edit_workflow_obj/",$node.contentobject_id,"/",$node.contentobject_version)|ezurl}>

<div class="objectheader" id="edit_bloc" style="display:none;">

    {default $view_parameters=array()}
    {section name=ContentObjectAttribute loop=$content_version.contentobject_attributes sequence=array(bglight,bgdark)}
    <div class="block">



        <label{section show=$ContentObjectAttribute:item.has_validation_error} class="validation-error"{/section}>{$ContentObjectAttribute:item.contentclass_attribute.name|wash}</label>
        <div class="labelbreak"></div>
        <input type="hidden" name="ContentObjectAttribute_id[]" value="{$ContentObjectAttribute:item.id}" />
        {if $ContentObjectAttribute:item.data_type_string|eq("ezuser")}
        {elseif $ContentObjectAttribute:item.data_type_string|eq("ezimage")}
        {elseif $ContentObjectAttribute:item.data_type_string|eq("ezuser")}
        {else}
        {attribute_edit_gui attribute_base=$attribute_base attribute=$ContentObjectAttribute:item view_parameters=$view_parameters}
        {/if}
	</div>

    {/section}
    {/default}
    <input class="button" type="submit" name="StoreButton" value="Edit" />
    <input class="button" type="button" name="DiscardButton" onclick="hide_edit_it();" value="Back" />

</div>

<div class="object" id="show_it">

    <h1>Add 《{$node_name}》 in parent node <a href={$node.parent.url_alias|ezurl} target="_blank">《{$node.parent.name}》- id {$node.parent_node_id}</a>
    <a href="javascript:void(0);" onclick="show_edit_it();">Edit</a>
    </h1>
    <input type="hidden" name="TopLevelNode" value="{$content_object.main_node_id}" />

    {section name=ContentObjectAttribute loop=$content_version.contentobject_attributes}
    <div class="block">
        <label>{$ContentObjectAttribute:item.contentclass_attribute.name|wash}</label>
    	<p class="box">{attribute_view_gui attribute=$ContentObjectAttribute:item}</p>
    </div>
    {/section}

    <h3>{'Placed in'|i18n('design/standard/node/view')}</h3>
    {section name=Parent loop=$content_object.parent_nodes}
        {let parent_node=fetch(content,node,hash(node_id,$:item))}
        {section name=Path loop=$:parent_node.path}
            {node_view_gui view=text_linked content_node=$:item} /
        {/section}
        {node_view_gui view=text_linked content_node=$:parent_node}<br/>
        {/let}
    {/section}
</div>

    {let name=Object related_objects=$content_version.related_contentobject_array}

      {section name=ContentObject  loop=$Object:related_objects show=$Object:related_objects  sequence=array(bglight,bgdark)}

        <div class="block">
        {content_view_gui view=text_linked content_object=$Object:ContentObject:item}
        </div>

      {/section}
    {/let}

{/default}
