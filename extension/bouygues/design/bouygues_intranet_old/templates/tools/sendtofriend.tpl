<div class="default">
	<h1>{"sendtofriend"|i18n("design/bouygues/sendtofriend")}</h1>
	<p class="ajaxReload-sendtofriend">
	{"share"|i18n("design/bouygues/sendtofriend")|nl2br()}
	</p>
	
	<form action={"/tools/sendtofriend"|ezurl()} method="post" name="formSendtofriend" id="formSendtofriend">
		<input type="hidden" name="action" value="1" class="hiddenField"/>
		<input type="hidden" name="url" value="{$url}" class="hiddenField"/>
		<div class="col">
			<label for="name">{"your_name"|i18n("design/bouygues/sendtofriend")}</label>
			<input type="text" id="name" name="name" value="{if is_set($currentUser)}{$currentUser.contentobject.data_map.first_name.content} {$currentUser.contentobject.data_map.last_name.content}{/if}"/>
		</div>
		<div class="col">
			<label for="sender_email">{"your_email"|i18n("design/bouygues/sendtofriend")}</label>
			<input type="text" id="sender_email" name="sender_email" class="required email" title="{"email_unknown"|i18n("design/bouygues/sendtofriend")}" value="{if is_set($currentUser)}{$currentUser.email}{/if}"/>
		</div>
		

		<h2>{"to_whom"|i18n("design/bouygues/sendtofriend")}</h2>
	
		
		<label for="email">{"recipients"|i18n("design/bouygues/sendtofriend")}</label>
		<input type="text" id="email" name="email" class="required" title="{"email_unknown"|i18n("design/bouygues/sendtofriend")}"/>
		<span class="info">{"recipient_more"|i18n("design/bouygues/sendtofriend")}</span>
		<p>
		<label for="content">{"your_message"|i18n("design/bouygues/sendtofriend")}</label>
		<textarea name="content" id="content"></textarea>
		</p>
		<div class="submit">
			{include uri="design:blocs/btn.tpl" label="cancel"|i18n("design/bouygues/sendtofriend") url='javascript: Lightbox.close();' align='right'}
			{include uri="design:blocs/btn.tpl" label="send"|i18n("design/bouygues/sendtofriend") url='#' submit='formSendtofriend' align='right'}
			<span class='btn_mandatory'>{"obligatory_fields"|i18n("design/bouygues/whoswho")}</span>
		</div>
		
	</form>

</div>
{literal}
<script type="text/javascript">
	$().ready(function(){
		$('input[name=name]').focus();
	});
</script>
{/literal}