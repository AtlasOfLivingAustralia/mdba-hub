package au.org.ala.biocache.hubs.mdba

import grails.converters.JSON

class DatasetsController {
    RestService restService

    def list() {}

    def resources(){
        List drs;
        String source = params.source?:'mdba'
        drs = restService.getDataResources(source)
        render text: drs as JSON, contentType: 'application/json'
    }

    def dataSetSearch (){
        String source = params.source?:'mdba'
        String query = params.q?:''
        List drs = restService.getFilteredDataResources(query, source);
        render drs as JSON
    }
}
