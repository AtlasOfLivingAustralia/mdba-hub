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

import grails.converters.JSON
import grails.plugin.cache.Cacheable
import groovyx.net.http.HTTPBuilder
import org.codehaus.groovy.grails.web.json.JSONArray
import org.codehaus.groovy.grails.web.json.JSONElement
import org.codehaus.groovy.grails.web.json.JSONObject
import org.springframework.web.util.UriUtils

class RestService {
    def grailsApplication, facetsCacheService, webServicesService

    @Cacheable('longTermCache')
    Map getFacetNames(String facet) {
        Map facetNames = facetsCacheService.getFacetNamesFor(facet)
        log.debug "facetNames = ${facetNames}"
        facetNames
    }

    @Cacheable('longTermCache')
    List getSpeciesGroups(Integer minLevel, Integer maxLevel) {
        def groupsWanted = []
        def max = 100
        def dataHubid = UriUtils.encodeQueryParam(grailsApplication.config.biocache.queryContext?:"", "UTF-8")
        def url = "${grailsApplication.config.biocache.baseUrl}/explore/groups?q=${dataHubid}&pageSize=${max}"
        def groups = webServicesService.getJsonElements(url)

        groups.each {
            // e.g. we may only want the level 2 groups, such as Mammals, Fish, Birds, etc
            if (it.level >= minLevel && it.level >= maxLevel && it.count > 0) {
                groupsWanted.add(it)
            }
        }

        groupsWanted
    }

    @Cacheable('longTermCache')
    JSONArray getSpeciesForGroup(String group) {
        def max = 20
        def dataHubid = UriUtils.encodeQueryParam(grailsApplication.config.biocache.queryContext?:"", "UTF-8")
        def url = "${grailsApplication.config.biocache.baseUrl}/explore/group/${group}?q=${dataHubid}&pageSize=${max}"
        log.debug "url = ${url}"
        webServicesService.getJsonElements(url)
    }

    @Cacheable('longTermCache')
    JSONArray getTaxaForNames(List names) {
        Map namesObj = [names: names]
        JSONElement json = webServicesService.postJsonElements((namesObj as JSON).toString())
    }

    @Cacheable('longTermCache')
    JSONArray getIconicSpecies(String uri) {

        JSONArray iconSpeciesJson = webServicesService.getJsonElements(uri)

        iconSpeciesJson.each {
            log.debug "json el = ${it}"
        }
    }

    Map getSpeciesListItemsForUid(String uid) {
        def url = "${grailsApplication.config.specieslist.baseUrl}${grailsApplication.config.specieslist.itemsPath}${uid}?includeKVP=true"
        JSONArray listItems = webServicesService.getJsonElements(url)
        log.debug "listItems = ${listItems}"
        // add BIE derived additional data (common name, image URL)
        List guids = listItems.collect { it.lsid } // List of guids
        // do lookup & populate Map
        Map guidsMap = bulkLookupSpecies(guids)

        Map speciesgroupMap = [:]

        // munge into a Map with "grouping" as keys
        listItems.each { item ->
            def group
            item.kvpValues?.each {
                if (it && it.key == "grouping") {
                    group = it.value
                }
            }

            // create new Map for data
            def itemMap = [:]
            itemMap.scientificName = item.name
            itemMap.guid = item.lsid

            if (guidsMap.containsKey(item.lsid)) {
                List data = guidsMap.get(item.lsid)
                itemMap.commonName = data[1]
                itemMap.imageUrl = data[0]
                itemMap.matcedName = data[3]
            }

            if (group && speciesgroupMap.containsKey(group)) {
                // existing group
                speciesgroupMap.get(group).add(itemMap)
            } else {
                // newgroup
                speciesgroupMap.put(group, [itemMap])
            }
        }

        speciesgroupMap

    }

    /**
     * Taken from specilist-webapp
     *
     * @param list
     * @return
     */
    Map bulkLookupSpecies(list) {

        def http = new HTTPBuilder(grailsApplication.config.bieService.baseUrl + "/species/guids/bulklookup.json")
        http.getClient().getParams().setParameter("http.socket.timeout", new Integer(5000))
        def map = [:]
        def jsonBody = (list as JSON).toString()

        log.debug(jsonBody)
        try {
            def jsonResponse =  http.post(body: jsonBody, requestContentType:groovyx.net.http.ContentType.JSON)
            log.debug "jsonResponse = ${jsonResponse}"
            jsonResponse.searchDTOList.each {
                if (it && it.guid) {
                    def guid = it.guid
                    def image = it.smallImageUrl
                    def commonName = it.commonNameSingle
                    def scientificName = it.name
                    def author = it.author
                    map.put(guid, [image, commonName, scientificName, author])
                }
            }
            log.debug(map)
            map
        } catch(ex) {
            log.error("Unable to obtain species details from BIE - " + ex.getMessage(), ex)
            map
        }
    }
}
