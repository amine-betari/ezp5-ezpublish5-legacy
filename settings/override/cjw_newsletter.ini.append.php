<?php /* #?ini charset="utf-8"?

[NewsletterSettings]

# NodeId of container where the system is looking for newsletter systems
RootFolderNodeId=29937

# ContentObjectID of a user with content read Section(User) rights
# Used in the process cronjobs to fetch users in case of general_emailing
AdministratorUser=14

# FullUrl is used in statistizeNewsletter() in cjw_newsletter_mailqueue_process.php cronjobs
# Key(www) represent the front AvailableSiteAccessList argument in override/site.ini.append.php [SiteAccessSettings]
# DO NOT ADD SLASH AT THE END
# Begin URL with http://
FullURL[]
FullURL[fre]=http://www.bouygues.aschneider.ez5.loc

# which is the command to exex php cli scripts
PhpCli=php

# array with all skin names located in design folder
# => design:newsletter/skin/ $skin_name

#AvailableSkinArray[]=default
#AvailableSkinArray[]=defaultwithstats
AvailableSkinArray[]=bouygues


[NewsletterMailSettings]

# smtp, sendmail, file

# newsletter
TransportMethodCronjob=smtp

# test newsletter
TransportMethodPreview=smtp

# subscribe, infomail
TransportMethodDirectly=smtp

# where to store mails send by TransportMethod = file
FileTransportMailDir=var/log/mail

# http://ezcomponents.org/docs/api/latest/introduction_Mail.html#mta-qmail
# HeaderLineEnding
#    auto - try to find correct settings
#           default is LF
#    CRLF - windows - \r\n
#    CR   - mac - \r
#    LF   - UNIX-MACOSX - \n
HeaderLineEnding=auto

# Configuration for SMTP
SmtpTransportServer=mx-gw.infrawan.net
SmtpTransportPort=25
SmtpTransportUser=
SmtpTransportPassword=
# Connection type in SMTP: <empty>(no encryption)|ssl|sslv2|sslv3|tls
SmtpTransportConnectionType=

# settings for mail send out by subscribe, unsubscribe
EmailSender=aschneider@kaliop.com
EmailSenderName=kcjw_dev

# string the subject of all mails is starting with
EmailSubjectPrefix=[Newsletter Test]

# enabled | disabled - if enabled all local images will be include to the mail message
ImageInclude=disabled

[BounceSettings]
# when we should nl user status to bounced?
BounceThresholdValue=3

[DebugSettings]
# Debug=enabled|disabled get more log output e.g. bounce parser
Debug=disabled

[NewsletterUserSettings]

# if disabled nl_user.name is created with default shema
# saluation first_name last_name
# if enabled the tpl design:newsletter/user/name.tpl will be used
UseTplForNameGeneration=disabled

# define which salutaions are available
# mapping of nl_user.salutation (int) to english string
# this string is used for i18n
# SalutationMappingArray[value_{$saluataionid}]={i18n english string}
# i18n( {i18n english string}, 'cjw_newsletter/user/salutation' )
SalutationMappingArray[value_1]=Mr
SalutationMappingArray[value_2]=Ms

*/