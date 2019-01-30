<div class="userRegistration">
{include uri="design:blocs/tools.tpl" light=1}
{section show=$link}
	<h1>{'registration_forgotpassword_passwordgenerated'|i18n('extension/bouygues/ebyidentification')}</h1>
	<p>{'registration_forgotpassword_passwordgenerated_intro'|i18n('extension/bouygues/ebyidentification')|nl2br()}</p>
	
	
{section-else}
   {section show=$generated}
	   <h1>{'registration_forgotpassword_passwordgenerated'|i18n('extension/bouygues/ebyidentification')}</h1>
	   <p>{'registration_forgotpassword_passwordgenerated_intro2'|i18n('extension/bouygues/ebyidentification')|nl2br()}</p>


   {section-else}
      {section show=$wrong_key}
		  <h1>{"The key is invalid or has been used. "|i18n('design/standard/user/forgotpassword')}</h1>
      {section-else}
	      
	    <div class="top">
	      <h1>{'registration_forgotpassword_title'|i18n('extension/bouygues/ebyidentification')}</h1>
	
	      	<p>{'registration_forgotpassword_intro'|i18n('extension/bouygues/ebyidentification')|nl2br()}</p>
	    </div>
	    <form method="post" name="forgotpassword" action={"/ebyidentification/forgotpassword/"|ezurl} id="forgotpasswordForm">
	      <input type="hidden" name="GenerateButton" value="GenerateButton">
	      <div class="element">
	      <label for="email_register">{"Email"|i18n('extension/bouygues/ebyidentification')}</label>
	      <input type="text" name="UserEmail" size="40" value="{$wrong_email|wash}" id="email_register" class="halfbox required email"//>
			{section show=$wrong_email}
			   <span class="error">{'registration_forgotpassword_wrong_address_eby'|i18n('extension/bouygues/ebyidentification')|nl2br()}</span>
		   {/section}
	      </div>

	      <div class="element right">
	      		 <!--<span class="fSmall">{'Obligatory field'|i18n('extension/bouygues/ebyidentification')}</span>-->
				{include uri="design:blocs/btn.tpl" label='registration_forgotpassword_validate'|i18n('extension/bouygues/ebyidentification') url='#' submit=concat('forgotpasswordForm')}
				
	      </div>
	      
	      </form>
      {/section}
   {/section}
{/section}
</div>

{literal}
<script type="text/javascript">
	$().ready(function(){
		
			$('#forgotpasswordForm').validate({
				errorElement: "span",
				messages: {
					UserEmail: {
						required: '{/literal}{'registration_email_not_valid'|i18n("extension/bouygues/ebyidentification")|addslashes()}{literal}',
						email: '{/literal}{'registration_email_not_valid'|i18n("extension/bouygues/ebyidentification")|addslashes()}{literal}'
					}
				}
			});
		
	});
</script>
{/literal}