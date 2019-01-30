{def
$html = ''
$parts = array()
}
{if $object.data_map.caption.has_content}
    {set $html = ''}
    {set-block variable=$html}{attribute_view_gui attribute=$object.data_map.caption}{/set-block}
    {set $parts = $parts|append($html|trim)}
{/if}
{if $object.data_map.credit.has_content}
    {set $html = ''}
    {set-block variable=$html}&copy; {attribute_view_gui attribute=$object.data_map.credit}{/set-block}
    {set $parts = $parts|append($html|trim)}
{/if}
{def $embed_class = ""}
{if $object_parameters.align}
    {set $embed_class = $embed_class|append($object_parameters.align)}
{/if}
{if ne($classification|trim,'')}
    {set $embed_class = $embed_class|append($classification|wash)}
{/if}
<figure class="{$embed_class}">
    {attribute_view_gui attribute=$object.data_map.image image_class=first_set($object_parameters.size, 'small') alt=first_set($object.data_map.alt.content, '')}
    {if $parts|count}
        <figcaption>{$parts|implode(', ')}</figcaption>
    {/if}
</figure>