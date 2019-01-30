{def $contacGroups = fetch('content', 'node', hash(
								'node_id', $contactNodeId
								)
							)}

<div class="default">
	<h1>{"contact_submitted_title"|i18n("design/bouygues/static")}</h1>
	<h2>{"contact_submitted_desc"|i18n("design/bouygues/static")|nl2br()}<br/>- {$contacGroups.object.name}</h2>
	
	<p>
	<img src="{'images/arrows/arrowB.png'|ezdesign(no)}"/> <a href="#" title="" class="color2" onclick="Lightbox.close();return false">{"contact_submitted_link"|i18n("design/bouygues/static")}</a>
	</p>
</div>