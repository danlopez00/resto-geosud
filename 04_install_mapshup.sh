#/bin/bash

PWD=`pwd`
MAPSHUP_SRC=/data/resto/mapshup
MAPSHUP_TARGET=/var/www/html/mapshup

git clone https://github.com/jjrom/mapshup.git

cd $MAPSHUP_SRC
$MAPSHUP_SRC/build.sh -t $MAPSHUP_TARGET -c $MAPSHUP_SRC/client/js/mapshup/config/example.js
cd $PWD
cp ${PWD}/config_mapshup/config.php ${MAPSHUP_TARGET}/s/config.php
cp ${PWD}/config_mapshup/example.js ${MAPSHUP_TARGET}/js/mapshup/config/example.js

mkdir /data/resto/_logs
chmod 1777 /data/resto/_logs
