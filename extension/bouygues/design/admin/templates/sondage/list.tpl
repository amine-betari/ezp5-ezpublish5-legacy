{include uri="design:settings/settings_validation.tpl"}

 			
<div class="content-navigation">

	{* DESIGN: Header START *}
	<div class="context-block">
		<div class="box-header">
			<div class="box-tc">
				<div class="box-ml">
					<div class="box-mr">
						<div class="box-tl">
							<div class="box-tr">
								<h1 class="context-title">Sondages</h1>
	
								{* DESIGN: Mainline *}<div class="header-mainline"></div>
	
								{* DESIGN: Header END *}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


<!-- DEB - Liste des sondages -->
	<div class="content-view-children">
	<!-- Children START -->
	
		<div class="context-block">
			<form action={"sondage/list"|ezurl} method="post" name="children">
			
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">List des sondages ({count($sondage_list)})</h2>
				<div class="header-subline"></div>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml"><div class="box-mr"><div class="box-content">
									
					 <div class="context-toolbar"><div class="block">
					<div class="left">
{include name=navigator uri='design:navigator/google.tpl' page_uri='/sondage/list' item_count=$item_count view_parameters=$view_parameters item_limit=$item_limit}
					</div>
					
					<div class="break"></div>
					
					    <div class="content-navigation-childlist">
					    <table cellspacing="0" class="list">
					    <tbody>
					    <tr>
					    	<th class="remove">&nbsp;</th>
					    	<th >Question posée</th>
							<th >Etat</th>
							<th >Date état</th>
							<th>Par</th>
							<th>Nb réponse</th>
							<th> </th>
					        <th class="edit"> </th>
					    </tr>
					    
					    
						    {if $sondage_list} 
								{set $class='bglight'}
						   		{foreach $sondage_list as $sondage sequence array('bgdark', 'bglight') as $seq}
						    <tr class="{$seq}">
						    	<td><input type="checkbox" value="{$sondage.id}" name="ActionIDArray[]"/></td>
						    	<td>{$sondage.question|wash}</td>
								<td>{$sondage.etat}</td>
								<td class="modified">{$sondage.dte_etat}</td>
								<td >{$sondage.admin|wash}</td>
								<td >{$sondage.nb_reponses|wash}</td>
								<td ><a href={concat('/sondage/list/?idSondage=',$sondage.id)|ezurl}>Stats</a></td>
						        <td><a href={concat('/sondage/edit/',$sondage.id)|ezurl}>Edit</a></td>
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
						<input type="submit" onclick="return confirm('Confirmation de la suppression des sondages.');" title="" value="Supprimer" name="DeleteButton" class="button"/>
						
					</div>
					   
				    <div class="break"></div>
				</div>
					
				</div></div></div></div></div></div>
				
			</div>
			</form>		
			<!-- FIN CONTROLBAR-->			
		
			<!-- STAT -->
			
			{if $currentSondage}
			
			<div class="box-ml"><div class="box-mr"><div class="box-content">
									
					<div class="context-toolbar"><div class="block">
					
					<div class="break"></div>
					<form name="children" method="post" action="/sondage/list?idSondage={$currentSondage.id}">
					    <div class="content-navigation-childlist">
					    <table cellspacing="0" class="list">
					    <tbody>
					    <tr>
					    	<th colspan="2"><strong>{$currentSondage.question}</strong></th>
					    </tr>
						<tr>
					    	<th ><strong>{$currentSondage.reponse1}</strong></th>
							<th >{$currentSondage.reponse1_rate}%</th>
					    </tr>
						<tr>
					    	<th ><strong>{$currentSondage.reponse2}</strong></th>
							<th >{$currentSondage.reponse2_rate}%</th>
					    </tr>
						<tr>
					    	<th ><strong>{$currentSondage.reponse3}</strong></th>
							<th >{$currentSondage.reponse3_rate}%</th>
					    </tr>
						<tr>
					    	<th ><strong>Export des données</strong></th>
							<th ><input type="submit" class="button" name="ExportUsers" value="Exporter les résultats"/></th>
					    </tr>				    
					    </tbody
					    </table>
						</div>
					</form>
					</div>
					</div>
					 
				
				</div></div>
			
			</div>
			
			{/if}
		

		</div>
	
	<!-- Children END -->
	</div>
<!-- FIN - Liste des sondages -->	


</div>





</div>



