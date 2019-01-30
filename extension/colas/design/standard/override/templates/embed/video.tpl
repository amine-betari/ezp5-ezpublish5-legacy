{if $object.data_map.file.has_content}
    <video width="100%" controls>
        <source src="{concat('/',$object.data_map.file.content.filepath)}" type="video/mp4">
        Your browser does not support the video tag.
    </video>
{/if}
