{def $object=fetch( 'content', 'object', hash( 'object_id', $nodeId ) )}

{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}
{if is_set($arrCssSubStructure[$object.object.section_id])}{def $classCss = $arrCssSubStructure[$object.section_id]}
{else}{def $classCss = 'default'}{/if}
			
<div class="default">
	<h1>{"unsubscribe_title"|i18n('design/bouygues/whoswho')}</h1>

	<div class="whoswho-ajax-content">
	
		<h2>{"unsubscribe_desc"|i18n("design/bouygues/whoswho")} {$whowho_name} {"unsubscribe_desc2"|i18n("design/bouygues/whoswho")}</h2>
		
		<div class="notification-footer">
			<div class="print-button print-bottom">
				{include uri="design:blocs/btn.tpl" label="cancel"|i18n("design/bouygues/notification") url='javascript:Lightbox.close()' align='right'}
				{include uri="design:blocs/btn.tpl" label="validate"|i18n("design/bouygues/notification") url=concat('/profile/yourwhoswho/unsubscribed/',$nodeId) align='right' onclick='return false;' class='whoswho-unsubscribe-final'}
				
			</div>
		</div>
	</div>
	
</div>

{literal}
<script type="text/javascript">
	$().ready(function(){
		var hrefString = $('.whoswho-unsubscribe-final').attr('href');

		$('.whoswho-unsubscribe-final').unbind('click').click(function(){
			if(eby.isAjax == false){
				eby.isAjax = true;
				$.ajax({
					type: "POST",
					async: "false",
					url: currentLang+'/layout/set/ajax2'+hrefString.replace('http://'+window.document.domain,'').replace('https://'+window.document.domain,''),
					success: function(msg){
		    			$('.whoswho-ajax-content').slideUp(500,function(){
		    				$(this).load({/literal}currentLang+'{concat('/layout/set/ajax2/profile/yourwhoswho/unsubscribedmessage/',$nodeId)}'{literal},{}, function(){
		$(this).slideDown(500);	
		});
							eby.isAjax = false;
		    			});
		    		}
				});
			}
		});
	});
</script>
{/literal}