// locations to search for config files that get merged into the main config;
// config files can be ConfigSlurper scripts, Java properties files, or classes
// in the classpath in ConfigSlurper format

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

grails.project.groupId = "au.org.ala" // change this to alter the default package name and Maven publishing destination

default_config = "/data/${appName}/config/${appName}-config.properties"
if(!grails.config.locations || !(grails.config.locations instanceof List)) {
    grails.config.locations = []
}
if (new File(default_config).exists()) {
    println "[${appName}] Including default configuration file: " + default_config;
    grails.config.locations.add "file:" + default_config
} else {
    println "[${appName}] No external configuration file defined."
}

println "[${appName}] (*) grails.config.locations = ${grails.config.locations}"
println "default_config = ${default_config}"

/******************************************************************************\
 *  SKINNING
\******************************************************************************/
skin.layout = 'mdba-hub'
skin.orgNameLong = "Murray-Darling Basin Authority"
skin.orgNameShort = "MDBA"
// whether crumb trail should include a home link that is external to this webabpp - ala.baseUrl is used if true
skin.includeBaseUrl = true
skin.headerUrl = "classpath:resources/generic-header.jsp" // can be external URL
skin.footerUrl = "classpath:resources/generic-footer.jsp" // can be external URL
skin.fluidLayout = false // true or false
chartsBgColour = "#FFFFFF"
// 3rd part WMS layer to show on maps
map.overlay.url = "http://spatial.ala.org.au/geoserver/ALA/wms"
map.overlay.name = "Murray-Darling Basin"
map.overlay.layer = "ALA:Objects"
map.overlay.viewparams = "s:6239153" //cl2110
map.overlay.opacity = "0.5"
map.defaultFacetMapColourBy = "grid"
map.densityCountThreshold = 10000

map.overlays = [
        [
                name: "Murray-Darling Basin",
                url: "http://spatial.ala.org.au/geoserver/ALA/wms",
                layer: "ALA:Objects",
                viewparams: "s:6239153",
                opacity: "0.5",
                show:true
        ],[
            name: "Murray-Darling Basin Sustainable Rivers Audit (SRA) Valleys",
            url: "http://spatial.ala.org.au/geoserver/gwc/service/wms",
            layer: "ALA:MDB_SRA_valleys",
            viewparams: "",
            opacity: "0.5"
        ],[
            name: "Murray-Darling Basin Sustainable Rivers Audit (SRA) Zones",
            url: "http://spatial.ala.org.au/geoserver/gwc/service/wms",
            layer: "ALA:MDB_SRA_zones",
            viewparams: "",
            opacity: "0.5"
        ],[
            name: "Murray-Darling Basin Authority Water Quality Zones",
            url: "http://spatial.ala.org.au/geoserver/gwc/service/wms",
            layer: "ALA:MDB_water_quality_zones",
            viewparams: "",
            opacity: "0.5"
        ]
]

// set temporary data hub context  **** remove before compiling to production ***
biocache.url = 'http://biocache.ala.org.au'
biocache.queryContext='cl2110:\"Murray-Darling Basin Boundary\"'
//biocache.groupedFacetsUrl = "file:///data/mdba-hub/config/grouped_facets_mdba.json"
//biocache.queryContext="cl1059:%22DARLING+RIVER%22"
//biocache.queryContext="data_resource_uid:dr2244
bieService.baseUrl = "http://bie.ala.org.au/ws"
mdba.mdbaRegionCode = "cl2110"

mdba.mdbaDataCode = "dr2244"
mdba.mdbaDataHubFilter = "data_hub_uid:dh10"
mdba.wetlandUrl = "h#rt=RAMSAR+wetland+regions"
specieslist.baseUrl = "http://lists.ala.org.au/ws"
specieslist.itemsPath = "/speciesListItems/"
specieslist.uid = "dr2660"
collectory.resources = "http://collections.ala.org.au/public/resources.json"

upload.extensions.blacklist = ['exe','js','php','asp','aspx','com','bat']
webservice.apiKeyHeader='Authorization' // Required for calls to ecodata

/******************************************************************************\
 *  MISC
\******************************************************************************/


// The ACCEPT header will not be used for content negotiation for user agents containing the following strings (defaults to the 4 major rendering engines)
grails.mime.disable.accept.header.userAgents = ['Gecko', 'WebKit', 'Presto', 'Trident']
grails.mime.types = [ // the first one is the default format
    all:           '*/*', // 'all' maps to '*' or the first available format in withFormat
    atom:          'application/atom+xml',
    css:           'text/css',
    csv:           'text/csv',
    form:          'application/x-www-form-urlencoded',
    html:          ['text/html','application/xhtml+xml'],
    js:            'text/javascript',
    json:          ['application/json', 'text/json'],
    multipartForm: 'multipart/form-data',
    rss:           'application/rss+xml',
    text:          'text/plain',
    hal:           ['application/hal+json','application/hal+xml'],
    xml:           ['text/xml', 'application/xml']
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// What URL patterns should be processed by the resources plugin
grails.resources.resourceLocatorEnabled = true
grails.resources.adhoc.patterns = ['/images/*', '/css/*', '/js/*', '/plugins/*', '/fonts/*', '/vendor/*']
grails.resources.adhoc.includes = ['/images/**', '/css/**', '/js/**', '/plugins/**', '/bootstrap/**', '/fonts/**', '/vendor/**']

// Legacy setting for codec used to encode data with ${}
grails.views.default.codec = "html"
//grails.resources.rewrite.css = false // fixes font errors due to css processor trying to process fonts

// The default scope for controllers. May be prototype, session or singleton.
// If unspecified, controllers are prototype scoped.
grails.controllers.defaultScope = 'singleton'

// GSP settings
grails {
    views {
        gsp {
            encoding = 'UTF-8'
            htmlcodec = 'xml' // use xml escaping instead of HTML4 escaping
            codecs {
                expression = 'html' // escapes values inside ${}
                scriptlet = 'html' // escapes output from scriptlets in GSPs
                taglib = 'none' // escapes output from taglibs
                staticparts = 'none' // escapes output from static template parts
            }
        }
        // escapes all not-encoded output at final stage of outputting
        filteringCodecForContentType {
            //'text/html' = 'html'
        }
    }
}
 
grails.converters.encoding = "UTF-8"
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// configure auto-caching of queries by default (if false you can cache individual queries with 'cache: true')
grails.hibernate.cache.queries = false

environments {
    development {
//        grails.serverURL = 'http://dev.ala.org.au:8080/' + appName
//        serverName='http://dev.ala.org.au:8080'
//        security.cas.appServerName = serverName
//        security.cas.contextPath = "/${appName}"
        //grails.resources.debug = true // cache & resources plugins
    }
    test {
//        grails.serverURL = 'http://biocache-test.ala.org.au'
//        serverName='http://biocache-test.ala.org.au'
//        security.cas.appServerName = serverName
        //security.cas.contextPath = "/${appName}"
    }
    production {
//        grails.serverURL = 'http://biocache.ala.org.au'
//        serverName='http://biocache.ala.org.au'
//        security.cas.appServerName = serverName
    }
}

// log4j configuration
log4j = {
    // Example of changing the log pattern for the default console appender:
    //
    appenders {
        environments {
            production {
//                rollingFile name: "tomcatLog", maxFileSize: 102400000, file: "/var/log/tomcat6/${appName}.log", threshold: org.apache.log4j.Level.ERROR, layout: pattern(conversionPattern: "%d %-5p [%c{1}] %m%n")
//                'null' name: "stacktrace"
                console name: "stdout", layout: pattern(conversionPattern: "%d %-5p [%c{1}]  %m%n"), threshold: org.apache.log4j.Level.WARN
            }
            development {
                console name: "stdout", layout: pattern(conversionPattern: "%d %-5p [%c{1}]  %m%n"), threshold: org.apache.log4j.Level.DEBUG
            }
            test {
//                rollingFile name: "tomcatLog", maxFileSize: 102400000, file: "/tmp/${appName}-test.log", threshold: org.apache.log4j.Level.DEBUG, layout: pattern(conversionPattern: "%d %-5p [%c{1}]  %m%n")
//                'null' name: "stacktrace"
                console name: "stdout", layout: pattern(conversionPattern: "%d %-5p [%c{1}]  %m%n"), threshold: org.apache.log4j.Level.INFO
            }
        }
    }

    root {
        info 'stdout'
    }

    error  'org.codehaus.groovy.grails.web.servlet',        // controllers
           'org.codehaus.groovy.grails.web.pages',          // GSP
           'org.codehaus.groovy.grails.web.sitemesh',       // layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping',        // URL mapping
           'org.codehaus.groovy.grails.commons',            // core / classloading
           'org.codehaus.groovy.grails.plugins',            // plugins
           'org.codehaus.groovy.grails.orm.hibernate',      // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate'
    info   'grails.app'
    debug  'grails.app.controllers',
           'grails.app.services',
           //'grails.app.taglib',
           'grails.web.pages',
            //'grails.app',
            'au.org.ala.cas',
            'au.org.ala.biocache.hubs',
            'au.org.ala.biocache.hubs.OccurrenceTagLib'
}