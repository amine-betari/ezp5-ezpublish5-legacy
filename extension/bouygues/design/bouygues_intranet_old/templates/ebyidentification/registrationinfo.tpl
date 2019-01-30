{let site_url=ezini('SiteSettings','SiteURL')}
{set-block scope=root variable=subject}{'%1 registration info'|i18n('design/standard/user/register',,array($site_url))}{/set-block}
{'Thank you for registering at %siteurl.'|i18n('design/standard/user/register',,hash('%siteurl',$site_url))}

Bonjour {$object.name},

Vous venez de vous inscrire ...



{'Your account information'|i18n('design/standard/user/register')}
{'Username'|i18n('design/standard/user/register')}: {$user.login}
{'Email'|i18n('design/standard/user/register')}: {$user.email}

{*section show=$password}
{'Password'|i18n('design/standard/user/register')}: {$password}
{/section*}


{section show=and( is_set( $hash ), $hash )}

{'Click the following URL to confirm your account'|i18n('design/standard/user/register')}
http://{$hostname}{concat( 'user/activate/', $hash, '/', $object.main_node_id )|ezurl(no)}

{/section}

A très vite sur e.by

{'Link to user information'|i18n('design/standard/user/register')}:
http://{$hostname}{concat('content/view/full/',$object.main_node_id)|ezurl(no)}

{/let}
