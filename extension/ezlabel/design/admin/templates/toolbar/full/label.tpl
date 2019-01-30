{def $object_id=$module_result.content_info.object_id}

{if $object_id}
{def $object_list=fetch('label','object_list',hash('object_id',$object_id,'scope','all'))
     $list=fetch('label','list',hash('scope','all'))
     $object_ids=array()}
	

<div id="ezlabeltoolbar">

{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

{if ezpreference( 'admin_labelmenu' )}
<h4><a class="showhide" href={'/user/preferences/set/admin_labelmenu/0'|ezurl} title="{"Hide label view"|i18n( "extension/ezlabel/toolbar/full" )}"><span class="bracket">[</span>-<span class="bracket">]</span></a> {"Labels"|i18n( "extension/ezlabel/toolbar/full" )}</h4>
{else}
<h4><a class="showhide" href={'/user/preferences/set/admin_labelmenu/1'|ezurl} title="{"Show label view"|i18n( "extension/ezlabel/toolbar/full" )}"><span class="bracket">[</span>+<span class="bracket">]</span></a> {"Labels"|i18n( "extension/ezlabel/toolbar/full" )}</h4>
{/if}

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-bl"><div class="box-br"><div class="box-content">

{if ezpreference( 'admin_labelmenu' )}
<div id="ezlabel">
{if fetch( 'user', 'has_access_to', hash( 'module', 'label', 'function', 'view' ) )|eq(true)}
            <fieldset>
                {if count($object_list)|gt(0)}
                    {foreach $object_list as $label}
                    <div class="single_label">
                        {if fetch( 'user', 'has_access_to', hash( 'module', 'label', 'function', 'remove' ) )|eq(true)}
                            <a href={concat('/label/remove/',$label.id)|ezurl}>
                                <img align="absmiddle" style="" src={'trash.png'|ezimage} title="{"Remove label"|i18n( "extension/ezlabel/toolbar/full" )}" alt="{"Remove label"|i18n( "extension/ezlabel/toolbar/full" )}" />
                            </a>
                        {/if}
                        {if fetch( 'user', 'has_access_to', hash( 'module', 'label', 'function', 'unassign' ) )|eq(true)}
                            <a href={concat('/label/unassign/',$label.id,'/',$object_id)|ezurl}>
                                <img align="absmiddle" style="" src={'remove.png'|ezimage} title="{"Unassign label"|i18n( "extension/ezlabel/toolbar/full" )}" alt="{"Unassign label"|i18n( "extension/ezlabel/toolbar/full" )}" />
                        {/if}
                        <a class="{$label.scope}_label" href={concat('/label/view/',$label.id)|ezurl}>
                        {if $label.is_private}
                            <img src={'private.png'|ezimage} alt="{'Private label'|i18n('extension/ezlabel/toolbar/full')}" title="{'Private label'|i18n('extension/ezlabel/toolbar/full')}" \>
                        {else}
                            <img src={'global.png'|ezimage} alt="{'Global label'|i18n('extension/ezlabel/toolbar/full')}" title="{'Global label'|i18n('extension/ezlabel/toolbar/full')}" \>
                        {/if}
                        {$label.name}
                        </a>
                        {set $object_ids=$object_ids|append($label.id)}
                </div>
                {/foreach}
                {else}
                <p>{"No Labels assigned."|i18n('extension/ezlabel/toolbar/full')|wash}</p>
                {/if}
                <a href={'/label/list'|ezurl}>{"List all labels"|i18n( "extension/ezlabel/toolbar/full" )}</a>
            </fieldset>
		{/if}
		{if fetch( 'user', 'has_access_to', hash( 'module', 'label', 'function', 'assign' ) )|eq(true)}
			{def $labels=array()}
            {foreach $list as $label}
                {if not($object_ids|contains($label.id))}
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
                <input class="button" type="submit" name="LinkButton" value="{"Assign"|i18n( "extension/ezlabel/toolbar/full" )}" />
            </fieldset>
            </form>
            {/if}
		{/if}
		{if fetch( 'user', 'has_access_to', hash( 'module', 'label', 'function', 'create' ) )|eq(true)}
            <form name="createLabel" action={'/label/create'|ezurl()} method="post">
            <fieldset>
                <input name="Name" type="text" class="addlabeltext" value="" /><br />
                <input type="radio" name="LabelScope" value="global" checked="checked" />{"Global"|i18n('extension/ezlabel/toolbar/full')|wash}
                <input type="radio" name="LabelScope" value="private" />{"Private"|i18n('extension/ezlabel/toolbar/full')|wash}<br />
                <input type="submit" name="CreateButton" class="button" value="{'Create'|i18n('extension/ezlabel/toolbar/full')}" />
                <input type="checkbox" name="ObjectId" value="{$object_id}" />{"Assign"|i18n('extension/ezlabel/toolbar/full')|wash}<br />
            </fieldset>
            </form>
		{/if}
</div>


{/if}

{* DESIGN: Content END *}</div></div></div></div></div></div>

</div>
{/if}
