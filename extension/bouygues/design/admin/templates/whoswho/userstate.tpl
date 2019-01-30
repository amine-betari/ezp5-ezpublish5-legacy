{def $class=''
	 $ww_user_status_accepted_link = concat('/whoswho/userstate/(sort)/', $ww_user_status_accepted)
	 $ww_user_status_pending_link = concat('/whoswho/userstate/(sort)/', $ww_user_status_pending)
	 $ww_user_status_refused_link = concat('/whoswho/userstate/(sort)/', $ww_user_status_refused)
	 $ww_user_status_accepted_vp=hash('offset',0)
	 $ww_user_status_pending_vp=hash('offset',0)
	 $ww_user_status_refused_vp=hash('offset',0)
	 
}
{if and(is_set($sort_type),is_set($sort_val)) }
	{switch match=$sort_type}
		{case match=$ww_user_status_accepted}
			{set $ww_user_status_accepted_link = concat($ww_user_status_accepted_link,'/(column)/', $sort_col, '/(value)/', $sort_val)}
		{/case}
		{case match=$ww_user_status_pending}
			{set $ww_user_status_pending_link = concat($ww_user_status_pending_link,'/(column)/', $sort_col, '/(value)/', $sort_val)}
		{/case}
		{case match=$ww_user_status_refused}
			{set $ww_user_status_refused_link = concat($ww_user_status_refused_link,'/(column)/', $sort_col, '/(value)/', $sort_val)}
		{/case}
	{/switch}
{/if}

{debug-log msg= '$sort_type' var=$sort_type}
{if is_set($sort_type)}
	{switch match=$sort_type}
		{case match=$ww_user_status_accepted}
			{set $ww_user_status_accepted_vp = $view_parameters}
		{/case}
		{case match=$ww_user_status_pending}
			{set $ww_user_status_pending_vp = $view_parameters}
		{/case}
		{case match=$ww_user_status_refused}
			{set $ww_user_status_refused_vp = $view_parameters}
		{/case}
	{/switch}
{/if}
{debug-log msg= '$item_limit' var=$item_limit}
{debug-log msg= '$view_parameters' var=$view_parameters}
{debug-log msg= '$ww_user_status_accepted_vp' var=$ww_user_status_accepted_vp}
{debug-log msg= '$ww_user_status_pending_vp' var=$ww_user_status_pending_vp}
{debug-log msg= '$ww_user_status_refused_vp' var=$ww_user_status_refused_vp}	

<div class="content-navigation">

	{* DESIGN: Header START *}
	<div class="context-block">
		<div class="box-header">
			<div class="box-tc">
				<div class="box-ml">
					<div class="box-mr">
						<div class="box-tl">
							<div class="box-tr">
								<h1 class="context-title">Les demandes d'inscriptions</h1>
	
								{* DESIGN: Mainline *}<div class="header-mainline"></div>
	
								{* DESIGN: Header END *}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


<!-- DEB - demande d'inscriptions en attente -->
	<div class="content-view-children">
	<!-- Children START -->
	
		<div class="context-block">
			<form action={"whoswho/userstate"|ezurl} method="post" name="children">
			
			<div class="box-header">
				<div class="box-tc">
					<div class="box-ml">
						<div class="box-mr">
							<div class="box-tl">
								<div class="box-tr">
									<h2 class="context-title">Les demandes d'inscription en attentes ({$item_count_pending})</h2>
									<div class="header-subline"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="box-ml">
				<div class="box-mr">
					<div class="box-content">
									
						<div class="context-toolbar">
							<div class="block">
								<div class="left">
{include name=navigator uri='design:navigator/google.tpl' page_uri=$ww_user_status_pending_link item_count=$item_count_pending view_parameters=$ww_user_status_pending_vp item_limit=$item_limit}
								</div>
					
								<div class="break"></div>
					
								<div class="content-navigation-childlist">
					    			<table cellspacing="0" class="list">
					    				<tbody>
					    					<tr>
					    						<th class="remove">&nbsp;</th>
					    						<th >Nom <a href={concat('/whoswho/userstate/(sort)/', $ww_user_status_pending,'/(column)/nom/(value)/asc')|ezurl}><img src={"button-move_up.gif"|ezimage} /></a><a href={concat('/whoswho/userstate/(sort)/',$ww_user_status_pending,'/(column)/nom/(value)/desc')|ezurl}><img src={"button-move_down.gif"|ezimage} /></a></th>
												<th>Who's Who <a href={concat('/whoswho/userstate/(sort)/', $ww_user_status_pending,'/(column)/ww_name/(value)/asc')|ezurl}><img src={"button-move_up.gif"|ezimage} /></a><a href={concat('/whoswho/userstate/(sort)/',$ww_user_status_pending,'/(column)/ww_name/(value)/desc')|ezurl}><img src={"button-move_down.gif"|ezimage} /></a></th>
												<th class="modified">Date de la demande</th>
					        					<th class="edit"> </th>
					    					</tr>
					    
					    
					    {if $user_pending_list} 
			    
							{set $class='bglight'}
					   		{foreach $user_pending_list as $usr sequence array('bgdark', 'bglight') as $seq}
					    					<tr class="{$seq}">
					    						<td><input type="checkbox" value="{$usr.user_id}-{$usr.ww_id}" name="ActionIDArray[]"/></td>
					    						<td>{$usr.nom|wash} {$usr.prenom|wash}</td>
												<td>{$usr.ww_name|wash}</td>
												<td class="modified">{$usr.dt_etat|l10n(shortdatetime)}</td>
					        					<td><a href={concat('/whoswho/userform/',$usr.user_id)|ezurl}>edit</a></td>
					  						</tr>
					  		{/foreach}
					  	{/if}
					    
					    
					    				</tbody>
					    			</table>
								</div>
					
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- DEB CONTROLBAR-->		
			<div class="controlbar">

				<div class="box-bc">
					<div class="box-ml">
						<div class="box-mr">
							<div class="box-tc">
								<div class="box-bl">
									<div class="box-br">
				
										<div class="block">
				    
				    						<div class="left">
												<input type="submit" title="Accepter les demandes d'inscription sélectionnées" value="Accepter" name="AcceptButton" class="button"/>
												<input type="submit" title="Refuser les demandes d'inscription sélectionnées" value="Refuser" name="RefuseButton" class="button"/>
											</div>
					   
				    						<div class="break"></div>
										</div>
					
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
			</div>
			<!-- FIN CONTROLBAR-->			
		
			</form>
		</div>
	
	<!-- Children END -->	
	</div>
<!-- FIN - demande d'inscriptions en attente -->	


		
<!-- DEB - Demande d'inscription acceptées -->	
	<div class="content-view-children">
	<!-- Children START -->
	
		<div class="context-block">
			
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">Les demandes d'inscriptions récemment acceptées ({$item_count_accepted})</h2>
				<div class="header-subline"></div>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml">
				<div class="box-mr">
					<div class="box-content">
									
						<div class="context-toolbar">
							<div class="block">
								<div class="left">
					{* pagination *}	
	{include name=navigator uri='design:navigator/google.tpl' page_uri=$ww_user_status_accepted_link item_count=$item_count_accepted view_parameters=$ww_user_status_accepted_vp item_limit=$item_limit}
								</div>
					
								<div class="break"></div>
					
					    		<div class="content-navigation-childlist">
					    <table cellspacing="0" class="list">
					    <tbody>
					    <tr>
					    	<th >Nom <a href={concat('/whoswho/userstate/(sort)/', $ww_user_status_accepted,'/(column)/nom/(value)/asc')|ezurl}><img src={"button-move_up.gif"|ezimage} /></a><a href={concat('/whoswho/userstate/(sort)/',$ww_user_status_accepted,'/(column)/nom/(value)/desc')|ezurl}><img src={"button-move_down.gif"|ezimage} /></a></th>
							<th >Who's Who <a href={concat('/whoswho/userstate/(sort)/', $ww_user_status_accepted,'/(column)/ww_name/(value)/asc')|ezurl}><img src={"button-move_up.gif"|ezimage} /></a><a href={concat('/whoswho/userstate/(sort)/',$ww_user_status_accepted,'/(column)/ww_name/(value)/desc')|ezurl}><img src={"button-move_down.gif"|ezimage} /></a></th>
							<th class="modified">Date de validation</th>
					        <th class="modifier">Validée par </th>
					    </tr>
					    
					    {if $user_accepted_list} 
{*debug-log msg= '$user_accepted_list' var=$user_accepted_list*}	
							{set $class='bglight'}
					   		{foreach $user_accepted_list as $usr sequence array('bgdark', 'bglight') as $seq}
					    <tr class="{$seq}">
					    	<td>{$usr.nom|wash} {$usr.prenom|wash}</td>
							<td>{$usr.ww_name|wash}</td>
							<td class="modified">{$usr.dt_etat|l10n(shortdatetime)}</td>
					        <td>{$usr.admin|wash}</td>
					  	</tr>
					  		{/foreach}
					  	{/if}
					    
					    </tbody>
					    </table>
								</div>
					
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- DEB CONTROLBAR-->		
			<div class="controlbar">
				<div class="box-bc">
					<div class="box-ml">
						<div class="box-mr">
							<div class="box-tc">
								<div class="box-bl">
									<div class="box-br">
										<div class="block">
				    						<div class="break"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- FIN CONTROLBAR-->				
		</div>
	<!-- Children END -->
	</div>
<!-- FIN - Demande d'inscription acceptées -->	



	
<!-- DEB - Demande d'inscription récemment refusées -->	
	<div class="content-view-children">
	<!-- Children START -->
	
		<div class="context-block">
			
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">Les demandes d'inscriptions récemment refusées ({$item_count_pending})</h2>
				<div class="header-subline"></div>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml">
				<div class="box-mr">
					<div class="box-content">
									
						<div class="context-toolbar">
							<div class="block">
								<div class="left">
{include name=navigator uri='design:navigator/google.tpl' page_uri=$ww_user_status_refused_link item_count=$item_count_refused view_parameters=$ww_user_status_refused_vp item_limit=$item_limit}
								</div>
					
								<div class="break"></div>
					
					    		<div class="content-navigation-childlist">
					    <table cellspacing="0" class="list">
					    <tbody>
					    <tr>
					    	<th >Nom <a href={concat('/whoswho/userstate/(sort)/', $ww_user_status_refused,'/(column)/nom/(value)/asc')|ezurl}><img src={"button-move_up.gif"|ezimage} /></a><a href={concat('/whoswho/userstate/(sort)/',$ww_user_status_refused,'/(column)/nom/(value)/desc')|ezurl}><img src={"button-move_down.gif"|ezimage} /></a></th>
							<th >Who's Who <a href={concat('/whoswho/userstate/(sort)/', $ww_user_status_refused,'/(column)/ww_name/(value)/asc')|ezurl}><img src={"button-move_up.gif"|ezimage} /></a><a href={concat('/whoswho/userstate/(sort)/',$ww_user_status_refused,'/(column)/ww_name/(value)/desc')|ezurl}><img src={"button-move_down.gif"|ezimage} /></a></th>
							<th class="modified">Date de refus</th>
					        <th class="modifier">Refusée par </th>
					    </tr>
					    
					    {if $user_refused_list} 
							{set $class='bglight'}
					   		{foreach $user_refused_list as $usr sequence array('bgdark', 'bglight') as $seq}
					    <tr class="{$seq}">
					    	<td>{$usr.nom|wash} {$usr.prenom|wash}</td>
							<td>{$usr.ww_name|wash}</td>
							<td class="modified">{$usr.dt_etat|l10n(shortdatetime)}</td>
					        <td>{$usr.admin|wash}</td>
					  	</tr>
					  		{/foreach}
					  	{/if}
					    </tbody>
					    </table>
								</div>
					
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- DEB CONTROLBAR-->		
			<div class="controlbar">

				<div class="box-bc">
					<div class="box-ml">
						<div class="box-mr">
							<div class="box-tc">
								<div class="box-bl">
									<div class="box-br">
										<div class="block">
				    						<div class="break"></div>
										</div>
					
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>	
			</div>
			<!-- FIN CONTROLBAR-->			
		</div>
	<!-- Children END -->
	</div>
<!-- FIN - Demande d'inscription récemment refusées -->
</div>
