{* Template for article viewing *}
<div class="context-block">
{* DESIGN: Header START *}
<div class="box-header">
    <div class="box-tc">
        <div class="box-ml">
            <div class="box-mr">
                <div class="box-tl">
                    <div class="box-tr">
                        <h1 class="context-title">
                            {$node.object.class_name|wash}: {$node.object.name|wash}
                        </h1>
                        {* DESIGN: Mainline *}
                        <div class="header-mainline"></div>
                        {* DESIGN: Header END *}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

{* DESIGN: Content START *}<div class="box-ml"><div class="box-mr"><div class="box-content">

<div class="context-attributes">
{foreach $node.data_map as $article_attribute}
    <div class="block">

    <label>{$article_attribute.contentclass_attribute_name}:</label>
    {attribute_view_gui attribute=$article_attribute}

    </div>
{/foreach}

</div>
{* DESIGN: Content END *}</div></div></div>

{* Buttons. *}
<div class="controlbar">
{* DESIGN: Control bar START *}
<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
<div class="block">
<form method="post" style="display:inline" action={'/content/action/'|ezurl}>
    <input name="TopLevelNode" value="{$node.node_id}" type="hidden">
    <input name="ContentNodeID" value="{$node.node_id}" type="hidden">
    <input name="SelectedNodeID" value="{$node.node_id}" type="hidden">
    <input name="ContentObjectID" value="{$node.contentobject_id}" type="hidden">
    <input class="button" type="submit" name="EditButton" value="{'Edit'|i18n( 'design/eznewsletter_builder/editor_view/article_view' )}" title="{'Edit this article.'|i18n( 'design/eznewsletter_builder/editor_view/article_view' )}" />
    <input class="button" name="ActionRemove" value="{'Remove'|i18n( 'design/eznewsletter_builder/editor_view/article_view' )}" title="{'Remove this item.'|i18n( 'design/eznewsletter_builder/editor_view/article_view' )}" type="submit">
    <input class="button" type="submit" name="MoveNodeButton" value="Move" title="{'Move this item to another location.'|i18n( 'design/eznewsletter_builder/editor_view/article_view' )}" />
</form>
<form style="display:inline" method="post" action={concat('content/copy/',$node.contentobject_id)|ezurl}>
    <input name="TopLevelNode" value="{$node.node_id}" type="hidden">
    <input name="ContentNodeID" value="{$node.node_id}" type="hidden">
    <input name="SelectedNodeID" value="{$node.node_id}" type="hidden">
    <input name="ContentObjectID" value="{$node.contentobject_id}" type="hidden">
    <input name="ObjectID" value="{$node.contentobject_id}" type="hidden" />
    <input name="SelectedNodeID" value="{$node.parent_node_id}" type="hidden" />
    <input class="button" type="submit" name="CopyToButton" value="{'Copy to'|i18n( 'design/eznewsletter_builder/editor_view/article_view' )}" title="{'Copy this article to another location.'|i18n( 'design/eznewsletter_builder/editor_view/article_view' )}" />
</form>

<form style="display:inline" method="post" action={'/epsoncopy/copy'|ezurl}>
    <input name="ObjectID" value="{$node.contentobject_id}" type="hidden" />
    <input name="SelectedNodeID" value="{$node.parent_node_id}" type="hidden" />
    <input class="button" type="submit" name="CopyButton" value="{'Copy'|i18n( 'design/eznewsletter_builder/editor_view/article_view' )}" title="{'Copy this article to the same location.'|i18n( 'design/eznewsletter_builder/editor_view/article_view' )}" />
</form>
</div>
{* DESIGN: Control bar END *}</div></div></div></div></div></div>
</div>

{include uri='design:editor_view/article_stats_box.tpl' object_id=$node.object.id}

</div>
