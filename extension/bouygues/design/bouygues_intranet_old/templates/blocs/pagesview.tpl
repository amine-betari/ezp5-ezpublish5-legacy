{def $arrCook=cookieget()}{def $pass = true() $filiere='' $lien='' $lien_titre='' $class='default' $arrp='' $parentNode='' $my_node='' $counter=0}	{if is_set($nbpages)|not()}{def $nbpages=10}{/if}{if $arrCook|count|gt(0)}{foreach $arrCook as $urlItem}{if $urlItem|eq('')|not()}
			{if $counter|lt($nbpages)}
				{set $filiere = ''}
				{set $class = 'default'}
				{if $urlItem|begins_with('/design/' )}
    				{set $pass = false()}
    			{elseif $urlItem|contains('/ebyperso/' )}	
    				{set $filiere = 'pageviews_ebyperso'|i18n('design/bouygues/tools')}
    				{set $lien = $urlItem}
    				{set $lien_titre = 'Home'}
    				{set $class = 'ebyperso'}
    			{elseif or($urlItem|contains('/user/' ), $urlItem|contains('/profile/' ), $urlItem|contains('/ebyidentification/' ))}	
    				{set $filiere = 'pageviews_profil'|i18n('design/bouygues/tools')}
    				{set $lien = $urlItem}
					{set $class = 'default'}
					{if $urlItem|contains('/ebyidentification/update')}{set $lien_titre = 'menu_left_profile'|i18n('design/bouygues/tools')}
					{elseif $urlItem|contains('/user/forgotpassword')}{set $lien_titre = 'pageviews_forgot'|i18n('design/bouygues/tools')}
					{elseif $urlItem|contains('/profile/yourwhoswhodata')}{set $lien_titre = 'menu_left_whoswhodata'|i18n('design/bouygues/tools')}
					{elseif $urlItem|contains('/profile/yourwhoswho')}{set $lien_titre = 'menu_left_whoswho'|i18n('design/bouygues/tools')}
					{elseif $urlItem|contains('/profile/yournewsletter')}{set $lien_titre = 'menu_left_newsletter'|i18n('design/bouygues/tools')}
					{elseif $urlItem|contains('/profile/yournotification')}{set $lien_titre = 'menu_left_notification'|i18n('design/bouygues/tools')}
					{elseif or($urlItem|contains('/ebyidentification/inscription'),
								$urlItem|contains('/ebyidentification/password'),
								$urlItem|contains('/user/success'),
								$urlItem|contains('/user/activate'))}{set $lien_titre = 'pageviews_subscription'|i18n('design/bouygues/tools')}
					{elseif $urlItem|contains('/profile/yournotification')}{set $lien_titre = 'menu_left_notification'|i18n('design/bouygues/tools')}
					{elseif $urlItem|contains('/profile/yournotification')}{set $lien_titre = 'menu_left_notification'|i18n('design/bouygues/tools')}
					{/if}
    				
    			{elseif or($urlItem|begins_with('/recherche' ),$urlItem|begins_with('/en/recherche' ), $urlItem|begins_with('/annuaire' ), $urlItem|begins_with('/en/annuaire' ))}	
	    				{set $filiere = 'pageviews_tools'|i18n('design/bouygues/tools')}
	    				{set $lien = $urlItem}
						{set $class = 'default'}
						{if $urlItem|contains('/recherche')}{set $lien_titre = 'pageviews_recherche'|i18n('design/bouygues/tools')}
						{elseif $urlItem|contains('/annuaire')}{set $lien_titre = 'pageviews_annuaire'|i18n('design/bouygues/tools')}
						{/if}
				{elseif or($urlItem|begins_with('/static'), $urlItem|begins_with('/en/static'))}

						{set $filiere = 'static'|i18n('design/bouygues/tools')}
						{set $lien = $urlItem}
						{set $class = 'default'}
				
						{if $urlItem|contains('/actu-history')}{set $lien_titre = 'footer_actu'|i18n('design/bouygues/tools')}
						{elseif $urlItem|contains('/group')}{set $lien_titre = 'footer_group'|i18n('design/bouygues/tools')}
						{elseif $urlItem|contains('/ebyperso')}{set $lien_titre = 'footer_ebyperso'|i18n('design/bouygues/tools')}
						{elseif $urlItem|contains('/about')}{set $lien_titre = 'footer_about_eby'|i18n('design/bouygues/tools')}
						{elseif $urlItem|contains('/sitemap')}{set $lien_titre = 'footer_sitemap'|i18n('design/bouygues/tools')}
						{elseif $urlItem|contains('/rss')}{set $lien_titre = 'footer_rss'|i18n('design/bouygues/tools')}
						{elseif $urlItem|contains('/webmaster')}{set $lien_titre = 'footer_contact'|i18n('design/bouygues/tools')}
						{elseif $urlItem|contains('/legals')}{set $lien_titre = 'footer_mention'|i18n('design/bouygues/tools')}
						{/if}
    			{/if}
				{if $pass}
					{if $filiere|eq('')}
        		
						{set $arrp = $urlItem|explode( '/' )}

						{set $lien = $urlItem}
						{if $arrp[1]|eq('en')|not()}
							{set $class = $arrp[1]}
							{set $parentNode=fetch( 'content', 'node', hash( 'node_path', $arrp[1] ) )}
						{else}
							{set $class = $arrp[2]}
							{set $parentNode=fetch( 'content', 'node', hash( 'node_path', $arrp[2] ) )}
							{set $urlItem=$urlItem|extract(3,count($urlItem))}
						{/if}
						{if $parentNode}
							{set $filiere = $parentNode.name}
						{/if}
						
						{def $finalUrl='/' $countItem=0}
						{foreach $arrp as $nodeCurrent}
							{if and($countItem|eq(0), $nodeCurrent|eq('en'))}{set $countItem=1}{/if}
							{if $nodeCurrent|begins_with('(')}{break}{/if}
							{set $finalUrl=concat($finalUrl, $nodeCurrent, '/')}
						{/foreach}
						{set $my_node=fetch( 'content', 'node', hash( 'node_path', $finalUrl ) )}
						{if $my_node}
    						{set $lien_titre = $my_node.name}
						{/if}		
					{/if}
					<div class="pv-item">
						<span class="rub">{$filiere|wash}</span> / <a href="{$lien}" class="color2-{$class}">{$lien_titre|wash}</a><br />
					</div>
					{set $cpt=$cpt|inc}
					{if $cpt|ge($nbpages)}
						{break}
					{/if}
				{/if}
			{/if}
			{set $counter=inc($counter)}
		{/if}
		{set $pass = true()}
		{set $filiere = ''}
		
	{/foreach}
	{else}
		&nbsp;
	{/if}
	
	{undef}