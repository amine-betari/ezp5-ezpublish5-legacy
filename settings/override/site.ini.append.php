<?php /* #?ini charset="utf-8"?

[ExtensionSettings]
ActiveExtensions[]=ezfind
#ActiveExtensions[]=ezfinder
ActiveExtensions[]=ezlabel
ActiveExtensions[]=ezmultiupload
ActiveExtensions[]=ezscriptmonitor
ActiveExtensions[]=ezodf
ActiveExtensions[]=ezoe
ActiveExtensions[]=ezie
ActiveExtensions[]=eztika
ActiveExtensions[]=swark
ActiveExtensions[]=ezjscore
#ActiveExtensions[]=cjw_newsletter
ActiveExtensions[]=ezgmaplocation
ActiveExtensions[]=ezstarrating
ActiveExtensions[]=ezflow
ActiveExtensions[]=ezxmlinstaller
ActiveExtensions[]=colas

[SiteSettings]
DefaultAccess=fre
SiteList[]=fre
SiteList[]=eng
SiteList[]=colas_gestion
SiteService=http

[SiteAccessSettings]
CheckValidity=false
ForceVirtualHost=true
RemoveSiteAccessIfDefaultAccess=enabled
AvailableSiteAccessList[]=fre
AvailableSiteAccessList[]=eng
AvailableSiteAccessList[]=colas_gestion
MatchOrder=host;uri
HostMatchMapItems[]=www.colas.ezdev;fre
HostMatchMapItems[]=www.colas.ezdev/en;eng
HostMatchMapItems[]=old.colas.ezdev;fre_old
HostMatchMapItems[]=admin.colas.ezdev;colas_gestion

[DatabaseSettings]
DatabaseImplementation=ezmysqli
Server=127.0.0.1
User=ecolas_ez
Password=oo6xeL1o
Database=ECOLAS_EZ_DEV
Port=
Charset=
Socket=disabled

[FileSettings]
VarDir=var/colas

[MailSettings]
Transport=smtp
TransportServer=mx-gw.infrawan.net
#TransportPort=25
TransportUser=
TransportPassword=
AdminEmail=aschneider@kaliop.com
EmailSender=aschneider@kaliop.com
OutputCharset=utf-8
ContentType=text/html

[ContentSettings]
ViewCaching=disabled

[TemplateSettings]
TemplateCache=enabled
TemplateCompile=enabled
ProcessCaching=disabled
ShowXHTMLCode=disabled

[DebugSettings]
DebugRedirection=disabled

[RegionalSettings]
Locale=fre-FR
TextTranslation=enabled

[SiteAccessRules]
Rules[]=access;disable
Rules[]=module;user/register
Rules[]=module;ezinfo/about

*/ ?>
