{include uri="design:settings/settings_validation.tpl"}

{*def $wws = fetch( 'content', 'list', hash( 'parent_node_id', 2,
											'depth',2,
											'attribute_filter', array( array( 'section','in',$arr_section ) ),
	 										'class_filter_type',  'include',
              								'class_filter_array', array( 'bouygues_whoswho' )
	 									)					 
	 			)
*}
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
{def  $ww_name=''
	$etat_titre = array( 'En cours', 'Envoyé' ) 			
}


{*$wws.0|attribute('show',2)*}
<div class="content-navigation">

	{* DESIGN: Header START *}
	<div class="context-block">
		<div class="box-header">
			<div class="box-tc">
				<div class="box-ml">
					<div class="box-mr">
						<div class="box-tl">
							<div class="box-tr">
								<h1 class="context-title">Mail de relance collaborateurs</h1>
	
								{* DESIGN: Mainline *}<div class="header-mainline"></div>
	
								{* DESIGN: Header END *}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


<!-- DEB - Formulaire envoi nouveau message -->	
	<div class="content-view-children">
	<!-- Children START -->
		<form action={"whoswho/useremail"|ezurl} method="post" name="children" id="relanceForm">

			<input type="hidden" name="id" value="{if is_set($messageWw.0)}{$messageWw.0.id}{/if}"/>
		<div class="context-block">
			
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">Envoi d'un nouveau message</h2>
				<div class="header-subline"></div>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml">
				<div class="box-mr"><div class="box-content">
									
					<div class="context-toolbar">
					<div class="block">
					
					<div class="break"></div>
					<table style="width:100%;margin-left:10px;margin-bottom:10px">
						<tr>
							<td>Sujet en Français</td><td>&nbsp;</td><td>Sujet en Anglais</td>
						</tr>
						<tr>
							<td><input type="text" name="sujetFr"  value="{if is_set($messageWw.0)}{$messageWw.0.sujetFr}{/if}" class="required" title="Ce champ esrt obligatoire"/></td>
							<td>&nbsp;</td>
							<td><input type="text" name="sujetEn" value="{if is_set($messageWw.0)}{$messageWw.0.sujetEn}{/if}" class="required" title="Ce champ esrt obligatoire" /></td>
						</tr>
						<tr><td colspan="3">&nbsp;</td></tr>
						<tr>
							<td>Corps du message en Français</td><td>&nbsp;</td><td>Corps du message en Anglais</td>
						</tr>
						<tr>
							<td><textarea rows="5" cols="50" name="corpsFr" class="required" title="Ce champ esrt obligatoire">{if is_set($messageWw.0)}{$messageWw.0.corpsFr}{/if}</textarea></td>
							<td>&nbsp;</td>
							<td><textarea rows="5" cols="50" name="corpsEn" class="required" title="Ce champ esrt obligatoire">{if is_set($messageWw.0)}{$messageWw.0.corpsEn}{/if}</textarea></td>
						</tr>
						<tr><td colspan="3">&nbsp;</td></tr>
						<tr>
							<td>Groupe à qui envoyer</td><td colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td><select size="10" multiple="multiple" name="wwIds[]" class="required" title="Ce champ esrt obligatoire">
						{foreach $wws as $ww}
	                           <option value="{$ww.contentobject_id}" {if and(is_set($wwSelected), $wwSelected|contains($ww.contentobject_id))}selected{/if}>{$ww.name|wash}</option>
      				    {/foreach} 
									
									</select></td><td colspan="2">&nbsp;</td>
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
						<input type="submit"  value="Envoyer" name="EnvoyerButton" class="button"/>
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
<!-- FIN - Recherche collaborateur WW -->		


</div>


		
<!-- DEB - Liste envoi effectué -->	
	<div class="content-view-children">
	<!-- Children START -->
	
		<div class="context-block">
			<form action={"whoswho/useremail"|ezurl} method="post" name="children">
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">Liste des envois effectués ({$messages_count} )</h2>
				<div class="header-subline"></div>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml">
				<div class="box-mr"><div class="box-content">
									
					<div class="context-toolbar">
					<div class="block">
					<div class="left"> 
{include name=navigator uri='design:navigator/google.tpl' page_uri='/whoswho/useremail' item_count=$messages_count view_parameters=$view_parameters item_limit=$item_limit}				    
					
					</div>
					
					<div class="break"></div>
					
					    <div class="content-navigation-childlist">
					    <table cellspacing="0" class="list">
					    <tbody>
					    <tr>
					    	<th class="remove">&nbsp;</th>
					    	<th class="modified">Date d'envoi</th>
					    	<th >Sujet (français)</th>
							<th >Destinataire</th>
							<th >Statut</th>
							<th >&nbsp;</th>
					    </tr>
					    
					    {if $messages} 
							{set $class='bglight'}
					   		{foreach $messages as $message sequence array('bgdark', 'bglight') as $seq}
					   			
					    <tr class="{$seq}">
					    	<td width="15"><input type="checkbox" value="{$message.id}" name="ActionIDArray[]"/></td>
					    	<td class="modified" width="100">{$message.date}</td>
					    	<td width="200">{$message.sujetFr|wash} </td>
							<td width="200">{foreach $message.ww as $ww}
				   				{$ww.name}{delimiter},{/delimiter}
				   			{/foreach}</td>
					       	<td >{$etat_titre[$message.etat]}</td>
							<td ><a href={concat("whoswho/useremail/?id=",$message.id)|ezurl}> edit</a></td>
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
						<input type="submit" value="Supprimer" name="DeleteButton" class="button"/>
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
<!-- FIN - Liste envoi effectué -->



</div>

{literal}
<script type="text/javascript">
	$().ready(function(){
		
		$('#relanceForm').validate({
			 	errorElement: "span"
		});
	});
</script>
{/literal}
