{* define basic fetch statement *}
{def $stmt=hash('parent_node_id', $node.node_id, 'class_filter_type','include',                                                                 'class_filter_array',array('newsletter_category')
                    )
}

{* fetch and set vars for googlebar *}
{let $item_type=ezpreference( 'admin_list_limit' )

    $number_of_items=min( $item_type, 3)|choose( 10,10, 25, 50 )
     $temp_list=fetch('content','tree',$stmt)
     
     $articleListCount=$temp_list|count()
     $articleList=$temp_list|extract($view_parameters.offset,$number_of_items)
}

{def $limit=$number_of_items}
{def $base_uri=concat( $node.path_identification_string, '/(offset)/', $view_parameters.offset )}

<form name="category_list" method="post" action={'/content/action'|ezurl}>
<div class="context-block">
{* DESIGN: Header START *}
<div class="box-header">
    <div class="box-tc">
        <div class="box-ml">
            <div class="box-mr">
                <div class="box-tl">
                    <div class="box-tr">
                        <h1 class="context-title">{'Newsletter categories'|i18n( 'design/eznewsletter_builder/editor_view/article_view' )}</h1>
                        {* DESIGN: Mainline *}
                        <div class="header-mainline"></div>

                        {* DESIGN: Header END *}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

{* DESIGN: Content START *}
<div class="box-ml">
    <div class="box-mr">
        <div class="box-content">
            {* Items per page selector. *}
            <div class="context-toolbar">
                <div class="block">
                    <div class="left">
                        <p>
                        {switch match=$number_of_items}
                        {case match=25}
                            <a href={'/user/preferences/set/admin_list_limit/1'|ezurl}>10</a>
                            <span class="current">25</span>
                            <a href={'/user/preferences/set/admin_list_limit/3'|ezurl}>50</a>
                        {/case}

                        {case match=50}
                            <a href={'/user/preferences/set/admin_list_limit/1'|ezurl}>10</a>
                            <a href={'/user/preferences/set/admin_list_limit/2'|ezurl}>25</a>
                            <span class="current">50</span>
                        {/case}

                        {case}
                            <span class="current">10</span>
                            <a href={'/user/preferences/set/admin_list_limit/2'|ezurl}>25</a>
                            <a href={'/user/preferences/set/admin_list_limit/3'|ezurl}>50</a>
                        {/case}

                        {/switch}
                        </p>
                    </div>
                    <div class="right outof">
                        {'%from - %to out of %total_count'|i18n( 
                            'design/eznewsletter_builder/editor_view/category_list',
                            'Shows the current viewed range and total count of categories in the current view',
                            hash( 
                                '%from', $view_parameters.offset|sum(1),
                                '%to', count($articleList)|sum($view_parameters.offset),
                                '%total_count', $articleListCount 
                                )
                            ) }

                    </div>
                    <div class="break"></div>
                </div>
            </div>
            {* Article list table. *}
            <table class="list" cellspacing="0">
                {* Remove column *}
                <th class="remove tight"><img src={'toggle-button-16x16.gif'|ezimage} alt="{'Invert selection'|i18n( 'design/eznewsletter_builder/editor_view/article_view' )}" title="{'Invert selection'|i18n( 'design/eznewsletter_builder/editor_view/article_view' )}" onclick="ezjs_toggleCheckboxes( document.children, 'DeleteIDArray[]' ); return false;" /></th>        
                <th>{'Category name'|i18n( 'design/eznewsletter_builder/editor_view/article_list' )}</th>
            </tr>
            {foreach $articleList as $category
                     sequence array( bglight, bgdark ) as $seq}
        
            <tr class="{$seq}">
                <td><input name="DeleteIDArray[]" value="{$article.node_id}" title="Use these checkboxes to select items for removal. Click the &quot;Remove selected&quot; button to actually remove the selected items." type="checkbox"></td>
                <td>{$category.name|wash}</td>
            </tr>
            {/foreach}
            </table>

            {* Navigator. *}
            <div class="context-toolbar">
            {include name=navigator
                     uri='design:navigator/google.tpl'
                     page_uri=$node.url_alias
                     item_count=$articleListCount
                     view_parameters=$view_parameters
                     item_limit=$number_of_items}
            </div>

        {* DESIGN: Content END *}
        </div>
    </div>
</div>

{* Buttons. *}
<div class="controlbar">
{* DESIGN: Control bar START *}
<div class="box-bc">
    <div class="box-ml">
        <div class="box-mr">
            <div class="box-tc">
                <div class="box-bl">
                    <div class="box-br">
                        <div class="block">
                            <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
                            <input type="hidden" name="NodeID" value="{$node.node_id}" />
                            <input type="hidden" name="ClassID" value="19" />
                            <input class="button" type="submit" name="NewButton" value="{'New category'|i18n( 'design/eznewsletter_builder/editor_view/article_view' )}" title="{'Create a new category.'|i18n( 'design/eznewsletter_builder/editor_view/article_view' )}" />
    
                            <input class="button" name="RemoveButton" value="Remove selected" title="Remove the selected items from the list above." type="submit">
                        </div>
                    </form>
{* DESIGN: Control bar END *}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
