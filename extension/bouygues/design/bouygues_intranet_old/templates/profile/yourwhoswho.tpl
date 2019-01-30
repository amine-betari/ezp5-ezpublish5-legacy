<div class="profile whoswho">
	{include uri="design:blocs/tools.tpl" light=1}
	
	<h1>{"whoswholist_title"|i18n("design/bouygues/whoswho")}</h1>
	{def $whoswho_search=''}
	{if $countSubscription|eq(0)}
	<div class="boxA">
		<div class="top">
			<div class="left"></div>
			<div class="right"></div>
			<div class="middle"></div>
		</div>
		<div class="content">{"whoswholist_nosubscription"|i18n("design/bouygues/whoswho")|nl2br()}</div>
		<div class="bottom">
			<div class="left"></div>
			<div class="right"></div>
			<div class="middle"></div>
		</div>
	</div>
	{else}
		{def $urlUnSubscribeTmp = '/profile/yourwhoswho/unsubscribe/'}
		{def $urlUnSubscribe = ''}
		{foreach $whoswholist as $data}
		
			{set $whoswho_search = fetch( 'content', 'tree', hash(
						  'parent_node_id', 2,
						  'class_filter_type',  'include',
						  'class_filter_array', array( 'bouygues_whoswho_search'),
						  'attribute_filter', array(array('section', '=', $data.object.section_id)),
						  'limit', 1,
						  'offset', 0,
						  'depth', 2,
						  'limitation', array()
						  ))}
		
			{set $urlUnSubscribe = ''}
			{set $urlUnSubscribe=concat($urlUnSubscribeTmp,$data.contentobject_id)}
			{if $whoswhouserlink[$data.contentobject_id]|eq(1)}
		
			{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}
			{if is_set($arrCssSubStructure[$data.object.section_id])}{def $classCss = $arrCssSubStructure[$data.object.section_id]}
			{else}{def $classCss = 'default'}{/if}
		
		<div class="boxA">
			<div class="top">
				<div class="left"></div>
				<div class="right"></div>
				<div class="middle"></div>
			</div>
			<div class="content">
				<div class="img"><img src="{'images/boxes/whoswho/picto-subscribed.gif'|ezdesign(no)}"/></div>
				<div class="description">
					<label class="color2-{$classCss}">{if $langCurrent|eq('')}{$data.data_map.titre.content}{else}{$data.data_map.titre_en.content}{/if}</label>
					<p>{$whoswho_search.0.data_map.accroche_liste.content.output.output_text}</p>
				</div>
				<a href="{concat($whoswho_search.0.url_alias, '/(userId)/',$user_id)|ezroot(no)}" class="color2-{$classCss} more"><img src="{'images/pictos/arrow-yourwhoswho.gif'|ezdesign(no)}"/>&nbsp;&nbsp;{"whoswholist_see"|i18n("design/bouygues/whoswho")} {if $langCurrent|eq('')}{$data.data_map.titre.content}{else}{$data.data_map.titre_en.content}{/if}</a>
		   	 	{include uri="design:blocs/btn.tpl" label="whoswholist_unsubscribe_sbumit"|i18n("design/bouygues/whoswho") url=$urlUnSubscribe align='left' class='whoswho-unsubscribe' onclick='return false;'}
			</div>
			<div class="bottom">
				<div class="left"></div>
				<div class="right"></div>
				<div class="middle"></div>
			</div>
		</div>
		{/if}
		{/foreach}
	
	{/if}
	
	<div class="newsletterSeparator"></div>
	
	<h4>{"whoswholist_subscribe_title"|i18n("design/bouygues/whoswho")}</h4>
	
											   
	{def $urlSubscribeTmp = '/profile/yourwhoswho/subscribe/'}
	{def $urlSubscribe = ''}
	
	{foreach $whoswholist as $data}{*$data|attribute('show',1)*}
	{set $urlSubscribe = ''}
	{set $urlSubscribe=concat($urlSubscribeTmp,$data.contentobject_id)}
	{if or($whoswhouserlink[$data.contentobject_id]|is_null(),$whoswhouserlink[$data.contentobject_id]|eq(0))}
	
	{set $whoswho_search = fetch( 'content', 'tree', hash(
				  'parent_node_id', 2,
				  'class_filter_type',  'include',
				  'class_filter_array', array( 'bouygues_whoswho_search'),
				  'attribute_filter', array(array('section', '=', $data.object.section_id)),
				  'limit', 1,
				  'offset', 0,
				  'depth', 2,
				  'limitation', array()
				  ))}
	<div class="element">
		{if $data.object.section_id|eq('7')}{def $classCss = 'communication'}
		{elseif $data.object.section_id|eq('6')}{def $classCss = 'consolidation'}
		{elseif $data.object.section_id|eq('8')}{def $classCss = 'controle_interne'}
		{elseif $data.object.section_id|eq('9')}{def $classCss = 'developpement_durable'}
		{elseif $data.object.section_id|eq('10')}{def $classCss = 'europe'}
		{elseif $data.object.section_id|eq('11')}{def $classCss = 'finance'}
		{elseif $data.object.section_id|eq('15')}{def $classCss = 'imb'}
		{elseif $data.object.section_id|eq('12')}{def $classCss = 'informatique'}
		{elseif $data.object.section_id|eq('13')}{def $classCss = 'innovation'}
        {elseif $data.object.section_id|eq('18')}{def $classCss = 'juridique'}
		{elseif $data.object.section_id|eq('14')}{def $classCss = 'rh'}
		{/if}
		
	    <label class="color2-{$classCss}">{if $langCurrent|eq('')}{$data.data_map.titre.content}{else}{$data.data_map.titre_en.content}{/if}</label>
	    <p>{$whoswho_search.0.data_map.accroche_liste.content.output.output_text}</p>
	    {include uri="design:blocs/btn.tpl" label="whoswholist_subscribe_sbumit"|i18n("design/bouygues/whoswho") url=$urlSubscribe align='left' class='whoswho-subscribe' onclick='return false;'}
	</div>
	{/if}
	{/foreach}


</div>