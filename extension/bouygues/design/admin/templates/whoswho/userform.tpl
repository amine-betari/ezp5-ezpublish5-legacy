{*$user_data.object_user|attribute('show',2)*}
{*$user_data.object.data_map.user_account|attribute('show',1)*}
{def $selected = ''}
<div class="content-navigation">

	{* DESIGN: Header START *}
	<div class="context-block">
		<div class="box-header">
			<div class="box-tc">
				<div class="box-ml">
					<div class="box-mr">
						<div class="box-tl">
							<div class="box-tr">
								<h1 class="context-title">Fiche Utilisateur : "{attribute_view_gui attribute=$user_data.object.data_map.last_name} {attribute_view_gui attribute=$user_data.object.data_map.first_name}"</h1>
	
								{* DESIGN: Mainline *}<div class="header-mainline"></div>
	
								{* DESIGN: Header END *}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


<!-- DEB - fiche collaborateur WW -->	
	<div class="content-view-children">
	<!-- Children START -->
		<form action={"whoswho/userform"|ezurl} method="post" name="children" enctype="multipart/form-data">
		<input type="hidden" name="UserId" value="{$user_data.user_id}" />
		<input type="hidden" name="SearchUser" value="{$SearchUser}"/>
		<div class="context-block">
			
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">Liste des inscrits aux Who's Who</h2>
				<div class="header-subline"></div>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml">
				<div class="box-mr"><div class="box-content">
									
					<div class="context-toolbar">
					<div class="block">
					
					<div class="break"></div>
					<table style="width:100%;margin-left:10px;margin-bottom:10px">
						
						<tr><td>Modifier le compte :</td><td><a href="/content/edit/{$user_data.user_id}/f/fre-FR">Cliquez ici</a></td></tr>
						<tr><td>Image :</td><td>{include uri='design:whoswho/datatype/edit/ezimage.tpl' attribute=$user_data.object.data_map.image}</td></tr>
						<tr><td>Nom :</td><td>{include uri='design:whoswho/datatype/edit/ezstring.tpl' attribute=$user_data.object.data_map.last_name}</td></tr>
						<tr><td>Prénom :</td><td>{include uri='design:whoswho/datatype/edit/ezstring.tpl' attribute=$user_data.object.data_map.first_name}</td></tr>
						<tr><td>Civilité :</td><td> {include uri='design:whoswho/datatype/edit/ezselection.tpl' attribute=$user_data.object.data_map.civilite}</td></tr>
						<tr><td>Date de naissance :</td><td> 						
							<div class="block">
							<div class="date">
							<div class="element">
							<label>{'Year'|i18n( 'design/standard/content/datatype' )}:</label>
							<input type="text" name="date_naissance_date_year" size="5" value="{$user_data.date_naissance.0}" />
							</div>
							<div class="element">
							<label>{'Month'|i18n( 'design/standard/content/datatype' )}:</label>
							<input type="text" name="date_naissance_date_month" size="3" value="{$user_data.date_naissance.1}" />
							</div>
							<div class="element">
							<label>{'Day'|i18n( 'design/standard/content/datatype' )}:</label>
							<input  type="text" name="date_naissance_date_day" size="3" value="{$user_data.date_naissance.2}" />
							</div>
							<div class="break"></div>
							</div>
							</div>
						</td></tr>	
						
						<tr><td colspan="2"><b>Attention le changement d'email implique la modification du mot de passe !</b></td></tr>
						<tr><td>Email :</td><td>{include uri='design:whoswho/datatype/edit/ezuser.tpl' attribute=$user_data.object.data_map.user_account}</td></tr>
						<tr><td>Activer le compte utilisateur : </td><td><input type="checkbox" name="is_enabled" {$user_data.object_user.is_enabled|choose( '', 'checked="checked"' )} value="" /></td></tr>
						
						
						<tr><td>Langue :</td><td>{include uri='design:whoswho/datatype/edit/ezselection.tpl' attribute=$user_data.object.data_map.langue}</td></tr>
						<tr><td>Ne pas synchroniser avec GALBY :</td><td>{include uri='design:whoswho/datatype/edit/ezboolean.tpl' attribute=$user_data.object.data_map.no_galby_sync}</td></tr>
						<tr><td>Entreprise :</td><td>
						<select name="EntrepriseID" id="EntrepriseID">
						<option value="">Séléctionner une entreprise</option>
						{foreach $entreprise_liste as $ent}
                        	{if and(is_set($user_data.entreprise) , eq($user_data.entreprise,$ent.id))} 
                        		{set $selected = 'selected="selected"'}
                        	{else}
                        		{set $selected = ''}
                            {/if}
                            <option value="{$ent.id}" {$selected}>{$ent.valeur|wash}</option>
					    {/foreach} 
						</select>
						</td></tr>
						
						<tr><td>Filiale :</td><td>
						<select name="FilialeID" id="FilialeID">
						<option value="">Séléctionner une filiale ou autre</option>
						{foreach $filiale_liste as $fil}
                        	{if and(is_set($user_data.filiale) , eq($user_data.filiale,$fil.id))} 
                        		{set $selected = 'selected="selected"'}
                        	{else}
                        		{set $selected = ''}
                            {/if}
                            <option value="{$fil.id}" {$selected}>{$fil.valeur|wash}</option>
					    {/foreach} 
						</select>
						</td></tr>
						<tr><td>Filiale autre :</td><td><input type="text" name="filiale_autre" value="{$user_data.filiale_autre|wash}"/></td></tr>
						<tr><td>Fonction :</td><td><input type="text" name="fonction" value="{$user_data.fonction|wash}"/></td></tr>
						<tr><td>Direction :</td><td><input type="text" name="direction" value="{$user_data.direction|wash}"/></td></tr>
						
						<tr><td>Secteur :</td><td>
						<select name="SecteurID" id="SecteurID">
						<option value="">Séléctionner un secteur</option>
						{foreach $secteur_liste as $sec}
                        	{if and(is_set($user_data.secteur) , eq($user_data.secteur,$sec.id))} 
                        		{set $selected = 'selected="selected"'}
                        	{else}
                        		{set $selected = ''}
                            {/if}
                            <option value="{$sec.id}" {$selected}>{$sec.valeur|wash}</option>
					    {/foreach} 
						</select>
						</td></tr>
						
						
						<tr><td>Adresse professionnelle :</td><td><textarea rows="5" cols="50" name="pro_adresse">{$user_data.pro_adresse|wash}</textarea></td></tr>
						<tr><td>Emplacement :</td><td><input type="text" name="emplacement" value="{$user_data.emplacement|wash}"/></td></tr>
						<tr><td>Tél. pro :</td><td><input type="text" name="pro_tel" value="{$user_data.pro_tel|wash}"/></td></tr>
						<tr><td>Mobile pro :</td><td><input type="text" name="pro_mobile" value="{$user_data.pro_mobile|wash}"/></td></tr>
						<tr><td>Fax pro :</td><td><input type="text" name="pro_fax" value="{$user_data.pro_fax|wash}"/></td></tr>
						<tr><td>Assistante nom :</td><td><input type="text" name="assistante_nom" value="{$user_data.assistante_nom|wash}"/></td></tr>
						<tr><td>Assistante tél. :</td><td><input type="text" name="assistante_tel" value="{$user_data.assistante_tel|wash}"/></td></tr>
						<tr><td>Date d'entrée :</td><td> 						
							<div class="block">
							<div class="date">
							<div class="element">
							<label>{'Year'|i18n( 'design/standard/content/datatype' )}:</label>
							<input type="text" name="date_entree_date_year" size="5" value="{$user_data.date_entree.0}" />
							</div>
							<div class="element">
							<label>{'Month'|i18n( 'design/standard/content/datatype' )}:</label>
							<input type="text" name="date_entree_date_month" size="3" value="{$user_data.date_entree.1}" />
							</div>
							<div class="element">
							<label>{'Day'|i18n( 'design/standard/content/datatype' )}:</label>
							<input  type="text" name="date_entree_date_day" size="3" value="{$user_data.date_entree.2}" />
							</div>
							<div class="break"></div>
							</div>
							</div>
						</td></tr>						
						<tr><td>Diplôme :</td><td><textarea rows="5" cols="50" name="diplome">{$user_data.diplome|wash}</textarea></td></tr>
						<tr><td>Parcours pro :</td><td><textarea rows="5" cols="50" name="parcours_pro">{$user_data.parcours_pro|wash}</textarea></td></tr>
						<tr><td>Service :</td><td><input type="text" name="service" value="{$user_data.service|wash}"/></td></tr>
						<tr><td>Mission actuelle :</td><td><textarea rows="5" cols="50" name="mission_actuelle">{$user_data.mission_actuelle|wash}</textarea></td></tr>
						<tr><td>Mission précédente :</td><td><textarea rows="5" cols="50" name="mission_precedente">{$user_data.mission_precedente|wash}</textarea></td></tr>
						<tr><td>Compétences :</td><td><textarea rows="5" cols="50" name="competences">{$user_data.competences|wash}</textarea></td></tr>
						<tr><td>Centres d'intérêt :</td><td><textarea rows="5" cols="50" name="centres_interet">{$user_data.centres_interet|wash}</textarea></td></tr>
												
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
						<input type="submit" value="Modifier" name="ModifierButton" class="button"/>
						<input type="submit" value="Annuler" name="CancelButton" class="button"/>
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
<!-- FIN - fiche collaborateur WW -->		


</div>






</div>

{undef}

