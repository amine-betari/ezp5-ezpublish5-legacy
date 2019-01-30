{set-block scope=global variable=cache_ttl}0{/set-block}
{set-block variable=$linkHTML}
{def $n=fetch(content, node, hash(node_path, $href))}
{if and($n,$n.object.class_identifier|eq('user'))}
{def $user_id=$n.object.id}
{def $section_id_environnement = getSection()}
{def $whoswhos = fetch( 'content', 'tree', hash(
									  'parent_node_id', 2,
              						  'class_filter_type',  'include',
              						  'class_filter_array', array( 'bouygues_whoswho_search'),
              						  'depth', 3,
              						  'limitation', array()
              						  ))}
{foreach $whoswhos as $whoswho}{if eq($whoswho.object.section_id, $section_id_environnement)}{def $url = $whoswho.url_alias}{/if}{/foreach}
<a href={concat('/',$url,'/(userId)/',$user_id)|ezurl} {section show=$target} target="{$target}"{/section}>{$content}</a>{if eq($classification, 'Saut de ligne')}<br/>{/if}
{else}
{def $attribute='' $url=false() $protocols=array('http', 'file', 'ftp', 'mailto', 'https')}{if $protocols|contains( $href|explode(':')|extract_left(1) )not()
    }{if and($n, $n.object.class_identifier|eq('file'))
    }{set $attribute=$n.data_map.file
    }{set $url=concat( '/content/download/', $attribute.contentobject_id, '/', $attribute.id,'/version/', $attribute.version , '/file/', $attribute.content.original_filename|urlencode )
    }{/if}{/if}{if $url|not()}{set $url=$href}{/if}


{if $caid|eq('yes')}{def $caidParam=caidParameter()}{def $EbyKey=concat('?EbyKey=', $caidParam)}{else}{def $EbyKey=''}{/if}<a href="{$url|ezurl(no)}{$EbyKey}" {section show=$title} title="{$title}"{/section}{section show=$target} target="{$target}"{/section}{section show=ne($classification|trim,'')} class="{$classification|wash}"{/section}>{$content}</a>
{if eq($classification, 'Saut de ligne')}<br/>{/if}{undef $n $attribute $url $protocols}
{/if}
{/set-block}
{$linkHTML}