{def $aItems =  fetch( 'content', 'list',
				        hash( 'parent_node_id',     $node.node_id,
				              'class_filter_type',  'include',
				              'class_filter_array', array( 	'article',
				              								'bouygues_liste_thema',
				              								'bouygues_liste',
				              								'bouygues_diapo',
				              								'bouygues_categorie',
				              								'bouygues_element_liste',
				              								'bouygues_galerie_vid',
				              								'bouygues_video'  
				              							),
				              'limit', ezini('WidgetActu', 'NbNewsMax', 'bouygues.ini'),
				              'depth', 10,							
				              'sort_by', array('published', false())
				       ))
				       
	 $title=''
	 $description=''
	 $enclosure=''
	 $filesize=''
	 $mime_type=''
	 $pubDate=''
	 $category=''
	  
	 $rssPubDate = $node.modified_subnode|datetime('rssPub')	
	
	 $shortMonthNamesFr = array('Jan','Fév','Mars','Avr','Mai','Juin','Juil','Août','Sept','Oct','Nov','Déc')			
	 $shortMonthNamesEn = array('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec')
	
	 $shortDayNamesFr = array('Lun','Mar','Mer','Jeu','Ven','Sam','Dim')
	 $shortDayNamesEn = array('Mon','Tue','Wed','Thu','Fri','Sat','Sun')

	
}
{set $rssPubDate = $rssPubDate|str_replace( $shortMonthNamesFr, $shortMonthNamesEn )|str_replace( $shortDayNamesFr, $shortDayNamesEn )}
<title>{$node.name|wash}</title>
<link>{$node.url_alias|ezroot('no','full')}</link>
<description>{$node.name|wash} - {$aItems|count}</description>
<pubDate>{$rssPubDate}</pubDate>
<docs>http://www.rssboard.org/rss-specification</docs>

{if $aItems}	{*$aNews|attribute(show,1)*}
	{foreach $aItems as $item}
		{set $title=''}
	  	{set $description=''}
	  	{set $enclosure=''}
		{set $filesize=''}
	  	{set $mime_type=''}
	  	{set $pubDate=''}
	  	{set $category=''}
		
		
		{* title par défaut => Titre du contenu *}
		{if is_set($item.data_map.titre)}
        	{set $title=$item.data_map.titre.content}
        {/if}		
		
		
		{* Date de publication => Date du contenu
		   Par défaut la date de modification 
		 *}		
		{set $pubDate = $item.object.modified|datetime('rssPub')}
		{if and(is_set($item.data_map.date_pu_cb), $item.data_map.date_pu_cb.value|eq(1))}
			{set $pubDate = $item.data_map.date_pub.content.timestamp|datetime('rssPub')}
		{/if}	
		
		
		{* description par défaut => Accroche du contenu *}
        {if and(is_set($item.data_map.accroche_liste),$item.data_map.accroche_liste.content.output.output_text|ne(''))}
        	{set $description = $item.data_map.accroche_liste.content.output.output_text}
        {* si pas d'accroche_liste => chapeau  *} 	
        {elseif and(is_set($item.data_map.chapeau),$item.data_map.chapeau.content.output.output_text|ne(''))}
			{set $description=$item.data_map.chapeau.content.output.output_text}
		{* si pas de cahpeau => description (Texte) *} 	
        {elseif and(is_set($item.data_map.description),$item.data_map.description.content.output.output_text|ne(''))}
			{set $description=$item.data_map.description.content.output.output_text}
		{/if}
        
        
        {* enclosure par défaut => Vignette du contenu *}
        {if $item.data_map.liste_vignette.has_content}
			{set $enclosure=$item.data_map.liste_vignette.content.rss_small.url|ezroot(,'full')}
			{set $filesize = $item.data_map.liste_vignette.content.rss_small.filesize}
			{set $mime_type = $item.data_map.liste_vignette.content.rss_small.mime_type}        			
		{/if}
		
		
		{* category par défaut => Surtitre du contenu *} 
		{if $item.data_map.liste_surtitre.content|ne('')}
			{set $category = $item.data_map.liste_surtitre.content}  
		{/if}	
        
        
        {* traitement des cas particuliers en fonction des classes *}				
		{switch match=$item.class_identifier}		 
			{case match='article'}
        		{set $title=$item.data_map.title.content}        		
        		{if and($description|eq(''),$item.data_map.intro.content.output.output_text|ne(''))}
        			{set $description=$item.data_map.intro.content.output.output_text}
        		{/if}        		
        		{if $item.data_map.image_vignette.has_content}
        			{set $enclosure=$item.data_map.image_vignette.content.rss_small.url|ezroot(,'full')}
        			{set $filesize = $item.data_map.image_vignette.content.rss_small.filesize}
        			{set $mime_type = $item.data_map.image_vignette.content.rss_small.mime_type}        			
        		{/if}        			 	
    		{/case}    		
    		
    		{case match='bouygues_categorie'}
        		{set $title=$item.data_map.nom.content}        		       			 	
    		{/case}    		
    		
    		{case match='bouygues_element_liste'}
        	    {if $item.data_map.accroche.content.output.output_text|ne('')}
		        	{set $description = $item.data_map.accroche.content.output.output_text}
		        {/if}		         
		        {if $item.data_map.date_pub.content.timestamp|ne('')}
					{set $pubDate = $item.data_map.date_pub.content.timestamp|datetime('rssPub')}
				{/if}		                		
        		{set $category = $item.data_map.surtitre.content}        		
        		{if $item.data_map.vignette.has_content}
        			{set $enclosure=$item.data_map.vignette.content.rss_small.url|ezroot(,'full')}
        			{set $filesize = $item.data_map.vignette.content.rss_small.filesize}
        			{set $mime_type = $item.data_map.vignette.content.rss_small.mime_type}        			
        		{/if}           		       			 	
    		{/case}
    		
	 	{/switch}	
		
		{*set $description = $description|shorten( 300, '...' )*}	
		{set $description = $description|strip_tags|shorten( 300 )|simplify|trim}
		{set $pubDate = $pubDate|str_replace( $shortMonthNamesFr, $shortMonthNamesEn )|str_replace( $shortDayNamesFr, $shortDayNamesEn )}
    <item>
      <title>{$title|wash}</title>
      <link>{$item.url_alias|ezroot('no','full')}</link>
      <description>{$description|wash}</description>       
 	{if $enclosure|ne('')}
 		<enclosure url={$enclosure} length="{$filesize}" type="{$mime_type}" />
	{/if}
	{if $category|ne('')}	  
	  <category>{$category|wash}</category>
	{/if}       
      <guid isPermaLink="true">{$item.url_alias|ezroot('no','full')}</guid>
      <pubDate>{$pubDate}</pubDate> 
    </item>
    {/foreach}
{/if}