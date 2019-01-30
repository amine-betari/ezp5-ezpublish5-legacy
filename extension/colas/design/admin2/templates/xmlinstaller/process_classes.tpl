{set $tpl_info = hash()}

{set-block variable="xml_data"}
	<?xml version="1.0" encoding="UTF-8"?>
	<eZXMLImporter>
		{include uri="design:xmlinstaller/classes/one_process.tpl"}
	</eZXMLImporter>
{/set-block}