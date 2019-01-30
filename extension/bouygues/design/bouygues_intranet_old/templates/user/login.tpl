{def $eZLocale=fetch( 'content', 'locale' )}
{def $localeUrl=''}
{if $eZLocale.locale_full_code|eq('eng-US')}{set $localeUrl='/en'}{/if}

{def $jsCancel='onClick=Lightbox.close()'}
{def $RedirectURI=concat($localeUrl, "/ebyperso/home/?check=1")|ezroot(no)}
{if and(is_set(ezhttp('uriReturn', 'get')), ezhttp('uriReturn', 'get')|eq('')|not)}{set $RedirectURI=concat(ezhttp('uriReturn', 'get'), '?check=1')|ezroot(no)}{/if}
{if is_set(ezhttp('from', 'get'))}
	{def $from = ezhttp('from', 'get')}
	{if ezhttp('from', 'get')|eq('fromMaj')}
		{def $callback=ezhttp('callback', 'get')}
	{elseif ezhttp('from', 'get')|eq('fromWhoswho')}
		{def $callback=ezhttp('callback', 'get')}
	{else}
		{def $callback=''}
	{/if}
{else}
	{def $from = 'fromDefault'}
{/if}

{if $callback|eq('')|not()}{set $RedirectURI=concat($RedirectURI, '&callback=', $callback)}{/if}

{if is_set(ezhttp('lb', 'get'))}
<div class="userIdentification">
<h1>{"Login"|i18n("extension/bouygues/ebyidentification")}</h1>
<h2>

{$from|i18n("extension/bouygues/ebyidentification")}

</h2>
<div class="column1">
	<span class="title">{"Login_already_register"|i18n("extension/bouygues/ebyidentification")}</span>
	<span class="subTitle">{"Login_connect"|i18n("extension/bouygues/ebyidentification")}</span>

	<form method="post" action={concat($localeUrl,"/user/login/")|ezroot} id="loginAjaxForm" name="loginAjaxForm">
		<input type="hidden" name="LoginButton" value="1"/>
		
		<input type="hidden" name="RedirectURI" value="{$RedirectURI|explode('/en/')|implode('/')|ezroot(no)}" />
		<input type="hidden" name="callback" value="{$callback}">
		{section show=and( is_set( $User:post_data ), is_array( $User:post_data ) )}
		  {section name=postData loop=$User:post_data }
		     <input name="Last_{$postData:key}" value="{$postData:item}" type="hidden" /><br/>
		  {/section}
		{/section}
		<div class="element">
			<label for="username_identification">{"Email"|i18n("extension/bouygues/ebyidentification")}</label><div class="labelbreak"></div>
			<input class="required email halfbox" type="text" size="10" name="Login" id="username_identification" value="{$User:login|wash}" tabindex="1"/>
		</div>
		
		<div class="element">
			<label for="password_identification">{"registration_password"|i18n("extension/bouygues/ebyidentification")}</label><div class="labelbreak"></div>
			<input class="required halfbox" type="password" size="10" name="Password" id="password_identification" value="" tabindex="1"/>
		</div>
	
		{if and( ezini_hasvariable( 'Session', 'RememberMeTimeout' ), ezini( 'Session', 'RememberMeTimeout' ) )}
			<div class="element link">
		       <input type="checkbox" name="Cookie" id="id3" /> <label for="id3">{"Login_Memorise"|i18n("extension/bouygues/ebyidentification")}</label>
		       <a href="{concat($localeUrl,'/user/forgotpassword')|ezroot(no)}" class="btn-hard-grey-arrow-left">{"registration_lost_password"|i18n("extension/bouygues/ebyidentification")}</a>
		   	</div>
		{/if}
		
		<div style="clear:both" ></div>
		{include uri="design:blocs/btn.tpl" label='widget_validate'|i18n('design/bouygues/ebyperso') url='#' submit=concat('loginAjaxForm')}&nbsp;
		{include uri="design:blocs/btn.tpl" label='widget_cancel'|i18n('design/bouygues/ebyperso') url='#' onclick='Lightbox.close();return false;'}
	
	</form>

</div>

<div class="column2">

	<span class="title">{"Login_not_register"|i18n("extension/bouygues/ebyidentification")}</span>
	<span class="subTitle">{"Login_you_can_register"|i18n("extension/bouygues/ebyidentification")}</span>
	
	<form method="post" action={concat($localeUrl,"/ebyidentification/inscription")|ezroot()} id="subscribeAjaxForm">
		<input type="hidden" name="RegisterButton" value="1"/>
		<div class="element">
			<label for="username_registration_identification">{"Email"|i18n("extension/bouygues/ebyidentification")}</label><div class="labelbreak"></div>
			<input class="halfbox required email" type="text" size="10" name="email_register" id="username_registration_identification" value="{$User:login|wash}" tabindex="1"/>
		</div>
		
		<div style="clear:both" ></div>
		{include uri="design:blocs/btn.tpl" label='widget_validate'|i18n('design/bouygues/ebyperso') url='#' submit=concat('subscribeAjaxForm')}&nbsp;
		{include uri="design:blocs/btn.tpl" label='widget_cancel'|i18n('design/bouygues/ebyperso') url='#' onclick='Lightbox.close();return false;'}


	</form>
</div>
{else}
<div class="userRegistration">
<h1>{"Login"|i18n("extension/bouygues/ebyidentification")}</h1>
<h2>

{"Login_description"|i18n("extension/bouygues/ebyidentification")}

</h2>
	<form method="post" action={concat($localeUrl,"/user/login/")|ezroot} id="subscribeForm">
		<input type="hidden" name="RedirectURI" value="{$RedirectURI|explode('/en/')|implode('/')|ezroot(no)}" />
		<input type="hidden" name="LoginButton" value="1" />
		<div class="element">
			<label for="username_identification">{"Email"|i18n("extension/bouygues/ebyidentification")}</label>
			<input type="text" size="10" name="Login" id="email_register" value="{$User:login|wash}" tabindex="1" class="required email"/>
		</div>
		
		<div class="element">
			<label for="password_identification">{"registration_password"|i18n("extension/bouygues/ebyidentification")}</label>
			<input type="password" size="10" name="Password" value="" tabindex="1"  id="password_register"  class="required"/>
			{if $User:warning.bad_login|true()}<span class="error">{'authentification_error'|i18n("extension/bouygues/ebyidentification")}</span>{/if}
		</div>
		
		{if and( ezini_hasvariable( 'Session', 'RememberMeTimeout' ), ezini( 'Session', 'RememberMeTimeout' ) )}
			<div class="element">
		       <input type="checkbox" name="Cookie" id="id3" /> <label for="id3">{"Login_Memorise"|i18n("extension/bouygues/ebyidentification")}</label>
		   	</div>
		{/if}
		
		<div class="element right">
				{include uri="design:blocs/btn.tpl" label='registration_forgotpassword_validate'|i18n('extension/bouygues/ebyidentification') url='#' submit=concat('subscribeForm')}
	      </div>
		
	</form>
	<div style="clear: both"></div>
	<a href="{"/ebyidentification/inscription"|ezurl(no)}" class="btn-grey-arrow-left">{'registration_not_already_exist'|i18n('extension/bouygues/ebyidentification')}</a><br />
	<a href="{"/ebyidentification/forgotpassword"|ezurl(no)}" class="btn-grey-arrow-left">{'registration_lost_password'|i18n('extension/bouygues/ebyidentification')}</a>
{/if}
	<div style="clear: both"></div>
	<br />
	<em class="information-message">{'information_message'|i18n('extension/bouygues/ebyidentification')}</em>
</div>


{literal}
<script type="text/javascript">
	$().ready(function(){
		$('input[name=Login]').focus();
		
		{/literal}
		
		eby.initCheckEmail();
		
		{literal}
		$('#subscribeAjaxForm').validate({
				errorElement: "span",
				rules: {
					email_register:{
						checkEmailEby: "{/literal}{$localeUrl}{literal}/ebyidentification/checkemail//"
					}
				},
				messages: {
					email_register:'{/literal}{'email_error_invalid'|i18n("extension/bouygues/ebyidentification")}{literal}'
				}
		});
		
		var options = {
			success : function(data) {
				
			}
		};
		
		$('#loginAjaxForm').validate({
				errorElement: "span",
				rules: {
					Login:{
						remote: "{/literal}{$localeUrl}{literal}/ebyidentification/emailexists/"
					},
					Password:{
						required: true
					}
				},
				messages: {
					Login: {
						required: '{/literal}{'registration_email_not_valid'|i18n("extension/bouygues/ebyidentification")|addslashes()}{literal}',
						email: '{/literal}{'registration_email_not_valid'|i18n("extension/bouygues/ebyidentification")|addslashes()}{literal}',
						remote: '{/literal}{'registration_forgotpassword_wrong_address_eby'|i18n("extension/bouygues/ebyidentification")|addslashes()}{literal}'
					},
					Password:{
						required: '{/literal}{'registration_password_required'|i18n("extension/bouygues/ebyidentification")}{literal}'
					}
				}
		});
		
		
		$('#subscribeForm').validate({
				errorElement: "span",
				rules: {
					Login:{
						remote: "{/literal}{$localeUrl}{literal}/ebyidentification/emailexists/"
					},
					Password:{
						required: true
					}
				},
				messages: {
					Login: {
						required: '{/literal}{'registration_email_not_valid'|i18n("extension/bouygues/ebyidentification")|addslashes()}{literal}',
						email: '{/literal}{'registration_email_not_valid'|i18n("extension/bouygues/ebyidentification")|addslashes()}{literal}',
						remote: '{/literal}{'registration_forgotpassword_wrong_address_eby'|i18n("extension/bouygues/ebyidentification")|addslashes()}{literal}'
					},
					Password:{
						required: '{/literal}{'registration_password_required'|i18n("extension/bouygues/ebyidentification")}{literal}'
					}
				}
		});
	});
	
</script>
{/literal}