{* DO NOT EDIT THIS FILE! Use an override template instead. *}
{* eZNewsletter - view newsletter type *}

{def $base_uri=concat( '/newsletter/view_type/', $newsletter_type.id, '/(limit)/', $limitKey, '/(offset)/', $offset )}

<div class="context-block">
{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

<h1 class="context-title">
{'newsletter'|icon( 'normal', 'Newsletter type'|i18n( 'design/eznewsletter/view_newslettertype' ) )} {'Newslettertype: %newsletter_type_name [%newsletter_type_id]'|i18n( 'eznewsletter',, hash( 
    '%newsletter_type_name', $newsletter_type.name,
    '%newsletter_type_id', $newsletter_type.id
) )|wash}</h1>

{* DESIGN: Mainline *}<div class="header-mainline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-ml"><div class="box-mr"><div class="box-content">

<div class="context-attributes">

<div class="block float-break">
<label>{'Name'|i18n( 'design/eznewsletter/view_newslettertype' )}:</label>
{$newsletter_type.name|wash}
</div>

<div class="block float-break">
<label>{'Description'|i18n( 'design/eznewsletter/view_newslettertype' )}:</label>
{$newsletter_type.description|wash}
</div>

<div class="block float-break">
<label>{'Sender address'|i18n( 'design/eznewsletter/view_newslettertype' )}:</label>
{$newsletter_type.sender_address|wash}
</div>

{* Newsletter send date *}
<div class="block float-break">
<label>{'Send date modifier'|i18n( 'design/eznewsletter/view_newslettertype' )}</label>

<div class="date">

<div class="element">
<label>{'Days'|i18n( 'design/eznewsletter/view_newslettertype' )}:</label>
{$newsletter_type.send_date_modifier_list.days}
</div>

<div class="element">
<label>{'Hours'|i18n( 'design/eznewsletter/view_newslettertype' )}:</label>
{$newsletter_type.send_date_modifier_list.hours}
</div>

<div class="element">
<label>{'Minutes'|i18n( 'design/eznewsletter/view_newslettertype' )}:</label>
{$newsletter_type.send_date_modifier_list.minutes}
</div>

</div>

</div>

<div class="block float-break">
<label>{'Default pretext'|i18n( 'design/eznewsletter/view_newslettertype' ) }</label>
{if $newsletter_type.pretext}
    <pre>{$newsletter_type.pretext}</pre>
{else}
    {'There is no default pretext defined.'|i18n( 'design/eznewsletter/view_newslettertype' )}
{/if}
</div>

<div class="block float-break">
<label>{'Default posttext'|i18n( 'design/eznewsletter/view_newslettertype' ) }</label>
{if $newsletter_type.posttext}
    <pre>{$newsletter_type.posttext}</pre>
{else}
    {'There is no default posttext defined.'|i18n( 'design/eznewsletter/view_newslettertype' )}
{/if}
</div>

<div class="block float-break">
<label>{'Default subscription'|i18n( 'design/eznewsletter/view_newslettertype' )}:</label>
    <div class="element"><a href={concat( 'newsletter/subscription_list/', $newsletter_type.default_subscription_list.url_alias )|ezurl }>{$newsletter_type.default_subscription_list.name|wash}</a></div>
</div>

<div class="block float-break">
<label>{'Subscription lists'|i18n( 'design/eznewsletter/view_newslettertype' )}:</label>
{foreach $newsletter_type.subscription_list as $subscriptionList}
    <div class="element"><a href={concat( 'newsletter/subscription_list/', $subscriptionList.subscription_object.url_alias )|ezurl }>{$subscriptionList.subscription_object.name|wash}</a></div>
{/foreach}
</div>

<div class="block float-break">
<label>{'Allowed designs'|i18n( 'design/eznewsletter/view_newslettertype' )}:</label>
<ul>
{foreach $allowed_designs as $design}
<li>{ezini( $design, 'Description', 'newsletterdesigns.ini' )|wash}</li>
{/foreach}
</ul>
</div>

<div class="block float-break">
<label>{'Allowed output formats'|i18n( 'design/eznewsletter/view_newslettertype' )}:</label>
<ul>
{foreach $allowed_output_formats as $output}
<li>{$output_format_names[$output]|wash}</li>
{/foreach}
</ul>
</div>

{*
<div class="block float-break">
<label>{'Related objects'|i18n( 'design/eznewsletter/view_newslettertype' )}:</label>
<div class="element">
1. {cond( $newsletter_type.related_object_id_1, concat( '<a href=', $newsletter_type.related_object_1.main_node.url_alias|ezurl, '>', $newsletter_type.related_object_1.name, '</a>' ),
                                                'No related object specified'|i18n( 'design/eznewsletter/view_newslettertype' ) )}
</div>
<div class="element">
2. {cond( $newsletter_type.related_object_id_2, concat( '<a href=', $newsletter_type.related_object_2.main_node.url_alias|ezurl, '>', $newsletter_type.related_object_2.name, '</a>' ),
                                                'No related object specified'|i18n( 'design/eznewsletter/view_newslettertype' ) )}
</div>
<div class="element">
3. {cond( $newsletter_type.related_object_id_3, concat( '<a href=', $newsletter_type.related_object_3.main_node.url_alias|ezurl, '>', $newsletter_type.related_object_3.name, '</a>' ),
                                                'No related object specified'|i18n( 'design/eznewsletter/view_newslettertype' ) )}
</div>
</div>
*}

<div class="block float-break">
<label>{'Suggestion inbox'|i18n( 'design/eznewsletter/view_newslettertype' )}:</label>
{if $newsletter_type.inbox_id}
    {def $inbox = $newsletter_type.inbox_object}
    <a href={$inbox.main_node.url_alias|ezurl}>{$inbox.name}</a>
{else}
    {'No inbox set'|i18n( 'design/eznewsletter/view_newslettertype' )}
{/if}
</div>

<div class="block float-break">
<label>{'Newsletter placement'|i18n( 'design/eznewsletter/view_newslettertype' )}:</label>
{if $newsletter_type.article_pool_object}
    {def $articlePool = $newsletter_type.article_pool_object}
    <a href={$articlePool.main_node.url_alias|ezurl}>{$articlePool.name}</a>
{else}
    {'No newsletter placement is specified.'|i18n( 'design/eznewsletter/view_newslettertype' )}
{/if}
</div>

</div>

{* DESIGN: Content END *}</div></div></div>

{* Buttons. *}
<div class="controlbar">
{* DESIGN: Control bar START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
<div class="block float-break">
<form method="post" action={concat( '/newsletter/edit_type/', $newsletter_type.id )|ezurl} style="display:inline;float:left;">
<input class="button" type="submit" name="" value="{'Edit'|i18n( 'design/eznewsletter/view_newslettertype' )}" title="{'Edit this newsletter type.'|i18n( 'design/eznewsletter/view_newslettertype' )}" />
</form>

<form name="CreateNewsletter" method="post" action={concat( 'newsletter/view_type/', $newsletter_type.id )|ezurl} style="display:inline;float:right;">
{if $contentclass_list|count|ge(1)}
    {def $contentClasses=fetch( class, list, hash( class_filter, $contentclass_list ) )}

    <select name="ClassID">
    {foreach $contentClasses as $class}
        <option value="{$class.id}" />{$class.name|wash}</option>
    {/foreach}
    </select>

    <input type="hidden" name="RedirectURIAfterPublish" value={concat('/newsletter/view_type/', $newsletter_type.id )} />
    <input type="hidden" name="RedirectIfDiscarded" value={concat('/newsletter/view_type/', $newsletter_type.id )} />
    <input class="button" type="submit" name="CreateNewsletter" value="{"Create newsletter"|i18n( 'design/eznewsletter/view_newslettertype' )}" />
{/if}
</form>

</div>
{* DESIGN: Control bar END *}</div></div></div></div></div></div>
</div>

</div>

<form name="newsletter_list" method="post" action={$base_uri|ezurl}>

<div class="context-block">
{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
<h2 class="context-title">{'Newsletter lists'|i18n( 'design/eznewsletter/view_newslettertype' )}</h2>

{* DESIGN: Mainline *}<div class="header-mainline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-ml"><div class="box-mr"><div class="box-content">

{* Items per page selector. *}
<div class="context-toolbar">
<div class="block float-break">
<div class="left">
<p>
{switch match=$limit}
{case match=25}
<a href={concat( $base_uri, '/(limit)/1' )|ezurl}>10</a>
<span class="current">25</span>
<a href={concat( $base_uri, '/(limit)/3' )|ezurl}>50</a>
{/case}

{case match=50}
<a href={concat( $base_uri, '/(limit)/1' )|ezurl}>10</a>
<a href={concat( $base_uri, '/(limit)/2' )|ezurl}>25</a>
<span class="current">50</span>
{/case}

{case}
<span class="current">10</span>
<a href={concat( $base_uri, '/(limit)/2' )|ezurl}>25</a>
<a href={concat( $base_uri, '/(limit)/3' )|ezurl}>50</a>
{/case}

{/switch}
</p>
</div>
<div class="break"></div>
</div>
</div>

{* Newsletter list table. *}
<table class="list" cellspacing="0">
<tr>
    <th class="tight">{'ID'|i18n('eznewslettert')}</th>
    <th>{'Name'|i18n( 'design/eznewsletter/view_newslettertype' )}</th>
    <th>{'Creator'|i18n( 'design/eznewsletter/view_newslettertype' )}</th>
    <th>{'Created'|i18n( 'design/eznewsletter/view_newslettertype' )}</th>
    <th>{'Status'|i18n( 'design/eznewsletter/view_newslettertype' )}</th>
    <th>{'# sent'|i18n( 'design/eznewsletter/view_newslettertype' )}</th>
    <th>{'# read'|i18n( 'design/eznewsletter/view_newslettertype' )}</th>
    <th>&nbsp;</th>
    <th>&nbsp;</th>
</tr>

{def $newsletters=fetch( newsletter, newsletter_list_by_type, hash( type_id, $newsletter_type.id, offset, $offset, limit, $limit ) ) }
{foreach $newsletters as $newsletter sequence array( bglight, bgdark ) as $seq}
<tr class="{$seq}">
    <td class="number">{$newsletter.id}</td>
    <td>{$newsletter.name|wash}</td>
    <td><a href={$newsletter.creator.contentobject.main_node.url_alias|ezurl}>{$newsletter.creator.contentobject.name|wash}</a></td>
    <td>{$newsletter.created|l10n( shortdatetime )}</td>
    <td>{$newsletter.send_status_name_map[$newsletter.send_status]|wash}</td>
    <td>{$newsletter.send_count}</td>
    <td>{$newsletter.read_count}</td>
    <td><a href="/content/edit/{$newsletter.contentobject_id}/f/fre-FR">Edit</a></td>
    <td>{if $newsletter.send_status|gt(0)}<a href="{concat( '/ebynewsletter/download/', $newsletter.id )}">Download</a>{/if}</td>
    </tr>
{/foreach}
</table>

{* Navigator. *}
<div class="context-toolbar">
{include name=navigator
         uri='design:navigator/google.tpl'
         page_uri=$base_uri
     view_parameters=$view_parameters
         item_count=fetch( newsletter, newsletter_count, hash( type_id, $newsletter_type.id ) )
         item_limit=$limit}
</div>

{* DESIGN: Content END *}</div></div></div>

{* Buttons. *}
<div class="controlbar">
{* DESIGN: Control bar START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
{* DESIGN: Control bar END *}</div></div></div></div></div></div>
</div></div>


</form>
