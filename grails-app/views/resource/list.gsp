<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <parameter name="returnUrlPath" value="${grailsApplication.config.grails.serverURL}"/>
    <title>${grailsApplication.config.skin.orgNameLong}</title>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <r:require modules="knockout,resources"/>
</head>

<body>
<h2>Resources</h2>
<g:render template="listDocuments"/>
<g:render template="attachDocument"/>
</body>
</html>