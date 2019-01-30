{include uri="design:settings/settings_validation.tpl"}
{def $question=''
	 $reponse1=''
	 $reponse2=''
	 $reponse3=''
	 $question_eng=''
	 $reponse1_eng=''
	 $reponse2_eng=''
	 $reponse3_eng=''
	 $checked1=''
	 $checked2=''
	 $checked3=''
	 $selected1=''
	 $selected2=''
}
{if $sondage_data}
	{set $question=$sondage_data.question}
	{set $reponse1=$sondage_data.reponse1}
	{set $reponse2=$sondage_data.reponse2}
	{set $reponse3=$sondage_data.reponse3}
	{set $question_eng=$sondage_data.question_eng}
	{set $reponse1_eng=$sondage_data.reponse1_eng}
	{set $reponse2_eng=$sondage_data.reponse2_eng}
	{set $reponse3_eng=$sondage_data.reponse3_eng}
	
	{switch match=$sondage_data.reponse_ok}
	    {case match=1}
	        {set $checked1='checked="checked"'}
	    {/case}
	 
	    {case match=2}
	        {set $checked2='checked="checked"'}
	    {/case}
	 
	    {case match=3}
	        {set $checked3='checked="checked"'}
	    {/case}
 	{/switch}
 	{switch match=$sondage_data.etat}
	    {case match=1}
	        {set $selected1='selected="selected"'}
	    {/case}
	 
	    {case match=2}
	        {set $selected2='selected="selected"'}
	    {/case}
	 
 	{/switch}
	
{/if}

{*$wws|attribute('show',1)*}
<div class="content-navigation">

	{* DESIGN: Header START *}
	<div class="context-block">
		<div class="box-header">
			<div class="box-tc">
				<div class="box-ml">
					<div class="box-mr">
						<div class="box-tl">
							<div class="box-tr">
								<h1 class="context-title">Edition d'un sondage</h1>
	
								{* DESIGN: Mainline *}<div class="header-mainline"></div>
	
								{* DESIGN: Header END *}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


<!-- DEB - sondage  -->	
	<div class="content-view-children">
	<!-- Children START -->
		<form action={"sondage/edit"|ezurl} method="post" name="children" id="sondageForm">
		<input type="hidden" value="" name="ActionIDArray[]"/>
		{if $sondage_data}<input type="hidden" name="SondageId" value="{$id}" />{/if}
		<div class="context-block">
			
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">Créer votre sondage</h2>
				<div class="header-subline"></div>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml">
				<div class="box-mr"><div class="box-content">
									
					<div class="context-toolbar">
					<div class="block">
					
					<div class="break"></div>
					<table style="width:100%;margin-left:10px;margin-bottom:10px">
						<tr><td>Question</td><td>Question - Anglais</td></tr>
						<tr><td><input type="text" name="question" value="{$question}" maxlength="60" style="width: 400px" class="required" title="Ce champ est obligatoire"/></td>
						<td><input type="text" name="question_eng" value="{$question_eng}" maxlength="60" style="width: 400px"/></td></tr>
					</table>
					<table style="width:100%;margin-left:10px;margin-bottom:10px">
						<tr><td>Réponse 1</td><td>Réponse 1 - Anglais</td></tr>
						<tr>
							<td><input type="text" name="reponse1" value="{$reponse1}" maxlength="37" style="width: 400px"  class="required" title="Ce champ est obligatoire"/></td>
							<td><input type="text" name="reponse1_eng" value="{$reponse1_eng}" maxlength="37" style="width: 400px" /></td>
						</tr>
						<tr><td>Réponse 2</td><td>Réponse 2 - Anglais</td></tr>
						<tr>
							<td><input type="text" name="reponse2" value="{$reponse2}" maxlength="37" style="width: 400px" class="required" title="Ce champ est obligatoire"/></td>
							<td><input type="text" name="reponse2_eng" value="{$reponse2_eng}" maxlength="37" style="width: 400px" /></td>
						</tr>
						<tr><td>Réponse 3</td><td>Réponse 3 - Anglais</td></tr>
						<tr>
							<td><input type="text" name="reponse3" value="{$reponse3}" maxlength="37" style="width: 400px" /></td>
							<td><input type="text" name="reponse3_eng" value="{$reponse3_eng}" maxlength="37" style="width: 400px" /></td>
						</tr>
					</table> 
					<table style="width:100%;margin-left:10px;margin-bottom:10px">
						<tr><td>Etat</td></tr>
						<tr><td><select name="etat"><option value="1" {$selected1}>Actif</option><option value="2" {$selected2}>Archivé</option></select></td></tr>
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
						<input type="submit" title="" value="Valider" name="ValidateButton" class="button"/>
						<input type="submit" title="" value="Annuler" name="CancelButton" class="button"/>
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
<!-- FIN - sondage -->		

</div>

</div>


{literal}
<script type="text/javascript">
	$().ready(function(){
		
		$('#sondageForm').validate({
			 	errorElement: "span"
		});
	});
</script>
{/literal}