#/bin/bash

PWD=`pwd`

# Paths and password
RESTO_HOME=/data/resto/resto
RESTO_TARGET=/var/www/resto
RESTO_ADMIN_PASSWORD=admin
RESTO_GEOSUD_URL=resto.teledetection.fr/resto

rm -Rf $RESTO_TARGET
$RESTO_HOME/_install/deploy.sh -s $RESTO_HOME -t $RESTO_TARGET

# Copy models to target
echo "Copy RestoModel_SPOT67.php to ${RESTO_TARGET}/include/resto/Models directory"
cp ${PWD}/Models/RestoModel_SPOT67.php ${RESTO_TARGET}/include/resto/Models/RestoModel_SPOT67.php

echo "Copy config.php to ${RESTO_TARGET}/include/config.php"
cp ${PWD}/config.php ${RESTO_TARGET}/include/config.php

echo "Install collection SPOT67"
curl -X POST -H "Content-Type: application/json" -d @${PWD}/collections/SPOT67.json "http://admin:${RESTO_ADMIN_PASSWORD}@${RESTO_GEOSUD_URL}/collections"
