{def $class=''}
<div class="content-navigation">

	{* DESIGN: Header START *}
	<div class="context-block">
		<div class="box-header">
			<div class="box-tc">
				<div class="box-ml">
					<div class="box-mr">
						<div class="box-tl">
							<div class="box-tr">
								<h1 class="context-title">Les alertes GALBY</h1>
	
								{* DESIGN: Mainline *}<div class="header-mainline"></div>
	
								{* DESIGN: Header END *}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


<!-- DEB - Liste des alertes GALBY -->
	<div class="content-view-children">
	<!-- Children START -->
	
		<div class="context-block">
			<form action={"whoswho/alertgalby"|ezurl} method="post" name="children">
			
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">Liste des alertes GALBY ({count($arrErrors)})</h2>
				<div class="header-subline"></div>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml"><div class="box-mr"><div class="box-content">
									
					 <div class="context-toolbar"><div class="block">
					<div class="left">
{*include name=navigator uri='design:navigator/google.tpl' page_uri='/whoswho/alertgalby' item_count=count($arrErrors) view_parameters=$view_parameters item_limit=10*}
					</div>
					
					<div class="break"></div>
					
					    <div class="content-navigation-childlist">
					    <table cellspacing="0" class="list">
					    <tbody>
					    <tr>
					    	<th class="remove">&nbsp;</th>
					    	<th >Nom</th>
							<th>Who's Who</th>
							<th>Email</th>
							<th class="modified">Date alerte</th>
					        <th class="edit"> </th>
					    </tr>
					    
					    
					    {foreach $arrErrors as $galbyError sequence array('bgdark', 'bglight') as $seq}
					    <tr class="{$seq}">
					    	<td><input type="checkbox" value="{$galbyError.user_id}" name="ActionIDArray[]"/></td>
					    	<td>{$galbyError.last_name} {$galbyError.first_name}</td>
							<td>{foreach $galbyError.whoswho as $whoswho}{$whoswho.name}{delimiter},{/delimiter}{/foreach}</td>
							<td>{$galbyError.email}</td>
							<td class="modified">{$galbyError.date}</td>
					        <td><a href="{concat('/whoswho/userform/',$galbyError.user_id)|ezurl(no)}">edit</a></td>
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
						<input type="submit" title="Supprimer les entrées GALBY sélectionnées" value="Supprimer" name="DeleteButton" class="button"/>
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
<!-- FIN - Liste des alertes GALBY -->	


</div>



