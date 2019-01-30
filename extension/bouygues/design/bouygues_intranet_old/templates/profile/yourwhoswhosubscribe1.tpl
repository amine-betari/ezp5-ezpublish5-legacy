{def $object=fetch( 'content', 'object', hash( 'object_id', $nodeId ) )}

{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}
{if is_set($arrCssSubStructure[$object.object.section_id])}{def $classCss = $arrCssSubStructure[$object.section_id]}
{else}{def $classCss = 'default'}{/if}
			
<div class="default">
	<h1>{"subscribe_title"|i18n('design/bouygues/whoswho')}</h1>

	<div class="notification-ajax-content">
	
		<h2>{"subscribe_desc"|i18n("design/bouygues/whoswho")} {$whowho_name}{"subscribe_desc2"|i18n("design/bouygues/whoswho")}</h2>
		<textarea name="message" class="whoswhoSubscriptionTextarea"></textarea>
		
		<div class="notification-footer">
			<div class="print-button print-bottom">
				{include uri="design:blocs/btn.tpl" label="cancel"|i18n("design/bouygues/notification") url='javascript:Lightbox.close()' align='right'}
				{include uri="design:blocs/btn.tpl" label="validate"|i18n("design/bouygues/notification") url=concat('/profile/yourwhoswho/subscribe/',$nodeId,'/1') align='right' onclick='return false;' class='whoswho-subscribe-final'}
				
			</div>
		</div>
	</div>
	
</div>

{literal}
<script type="text/javascript">
	$().ready(function(){
		var hrefString = $('.whoswho-subscribe-final').attr('href');

		$('.whoswho-subscribe-final').unbind('click').click(function(){
			$.ajax({
				type: "POST",
				url: currentLang+'/layout/set/ajax2'+hrefString.replace('http://'+window.document.domain,'').replace('https://'+window.document.domain,''),
				data: "message="+$('textarea[name=message]').val(),
				success: function(msg){
		    		$('.notification-ajax-content').slideUp(500,function(){
						$(this).load({/literal}currentLang+'{concat('/layout/set/ajax2/profile/yourwhoswho/subscribemessage/',$nodeId)}'{literal},{}, function(){
	$(this).slideDown(500);	
	});
						
		    			
		    		});
		    	}
			});
		});
	});
</script>
{/literal}