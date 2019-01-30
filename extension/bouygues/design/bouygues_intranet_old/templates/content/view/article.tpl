{* Article - Full view *}

{*$node.data_map.titre_colonne|attribute(show,1)*}
					
<div class="post colorDefault1">

		<div class="column" style="margin-top:-16px;">		
				<div class="box">
				
						<div class="information">
							<span class="date">{"Mis à jour"|i18n('extension/bouygues/ebyidentification')} {$node.data_map.date_pub.data_int|datetime( 'custom', '%l %d %F %Y' )}</span> <a href="#" class="decreaseFont" onclick="return false"><img src={"pictos/textLess.gif"|ezimage} alt="-" border="0" /></a> <a href="#" class="increaseFont" onclick="return false"><img src={"pictos/textPlus.gif"|ezimage} alt="-" border="0" /></a><br />
							<div class="links">
								<a href="#" title="">Imprimer</a> |
								<a href="#" title="">Panier d'impression</a> |
								<a href="#" title="">Envoyer</a> 
								<br /><a href="#">Suivre les mises à jour</a>
							</div>
							<a href="#" title="">Content also available in english</a> <img src={"pictos/englishFlag.gif"|ezimage} alt="-" border="0" />
						</div>

				</div>
		</div>
		
		<div class="column">
						
					{if $node.data_map.titre_colonne.has_content}
					<div class="box sBox">	
						<div class="second">
							<div class="boxA">
								<div class="top">
									<div class="left"></div>
									<div class="right"></div>
									<div class="middle"></div>
								</div>
								<div class="content">
									<b class="title color4">{$node.data_map.titre_colonne.content|wash()}</b>
									{$node.data_map.texte_colonne.content.output.output_text}
								</div>
								<div class="bottom">
									<div class="left"></div>
									<div class="right"></div>
									<div class="middle"></div>
								</div>
							</div>
						</div>
					</div>
					{else}
					<div class="box">
						<div class="summary">

						
							<img src="	{$node.data_map.image_main.content[original].full_path|ezroot(no)}" alt=""/>
							<p class="legend">{$node.data_map.image_legende.content} - {$node.data_map.image_copyright.content} </p>
						</div>
												{if $node.data_map.titre_encadre.has_content}
						<div class="second">

							<div class="boxA">
								<div class="top">
									<div class="left"></div>
									<div class="right"></div>
									<div class="middle"></div>
								</div>
								<div class="content">
									<b class="title">{$node.data_map.titre_encadre.content|wash()}</b>
									{$node.data_map.contenu_encadre.content.output.output_text}
								</div>
								<div class="bottom">
									<div class="left"></div>
									<div class="right"></div>
									<div class="middle"></div>
								</div>
							</div>
				
						</div>
								{/if}
					</div>
						{/if}
					</div>

		
        <h1>{$node.data_map.title.content|wash()}</h1>
        
        <h2>{$node.data_map.short_title.content|wash()}</h2>
        
        <h3>{$node.data_map.intro.content.output.output_text}</h3>
        
        {$node.data_map.body.content.output.output_text}
                
</div>

<div class="user colorDefault1">
	
	<em>{attribute_view_gui attribute=$node.data_map.author}</em>{if $node.data_map.author.has_content} - {/if}{if $node.data_map.date_pu_cb.value|eq(1)}{"Posted on"|i18n("design/bouygues/dossier")} {$node.data_map.date_pub.data_int|datetime( 'custom', '%d/%m/%Y' )}{/if}

</div>
				
				
	
{include uri="design:blocs/annexe.tpl"}



