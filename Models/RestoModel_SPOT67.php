<?php

/*
 * Copyright 2014 Jérôme Gasperi
 * 
 * Licensed under the Apache License, version 2.0 (the "License");
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 * 
 *   http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations
 * under the License.
 */

/**
 * Model for SPOT 6-7 metadata from Geosud
 */
class RestoModel_SPOT67 extends RestoModel {

    /**
     * Constructor
     * 
     * @param RestoContext $context : Resto context
     * @param RestoContext $user : Resto user
     */
    public function __construct() {
        parent::__construct();
    }

    /**
     * Add feature to the {collection}.features table following the class model
     * 
     * @param array $data : array (MUST BE GeoJSON in abstract Model)
     * @param string $collectionName : collection name
     */
    public function storeFeature($data, $collectionName) {
        return parent::storeFeature($this->parse(join('', $data)), $collectionName);
    }

    /**
     * Create JSON feature from CSW ISO 19115 metadata
     * 
     * See example in metadata_examples/spot67.xml
     * 
     * @param {String} $xml : $xml string
     */
    private function parse($xml) {

        $dom = new DOMDocument();
        $dom->loadXML(rawurldecode($xml));

        $splittedParentIdentifier = explode('_', $dom->getElementsByTagName('parentIdentifier')->item(0)->getElementsByTagName('CharacterString')->item(0)->nodeValue);

        $westLon = (float) $dom->getElementsByTagName('westBoundLongitude')->item(0)->getElementsByTagName('Decimal')->item(0)->nodeValue;
        $eastLon = (float) $dom->getElementsByTagName('eastBoundLongitude')->item(0)->getElementsByTagName('Decimal')->item(0)->nodeValue;
        $southLat = (float) $dom->getElementsByTagName('southBoundLatitude')->item(0)->getElementsByTagName('Decimal')->item(0)->nodeValue;
        $northLat = (float) $dom->getElementsByTagName('northBoundLatitude')->item(0)->getElementsByTagName('Decimal')->item(0)->nodeValue;

        /*
         * Initialize feature
         */
        $feature = array(
            'type' => 'Feature',
            'geometry' => array(
                'type' => 'Polygon',
                'coordinates' => array(
                    array(
                        array($westLon, $southLat),
                        array($westLon, $northLat),
                        array($eastLon, $northLat),
                        array($eastLon, $southLat),
                        array($westLon, $southLat)   
                    )
                ),
            ),
            'properties' => array(
                'productIdentifier' => $dom->getElementsByTagName('fileIdentifier')->item(0)->getElementsByTagName('CharacterString')->item(0)->nodeValue,
                'title' => $dom->getElementsByTagName('abstract')->item(0)->getElementsByTagName('CharacterString')->item(0)->nodeValue,
                'authority' => $dom->getElementsByTagName('pointOfContact')->item(0)
                                ->getElementsByTagName('CI_ResponsibleParty')->item(0)
                                ->getElementsByTagName('organisationName')->item(0)
                                ->getElementsByTagName('CharacterString')->item(0)->nodeValue,
                'startDate' => $dom->getElementsByTagName('beginPosition')->item(0)->nodeValue,
                'completionDate' => $dom->getElementsByTagName('endPosition')->item(0)->nodeValue,
                'productType' => 'REFLECTANCETOA',
                'processingLevel' => $dom->getElementsByTagName('processingLevelCode')->item(0)
                                ->getElementsByTagName('MD_Identifier')->item(0)
                                ->getElementsByTagName('code')->item(0)
                                ->getElementsByTagName('CharacterString')->item(0)->nodeValue,
                'platform' => $splittedParentIdentifier[0],
                'quicklook' => $dom->getElementsByTagName('MD_BrowseGraphic')->item(0)
                                ->getElementsByTagName('fileName')->item(0)
                                ->getElementsByTagName('FileName')->item(0)->getAttribute('src'),
            )
        );

        return $feature;

    }

}
