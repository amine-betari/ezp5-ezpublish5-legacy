#! /bin/bash

echo "Script de migration du site bouygues de 4.1.3 vers 5.3"

#informations base sql
DB_NAME=eby_dev
DB_USER=ez_eby
DB_PASSWORD=QK#F3UXM

cd update/database/mysql/

SQL_UPDATE_SCRIPTS[]='4.2/dbupdate_4.1.3-to-4.2.0.sql' #ok
SQL_UPDATE_SCRIPTS[]='4.3/dbupdate-4.2.0-to-4.3.0.sql' #ok
SQL_UPDATE_SCRIPTS[]='4.3/dbupdate-cluster-4.2.0-to-4.3.0.sql' #ok
SQL_UPDATE_SCRIPTS[]='4.4/dbupdate-4.3.0-to-4.4.0.sql' #ok
SQL_UPDATE_SCRIPTS[]='4.5/dbupdate-4.4.0-to-4.5.0.sql' #ok
SQL_UPDATE_SCRIPTS[]='4.6/dbupdate-4.5.0-to-4.6.0.sql' #ok
SQL_UPDATE_SCRIPTS[]='4.7/dbupdate-4.6.0-to-4.7.0.sql' #ok
SQL_UPDATE_SCRIPTS[]='4.7/dbupdate-cluster-db-4.6.0-to-4.7.0.sql'

for scriptsql in ${SQL_UPDATE_SCRIPTS}
do
	echo "execution du script sql : "$scriptsql
	mysql -u${DB_USER} -p${DB_PASSWORD} -f ${DB_NAME} < $scriptsql
done

echo "maj_base_sql_${DB_NAME}"

cd ../../../

#cd settings/override/
#sed -i "/DatabaseImplementation=ezmysql/a\DatabaseImplementation=ezmysqli" site.ini.append.php
#echo "maj_binary"  | tee -a $LOGFILE



#php bin/php/ezpgenerateautoloads.php --extension

#php update/common/scripts/4.1/correctxmlalign.php -s bouygues_gestion ok

#php update/common/scripts/4.2/fixorphanimages.php -s bouygues_gestion ok

#php update/common/scripts/4.3/updatenodeassignment.php -s bouygues_gestion ok

#php update/common/scripts/4.5/updatesectionidentifier.php -s bouygues_gestion

#php update/common/scripts/4.6/removetrashedimages.php

#Remove window_controls and windows blocks from
# extension/bouygues/settings/siteaccess/bouygues_gestion/override.ini.append.php

# FIN MIGRATION ez 4.7


#########" MIGRATION ez 5.3

cd update/database/mysql/

SQL_UPDATE_SCRIPTS[]='5.0/dbupdate-4.7.0-to-5.0.0.sql'
SQL_UPDATE_SCRIPTS[]='5.1/dbupdate-5.0.0-to-5.1.0.sql'
SQL_UPDATE_SCRIPTS[]='5.2/dbupdate-5.1.0-to-5.2.0.sql'
SQL_UPDATE_SCRIPTS[]='5.2/dbupdate-cluster-5.1.0-to-5.2.0.sql'
SQL_UPDATE_SCRIPTS[]='5.3/dbupdate-5.2.0-to-5.3.0.sql'

# Scripts php

cd ../../../

php update/common/scripts/5.0/deduplicatecontentstategrouplanguage.php -s bouygues_gestion #ok
php update/common/scripts/5.0/restorexmlrelations.php -s bouygues_gestion