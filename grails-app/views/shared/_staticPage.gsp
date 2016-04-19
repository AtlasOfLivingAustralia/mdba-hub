<auth:ifAnyGranted roles="ROLE_ADMIN,ROLE_MDBA_ADMIN">
    <g:render template="/shared/flashScopeMessage"/>
        <a href="${g.createLink(controller: 'admin', action:'editSettingText',
                params:[name:name,
                        editMode:true,
                        returnUrl:grailsApplication.config.grails.serverURL+path])}"
           class="btn btn-default">edit
        </a>
</auth:ifAnyGranted>

<mdba:getSettingContent settingType="${name}"/>