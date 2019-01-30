{set-block scope=global variable=cache_ttl}0{/set-block}
<li class="widget bourse" id="widget{$id}">  
	<form id="form{$id}">
	<div class="widget-head"></div>
	<div class="widget-title">
		<h3><img src={"pictos/ebyperso_cac.gif"|ezimage} alt="" /> {'widget_market_title'|i18n('design/bouygues/ebyperso')}</h3>
	</div>
	<div class="widget-content">
	<div class="widget-overview">
	<p>
		{foreach $cotations as $cot}
			<span class="blue boursename">{$cot.nom}</span> : {$cot.cotation} €<br />
		{/foreach}
	</p>
	</div>	
	</div>
	<div class="widget-bottom"></div>
	</form>
</li>