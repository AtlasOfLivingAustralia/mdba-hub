<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <parameter name="returnUrlPath" value="${grailsApplication.config.grails.serverURL}"/>
    <title>${grailsApplication.config.skin.orgNameLong}</title>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
</head>

<body>
<!-- <div id="headingBar" class="heading-bar"> --->
<g:img dir="/images" file="kingfisher-strip-logo.png" alt="kingfisher" />
<!--</div> -->

<div style="padding-left: 14px; padding-right: 14px">
    <h2 style="color:#00A18F">Online accessibility statement</h2>
    <p>Australian Government departments and Agencies are obliged by the <i>Disability Discrimination Act 1992</i>> to
    ensure that online information and services are accessible by people with disabilities. They are also required to
    make online resources accessible to people with technical constraints, such as older browsers and lower speed
    Internet connections.</p>
    <p>This website aims to conform to Level AA of the <a class="external" href="http://www.w3.org/TR/WCAG20/" target="_blank">Web Content Accessibility Guidelines version 2 (WCAG 2.0)</a>
        , developed by the <a class="external" href="http://www.w3.org/WAI/" target="_blank">Web Accessibility Initiative of the World Wide Web Consortium (W3C)</a>.</p>
    <p>This web site has been developed to display adequately on all commonly used browsers and to work effectively with
    accessibility hardware and/or software. Although it is designed for a 1024&nbsp;x&nbsp;768 screen resolution, this
    site will scale to both higher and lower screen resolutions.</p>
    <p>For technical reasons and to meet some legal requirements, this web site has a limited number of documents that
    cannot be provided in HTML format. In such cases, contact details have been provided for the supply of alternative
    non-web formats.</p>
    <br>
    <br>
    <p>If you encounter accessibility difficulties with the Murray&ndash;Darling Basin Authority web site, please <a href="${request.contextPath}/contact">contact us</a>.</p>
    <br>
    <h4 style="color:#00A18F">Links:</h4>
    <p><a class="external" href="http://www.comlaw.gov.au/Details/C2014C00013" target="_blank" title="">Disability Discrimination Act</a><br />
        <a class="external" href="http://www.w3.org/TR/WCAG20/" target="_blank" title="">Web Accessibility Initiative of the World Wide Web Consortium</a> (W3C)</p>
</div>
</body>
</html>
