			
<div class="content-navigation">

	{* DESIGN: Header START *}
	<div class="context-block">
		<div class="box-header">
			<div class="box-tc">
				<div class="box-ml">
					<div class="box-mr">
						<div class="box-tl">
							<div class="box-tr">
								<h1 class="context-title">Restriction d'accès > Mes groupes</h1>
	
								{* DESIGN: Mainline *}<div class="header-mainline"></div>
	
								{* DESIGN: Header END *}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<!-- DEB - Liste des groupes -->
	<div class="content-view-children">
	<!-- Children START -->
	
		<div class="context-block">
			<form action={"restricted-access/group"|ezurl} method="post" name="children">
			
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">Liste des groupes ({count($group_list)})</h2>
				<div class="header-subline"></div>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml"><div class="box-mr"><div class="box-content">
									
					 <div class="context-toolbar"><div class="block">
					<div class="left">
{include name=navigator uri='design:navigator/google.tpl' page_uri='/restricted-access/edit' item_count=$item_count view_parameters=$view_parameters item_limit=$item_limit}
					</div>
					
					<div class="break"></div>
					
					    <div class="content-navigation-childlist">
					    <table cellspacing="0" class="list">
					    <tbody>
					    <tr>
					    	<th class="remove">&nbsp;</th>
					    	<th >Groupe</th>
					    	<th >Section</th>
							<th class="edit"> </th>
					    </tr>
					    
					    
				{if $group_list}	    
					{set $class='bglight'}
			   		{foreach $group_list as $group sequence array('bgdark', 'bglight') as $seq}
			   			<tr class="{$seq}">
					    	<td><input type="checkbox" value="{$group.id}" name="ActionIDArray[]"/></td>
					    	<td>{$group.nom|wash}</td>
					    	<td>{$group.section|wash}</td>
					    	<td><a href={concat('/restricted-access/group/',$group.id)|ezurl}>edit</a></td>
					  	</tr>
					{/foreach}
				{/if}	  	
					    
					    
						    
					    
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
						<input type="submit" title="" value="Supprimer" name="RemoveButton" class="button"/>
						<input type="submit" title="" value="Créer un nouveau groupe" name="CreateButton" class="button"/>
					</div>
					   
				    <div class="break"></div>
				</div>
					
				</div></div></div></div></div></div>
				
			</div>
			<!-- FIN CONTROLBAR-->			
		
			</form>
		</div>
	
	<!-- Children END -->
	</div>
<!-- FIN - Liste des groupes -->	


</div>



