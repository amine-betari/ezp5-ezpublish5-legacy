<div class="default list">
{include uri="design:blocs/tools.tpl" light=1 btn_back=1}
<h1> {'news_all'|i18n('design/bouygues/static')} </h1>

{if is_set($view_parameters.offset)}
{def $offset=$view_parameters.offset}
{else}
{def $offset=0}
{/if}

{def $actu_node_id = ezini('NODE_ID', 'actu_groupe', 'site.ini')}

{def $datas_total = fetch('content','list',hash( 'parent_node_id', $actu_node_id,
									'sort_by', array( array( 'priority',false() ) ) ))}

{def $datas = fetch('content','list',hash( 'parent_node_id', $actu_node_id,
									'sort_by', array( array( 'priority',false() ) ),
									'limit',5,
									'offset',$offset ))}
							
{def $array_content = $datas}

	<div class="content2">	
		<div class="boxA">
			<div class="top">
				<div class="left"></div>
				<div class="right"></div>
				<div class="middle"></div>
			</div>
			<div class="content">
				{include uri="design:blocs/liste.tpl" children=$array_content mode=static}
			</div>
			<div class="bottom">
				<div class="left"></div>
				<div class="right"></div>
				<div class="middle"></div>
			</div>
		</div>
	</div>
</div>

{include uri="design:blocs/pagination.tpl" url_pagination='/static/actu-history' articleCount=$datas_total|count numberOfObjects=5}

{undef}
