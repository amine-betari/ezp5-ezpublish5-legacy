{let content_object_version=fetch(notification,event_content,hash(event_id,$collection_item.event_id))}

{def $result=$content_object_version.contentobject.main_node}

{*debug bin : {$result.url_alias}
debug bin : {$content_object_version.contentobject.class_identifier}
*}

{def $linkedNode = ''}
{include uri="design:blocs/setlinkednode.tpl"}
{def $url = '' $urlTarget=''}
{include uri="design:blocs/setlink.tpl"}

- {if $url|eq('')|not()}<a href="{if and($url|contains('https://')|not(),$url|contains('http://')|not())}https://{ezini("SiteSettings","SiteURL")}{$url}{else}{$url}{/if}" target="_blank" style="color: #2576c7; text-decoration: none">{else}<span style="color: #2576c7; text-decoration: none">{/if}{$content_object_version.contentobject.name}{if $url|eq('')|not()}</a>{else}</span>{/if}<br/>
{/if}
{undef $result $linkedNode $url}
{/let}
