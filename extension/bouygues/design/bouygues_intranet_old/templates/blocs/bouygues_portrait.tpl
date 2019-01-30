			<div class="boxA smallbloc">
				<div class="top">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
				<div class="content whos_who">
				<strong class="title">{$object.data_map.titre.content}</strong>

				{if gt(count($object.data_map.fiches_collabor.content.relation_list),0)}


					{foreach $object.data_map.fiches_collabor.content.relation_list as $data}
						{def $portrait = fetch('content', 'node', hash('node_id',$data.node_id ))}
						{*$portrait.object|attribute(show, 2)*}
						{def $whoswhos = fetch('content', 'tree', hash(
								'parent_node_id', 2,
								'class_filter_type', 'include',
								'class_filter_array', array('bouygues_whoswho'),
								'depth', 2,

								)
							)}
						{foreach $whoswhos as $whoswho}
							{if eq($whoswho.object.section_id, $node.object.section_id)}
								{def $ww_id = $whoswho.object.id}
							{/if}
						{/foreach}
						{undef $whoswhos}

						{def $whoswhos = fetch( 'content', 'tree', hash(
									  'parent_node_id', 2,
              						  'class_filter_type',  'include',
              						  'class_filter_array', array( 'bouygues_whoswho_search'),
              						  'depth', 3,
              						  'limitation', array()
              						  ))}
						{foreach $whoswhos as $whoswho}
							{if eq($whoswho.object.section_id, $node.object.section_id)}
								{def $url = $whoswho.url_alias}
							{/if}
						{/foreach}

						{def $userData = fetch('whoswho', 'whoswho_fetch', hash('user_id', $portrait.object.id, 'ww_id', $ww_id))}
						{def $entreprise=fetch('whoswho', 'search_option_value', hash('id',$userData.0.entreprise))}
						{def $filiale=fetch('whoswho', 'search_option_value', hash('id',$userData.0.filiale))}

						<div class="overview ">

							{if and($portrait.object.data_map.image.has_content,$portrait.object.data_map.image.content.whoswho_user|null()|not())}
							<div class="thumb">{if is_set($ww_id)}<a href="/{$url}/(userId)/{$portrait.object.id}" class="image_small">{/if}<img src="{$portrait.object.data_map.image.content.masterportrait.url|ezroot(no)}" title="{$portrait.object.data_map.first_name.content} {$portrait.object.data_map.last_name.content}" alt="{$portrait.object.data_map.first_name.content} {$portrait.object.data_map.last_name.content}" border="0"/>{if is_set($ww_id)}</a>{/if}</div>
							{else}
							<div class="thumb"><span class="image_small_no-link"><img src="{concat('images/general/default-whoswho-min.jpg')|ezdesign(no)}" border=0 /></span></div>
							{/if}

							<div class="text">
								<strong class="subTitle"><a href="/{$url}/(userId)/{$portrait.object.id}">{$portrait.object.data_map.first_name.content} {$portrait.object.data_map.last_name.content}</a></strong>
								<div class="function">
									<strong>{if eq($filiale, '')|not()}{$filiale}
									{elseif eq($entreprise,'')|not()}{$entreprise}{/if}</strong><br/>
									{if eq($userData.0.direction, '')|not()}{$userData.0.direction}
									{else}{fetch('whoswho', 'search_option_value', hash('id',$userData.0.service))}{/if}<br/>
									{$userData.0.fonction}
								</div>

							{if is_set($ww_id)}<a href="/{$url}/(userId)/{$portrait.object.id}" class="btn-grey-arrow-left">En savoir plus</a>{/if}

							</div>


						</div>
						{undef $portrait $url $whoswhos $ww_id $service $filiale}
					{/foreach}
					{undef $data}
				{else}

				{/if}
					{foreach $datas as $data}
						<div class="overview ">
							<div class="thumb">
								image
							</div>
							<div class="text">
								En attente whos_who
							</div>
						</div>
					{/foreach}
					{undef $data}
				</div>
				<div class="bottom">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
			</div>
			{undef}
