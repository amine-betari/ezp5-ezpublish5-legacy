<div class="profile newsletter">
	{include uri="design:blocs/tools.tpl" light=1}
	
	<h1>{"yournewsletter_title"|i18n("design/bouygues/newsletter")}</h1>
	{def $filiere = ''} {def $counterNotSub=1}
	{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}
	{if $countSubscription|eq(0)}
	<div class="boxA">
		<div class="top">
			<div class="left"></div>
			<div class="right"></div>
			<div class="middle"></div>
		</div>
		<div class="content">{"yournewsletter_no_subscription"|i18n("design/bouygues/newsletter")|nl2br()}</div>
		<div class="bottom">
			<div class="left"></div>
			<div class="right"></div>
			<div class="middle"></div>
		</div>
	</div>
	{else}
		{def $urlUnSubscribeTmp = '/profile/yournewsletter/unsubscribe/'}
		{def $urlUnSubscribe = '' $classCss='default' $lastnewsletter='' $containerNewsObj=''}
		{set $counterNotSub=0}
		{foreach $newsletterlist as $data}
			
		
			{set $urlUnSubscribe = ''}{def $classCss = ''}
			{set $urlUnSubscribe=concat($urlUnSubscribeTmp,$data.id)|ezurl(no)}
			{set $filiere = fetch( 'content', 'object',hash( 'object_id', $data.article_pool_object_id))}
			{if or(
					and($newsletterUserLink[$data.listId]|is_null()|not(), $filiere.current.contentobject.main_node.parent.data_map.newsletter_cb.value|eq(1)), 
					and($newsletterUserLink[$data.listId]|is_null()|not(), $filiere.section_id|eq(16)))}

				
				{set $containerNewsObj = fetch('content', 'object', hash('object_id', $data.article_pool_object_id))}

				{if is_set($arrCssSubStructure[$filiere.section_id])}{set $classCss = $arrCssSubStructure[$filiere.section_id]}
				{else}{set $classCss = 'default'}{/if}
	
				{set $lastnewsletter = fetch('content', 'list', hash('parent_node_id', $containerNewsObj.main_node_id, 'class_filter_type', 'include', 'class_filter_array', array('newsletter_issue'), 'depth', '2', 'limit', 1, 'sort_by', array('published', false()) ))}
	
		<div class="boxA">
			<div class="top">
				<div class="left"></div>
				<div class="right"></div>
				<div class="middle"></div>
			</div>
			<div class="content">
				<div class="img"><img src="{concat('images/boxes/newsletter/',$classCss,'.gif')|ezdesign(no)}"/></div>
				<div class="description">
					<label class="color2-{$classCss}">{concat('title_',$classCss)|i18n('design/bouygues/newsletter')}</label>
					<p>{concat('desc_',$classCss)|i18n('design/bouygues/newsletter')|nl2br()}</p>
				</div>
				<div style="clear: both"></div>
				{if is_set($lastnewsletter.0)}<a href="{concat('/layout/set/newsletter/',$lastnewsletter.0.url_alias, '/(newsid)/', $data.id)|ezurl(no)}" class="color2-{$classCss} more" target="_blank"><img src="{'images/pictos/arrow-yourwhoswho.gif'|ezdesign(no)}"/>&nbsp;&nbsp;{"last_newsletter"|i18n("design/bouygues/master")}</a>{else}
				<div style="clear: both; margin: 8px 0px 0px 0px"></div>
				{/if}
				
		   	 	{include uri="design:blocs/btn.tpl" label="yournewsletter_unsubscribe"|i18n("design/bouygues/newsletter") url=$urlUnSubscribe align='left'}
			</div>
			<div class="bottom">
				<div class="left"></div>
				<div class="right"></div>
				<div class="middle"></div>
			</div>
		</div>
			{elseif or(
					and($newsletterUserLink[$data.listId]|is_null(), $filiere.current.contentobject.main_node.parent.data_map.newsletter_cb.value|eq(1)),
					and($newsletterUserLink[$data.listId]|is_null(), $filiere.section_id|eq(16)))}
				{set $counterNotSub=1}
			{/if}
		{/foreach}
	
	{/if}
	
	{if $counterNotSub|eq(1)}
	<div class="newsletterSeparator"></div>
	
	<h4>{"yournewsletter_subscribe_title"|i18n("design/bouygues/newsletter")}</h4>
	
											   
	{def $urlSubscribeTmp = '/profile/yournewsletter/subscribe/'}
	{def $urlSubscribe = ''}
	
	{foreach $newsletterlist as $data}
	{set $urlSubscribe = ''}{def $classCss = ''}
	{set $urlSubscribe=concat($urlSubscribeTmp,$data.id)|ezurl(no)}
	{set $filiere = fetch( 'content', 'object',hash( 'object_id', $data.article_pool_object_id))}

	{if or(
			and($newsletterUserLink[$data.listId]|is_null(),$filiere.current.contentobject.main_node.parent.data_map.newsletter_cb.value|eq(1)),
			and($newsletterUserLink[$data.listId]|is_null(),$filiere.section_id|eq(16)))}
	<div class="element">
		

		{if is_set($arrCssSubStructure[$filiere.section_id])}{set $classCss = $arrCssSubStructure[$filiere.section_id]}
		{else}{set $classCss = 'default'}{/if}
		<div class="img"><img src="{concat('images/boxes/newsletter/',$classCss,'.gif')|ezdesign(no)}"/></div>
	    
	    <div class="description">
		    <label class="color2-{$classCss}">{concat('title_',$classCss)|i18n('design/bouygues/newsletter')}</label>
		    <p>{concat('desc_',$classCss)|i18n('design/bouygues/newsletter')|nl2br()}</p>

	    </div>
		<div style="clear: both"></div>
		<div style="float:left; margin: 8px 0px 0px 0px">
		<!--<a href="#" class="color2-{$classCss} more"><img src="{'images/pictos/arrow-yourwhoswho.gif'|ezdesign(no)}"/>&nbsp;&nbsp;Visualisez la dernière newsletter</a>-->
	    {include uri="design:blocs/btn.tpl" label="yournewsletter_subscribe_request"|i18n("design/bouygues/newsletter") url=$urlSubscribe align='left'}
		</div>
	</div>
	{/if}
	{/foreach}
	{/if}
	{undef $filiere}

</div>
{literal}
<script type="text/javascript">
	$().ready(function(){
{/literal}

{if is_set($subscribed)}eby.newsletterSubscription();{/if}
{if is_set($unsubscribed)}eby.newsletterUnSubscription();{/if}

{literal}
	});
</script>{/literal}
