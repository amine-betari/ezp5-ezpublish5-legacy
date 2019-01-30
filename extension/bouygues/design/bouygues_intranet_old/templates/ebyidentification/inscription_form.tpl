<div class="userRegistration">
	{include uri="design:blocs/tools.tpl" light=1}
	<div class="top">
		<h1>{'Subscribe Eby'|i18n('extension/bouygues/ebyidentification')}</h1>
	
		<h2>
		{'Subscribe Eby description'|i18n('extension/bouygues/ebyidentification')}
		</h2>
		
		<h3>{'Subscribe Eby details'|i18n('extension/bouygues/ebyidentification')}</h3>
	</div>

	<form method="post" action={"/ebyidentification/inscription/"|ezurl} id="subscriptionForm">
		<input type="hidden" name="step" value="subscription"/>
		<input type="hidden" name="RegisterButton" value="ok"/>
		<div class="element">
		    <label for="email_register">{'Your email'|i18n('extension/bouygues/ebyidentification')}</label>
		    <input type="text" value="" size="30" name="email_register"  id="email_register" /> <span class="error">{$status_message}&nbsp;</span>
		</div>
		
		<div class="element">
		    <label>{'language'|i18n('extension/bouygues/ebyidentification')}</label>
		    <input type="radio" value="0" name="langue"  id="langue0" checked="checked"/> <label for="langue0" class="label-simple">{'French'|i18n('extension/bouygues/ebyidentification')}</label>
		    <input type="radio" value="1" name="langue"  id="langue1" />  <label for="langue1" class="label-simple">{'English'|i18n('extension/bouygues/ebyidentification')}</label>
		</div>
		<div style="clear: both"></div>
		<div class="element">  
		    <input type="checkbox" value="1" name="newsletter"  id="newsletter" /> <span>{'Newsletter message'|i18n('extension/bouygues/ebyidentification')}</span>
		</div>
		
		<div class="element right">
			{include uri="design:blocs/btn.tpl" label='widget_validate'|i18n('design/bouygues/ebyperso') url='#' submit=concat('subscriptionForm')}
		</div>
	</form>
	<div style="clear: both"></div>
	<a href="{'/user/login'|ezurl(no)}" class="btn-grey-arrow-left">{'registration_already_exist'|i18n('extension/bouygues/ebyidentification')}</a><br />
	<a href="{'/user/forgotpassword'|ezurl(no)}" class="btn-grey-arrow-left">{'registration_lost_password'|i18n('extension/bouygues/ebyidentification')}</a>
	
</div>