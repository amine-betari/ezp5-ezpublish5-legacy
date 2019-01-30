{def $list_count=fetch('label', 'list_count', hash('scope','all'))
     $list=fetch('label','list',hash('scope','all'))}
         
<div class="context-block">

{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

<h1 class="context-title">{'Label'|i18n('extension/ezlabel/list')}</h1>
<h2 class="context-title">{$list_count} {'Labels defined'|i18n('extension/ezlabel/list')}</h2>


{* DESIGN: Mainline *}<div class="header-mainline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-ml"><div class="box-mr"><div class="box-content">


{if $list}
<table class="list" cellspacing="0">
<tr>
    <th>{'ID'|i18n('extension/ezlabel/list')}</th>
    <th>{'Name'|i18n('extension/ezlabel/list')}</th>
    <th>{'Action'|i18n('extension/ezlabel/list')}</th>
</tr>
{foreach $list as $label sequence array( 'bglight', 'bgdark' ) as $class_name}
    <tr class="$class_name">
            <td>
                {if $label.is_private}
                    <img src={'private.png'|ezimage} alt="{'Private label'|i18n('extension/ezlabel')}" title="{'Private label'|i18n('extension/ezlabel/list')}">
                {else}
                    <img src={'global.png'|ezimage} alt="{'Global label'|i18n('extension/ezlabel')}" title="{'Global label'|i18n('extension/ezlabel/list')}">
                {/if}
                {$label.id}
            </td>
            <td><a href={concat('/label/view/',$label.id)|ezurl}>{$label.name}</a></td>
            <td>
            {if $label.can_edit}
            <a href={concat('/label/edit/',$label.id)|ezurl}><img src={'edit.png'|ezimage}>
            {/if}
            {if $label.can_remove}
            <a href={concat('/label/remove/',$label.id)|ezurl}><img src={'trash.png'|ezimage}> 
            {/if}
            {if and($label.is_private,$label.can_scope)}
            <a href={concat('/label/remove/',$label.id)|ezurl}><img src={'user.gif'|ezimage}>
            {/if}
            {if and($label.is_global,$label.can_scope)}
            <a href={concat('/label/remove/',$label.id)|ezurl}><img src={'usergroup.gif'|ezimage}>
            {/if}</td>
    </tr>
{/foreach}
</table>
{else}
<div class="block">
<p>{'There are no labels.'|i18n('extension/ezlabel/list')}</p>
</div>
{/if}
</div>
{if $label.can_remove}
<div class="block">

            <form name="createLabel" action={'/label/create'|ezurl()} method="post">
<fieldset>
<input name="Name" type="text" class="address" value="" />&nbsp;&nbsp;
                <input type="radio" name="LabelScope" value="global" checked=checked> {"Global"|i18n('extension/ezlabel/list')|wash}
                <input type="radio" name="LabelScope" value="private"> {"Private"|i18n('extension/ezlabel/list')|wash}&nbsp;&nbsp;
                <input type="submit" name="CreateButton" class="button" value="{'Create'|i18n('extension/ezlabel/list')}" />
</fieldset>
            </form>
</div>
            {/if}



</div>
</div>
