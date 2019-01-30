<li class="widget pagesview" id="widget{$id}">  
	<form id="form{$id}">
	<div class="widget-head"></div>
	<div class="edit-box" style="display:none;">
	<div class="widget-edit-content">
			<fieldset>
		<legend><img src={"pictos/ebyperso_pagesview.gif"|ezimage} alt="" /> {'widget_pages_title'|i18n('design/bouygues/ebyperso')}</legend>
			<p>
			<label>{'widget_pages_display'|i18n('design/bouygues/ebyperso')} </label><select id="nbpages"  name="nbpages" >			
			{for 1 to $nbPagesVuesMax as $i}
				<option value="{$i}">{$i}</option>
			{/for}				
			</select> {'widget_pages_content'|i18n('design/bouygues/ebyperso')}
		</p>
		

			{include uri="design:blocs/btn.tpl" label='widget_cancel'|i18n('design/bouygues/ebyperso') url='#' onclick='return false;' class='closeViewsWidget' align='right'}
			{include uri="design:blocs/btn.tpl" label='widget_validate'|i18n('design/bouygues/ebyperso') url='#' submit=concat('form',$id) align='right'}
			
		</fieldset>
		</div>
			<div class="widget-edit-bottom"></div>
	</div>
	<div class="widget-title">
		<h3><img src={"pictos/ebyperso_pagesview.gif"|ezimage} alt="" /> {'widget_pages_title'|i18n('design/bouygues/ebyperso')}</h3>
	</div>
	<div class="widget-content">
	<div class="widget-overview">
		{include uri="design:blocs/pagesview.tpl"}		
	</div>		
	</div>
	<div class="widget-bottom"></div>
	</form>
</li>
<script type="text/javascript">	
	$("form#form{$id}").submit(function(){ldelim}
		updSettings({$id});
		return false;
	{rdelim});

	$("#nbpages").val({$nbpages});
	

</script>
{undef}