package au.org.ala.biocache.hubs.mdba

import grails.converters.JSON
import org.apache.http.HttpStatus

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

    def showDataResource(){
        String id = params.id?: 'dr4256'
        if(id){
            Map instance = restService.getDataResource(id)
            render view: 'showDataResource', model:[instance: instance]
        } else {
            render status: HttpStatus.SC_NOT_FOUND, text: 'Data provider not found'
        }
    }

    def showInstitution(){
        String id = params.id
        if(id){
            Map instance = restService.getInstitution(id)
            render view: 'showInstitution', model:[instance: instance]
        } else {
            render status: HttpStatus.SC_NOT_FOUND, text: 'Data provider not found'
        }

    }
}
