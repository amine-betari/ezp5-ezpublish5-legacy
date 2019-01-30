{set $tpl_info = hash()}

{set-block variable="xml_data"}
<?xml version="1.0" encoding="UTF-8"?>
<eZXMLImporter>
	{include uri="design:xmlinstaller/sections/process.tpl"}
	{include uri="design:xmlinstaller/classes/video.tpl"}
	{include uri="design:xmlinstaller/content/process.tpl"}
	{include uri="design:xmlinstaller/roles/process.tpl"}
</eZXMLImporter>
{/set-block}
