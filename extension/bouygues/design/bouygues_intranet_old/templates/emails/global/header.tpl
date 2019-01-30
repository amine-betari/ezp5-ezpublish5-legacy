{def 
	$img_path_bouygues  = 'extension/bouygues/design/bouygues_intranet/images/'
	$host_path = eZDefaultHostname()
	$image_host_path = eZDefaultHostname(1)
	$sys_path  = ezsys('sitedir')
}
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
 	   			<td><a href="{concat($host_path, $lang, '/')}"><img src="{concat($image_host_path, '/', $img_path_bouygues,'emails/header.gif')}" border="0" /></a></td>
    		</tr>
    		<tr>
    			<td>
					<table width="610">
						<tr>
							<td width="213">&nbsp;</td>
							<td>
								<font face="Arial, sans-serif" color="#646464">
									<font size="5"><span style="line-height:20px">{$title}</span></font>
									<br/>
									<font size="6"><strong style="line-height:32px">{$subtitle}</strong></font>
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