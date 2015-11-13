modules = {
//    application {
//        resource url:'js/application.js'
//    }

    // Define your skin module here - it must 'dependsOn' either bootstrap (ALA version) or bootstrap2 (unmodified) and core

    mdba {
        dependsOn 'bootstrap2', 'hubCore','font-awesome'
        resource url: [dir:'css', file:'Common_fonts.css']
        resource url: [dir:'css', file:'mdba-styles.css']
    }

//    fontawesome {
//        resource url:[dir:'css', file:'font-awesome.css', plugin:'biocache-hubs'], attrs: [ media: 'all' ]
//    }

    browseBy {
        dependsOn 'lazyload'
        resource url: [dir:'css', file:'browseBy.css']
    }

    lazyload {
        dependsOn 'jquery'
        resource url: [dir:'js', file:'jquery.lazyload.js']
    }

    bootstrapSwitch {
        dependsOn 'bootstrap2','jquery'
        resource url: [dir:'css', file:'bootstrap-switch.css']
        resource url: [dir:'js', file:'bootstrap-switch.min.js']
    }

}