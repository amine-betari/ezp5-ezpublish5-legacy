<a class="btn-hard-grey-arrow-left" href={concat('content/download/',
$object.data_map.file.contentobject_id, '/',
$object.data_map.file.id,'/version/',
$object.data_map.file.version , '/file/',
$object.data_map.file.content.original_filename|urlencode )|ezurl}>
<img src="{concat('images/pictos/',$object.data_map.file.content.mime_type_part,'.gif')|ezdesign(no)}" alt="-" border="0" /> {$object.name|wash} (<span class="extension">{$object.data_map.file.content.mime_type_part}</span>)</a>
