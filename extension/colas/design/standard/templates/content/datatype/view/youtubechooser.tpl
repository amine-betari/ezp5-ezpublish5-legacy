{if $attribute.content.thumb_medium}
    <p class="youtubepreview view_full_link"><a href="https://www.youtube.com/watch?v={$attribute.content.videoId}" target="_blank">{$attribute.content.title}</a></p>
    <a href="https://www.youtube.com/watch?v={$attribute.content.videoId}" target="_blank"><img src="{$attribute.content.thumb_medium}" title="{$attribute.content.title}" /></a>
    {* Lien embarqué - si besoin un jour :p *}
    {*<iframe width="320" height="180" src="https://www.youtube.com/embed/{$attribute.content.videoId}" frameborder="0" allowfullscreen></iframe>*}
{/if}