<div class="default errorPage">
	
	{include uri="design:blocs/tools.tpl" light=1}
	
	<h1>{"error_restricted_title"|i18n("extension/bouygues/error")}</h1>
	<p class="description">{"error_restricted_desc"|i18n("extension/bouygues/error")|nl2br()}</p>
	<p>
	<img src="{'images/arrows/arrowB.png'|ezdesign(no)}"/> <a href={"/"|ezurl()} title="" class="color2">{"error_restricted_link"|i18n("extension/bouygues/error")}</a>
	</p>
</div>