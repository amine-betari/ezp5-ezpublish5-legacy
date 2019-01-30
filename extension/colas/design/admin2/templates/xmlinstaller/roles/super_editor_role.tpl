<Role name="Super Editor" createRole="true" replacePolicies="true" referenceID="SUPER_EDITOR_ROLE">
    {include uri="design:xmlinstaller/policy.tpl" module="content" function="create" parent_class=array("folder") class=array("ecolas_visionneuse_home")}
    {include uri="design:xmlinstaller/policy.tpl" module="content" function='edit' class=array("ecolas_visionneuse_home")}
    {include uri="design:xmlinstaller/policy.tpl" module="content" function='manage_locations' class=array("ecolas_visionneuse_home")}
    {include uri="design:xmlinstaller/policy.tpl" module="content" function='remove' class=array("ecolas_visionneuse_home")}
</Role>
