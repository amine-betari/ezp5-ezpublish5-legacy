<div class="profile notification">

	{include uri="design:blocs/tools.tpl" light=1}
	
	<h1>{"yournotification_title"|i18n('design/bouygues/notification')}</h1>
	
	{def $notifications_count = fetch('notification', 'subscribed_nodes_count')}	
	{if $notifications_count|eq(0)}
	
		<div class="content">
			<div class="img"><img src="{'images/boxes/notification/default.gif'|ezdesign(no)}"/></div>
			<div class="description">
				<label class="color2-{$classCss}"><strong>{"yournotification_no_subscription_label"|i18n('design/bouygues/notification')}</strong></label>
				<p>{"yournotification_no_subscription"|i18n('design/bouygues/notification')}</p>
			</div>
		</div>
		
	{else}
		<h3>{"yournotification_subscription_title"|i18n('design/bouygues/notification')}</h3>
		
		<div class="notification-list">
		{def $notifications = fetch('notification', 'subscribed_nodes')}
		{foreach $notifications as $notification}
		
			{def $object=fetch( 'content', 'node', hash( 'node_id', $notification.node_id ) )}

			{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}
			{if is_set($arrCssSubStructure[$object.object.section_id])}{def $classCss = $arrCssSubStructure[$object.object.section_id]}
			{else}{def $classCss = 'default'}{/if}
			
			{def $arrp = $object.object.assigned_nodes.0.url_alias|explode( '/' )}{def $stringTitle = ''}{def $parentNode = ''}{def $count = 0}{def $parentPath = ''}
			{def $balBegin='' $baEnd=''}
			{foreach $arrp as $p}
				{set $balBegin = ''}
				{if $parentPath|eq('')|not()}{set $p = concat($parentPath,'/',$p)}{/if}
				{set $parentPath = $p}
				{set $parentNode=fetch( 'content', 'node', hash( 'node_path', $p ) )}
				
				{if eq(count($arrp), inc($count))}
					{set $balBegin = concat('color2-',$classCss)}
					{set $balEnd = ''}
				
				{/if}
				
				{if $parentNode}
					{if gt($count,0)}
						{if $balBegin|eq('')|not()}
							{set $stringTitle = concat($stringTitle, ' / ', '<a href="',$parentNode.url_alias|ezurl(no),'" class="',$balBegin,'">', $parentNode.name, '</a>')}
						{else}
							{set $stringTitle = concat($stringTitle, ' / ', $parentNode.name)}
						{/if}
					{else}
						{if $balBegin|eq('')|not()}
							{set $stringTitle = concat($stringTitle, ' ', '<a href="',$parentNode.url_alias|ezurl(no),'" class="',$balBegin,'">', $parentNode.name, '</a>')}
						{else}
							{set $stringTitle = concat($stringTitle, ' ', $parentNode.name)}
						{/if}
					{/if}
				{/if}
				{set $count = inc($count)}
			{/foreach}
			<div class="notification-item">
				<span class="path"><img src="{concat('images/breadcrumb/',$classCss,'/start_hard.gif')|ezdesign(no)}"/>{$stringTitle}</span>
				<div class="notification-button">
					{include uri="design:blocs/btn.tpl" label="btn_unsubscribe"|i18n('design/bouygues/notification') url=concat('/profile/yournotification/unsubscribe/',$notification.node_id)|ezurl(no) align='right'}
				</div>
			</div>
			
			{undef $classCss $object $arrp $stringTitle $parentNode $count $parentPath $balBegin $balEnd}
		{/foreach}
		</div>
	{/if}
	
</div>
{literal}
<script type="text/javascript">
	$().ready(function(){
{/literal}

{if is_set($unsubscribed)}eby.notificationUnSubscription();{/if}

{literal}
	});
</script>{/literal}
