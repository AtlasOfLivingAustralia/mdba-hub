<html>
<head>
    <g:set var="collectoryService" bean="collectoryService"></g:set>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <title><mdba:pageTitle>${instance.name}</mdba:pageTitle></title>
    <script type="text/javascript" language="javascript" src="http://www.google.com/jsapi"></script>
    <r:require modules="jquery, fancybox, jquery_jsonp, charts, collectory"/>
    <r:script type="text/javascript" disposition="head">
      biocacheServicesUrl = "${grailsApplication.config.biocacheServicesUrl}";
      biocacheWebappUrl = "${grailsApplication.config.grails.serverURL}";
      loadLoggerStats = ${!grailsApplication.config.disableLoggerLinks.toBoolean()};
      var COLLECTORY_CONF = { contextPath: "${grailsApplication.config.contextPath}", locale: "" }
      $(document).ready(function () {
        $("a#lsid").fancybox({
            'hideOnContentClick': false,
            'titleShow': false,
            'autoDimensions': false,
            'width': 600,
            'height': 180
        });
        $("a.current").fancybox({
            'hideOnContentClick': false,
            'titleShow': false,
            'titlePosition': 'inside',
            'autoDimensions': true,
            'width': 300
        });
      });
    </r:script>
</head>

<body>
<div id="content">
    <div id="header" class="collectory">
        <div class="row-fluid">
            <div class="span8">
                <h1>${instance.name}</h1>
                <g:set var="parents" value="${instance.parentInstitutions}"/>
                <g:each var="p" in="${parents}">
                    <h2><g:link action="show" id="${p.uid}">${p.name}</g:link></h2>
                </g:each>
                <mdba:valueOrOtherwise value="${instance.acronym}"><span
                        class="acronym">Acronym: ${instance.acronym}</span></mdba:valueOrOtherwise>
            </div>

            <div class="span4">
                <g:if test="${instance.logoRef && instance.logoRef.uri}">
                    <img class="institutionImage"
                         src='${instance.logoRef.uri}'/>
                </g:if>
            </div>
        </div>
    </div><!--close header-->
    <div class="row-fluid">
            <div class="span8">
                <g:if test="${instance.pubDescription}">
                    <h2><g:message code="public.des" /></h2>
                    <mdba:formattedText>${instance.pubDescription}</mdba:formattedText>
                    <g:if test="${instance.techDescription}">
                        <mdba:formattedText>${instance.techDescription}</mdba:formattedText>
                    </g:if>
                </g:if>
                <g:if test="${instance.focus}">
                    <h2><g:message code="public.si.content.label02" /></h2>
                    <mdba:formattedText>${instance.focus}</mdba:formattedText>
                </g:if>
                <g:if test="${instance.collections?.size()}">
                    <h2><g:message code="public.si.content.label03" /></h2>
                    <ol>
                        <g:each var="c" in="${instance.collections.sort { it.name }}">
                            <li><g:link controller="public" action="show"
                                        id="${c.uid}">${c?.name}</g:link> ${c?.makeAbstract(400)}</li>
                        </g:each>
                    </ol>
                </g:if>
                <g:if test="instance.linkedRecordProviders?.size()">
                    <h2><g:message code="public.si.content.label05" /></h2>
                    <ol>
                        <g:each var="c" in="${instance.linkedRecordProviders.sort { it.name }}">
                            <li><g:link controller="datasets" action="showDataResource"
                                        id="${c.uid}">${c?.name}</g:link></li>
                        </g:each>
                    </ol>
                </g:if>
                <div id='usage-stats'>
                    <h2><g:message code="public.usagestats.label" /></h2>

                    <div id='usage'>
                        <p><g:message code="public.usage.des" />...</p>
                    </div>
                </div>

                <h2><g:message code="public.si.content.label04" /></h2>

                <div>
                    <p style="padding-bottom:8px;"><span
                            id="numBiocacheRecords"><g:message code="public.numbrs.des01" /></span> <g:message code="public.numbrs.des02" />.
                    </p>
                    %{--<mdba:recordsLink--}%
                            %{--entity="${instance}"><g:message code="public.numbrs.link" /> ${instance.name}.</mdba:recordsLink>--}%
                </div>

                <div id="recordsBreakdown" class="section vertical-charts">
                    <div id="charts"></div>
                </div>

                <mdba:lastUpdated date="${instance.lastUpdated}"/>

            </div><!--close section-->
            <div class="span4">
                <g:if test="${instance.imageRef && instance.imageRef.file}">
                    <div class="section">
                        <img alt="${instance.imageRef.file}"
                             src="${resource(absolute: "true", dir: "data/institution/", file: instance.imageRef.file)}"/>
                        <mdba:formattedText
                                pClass="caption">${instance.imageRef.caption}</mdba:formattedText>
                        <mdba:valueOrOtherwise value="${instance.imageRef?.attribution}"><p
                                class="caption">${instance.imageRef.attribution}</p></mdba:valueOrOtherwise>
                        <mdba:valueOrOtherwise value="${instance.imageRef?.copyright}"><p
                                class="caption">${instance.imageRef.copyright}</p></mdba:valueOrOtherwise>
                    </div>
                </g:if>

                <div id="dataAccessWrapper" style="display:none;">
                    <g:render template="dataAccess" model="[instance:instance, facet:'institution_uid']"/>
                </div>

                <div class="section">
                    <h3><g:message code="public.location" /></h3>
                    <g:if test="${instance.address != null && !collectoryService.isAddressEmpty(instance.address)}">
                        <p>
                            <mdba:valueOrOtherwise
                                    value="${instance.address?.street}">${instance.address?.street}<br/></mdba:valueOrOtherwise>
                            <mdba:valueOrOtherwise
                                    value="${instance.address?.city}">${instance.address?.city}<br/></mdba:valueOrOtherwise>
                            <mdba:valueOrOtherwise
                                    value="${instance.address?.state}">${instance.address?.state}</mdba:valueOrOtherwise>
                            <mdba:valueOrOtherwise
                                    value="${instance.address?.postcode}">${instance.address?.postcode}<br/></mdba:valueOrOtherwise>
                            <mdba:valueOrOtherwise
                                    value="${instance.address?.country}">${instance.address?.country}<br/></mdba:valueOrOtherwise>
                        </p>
                    </g:if>
                    <g:if test="${instance.email}"><mdba:emailLink>${instance.email}</mdba:emailLink><br/></g:if>
                    <mdba:ifNotBlank value='${instance.phone}'/>
                </div>

            <!-- contacts -->
                <g:render template="contacts" model="${[contacts: collectoryService.getPublicContactsPrimaryFirst(instance.contacts)]}"/>

            <!-- web site -->
                <g:if test="${instance.websiteUrl}">
                    <div class="section">
                        <h3><g:message code="public.website" /></h3>

                        <div class="webSite">
                            <a class='external' target="_blank"
                               href="${instance.websiteUrl}"><g:message code="public.si.website.link01" /> <mdba:institutionType
                                    inst="${instance}"/><g:message code="public.si.website.link02" /></a>
                        </div>
                    </div>
                </g:if>

            </div>
        </div><!--close content-->
</div>
<r:script type="text/javascript">
      // configure the charts
      var facetChartOptions = {
          /* base url of the collectory */
          collectionsUrl: "${grailsApplication.config.grails.serverURL}",
          /* base url of the biocache ws*/
          biocacheServicesUrl: biocacheServicesUrl,
          /* base url of the biocache webapp*/
          biocacheWebappUrl: biocacheWebappUrl,
          /* a uid or list of uids to chart - either this or query must be present
            (unless the facet data is passed in directly AND clickThru is set to false) */
          instanceUid: "${collectoryService.descendantUids(instance)?.join(',')}",
          /* the list of charts to be drawn (these are specified in the one call because a single request can get the data for all of them) */
          charts: ['country','state','species_group','assertions','type_status',
              'biogeographic_region','state_conservation','occurrence_year']
      }
      var taxonomyChartOptions = {
          /* base url of the collectory */
          collectionsUrl: "${grailsApplication.config.grails.serverURL}",
          /* base url of the biocache ws*/
          biocacheServicesUrl: biocacheServicesUrl,
          /* base url of the biocache webapp*/
          biocacheWebappUrl: biocacheWebappUrl,
          /* a uid or list of uids to chart - either this or query must be present */
          instanceUid: "${collectoryService.descendantUids(instance)?.join(',')}",
          /* threshold value to use for automagic rank selection - defaults to 55 */
          threshold: 55,
          rank: "${null}"
      }

    /************************************************************\
    * Actions when page is loaded
    \************************************************************/
    function onLoadCallback() {

      // stats
      if(loadLoggerStats){
        loadDownloadStats("${grailsApplication.config.loggerURL}", "${instance.uid}","${instance.name}", "1002");
      }

      // records
      $.ajax({
        url: urlConcat(biocacheServicesUrl, "/occurrences/search.json?pageSize=0&q=") + buildQueryString("${collectoryService.descendantUids(instance)?.join(',')}"),
        dataType: 'jsonp',
        timeout: 20000,
        complete: function(jqXHR, textStatus) {
            if (textStatus == 'timeout') {
                noData();
                alert('Sorry - the request was taking too long so it has been cancelled.');
            }
            if (textStatus == 'error') {
                noData();
                alert('Sorry - the records breakdowns are not available due to an error.');
            }
        },
        success: function(data) {
            // check for errors
            if (data.length == 0 || data.totalRecords == undefined || data.totalRecords == 0) {
                noData();
            } else {
                setNumbers(data.totalRecords);
                // draw the charts
                drawFacetCharts(data, facetChartOptions);
                if(data.totalRecords > 0){
                    $('#dataAccessWrapper').css({display:'block'});
                    $('#totalRecordCountLink').html(data.totalRecords.toLocaleString() + ' records');
                }
            }
        }
      });

      // taxon chart
      loadTaxonomyChart(taxonomyChartOptions);
    }
    /************************************************************\
    *
    \************************************************************/

    google.load("visualization", "1", {packages:["corechart"]});
    google.setOnLoadCallback(onLoadCallback);

</r:script>
</body>
</html>