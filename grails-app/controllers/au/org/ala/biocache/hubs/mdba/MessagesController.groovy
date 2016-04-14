package au.org.ala.biocache.hubs.mdba

class MessagesController {

    def messageSources // ExtendedPluginAwareResourceBundleMessageSource

    static defaultAction = "i18n"

    /**
     * Export raw i18n message properties as TEXT for use by JavaScript i18n library
     *
     * @param id - messageSource file name
     * @return
     */
    def i18n(String id) {
        Locale locale = org.springframework.web.servlet.support.RequestContextUtils.getLocale(request)

        //println "User locale: " + locale.toString()
        //println "Browser locale: " + request.locale

        //if(id == 'messages.properties') {
        if (id && !id.startsWith("messages_")) {
            // Assume standard messageSource file name pattern:
            // messages.properties, messages_en.properties, messages_en_US.properties
            // String locale_suffix = id.replaceFirst(/messages_(.*)/,'$1')
            //    List locBits = id?.tokenize('_')
            //    locale = new Locale(locBits[1], locBits[2]?:'')
            //    println "id = ${id} || locale = ${locale} || locBits = ${locBits}"
            //}

            Map props = messageSources.listMessageCodes(locale?:request.locale)
            //log.debug "props = ${props}"

            //Alan modified it for outstream utf-8 on 16/08/2014 --- START
            //response.setHeader("Content-type", "text/plain")
            response.setHeader("Content-type", "text/plain; charset=UTF-8")
            //Alan modified it --- END

            def messages = props.collect{ "${it.key}=${it.value}" }

            render ( text: messages.sort().join("\n") )
        } else {
            render (text: '')
        }
    }}
