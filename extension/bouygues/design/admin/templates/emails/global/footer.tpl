{def 
	$img_path_bouygues  = 'extension/bouygues/design/bouygues_intranet/images/'
	$host_path = eZDefaultHostname()
	$image_host_path = eZDefaultHostname(1)
	$sys_path  = ezsys('sitedir')
}	
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
					<font face="Arial, sans-serif" size="2"><a href="{concat($host_path, $lang, '/')}" style="font-size:12px;text-decoration:none;color:#646464">{'email_footer_site'|i18n('design/bouygues/notification')}</a></font>
				</td>
				<td align="center" width="50%" style="padding-top: 20px;" valign="top">
					<font face="Arial, sans-serif" size="2"><a href="{concat($host_path, $lang, '/static/webmaster')}" style="font-size:12px;text-decoration:none;color:#646464">{'email_footer_contact'|i18n('design/bouygues/notification')}</a></font>
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