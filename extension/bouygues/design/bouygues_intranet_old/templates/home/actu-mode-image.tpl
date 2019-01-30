<div class="mode-image">
	<div class="middle" id="carousel-actu{if is_set($groupe)}-groupe{/if}">
		<div class="carousel-actu mycarousel global">
			<div class="carousel mycarousel container">
			{def $actus=$array}
			{def $filiere=''}
			
			{foreach $actus as $data}	

					{*def $data = fetch( 'content', 'node', hash('node_id', $actu.node_id ) )*}
			
			
					{if $data.class_identifier|eq('file')}
								{def $url=concat('content/download/',
								$data.data_map.file.contentobject_id, '/',
								$data.data_map.file.id,'/version/',
								$data.data_map.file.version , '/file/',
								$data.data_map.file.content.original_filename|urlencode)|ezurl(no)}
							{elseif $data.class_identifier|eq('link')}
								{def $url=$data.data_map.lien.content|ezurl(no)}
								{def $urlTitle=$data.data_map.lien.data_text}
								{def $urlTarget='_blank'}
							{elseif or($data.class_identifier|eq('bouygues_element_liste'),
										   $data.class_identifier|eq('bouygues_element_mea'))}
								{if $data.data_map.lien_eby.has_content}
									{def $url=$data.data_map.lien_eby.value.main_node.url_alias|ezurl(no)}
								{elseif $data.data_map.lien_ext.has_content}
									{def $url=$data.data_map.lien_ext.content|ezurl(no)}
									{def $urlTitle=$data.data_map.lien_ext.data_text}
									{def $urlTarget='_blank'}
								{else}
									{def $url = ''}
								{/if}
							{else}
								{def $url=$data.url_alias|ezurl(no)}
							{/if}
			
			
			{if and(is_set($groupe),or($actus|count|eq(1),$actus|count|eq(2)))}
				<div class="{if $actus|count|eq(1)}one-item{elseif $actus|count|eq(2)}two-item{/if}">
					
					{if $actus|count|eq(2)}
						{if $url|eq('')|not()}<a  title="{$data.name}" href="{$url}"class="arrow" {if is_set($urlTarget)}target="{$urlTarget}"{/if}></a>{/if}
					{/if}
						
					
						<div class="image">
							{if $url|eq('')|not()}<a href="{$url}" title="{$data.name}" {if is_set($urlTarget)}target="{$urlTarget}"{/if}>{/if}
							

							{if $data.data_map.image_vignette.has_content}	
								{if $actus|count|eq(1)}
									{def $url_image = $data.data_map.image_vignette.content.home_pageactu_one.url|ezurl(no)}
								{elseif $actus|count|eq(2)}
									{def $url_image = $data.data_map.image_vignette.content.home_pageactu_two.url|ezurl(no)}
								{/if}
							{elseif $data.data_map.image_main.has_content}	
								{if $actus|count|eq(1)}
									{def $url_image = $data.data_map.image_main.content.home_pageactu_one.url|ezurl(no)}
								{elseif $actus|count|eq(2)}
									{def $url_image = $data.data_map.image_main.content.home_pageactu_two.url|ezurl(no)}
								{/if}
							{elseif $data.data_map.image.has_content}	
								{if $actus|count|eq(1)}
									{def $url_image = $data.data_map.image.content.home_pageactu_one.url|ezurl(no)}
								{elseif $actus|count|eq(2)}
									{def $url_image = $data.data_map.image.content.home_pageactu_two.url|ezurl(no)}
								{/if}
							{elseif and($data.class_identifier|eq('bouygues_element_liste'),$data.data_map.lien_eby.content.data_map.image_vignette.has_content)}
								{if $actus|count|eq(1)}
									{def $url_image = $data.data_map.lien_eby.content.data_map.image_vignette.content.home_pageactu_one.url|ezurl(no)}
								{elseif $actus|count|eq(2)}
									{def $url_image = $data.data_map.lien_eby.content.data_map.image_vignette.content.home_pageactu_two.url|ezurl(no)}
								{/if}
							{else}
								{if $actus|count|eq(1)}
									{def $url_image = concat("images/","actus/",$arrCssSubStructure[$data.object.section_id],'-group1.png')|ezdesign(no)}
								{elseif $actus|count|eq(2)}
									{def $url_image = concat("images/","actus/",$arrCssSubStructure[$data.object.section_id],'.png')|ezdesign(no)}
								{/if}
								
							{/if}
							
								<img src="{$url_image}" align="left" alt="{$data.name}" title="{$data.name}" border="0"/><br />
								
							{if $url|eq('')|not()}</a>{/if}
						</div>
					
					
					{if $actus|count|eq(1)}
						<div class="text">
					{/if}
					
					{if and(is_set($data.data_map.date_pub),and(is_set($data.data_map.date_pub_cb),$data.data_map.date_pub_cb.content|eq(1)))}
						<span class="date">{$data.data_map.date_pub.data_int|datetime( 'custom', '%d/%m/%Y' )}</span>
					{else}
						<span class="date">{$data.object.current.modified|datetime( 'custom', '%d/%m/%Y' )}</span>
					{/if}
						
						{if $url|eq('')|not()}
						<a href="{$url}"  title="{$data.name}" {if is_set($urlTarget)}target="{$urlTarget}"{/if}>
							{$data.name}
						</a>
						
						{else}
							<span class="color2-{$arrCssSubStructure[$data.object.section_id]}"> {$data.name} </span>
						{/if}
						
					
						
					{if $actus|count|eq(2)}
						<div class="text">
					{/if}	
							{if $data.data_map.accroche_liste.has_content}
								<p>{$data.data_map.accroche_liste.content.output.output_text|strip_tags()|shorten(230,'...')}</p>
							{elseif $data.data_map.intro.has_content }
								<p>{$data.data_map.intro.content.output.output_text|strip_tags()|shorten(230,'...')}</p>
							{elseif $data.data_map.chapeau.has_content }
								<p>{$data.data_map.chapeau.content.output.output_text|strip_tags()|shorten(230,'...')}</p>
							{elseif $data.data_map.body.has_content }
								<p>{$data.data_map.body.content.output.output_text|strip_tags()|shorten(230,'...')}</p>
							{elseif $child.class_identifier|eq('bouygues_element_liste')}
								{if $child.data_map.lien_eby.content.data_map.accroche_liste.has_content}
									<p>{$child.data_map.lien_eby.content.data_map.accroche_liste.content.output.output_text}</p>
								{elseif $child.data_map.lien_eby.content.data_map.intro.has_content}
									<p>{$child.data_map.lien_eby.content.data_map.intro.content.output.output_text|strip_tags()|shorten(300,'...')}</p>
								{elseif $child.data_map.lien_eby.content.data_map.chapeau.has_content}
									<p>{$child.data_map.lien_eby.content.data_map.chapeau.content.output.output_text|strip_tags()|shorten(300,'...')}</p>
								{elseif $child.data_map.lien_eby.content.data_map.description.has_content}
									<p>{$child.data_map.lien_eby.content.data_map.description.content.output.output_text|strip_tags()|shorten(300,'...')}</p>
								{elseif $child.data_map.lien_eby.content.data_map.body.has_content}
									<p>{$child.data_map.lien_eby.content.data_map.body.content.output.output_text|strip_tags()|shorten(300,'...')}</p>
								{/if}
							{/if}
						</div>

				</div>
			{else}
				{set $filiere=fetch('content', 'tree', hash('parent_node_id', 2, 
									'class_filter_type', 'include',
									'class_filter_array', array('bouygues_master_page'),
									'depth', 1,
									'limit', 1,
									'offset', 0,
									'attribute_filter', array(array('section', '=', $data.object.section_id))))}

				<div class="overview item" >
					<span class="title">
					<img src="{concat("breadcrumb/",$arrCssSubStructure[$data.object.section_id],"/start_hard.gif")|ezimage(no)}" alt="" /> 
					<strong class="color3-{$arrCssSubStructure[$data.object.section_id]}">{$filiere.0.object.name}</strong>
					</span>
					<br />
					
					<div class="image">
						{if $url|eq('')|not()}<a href="{$url}" title="{$data.name}" {if is_set($urlTarget)}target="{$urlTarget}"{/if}>{/if}
						
						{if and(is_set($data.data_map.image_vignette),$data.data_map.image_vignette.has_content)}
							<img src="{$data.data_map.image_vignette.content.home_pageactu.url|ezurl(no)}" alt="{$data.name}" title="{$data.name}" border="0"/><br />
						{elseif and(is_set($data.data_map.image_main),$data.data_map.image_main.has_content)}
							<img src="{$data.data_map.image_main.content.home_pageactu.url|ezurl(no)}" alt="{$data.name}" title="{$data.name}" border="0"/><br />
						{elseif and(is_set($data.data_map.image),$data.data_map.image.has_content)}
							<img src="{$data.data_map.image.content.home_pageactu.url|ezurl(no)}" alt="{$data.name}" title="{$data.name}" border="0"/><br />
						{elseif and($data.class_identifier|eq('bouygues_element_liste'),$data.data_map.lien_eby.content.data_map.image_vignette.has_content)}
							<img src="{$data.data_map.lien_eby.content.data_map.image_vignette.content.home_pageactu.url|ezurl(no)}" alt="{$data.name}" title="{$data.name}" border="0"/><br />
						{else}
							<img src="{concat("images/","actus/",$arrCssSubStructure[$data.object.section_id],'-group2.png')|ezdesign(no)}" alt="{$data.name}" title="{$data.name}" border="0"/><br />
						{/if}
						
						{if $url|eq('')|not()}</a>{/if}
					</div>
					
					{if and(is_set($data.data_map.date_pub),and(is_set($data.data_map.date_pub_cb),$data.data_map.date_pub_cb.content|eq(1)))}
						<span class="date">{$data.data_map.date_pub.data_int|datetime( 'custom', '%d/%m/%Y' )}</span><br />
					{else}
						<span class="date">{$data.object.current.modified|datetime( 'custom', '%d/%m/%Y' )}</span><br />
					{/if}
					
					{if $url|eq('')|not()}<a href="{$url}" class="btn-grey-small-arrow-right" title="{$data.name}" {if is_set($urlTarget)}target="{$urlTarget}"{/if}>{/if}{$data.name|shorten(40,'...')}{if $url|eq('')|not()}</a>{/if}
				</div>
			{/if}
			{undef $data $url $urlTarget}
			
			{set $count_actus=$count_actus|inc($count_actus)}
					
			{/foreach}
			</div>
		</div>
	</div>
</div>	

{undef $filiere}