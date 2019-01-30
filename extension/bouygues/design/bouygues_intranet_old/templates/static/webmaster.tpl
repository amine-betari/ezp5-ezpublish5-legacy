{def $currentUser = fetch( 'user', 'current_user' )	}
<div class="default footer static">
	{include uri="design:blocs/tools.tpl" light=1}
	{def $my_node=fetch( 'content', 'node', hash( 'node_id', 11390 ) )}
												  
	<h1>{$my_node.data_map.title.content}</h1>
	
	{$my_node.data_map.content.content.output.output_text}
	
	{def $contactNodeId = ezini( 'UserSettings', 'AdminContactGroupNodeID', 'bouygues.ini' )}
	{def $contacGroups = fetch('content', 'tree', hash(
									'parent_node_id', $contactNodeId,
									'class_filter_type', 'include',
									'class_filter_array', array('user_group'),
									'depth', 1,
									'limitation', array(),
									'sort_by', array(array('priority'))
									)
								)}
	<div class="contact">
	<form action="{'/static/webmaster'|ezurl(no)}" method="post" name="contactForm" id="contactFormAjax">
		<p>
		<label for="who">{'contact_who'|i18n('design/bouygues/static')}</label>
		<select class="select required" id="who" name="who" title="{'contact_who_error'|i18n('design/bouygues/static')}"/>
			{foreach $contacGroups as $contacGroup}
			<option value="{$contacGroup.node_id}">{$contacGroup.object.name}</option>
			{/foreach}
		</select>
		</p>
		
		<p>
		<label for="email">{'contact_email'|i18n('design/bouygues/static')}</label>
		<input type="text" id="email" name="email" class="text required email" value="{if $currentUser.is_logged_in}{$currentUser.email}{/if}"/>
		</p>
		
		<p>
		<label for="subject">{'contact_subject'|i18n('design/bouygues/static')} </label>
		<input type="text" id="subject" name="subject" class="text" />
		</p>
		
		<p>
		<label for="message">{'contact_message'|i18n('design/bouygues/static')}</label>
		<textarea class="textarea required" id="message" name="message"></textarea>
		</p>
		
		<p class="block right">
			 <span class="fSmall">{'Obligatory field'|i18n('extension/bouygues/ebyidentification')}</span><br/>
			{include uri="design:blocs/btn.tpl" label='widget_validate'|i18n('design/bouygues/ebyperso') url='#' submit=concat('contactFormAjax')}
		</p>
	</form>
	</div>
	
	
</div>


{literal}
<script type="text/javascript">
	$().ready(function(){
		
		var options = {
			url :currentLang+'/layout/set/ajax2/static/webmaster',
			success : function(msg) {
				eby.contactOk(msg);
			}
		}
		
		$('form[name=contactForm]').validate({
			 	errorElement: "span",
	          	messages: {
					email: {
						email: "{/literal}{'contact_email_invalid'|i18n('design/bouygues/contact')}{literal}"
					},
					message: {
						required: "{/literal}{'contact_message_error'|i18n('design/bouygues/static')}{literal}"
					}
				},
				submitHandler : function(error) {
					$('form[name=contactForm]').ajaxSubmit(options);
				}
		});
	});
</script>
{/literal}