{def $import = false()
	 $export = false()
	 $section=''
}
{*debug-log msg= '$ww_hash' var=$ww_hash*}


{if eq($type,'import')}
	{set $import = true()}
	{set $type = 'import'}
{else}
	{set $export = true()}
	{set $type = 'export'}
{/if}



{def $wws = fetch( 'content', 'list', $ww_hash)}

{*debug-log msg= '$ra_list' var=$ra_list*}

{*debug-log msg= '$arr_section' var=$arr_section*}
{*debug-log msg= '$sort_type' var=$sort_type*}
<div class="content-navigation">
<form action={"listdiffusion/list"|ezurl} method="post" name="children" enctype="multipart/form-data">
	{* DESIGN: Header START *}
	<div class="context-block">
		<div class="box-header">
			<div class="box-tc">
				<div class="box-ml">
					<div class="box-mr">
						<div class="box-tl">
							<div class="box-tr">
								<h1 class="context-title">Liste de diffusion - {if $export}EXPORT{else}IMPORT{/if}</h1>
	
								{* DESIGN: Mainline *}<div class="header-mainline"></div>
	
								{* DESIGN: Header END *}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



<!-- DEB - Liste ww -->
	<div class="content-view-children"><!-- Children START -->
		<div class="context-block">
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">Liste des Who's who ({count($wws)})</h2>
				<div class="header-subline"></div>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml"><div class="box-mr"><div class="box-content">
				<div class="context-toolbar"><div class="block">
					<div class="left"></div>
					<div class="break"></div>
						<div class="content-navigation-childlist">
					    <table cellspacing="0" class="list">
					    <tbody>
					    <tr>
					    	<th >&nbsp;</th>
					    	<th >Nom</th>
					    	<th >Section</th>
					    </tr>
					 {if $wws}
						{foreach $wws as $ww sequence array( 'bglight', 'bgdark' ) as $seq}
							{set $section=fetch( 'section', 'object', hash( 'section_id', $ww.object.section_id ) )}

                        <tr class="{$seq}">
                        	<td>{if $export}<input type="checkbox" name="ww[]" value="{$ww.contentobject_id}" />{/if}</td>
                        	<td class="name">{$ww.name|wash}</td>
                        	<td class="name">{$section.name|wash}</td>
                        </tr>		
					    {/foreach} 
					 {/if}   
					    </tbody>
					    </table>
						</div>
					
					</div></div>
			</div></div></div>

			<!-- DEB CONTROLBAR-->		
			<div class="controlbar">
				<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
					<div class="block">
						<div class="left">
							{if $export}
							<input type="submit"  value="Exporter Who's Who Users" name="ExportWwButton" class="button"/>
							{/if}
							{if $import}
							<a href={"listdiffusion/example_import.csv"|ezimage}>Exemple de fichier d'import</a><br/>
							<input type="file"  value="fichier csv" name="ImportWwFile" class="box ezcc-file ezcca-file_file"/>
							<select name="wwImport">
							{foreach $wws as $ww}
	                        	<option value="{$ww.contentobject_id}">{$ww.name|wash}</option>
	                        {/foreach} 
							</select>
							<input type="submit"  value="Importer Who's Who Users" name="ImportWwButton" class="button"/>
							{/if}
						</div>
						<div class="break"></div>
					</div>
				</div></div></div></div></div></div>
			</div>
			<!-- FIN CONTROLBAR-->			
		
			
		</div>
	</div><!-- Children END -->	
<!-- FIN - liste ww -->





<!-- DEB - Liste newsletter -->
	<div class="content-view-children"><!-- Children START -->
		<div class="context-block">
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">Liste des Newsletters ({count($newsletter_list)})</h2>
				<div class="header-subline"></div>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml"><div class="box-mr"><div class="box-content">
				<div class="context-toolbar"><div class="block">
					<div class="left"></div>
					<div class="break"></div>
						<div class="content-navigation-childlist">
					    <table cellspacing="0" class="list">
					    <tbody>
					    <tr>
					    	<th >&nbsp;</th>
					    	<th>Titre newsletter</th>
					    </tr>
					    
						{if $newsletter_list} 
							{foreach $newsletter_list as $nl sequence array( 'bglight', 'bgdark' ) as $seq}
					   		{*debug-log msg= 'subscriber' var=$subscriber.subscription_list.name*}
						    <tr class="{$seq}">
						    	<td>{if $export}<input type="checkbox" name="nl[]" value="{$nl.id}" />{/if}</td>
						    	<td>{$nl.name|wash}</td>
						    </tr>
					  		{/foreach}
					  	{/if}
					    </tbody>
					    </table>
						</div>
					
					</div></div>
			</div></div></div>

			<!-- DEB CONTROLBAR-->		
			<div class="controlbar">
				<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
					<div class="block">
						<div class="left">
							{if $export}
							<input type="submit"  value="Exporter Newsletter List Users" name="ExportNlButton" class="button"/>
							{/if}
							{if $import}
							<a href={"listdiffusion/example_import.csv"|ezimage}>Exemple de fichier d'import</a><br/>
							<input type="file"  value="fichier csv" name="ImportNlFile" class="box ezcc-file ezcca-file_file"/>
							<select name="nlImport">
							{foreach $newsletter_list as $nl}
	                        	<option value="{$nl.id}">{$nl.name|wash}</option>
	                        {/foreach} 
							</select>
							<input type="submit"  value="Importer Newsletter Users" name="ImportNlButton" class="button"/>
							{/if}
						</div>
						<div class="break"></div>
					</div>
				</div></div></div></div></div></div>
			</div>
			<!-- FIN CONTROLBAR-->			
		
			
		</div>
	</div><!-- Children END -->	
<!-- FIN - liste des ww existants -->





<!-- DEB - Liste dossiers restreints -->
	<div class="content-view-children"><!-- Children START -->
		<div class="context-block">
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">Liste des Dossiers restreints ({count($ra_list)})</h2>
				<div class="header-subline"></div>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml"><div class="box-mr"><div class="box-content">
				<div class="context-toolbar"><div class="block">
					<div class="left"></div>
					<div class="break"></div>
						<div class="content-navigation-childlist">
					    <table cellspacing="0" class="list">
					    <tbody>
					    <tr>
					    	<th >&nbsp;</th>
					    	<th>Titre dossier restreint</th>
					    	<th>Section</th>
					    </tr>
					    
						{if $ra_list} 
							{foreach $ra_list as $ra sequence array('bgdark', 'bglight') as $seq}
					    	<tr class="{$seq}">
						    	<td>{if $export}<input type="checkbox" name="ra[]" value="{$ra.id}" />{/if}</td>
						    	<td>{$ra.nom|wash}</td>
						    	<td>{$ra.section|wash}</td>
						    </tr>
					
					  		{/foreach}
					  	{/if}
					    </tbody>
					    </table>
						</div>
					
					</div></div>
			</div></div></div>

			<!-- DEB CONTROLBAR-->		
			<div class="controlbar">
				<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
					<div class="block">
						<div class="left">
							{if $export}
							<input type="submit"  value="Exporter Dossier restreint Users" name="ExportRaButton" class="button"/>
							{/if}
							{if $import}
							<a href={"listdiffusion/example_import.csv"|ezimage}>Exemple de fichier d'import</a><br/>
							<input type="file"  value="fichier csv" name="ImportRaFile" class="box ezcc-file ezcca-file_file"/>
							<select name="raImport">
							{foreach $ra_list as $ra}
	                        	<option value="{$ra.id}">{$ra.nom|wash}</option>
	                        {/foreach} 
							</select>
							<input type="submit"  value="Importer Dossier Retreint" name="ImportRaButton" class="button"/>
							{/if}
						</div>
						<div class="break"></div>
					</div>
				</div></div></div></div></div></div>
			</div>
			<!-- FIN CONTROLBAR-->			
		
			
		</div>
	</div><!-- Children END -->	
<!-- FIN - liste dossiers restreints -->







</form>
</div>









