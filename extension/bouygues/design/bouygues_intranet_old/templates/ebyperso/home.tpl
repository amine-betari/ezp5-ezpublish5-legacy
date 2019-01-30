{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' ) $actu_node_id = ezini('NODE_ID', 'actu_groupe', 'site.ini')
$datasHome = fetch('content','list',hash( 'parent_node_id', 2,
															  'class_filter_type','include',
															  'class_filter_array',array('bouygues_home_page'),
															  'sort_by', array( array('priority' )),
															  'limit',1
															  ))}
<div class="eby_perso">
<script type="text/javascript" src={concat('javascript/jquery-ui-1.8.6.custom.min.js')|ezdesign(no)}></script>
<script type="text/javascript">
	var setLabel='{'update'|i18n('design/bouygues/ebyperso')}'; 
	var delLabel='{'delete'|i18n('design/bouygues/ebyperso')}';
	var delConfirm='{'deleteConfirm'|i18n('design/bouygues/ebyperso')}';
</script>
<script type="text/javascript" src={'javascript/ebyperso.js'|ezdesign}></script>
<script type="text/javascript" src={'javascript/xhttpr.js'|ezdesign}></script>

	<div class="content1">
			<div class="box-add displayNone">
				<div class="box-add-top"></div>
				<div class="box-add-body">
					<ul>
						{foreach $widget_list as $widget}
							<li id="widget_{$widget[0]}">
								<span class="btn-text-widget">{$widget[1]|i18n('design/bouygues/ebyperso')}</span> 
								<a href="" class="btn-ebyPersoAddWidget{if $widget[2]|eq(0)} btn-add-widget{else} btn-off-widget{/if}" onclick="return false;">{'widget_add'|i18n('design/bouygues/ebyperso')}</a>
							</li>
						{/foreach}
					</ul>
				</div>
			</div>
			<a href="{"static/ebyperso"|ezurl(no)}" class="btn-ebyPersoCreate"></a>
			<a href="" class="btn-ebyPersoAddContent" onclick="return false;"></a>
			<a href="#" class="decreaseFont" onclick="return false"></a> 
			<a href="#" class="increaseFont" onclick="return false"></a>
	</div>
	
	<div class="content2">
		<div class="userEbyperso">{'hello'|i18n('design/bouygues/ebyperso')} {$user_obj.name}.<br/><span class="messageEbyperso">{'welcome'|i18n('design/bouygues/ebyperso')}</span></div>
	</div>
	
	<div class="content3">		
		{def $datas = fetch('content','list',hash( 'parent_node_id', $actu_node_id,
												'attribute_filter',array(array('section','=',16)),
												'limit',1,
												'sort_by', array( array( 'priority',false() ) ) ))}
		
		{def $numberOfGroupObjects = $datasHome.0.data_map.element_group_select.class_content.options[$datasHome.0.data_map.element_group_select.value[0]].name}

		{if or($numberOfGroupObjects|eq(''),$numberOfGroupObjects|eq(false()), $numberOfGroupObjects|eq(0))}{elseif count($datas)|gt(0)}
	  	<div class="large">
			<div class="boxA">
				<div class="top">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
				<div class="content">
					{def $data = $datas.0}
									
						<div class="image">
							<a href="{$data.url_alias|ezurl(no)}" title="{$data.name}">
							{if and(is_set($data.data_map.image_vignette),$data.data_map.image_vignette.has_content)}
								<img src="{$data.data_map.image_vignette.content.ebyperso_pageactu.url|ezurl(no)}" alt="{$data.name}" title="{$data.name}" border="0"/><br />
							{else}
								<img src="{concat("images/","actus/",$arrCssSubStructure[$data.object.section_id],'-group2.png')|ezdesign(no)}" alt="{$data.name}" title="{$data.name}" border="0"/><br />
							{/if}
							</a>
						</div>
						
						<a href="{$data.url_alias|ezurl(no)}" title="{$data.name}"><h2>{$data.name}</h2></a>					
						{if $data.data_map.accroche_liste.has_content}
							{$data.data_map.accroche_liste.content.output.output_text}
						{elseif $data.data_map.intro.has_content}
							{$data.data_map.intro.content.output.output_text}
						{elseif $data.data_map.chapeau.has_content}
							{$data.data_map.chapeau.content.output.output_text}
						{elseif $data.data_map.description.has_content}
							{$data.data_map.description.content.output.output_text}
						{elseif $data.data_map.body.has_content}
							{$data.data_map.body.content.output.output_text}
						{/if}
				</div>
				<div class="bottom">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
			</div>
		</div>
		{/if}
		{undef $data $datas}
	    <div class="columns">
	        
	        <ul id="column1" class="column">
	            {$col1}
	        </ul>
	
	        <ul id="column2" class="column">
	            {$col2}
	        </ul>
	        
	        <ul id="column3" class="column">
	            {$col3}            
	        </ul>
	        
	    </div>
    </div>
</div>
{literal}
<script type="text/javascript">
eby.loadActiveX();
</script>
{/literal}