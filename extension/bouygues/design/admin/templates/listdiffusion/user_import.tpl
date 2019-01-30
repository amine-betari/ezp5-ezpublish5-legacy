<!-- Maincontent Import START -->
{if is_set($resultat)}
	{def $titre =''
		 $message= ''	
	}
	{if $resultat}
		{set $titre='Confirmation'}
		{set $message='Importation résussie.'}
		
	{else}
		{set $titre='ERREUR'}
		{set $message="Une erreur est survenue lors de l'importation."}
	{/if}
<div class="error">
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
    <td>
      <h3 class="error">{$titre}</h3>
      <ul class="error">
        <li>{$message}</li>
      </ul>
    </td>
</tr>
</table>
</div>

{/if}
<div class="content-edit">
<form action={"listdiffusion/list"|ezurl} method="post" name="children">
	<input type="hidden" name="diffusionId" value="{$diffusion.id}" />
	<input type="hidden" name="diffusionType" value="{$diffusion.type}" />
	<input type="hidden" name="diffusionName" value="{$diffusion.name|wash}" />
	<div class="context-block">
		<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
			<h1 class="context-title">&nbsp;Valider l'import des utilisateurs vers {$diffusion.name|wash}</h1>
			<div class="header-mainline"></div>
		</div></div></div></div></div></div>

		<div class="box-ml"><div class="box-mr"><div class="box-content">
			<div class="context-attributes">
			    <table cellspacing="0" class="list">
			    	<tbody>
			    	<tr>
			    		<th>Id</th>
			    		<th>Email</th>
			    		<th>Nom</th>
			    		<th>Prénom</th>
			    		<th>Commentaire</th>
			    	</tr>
			    	{foreach $user_import as $user}
			    		{*debug-log msg= '$arr_section' var=$user*}
			    		<tr>
			    			{if $user['status']}
			    				<input type="hidden" name="userImport[]" value="{$user['id']}" />
			    				{if eq($user['id'],'new')}
			    					<input type="hidden" name="userImportEmail[]" value="{$user['email']|wash}" />
			    					<input type="hidden" name="userImportFirstName[]" value="{$user['last_name']|wash}" />
			    					<input type="hidden" name="userImportLastName[]" value="{$user['first_name']|wash}" />
			    				{/if}	
			    			{/if}
			    			<td>{$user['id']}</td>
			    			<td>{$user['email']|wash}</td>
			    			<td>{$user['last_name']|wash}</td>
			    			<td>{$user['first_name']|wash}</td>
			    			<td>{$user['comment']}</td>
			    		</tr>	
			    	{/foreach}	
			    	</tbody>
			    </table>	
			</div>
		</div></div></div>
		{if is_set($resultat)|not}
		<div class="controlbar">
			<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
				<div class="block">
	       		<input class="button" type="submit" name="ImportValidationButton" value="Valider l'importation" title="Valider l'importation" />
	    		<input class="button" type="submit" name="AnnulerButton" value="Annuler"  title="Annuler l'importation" />
	    		</div>
			</div></div></div></div></div></div>
		</div>
		{/if}
	</div>
</form>	
</div>

<!-- Maincontent Import END -->