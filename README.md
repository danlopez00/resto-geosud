# resto-geosud
resto installation for Geosud

##Verifier les packages

    sudo apt-get install php5-pgsql
    sudo apt-get install openjdk-7-jre
    sudo apt-get install php5-curl


## Lancer UNE FOIS:

    01_install_resto+itag.sh


## A chaque deploiement (i.e. changement config.php, changement Models/RestoModel_SPOT67.php)

    02_deploy_resto.sh


## Ingestion metadata

    03_ingest_metadata.sh

## Installation mapshup

    04_install_mapshup.sh
