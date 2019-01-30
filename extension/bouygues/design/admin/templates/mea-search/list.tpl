{def $object =''
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
								<h1 class="context-title">Liste des MEA de noeuds en fonction de mots-clés</h1>
	
								{* DESIGN: Mainline *}<div class="header-mainline"></div>
	
								{* DESIGN: Header END *}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


<!-- DEB - Liste des mea -->
	<div class="content-view-children">
	<!-- Children START -->
	
		<div class="context-block">
			<form action={"mea-search/list"|ezurl} method="post" name="children">
			
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">Liste des MEA ({count($object_list)})</h2>
				<div class="header-subline"/>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml"><div class="box-mr"><div class="box-content">
									
					 <div class="context-toolbar"><div class="block">
					<div class="left">
{include name=navigator uri='design:navigator/google.tpl' page_uri='/mea-search/list' item_count=$item_count view_parameters=$view_parameters item_limit=$item_limit}
					</div>
					
					<div class="break"></div>
					
					    <div class="content-navigation-childlist">
					    <table cellspacing="0" class="list">
					    <tbody>
					    <tr>
					    	<th class="remove">&nbsp;</th>
					    	<th style="width:70%">Objet</th>
							<th class="name">Mots-clés Français</th>
							<th class="name">Mots-clés Anglais</th>
							<th class="edit"> </th>
					    </tr>
					    
					    {if $object_list} 
							{set $class='bglight'}
					   		{foreach $object_list as $obj sequence array('bgdark', 'bglight') as $seq}
					   			{set $object =fetch( 'content', 'object', hash( 'object_id', $obj.object_id ) )}
							    <tr class="{$seq}">
							    	<td><input type="checkbox" value="{$obj.object_id}" name="ActionIDArray[]"/></td>
							    	<td>{$object.name|wash}</td>
							    	<td>{$obj.keys_fr|wash}</td><td>{$obj.keys_en|wash}</td>
									<td class="modified"><a href={concat("mea-search/edit/",$obj.object_id)|ezurl}> edit</a></td>
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
				{if $object_list}
				    <div class="left">
						<input type="submit" title="" value="Supprimer" name="RemoveButton" class="button"/>
					</div>
				{/if}   
				    <div class="break"></div>
				</div>
					
				</div></div></div></div></div></div>
				
			</div>
			<!-- FIN CONTROLBAR-->			
		
			</form>
		</div>
	
	<!-- Children END -->
	</div>
<!-- FIN - Liste des mea -->	


</div>




</div>



