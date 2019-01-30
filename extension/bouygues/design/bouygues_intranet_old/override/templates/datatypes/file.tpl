			{if eq($object.data_map.file.content.original_filename|extract_right( 4 )|downcase(), 'pptx')}
				{def $pictoType='ppt'}
				{def $pictoName='pptx'}
			{elseif eq($object.data_map.file.content.original_filename|extract_right( 4 )|downcase(), 'pptm')}
				{def $pictoType='ppt'}
				{def $pictoName='pptm'}
			{elseif eq($object.data_map.file.content.original_filename|extract_right( 4 )|downcase(), 'xlsx')}
				{def $pictoType='xls'}	
				{def $pictoName='xlsx'}
			{elseif eq($object.data_map.file.content.original_filename|extract_right( 4 )|downcase(), 'docx')}
				{def $pictoType='doc'}
				{def $pictoName='docx'}
			{elseif or(eq($object.data_map.file.content.original_filename|extract_right( 3 )|downcase(), 'doc'),
				eq($object.data_map.file.content.original_filename|extract_right( 3 )|downcase(), 'ppt'),
				eq($object.data_map.file.content.original_filename|extract_right( 3 )|downcase(), 'xls'),
				eq($object.data_map.file.content.original_filename|extract_right( 3 )|downcase(), 'pdf'))}
				{def $pictoType=$object.data_map.file.content.original_filename|extract_right( 3 )|downcase()}
				{else}{def $pictoType='other'}
			{/if}

<a class="btn-hard-grey-arrow-left" title="{if $object_parameters.label}{$object_parameters.label}{else}{$object.name|wash}{/if} - {$object.data_map.file.content.filesize|si( byte )} - {if is_set($pictoName)}{$pictoName}{else}{$object.data_map.file.content.original_filename|extract_right( 3 )}{/if}" href="{concat('/content/download/',
$object.data_map.file.contentobject_id, '/',
$object.data_map.file.id,'/version/',
$object.data_map.file.version , '/file/',
$object.data_map.file.content.original_filename|urlencode )}{$object_parameters.signet}">		
<img src="{concat('images/pictos/file/xsmall/',$pictoType,'.gif')|ezdesign(no)}" alt="{$pictoType}" border="0" /> {if $object_parameters.label}{$object_parameters.label}{else}{$object.name|wash}{/if} (<span class="extension">{if is_set($pictoName)}{$pictoName}{else}{$object.data_map.file.content.original_filename|extract_right( 3 )}{/if}</span>)</a>
<br />
{undef}