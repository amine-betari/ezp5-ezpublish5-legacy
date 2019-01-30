{if eq($object.class_identifier, 'user')|not()}
<div class="{if $object_parameters.align}object-{$object_parameters.align}{/if}{if ne($classification|trim,'')} {$classification|wash}{/if}"{if is_set($object_parameters.id)} id="{$object_parameters.id}"{/if}>
{default attribute_parameters=array()}
{section show=$object.main_node_id|null|not}
    <a href={$object.main_node.url_alias|ezurl}>{if eq($object_parameters.label, '')|not()}{$object_parameters.label}{else}{$object.name|wash}{/if}</a>
{section-else}
    {$object.name|wash}
{/section}
{/default}
</div>
{else}
{def $whoswhos = fetch( 'content', 'tree', hash(
									  'parent_node_id', 2,
              						  'class_filter_type',  'include',
              						  'class_filter_array', array( 'bouygues_whoswho_search'),
              						  'depth', 3,
              						  'limitation', array()
              						  ))}
{def $section_id = getSection()}
{foreach $whoswhos as $whoswho}{if eq($whoswho.object.section_id, $section_id)}{def $url = $whoswho.url_alias}{/if}{/foreach}
<a href={concat($url,'/(userId)/',$object.id)|ezurl}>{if eq($object_parameters.label, '')|not()}{$object_parameters.label}{else}{$object.name|wash}{/if}</a><br/>{/if}