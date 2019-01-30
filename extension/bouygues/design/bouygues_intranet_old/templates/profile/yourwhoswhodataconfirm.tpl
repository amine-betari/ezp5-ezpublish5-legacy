{def $subscriptions = fetch('whoswho', 'whoswho_user')}

<div class="default">
	<h1>{"whoswho_lightbox_title"|i18n("design/bouygues/whoswho")}</h1>
	<h2>{"whoswho_lightbox_desc"|i18n("design/bouygues/whoswho")}</h2>
	
	<p>
	{foreach $subscriptions as $subscription}
		{def $whoswho_search = fetch( 'content', 'tree', hash(
					  'parent_node_id', 2,
					  'class_filter_type',  'include',
					  'class_filter_array', array( 'bouygues_whoswho_search', 'bouygues_whoswho_list'),
					  'attribute_filter', array(array('section', '=', $subscription.object.section_id)),
					  'limit', 1,
					  'offset', 0,
					  'depth', 10,
					  'limitation', array()
					  ))}
	<img src="{'images/arrows/arrowB.png'|ezdesign(no)}"/> <a href={concat($langCurrent,'/',$whoswho_search.0.url_alias, '/(userId)/',$user_id)|ezroot()} title="" class="color2">{"whoswho_lightbox_link"|i18n("design/bouygues/whoswho")} {$subscription.data_map.titre.content}</a><br/>
	{/foreach}
	</p>
</div>