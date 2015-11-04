modules = {
//    application {
//        resource url:'js/application.js'
//    }

    // Define your skin module here - it must 'dependsOn' either bootstrap (ALA version) or bootstrap2 (unmodified) and core

    mdba {
        dependsOn 'bootstrap2', 'hubCore'
        resource url: [dir:'css', file:'Common_fonts.css']
        resource url: [dir:'css', file:'mdba-styles.css']
    }

    fontawesome {
        resource url:[dir:'css/font-awesome-4.1.0/css', file:'font-awesome.min.css', plugin:'biocache-hubs'], attrs: [ media: 'all' ]
    }

}