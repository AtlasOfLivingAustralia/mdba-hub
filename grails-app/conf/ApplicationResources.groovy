modules = {
    // Define your skin module here - it must 'dependsOn' either bootstrap (ALA version) or bootstrap2 (unmodified) and core
    jquery {
        resource url: 'vendor/jquery/jquery-1.8.0.min.js', disposition: 'head'
    }

    mdba {
        dependsOn 'bootstrap2', 'biocacheHubCore','font-awesome', 'bootstrapSwitch', 'jquery'
        resource url: "css/Common_fonts.css"
        resource url: "css/mdba-styles.css"
        resource url: "css/hidden-elements.css"
        resource url: 'css/common.css'
    }

    mdbaCharts {
        dependsOn 'bootstrapToggle', 'bootstrapMultiselect'
        resource url: [dir: "js", file: "Chart.min.js", plugin: "ala-charts-plugin"]
        resource url: [dir: "js", file: "ALAChart.js", plugin: "ala-charts-plugin"]
        resource url: [dir: "css", file: "ALAChart.css", plugin: "ala-charts-plugin"]
        resource url: [dir: "js", file: "slider.js", plugin: "ala-charts-plugin"]
        resource url: [dir: "js", file: "moment.min.js", plugin: "ala-charts-plugin"]
    }

    bootstrap {
        dependsOn 'bootstrap2'
    }

    wmd {
        resource url: 'vendor/wmd/wmd.css'
        resource url: 'vendor/wmd/showdown.js'
        resource url: 'vendor/wmd/wmd.js'
        resource url: 'vendor/wmd/wmd-buttons.png'
        resource url: 'css/wmd-editor.css'
    }


    biocacheHubCore {
        //dependsOn 'bootstrap'
        dependsOn 'jquery'
        resource url: [dir:'css', file:'autocomplete.css', plugin:'biocache-hubs']
        resource url: [dir:'css', file:'base.css', plugin: 'biocache-hubs'],attrs: [ media: 'all' ]
        resource url: [dir:'css', file:'bootstrapAdditions.css', plugin: 'biocache-hubs'],attrs: [ media: 'all' ]
        resource url: [dir:'js', file:'jquery.autocomplete.js', plugin:'biocache-hubs'], disposition: 'head'
        resource url: [dir:'js', file:'html5.js', plugin:'biocache-hubs'], wrapper: { s -> "<!--[if lt IE 9]>$s<![endif]-->" }, disposition: 'head'
    }
    
    jquery_i18n_hubcore {
        resource url: [dir:'js', file:'jquery.i18n.properties-1.0.9.js', plugin:'biocache-hubs']
    }

    browseBy {
        dependsOn 'lazyload'
        resource url: 'css/browseBy.css'
    }

    lazyload {
        dependsOn 'jquery'
        resource url: 'js/jquery.lazyload.js'
    }

    knockout {
        resource url: 'vendor/knockoutjs/3.4.0/knockout-3.4.0.min.js'
        resource url: 'vendor/knockoutjs/knockout.mapping-latest.js'
        resource url: 'js/knockout-extenders.js'
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

        resource url: 'js/document.js'
        resource url: 'css/resources.css'
    }
}