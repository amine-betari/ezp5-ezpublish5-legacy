<Role name="Editor" createRole="true" replacePolicies="true" referenceID="EDITOR_ROLE">
    {include uri="design:xmlinstaller/policy.tpl" module="user" function="login"}
    {include uri="design:xmlinstaller/policy.tpl" module="content" function="read"}
    {include uri="design:xmlinstaller/roles/includes/create_content_roles.tpl"}
    {include uri="design:xmlinstaller/policy.tpl" module="content" function='edit' class=$all_classes_without_visio group='self'}
    {include uri="design:xmlinstaller/policy.tpl" module="content" function='manage_locations' class=$all_classes_without_visio}
    {include uri="design:xmlinstaller/policy.tpl" module="content" function='hide'}
    {include uri="design:xmlinstaller/policy.tpl" module="content" function='remove' class=$all_classes_without_visio}
    {include uri="design:xmlinstaller/policy.tpl" module="content" function='dashboard'}
    {include uri="design:xmlinstaller/policy.tpl" module="content" function='restore'}
    {include uri="design:xmlinstaller/policy.tpl" module="content" function='cleantrash'}
    {include uri="design:xmlinstaller/policy.tpl" module="collaboration" function='*'}
    {include uri="design:xmlinstaller/policy.tpl" module="ezflow" function="edit"}
    {include uri="design:xmlinstaller/policy.tpl" module="ezflow" function="call"}
    {include uri="design:xmlinstaller/policy.tpl" module="ezflow" function="changelayout"}
    {include uri="design:xmlinstaller/policy.tpl" module="ezflow" function="timeline"}
    {include uri="design:xmlinstaller/policy.tpl" module="ezoe" function="*"}
    {include uri="design:xmlinstaller/policy.tpl" module="user" function="*"}
    {include uri="design:xmlinstaller/policy.tpl" module="events" function="*"}
    {include uri="design:xmlinstaller/policy.tpl" module="ezmultiupload" function="*"}
</Role>
