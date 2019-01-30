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
	 $checked_field=''
	 $row_max=10
	 $cpt=0			
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
								<h1 class="context-title">Configuration du Who's Who</h1>
	
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
		<form action={"whoswho/edit"|ezurl} method="post" name="children">
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
                        	{*foreach $arr_ww as $wwd*}
	                        		{*if eq($wwd,$ww.contentobject_id)*}
		                        	{if and(is_set($ww_id) , eq($ww.contentobject_id,$ww_id))} 
		                        		{set $selected = 'selected="selected"'}
		                        	{else}
		                        		{set $selected = ''}
		                            {/if}
	                            <option value="{$ww.contentobject_id}" {$selected}>{$ww.name|wash}</option>
                        		{*/if*}
                        	{*/foreach*}	
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
<!-- DEB - champs visible dans le WW -->	
	<div class="content-view-children">
	<!-- Children START -->
		<form action={"whoswho/edit"|ezurl} method="post" name="children">
		{if is_set($ww_id)} 
			<input type="hidden" value="{$ww_id}" name="WwID"/>
		{/if}
		<div class="context-block">
			
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">Champs visibles dans le Who's Who</h2>
				<div class="header-subline"/>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml">
				<div class="box-mr"><div class="box-content">
									
					<div class="context-toolbar">
					<div class="block">
					
					<div class="break"></div>
					<table style="width:100%;margin-left:10px;margin-bottom:10px">
						<tr><td valign="top">
						{set $cpt=0}
						{foreach $all_fields as $key => $obj}
							{if gt( $cpt, $row_max ) }
								</td><td valign="top">
								{set $cpt=0}
							{/if}
							
							{if and(is_set($obj.actif),eq($obj.actif,true()) )}
								{set $checked_field='checked="checked"'}
							{else}
								{set $checked_field=''}	
							{/if}
							<input type="checkbox"  value="{$key}" name="field_checked[]" {$checked_field} /> {$obj.titre}<br>
							{set $cpt=inc( $cpt )}
						{/foreach}
						</td></tr>
						
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
						<input type="submit"  value="Modifier" name="ModifierFieldsButton" class="button"/>
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
<!-- FIN - champs visible dans le WW -->	



<!-- DEB - champs recherche dans le WW -->	
	<div class="content-view-children">
	<!-- Children START -->
		<form action={"whoswho/edit"|ezurl} method="post" name="children">
		{if is_set($ww_id)} 
			<input type="hidden" value="{$ww_id}" name="WwID"/>
		{/if}
		<div class="context-block">
			
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">Champs disponibles dans le moteur de recherche (6 max)</h2>
				<div class="header-subline"/>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml">
				<div class="box-mr"><div class="box-content">
									
					<div class="context-toolbar">
					<div class="block">
					
					<div class="break"></div>
					<table style="width:100%;margin-left:10px;margin-bottom:10px">
						<tr><td valign="top">
						{set $cpt=0}
						{foreach $all_fields as $key => $obj}
							{if gt( $cpt, $row_max ) }
								</td><td valign="top">
								{set $cpt=0}
							{/if}
							{if and(is_set($obj.search),eq($obj.search,true()) )}
								{set $checked_field='checked="checked"'}
							{else}
								{set $checked_field=''}	
							{/if}
							<input type="checkbox"  value="{$key}" name="search_checked[]" {$checked_field} /> {$obj.titre}<br>
							{set $cpt=inc( $cpt )}
						{/foreach}
						</td></tr>
						
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
						<input type="submit"  value="Modifier" name="ModifierSearchButton" class="button"/>
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
<!-- FIN - champs recherche dans le WW -->	
{/if}
		



</div>

{undef $sections
	   $class
	   $cpt	
}

