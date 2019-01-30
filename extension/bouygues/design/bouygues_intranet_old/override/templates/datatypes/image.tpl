
	{section show=is_set($link_parameters.href)}
	  {section show=is_set($object_parameters.size)}
	 
	    {attribute_view_gui attribute=$object.data_map.image image_class=$object_parameters.size alignment=$object_parameters.align href=$link_parameters.href|ezurl target=$link_parameters.target link_class=$link_parameters.classification link_id=$link_parameters.id}

	  {section-else}
	  
	    {attribute_view_gui attribute=$object.data_map.image image_class=ezini( 'ImageSettings', 'DefaultEmbedAlias', 'content.ini' ) alignment=$object_parameters.align href=$link_parameters.href|ezurl target=$link_parameters.target link_class=$link_parameters.classification link_id=$link_parameters.id}

	  {/section}
	{section-else}
	  {section show=is_set($object_parameters.size)}
	 
	    {attribute_view_gui attribute=$object.data_map.image image_class=$object_parameters.size alignment=$object_parameters.align}

	  {section-else}
	  
	    {attribute_view_gui attribute=$object.data_map.image image_class=ezini( 'ImageSettings', 'DefaultEmbedAlias', 'content.ini' ) alignment=$object_parameters.align}
	  
	  {/section}
	{/section}
