#/bin/bash

PWD=`pwd`

# Paths and password
RESTO_HOME=/data/resto/resto
RESTO_TARGET=/var/www/resto
RESTO_ADMIN_PASSWORD=admin
RESTO_GEOSUD_URL=resto.teledetection.fr/resto
METADATA_DIRECTORY=/var/www/html/md_test/csw-geosud/


for filename in ${METADATA_DIRECTORY}/*.xml; do
    echo "POST ${filename}"
    curl -X POST -H "Content-Type: application/json" -d @${filename} "http://admin:${RESTO_ADMIN_PASSWORD}@${RESTO_GEOSUD_URL}/collections/SPOT67"
done
