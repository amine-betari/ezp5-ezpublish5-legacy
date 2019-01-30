{def $img_path_bouygues  = 'extension/bouygues/design/bouygues_intranet/images/'}
{def $host_path = eZDefaultHostname()}
{def $image_host_path = eZDefaultHostname(1)}
{def $sys_path = ezsys('sitedir')}

{def $userData = fetchUserByEmail($address)}
{def $hash = $userData.password_hash}

{def $switchLang = switchLang($address)}
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <meta http-equiv="content-type" content="text/html; charset=windows-1250">
    </head>
    <body style="margin:0; padding:10px 0px; font-family: Arial; background-color: #cee1f4; color: #646464;">
		<table width="610" align="center" border="0" cellpadding="0" cellspacing="0">
    		<tr>
    			<td align="center"><font face="Arial, sans-serif" color="#2576c7" size="1">{"mail_antispam"|i18n("extension/bouygues/ebyidentification")}</font></td>
    		</tr>	
    	</table>

		<table width="610" align="center" bgcolor="#FFFFFF" border="0" cellpadding="0" cellspacing="0">
		
    		<tr>
    			<td><a href="{$host_path}"><img src="{concat($image_host_path, '/', $img_path_bouygues,'emails/header.gif')}" border="0" /></a></td>
    		</tr>
    		<tr>
    			<td>
					<table width="610">
						<tr>
							<td width="213">&nbsp;</td>
							<td>
								<font face="Arial, sans-serif" color="#646464">
									<font size="5"><span style="line-height:20px">{"email_title1"|i18n('design/bouygues/notification')}</span></font>
									<br/>
									<font size="6"><strong style="line-height:32px">{"email_title2"|i18n('design/bouygues/notification')}</strong></font>
								</font>
							</td>
						</tr>
					</table>
				</td>
    		</tr>
    		<tr>
				<td>
					<table cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td width="19" rowspan="3"></td>
							<td><img src="{concat($image_host_path, '/', $img_path_bouygues,'emails/editoTop.gif')}" /></td>
							<td width="19" rowspan="3"></td>
						</tr>
						<tr>
							<td style="border-left:1px solid #efefef;border-right:1px solid #efefef;padding:5px 15px 15px 15px">
								<font face="Arial, sans-serif" size="2" color="#646464" style="font-size:12px;line-height:1.5em;">
{set-block scope=root variable=subject}{"notification"|i18n('design/bouygues/notification')}{/set-block}		

{"email_content1"|i18n('design/bouygues/notification')|nl2br()}<br/><br/>

{section name=Handlers loop=fetch(notification,digest_handlers,hash(date,$date.timestamp,address,$address))}
{include handler=$Handlers:item date=$date address=$address uri=concat( "design:notification/handler/",$Handlers:item.id_string,"/view/digest_plain.tpl")}<br/><br/>
{/section}
{"email_content2"|i18n('design/bouygues/notification')|nl2br()}
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
<td height="82" align="center" width="33%" style="padding-top: 20px;" valign="top">
	<font face="Arial, sans-serif" size="2"><a href="{concat($host_path,'/')|ezurl(no)}" style="font-size: 12px; text-decoration: none; color: #646464">{'email_footer_site'|i18n('design/bouygues/notification')}</a></a></font>
</td>
<td align="center" width="34%" style="padding-top: 20px;" valign="top">
	<font face="Arial, sans-serif" size="2"><a href="{concat($host_path, '/ebyidentification/login/',$hash,'/yournotification/',$address)}" style="font-size: 12px; text-decoration: none; color: #646464">{"email_unsubscribe"|i18n('design/bouygues/notification')}</a></a></font>
</td>
<td align="center" width="33%" style="padding-top: 20px;" valign="top">
	<font face="Arial, sans-serif" size="2"><a href="{concat($host_path , '/static/webmaster')}" style="font-size: 12px; text-decoration: none; color: #646464">{'email_footer_contact'|i18n('design/bouygues/notification')}</a></font>
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