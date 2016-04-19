package au.org.ala.biocache.hubs.mdba

import au.org.ala.web.AlaSecured
import au.org.ala.web.AuthService
import grails.util.GrailsNameUtils

class AdminController {
    SettingService settingService
    AuthService authService

    /**
     * Edit statuc page text
     */
    @AlaSecured(value = ['ROLE_MDBA_ADMIN', 'ROLE_ADMIN'], anyRole = true)
    def editSettingText() {
        String content
        String returnUrl = params.returnUrl ?: g.createLink(controller: 'home', action: 'index', absolute: true)
        String returnAction = returnUrl.tokenize("/")[-1]
        String returnLabel = GrailsNameUtils.getScriptName(returnAction).replaceAll('-', ' ').capitalize()

        SettingPageType type
        for (SettingPageType entry : SettingPageType.values()) {
            if (params.name && entry == params.name.toUpperCase() as SettingPageType) {
                type = entry
            }
        }

        if (type) {
            content = settingService.getSettingText(type)
        } else {
            render(status: 404, text: "No settings type found for: ${params.name}")
            return
        }

        render(view: 'editTextAreaSetting',
                model: [
                textValue   : content,
                returnUrl   : returnUrl,
                returnLabel : returnLabel,
                settingTitle: type.title,
                settingKey  : type.key])
    }

    /**
     * Save static page text
     */
    @AlaSecured(value = ['ROLE_MDBA_ADMIN', 'ROLE_ADMIN'], anyRole = true)
    def saveTextAreaSetting() {
        String text = params.textValue
        String settingKey = params.settingKey
        String returnUrl = params.returnUrl ?: g.createLink(controller: 'home', action: 'indexS', absolute: true)

        if (settingKey) {
            SettingPageType type = SettingPageType.getForKey(settingKey)

            if (type) {
                settingService.setSettingText(type, text)
                flash.message = "Successfully saved."
            } else {
                flash.errorMessage = "Error: Undefined setting key - ${settingKey}"
            }
        }

        redirect(uri: returnUrl)
    }
}
