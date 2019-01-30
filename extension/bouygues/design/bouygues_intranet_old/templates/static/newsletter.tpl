{def $currentUser = fetch( 'user', 'current_user' )}	

<div class="default newsletter static">

	{include uri="design:blocs/tools.tpl" light=1 btn_back=1 btn_back_text="btn_back_text"|i18n("design/bouygues/tools") btn_back_url="/"|ezurl(no)}

	
	<h1> {'newsletter_title'|i18n('design/bouygues/static')|nl2br()} </h1>
	
	<div class="content1">
		<p>
			<h4>{'newsletter_subscribe1'|i18n('design/bouygues/static')|nl2br()}</h4>
			
			
			{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini') $filiere='' $containerNewsObj='' $classCss='' $lastnewsletter=''}
			{def $counter=1}
			{def $urlSubscribeTmp = '/profile/yournewsletter/subscribe/'}
			{def $urlSubscribe = ''}
			{foreach $newsletterlist as $data}
					{set $classCss = ''}
					{set $filiere = fetch( 'content', 'object',hash( 'object_id', $data.article_pool_object_id))}
					{set $containerNewsObj = fetch('content', 'object', hash('object_id', $data.article_pool_object_id))}
					
					{if $filiere.section_id|eq(16)}
					
						{if is_set($arrCssSubStructure[$filiere.section_id])}{set $classCss = $arrCssSubStructure[$filiere.section_id]}
						{else}{set $classCss = 'default'}{/if}

						{set $lastnewsletter = fetch('content', 'list', hash('parent_node_id', $containerNewsObj.main_node_id, 'class_filter_type', 'include', 'class_filter_array', array('newsletter_issue'), 'depth', '2', 'limit', 1, 'sort_by', array('published', false()) ))}

						<div class="contenteby">
							<div class="img"><img src="{concat('images/boxes/newsletter/',$classCss,'.gif')|ezdesign(no)}"/></div>
							<div class="description">
								<label class="color2-{$classCss}">{concat('title_',$classCss)|i18n('design/bouygues/newsletter')}</label>
								<p>{concat('desc_',$classCss)|i18n('design/bouygues/newsletter')|nl2br()}</p>
							</div>
							<div style="clear: both"></div>
							{if $currentUser.is_logged_in}
								{include uri="design:blocs/btn.tpl" label='newsletter_subscribe_link'|i18n('design/bouygues/static') url=$urlSubscribe align='left' onclick=concat('eby.newsletter(\'',$data.id,'\');return false;')}
							{else}
								{include uri="design:blocs/btn.tpl" label='newsletter_subscribe_link'|i18n('design/bouygues/static') url='/user/login'|ezurl(no) align='left' onclick='return false;' class='UserConnect' rel='/static/newsletter'|ezurl(no)}
							{/if}
							<div style="clear: both; margin: 5px 0px 0px 0px"></div>
							{if is_set($lastnewsletter.0)}<a href="/layout/set/newsletter{$lastnewsletter.0.url_alias|ezurl(no)}" class="color2-{$classCss} more" target="_blank"><img src="{'images/pictos/arrow-yourwhoswho.gif'|ezdesign(no)}"/>&nbsp;&nbsp;{"last_newsletter"|i18n("design/bouygues/master")}</a>{else}
							{/if}
    				
					   	 	
						</div>
						{if eq($counter, 2)}{set $counter=1}<div style="clear: both"></div>
						{else}{set $counter=inc($counter)}{/if}


					{/if}
			{/foreach}
			
			
		</p>
		
		<p>
			<h4>{'newsletter_subscribe2'|i18n('design/bouygues/static')|nl2br()}</h4>
			
			
			{set $counter=1}
			{set $urlSubscribe = ''}
			{foreach $newsletterlist as $data}
					{set $classCss = ''}
					{set $filiere = fetch( 'content', 'object',hash( 'object_id', $data.article_pool_object_id))}
					{set $containerNewsObj = fetch('content', 'object', hash('object_id', $data.article_pool_object_id))}
					
					{if and($filiere.section_id|eq(16)|not(), $filiere.current.contentobject.main_node.parent.data_map.newsletter_cb.value|eq(1))}
						{set $urlSubscribe = ''}{def $classCss = ''}
						{set $urlSubscribe=concat($urlSubscribeTmp,$data.id)}
						
						{if is_set($arrCssSubStructure[$filiere.section_id])}{set $classCss = $arrCssSubStructure[$filiere.section_id]}
						{else}{set $classCss = 'default'}{/if}

						{set $lastnewsletter = fetch('content', 'list', hash('parent_node_id', $containerNewsObj.main_node_id, 'class_filter_type', 'include', 'class_filter_array', array('newsletter_issue'), 'depth', '2', 'limit', 1, 'sort_by', array('published', false()) ))}
								
								
	
								<div class="content">
									<div class="img"><img src="{concat('images/boxes/newsletter/',$classCss,'.gif')|ezdesign(no)}"/></div>
									<div class="description">
										<label class="color2-{$classCss}">{concat('title_',$classCss)|i18n('design/bouygues/newsletter')}</label>
										<p>{concat('desc_',$classCss)|i18n('design/bouygues/newsletter')|nl2br()}</p>
									</div>
									<div style="clear: both"></div>
									{if $currentUser.is_logged_in}
										{include uri="design:blocs/btn.tpl" label='newsletter_subscribe_link'|i18n('design/bouygues/static') url=$urlSubscribe align='left' onclick=concat('eby.newsletter(\'',$data.id,'\');return false;')}
									{else}
									
										{include uri="design:blocs/btn.tpl" label='newsletter_subscribe_link'|i18n('design/bouygues/static') url='/user/login'|ezurl(no) align='left' onclick='return false;' class='UserConnect fromNewsletter' rel='/static/newsletter'|ezurl(no)}
									{/if}
									<div style="clear: both; margin: 5px 0px 0px 0px"></div>
									{if is_set($lastnewsletter.0)}<a href="/layout/set/newsletter{$lastnewsletter.0.url_alias|ezurl(no)}" class="color2-{$classCss} more" target="_blank"><img src="{'images/pictos/arrow-yourwhoswho.gif'|ezdesign(no)}"/>&nbsp;&nbsp;{"last_newsletter"|i18n("design/bouygues/master")}</a>{else}
									{/if}
            				
							   	 	
								</div>
								{if eq($counter, 2)}{set $counter=1}<div style="clear: both"></div>
	    						{else}{set $counter=inc($counter)}{/if}
					{/if}
			{/foreach}
			
			
		</p>
	</div

</div>