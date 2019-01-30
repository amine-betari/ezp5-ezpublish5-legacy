{* Génére la liste des iframes incluses dans un contenu *}

{def $bloc_iframes = fetch('content','list',hash('parent_node_id',$node.node_id,'class_filter_type','include','class_filter_array',array('bouygues_iframe'),'sort_by',array(array('priority'))))}
 
{foreach $bloc_iframes as $iframe}
  <iframe src="{$iframe.data_map.url.content}" width="693" height="{$iframe.data_map.hauteur.content}" frameborder="0"></iframe>
{/foreach}
