
<div class="context-block">

{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

<h1 class="context-title">{'Label'|i18n('extension/ezlabel/edit')}</h1>
<h2 class="context-title">{$list_count} {'Labels defined'|i18n('extension/ezlabel/edit')}</h2>


{* DESIGN: Mainline *}<div class="header-mainline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-bl"><div class="box-br"><div class="box-content">

<form action={'/label/edit'|ezurl()} mothod="post">
<input name="Id" type="hidden" value="{$label.id}" />
    <div class="table02" style="width: auto">
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <th width="160">{'Name'|i18n('extension/ezlabel/edit')}</th>
                <td class="num" width="420">
                    <input name="Name" type="text" class="address" value="{$label.name}" />
                </td>
            </tr>
        </table>
    </div>
    <input type="submit" name="Submit" class="button_go" value="{'Save'|i18n('extension/ezlabel/edit')}" />
</form>


</div></div></div></div></div></div></div>
