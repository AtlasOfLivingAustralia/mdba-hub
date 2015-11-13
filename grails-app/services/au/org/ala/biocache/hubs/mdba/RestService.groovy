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

import grails.plugin.cache.Cacheable
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
}
