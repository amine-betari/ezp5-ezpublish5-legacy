<Role name="Editor Media" createRole="true" replacePolicies="true" referenceID="EDITOR_MEDIA_ROLE">
    {include uri="design:xmlinstaller/roles/includes/create_media_roles.tpl"}
    {include uri="design:xmlinstaller/policy.tpl" module="content" function='edit' subtree=array(43)}
    {include uri="design:xmlinstaller/policy.tpl" module="content" function='manage_locations' subtree=array(43)}
    {include uri="design:xmlinstaller/policy.tpl" module="content" function='hide' subtree=array(43)}
    {include uri="design:xmlinstaller/policy.tpl" module="content" function='remove' subtree=array(43)}
</Role>