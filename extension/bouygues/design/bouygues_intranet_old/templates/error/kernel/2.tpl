<div class="default errorPage">
	{include uri="design:blocs/tools.tpl" light=1}
	
	<h1>{"error_404_title"|i18n("extension/bouygues/error")}</h1>
	<p class="description">{"error_404_desc"|i18n("extension/bouygues/error")|nl2br()}</p>
	<p>
	<img src="{'images/arrows/arrowB.png'|ezdesign(no)}"/> <a href={"/"|ezroot()} title="" class="color2">{"error_404_link"|i18n("extension/bouygues/error")}</a>
	</p>
</div>