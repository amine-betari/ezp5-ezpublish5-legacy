<li class="widget meteo" id="widget{$id}">  
	<form id="form{$id}">
	<div class="widget-head"></div>
		<div class="edit-box" style="display:none;" >
			<div class="widget-edit-content">
				<fieldset>
				<legend><img src={"pictos/ebyperso_meteo.gif"|ezimage} alt="" /> {'widget_weather_title'|i18n('design/bouygues/ebyperso')}</legend>
				<p>
				<label>{'widget_weather_select'|i18n('design/bouygues/ebyperso')}</label><br />
				<select id="select-city-one" name="ville1">
				<option value=""></option>
				{foreach $liste_ville as $key => $vil}
					
						<option value="{$key}" {if and(is_set($arrVillesSel.0), $arrVillesSel.0.id|eq($key))}selected{/if} {if or($arrVillesSel.1.id|eq($key),$arrVillesSel.2.id|eq($key),$arrVillesSel.3.id|eq($key),$arrVillesSel.4.id|eq($key),$arrVillesSel.5.id|eq($key))}disabled="disabled"{/if}>{$vil|i18n('design/bouygues/ebyperso')}</option>
					
				{/foreach}
				</select>
				</p>
				<p>
				<select id="select-city-two" name="ville2">
				<option value=""></option>
				{foreach $liste_ville as $key => $vil}
					
						<option value="{$key}" {if and(is_set($arrVillesSel.1), $arrVillesSel.1.id|eq($key))}selected{/if} {if or($arrVillesSel.0.id|eq($key),$arrVillesSel.2.id|eq($key),$arrVillesSel.3.id|eq($key),$arrVillesSel.4.id|eq($key),$arrVillesSel.5.id|eq($key))}disabled="disabled"{/if}>{$vil|i18n('design/bouygues/ebyperso')}</option>
					
				{/foreach}
				{undef $selectedCity}
				</select>			
				</p>
				<p>
				<select id="select-city-three" name="ville3">
				<option value=""></option>
				{foreach $liste_ville as $key => $vil}
					
						<option value="{$key}" {if and(is_set($arrVillesSel.2), $arrVillesSel.2.id|eq($key))}selected{/if} {if or($arrVillesSel.1.id|eq($key),$arrVillesSel.0.id|eq($key),$arrVillesSel.3.id|eq($key),$arrVillesSel.4.id|eq($key),$arrVillesSel.5.id|eq($key))}disabled="disabled"{/if}>{$vil|i18n('design/bouygues/ebyperso')}</option>
					
				{/foreach}
				{undef $selectedCity}
				</select>			
				</p>
				<p>
				<select id="select-city-four" name="ville4">
				<option value=""></option>
				{foreach $liste_ville as $key => $vil}
					
						<option value="{$key}" {if and(is_set($arrVillesSel.3), $arrVillesSel.3.id|eq($key))}selected{/if} {if or($arrVillesSel.1.id|eq($key),$arrVillesSel.2.id|eq($key),$arrVillesSel.0.id|eq($key),$arrVillesSel.4.id|eq($key),$arrVillesSel.5.id|eq($key))}disabled="disabled"{/if}>{$vil|i18n('design/bouygues/ebyperso')}</option>
					
				{/foreach}
				{undef $selectedCity}
				</select>			
				</p>
				<p>
				<select id="select-city-five" name="ville5">
				<option value=""></option>
				{foreach $liste_ville as $key => $vil}
					
						<option value="{$key}" {if and(is_set($arrVillesSel.4), $arrVillesSel.4.id|eq($key))}selected{/if} {if or($arrVillesSel.1.id|eq($key),$arrVillesSel.2.id|eq($key),$arrVillesSel.3.id|eq($key),$arrVillesSel.0.id|eq($key),$arrVillesSel.5.id|eq($key))}disabled="disabled"{/if}>{$vil|i18n('design/bouygues/ebyperso')}</option>
					
				{/foreach}
				{undef $selectedCity}
				</select>			
				</p>
				<p>
				<select id="select-city-six" name="ville6">
				<option value=""></option>
				{foreach $liste_ville as $key => $vil}
					
						<option value="{$key}" {if and(is_set($arrVillesSel.5), $arrVillesSel.5.id|eq($key))}selected{/if} {if or($arrVillesSel.1.id|eq($key),$arrVillesSel.2.id|eq($key),$arrVillesSel.3.id|eq($key),$arrVillesSel.4.id|eq($key),$arrVillesSel.0.id|eq($key))}disabled="disabled"{/if}>{$vil|i18n('design/bouygues/ebyperso')}</option>
					
				{/foreach}
				{undef $selectedCity}
				</select>			
				</p>

				
				{include uri="design:blocs/btn.tpl" label='widget_cancel'|i18n('design/bouygues/ebyperso') url='#' onclick='return false;' class='closeMeteoWidget' align='right'}
				{include uri="design:blocs/btn.tpl" label='widget_validate'|i18n('design/bouygues/ebyperso') url='#' submit=concat('form',$id) align='right'}
				
					
				</fieldset>
			</div>
			<div class="widget-edit-bottom"></div>
		</div>
	<div class="widget-title">
		<h3><img src={"pictos/ebyperso_meteo.gif"|ezimage} alt="" /> {'widget_weather_title'|i18n('design/bouygues/ebyperso')}</h3>
	</div>
	<div class="widget-content">
		<div class="widget-overview">
		{if is_set( $arrVillesSel )}{$arrVillesSel.attribute('show')}
			{foreach $arrVillesSel as $ville}
				{if $ville.id|eq('')|not()}
				<div id="{$ville.id}" class="widget-content-column weather">
					<span class="city">{$ville.nom|i18n('design/bouygues/ebyperso')}</span>
					<span class="hour_text">{'widget_weather_localtime'|i18n('design/bouygues/ebyperso')}</span>
					<span class="hour_data">{$ville.time}</span>
					<div class="weather_data">
						<img src="{$ville.now.icon}" />
					</div>
					<span class="degree">MIN : {$ville.now.low}° C <br /> MAX : {$ville.now.high}° C</span>
					<br />
					<span class="degree"><strong>{'widget_weather_tomorrow'|i18n('design/bouygues/ebyperso')} :</strong><br />{$ville.futur.text|i18n('design/bouygues/ebyperso')}</span>
					<span class="degree">MIN : {$ville.futur.low}° C <br /> MAX : {$ville.futur.high}° C</span>
				</div>
				{/if}
			{/foreach}
		{/if}
		</div>
	</div>
	<input type="hidden" name="villes[]" id="newville" value="" />
	<div class="widget-bottom"></div>
		</form>
</li>
<script type="text/javascript">
$("form#form{$id}").submit(function(){ldelim}
	updSettings({$id});
	return false;
{rdelim});
</script>