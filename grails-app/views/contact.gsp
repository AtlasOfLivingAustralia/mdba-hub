<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <parameter name="returnUrlPath" value="${grailsApplication.config.grails.serverURL}"/>
    <title>${grailsApplication.config.skin.orgNameLong}</title>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
</head>

<body>
<content tag="page-header">
    <div id="homeBanner">
        <div class="${fluidLayout?'container-fluid':'container'}">
            <g:img dir="/images" file="MDBA_AG_crest_mono_reverse_stacked.png" alt="kingfisher" id="bannerImg"/>
        </div>
    </div>
</content>
<div class="staticContent">
    <h2>Contact us</h2>
    <h4>General enquiries</h4>
    <b>Phone:</b> 02 6279 0100<br>
    <b>Fax:</b> 02 6248 8053<br>
    <b>Address:</b> Level 4, 51 Allara St, Canberra City, ACT 2601<br>
    <b>Postal Address:</b> GPO Box 1801, Canberra City 2601<br>
    <br>
    <h4>Community Questions</h4>
    <b>Phone:</b> 1800 230 067
</div>
</body>
</html>
