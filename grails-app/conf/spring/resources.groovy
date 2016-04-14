import au.org.ala.biocache.hubs.mdba.ExtendedPluginAwareResourceBundleMessageSource

// Place your Spring DSL code here
beans = {
    // Custom message source
    messageSources(ExtendedPluginAwareResourceBundleMessageSource) {
        basenames = ["WEB-INF/grails-app/i18n/messages"] as String[]
        cacheSeconds = (60 * 60 * 6) // 6 hours
        useCodeAsDefaultMessage = false
    }
}
