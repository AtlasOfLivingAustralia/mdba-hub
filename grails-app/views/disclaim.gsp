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
    <h2>Disclaimer</h2>
    <p>The Murray–Darling Basin Authority is responsible for the development and ongoing operation of the Murray–Darling
    Basin Authority web site.</p>
    <p>The Murray–Darling Basin Authority web site is presented by the Commonwealth for the purpose of disseminating
    information free of charge for the benefit of the public.</p>
    <p>The Commonwealth monitors the quality of the information available on this web site and updates the information
    regularly.</p>
    <p>However, the Commonwealth does not guarantee, and accepts no legal liability whatsoever arising from or connected
    to, the accuracy, reliability, currency or completeness of any material contained on this web site or on any linked site.</p>
    <p>The Commonwealth recommends that users exercise their own skill and care with respect to their use of this web site
    and that users carefully evaluate the accuracy, currency, completeness and relevance of the material on the web site for
    their purposes.</p>
    <p>This web site is not a substitute for independent professional advice and users should obtain any appropriate
    professional advice relevant to their particular circumstances.</p>
    <p>The material on this web site may include the views or recommendations of third parties, which do not necessarily
    reflect the views of the Commonwealth, or indicate its commitment to a particular course of action.</p>

    <h4>Security of the Murray–Darling Basin Authority web site</h4>
    <p>The Murray–Darling Basin Authority applies a range of security controls to protect its web site from unauthorised
    access. However, users should be aware that the World Wide Web is an insecure public network that gives rise to a
    potential risk that a user's transactions are being viewed, intercepted or modified by third parties or that files
    which the user downloads may contain computer viruses, disabling codes, worms or other devices or defects.</p>
    <p>The Commonwealth accepts no liability for any interference with or damage to a user's computer system, software
    or data occurring in connection with or relating to this web site or its use. Users are encouraged to take appropriate
    and adequate precautions to ensure that whatever is selected from this site is free of viruses or other contamination
    that may interfere with or damage the user's computer system, software or data.</p>
    <h4>Links to external web sites</h4>
    <p>This web site contains links to other web sites that are external to the Murray–Darling Basin Authority. The
    Murray–Darling Basin Authority takes reasonable care in linking web sites but has no direct control over the content
    of the linked web sites, the changes that may occur to the content on those web sites, or the security arrangements
    applying to those web sites. It is the responsibility of users to make their own decisions about the accuracy, currency,
    reliability and completeness of information contained on linked external web sites.</p>
    <p>Links to external web sites do not constitute an endorsement or a recommendation of any material on those web sites
    or of any third party products or services offered by, from or through those web sites. Users of links provided by this
    web site are responsible for being aware of which organisation is hosting the web site they visit.</p>
    <p>We make every reasonable effort to maintain links to current and accurate information. Please contact us to report
    any broken links.</p>
    <br>
    <br>
    <p>The Murray–Darling Basin Authority web site has been developed with usability principles as a main driver of design.
    We are always keen to receive ideas and feedback from our users, so if you have any comments or questions
    please <a href="${request.contextPath}/contact">contact us</a>.</p>
</div>

</body>
</html>
