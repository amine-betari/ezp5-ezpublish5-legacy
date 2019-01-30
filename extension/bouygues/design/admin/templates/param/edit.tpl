{def $statut='create'
	 $submitButton='CreateButton'
	 $ValuesubmitButton='Ajouter'
	 $titreForm='Ajouter un champ'
	 $cle=''
	 $valeur=''
	 $section_id=''
	 $type=''
	 $selected=''
	 $sections = fetch( 'content', 'section_list' )
	 $arrSection = hash()
	 	
}
{foreach $sections as $section}
	{if gt( $section.id, 5)}
    	{set $arrSection = $arrSection|set_array_element( $section.id, $section.name )}
    {/if}
{/foreach}
{*$arrSection|attribute(show,1)*}
{if $id}
	{set $statut='update'}
	{set $submitButton='UpdateButton'}
	{set $ValuesubmitButton='Modifier'}
	{set $titreForm='Modifier un champ'}
	{foreach $field as $k => $v}
		{set $cle=$v['cle']}
		{set $valeur=$v['valeur']}
		{set $type=$v['type']}
		{set $section_id=$v['section_id']}
	{/foreach}
	
{/if}			
<div class="content-navigation">

	{* DESIGN: Header START *}
	<div class="context-block">
		<div class="box-header">
			<div class="box-tc">
				<div class="box-ml">
					<div class="box-mr">
						<div class="box-tl">
							<div class="box-tr">
								<h1 class="context-title">Paramètres généraux</h1>
	
								{* DESIGN: Mainline *}<div class="header-mainline"></div>
	
								{* DESIGN: Header END *}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



<!-- DEB - Formulaire ajout/modif paramètre -->	
	<div class="content-view-children">
	<!-- Children START -->
		<form action={"param/edit"|ezurl} method="post" name="children">
		{if $statut|eq('update')}
		<input type="hidden" name="Id" value="{$id}" />
		{/if}
		<div class="context-block">
			
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">{$titreForm}</h2>
				<div class="header-subline"></div>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml">
				<div class="box-mr"><div class="box-content">
									
					<div class="context-toolbar">
					<div class="block">
					
					<div class="break"></div>
					<table style="width:100%;margin-left:10px;margin-bottom:10px;margin-top:10px">
						<tr>
							<td>Choisir type de champ</td>
							<td>&nbsp;</td>
							<td>Clé</td>
							<td>&nbsp;</td>
							<td>Valeur du champ</td>
							<td>&nbsp;</td>
							<td>Section</td>
						</tr>
						
						<tr>
							<td valign="top"><select name="type">
							{foreach $type_ini as $key => $item}
								{if and( is_set($type), eq($key,$type) )}
									{set $selected = 'selected="selected"'}
	                        	{else}
	                        		{set $selected = ''}
	                            {/if}
	                            
								<option value="{$key}" {$selected}>{$item.0|wash}</option>
								
							{/foreach}
							</select></td>
							<td>&nbsp;</td>
							<td><input type="text" name="cle" value="{$cle}" /></td>
							<td>&nbsp;</td>
							<td><input type="text" name="valeur" value="{$valeur}" /></td>
							<td>&nbsp;</td>
							<td>
							<select title='Sélectionner' name="SectionID" id="SectionID">
							<option value="">Aucune</option>
                       		 {foreach $arrSection as $key => $item}
                        	    	{if and(is_set($section_id) , eq($section_id,$key))} 
		                        		{set $selected = 'selected="selected"'}
		                        	{else}
		                        		{set $selected = ''}
		                            {/if} 
		                            <option value="{$key}" {$selected}>{$item|wash}</option>
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
						<input type="submit"  value="{$ValuesubmitButton}" name="{$submitButton}" class="button"/>
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
<!-- FIN - Formulaire ajout/modif paramètre -->		


<!-- DEB - Liste des paramètres -->
	<div class="content-view-children">
	<!-- Children START -->
	
		<div class="context-block">
			<form action={"param/edit"|ezurl} method="post" name="children">
			
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">Liste des paramètres ({count($entry_list)})</h2>
				<div class="header-subline"></div>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml"><div class="box-mr"><div class="box-content">
									
					 <div class="context-toolbar"><div class="block">
					<div class="left">
{*include name=navigator uri='design:navigator/google.tpl' page_uri='/mea-search/edit' item_count=$item_count view_parameters=$view_parameters item_limit=$item_limit*}
					</div>
					
					<div class="break"></div>
					
					    <div class="content-navigation-childlist">
					    <table cellspacing="0" class="list">
					    <tbody>
					    <tr>
					    	<th class="remove">&nbsp;</th>
					    	<th >Type</th>
							<th >Clé </th>
							<th >Valeur </th>
							<th >Section</th>
							<th class="edit"> </th>
					    </tr>
					    
					    
					   {if $entry_list} 
							{set $class='bglight'}
					   		{foreach $entry_list as $key => $item sequence array('bgdark', 'bglight') as $seq}
					    <tr class="{$seq}">
					    	<td><input type="checkbox" value="{$key}" name="ActionIDArray[]"/></td>
					    	<td>{$item.type|wash}</td>
					    	<td>{$item.cle|wash}</td>
							<td>{$item.valeur|wash}</td>
							<td>{$arrSection[$item.section_id]|wash}</td>
							<td class="modified"><a href={concat("param/edit/",$key)|ezurl}> edit</a></td>
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
						<input type="submit" title="Refuser les demandes d'inscription sélectionnées" value="Supprimer" name="RemoveButton" class="button"/>
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
<!-- FIN - Liste des paramètres -->	




</div>
{undef}


