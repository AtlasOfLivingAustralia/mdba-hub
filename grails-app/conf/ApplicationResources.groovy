modules = {
//    application {
//        resource url:'js/application.js'
//    }

    // Define your skin module here - it must 'dependsOn' either bootstrap (ALA version) or bootstrap2 (unmodified) and core

    mdba {
        dependsOn 'bootstrap2', 'biocacheHubCore','font-awesome'
        resource url: [dir:'css', file:'Common_fonts.css']
        resource url: [dir:'css', file:'mdba-styles.css']
        resource url: [dir: 'css', file: 'hidden-elements.css']
    }

    biocacheHubCore {
        //dependsOn 'bootstrap'
        defaultBundle 'core'
        resource url: [dir:'css', file:'autocomplete.css', plugin:'biocache-hubs']
        resource url: [dir:'css', file:'base.css', plugin: 'biocache-hubs'],attrs: [ media: 'all' ]
        resource url: [dir:'css', file:'bootstrapAdditions.css', plugin: 'biocache-hubs'],attrs: [ media: 'all' ]
        resource url: [dir:'js', file:'jquery.autocomplete.js', plugin:'biocache-hubs'], disposition: 'head'
        resource url: [dir:'js', file:'html5.js', plugin:'biocache-hubs'], wrapper: { s -> "<!--[if lt IE 9]>$s<![endif]-->" }, disposition: 'head'
    }

    collectory {
        dependsOn 'jquery', 'jquery_i18n', 'jquery_json', 'jquery_tools', 'jquery_jsonp', 'bootstrap2'
        resource url: 'js/collectory.js'
        resource url: 'css/temp-style.css'
    }

    pagination {
        resource url: 'css/pagination.css'
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


    datasets {
        resource url:'js/datasets.js'
    }

    bbq {
        resource url: [dir: 'js', file: 'jquery.ba-bbq.min.js']
    }

    jquery_json {
        resource url:'js/jquery.json-2.2.min.js'
    }

    rotate {
        resource url:'js/jQueryRotateCompressed.2.1.js'
    }

    jquery_tools {
        resource url: 'js/jquery.tools.min.js'
    }

    jquery_i18n {
        resource url:'js/jquery.i18n.properties-1.0.9.min.js'
    }

    jquery_jsonp {
        resource url: 'js/jquery.jsonp-2.1.4.min.js'
    }
    knockout {
        resource url: [dir:'vendor/knockoutjs/3.4.0/', file:'knockout-3.4.0.min.js']
        resource url: [dir:'vendor/knockoutjs', file:'knockout.mapping-latest.js']
        resource url: [dir:'js', file:'knockout-extenders.js']
    }

    resources {
        dependsOn 'knockout','mdba'


        resource url: '/vendor/jquery-ui/jquery-ui-1.11.2-no-autocomplete.js', disposition: 'head'
        resource url: '/vendor/jquery-ui/themes/smoothness/jquery-ui.css', attrs: [media: 'all'], disposition: 'head'

        resource url: 'vendor/fileupload-9.0.0/jquery.fileupload-ui.css', disposition: 'head'

        resource url: 'vendor/fileupload-9.0.0/load-image.min.js'
        resource url: 'vendor/fileupload-9.0.0/jquery.fileupload.js'
        resource url: 'vendor/fileupload-9.0.0/jquery.fileupload-process.js'
        resource url: 'vendor/fileupload-9.0.0/jquery.fileupload-image.js'
        resource url: 'vendor/fileupload-9.0.0/jquery.fileupload-video.js'
        resource url: 'vendor/fileupload-9.0.0/jquery.fileupload-validate.js'
        resource url: 'vendor/fileupload-9.0.0/jquery.fileupload-audio.js'
        resource url: 'vendor/fileupload-9.0.0/jquery.iframe-transport.js'

        resource url: 'vendor/fileupload-9.0.0/locale.js'
        resource url: 'vendor/fileupload-9.0.0/cors/jquery.xdr-transport.js',
                wrapper: { s -> "<!--[if gte IE 8]>$s<![endif]-->" }

        resource url: 'vendor/jquery.validationEngine/jquery.validationEngine.js'
        resource url: 'vendor/jquery.validationEngine/jquery.validationEngine-en.js'
        resource url: 'vendor/jquery.validationEngine/validationEngine.jquery.css'

        resource url: [dir:'js', file:'document.js']
        resource url: [dir:'css', file:'resources.css']
    }
}