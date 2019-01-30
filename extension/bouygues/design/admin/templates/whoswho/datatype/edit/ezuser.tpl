{default attribute_base=ContentObjectAttribute}
{*$attribute.content|attribute(show,1)*}


{* User ID. *}
<div class="block">
    <label>{'User ID'|i18n( 'design/standard/content/datatype' )}:</label>
    <p>{$attribute.content.contentobject_id}</p>
</div>

<div class="block">

{* Username. *}
<div class="element">
    <label>{'Username'|i18n( 'design/standard/content/datatype' )}:</label>
    {section show=$attribute.content.has_stored_login}
        <input type="text" name="user_login_stored" size="16" value="{$attribute.content.login}" disabled="disabled" />
        <input type="hidden" name="user_login" value="{$attribute.content.login}" />
    {section-else}
        <input  type="text" name="user_login" size="16" value="{$attribute.content.login}" />
    {/section}
</div>

{* Password #1. *}
<div class="element">
    <label>{'Password'|i18n( 'design/standard/content/datatype' )}:</label>
    <input type="password" name="user_password" size="16" value="{section show=$attribute.content.original_password}{$attribute.content.original_password}{section-else}{section show=$attribute.content.has_stored_login}_ezpassword{/section}{/section}" />
</div>
{* Password #2. *}
<div class="element">
    <label>{'Confirm password'|i18n( 'design/standard/content/datatype' )}:</label>
    <input type="password" name="user_password_confirm" size="16" value="{section show=$attribute.content.original_password_confirm}{$attribute.content.original_password_confirm}{section-else}{section show=$attribute.content.has_stored_login}_ezpassword{/section}{/section}" />
</div>
{* Email. *}
<div class="element">
    <label>{'Email'|i18n( 'design/standard/content/datatype' )}:</label>
    <input type="text" name="user_email" size="28" value="{$attribute.content.email|wash( xhtml )}" />
</div>

<div class="break"></div><div class="break"></div>
</div>

{* Status *}
<div class="block">
<div class="element">
    <label>{'Current account status:'|i18n( 'design/standard/content/datatype' )}
    {section show=$attribute.content.is_enabled}
	<span class="userstatus-enabled">{'enabled'|i18n( 'design/standard/content/datatype' )}</span>
    {section-else}
	<span class="userstatus-disabled"> {'disabled'|i18n( 'design/standard/content/datatype' )}</span>
    {/section}
    </label>
</div>

<div class="break"></div>
</div>

{/default}
