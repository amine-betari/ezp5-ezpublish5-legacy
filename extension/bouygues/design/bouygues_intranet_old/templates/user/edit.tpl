{def $userAccount = fetch( 'user', 'current_user' )}
{def $galbyeError=isEmailGalbyError()}

<div class="userRegistration">
{include uri="design:blocs/tools.tpl" light=1}

<h1>{"profile_title"|i18n("design/bouygues/profile")}</h1>
<h3>
{"profile_desc"|i18n("design/bouygues/profile")}
</h3>
<h4>{"profile_yourdata"|i18n("design/bouygues/profile")}</h4>

	<form method="post" action={"/ebyidentification/update/"|ezurl} id="profilForm" name="profilForm" >
		<input type="hidden" name="RegisterButton" value=""/>
		<input type="hidden" name="url" value="/user/edit"/>
		<input type="hidden" name="login" id="login" value="{$userAccount.login}"/>
		<div class="element">
		    <label class="profile-name-label">{"profile_firstname"|i18n("design/bouygues/profile")}</label>
			<label class="profile-name-value">{$userAccount.contentobject.data_map.first_name.content}</label>
				<label class="profile-name-label">{"profile_lastname"|i18n("design/bouygues/profile")}</label>
				<label class="profile-name-value">{$userAccount.contentobject.data_map.last_name.content}</label>

		</div>
		
		<div class="element">
		    <label for="email_register">{"profile_email"|i18n("design/bouygues/profile")}</label>
		    <input type="text" size="30" name="email_register" value="{$userAccount.email}"  id="email_register" class="required email"/>
			<span class='error error_ajax'>{$status_message}</span>      
		</div>
		
		<div class="element">
		    <label for="new_password">{'profile_password'|i18n('design/bouygues/profile')}</label>
		    <input type="password" value="" size="30" name="newPassword"  id="new_password"/>      
		</div>
		
		<div class="element">
		    <label for="confirm_password">{'profile_password_confirm'|i18n('design/bouygues/profile')}</label>
		    <input type="password" value="" size="30" name="confirmPassword"  id="confirm_password"/>      
		</div>
		
		<div class="element">
		    <label>{'profile_language'|i18n('design/bouygues/profile')}</label>
		    <input type="radio" value="0" name="langue"  id="langue0" {if $userAccount.contentobject.data_map.langue.value.0|eq(0)}checked{/if}/>  <label for="langue0" class="label-simple">{'French'|i18n('design/bouygues/profile')}</label>
		    <input type="radio" value="1" name="langue"  id="langue1" {if $userAccount.contentobject.data_map.langue.value.0|eq(1)}checked{/if}/>   <label for="langue1" class="label-simple">{'English'|i18n('design/bouygues/profile')}</label>
		</div>
		
		<div class="element right">
			{include uri="design:blocs/btn.tpl" label='widget_validate'|i18n('design/bouygues/ebyperso') url='#' submit=concat('profilForm')}
		</div>
	</form>
	<div style="margin-bottom: 15px; clear: both"></div>
	<p style="clear:both;"><strong>{'profile_mention1'|i18n('design/bouygues/profile')}</strong> {'profile_mention2'|i18n('design/bouygues/profile')|nl2br()}</p>
</div>
{literal}
<script type="text/javascript">
	$().ready(function(){
				
		{/literal}
		
		eby.initCheckEmail();
		
		{if is_set($setData)}eby.setUserData('{$setData}');{/if}
		
		{literal}
		var options = {
			url :currentLang+'/ebyidentification/update',
			type: 'POST',
			success : function(data) {
				if(data == 1 || data == 2)
					eby.setUserData(data);
				else if(data == 3)
					$('span.error_ajax').html('{/literal}{'registration_email_already_registered'|i18n('extension/bouygues/ebyidentification')|addslashes()}{literal}').show();
				else if(data == 4)
					$('span.error_ajax').html('{/literal}{'email_galby_error'|i18n('extension/bouygues/ebyidentification')|addslashes()}{literal}').show();
				else if(data == 5)
					$('span.error_ajax').html('{/literal}{'registration_email_not_valid'|i18n('extension/bouygues/ebyidentification')|addslashes()}{literal}').show();
				
			}
		};
		
		$('form[name=profilForm]').validate({
				errorElement: "span",
				rules: {
					confirmPassword: {
						minlength: 3,
						equalTo: "#new_password"
					},
					newPassword:{
						minlength: 3
					}
				},
				messages: {
					confirmPassword: {
						equalTo: "{/literal}{'profile_password_required_same'|i18n('design/bouygues/profile')}{literal}"
					},
					email_register: {
						required: "{/literal}{'registration_email_not_valid'|i18n('extension/bouygues/ebyidentification')}{literal}"
					},
					newPassword: {
						required: "{/literal}{'profile_password_required'|i18n('design/bouygues/profile')}{literal}"
					}
				},
				submitHandler : function(error) {
					$("form[name=profilForm]").ajaxSubmit(options);
				}
		});
	});
	
</script>
{/literal}