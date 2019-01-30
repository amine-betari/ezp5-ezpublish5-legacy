
<a name="comments"></a>
		{def $currentUser = fetch('user','current_user')}
			
			<div class="boxA">
				<div class="top">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
				<div class="content">
				<b class="title">{"comment_question_share"|i18n("design/bouygues/comment")}</b>
				
				<p>{"comment_question_share_desc"|i18n("design/bouygues/comment")|nl2br()}</p>
					

						
				</div>
					<div class="comments">
						
						
						{def $comments = fetch('content','list',hash( 'parent_node_id', $node.object.main_node.node_id,
														  'class_filter_type','include',
														  'class_filter_array',array('comment')),
														  'sort_by', array('published', false())  ))}	
						
						{set $comments = $comments|reverse()}
						<div class="comments-rows">
							
							{def $count_comments = 1}
							{foreach $comments as $comment}
	
							{if $comment.data_map.status.data_text|eq('1')|not()}
							{*$comment|attribute(show,1)*}

							<div class="comment-row {if $comment.data_map.message.data_text|count_chars|gt(400)}more-text{/if} {if $count_comments|mod(2)|eq(0)|not}comment-row-grey{/if}">
								<div class="user">
									<strong>{$comment.data_map.author.content}</strong><br />
									<u>{$comment.object.published|datetime( 'custom', '%d/%m/%Y' )}</u><br />
									{$comment.object.published|datetime( 'custom', '%G h %i' )}
								</div>

								<div class="text">
								{if $comment.data_map.message.data_text|count_chars|gt(400)}
									{$comment.data_map.message.data_text|strip_tags|shorten(400,'...')}
									<span id="readNext_{$comment.node_id}" class="next-text">
									{$comment.data_map.message.data_text|extract(400,$comment.data_map.message.data_text|count_chars)}
									</span>
									{else}	
									{$comment.data_map.message.data_text}
								{/if}
								</div>
									
								<div class="btn">
								
									{if $comment.data_map.message.data_text|count_chars|gt(400)}
										<a href="" onclick="post.readNext({$comment.node_id});return false;" class="btn-hard-grey-arrow-left btnNext_{$comment.node_id}">{"read_more"|i18n("design/bouygues/comment")}</a>
										<a href="" onclick="post.readNext({$comment.node_id});return false;" class="btn-hard-grey-arrow-left btnNext_{$comment.node_id}" style="display:none;">{"close"|i18n("design/bouygues/comment")}</a>
									{/if}

								</div>
								
							</div>
							
								{if and($count_comments|eq(5), gt($comments|count, 5)) }
										{def $showNext=true}
										<a href="" onclick="post.showNext({$count_comments});return false;" class="btn-hard-grey-arrow-left showNext">{"all_comments"|i18n("design/bouygues/comment")}</a>
										<a href="" onclick="post.showNext({$count_comments});return false;" class="btn-hard-grey-arrow-left showNext" style="display:none;">{"5_comments"|i18n("design/bouygues/comment")}</a>
										<div class="showNextComments displayNone" id="showNext_{$count_comments}">
								{/if}
								
								{if and($count_comments|eq($comments|count),$showNext)}
										
										</div>
								{/if}
							
							{set $count_comments=inc($count_comments)}
							{/if}
							{/foreach}
								
						</div>
					</div>
						
					<div class="content">
						<div class="comments">
						<div class="form-comment">
						
						{if $currentUser.is_logged_in|not()}
							<p>
								<strong>{"participate"|i18n("design/bouygues/comment")}</b>
								<br />{"login_first"|i18n("design/bouygues/comment")}
							</p>
							<ul>
								<li><a href="{"/user/login"|ezurl(no)}" class="UserConnect fromComment" onclick="return false;" title="{"authenticate"|i18n("design/bouygues/comment")}" rel="{$node.url_alias|ezurl(no)}">{"authenticate"|i18n("design/bouygues/comment")}</a></li>
							</ul>
						{elseif fetch( 'content', 'access', hash( 'access', 'create','contentobject', $node,'contentclass_id', 'comment' ) )}

	
		  					<div class="edit-comment"></div>

		  				
		  				{/if}
		  					  				
		  				<p class="legal">
		  					<strong>{"tip"|i18n("design/bouygues/comment")|nl2br()}</strong> <em>{"tip2"|i18n("design/bouygues/comment")|nl2br()}</em> {"tip3"|i18n("design/bouygues/comment")|nl2br()} <a href="{"/static/webmaster"|ezurl(no)}">{"tip4"|i18n("design/bouygues/comment")|nl2br()}</a>
		  					
		  				</p>
		  				
						</div>
					
					
					</div>
					
				</div>
				<div class="bottom">
					<div class="left"></div>
					<div class="right"></div>
					<div class="middle"></div>
				</div>
			</div>

{def $link=concat($node.url_alias|ezurl(no),'/(comment)/1/#comments','|','comment','|',$node.node_id,'|',ezini( 'RegionalSettings', 'Locale', 'site.ini'))}	  				 

{literal}
	 <script type="text/javascript">
	$().ready(function() {
		post.getFormComment('{/literal}{"/layout/set/ajax/content/action/"|ezurl(no)}{literal}','{/literal}{$link}{literal}');
		{/literal}
		
		
		{if $view_parameters.comment|eq('1')}
			{literal}post.getFormValidation('<h1>{/literal}{"comment_question_share"|i18n("design/bouygues/comment")|explode("\n")|implode("<br/>")|addslashes}{literal}</h1><p>{/literal}{"comment_sent"|i18n("design/bouygues/comment")|explode("\n")|implode("<br/>")|explode("\r")|implode("<br/>")|addslashes}{literal}</p>');{/literal}
		{/if}
		
{literal}		
	});	
	</script>
{/literal}
