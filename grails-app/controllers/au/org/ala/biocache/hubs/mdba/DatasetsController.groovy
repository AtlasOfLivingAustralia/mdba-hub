package au.org.ala.biocache.hubs.mdba

import au.org.ala.biocache.hubs.WebServicesService
import grails.converters.JSON

class DatasetsController {
    WebServicesService webServicesService;

    def list() {}

    def resources(){
        List drs;
        drs = webServicesService.getJsonElements('http://collections.ala.org.au/public/resources.json')
        render text: drs as JSON, contentType: 'application/json'
    }
}
