<?php /* #?ini charset="utf-8"?

[AccessLogFileSettings]
# Storage of the log file, for example /var/log/httpd
# Do not add trailing slash
StorageDir=/home/site/logs
# The name of log file, for example mytest.log
LogFileName=dynamic-access.log
# If using site match by URL, the site may like http://siteurl/mysite and
# apache log will start with for example mysite/content/view/full/node_id. To
# remove this prefix in apache log before analysis the log, add mysite to
# SitePrefix. Example: SitePrefix[]=mysite
SitePrefix[]=fr
SitePrefix[]=en

*/