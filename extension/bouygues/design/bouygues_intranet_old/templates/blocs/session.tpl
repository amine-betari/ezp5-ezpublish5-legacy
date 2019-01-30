		<div class="boxA">
			<div class="top">
				<div class="left"></div>
				<div class="right"></div>
				<div class="middle"></div>
			</div>
			<div class="content">
	
				{def $children = fetch('content', 'list', hash(
										'parent_node_id', $main_list.node_id,
										'class_filter_type','include',
										'class_filter_array',array('bouygues_session_element'),
										'sort_by', array( array( 'priority' ) )))}
					
				{def $nb_children = $children|count()}
				{def $count_child=1}


				
				<div class="hOverview">			
					
						<div class="clear">
						
								{if $main_list.data_map.description.has_content}
									{$main_list.data_map.description.content.output.output_text}
								{/if}

								{if $children|count()|gt(0)}
								<ul>
									{def $user_id='' $result=''}
									{foreach $children as $data}
									
									{set $user_id=$data.data_map.collaborator.content.id}
									{def $userObj  = fetch('content', 'object', hash('object_id', $user_id))}
									
									{set $result = fetch('whoswho', 'whoswho_fetch', hash('user_id', $user_id, 'ww_id', $ww_id))}
									<li>{if is_set($result.0)}<a href={concat($url_whoswho,'/(userId)/',$user_id)|ezurl} target="_blank" alt="{$userObj.main_node.data_map.first_name.content} {$userObj.main_node.data_map.last_name.content}" title="{$userObj.main_node.data_map.first_name.content} {$userObj.main_node.data_map.last_name.content}">{$data.name}</a>{else}{$data.name}{/if}</li>
										{undef $urlTitle}
										{undef $urlTarget}
										{undef $url}
										{undef $userObj}
									{/foreach}
								</ul>
								{/if}

						</div>
					
				</div>

				
		
			</div>
			<div class="bottom">
				<div class="left"></div>
				<div class="right"></div>
				<div class="middle"></div>
			</div>
		</div>

{undef $children $nb_children $count_child $user_id $result}