{* 	check if the current node is a video / diaporama image / element liste / link / file 
	. If a video or a diap image, then we get the parent in order to link to it
	. If a link or a file or an element liste, then we take the object
	. Else we need to parse all the node of the url_alias in order to check if there is a :
		. mini site
		. dossier
	. If so we link to first the mini site, otherwise, the dossier
	
	*}

{if and(or($result.class_identifier|eq('bouygues_video'), $result.class_identifier|eq('bouygues_galerie_vid'), $result.class_identifier|eq('bouygues_diapo')), $result.parent.class_identifier|eq('article'))}

	{set $linkedNode=$result.parent}
		
{elseif and($result.class_identifier|eq('bouygues_video'), 
			$result.parent.class_identifier|eq('bouygues_galerie_vid'))}
	
	{set $linkedNode=$result.parent}

{elseif $result.class_identifier|eq('bouygues_diapo_image')}

	{set $linkedNode=$result.parent}
	
{elseif $result.class_identifier|eq('link')}

	{set $linkedNode=$result}

{elseif $result.class_identifier|eq('file')}

	{set $linkedNode=$result}
	
{elseif $result.class_identifier|eq('bouygues_element_liste')}

	{set $linkedNode=$result}
	
{elseif $result.class_identifier|eq('bouygues_session')}

	{set $linkedNode=$result.parent}
	
{elseif $result.class_identifier|eq('bouygues_session_element')}

	{set $linkedNode=$result.parent.parent}
	
{elseif $result.class_identifier|eq('bouygues_prestataire_projet')}

	{set $linkedNode=$result.parent}
	
{elseif $result.class_identifier|eq('bouygues_annexe')}

	{set $linkedNode=$result.parent}
	
{elseif $result.class_identifier|eq('bouygues_page_sessions')}

	{set $linkedNode=$result}

{else}
	
	{set $linkedNode=$result}
	
{/if}