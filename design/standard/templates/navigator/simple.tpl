{* DO NOT EDIT THIS FILE! Use an override template instead. *}
{default page_uri_suffix=false()}
{let item_previous=sub( first_set( $view_parameters.offset, 0), $item_limit) item_next=sum( first_set( $view_parameters.offset, 0 ), $item_limit)}
<div class="pagenavigator">
<p>
	{switch match=$item_previous|lt(0)}
	  {case match=0}
          <span class="previous"><a href={concat($page_uri,$item_previous|gt(0)|choose('',concat('/offset/',$item_previous)),$page_uri_suffix)|ezurl}><span class="text">&laquo;&nbsp;{"Previous"|i18n("design/standard/navigator")}</span></a></span>
	  {/case}
          {case match=1}
	  {/case}
        {/switch}

	{switch match=$item_next|lt($item_count)}
	  {case match=1}
          <span class="next"><a href={concat($page_uri,'/offset/',$item_next,,$page_uri_suffix)|ezurl}><span class="text">{"Next"|i18n("design/standard/navigator")}&nbsp;&raquo;</span></a></span>
          {/case}
	  {case}
          {/case}
        {/switch}
{/let}
{/default}
</p>
<div class="break"></div>
</div>
