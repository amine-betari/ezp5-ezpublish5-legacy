{def $class=''
	 $selected=''
	 $val_keyword=''
	 $val_code=''
	 $arrLangue = hash( 'fre-FR', 'Français', 'eng-US', 'Anglais' )
	 $valueAddkeywordButton='Ajouter le mot-clé'
	 $nameAddkeywordButton='AddKeyWordButton'
}
{if $object_id}
	{def $object =fetch( 'content', 'object', hash( 'object_id', $object_id ) )}
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
								<h1 class="context-title">Associer des mots-clés à un objet</h1>
	
								{* DESIGN: Mainline *}<div class="header-mainline"></div>
	
								{* DESIGN: Header END *}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

{if $object_id}
	{$object.name|wash} -> chemin principal : {$object.main_node.url_alias}
{/if}
{if or(and($keyword_list,$object_id),and($keyword_list_en,$object_id))}
	
<!-- DEB - Liste des mots-clés associé à l'objet -->
	<div class="content-view-children">
	<!-- Children START -->
	
		<div class="context-block">
			<form action={"mea-search/edit"|ezurl} method="post" name="children">
			<input type="hidden" value="{$object_id}" name="ObjectId"/>
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">Liste des mots-clés pour l'objet ({sum(count($keyword_list),count($keyword_list_en))})</h2>
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
					    	<th class="remove">&nbsp;</th>
					    	<th >Mot-clé</th>
					    	<th >Langue</th>
							<th class="edit"> </th>
					    </tr>
					    
					
					    {if $keyword_list} 
							{set $class='bglight'}
					   		{foreach $keyword_list as $word sequence array('bgdark', 'bglight') as $seq}
					    <tr class="{$seq}">
					    	<td><input type="checkbox" value="{$word.id}" name="ActionIDArray[]"/></td>
					    	<td>{$word.keyword|wash}</td>
					    	<td>{$word.langue|wash}</td>
						   <td class="modified"><a href={concat("mea-search/edit/",$object_id,"/",$word.id)|ezurl}> edit</a></td>
					  	</tr>
					  		{/foreach}
					  	{/if}
					   {if $keyword_list_en} 
							{set $class='bglight'}
					   		{foreach $keyword_list_en as $word sequence array('bgdark', 'bglight') as $seq}
					    <tr class="{$seq}">
					    	<td><input type="checkbox" value="{$word.id}" name="ActionIDArray[]"/></td>
					    	<td>{$word.keyword|wash}</td>
					    	<td>{$word.langue|wash}</td>
						   <td class="modified"><a href={concat("mea-search/edit/",$object_id,"/",$word.id)|ezurl}> edit</a></td>
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
						<input type="submit" title="" value="Supprimer" name="RemoveKeywordButton" class="button"/>
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
<!-- FIN - Liste des mea -->	
{/if}

</div>


<!-- DEB - Formulaire ajout MEA -->	
	<div class="content-view-children">
	<!-- Children START -->
		<form action={"mea-search/edit"|ezurl} method="post" name="children">
		
		<div class="context-block">
			
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">Associer un mot clé à un objet</h2>
				<div class="header-subline"/>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml">
				<div class="box-mr"><div class="box-content">
									
					<div class="context-toolbar">
					<div class="block">
					
					<div class="break"></div>
					{if $object_id}
						<input type="hidden" value="{$object_id}" name="ObjectId"/>
						<table style="width:100%;margin-left:10px;margin-bottom:10px;margin-top:10px">
						<tr>
							<td>Un mot-clé</td>
						</tr>
						<tr>
							<td>
							{if $keyword}
								{set $val_keyword=$keyword.keyword}
								{set $val_code=$keyword.langue}
								{set $valueAddkeywordButton='Modifier le mot-clé'}
								{set $nameAddkeywordButton='UpdKeyWordButton'}
								<input type="hidden" value="{$keyword.id}" name="Id"/>
							{/if}	
								
							<input type="text" name="KeyWord" value="{$val_keyword|wash}" />
							<select name="Langue">
							{foreach $arrLangue as $code => $libelle }
								{if eq($code,$val_code)}
									{set $selected='selected="selected"'}
								{else}
									{set $selected=''}
								{/if}
								<option {$selected} value="{$code}">{$libelle|wash}</option>
							{/foreach}	
							</select>
							<input type="submit"  value="{$valueAddkeywordButton|wash}" name="{$nameAddkeywordButton}" class="button"/></td>
						</tr>   
					</table>
					{else}
					<table style="width:100%;margin-left:10px;margin-bottom:10px;margin-top:10px">
						<tr>
							<td>Choisir l'objet : &nbsp;&nbsp;<input type="submit" value="Ajouter un objet" name="BrowseForObject" class="button"/></td>
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
						<!--<input type="submit"  value="Ajouter" name="EnvoyerButton" class="button"/>-->
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
<!-- FIN - Formulaire ajout MEA -->		


</div>



