package au.org.ala.biocache.hubs.mdba

import au.org.ala.ws.service.WebService


class SettingService {
    def grailsApplication
    WebService webService

    def getSettingText(SettingPageType type) {
        String url = "${grailsApplication.config.ecodata.baseURL}/ws/setting/ajaxGetSettingTextForKey?key=${type.key}"
        def res = webService.get(url)
        return res?.resp?.settingText ?: ""
    }

    def setSettingText(SettingPageType type, String content){
        String url = "${grailsApplication.config.ecodata.baseURL}/ws/setting/ajaxSetSettingText/${type.key}"
        webService.post(url, [settingText: content, key: type.key])
    }
}
