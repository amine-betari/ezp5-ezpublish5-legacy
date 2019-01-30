<div class="userRegistration">
	{include uri="design:blocs/tools.tpl" light=1}

	<h1>{"registration_confirmation_title"|i18n("extension/bouygues/ebyidentification")}</h1>
	
	{def $currentUser = fetch( 'user', 'current_user' )}
	<strong class="user-title">{"registration_confirmation_hi"|i18n("extension/bouygues/ebyidentification")} {$currentUser.contentobject.name}</strong>
	
	<p class="description">
	{"registration_confirmation_intro"|i18n("extension/bouygues/ebyidentification")|nl2br()}
	</p>
	
	<div class="columns">
		<div class="column">
		
			<img class="image" src={"user/ebyperso.gif"|ezimage} title="" alt=""/><br />
			
			<strong>{"registration_confirmation_ebyperso_title"|i18n("extension/bouygues/ebyidentification")|nl2br()}</strong>
			<p>{"registration_confirmation_ebyperso"|i18n("extension/bouygues/ebyidentification")|nl2br()}</p>
			<a href="{"/ebyperso/home"|ezurl(no)}" class="btn-grey-arrow-left">{"registration_confirmation_ebyperso_link"|i18n("extension/bouygues/ebyidentification")}</a>
			
		</div>
		
		<div class="column">
		
			<img class="image" src={"user/newsletter.gif"|ezimage} title="" alt=""/><br />
			
			<strong>{"registration_confirmation_newsletter_title"|i18n("extension/bouygues/ebyidentification")|nl2br()}</strong>
			<p>{"registration_confirmation_newsletter"|i18n("extension/bouygues/ebyidentification")|nl2br()}</p>
			<a href="{"/profile/yournewsletter"|ezurl(no)}" class="btn-grey-arrow-left">{"registration_confirmation_newsletter_link"|i18n("extension/bouygues/ebyidentification")}</a>
		
		</div>
		
		<div class="column">
			
			<img class="image" src={"user/maj.gif"|ezimage}  alt="{"registration_confirmation_maj"|i18n("extension/bouygues/ebyidentification")}"/><br />
			<strong>{"registration_confirmation_maj_title"|i18n("extension/bouygues/ebyidentification")|nl2br()}</strong>
			<p>{"registration_confirmation_maj"|i18n("extension/bouygues/ebyidentification")|nl2br()}</p>
		
		</div>
		
	</div>
	
	<div class="nice-visit">{"registration_confirmation_nicevisit"|i18n("extension/bouygues/ebyidentification")}</div>

</div>