<g:set var="fluidLayout" value="${grailsApplication.config.skin.fluidLayout?.toBoolean()}"/>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <title>${grailsApplication.config.skin.orgNameLong}</title>
    <r:script>
        $(document).ready(function(){
            $(".homePageNav button").click(function(e) {
                e.preventDefault();
                var url = $(this).data("href");
                window.location = url;
            });
        });
    </r:script>
</head>
<body>
<content tag="page-header">
    <div id="homeBanner">
        <div class="${fluidLayout?'container-fluid':'container'}">
            <g:img dir="/images" file="MDBA_AG_crest_mono_reverse_stacked.png" alt="kingfisher" id="bannerImg"/>
        </div>
    </div>
</content>

<g:if test="${flash.message}">
    <div class="message alert alert-info">
        <button type="button" class="close" onclick="$(this).parent().hide()">×</button>
        <b><g:message code="home.index.body.alert" default="Alert:"/></b> ${raw(flash.message)}
    </div>
</g:if>

<div class="${fluidLayout?'row-fluid':'row'}">
    <div class="span12" id="quickSearchBox">
        <form action="${g.createLink(controller: 'occurrences', action: 'search')}" id="solrSearchForm" class="">
            <div class="input-append pull-right">
                <input class="input span2" placeholder="Quick search" name="taxa" type="text">
                <button class="btn btn-primary" type="submit">Go!</button>
            </div>
        </form>
    </div><!-- end .span12 -->
</div><!-- end .row-fluid -->
<div class="${fluidLayout?'row-fluid':'row'}">
    <g:render template="/homeActionButton" model="[label:'Species', browseBy: true, href: g.createLink(controller:'browseBy', action:'species')]"/>
    <g:render template="/homeActionButton" model="[label:'Catchment', browseBy: true, href:grailsApplication.config.mdba.regions]"/>
    <g:render template="/homeActionButton" model="[label:'Dataset', browseBy: true, href:'http://collections.ala.org.au/public/show/in94']"/>
</div><!-- end .row-fluid -->
<div class="${fluidLayout?'row-fluid':'row'}">
    <g:render template="/homeActionButton" model="[label:'Traditional Owner Groups',href:'']"/>
    <g:render template="/homeActionButton" model="[label:'Basin Champions', href:grailsApplication.config.mdba.basinChampions]"/>
    <g:render template="/homeActionButton" model="[label:'Resources',href:g.createLink(controller: 'resource', action:'list')]"/>
</div><!-- end .row-fluid -->
<div class="indexBuffer"></div>
</body>
</html>
