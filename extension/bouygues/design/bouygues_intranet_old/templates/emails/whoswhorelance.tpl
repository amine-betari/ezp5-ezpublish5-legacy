{def $img_path_bouygues  = 'extension/bouygues/design/bouygues_intranet/images/'}
{def $host_path = eZDefaultHostname()}
{def $image_host_path = eZDefaultHostname(1)}
{def $sys_path  = ezsys('sitedir')}

{def $userData = fetchUserByEmail($email)}
{def $hash = $userData.password_hash}
{def $currentLocale=fetch( 'content', 'locale' ) $lang=''}
{if $currentLocale.locale_code|eq('eng-US')}{set $lang='/en'}{/if}

{include uri="design:emails/global/header.tpl"}
	
{"email_request_hello"|i18n("design/bouygues/whoswho")} {$first_name} {$last_name},<br/><br/>

{$message|nl2br()}<br/><br/>

<img src="{concat($image_host_path, '/', $img_path_bouygues,'emails/link.png')}" align="absmiddle"/>&nbsp;<a href="{concat($host_path, $lang, '/ebyidentification/login/', $hash, '/yourwhoswhodata/', $email)|ezurl(no)}" style="color: #2576c7; text-decoration: none">{"email_accepted_content4"|i18n("design/bouygues/whoswho")|nl2br()}</a>

    			</font>	
			</td>
		</tr>
		<tr>
			<td><img src="{concat($image_host_path, '/', $img_path_bouygues,'emails/editoBottom.gif')}" /></td>
		</tr>
	</table>
</td>
</tr><tr>
	<td style="padding-top:10px">
		<table width="572" align="center" cellpadding="0" cellspacing="0" background="{concat($image_host_path, '/', $img_path_bouygues,'emails/footerBg.gif')}"> 
			<tr>
				<td height="82" align="center" width="50%" style="padding-top: 20px;" valign="top">
					<font face="Arial, sans-serif" size="2"><a href="{concat($host_path, $lang,'/')|ezurl(no)}" style="font-size: 12px; text-decoration: none; color: #646464">{'email_footer_site'|i18n('design/bouygues/notification')}</a></font>
				</td>
				<td align="center" width="50%" style="padding-top: 20px;" valign="top">
					<font face="Arial, sans-serif" size="2"><a href="{concat($host_path, $lang, '/static/webmaster')|ezurl(no)}" style="font-size: 12px; text-decoration: none; color: #646464">{'email_footer_contact'|i18n('design/bouygues/notification')}</a></font>
				</td>
			</tr>
		</table>
	</td>
</tr>

<tr>
	<td><img src="{concat($image_host_path, '/', $img_path_bouygues,'emails/footer.gif')}" /></td>
</tr>
</table>

</body>
</html>