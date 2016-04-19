package au.org.ala.biocache.hubs.mdba

class MDBATagLib {

    static namespace = "mdba"
    SettingService settingService

    /**
     * Output HTML content for the requested SettingPageType
     *
     * @attr settingType REQUIRED
     */
    def getSettingContent = { attrs ->
        SettingPageType settingType = attrs.settingType
        String content = settingService.getSettingText(settingType) as String
        if (content) {
            out << content.markdownToHtml()
        }
    }
}
