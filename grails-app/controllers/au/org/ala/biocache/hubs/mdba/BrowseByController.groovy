/*
 * Copyright (c) 2015 Atlas of Living Australia
 * All Rights Reserved.
 * The contents of this file are subject to the Mozilla Public
 * License Version 1.1 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/MPL/
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 */

package au.org.ala.biocache.hubs.mdba

import org.codehaus.groovy.grails.web.json.JSONArray

/**
 * Custom pages to allow data to be pre-filtered by data "types", such as taxa, regions, etc.
 *
 * @author Nick dos Remedios nick.dosremedios@csiro.au
 */
class BrowseByController {
    def restService
    static defaultAction = "species"

    /**
     * Provide a species thumbnail view based on MDBA iconic species list
     * at http://lists.ala.org.au/speciesListItem/list/dr2660#list
     *
     * @return
     */
    def species() {
        def listUid = grailsApplication.config.specieslist.uid
        [speciesGroupMap: restService.getSpeciesListItemsForUid(listUid)]
    }
}
