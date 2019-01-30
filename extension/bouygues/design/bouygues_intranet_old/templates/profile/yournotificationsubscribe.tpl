{def $object=fetch( 'content', 'node', hash( 'node_id', $nodeId ) )}

{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}
{if is_set($arrCssSubStructure[$object.object.section_id])}{def $classCss = $arrCssSubStructure[$object.object.section_id]}
{else}{def $classCss = 'default'}{/if}

{def $arrp = $object.object.assigned_nodes.0.url_alias|explode( '/' )}{def $stringTitle = ''}{def $parentNode = ''}{def $count = 0}{def $parentPath = ''}
{def $balBegin='' $baEnd=''}
{foreach $arrp as $p}

	{if $parentPath|eq('')|not()}{set $p = concat($parentPath,'/',$p)}{/if}
	{set $parentPath = $p}
	{set $parentNode=fetch( 'content', 'node', hash( 'node_path', $p ) )}
	
	
	{if eq(count($arrp), inc($count))}
		{set $balBegin = concat('color2-',$classCss)}
		{set $balEnd = ''}
	{/if}
	
	{if $parentNode}
		{if gt($count,0)}{set $stringTitle = concat($stringTitle, ' / ', '<span class="', $balBegin, '">', $parentNode.name, '</span>')}
		{else}{set $stringTitle = concat($stringTitle, '<span class="', $balBegin, '">', $parentNode.name, '</span>')}{/if}
	{/if}
	{set $count = inc($count)}
{/foreach}
			
<div class="default">
	<h1>{"yournotification_title_lightbox"|i18n('design/bouygues/notification')}</h1>

	<div class="notification-ajax-content">
	
		<h2>{"notification_desc"|i18n("design/bouygues/notification")|nl2br()}</h2>
		<div class="notification-bloc">
			<h2>{"message_confirm1"|i18n("design/bouygues/notification")|nl2br()}</h2>
			<span class="notification-path"><img src="{concat('images/breadcrumb/',$classCss,'/start_hard.gif')|ezdesign(no)}"/>  {$stringTitle}</span>
		</div>
		
		<div class="notification-footer">
			<span class="notification-all"><a href={concat($langCurrent,"/profile/yournotification")|ezroot()] title="{"all_notifications"|i18n("design/bouygues/notification")}" class="btn-hard-grey-arrow-left color2">{"all_notifications"|i18n("design/bouygues/notification")}</a></span>
			<div class="print-button print-bottom">
				
				{include uri="design:blocs/btn.tpl" label="cancel"|i18n("design/bouygues/notification") url='javascript:Lightbox.close()' align='right'}
				{include uri="design:blocs/btn.tpl" label="validate"|i18n("design/bouygues/notification") url=concat('/profile/yournotification/subscribe/',$nodeId,'/1') align='right' onclick='return false;' class='notification-subscribe-final'}
				
			</div>
		</div>
	</div>
	
</div>
{literal}
<script type="text/javascript">
	$().ready(function(){
		var hrefString = $('.notification-subscribe-final').attr('href');

		$('.notification-subscribe-final').unbind('click').click(function(){
			$.ajax({
				type: "POST",
				url: currentLang+'/layout/set/ajax2'+hrefString.replace('http://'+window.document.domain,'').replace('https://'+window.document.domain,''),
				success: function(msg){
					$('.notification-ajax-content').slideUp(500,function(){
		    			$(this).html(msg).slideDown(500);
		    		});
		    	}
			});
		});
	});
</script>
{/literal}