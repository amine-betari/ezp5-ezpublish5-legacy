{def $obj_node=''
	 $selected=''
	 $maxNode=1
}			
<div class="content-navigation">

	{* DESIGN: Header START *}
	<div class="context-block">
		<div class="box-header">
			<div class="box-tc">
				<div class="box-ml">
					<div class="box-mr">
						<div class="box-tl">
							<div class="box-tr">
								<h1 class="context-title">Dossiers restreints</h1>
	
								{* DESIGN: Mainline *}<div class="header-mainline"></div>
	
								{* DESIGN: Header END *}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<form action={"restricted-access/dossier"|ezurl} method="post" name="children">

<!-- DEB - Formulaire ajout dossier -->	
	<div class="content-view-children">
	<!-- Children START -->
		
		<div class="context-block">
			
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">Ajout un dossier restreint</h2>
				<div class="header-subline"></div>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml">
				<div class="box-mr"><div class="box-content">
									
					<div class="context-toolbar">
					<div class="block">
					
					<div class="break"></div>
{if $edition}					
					<table style="width:100%;margin-left:10px;margin-bottom:10px;margin-top:10px">
						<tr>
							<td>Sélectionner le(s) groupe(s) d'utilisateur(s) autorisé(s)</td>
						</tr>
						
						<tr>
							<td>
					{if $group_list}
							<select size="10" multiple="multiple" style="width:200px" name="GroupIdArray[]">
							{foreach $group_list as $group}
								{foreach $node_selected as $nd}
									{if eq($nd.group_id,$group.id)}
										{set $selected='selected="selected"'}
									{/if}	
								{/foreach}	
								<option {$selected} value="{$group.id}">{$group.nom|wash}</option>
								{set $selected=''}
							{/foreach}
							</select>
					{/if}		
							</td>
						</tr>
					</table>
{else}
	{set $maxNode=count($node_selected)}
	
					<table style="width:100%;margin-left:10px;margin-bottom:10px;margin-top:10px">
						<tr>
							<td>Sélectionner les noeuds</td><td>&nbsp;</td><td>
							{if and(is_set($group_list),gt(count($node_selected),0))}Sélectionner le(s) groupe(s) d'utilisateur(s) autorisé(s){/if}</td>
						</tr>
						
						<tr>
							<td valign="top"><input type="submit" value="Ajouter des noeuds" name="BrowseForNodes" class="button"/></td>
							<td>&nbsp;</td>
							<td>
					{if and(is_set($group_list),gt(count($node_selected),0))}
							<select size="10" multiple="multiple" style="width:200px" name="GroupIdArray[]">
							{foreach $group_list as $group}
							<option value="{$group.id}">{$group.nom|wash}</option>
							{/foreach}
							</select>
					{/if}		
							</td>
						</tr>
					</table>

{/if}					    
					</div>
					</div>
					
				
				</div></div>
			
			</div>

			<!-- DEB CONTROLBAR-->		
			<div class="controlbar">

				<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
				
				<div class="block">
				    
					<div class="left">
						
					</div>
					   
				    <div class="break"></div>
				</div>
					
				</div></div></div></div></div></div>
				
			</div>
			<!-- FIN CONTROLBAR-->			
		
			
		</div>
	
	<!-- Children END -->
	</div>
<!-- FIN - Formulaire ajout dossier -->		


{if $node_selected}
<!-- DEB - Liste des noeuds sélectionnés -->
	<div class="content-view-children">
	<!-- Children START -->
	
		<div class="context-block">
			
			
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">Liste des noeuds sélectionnés ({$maxNode})</h2>
				<div class="header-subline"></div>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml"><div class="box-mr"><div class="box-content">
									
					 <div class="context-toolbar"><div class="block">
					<div class="left">
					</div>
					
					<div class="break"></div>
					
					    <div class="content-navigation-childlist">
					    <table cellspacing="0" class="list">
					    <tbody>
					    <tr>
					    	<th >Node</th>
					    	<th >Path</th>
					    </tr>
					    
					    
					    
					{set $class='bglight'}
			   		{foreach $node_selected as $node_id max $maxNode sequence array('bgdark', 'bglight') as $seq}
			   			{if $edition}
			   				{set $node_id = $node_id.node_id}
			   			{/if}
			   			{set $obj_node =fetch( 'content', 'node', hash( 'node_id', $node_id) )}
			   			<tr class="{$seq}"><input type="hidden" name="ActionIDArray[]" value="{$node_id}" />
					    	<td>{$obj_node.name|wash}</td>
					    	<td>{$obj_node.url_alias}</td>
					  	</tr>
					{/foreach}
					  	
					    
					    </tbody>
					    </table>
						</div>
					
					</div>
					</div>
					 
				
				</div></div>
			
			</div>

			<!-- DEB CONTROLBAR-->		
			<div class="controlbar">

				<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
				
				<div class="block">
				    <div class="left">
						<input type="submit"  value="Valider" name="CreateButton" class="button"/>
					</div>
					   
				    <div class="break"></div>
				</div>
					
				</div></div></div></div></div></div>
				
			</div>
			<!-- FIN CONTROLBAR-->			
		
			
		</div>
	
	<!-- Children END -->
	</div>
<!-- Liste des noeuds sélectionnés -->
{/if}

</form>
</div>



