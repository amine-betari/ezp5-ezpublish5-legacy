{def
$children = fetch( 'content', 'list', hash(
'parent_node_id', 2,
'class_filter_type',  'include',
'class_filter_array', array( 'bouygues_master_page' ),
'sort_by', array( array( 'priority' ) )
))
}
{if is_set($currentUser)|not()}{def $currentUser = fetch( 'user', 'current_user' )}{/if}{def
$i=1
$n2=true()
$n3=true()
$n4=true()
$n5=true()
$nolink=false()
$linkN2=false()
$external_link=false()
$count_children=0
$sub_children = ''
$sub_sub_children = ''
$sub_sub_sub_children = ''
$sub_sub_sub_sub_children = ''
$sub_sub_sub_sub_sub_children = ''
$sub_sub_sub_sub_sub_sub_children = ''
$sub_sub_sub_sub_sub_sub_sub_children = ''
}
{if is_set($mode)|not()}{def $mode=''}{/if}{if gt($children|count(),0)}
    <ul id="first">
    <!-- Niv 1 -->
    {def $countMenuItem = 0}
    {if $mode|eq('sitemap')}
        <li class="first first-clear"><a href="{'/'|ezurl(no)}" class="li7 lia-first-row color2-home"
                                         title="{"accueil menu"|i18n("design/bouygues/master")}"><img
                    src="/extension/bouygues/design/bouygues_intranet/images/breadcrumb/home/start_hard.gif"
                    border="0"/> {"accueil menu"|i18n("design/bouygues/master")}</a>
        <ul class="second hideSub">
            <li><a href="{'/static/actu-history'|ezurl(no)}" class="noArrow"
                   title="{"accueil menu"|i18n("design/bouygues/master")} - {"footer_actu"|i18n("design/bouygues/tools")}">{"footer_actu"|i18n("design/bouygues/tools")}</a>
            </li>
            <li><a href="{if $currentUser.is_logged_in}{"ebyperso/home"|ezurl(no)}{else}{"static/ebyperso"|ezurl(no)}{/if}" class="noArrow"
                   title="{"accueil menu"|i18n("design/bouygues/master")} - {"footer_ebyperso"|i18n("design/bouygues/tools")}">{'footer_ebyperso'|i18n('design/bouygues/tools')}</a>
            </li>
            <li><a href="{'/annuaire'|ezurl(no)}" class="noArrow"
                   title="{"accueil menu"|i18n("design/bouygues/master")} - {"footer_annauire"|i18n("design/bouygues/tools")}">{'footer_annuaire'|i18n('design/bouygues/tools')}</a>
            </li>
            <li><a href="{'/recherche'|ezurl(no)}" class="noArrow"
                   title="{"accueil menu"|i18n("design/bouygues/master")} - {"footer_recherche"|i18n("design/bouygues/tools")}">{'footer_recherche'|i18n('design/bouygues/tools')}</a>
            </li>
            <li><a href="{'/static/group'|ezurl(no)}" class="noArrow"
                   title="{"accueil menu"|i18n("design/bouygues/master")} - {"footer_group"|i18n("design/bouygues/tools")}">{'footer_group'|i18n('design/bouygues/tools')}</a>
            </li>
            <li><a href="{'/static/about'|ezurl(no)}" class="noArrow"
                   title="{"accueil menu"|i18n("design/bouygues/master")} - {"footer_about_eby"|i18n("design/bouygues/tools")}">{'footer_about_eby'|i18n('design/bouygues/tools')}</a>
            </li>
            <li><a href="{'/static/sitemap'|ezurl(no)}" class="noArrow"
                   title="{"accueil menu"|i18n("design/bouygues/master")} - {"footer_sitemap"|i18n("design/bouygues/tools")}">{'footer_sitemap'|i18n('design/bouygues/tools')}</a>
            </li>
            <li><a href="{'/static/rss'|ezurl(no)}" class="noArrow"
                   title="{"accueil menu"|i18n("design/bouygues/master")} - {"footer_rss"|i18n("design/bouygues/tools")}">{'footer_rss'|i18n('design/bouygues/tools')|upfirst}</a>
            </li>
            <li><a href="{'/static/webmaster'|ezurl(no)}" class="noArrow"
                   title="{"accueil menu"|i18n("design/bouygues/master")} - {"footer_contact"|i18n("design/bouygues/tools")}">{'footer_contact'|i18n('design/bouygues/tools')}</a>
            </li>
            <li><a href="{'/static/legals'|ezurl(no)}" class="noArrow"
                   title="{"accueil menu"|i18n("design/bouygues/master")} - {"footer_mention"|i18n("design/bouygues/tools")}">{'footer_mention'|i18n('design/bouygues/tools')}</a>
            </li>
            <li><a href="{'/les-sites-du-groupe'|ezurl(no)}" class="noArrow"
                   title="{"accueil menu"|i18n("design/bouygues/master")} - {"footer_sites"|i18n("design/bouygues/tools")}">{'footer_sites'|i18n('design/bouygues/tools')}</a>
            </li>
        </ul>
        </li>
    {/if}
    {foreach $children as $Child}
        {set $countMenuItem = inc($countMenuItem)}
        {if and($mode|eq('sitemap'),$countMenuItem|mod(2)|eq(0) )}
            <li style="clear:both"></li>
        {/if}
    <li class="first {if and($mode|eq('sitemap'),$countMenuItem|mod(2)|eq(0) )}first-clear{/if}">
        <a href={$Child.url_alias|ezurl} class="li{$Child.object.section_id}
        {if $sid|eq($Child.object.section_id)}-active{/if} lia-first-row" title="{$Child.name}">
            {if and($mode|eq('sitemap'),is_set($arrCssSubStructure))}
            <img src={concat("breadcrumb/",$arrCssSubStructure[$Child.object.section_id],"/start_hard.gif")|ezimage} border="0"/>{/if} {$Child.name|wash}</a>
            {set $sub_children = fetch('content','list',hash(
            'parent_node_id', $Child.node_id,
            'class_filter_type', 'include',
            'class_filter_array', array( 'bouygues_page_sessions','article','bouygues_diapo','bouygues_dossier','bouygues_galerie_vid','bouygues_liste','bouygues_liste_thema','bouygues_mini_site','bougues_video','bouygues_categorie', 'bouygues_whoswho_search', 'bouygues_whoswho_list', 'link' ),
            'sort_by', array( array( 'priority' ) )
            ))}
            {foreach $sub_children as $node_children}
                {if or(
                    and(is_set($node_children.data_map.menu_cb),$node_children.data_map.menu_cb.value|eq(1)),
                    $node_children.class_identifier|eq('bouygues_categorie') )}
                    {set $count_children=$count_children|inc}
                {/if}
            {/foreach}
        {if gt($count_children,0)}
        <ul class="second {$arrCssSubStructure[$Child.object.section_id]} hideSub{if eq($countMenuItem,10)} back{/if}">
            <!-- Niv 2 -->
            {foreach $sub_children as $Sub_child}
                {if or(
                        and(is_set($Sub_child.data_map.menu_cb),$Sub_child.data_map.menu_cb.value|eq(1)),
                        $Sub_child.class_identifier|eq('bouygues_categorie'),
                        $Sub_child.class_identifier|eq('link'))}
                    {set $sub_sub_children = fetch('content','list',hash(
                    'parent_node_id', $Sub_child.node_id,
                    'class_filter_type','include',
                    'class_filter_array',array( 'bouygues_page_sessions','article','bouygues_diapo','bouygues_dossier','bouygues_galerie_vid','bouygues_liste','bouygues_liste_thema','bouygues_mini_site','bougues_video','bouygues_categorie', 'bouygues_whoswho_search', 'bouygues_whoswho_list', 'link' ),
                    'attribute_filter',array(array('name','!=',$Sub_child.name)),
                    'sort_by', array( array( 'priority' ) )
                    ))}
                    {*Ouvrir les enfants ?*}
                    {if is_set($Sub_child.data_map.menu_se_cb)}
                        {if $Sub_child.data_map.menu_se_cb.value|eq(1)}
                            {set $n2=true()}
                        {else}
                            {set $n2=false()}

                        /if}
                    {else}
                        {set $n2=true()}
                    {/if}
                    {if $n2}
                        {set $count_children=0}
                        {foreach $sub_sub_children as $node_children}
                            {if or(
                                and(is_set($node_children.data_map.menu_cb),$node_children.data_map.menu_cb.value|eq(1)),
                                $node_children.class_identifier|eq('bouygues_categorie') )}
                                {set $count_children=$count_children|inc}
                                {/if}
                        {/foreach}
                    {else}
                        {set $count_children=0}
                    {/if}
                    {*Gestion des catégories ?*}
                    {set $nolink=false()}
                    {set $linkN2=false()}
                    {if and(is_set($Sub_child.data_map.menu_1se_select),$Sub_child.data_map.menu_1se_select.value.0|eq(1))}
                        {set $nolink=true()}
                    {elseif and(is_set($Sub_child.data_map.menu_1se_select),$Sub_child.data_map.menu_1se_select.value.0|eq(0))}
                        {set $linkN2=true()}
                    {/if}
                    {*Gestion des liens externes ?*}
                    {set $external_link=false()}
                    {if $Sub_child.class_identifier|eq('link')}
                        {set $external_link=$Sub_child.data_map.lien.content|ezurl(no)}
                    {else}
                        {set $external_link=false()}
                    {/if}
            <li{if eq(lt($countMenuItem,6),false())} class="back"{/if}>
                {if $external_link|eq(false())|not()}<a href="{$external_link}"{if lt($count_children,1)}class="noArrow"{else} class="arrow"{/if} target="_blank" title="{$Sub_child.name|wash} - {$Child.name}">{$Sub_child.name|wash}</a>
                {elseif and(eq($nolink, false()),eq($linkN2,false()))}
                <a href={$Sub_child.url_alias|ezurl} {if lt($count_children,1)}class="noArrow"{else}class="arrow"{/if}
                   title="{$Sub_child.name|wash} - {$Child.name}">{$Sub_child.name|wash}</a>
                {elseif eq($linkN2,false())}<a
                        {if lt($count_children,1)}class="noArrow" {else}class="arrow"{/if} onclick="return false;"
                        title="{$Sub_child.name|wash} - {$Child.name}">{$Sub_child.name|wash}</a>{else}<a
                        href="{$Sub_child.children.0.url_alias|ezurl(no)}" {if lt($count_children,1)}class="noArrow"
                        {else}class="arrow"{/if}
                        title="{$Sub_child.name|wash} - {$Child.name}">{$Sub_child.name|wash}</a>
                {/if}
                {if gt($count_children,0)}
                    <ul>
                    <!-- Niv 3 -->
                    {foreach $sub_sub_children as $Sub_sub_child}
                        {if or(
                            and(is_set($Sub_child.data_map.menu_cb),$Sub_child.data_map.menu_cb.value|eq(1)),
                            $Sub_child.class_identifier|eq('bouygues_categorie') , $Sub_child.class_identifier|eq('link'))}
                            {set $sub_sub_sub_children = fetch( 'content', 'list', hash(
                                'parent_node_id', $Sub_sub_child.node_id,
                                'class_filter_type','include',
                                'class_filter_array', array( 'bouygues_page_sessions','article','bouygues_diapo','bouygues_dossier','bouygues_galerie_vid','bouygues_liste','bouygues_liste_thema','bouygues_mini_site','bougues_video',
                                'bouygues_categorie', 'bouygues_whoswho_search', 'bouygues_whoswho_list', 'link' ),
                                'sort_by', array(array( 'priority' )) ))}
                                {*Ouvrir les enfants ?*}
                            {if is_set($Sub_sub_child.data_map.menu_se_cb)}
                                {if $Sub_sub_child.data_map.menu_se_cb.value|eq(1)}
                                    {set $n3=true()}
                                {else}
                                    {set $n3=false()}
                                {/if}
                            {else}
                                {set $n3=true()}
                            {/if}
                            {if $n3}
                                {set $count_children=0}
                                {foreach $sub_sub_sub_children as $node_children}
                                    {if or($node_children.data_map.menu_cb.value|eq(1), $node_children.class_identifier|eq('bouygues_categorie'))}
                                        {set $count_children=$count_children|inc}
                                    {/if}
                                {/foreach}
                            {else}
                                {set $count_children=0}

                            {/if}
                            {*Gestion des catégories ?*}
                            {set $nolink=false()}
                            {set $linkN2=false()}
                            {if and(is_set($Sub_sub_child.data_map.menu_1se_select),$Sub_sub_child.data_map.menu_1se_select.value.0|eq(1))}
                                {set $nolink=true()}
                            {elseif and(is_set($Sub_sub_child.data_map.menu_1se_select),$Sub_sub_child.data_map.menu_1se_select.value.0|eq(0))}
                                {set $linkN2=true()}
                            {/if}
                            {*Gestion des liens externes ?*}
                            {if $Sub_sub_child.class_identifier|eq('link')}
                                {set $external_link=$Sub_sub_child.data_map.lien.content|ezurl(no)}
                            {else}
                                {set $external_link=false()}
                            {/if}
                    <li{if eq(lt($countMenuItem,6),false())} class="back"{/if}>
                        {if $external_link|eq(false())|not()}<a href="{$external_link}" {if lt($count_children,1)}class="noArrow"
                                                                {else}class="arrow"{/if} target="_blank"
                                                                title="{$Sub_sub_child.name|wash} - {$Child.name}">{$Sub_sub_child.name|wash}</a>
                        {elseif and(eq($nolink, false()),eq($linkN2,false()))}<a
                                href={$Sub_sub_child.url_alias|ezurl} {if lt($count_children,1)}class="noArrow"{else}class="arrow"{/if}
                                title="{$Sub_sub_child.name|wash} - {$Child.name}">{$Sub_sub_child.name|wash}</a>
                        {elseif eq($linkN2,false())}<a {if lt($count_children,1)}class="noArrow" {else}class="arrow"{/if}
                                                       onclick="return false;"
                                                       title="{$Sub_sub_child.name|wash} - {$Child.name}">{$Sub_sub_child.name|wash}</a>
                        {else}<a href="{$Sub_sub_child.children.0.url_alias|ezurl(no)}" {if lt($count_children,1)}class="noArrow"
                                 {else}class="arrow"{/if}
                                 title="{$Sub_sub_child.name|wash} - {$Child.name}">{$Sub_sub_child.name|wash}</a>
                        {/if}
                        {if gt($count_children,0)}
                            <ul>
                            <!-- Niv 4 -->
                            {foreach $sub_sub_sub_children as $sub_sub_sub_child}
                                {if or(
                                and($sub_sub_sub_child.data_map.menu_cb.value|eq(1),$n3),
                                $sub_sub_sub_child.class_identifier|eq('bouygues_categorie'),
                                $Sub_child.class_identifier|eq('link'))}
                                    {set $sub_sub_sub_sub_children = fetch( 'content', 'list',hash( 'parent_node_id', $sub_sub_sub_child.node_id,'class_filter_type','include', 'class_filter_array',
                                        array( 'bouygues_page_sessions','article','bouygues_diapo','bouygues_dossier','bouygues_galerie_vid','bouygues_liste','bouygues_liste_thema','bouygues_mini_site','bougues_video','bouygues_categorie', 'bouygues_whoswho_search', 'bouygues_whoswho_list', 'link' ),
                                        'sort_by', array( array( 'priority' ) )))}
                                    {*Ouvrir les enfants ?*}
                                    {if is_set($sub_sub_sub_child.data_map.menu_se_cb)}
                                        {if $sub_sub_sub_child.data_map.menu_se_cb.value|eq(1)}
                                            {set $n4=true()}
                                        {else}
                                            {set $n4=false()}
                                        {/if}
                                    {else}
                                        {set $n4=true()}
                                    {/if}
                                    {if $n2}
                                        {set $count_children=0}
                                        {foreach $sub_sub_sub_sub_children as $node_children}
                                            {if or($node_children.data_map.menu_cb.value|eq(1), $node_children.class_identifier|eq('bouygues_categorie'))}
                                                {set $count_children=$count_children|inc}
                                            {/if}
                                        {/foreach}
                                    {else}
                                        {set $count_children=0}
                                    {/if}
                                    {*Gestion des catégories ?*}
                                    {set $nolink=false()}
                                    {set $linkN2=false()}
                                    {if and(is_set($sub_sub_sub_child.data_map.menu_1se_select),$sub_sub_sub_child.data_map.menu_1se_select.value.0|eq(1))}
                                        {set $nolink=true()}
                                    {elseif and(is_set($sub_sub_sub_child.data_map.menu_1se_select),$sub_sub_sub_child.data_map.menu_1se_select.value.0|eq(0))}
                                        {set $linkN2=true()}
                                    {/if}
                                    {*Gestion des liens externes ?*}
                                    {if $sub_sub_sub_child.class_identifier|eq('link')}
                                        {set $external_link=$sub_sub_sub_child.data_map.lien.content|ezurl(no)}
                                    {else}
                                        {set $external_link=false()}
                                    {/if}
                                    <li{if eq(lt($countMenuItem,6),false())} class="back"{/if}>{if $external_link|eq(false())|not()}<a
                                        href="{$external_link}" {if lt($count_children,1)}class="noArrow" {else}class="arrow"{/if}
                                        target="_blank"
                                        title="{$sub_sub_sub_child.name|wash} - {$Child.name}">{$sub_sub_sub_child.name|wash}</a>{elseif and(eq($nolink, false()),eq($linkN2,false()))}
                                    <a href={$sub_sub_sub_child.url_alias|ezurl} {if lt($count_children,1)}class="noArrow"{else}class="arrow"{/if}
                                   title="{$sub_sub_sub_child.name|wash} - {$Child.name}">{$sub_sub_sub_child.name|wash}</a>{elseif eq($linkN2,false())}
                                    <a {if lt($count_children,1)}class="noArrow" {else}class="arrow"{/if} onclick="return false;"
                                   title="{$sub_sub_sub_child.name|wash} - {$Child.name}">{$sub_sub_sub_child.name|wash}</a>{else}<a
                                        href="{$sub_sub_sub_child.children.0.url_alias|ezurl(no)}" {if lt($count_children,1)}class="noArrow"
                                        {else}class="arrow"{/if}
                                        title="{$sub_sub_sub_child.name|wash} - {$Child.name}">{$sub_sub_sub_child.name|wash}</a>
                                    {/if}
                                    {if and(gt($count_children,0),$n4)}
                                    <ul>
                                   <!-- Niv 5 -->
                                        {foreach $sub_sub_sub_sub_children as $sub_sub_sub_sub_child}
                                            {if or($sub_sub_sub_sub_child.data_map.menu_cb.value|eq(1),
                                                   $sub_sub_sub_sub_child.class_identifier|eq('bouygues_categorie'),
                                                   $Sub_child.class_identifier|eq('link'))}
                                                {set $sub_sub_sub_sub_sub_children = fetch( 'content', 'list',hash( 'parent_node_id', $sub_sub_sub_sub_child.node_id,'class_filter_type','include', 'class_filter_array',
                                                    array( 'bouygues_page_sessions','article','bouygues_diapo','bouygues_dossier','bouygues_galerie_vid','bouygues_liste','bouygues_liste_thema','bouygues_mini_site','bougues_video','bouygues_categorie', 'bouygues_whoswho_search', 'bouygues_whoswho_list', 'link' ),
                                                    'sort_by', array( array( 'priority' ) )))}
                                                    {*Ouvrir les enfants ?*}
                                                {if is_set($sub_sub_sub_sub_child.data_map.menu_se_cb)}
                                                    {if $sub_sub_sub_sub_child.data_map.menu_se_cb.value|eq(1)}
                                                        {set $n5=true()}
                                                    {else}
                                                        {set $n5=false()}
                                                    {/if}
                                                {else}
                                                    {set $n5=true()}
                                                {/if}
                                                {if $n2}
                                                    {set $count_children=0}
                                                    {foreach $sub_sub_sub_sub_sub_children as $node_children}
                                                        {if or($node_children.data_map.menu_cb.value|eq(1), $node_children.class_identifier|eq('bouygues_categorie'))}
                                                            {set $count_children=$count_children|inc}
                                                        {/if}
                                                    {/foreach}
                                                {else}
                                                    {set $count_children=0}
                                                {/if}
                                                {*Gestion des cat√©gories ?*}
                                                {set $linkN2=false()}
                                                {set $nolink=false()}
                                                {if and(is_set($sub_sub_sub_sub_child.data_map.menu_1se_select),$sub_sub_sub_sub_child.data_map.menu_1se_select.value.0|eq(1))}
                                                    {set $nolink=true()}
                                                {elseif and(is_set($sub_sub_sub_sub_child.data_map.menu_1se_select),$sub_sub_sub_sub_child.data_map.menu_1se_select.value.0|eq(0))}
                                                    {set $linkN2=true()}
                                                {/if}
                                                {*Gestion des liens externes ?*}
                                                {if $sub_sub_sub_sub_child.class_identifier|eq('link')}
                                                    {set $external_link=$sub_sub_sub_sub_child.data_map.lien.content|ezurl(no)}
                                                {else}
                                                    {set $external_link=false()}
                                                {/if}
                                                <li>{if $external_link|eq(false())|not()}<a href="{$external_link}"
                                                                                            {if lt($count_children,1)}class="noArrow"
                                                                                            {else}class="arrow"{/if} target="_blank"
                                                                                            title="{$sub_sub_sub_sub_sub_child.name|wash} - {$Child.name}">{$sub_sub_sub_sub_sub_child.name|wash}</a>{elseif and(eq($nolink, false()),eq($linkN2,false()))}
                                                <a href={$sub_sub_sub_sub_child.url_alias|ezurl} {if lt($count_children,1)}class="noArrow"{else}class="arrow"{/if}
                                                   title="{$sub_sub_sub_sub_sub_child.name|wash} - {$Child.name}">{$sub_sub_sub_sub_child.name|wash}</a>{elseif eq($linkN2,false())}
                                                <a {if lt($count_children,1)}class="noArrow" {else}class="arrow"{/if} onclick="return false;"
                                                   title="{$sub_sub_sub_sub_sub_child.name|wash} - {$Child.name}">{$sub_sub_sub_sub_child.name|wash}</a>{else}
                                                <a href="{$sub_sub_sub_sub_child.children.0.url_alias|ezurl(no)}"
                                                   {if lt($count_children,1)}class="noArrow" {else}class="arrow"{/if}
                                                   title="{$sub_sub_sub_sub_sub_child.name|wash} - {$Child.name}">{$sub_sub_sub_sub_child.name|wash}</a>{/if}{if and(gt($count_children,0),$n5)}
                                                <ul>
                                                    {foreach $sub_sub_sub_sub_sub_children as $sub_sub_sub_sub_sub_child}
                                                        <li><a href={$sub_sub_sub_sub_sub_child.url_alias|ezurl} class="noArrow"
                                                               title="{$sub_sub_sub_sub_sub_child.name|wash} - {$Child.name}">{$sub_sub_sub_sub_sub_child.name|wash}</a>
                                                        </li>
                                                    {/foreach}
                                                </ul>
                                                {/if}
                                            </li>
                                            {/if}
                                        {/foreach}
                                   </ul>
                                   {/if}
                                </li>
                                {/if}
                            {/foreach}
                            </ul>
                        {/if}
                        <!-- Niv 4 -->
                        </li>
                        {/if}
                    {/foreach}
                    <!-- Niv 3 -->
                    </ul>
                {/if}
            </li>
            {/if}
            {/foreach}
        <!-- Niv 2 -->
        </ul>
        {/if}
        </li>
        {set $i = inc($i)}

    {/foreach}
{undef $i}{undef $n2}{undef $count_children}{undef $children}{undef $sub_children}{undef $sub_sub_children}{undef $sub_sub_sub_children}{undef $sub_sub_sub_sub_children}{undef $sub_sub_sub_sub_sub_children}{undef $sub_sub_sub_sub_sub_sub_children}{undef $sub_sub_sub_sub_sub_sub_sub_children}
<!-- Niv 1 -->
</ul>
{/if}
{undef}