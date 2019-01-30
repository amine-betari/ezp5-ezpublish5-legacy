{include uri="design:settings/settings_validation.tpl"}

{def $sections = fetch( 'content', 'section_list' )
	 $arrSection = hash()
	 
}
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
{foreach $sections as $section}
	{if gt( $section.id, 5)}
    	{set $arrSection = $arrSection|set_array_element( $section.id, $section.name )}
    {/if}
{/foreach} 

	 			
{*$arr_section|attribute('show',1)*}
<div class="content-navigation">

	{* DESIGN: Header START *}
	<div class="context-block">
		<div class="box-header">
			<div class="box-tc">
				<div class="box-ml">
					<div class="box-mr">
						<div class="box-tl">
							<div class="box-tr">
								<h1 class="context-title">Gestion des Who's Who</h1>
	
								{* DESIGN: Mainline *}<div class="header-mainline"></div>
	
								{* DESIGN: Header END *}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


<!-- DEB - Liste des ww existants -->
	<div class="content-view-children">
	<!-- Children START -->
	
		<div class="context-block">
		
			
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">Liste des Who's who existants</h2>
				<div class="header-subline"/>
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
					    	<th>Nom</th>
					    	<th>Section</th>
							<th class="modified">Modifié</th>
					        <th class="modifier">Par</th>
					        <th class="edit"> </th>
					        <th class="edit"> </th>
					    </tr>
					    
						{if $wws} 
							{def $class='bglight'}
					   		{foreach $wws as $ww sequence array('bgdark', 'bglight') as $seq}
					    <tr class="{$seq}">
					    	<td>{$ww.name|wash}</td>
							<td>{$arrSection[$ww.object.section_id]|wash}</td>
							<td class="modified">{$ww.object.modified|l10n(shortdatetime)}</td>
					        <td><a href={$ww.object.current.creator.main_node.url_alias|ezurl}>{$ww.object.current.creator.name|wash}</a></td>
							<td>
								<form action={"whoswho/list"|ezurl} method="post">
								<!--<input type="hidden" name="NodeId" value="{$ww.node_id}" />-->
								<input type="hidden" name="WwID" value="{$ww.contentobject_id}" />
								<input type="image" src={'trash.png'|ezimage} name="RemoveButton"/>
								</form>
					        </td>
					        <td><a href={concat("whoswho/list/",$ww.contentobject_id)|ezurl}>edit</a></td>
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
				    
				       
				    <div class="break"></div>
				</div>
					
				</div></div></div></div></div></div>
				
			</div>
			<!-- FIN CONTROLBAR-->			
		
			
		</div>
	
	<!-- Children END -->
	</div>
<!-- FIN - liste des ww existants -->	

{if is_set($ww_id)}
	{def $object_ww=fetch( 'content', 'object', hash( 'object_id', $ww_id ) )
		$attributes=fetch( 'content', 'contentobject_attributes', hash( 'version', $object_ww.current ) )
		$titre_fr=''
		$titre_en=''	
	}
	{foreach $attributes as $attribute}
	    {if eq($attribute.contentclass_attribute_identifier,'titre')} 
	    	{set $titre_fr = $attribute.content }
	    {/if}
	    {if eq($attribute.contentclass_attribute_identifier,'titre_en')} 
	    	{set $titre_en = $attribute.content }
	    {/if}
	{/foreach}  
	
	
	
	{def $section_object = fetch( 'section', 'object', hash( 'section_id', $object_ww.section_id  ) ) }

	<!-- DEB - modification ww -->	
	<div class="content-view-children">
	<!-- Children START -->
		<form action={"whoswho/list"|ezurl} method="post" name="children">
		<input type="hidden" name="WwID" value="{$ww_id}" />
		<div class="context-block">
			
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">Modifier le Who's Who</h2>
				<div class="header-subline"></div>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml">
				<div class="box-mr"><div class="box-content">
									
					<div class="context-toolbar">
					<div class="block">
					
					<div class="break"></div>
					<table style="width:100%;margin-left:10px;margin-bottom:10px">
						<tr><td>Section</td><td>Nom en français</td><td>Nom en Anglais</td></tr>
						<tr>
						<td>{$section_object.name|wash}</td>
						<td><input type="texte" name="wwFr" value="{$titre_fr|wash}" /></td><td><input type="texte" name="wwEn" value="{$titre_en|wash}"/></td></tr>
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
						<input type="submit" title="Modifier le whoswho" value="Modifier" name="UpdateButton" class="button"/>
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
<!-- FIN - modification ww -->	
	
	
{/if}

		
<!-- DEB - création ww -->	
	<div class="content-view-children">
	<!-- Children START -->
		<form action={"whoswho/list"|ezurl} method="post" name="children">
		<div class="context-block">
			
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">Créer un nouveau Who's who</h2>
				<div class="header-subline"></div>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml">
				<div class="box-mr"><div class="box-content">
									
					<div class="context-toolbar">
					<div class="block">
					
					<div class="break"></div>
					<table style="width:100%;margin-left:10px;margin-bottom:10px">
						<tr><td>Section</td><td>Nom en français</td><td>Nom en Anglais</td></tr>
						<tr>
						<td>
						<select title='Sélectionner' name="SectionID" id="SectionID">
                        {foreach $sections as $section}
                        	{if gt( $section.id, 5)}
					        <option value="{$section.id}">{$section.name|wash}</option>
					        {/if}
					    {/foreach} 
                    	</select>
						</td>
						<td><input type="texte" name="wwFr"/></td><td><input type="texte" name="wwEn" /></td></tr>
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
						<input type="submit" title="Créer un nouveau whoswho" value="Créer" name="createbutton" class="button"/>
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
<!-- FIN - création ww -->	


</div>

{undef $sections
	   $class	
}

