{include uri="design:settings/settings_validation.tpl"}
{if is_array($arr_section)}
	{def $wws = fetch( 'content', 'list', hash( 'parent_node_id', 2,
												'depth',2,
		 										'class_filter_type',  'include',
	              								'class_filter_array', array( 'bouygues_whoswho' ),
	              								'limitation' , array( hash( 'Section', $arr_section ))
		 									)					 
		 			)
		 			
	}
{else}
	{def $wws = fetch( 'content', 'list', hash( 'parent_node_id', 2,
												'depth',2,
		 										'class_filter_type',  'include',
	              								'class_filter_array', array( 'bouygues_whoswho' )
		 									)					 
		 			)
		 			
	}
{/if}
{def $selected=''
	 $ww_name=''
}


{*$wws|attribute('show',1)*}
<div class="content-navigation">

	{* DESIGN: Header START *}
	<div class="context-block">
		<div class="box-header">
			<div class="box-tc">
				<div class="box-ml">
					<div class="box-mr">
						<div class="box-tl">
							<div class="box-tr">
								<h1 class="context-title">Who's Who liste</h1>
	
								{* DESIGN: Mainline *}<div class="header-mainline"></div>
	
								{* DESIGN: Header END *}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


<!-- DEB - sélection WW -->	
	<div class="content-view-children">
	<!-- Children START -->
		<form action={"whoswho/filter"|ezurl} method="post" name="children">
		<div class="context-block">
			
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">Sélectionner le Who's Who concerné</h2>
				<div class="header-subline"></div>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml">
				<div class="box-mr"><div class="box-content">
									
					<div class="context-toolbar">
					<div class="block">
					
					<div class="break"></div>
					<table style="width:100%;margin-left:10px;margin-bottom:10px">
						<tr><td>Sélectionner votre choix</td></tr>
						<tr>
						<td>
						<select title='Sélectionner' name="WhosWhoID" id="WhosWhoID">
							<option value="">Sélectionner</option>
                        {foreach $wws as $ww}
                        	{foreach $arr_ww as $wwd}
                        		{if eq($wwd,$ww.contentobject_id)}
	                        		{if and(is_set($ww_id) , eq($ww.contentobject_id,$ww_id))} 
	                        		{set $selected = 'selected="selected"'}
	                        		{set $ww_name = $ww.name}
	                        	{else}
	                        		{set $selected = ''}
	                            {/if}
	                            <option value="{$ww.contentobject_id}" {$selected}>{$ww.name|wash}</option>
                        		{/if}
                        	{/foreach}	
					    {/foreach} 
                    	</select>
						</td>
						</tr>
					</table>    
					</div>
					</div>
					
				
				</div></div>
			
			</div>

			<!-- DEB CONTROLBAR-->		
			<div class="controlbar">

				<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
				
				<div class="block">
				    
					<div class="left">
						<input type="submit" title="Afficher la configuration du whoswho" value="Afficher" name="AfficherButton" class="button"/>
					</div>
					   
				    <div class="break"></div>
				</div>
					
				</div></div></div></div></div></div>
				
			</div>
			<!-- FIN CONTROLBAR-->			
		
			
		</div>
	</form>
	<!-- Children END -->
	</div>
<!-- FIN - sélection WW -->		

{if is_set($ww_id)}


<!-- DEB - Sélection des users appartenant déjà à la liste WW -->	
	<div class="content-view-children">
	<!-- Children START -->
	<form action={"whoswho/filter"|ezurl} method="post" name="children">
		<input type="hidden" value="{$ww_id}" name="WwID"/>
		<div class="context-block">
			
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">{$ww_name|wash} - Liste des utilisateurs appartenant à la sélecion ({$user_list_count})</h2>
				<div class="header-subline"></div>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml">
				<div class="box-mr"><div class="box-content">
									
					<div class="context-toolbar">
					<div class="block">
					<div class="left">
					{* pagination *}	
	{include name=navigator uri='design:navigator/google.tpl' page_uri='/whoswho/filter' item_count=$user_list_count view_parameters=$view_parameters item_limit=$item_limit}
					</div>
					
					<div class="break"></div>
					
					    <div class="content-navigation-childlist">
					    <table cellspacing="0" class="list">
					    <tbody>
					    <tr>
					    	<th class="remove">&nbsp;</th>
					    	<th >Nom</th>
							<th >Who's Who</th>
							<th class="modified">Date de validation</th>
					        <th class="modifier">Validée par </th>
					    </tr>
					    
					    {if $user_list} 
							{set $class='bglight'}
					   		{foreach $user_list as $usr sequence array('bgdark', 'bglight') as $seq}
					    <tr class="{$seq}">
					    	<td><input type="checkbox" value="{$usr.user_id}" name="ActionIDArray[]"/></td>
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
					
				
				</div></div>
			
			</div>

			<!-- DEB CONTROLBAR-->		
			<div class="controlbar">

				<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
				
				<div class="block">
				    
					<div class="left">
						<input type="submit" title="Retirer utilisateur de la liste" value="Retirer" name="RetirerButton" class="button"/>
					</div>
				    <div class="break"></div>
				</div>
					
				</div></div></div></div></div></div>
				
			</div>
			<!-- FIN CONTROLBAR-->			
		
			
		</div>
	</form>
	<!-- Children END -->
	</div>
<!-- FIN -  Sélection des users appartenant déjà à la liste WW -->	





<!-- DEB - Liste  des users appartenant au WW -->	
	<div class="content-view-children">
	<!-- Children START -->
	<form action={"whoswho/filter"|ezurl} method="post" name="children">
		<input type="hidden" value="{$ww_id}" name="WwID"/>
		<div class="context-block">
			
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">{$ww_name|wash} - Liste des utilisateurs appartenant au WW ({$user_ww_count})</h2>
				<div class="header-subline"></div>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml">
				<div class="box-mr"><div class="box-content">
									
					<div class="context-toolbar">
					<div class="block">
					<div class="left">
					{* pagination *}	
	{include name=navigator uri='design:navigator/google.tpl' page_uri='/whoswho/filter' item_count=$user_ww_count view_parameters=$view_parameters item_limit=$item_limit}
					</div>
					
					<div class="break"></div>
					
					    <div class="content-navigation-childlist">
					    <table cellspacing="0" class="list">
					    <tbody>
					    <tr>
					    	<th class="remove">&nbsp;</th>
					    	<th >Nom</th>
							<th >Who's Who</th>
							<th class="modified">Date de validation</th>
					        <th class="modifier">Validée par </th>
					    </tr>
					    
					    {if $user_ww} 
							{set $class='bglight'}
					   		{foreach $user_ww as $usr sequence array('bgdark', 'bglight') as $seq}
					    <tr class="{$seq}">
					    	<td><input type="checkbox" value="{$usr.user_id}" name="ActionIDArray[]"/></td>
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
					
				
				</div></div>
			
			</div>

			<!-- DEB CONTROLBAR-->		
			<div class="controlbar">

				<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
				
				<div class="block">
				    
					<div class="left">
						<input type="submit" title="Ajouter utilisateur de la liste" value="Ajouter" name="AjouterButton" class="button"/>
					</div>
				    <div class="break"></div>
				</div>
					
				</div></div></div></div></div></div>
				
			</div>
			<!-- FIN CONTROLBAR-->			
		
			
		</div>
	</form>
	<!-- Children END -->
	</div>
<!-- FIN -  Liste  des users appartenant au WW -->	



{/if}

</div>


		



</div>

{undef}

