#/bin/bash

# Paths and password
RESTO_HOME=/data/resto/resto
RESTO_PASSWORD=resto
RESTO_ADMIN_PASSWORD=admin

ITAG_HOME=/data/resto/itag
ITAG_PASSWORD=itag


echo "############ resto ###########"
PWD=`pwd`

echo "Retrieve resto archive from github"
git clone https://github.com/jjrom/resto.git $RESTO_HOME

echo "Modify resto _install/installDB.sh for geosud LOCAL specificity"
cp ${PWD}/install/installDB_resto_modified.sh $RESTO_HOME/_install/installDB.sh

echo "Install resto"
$RESTO_HOME/_install/installDB.sh -F -p $RESTO_PASSWORD

echo "Create admin user"
$RESTO_HOME/_install/createAdminUser.sh -u admin -p ${RESTO_ADMIN_PASSWORD}

echo "############ itag ###########"

echo "Retrieve itag archive from github"
git clone https://github.com/jjrom/resto.itag $ITAG_HOME

echo "Modify itag _install/installDB.sh for geosud LOCAL specificity"
cp ${PWD}/install/installDB_itag_modified.sh $RESTO_HOME/_install/installDB.sh

echo "Install itag"
ITAG_DATA=$ITAG_HOME/data
mkdir $ITAG_DATA
cd $ITAG_DATA
wget http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/physical/ne_10m_coastline.zip
unzip ne_10m_coastline.zip
wget http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_admin_0_countries.zip
unzip ne_10m_admin_0_countries.zip
wget http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_admin_1_states_provinces.zip
unzip ne_10m_admin_1_states_provinces.zip
wget http://download.geonames.org/export/dump/allCountries.zip
wget http://download.geonames.org/export/dump/alternateNames.zip
unzip allCountries.zip
unzip alternateNames.zip
wget http://www.colorado.edu/geography/foote/maps/assign/hotspots/download/hotspots.zip
unzip hotspots.zip
wget http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/physical/ne_10m_glaciated_areas.zip
unzip ne_10m_glaciated_areas.zip
wget http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/physical/ne_10m_rivers_lake_centerlines.zip
unzip ne_10m_rivers_lake_centerlines.zip
wget http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/physical/ne_10m_geography_marine_polys.zip
unzip ne_10m_geography_marine_polys.zip


$ITAG_HOME/_install/installDB.sh -F -p $ITAG_PASSWORD
$ITAG_HOME/_install/installDatasources.sh -F -D $ITAG_DATA
$ITAG_HOME/_install/installGazetteerDB.sh -F -D $ITAG_DATA


