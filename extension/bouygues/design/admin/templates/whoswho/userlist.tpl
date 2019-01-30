{include uri="design:settings/settings_validation.tpl"}
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

{*$wws|attribute('show',2)*}
<div class="content-navigation">

	{* DESIGN: Header START *}
	<div class="context-block">
		<div class="box-header">
			<div class="box-tc">
				<div class="box-ml">
					<div class="box-mr">
						<div class="box-tl">
							<div class="box-tr">
								<h1 class="context-title">Les inscrits aux Who's Who</h1>
	
								{* DESIGN: Mainline *}<div class="header-mainline"></div>
	
								{* DESIGN: Header END *}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


<!-- DEB - Recherche collaborateur WW -->	
	<div class="content-view-children">
	<!-- Children START -->
		<form action={"whoswho/userlist"|ezurl} method="get" name="children">
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
						<tr><td>Entre le nom ou prénom ou email du collaborateur</td></tr>
						<tr>
						<td>
						<input type="text" name="SearchUser" />
						</td>
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
						<input type="submit" title="Recherche des collaborateurs inscrits aux WhosWho" value="Rechercher" name="SearchButton" class="button"/>
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


		
<!-- DEB - Résultat de la recherche -->	
	<div class="content-view-children">
	<!-- Children START -->
	
		<div class="context-block">
			<form action={"whoswho/userlist"|ezurl} method="post" name="children">
				<input type="hidden" name="SearchUser" value="{$SearchUser}"/>
			<div class="box-header">
				<div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
				<h2 class="context-title">Résultat de votre recherche {if is_set($item_count)}({$item_count}){/if}</h2>
				<div class="header-subline"></div>
				</div></div></div></div></div>
			</div>
			
			<div class="box-ml">
				<div class="box-mr"><div class="box-content">
									
					<div class="context-toolbar">
					<div class="block">
					<div class="left"> 
{*debug-log msg= '$user_search_list' var=$user_search_list*}						
{def $page_uri_suffix_init = concat( '?SearchUser=', $search_user|urlencode, $search_timestamp|gt( 0 )|choose( '', concat( '&SearchTimestamp=', $search_timestamp ) ))
	 $page_uri_suffix =''
	 $page_uri_suffix_search = $page_uri_suffix_init
}
{if and(is_set($sort_val),is_set($sort_col))}
	{set $page_uri_suffix = concat('(column)/',$sort_col,'/(value)/',$sort_val,'/', $page_uri_suffix_init)}
	{set $page_uri_suffix_search = concat('/',$page_uri_suffix)}
{/if}					
{debug-log msg= '$view_parameters' var=$view_parameters}
{debug-log msg= '$item_count' var=$item_count}
{debug-log msg= '$page_limit' var=$page_limit}						
{include name=navigator uri='design:navigator/google.tpl' 
		 page_uri='/whoswho/userlist' 
		 page_uri_suffix=$page_uri_suffix_search
		 item_count=$item_count 
		 view_parameters=$view_parameters 
		 item_limit=$page_limit}					    

					
					</div>
					
					<div class="break"></div>
					
					    <div class="content-navigation-childlist">
					    <table cellspacing="0" class="list">
					    <tbody>
					    <tr>
					    	<th class="remove">&nbsp;</th>
					    	
					    	<th >Nom <a href={concat('/whoswho/userlist/(column)/nom/(value)/asc/',$page_uri_suffix_init)|ezurl}><img src={"button-move_up.gif"|ezimage} /></a><a href={concat('/whoswho/userlist/(column)/nom/(value)/desc/',$page_uri_suffix_init)|ezurl}><img src={"button-move_down.gif"|ezimage} /></a></th>
							<th >Who's Who <a href={concat('/whoswho/userlist/(column)/ww_name/(value)/asc/',$page_uri_suffix_init)|ezurl}><img src={"button-move_up.gif"|ezimage} /></a><a href={concat('/whoswho/userlist/(column)/ww_name/(value)/desc/',$page_uri_suffix_init)|ezurl}><img src={"button-move_down.gif"|ezimage} /></a></th>
							<th class="modified">Date d'inscription <a href={concat('/whoswho/userlist/(column)/dt_etat/(value)/asc/',$page_uri_suffix_init)|ezurl}><img src={"button-move_up.gif"|ezimage} /></a><a href={concat('/whoswho/userlist/(column)/dt_etat/(value)/desc/',$page_uri_suffix_init)|ezurl}><img src={"button-move_down.gif"|ezimage} /></a></th>
					        <th class="modifier"></th>
					    </tr>
					    
					    {if $user_search_list} 
							{set $class='bglight'}
					   		{foreach $user_search_list as $usr sequence array('bgdark', 'bglight') as $seq}
					    <tr class="{$seq}">
					    	<td><input type="checkbox" value="{$usr.user_id}-{$usr.ww_id}" name="ActionIDArray[]"/></td>
					    	<td>{$usr.nom|wash} {$usr.prenom|wash}</td>
							<td>{$usr.ww_name|wash}</td>
							<td class="modified">{if is_numeric($usr.dt_etat)}{$usr.dt_etat|l10n(shortdatetime)}{/if}</td>
					       <td class="modified"><a href={concat("whoswho/userform/",$usr.user_id, '/?SearchUser=', $SearchUser)|ezurl}> edit</a></td>
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
						Pour la séléction 
				    	<input type="submit" value="Ajouter à" name="AddUsers" class="button"/>
				    	<select title='Sélectionner' name="WwID" id="WwID">
                        {foreach $wws as $ww}
                        	{foreach $arr_ww as $wwd}
                        		{if eq($wwd,$ww.contentobject_id)}
                        		<option value="{$ww.contentobject_id}">{$ww.name|wash}</option>
                        		{/if}
                        	{/foreach}
					    {/foreach}
					
                    	</select>
				    	<input type="submit" value="Supprimer" name="DeleteUsers" class="button"/>
						<input type="submit" value="Exporter Tous les Inscrits" name="ExportUsers" class="button"/>
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
<!-- FIN - Résultat de la recherche -->



</div>

{undef $ww
	   $wws
	   $class	
}

