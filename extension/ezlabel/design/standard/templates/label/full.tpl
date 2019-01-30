{def $list=fetch( 'content', 'tree', hash( 'parent_node_id', 1,
              'extended_attribute_filter', hash( 'id', 'eZLabelFilter',
                                                 'params', hash( 'label', $label.id ) )))
    $list_count=count($list)}

<div class="context-block">

{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

<h1 class="context-title">{'Assigned objects'|i18n('extension/ezlabel/view_full')}</h1>
<h2 class="context-title">{$list_count} {'Objects assigned to label'|i18n('extension/ezlabel/view_full')} &laquo;{$label.name}&raquo;</h2>


{* DESIGN: Mainline *}<div class="header-mainline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-ml"><div class="box-mr"><div class="box-content">

{if $list}
<table class="list" cellspacing="0">
<tr>
    <th>{'Name'|i18n('extension/ezlabel/view_full')}</th>
    {if $label.can_remove}<th>{'Action'|i18n('extension/ezlabel/view_full')}</th>{/if}
</tr>
{foreach $list as $node sequence array( 'bglight', 'bgdark' ) as $class_name}
    <tr class="$class_name">
            <td><a href={$node.url_alias|ezurl}>{$node.name}</a></td>
            {if $label.can_remove}<td><a href={concat('/label/remove/',$label.id,'/',$node.object.id)|ezurl}><img src={'trash.png'|ezimage}></td>{/if}
    </tr>
{/foreach}
</table>
{else}
<div class="block">
<p>{'There are no objects assigned to this label.'|i18n('extension/ezlabel/view_full')}</p>
</div>
{/if}
</div>
</div>
</div>
