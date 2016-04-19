package au.org.ala.biocache.hubs.mdba

/**
 * Enum class for static content
 *
 * Created by sat01a on 18/04/16.
 */
enum SettingPageType {
    ABOUT ("mdbaAbout", "About", "mdba.about.text"),
    CONTACT ("mdbaContact", "Contact", "mdba.contact.text"),
    DISCLAIMER ("mdbaDisclaimer", "Disclaimer", "mdba.disclaimer.text"),
    ACCESSIBILITY ("mdbaAccessibility", "Accessibility", "mdba.accessibility.text")
    String name
    String title
    String key

    public SettingPageType(name, title, key) {
        this.name = name
        this.title = title
        this.key = key
    }

    public static SettingPageType getForName(String name) {
        for(SettingPageType s : values()){
            if (s.name == name){
                return s
            }
        }
    }

    public static SettingPageType getForKey(String key) {
        for(SettingPageType s : values()){
            if (s.key == key){
                return s
            }
        }
    }
}
