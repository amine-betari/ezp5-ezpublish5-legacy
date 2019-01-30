{def $img_path  = 'extension/eznewsletter/design/standard/images/'}
{def $img_path_bouygues  = 'extension/bouygues/design/bouygues_intranet/images/'}
{def $host_path = eZDefaultHostname()}
{def $image_host_path = eZDefaultHostname(1)}
{def $sys_path  = ezsys('sitedir')}
{def $object = $node.object}

{def $currentLocale=fetch( 'content', 'locale' ) $lang=''}
{if $currentLocale.locale_code|eq('eng-US')}{set $lang='/en'}{/if}

{def $arrCssSubStructure = ezini( 'CssSettings', 'arrIdToString', 'bouygues.ini' )}
{if is_set($arrCssSubStructure[$object.section_id])}{def $classCss = $arrCssSubStructure[$object.section_id]}
{else}{def $classCss = 'default'}{/if}
{def $filieres = fetch('content', 'list', hash('parent_node_id', 2, 'class_filter_type', 'include', 'class_filter_array', array('bouygues_master_page')))}
{foreach $filieres as $filiere}{if $filiere.object.section_id|eq($object.section_id)}{def $filiere_url=$filiere.url_alias}{def $titleNewsletter = $filiere.object.name}{break}{/if}{/foreach}

{if $titleNewsletter|eq('')}{def $titleNewsletter = 'e.by'}{/if}

{if $classCss|eq('communication')}{def $colorCss='fc9a01'}
{elseif $classCss|eq('consolidation')}{def $colorCss='0db5e2'}
{elseif $classCss|eq('developpement-durable')}{def $colorCss='74ca05'}
{elseif $classCss|eq('imb')}{def $colorCss='585bff'}
{elseif $classCss|eq('informatique')}{def $colorCss='16ad06'}
{elseif $classCss|eq('innovation')}{def $colorCss='0184a2'}
{elseif $classCss|eq('europe')}{def $colorCss='fe0000'}
{elseif $classCss|eq('controle-interne')}{def $colorCss='d22366'}
{elseif $classCss|eq('rh')}{def $colorCss='a410c4'}
{elseif $classCss|eq('juridique')}{def $colorCss='ff9895'}
{elseif $classCss|eq('finance')}{def $colorCss='ba78ff'}
{else}{def $colorCss='e6642a'}
{/if}

{def $url=''}
{def $urlLink=''}

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

    <meta http-equiv="content-type" content="text/html; charset=windows-1250" />

</head>
<body style="margin:0;padding:10px 0px;background-color:#cee1f4;">

{literal}
    <style type="text/css">
        p {margin:0}
        a {text-decoration:none;color:#2576c7}
    </style>
{/literal}

<table width="610" align="center" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="center"> <font face="Arial, sans-serif" size="1" color="#2576c7">{"see_newsletter"|i18n("design/bouygues/newsletter")} <a href="{concat($host_path,'/layout/set/newsletter/',$object.main_node.url_alias)|ezurl(no)}" target="_blank">{"see_newsletter_link"|i18n("design/bouygues/newsletter")}</a></font></td>
    </tr>
</table>
<table width="610" bgcolor="#ffffff" align="center" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td colspan="2" ><a href="{$host_path}" target="_blank"><img src="{if $object.default_language|eq('eng-US')}{concat($image_host_path, '/', $img_path,'headeren.gif')}{else}{concat($image_host_path, '/', $img_path,'header.gif')}{/if}"  border="0" /></a></td>
</tr>
<tr>
    <td colspan="2" style="padding-left: 213px; font-size: 22px; color:#646464;
				font-family:Arial;"><font face="Arial, sans-serif" style="font-size:22px; color: #646464">{$titleNewsletter}</font></td>
</tr>
<tr>
    <td colspan="2" style="padding-left:213px;padding-top:10px;">
        <font face="Arial, sans-serif" color="#{$colorCss}" style="font-size:12px"><img src="{concat($image_host_path, '/', $img_path_bouygues,'breadcrumb/',$classCss,'/start_hard.gif')}" /> {$node.data_map.title.content}</font></td>
</tr>
<tr>
    <td colspan="2" style="padding:20px 0 10px">
        <table width="572" align="center">
            <tr>
                <td><font face="Arial, sans-serif" size="2" color="#f96000"><strong style="font-size:12px">{if $object.default_language|eq('eng-US')}{currentdate()|datetime('custom','%l %d')} {currentdate()|datetime('custom','%F')} {currentdate()|datetime('custom','%Y')|downcase}
                            {else}
                                {currentdate()|datetime('custom','%l %d')} {currentdate()|datetime('custom','%F')|downcase} {currentdate()|datetime('custom','%Y')|downcase}
                            {/if}</strong></font>
                </td>
                <td align="right"><font face="Arial, sans-serif" size="2" color="#2576c7" style="font-size:12px">
                        {if and(is_set($object.all_languages.eng-US),$object.default_language|eq('fre-FR'))}
                            <a href="{concat($host_path,'/en/layout/set/newsletter/',$object.main_node.url_alias)|ezurl(no)}" style="color: #2576c7; text-decoration: none" target="_blank"><u>{"content_english"|i18n("design/bouygues/tools")}</u> <img src="{concat($image_host_path, '/', $img_path_bouygues,"pictos/englishFlag.gif")}" alt="" border="0" style="vertical-align:middle"/></a>
                        {elseif and(is_set($object.all_languages.eng-US),$object.default_language|eq('eng-US'))}

                            <a href="{concat($host_path,'/layout/set/newsletter/',$object.main_node.url_alias)|ezurl(no)}" style="color: #2576c7; text-decoration: none" target="_blank"><u>{"content_french"|i18n("design/bouygues/tools")}</u> <img src="{concat($image_host_path, '/', $img_path_bouygues,"pictos/frenchFlag.gif")}" alt="" border="0" style="vertical-align:middle"/></a>
                        {elseif and(is_set($object.all_languages.eng-US)|not(),$object.default_language|eq('eng-US'))}
                            <u style="color: #2576c7" >{"content_french_only"|i18n("design/bouygues/tools")}</u> <img src="{concat($image_host_path, '/', $img_path_bouygues,"pictos/frenchFlag.gif")}" alt="" border="0" />
                        {/if}</font>
                </td>
            </tr>
        </table>
    </td>
</tr>


{if $node.data_map.pretext.has_content}
    {if $node.data_map.edito_image.has_content}{set $url=$node.data_map.edito_image.content.newslettermain.url|ezroot(no)}{/if}
    {set $urlLink=''}
    {if $node.data_map.edito_link.has_content}{set $urlLink=$node.data_map.edito_link.content}{/if}
    <tr>
        <td colspan="2">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="19" rowspan="3"></td>
                    <td {if eq($url, '')|not()}colspan="2"{/if}><img src="{concat($image_host_path, '/', $img_path,'editoTop.gif')}" /></td>
                    <td width="19" rowspan="3"></td>
                </tr>
                <tr>
                    {if eq($url, '')|not()}
                        <td valign="top" align="left" style="border-left:1px solid #dceaf9;padding:5px 15px" width="214">
                            <div style="border:1px solid #0e7d9a;width:214px;background-color:white;text-align:center;">
                                {if eq($urlLink, '')|not()}<a href="{$urlLink}" style="color: #f96000; font-size: 15px; text-decoration: none;" target="_blank">{/if}<img src="{concat($host_path,$url)}" alt="" border="0" />{if eq($urlLink, '')|not()}</a>{/if}
                            </div>
                        </td>
                    {/if}
                    <td style="border-right:1px solid #efefef;{if eq($url, '')}border-left:1px solid #efefef;padding:5px 15px 15px 15px;{else}padding:5px 15px 15px 0px;{/if}">
                        {if eq($urlLink, '')|not()}<a href="{$urlLink}" style="color: #f96000; font-size: 15px; text-decoration: none;" target="_blank">{/if}<font face="Arial, sans-serif" size="5" color="#2576c7"><strong>{$node.data_map.edito_title.content}</strong></font>{if eq($urlLink, '')|not()}</a>{/if}<br>
                        <font face="Arial, sans-serif" size="2" color="#646464" style="font-size:14px;line-height:1.5em;">{$node.data_map.pretext.content.output.output_text}</font>
                        <font face="Arial, sans-serif" color="#646464">{if eq($urlLink, '')|not()}<br /><a href="{$urlLink}" style="color: #2576c7; font-size: 14px; text-decoration: none;" target="_blank"><img src="{concat($image_host_path, '/', $img_path,'more.gif')}" border="0"/>&nbsp;En savoir plus</a>{/if}</font>
                    </td>
                </tr>
                <tr>
                    <td {if eq($url, '')|not()}colspan="2"{/if}><img src="{concat($image_host_path, '/', $img_path,'editoBottom.gif')}" /></td>
                </tr>
            </table>
        </td>
    </tr>
{/if}
{set $urlLink = ''}
{if $node.data_map.topics.has_content}
    {def $main_topic=fetch('content', 'node', hash('node_id', $node.data_map.topics.content.main_node.node_id))}
    {if $main_topic.data_map.image_vignette.has_content}{set $url=$main_topic.data_map.image_vignette.content.newslettermain.url|ezroot(no)}
    {elseif $main_topic.data_map.image_texte.has_content}{set $url=$main_topic.data_map.image_texte.content.newslettermain.url|ezroot(no)}
    {elseif $main_topic.data_map.image_main.has_content}{set $url=$main_topic.data_map.image_main.content.newslettermain.url|ezroot(no)}
    {else}{set $url=''}
    {/if}

    {if $main_topic.class_identifier|eq('file')}
        {set $urlLink=concat($host_path,'/content/download/',
        $main_topic.data_map.file.contentobject_id, '/',
        $main_topic.data_map.file.id,'/version/',
        $main_topic.data_map.file.version , '/file/',
        $main_topic.data_map.file.content.original_filename|urlencode)|ezurl(no)}
    {elseif $main_topic.class_identifier|eq('link')}
        {set $urlLink=concat($host_path,$main_topic.data_map.lien.content|ezurl(no))}
    {elseif $main_topic.class_identifier|eq('bouygues_element_liste')|not()}
        {set $urlLink=concat($host_path,$main_topic.url_alias|ezurl(no))}
    {elseif and($main_topic.class_identifier|eq('bouygues_element_liste'),or($main_topic.data_map.lien_eby.has_content, $main_topic.data_map.lien_ext.has_content))}
        {if $main_topic.data_map.lien_eby.has_content}
            {set $urlLink=concat($host_path,$main_topic.data_map.lien_eby.value.main_node.url_alias|ezurl(no))}
        {elseif $main_topic.data_map.lien_ext.has_content}
            {set $urlLink=concat($main_topic.data_map.lien_ext.content|ezurl(no))}
        {else}{set $urlLink = ''}{/if}
    {else}
        {set $urlLink=''}
    {/if}


    <tr>
        <td style="padding-top:10px" colspan="2">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="19"></td>
                    <td colspan="2"><img src="{concat($image_host_path, '/', $img_path,'newsTop.gif')}" /></td>
                    <td width="19"></td>
                </tr>
                <tr>
                    <td width="19"></td>
                    <td colspan="2" style="border-left:1px solid #dceaf9;border-right:1px solid #dceaf9;padding:5px 15px">
                        <font face="Arial, sans-serif" size="4" color="#646464"><strong>{$node.data_map.topics_title.content}</strong></font>
                    </td>
                    <td width="19"></td>
                </tr>
                <tr>
                    <td width="19"></td>
                    {if eq($url, '')|not()}
                        <td valign="top" align="left" style="border-left:1px solid #dceaf9;padding:5px 15px" width="214">
                            <div style="border:1px solid #0e7d9a;width:214px;background-color:white;text-align:center;">
                                {if eq($urlLink, '')|not()}<a href="{$urlLink}" style="color: #f96000; font-size: 15px; text-decoration: none; border: 0px;" target="_blank">{/if}<img src="{concat($host_path,$url)}" alt="" border="0" />{if eq($urlLink, '')|not()}</a>{/if}
                            </div>
                        </td>
                    {/if}
                    <td style="border-right:1px solid #dceaf9;padding-right: 15px; padding-bottom:5px;{if eq($url, '')}border-left:1px solid #dceaf9;padding-left: 15px{/if}" valign="top" {if eq($url, '')}colspan="2"{/if}>
                        <font face="Arial, sans-serif" color="#646464">
                            {set $filieretopic=fetch('content', 'tree', hash('parent_node_id', 2,
                            'class_filter_type', 'include',
                            'class_filter_array', array('bouygues_master_page'),
                            'depth', 1,
                            'limit', 1,
                            'offset', 0,
                            'attribute_filter', array(array('section', '=', $main_topic.object.section_id))))}
                            <span style="font-size: 12px;"><strong>{if $filieretopic|not}Groupe{else}{$filieretopic.0.object.name}{/if}</strong></span><br />
                            {if eq($urlLink, '')|not()}<a href="{$urlLink}" style="color: #f96000; font-size: 15px; text-decoration: none;" target="_blank"><span style="color: #f96000; font-size: 15px;">{$main_topic.name}</span>{/if}{if eq($urlLink, '')|not()}</a>{/if}<br>
			    						<span style="font-size: 12px;">
			    						{if is_set($main_topic.data_map.date_pub)}
                                            {$main_topic.data_map.date_pub.data_int|datetime( 'custom', '%d/%m/%Y' )}
                                        {elseif is_set($main_topic.object.current.modified)}
                                            {$main_topic.object.current.modified|datetime( 'custom', '%d/%m/%Y' )}
                                        {/if}</span><br>

                            {if eq($urlLink, '')|not()}<a href="{$urlLink}" style="color: #646464; text-decoration: none;" target="_blank">{/if}<span style="font-size: 13px;">{if $main_topic.data_map.accroche_liste.has_content}
											{$main_topic.data_map.accroche_liste.content.output.output_text}
										{elseif $main_topic.data_map.intro.has_content}
											{$main_topic.data_map.intro.content.output.output_text|strip_tags()|shorten(300,'...')}
										{elseif $main_topic.data_map.chapeau.has_content}
											{$main_topic.data_map.chapeau.content.output.output_text|strip_tags()|shorten(300,'...')}
										{elseif $main_topic.data_map.description.has_content}
											{$main_topic.data_map.description.content.output.output_text|strip_tags()|shorten(300,'...')}
										{elseif $main_topic.data_map.body.has_content}
											{$main_topic.data_map.body.content.output.output_text|strip_tags()|shorten(300,'...')}
										{elseif $main_topic.data_map.contenu_texte.has_content}
											{$main_topic.data_map.contenu_texte.content.output.output_text|strip_tags()|shorten(300,'...')}
										{/if}</span>{if eq($urlLink, '')|not()}</a>{/if}<br>

                            {if eq($urlLink, '')|not()}<a href="{$urlLink}" style="color: #2576c7; font-size: 14px; text-decoration: none;" target="_blank"><img src="{concat($image_host_path, '/', $img_path,'more.gif')}" border="0"/>&nbsp;En savoir plus</a>{/if}</font>
                    </td>
                    <td width="19"></td>
                </tr>
                <tr>
                    <td width="19"></td>
                    <td colspan="2"><img src="{concat($image_host_path, '/', $img_path,'newsBottom.gif')}" /></td>
                    <td width="19"></td>
                </tr>
            </table>
        </td>
    </tr>
    {undef $main_topic}
{/if}
{if $node.data_map.other_topics.has_content}

    <tr>
        <td style="padding-top:10px">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="19"></td>
                    <td colspan="2"><img src="{concat($image_host_path, '/', $img_path,'newsTop.gif')}" /></td>
                    <td width="19"></td>
                </tr>

                <tr>
                    <td width="19"></td>
                    <td colspan="2" style="border-left:1px solid #dceaf9;border-right:1px solid #dceaf9;padding:5px 15px">
                        <font face="Arial, sans-serif" size="4" color="#646464"><strong>{$node.data_map.other_topics_title.content}</strong></font>
                    </td>
                    <td width="19"></td>
                </tr>
                <tr>
                    <td width="19"></td>
                    <td colspan="2" style="border-left:1px solid #dceaf9;border-right:1px solid #dceaf9;padding:5px 15px">
                        {foreach $node.data_map.other_topics.content.relation_list as $otherTopic}
                            {def $main_topic=fetch('content', 'node', hash('node_id', $otherTopic.node_id))}

                            {if $main_topic.data_map.image_vignette.has_content}{set $url=$main_topic.data_map.image_vignette.content.newsletterother.url|ezroot(no)}
                            {elseif $main_topic.data_map.image_texte.has_content}{set $url=$main_topic.data_map.image_texte.content.newsletterother.url|ezroot(no)}
                            {elseif $main_topic.data_map.image_main.has_content}{set $url=$main_topic.data_map.image_main.content.newsletterother.url|ezroot(no)}
                            {else}{set $url=''}
                            {/if}

                            {if $main_topic.class_identifier|eq('file')}
                                {set $urlLink=concat($host_path,'/content/download/',
                                $main_topic.data_map.file.contentobject_id, '/',
                                $main_topic.data_map.file.id,'/version/',
                                $main_topic.data_map.file.version , '/file/',
                                $main_topic.data_map.file.content.original_filename|urlencode)|ezurl(no)}
                            {elseif $main_topic.class_identifier|eq('link')}
                                {set $urlLink=concat($host_path,$main_topic.data_map.lien.content|ezurl(no))}
                            {elseif $main_topic.class_identifier|eq('bouygues_element_liste')|not()}
                                {set $urlLink=concat($host_path,$main_topic.url_alias|ezurl(no))}
                            {elseif and($main_topic.class_identifier|eq('bouygues_element_liste'),or($main_topic.data_map.lien_eby.has_content, $main_topic.data_map.lien_ext.has_content))}
                                {if $main_topic.data_map.lien_eby.has_content}
                                    {set $urlLink=concat($host_path,$main_topic.data_map.lien_eby.value.main_node.url_alias|ezurl(no))}
                                {elseif $main_topic.data_map.lien_ext.has_content}
                                    {set $urlLink=concat($main_topic.data_map.lien_ext.content|ezurl(no))}
                                {else}{set $urlLink = ''}{/if}
                            {else}
                                {set $urlLink=''}
                            {/if}

                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    {if eq($url, '')|not()}
                                        <td width="132" valign="top" rowspan="2" align="left" style="padding-right:15px">
                                            <table cellpadding="0" cellspacing="0" width="132" align="left" style="border:1px solid #0e7d9a;text-align:center;"><tr><td>{if eq($urlLink, '')|not()}<a href="{$urlLink}" target="_blank" >{/if}<img src="{concat($host_path,$url)}" alt="" border="0" />{if eq($urlLink, '')|not()}</a>{/if}</td></tr></table>
                                        </td>
                                    {elseif and($main_topic.class_identifier|eq('bouygues_video'),not(eq($main_topic.data_map.video_wat.content.display, '')))}
                                        <td width="132" valign="top" rowspan="2" align="left" style="padding-right:15px">
                                            <table cellpadding="0" cellspacing="0" width="132" align="left" style="border:1px solid #0e7d9a;text-align:center;"><tr><td>{if eq($urlLink, '')|not()}<a href="{$urlLink}" target="_blank" >{/if}<img width="130" height="84" src="{$main_topic.data_map.video_wat.content.thumb_mini}" alt="" border="0" />{if eq($urlLink, '')|not()}</a>{/if}</td></tr></table>
                                        </td>
                                    {/if}
                                    <td {if eq($url, '')|not()}style="padding-left: 10px"{/if} valign="top" width="90%">
                                        <font face="Arial, sans-serif" color="#646464">
                                            {set $filieretopic=fetch('content', 'tree', hash('parent_node_id', 2,
                                            'class_filter_type', 'include',
                                            'class_filter_array', array('bouygues_master_page'),
                                            'depth', 1,
                                            'limit', 1,
                                            'offset', 0,
                                            'attribute_filter', array(array('section', '=', $main_topic.object.section_id))))}
                                            <span style="font-size: 12px;"><strong>{if $filieretopic|not}Groupe{else}{$filieretopic.0.object.name}{/if}</strong></span><br />
                                            {if eq($urlLink, '')|not()}<a href="{$urlLink}" target="_blank" style="color: #f96000;text-decoration: none;">{/if}<span style="color: #f96000; font-size: 15px;">{$main_topic.name}</span>{if eq($urlLink, '')|not()}</a>{/if}<br>
				    						<span style="font-size: 12px;">
				    						{if and(is_set($main_topic.data_map.date_pub),$main_topic.data_map.date_pub|eq(''))}
                                                {$main_topic.data_map.date_pub.data_int|datetime( 'custom', '%d/%m/%Y' )}
                                            {elseif is_set($main_topic.object.current.modified)}
                                                {$main_topic.object.current.modified|datetime( 'custom', '%d/%m/%Y' )}
                                            {/if}</span></font>

                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">{if eq($urlLink, '')|not()}<a href="{$urlLink}" target="_blank" style="text-decoration: none;"><img src="{concat($image_host_path, '/', $img_path,'more2.gif')}" border="0"/></a>{/if}</td>
                                </tr>
                                <tr>
                                    <td {if or(eq($url, '')|not(),and($main_topic.class_identifier|eq('bouygues_video'),not(eq($main_topic.data_map.video_wat.content.display, ''))))}colspan="2"{/if} valign="top" style="padding:10px 0px 20px;font-size: 12px;">
                                        <font face="Arial, sans-serif" color="#646464">
                                            {if eq($urlLink, '')|not()}<a href="{$urlLink}" target="_blank" style="color: #646464;text-decoration: none;">{/if}<span style="font-size: 12px;">{if $main_topic.data_map.accroche_liste.has_content}
												{$main_topic.data_map.accroche_liste.content.output.output_text}
											{elseif $main_topic.data_map.intro.has_content}
												{$main_topic.data_map.intro.content.output.output_text|strip_tags()|shorten(300,'...')}
											{elseif $main_topic.data_map.chapeau.has_content}
												{$main_topic.data_map.chapeau.content.output.output_text|strip_tags()|shorten(300,'...')}
											{elseif $main_topic.data_map.description.has_content}
												{$main_topic.data_map.description.content.output.output_text|strip_tags()|shorten(300,'...')}
											{elseif $main_topic.data_map.body.has_content}
												{$main_topic.data_map.body.content.output.output_text|strip_tags()|shorten(300,'...')}
											{elseif $main_topic.data_map.contenu_texte.has_content}
												{$main_topic.data_map.contenu_texte.content.output.output_text|strip_tags()|shorten(300,'...')}
											{/if}</span>{if eq($urlLink, '')|not()}</a>{/if}<br>
                                        </font>
                                    </td>
                                </tr>
                            </table>

                            {undef $main_topic}
                        {/foreach}
                    </td>
                    <td width="19"></td>
                </tr>
                <tr>
                    <td width="19"></td>
                    <td colspan="2"><img src="{concat($image_host_path, '/', $img_path,'newsBottom.gif')}" /></td>
                    <td width="19"></td>
                </tr>
            </table>
        </td>
    </tr>
{/if}

{if $node.data_map.agenda.has_content}
{def $datas = fetch( 'content', 'list',hash( 'parent_node_id', $node.data_map.agenda.content.main_node.node_id,
'class_filter_type',  'include',
'class_filter_array', array( 'bouygues_entree_agenda'),
'sort_by', array('attribute' ,true(),'bouygues_entree_agenda/date_debut') ))}
<tr>
    <td style="padding-top:10px">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td width="19" rowspan="3"></td>
                <td><img src="{concat($image_host_path, '/', $img_path,'editoTop.gif')}" /></td>
                <td width="19" rowspan="3"></td>
            </tr>
            <tr>
                <td style="border-left:1px solid #efefef;border-right:1px solid #efefef;padding:5px 15px 15px 15px"><font face="Arial, sans-serif" style="font-size:12px; color: #646464"><strong style="font-size:12px;line-height:24px">{$node.data_map.agenda_title.content}</strong></font>
                    <table cellpadding="0" cellspacing="0" width="100%" style="border-top:1px solid #e3e3e3">

                        {def $counter=1}{def $numDatas=count($datas)}{def $i=1}{set $url=''}
                        {foreach $datas as $data}

                            {if eq($counter, 1)}<tr><td {if $i|eq($numDatas)}colspan="2"{/if} valign="top" style="padding-top:18px">
                            {else}<td width="50%"  style="padding-top:18px" valign="top">{/if}

                            <table width="262">
                                <tr>
                                    <td width="24" valign="top"><img src="{concat($image_host_path, '/', $img_path,'more3.gif')}" border="0"/></td>
                                    <td width="240" valign="top">
                                        <font face="Arial, sans-serif" size="2" color="#646464">
                                            <strong>
                                                {if $data.data_map.date_fin.has_content}du{/if}
                                                {$data.data_map.date_debut.data_int|datetime( 'custom', '%d/%m/%y' )}
                                                {if $data.data_map.date_fin.has_content}au {$data.data_map.date_fin.data_int|datetime( 'custom', '%d/%m/%y' )}{/if}
                                            </strong><br>
                                            {set $url=""}
                                            {if $data.data_map.url_ext.has_content}
                                                {set $url=$data.data_map.url_ext.content}
                                            {elseif $data.data_map.lien_eby.has_content}
                                                {set $url=concat($host_path,'/',$data.data_map.lien_eby.content.main_node.url_alias)}
                                            {/if}
                                            {if $url|eq('')|not()}<a href="{$url|ezurl(no)}" target="_blank" style="text-decoration: none;">{/if}
                                                <font color="#2576c7"><span style="font-size:11px;">{$data.data_map.titre.content|shorten(100,'...')}</span></font>
                                                {if $url|eq('')|not()}</a>{/if}
                                            <p style="font-size:11px;">{$data.data_map.description.content.output.output_text}</p>
                                        </font>
                                    </td>
                                </tr>
                            </table>

                            {if eq($counter, 2)}{set $counter=1}</td></tr>
                            {else}{set $counter=inc($counter)}</td>{/if}

                            {set $i=inc($i)}
                        {/foreach}
                        {if eq($counter, 2)}</tr>{/if}
                    </table>

                </td>
            </tr>
            {else}{set $counter=inc($counter)}
            </td>
            </tr>
            {/if}

            {if $node.data_map.bypedia_text.has_content}
                <tr>
                    <td style="padding-top:10px">
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td width="19"></td>
                                <td colspan="2"><img src="{concat($image_host_path, '/', $img_path,'newsTop.gif')}" /></td>
                                <td width="19"></td>
                            </tr>

                            {if $node.data_map.bypedia_big_title.has_content}
                                <tr>
                                    <td width="19"></td>
                                    <td colspan="2" style="border-left:1px solid #dceaf9;border-right:1px solid #dceaf9;padding:5px 15px">
                                        <font face="Arial, sans-serif" size="4" color="#646464"><strong>{$node.data_map.bypedia_big_title.content}</strong></font>
                                    </td>
                                    <td width="19"></td>
                                </tr>
                            {/if}

                            <tr>
                                <td width="19"></td>
                                <td colspan="2" style="border-left:1px solid #dceaf9;border-right:1px solid #dceaf9;padding:5px 15px">

                                    <table width="100%" cellpadding="0" cellspacing="0">
                                        <tr>
                                            {set $url=''}
                                            {set $urlLink=''}
                                            {if $node.data_map.bypedia_link.has_content}{set $urlLink=$node.data_map.bypedia_link.content}{/if}
                                            {if $node.data_map.bypedia_image.has_content}{set $url=$node.data_map.bypedia_image.content.newsletterother.url|ezroot(no)}{/if}
                                            {if eq($url, '')|not()}
                                                <td width="132" valign="top" rowspan="2" align="left" style="padding-right:15px">
                                                    <table cellpadding="0" cellspacing="0" width="132" align="left" style="border:1px solid #0e7d9a;text-align:center;"><tr><td>{if eq($urlLink, '')|not()}<a href="{$urlLink}" target="_blank" >{/if}<img src="{concat($host_path,$url)}" alt="" border="0" />{if eq($urlLink, '')|not()}</a>{/if}</td></tr></table>
                                                </td>
                                            {/if}
                                            <td style="{if eq($url, '')|not()}padding-left: 10px;{/if}font-size:12px;" valign="top" width="90%">
                                                <font face="Arial, sans-serif" color="#646464">
                                                    <span style="color: #f96000; font-size: 15px;">{if eq($urlLink, '')|not()}<a href="{$urlLink}" target="_blank" style="text-decoration: none;color: #f96000;">{/if}{$node.data_map.bypedia_title.content}{if eq($urlLink, '')|not()}</a>{/if}</span>
                                                    {if $node.data_map.bypedia_date.has_content}<br>{$node.data_map.bypedia_date.data_int|datetime( 'custom', '%d/%m/%Y' )}{/if}
                                                </font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">{if eq($urlLink, '')|not()}<a href="{$urlLink}" target="_blank" style="text-decoration: none;"><img src="{concat($image_host_path, '/', $img_path,'more2.gif')}" border="0"/></a>{/if}</td>
                                        </tr>
                                        <tr>
                                            <td style="font-size:12px;padding:10px 0px 0px 0px;" valign="top" colspan="{if eq($url, '')}2{else}3{/if}">
                                                <font face="Arial, sans-serif" color="#646464">
                                                    <font face="Arial, sans-serif" color="#646464">{$node.data_map.bypedia_text.content.output.output_text}</font>
                                                </font>
                                            </td>
                                        </tr>
                                    </table>

                                </td>
                                <td width="19"></td>
                            </tr>
                            <tr>
                                <td width="19"></td>
                                <td colspan="2"><img src="{concat($image_host_path, '/', $img_path,'newsBottom.gif')}" /></td>
                                <td width="19"></td>
                            </tr>
                        </table>
                    </td>
                </tr>

            {/if}


            <tr>
                <td style="padding-top: 10px;">
                    <table width="572" height="80" align="center" cellpadding="0" cellspacing="0" background="{concat($image_host_path, '/', $img_path,'footerBg.gif')}">
                        <tr>
                            <td align="center" width="191" height="60" style="padding-top: 20px;" valign="top">
                                <font face="Arial, sans-serif" size="2"><a href="{concat($host_path,'/',$filiere_url)|ezurl(no)}" target="_blank" style="font-size: 12px; text-decoration: none; color: #646464">{"go_to_eby"|i18n("design/bouygues/newsletter")}</a></font>
                            </td>
                            <td align="center" width="190" style="padding-top: 20px;" valign="top">
                                <font face="Arial, sans-serif" size="2"><a href="http://bypedia.com" target="_blank" style="font-size: 12px; text-decoration: none; color: #646464">BYPEDIA</a></font>
                            </td>
                            <td align="center" width="191" style="padding-top: 20px;" valign="top">
                                <font face="Arial, sans-serif" size="2"><a href="{concat($host_path, '/static/webmaster')|ezurl(no)}" target="_blank" style="font-size: 12px; text-decoration: none; color: #646464">{"contact"|i18n("design/bouygues/newsletter")}</a></font>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

            <tr>
                <td><img src="{concat($image_host_path, '/', $img_path,'footer.gif')}" /></td>
            </tr>
        </table>

</body>
</html>