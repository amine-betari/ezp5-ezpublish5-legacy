{def $object_id=$module_result.content_info.object_id}

{if $object_id}
{def $object_list=fetch('label','object_list',hash('object_id',$object_id,'scope','all'))
     $list=fetch('label','list',hash('scope','all'))
     $object_ids=array()}
    

<div class="toolbar-item {$placement}">
    <div class="toolbox">
        <div class="toolbox-design">
        <h2>{"Labels"|i18n( "extension/label" )}</h2>
        <div class="toolbox-content">


<div id="ezlabel">
{if fetch( 'user', 'has_access_to', hash( 'module', 'label', 'function', 'view' ) )|eq(true)}
            <fieldset>
                {if count($object_list)|gt(0)}
                    {foreach $object_list as $label}
                    <div class="single_label">
                        {if fetch( 'user', 'has_access_to', hash( 'module', 'label', 'function', 'remove' ) )|eq(true)}
                            <a href={concat('/label/remove/',$label.id)|ezurl}>
                                <img align="absmiddle" style="" src={'trash.png'|ezimage} title="{"Remove label"|i18n( "extension/ezlabel" )}" alt="{"Remove label"|i18n( "extension/ezlabel" )}" />
                            </a>
                        {/if}
                        {if fetch( 'user', 'has_access_to', hash( 'module', 'label', 'function', 'unassign' ) )|eq(true)}
                            <a href={concat('/label/unassign/',$label.id,'/',$object_id)|ezurl}>
                                <img align="absmiddle" style="" src={'remove.png'|ezimage} title="{"Unassign label"|i18n( "extension/ezlabel" )}" alt="{"Unassign label"|i18n( "extension/ezlabel" )}" />
                        {/if}
                        <a class="{$label.scope}_label" href={concat('/label/view/',$label.id)|ezurl}>
                        {if $label.is_private}
                            <img src={'private.png'|ezimage} alt="{'Private label'|i18n('extension/ezlabel')}" title="{'Private label'|i18n('extension/ezlabel/toolbar/full')}">
                        {else}
                            <img src={'global.png'|ezimage} alt="{'Global label'|i18n('extension/ezlabel')}" title="{'Global label'|i18n('extension/ezlabel/toolbar/full')}">
                        {/if}
{$label.name}</a>
                        {set $object_ids=$object_ids|append($label.id)}
                </div>
                {/foreach}
                {else}
                <p>{"No labels assigned."|i18n('extension/ezlabel/toolbar/full')|wash}</p>
                {/if}
            <a href={'/label/list'|ezurl}>{"List all labels"|i18n( "extension/ezlabel" )}</a>
            </fieldset>
        {/if}
        {if fetch( 'user', 'has_access_to', hash( 'module', 'label', 'function', 'assign' ) )|eq(true)}
            {def $labels=array()}
            {foreach $list as $label}
                {if and(not($object_ids|contains($label.id)),
                    or(and($label.scope|eq('global'),fetch( 'label', 'can_assign_labels' )|contains('global')),
                       and($label.scope|eq('private'),fetch( 'label', 'can_assign_labels' )|contains('private'))))}
                    {set $labels=$labels|append($label)}
                {/if}
            {/foreach}
            {if count($labels)|gt(0)}
            <form name="addLabel" action={"/label/assign"|ezurl} method="post">
            <fieldset>
{*             <legend></legend>*}
                <input type="hidden" name="ObjectId" value="{$object_id}" />
                <select name="LabelId">
                    {foreach $labels as $label}
                        <option value="{$label.id}">{$label.name}</option>
                    {/foreach}
                </select>
                <input class="button" type="submit" name="LinkButton" value="{"Assign"|i18n( "extension/ezlabel" )}" />
            </fieldset>
            </form>
            {/if}
        {/if}
        {if fetch( 'user', 'has_access_to', hash( 'module', 'label', 'function', 'create' ) )|eq(true)}
            <form name="createLabel" action={'/label/create'|ezurl()} method="post">
            <fieldset>
{*             <legend></legend>*}
                <input name="Name" type="text" class="address" value="" /><br />
        {if fetch( 'label', 'can_create_labels' )|contains('global')}
                <input type="radio" name="LabelScope" value="global" checked="checked"> {"Global"|i18n('extension/ezlabel/toolbar/full')|wash}
        {/if}
        {if fetch( 'label', 'can_create_labels' )|contains('private')}
                <input type="radio" name="LabelScope" value="private"> {"Private"|i18n('extension/ezlabel/toolbar/full')|wash}
        {/if}
                <input type="submit" name="CreateButton" class="button" value="{'Create'|i18n('extension/ezlabel/toolbar/full')}" />
                <input type="checkbox" name="ObjectId" value="{$object_id}" />{"Assign"|i18n('extension/ezlabel/toolbar/full')|wash}<br />
            </fieldset>
            </form>
        {/if}
</div>
        </div>
    </div>
</div>
</div>
{/if}

