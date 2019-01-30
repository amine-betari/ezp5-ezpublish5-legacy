{def $currentUser = fetch( 'user', 'current_user' )}	
<div class="default eby_perso_faq static">
<script type="text/javascript" src={concat('javascript/jquery-ui-1.8.6.custom.min.js')|ezdesign(no)}></script>
<script type="text/javascript" src={'javascript/xhttpr.js'|ezdesign}></script>
<script type="text/javascript" src={'javascript/ebyperso-faq.js'|ezdesign}></script>

 	{if $currentUser.is_logged_in}
 		{include uri="design:blocs/tools.tpl" light=1 btn_back=1 btn_back_text="ebyperso_link_home"|i18n("design/bouygues/static") btn_back_url="/ebyperso/home"|ezurl(no)}
	{else}
		{include uri="design:blocs/tools.tpl" light=1 btn_auth=1}
	{/if}
	
	<h1> {if $currentUser.is_logged_in}{'ebyperso_title2'|i18n('design/bouygues/static')}
	{else}{'ebyperso_title1'|i18n('design/bouygues/static')}{/if}</h1>
	
	<div class="content1">
		<p>
			<h4>{'ebyperso_content1_title'|i18n('design/bouygues/static')}</h4>
			{'ebyperso_content1_p'|i18n('design/bouygues/static')|nl2br()}
		</p>
	</div>
	
	<div class="columns">
		<div class="column1">
		
		<h4>{'ebyperso_content2_title'|i18n('design/bouygues/static')}</h4>
			<ol>
				<li>{'ebyperso_content2_p1'|i18n('design/bouygues/static')|nl2br()}</li>
				<li>{'ebyperso_content2_p2'|i18n('design/bouygues/static')|nl2br()}</li>
				<li>{'ebyperso_content2_p3'|i18n('design/bouygues/static')|nl2br()}</li>
				<li>{'ebyperso_content2_p4'|i18n('design/bouygues/static')|nl2br()}</li>
			</ol>
			
			{def $langPlayer='fr'}
			{literal}
			<script language="javascript">
				if (AC_FL_RunContent == 0) {
					alert("This page requires AC_RunActiveContent.js.");
				} else {
					{/literal}
					AC_FL_RunContent(
						'codebase', 'https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0',
						'width', '422',
						'height', '320',
						'src', '/extension/bouygues/design/bouygues_intranet/swf/eby_perso',
						'quality', 'high',
						'pluginspage', 'http://www.macromedia.com/go/getflashplayer',
						'align', 'middle',
						'play', 'true',
						'loop', 'true',
						'scale', 'scale',
						'wmode', 'transparent',
						'devicefont', 'false',
						'id', 'IntranetPlayer',
						'bgcolor', '#FFFFFF',
						'name', 'IntranetPlayer',
						'menu', 'true',
						'allowFullScreen', 'true',
						'allowScriptAccess','always',
						'movie', '/extension/bouygues/design/bouygues_intranet/swf/eby_perso',
						'salign', 'lt'
						); //end AC code 
						{literal}
				}
			</script>
			{/literal}
			<noscript>
				<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-443203542422" codebase="https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" width="422" height="320" id="IntranetPlayer" align="middle">
				<param name="allowScriptAccess" value="always" />
				<param name="allowFullScreen" value="true" />
				<param name="movie" value="/extension/bouygues/design/bouygues_intranet/swf/eby_perso.swf" />
				<param name="quality" value="high" />
				<param name="scale" value="noscale" />
				<param name="bgcolor" value="#FFFFFF" />

				<embed src="/extension/bouygues/design/bouygues_intranet/swf/eby_perso.swf" 
				quality="high" bgcolor="#FFFFFF" 
				scale="scale" 
				width="422" height="320" 
				name="IntranetPlayer" align="middle" allowScriptAccess="always" allowFullScreen="true" 
				type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
				</object>
			</noscript>
			
			
		</div>
		<div class="column2">
			<div class="boxA">
								<div class="top">
									<div class="left"></div>
									<div class="right"></div>
									<div class="middle"></div>
								</div>
								<div class="content">
									<strong class="title">{'ebyperso_service_title'|i18n('design/bouygues/static')|nl2br()}</strong>
									<div class="overview">
										{def $chekUserWidget = isUserWidget($currentUser.contentobject_id, 2)}
										<div class="item">
											{if and($currentUser.is_logged_in, $chekUserWidget|eq(true())|not())}<div class="item-button" id="widget_2">{include uri="design:blocs/btn.tpl" label='ebyperso_faq_btn'|i18n('design/bouygues/static') url='/' class="btn-add-widget" onclick="return false;"}</div>{/if}
											<img src={"ebyperso/faq/img1.gif"|ezimage} class="item-image" alt="" align="left"/>
											<strong class="item-title">{'ebyperso_service1_title'|i18n('design/bouygues/static')|nl2br()}</strong>
											{'ebyperso_service1_p'|i18n('design/bouygues/static')|nl2br()}
										</div>
										{set $chekUserWidget = isUserWidget($currentUser.contentobject_id, 1)}
										<div class="item">
											{if and($currentUser.is_logged_in, $chekUserWidget|eq(true())|not())}<div class="item-button" id="widget_1">{include uri="design:blocs/btn.tpl" label='ebyperso_faq_btn'|i18n('design/bouygues/static') url='/' class="btn-add-widget" onclick="return false;"}</div>{/if}
											<img src={"ebyperso/faq/img2.gif"|ezimage} class="item-image" alt="" align="left"/>
											<strong class="item-title">{'ebyperso_service2_title'|i18n('design/bouygues/static')|nl2br()}</strong>
											{'ebyperso_service2_p'|i18n('design/bouygues/static')|nl2br()}
										</div>
										{set $chekUserWidget = isUserWidget($currentUser.contentobject_id, 6)}
										<div class="item">
											{if and($currentUser.is_logged_in, $chekUserWidget|eq(true())|not())}<div class="item-button" id="widget_6">{include uri="design:blocs/btn.tpl" label='ebyperso_faq_btn'|i18n('design/bouygues/static') url='/' class="btn-add-widget" onclick="return false;"}</div>{/if}
											<img src={"ebyperso/faq/img3.gif"|ezimage} class="item-image" alt="" align="left"/>
											<strong class="item-title">{'ebyperso_service3_title'|i18n('design/bouygues/static')|nl2br()}</strong>
											{'ebyperso_service3_p'|i18n('design/bouygues/static')|nl2br()}
										</div>
										{set $chekUserWidget = isUserWidget($currentUser.contentobject_id, 3)}
										<div class="item">
											{if and($currentUser.is_logged_in, $chekUserWidget|eq(true())|not())}<div class="item-button" id="widget_3">{include uri="design:blocs/btn.tpl" label='ebyperso_faq_btn'|i18n('design/bouygues/static') url='/' class="btn-add-widget" onclick="return false;"}</div>{/if}
											<img src={"ebyperso/faq/img4.gif"|ezimage} class="item-image" alt="" align="left"/>
											<strong class="item-title">{'ebyperso_service4_title'|i18n('design/bouygues/static')|nl2br()}</strong>
											{'ebyperso_service4_p'|i18n('design/bouygues/static')|nl2br()}
										</div>
										{set $chekUserWidget = isUserWidget($currentUser.contentobject_id, 4)}
										<div class="item">
											{if and($currentUser.is_logged_in, $chekUserWidget|eq(true())|not())}<div class="item-button" id="widget_4">{include uri="design:blocs/btn.tpl" label='ebyperso_faq_btn'|i18n('design/bouygues/static') url='/' class="btn-add-widget" onclick="return false;"}</div>{/if}
											<img src={"ebyperso/faq/img5.gif"|ezimage} class="item-image" alt="" align="left"/>
											<strong class="item-title">{'ebyperso_service5_title'|i18n('design/bouygues/static')|nl2br()}</strong>
											{'ebyperso_service5_p'|i18n('design/bouygues/static')|nl2br()}
										</div>
										{set $chekUserWidget = isUserWidget($currentUser.contentobject_id, 5)}
										<div class="item">
											{if and($currentUser.is_logged_in, $chekUserWidget|eq(true())|not())}<div class="item-button" id="widget_5">{include uri="design:blocs/btn.tpl" label='ebyperso_faq_btn'|i18n('design/bouygues/static') url='/' class="btn-add-widget" onclick="return false;"}</div>{/if}
											<img src={"ebyperso/faq/img6.gif"|ezimage} class="item-image" alt="" align="left"/>
											<strong class="item-title">{'ebyperso_service6_title'|i18n('design/bouygues/static')|nl2br()}</strong>
											{'ebyperso_service6_p'|i18n('design/bouygues/static')|nl2br()}
										</div>
									</div>
									
										
								</div>
								<div class="bottom">
									<div class="left"></div>
									<div class="right"></div>
									<div class="middle"></div>
								</div>
							</div>
		</div>
	</div>

{undef}
</div>