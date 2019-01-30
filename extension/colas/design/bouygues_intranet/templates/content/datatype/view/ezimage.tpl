{def $image = $attribute.content[first_set($image_class, 'small')]}
<img src={$image.url|ezroot} alt="{first_set($alt, $link_title, '')}" width="{$image.width}" height="{$image.height}" class="{first_set($css_class, '')}" />
{undef $image}