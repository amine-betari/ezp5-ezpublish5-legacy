<div class="userRegistration">
{include uri="design:blocs/tools.tpl" light=1}
<h1>{"registration_activation_title"|i18n("extension/bouygues/ebyidentification")}</h1>
	<p>
	{if $account_activated}
	{'registration_activated'|i18n('extension/bouygues/ebyidentification')|nl2br()}
	{elseif $already_active}
	{'registration_activated'|i18n('extension/bouygues/ebyidentification')|nl2br()}
	{else}
	{'registration_activation_error'|i18n('extension/bouygues/ebyidentification')|nl2br()}
	{/if}
	{def $currentUser = fetch( 'user', 'current_user' )}
	</p>
	
	<div class="buttonblock">
	
	<form action={concat("/ebyidentification/password/",$currentUser.contentobject_id)|ezurl} method="post" id="Password" name="Password">
	
		<div class="element">
			<label>{'registration_password'|i18n('extension/bouygues/ebyidentification')}</label>
			<input type="password" name="newPassword" size="11" value="{$newPassword}" class="passwordField required" id="passwordField"/>
		</div>
		
		<div class="element">
			<label>{'registration_password_confirm'|i18n('extension/bouygues/ebyidentification')}</label>
			<input type="password" name="confirmPassword" size="11" value="{$confirmPassword}"  class="passwordField required"/>
		</div>
		
		<div class="element right">
			<input type="hidden" name="oldPassword" size="11" value="passeby" />
			<input type="hidden" name="OKButton" size="11" value="OKButton" />
			
			{include uri="design:blocs/btn.tpl" label='registration_activation_submit'|i18n('extension/bouygues/ebyidentification') url='#' submit=concat('Password')}
		</div>
	  
	</form>
	</div>
</div>
{literal}
<script type="text/javascript">
	$().ready(function(){
		$('form[name=Password]').validate({
			 	errorElement: "div",
				rules: {
					confirmPassword: {
						required: true,
						equalTo: "#passwordField"
					}
				},
				messages: {
					confirmPassword: {
						equalTo: "{/literal}{'registration_password_required_same'|i18n('extension/bouygues/ebyidentification')}{literal}",
						required: "{/literal}{'registration_password_required'|i18n('extension/bouygues/ebyidentification')}{literal}"
					},
					newPassword: {
						required: "{/literal}{'registration_password_required'|i18n('extension/bouygues/ebyidentification')}{literal}"
					}
				}
		});
	});
</script>
{/literal}