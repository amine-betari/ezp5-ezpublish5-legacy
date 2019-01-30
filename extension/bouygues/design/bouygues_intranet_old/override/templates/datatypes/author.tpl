{section var=Authors loop=$attribute.content.author_list sequence=array( bglight, bgdark )}
{if $Authors.item.email}<a href="mailto:{$Authors.item.email|wash( xhtml )}">{/if}{$Authors.item.name|wash( xhtml )}{if $Authors.item.email}</a>{/if}{delimiter}<br />{/delimiter}
{/section}