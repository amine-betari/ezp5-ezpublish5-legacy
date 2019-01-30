
<div class="context-block">

{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

<h1 class="context-title">{'Label'|i18n('extension/ezlabel/create')}</h1>
<h2 class="context-title">{$list_count} {'Labels defined'|i18n('extension/ezlabel/create')}</h2>


{* DESIGN: Mainline *}<div class="header-mainline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-ml"><div class="box-mr"><div class="box-content">
<div class="content-view-full">
            <form name="createLabel" action={'/label/create'|ezurl()} method="post">
                <input name="Name" type="text" class="address" value="" /><br />
                <input type="radio" name="LabelScope" value="global" checked="checked"> {"Global"|i18n('extension/ezlabel/create')|wash}<br />
                <input type="radio" name="LabelScope" value="private"> {"Private"|i18n('extension/ezlabel/create')|wash}<br />
                <input type="submit" name="CreateButton" class="button" value="{'Create'|i18n('extension/ezlabel/create')}" />
                <input type="checkbox" name="ObjectId" value="{$object_id}" />{"Assign"|i18n('extension/ezlabel/create')|wash}<br />
            </form>


</div>
</div>
</div>
<div class="controlbar">

<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">

<div class="block">

<div class="left"></div>


<div class="right"></div>




<div class="break"></div>

</div>

</div></div></div></div></div></div>
</div>
