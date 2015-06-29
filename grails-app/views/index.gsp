<%@ page import="au.org.ala.biocache.hubs.FacetsName; org.apache.commons.lang.StringUtils" contentType="text/html;charset=UTF-8" %>
<%@ page import="org.springframework.web.servlet.support.RequestContextUtils; au.org.ala.biocache.hubs.FacetsName; org.apache.commons.lang.StringUtils" contentType="text/html;charset=UTF-8" %>
<g:set var="hubDisplayName" value="${grailsApplication.config.skin.orgNameLong}"/>
<g:set var="biocacheServiceUrl" value="${grailsApplication.config.biocache.baseUrl}"/>
<g:set var="serverName" value="${grailsApplication.config.serverName?:grailsApplication.config.biocache.baseUrl}"/>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <title>${grailsApplication.config.skin.orgNameLong}</title>
    <r:require modules="jquery, leaflet, mapCommon, searchMap"/>
    <script src="http://maps.google.com/maps/api/js?v=3.5&sensor=false"></script>
    <r:script>
        // global var for GSP tags/vars to be passed into JS functions
        var BC_CONF = {
            biocacheServiceUrl: "${alatag.getBiocacheAjaxUrl()}",
            bieWebappUrl: "${grailsApplication.config.bie.baseUrl}",
            autocompleteHints: ${grailsApplication.config.bie?.autocompleteHints?.encodeAsJson()?:'{}'},
            contextPath: "${request.contextPath}",
            locale: "${org.springframework.web.servlet.support.RequestContextUtils.getLocale(request)}",
            queryContext: "${grailsApplication.config.biocache.queryContext}"
        }

        $(document).ready(function() {

            var mapInit = false;
            $('a[data-toggle="tab"]').on('shown', function(e) {
                //console.log("this", $(this).attr('id'));
                var id = $(this).attr('id');
                location.hash = 'tab_'+ $(e.target).attr('href').substr(1);

                if (id == "t5" && !mapInit) {
                    initialiseMap();
                    mapInit = true;
                }
            });
            // catch hash URIs and trigger tabs
            if (location.hash !== '') {
                $('.nav-tabs a[href="' + location.hash.replace('tab_','') + '"]').tab('show');
                //$('.nav-tabs li a[href="' + location.hash.replace('tab_','') + '"]').click();
            } else {
                $('.nav-tabs a:first').tab('show');
            }

            // Toggle show/hide sections with plus/minus icon
            $(".toggleTitle").not("#extendedOptionsLink").click(function(e) {
                e.preventDefault();
                var $this = this;
                $(this).next(".toggleSection").slideToggle('slow', function(){
                    // change plus/minus icon when transition is complete
                    $($this).toggleClass('toggleTitleActive');
                });
            });

            $(".toggleOptions").click(function(e) {
                e.preventDefault();
                var $this = this;
                var targetEl = $(this).attr("id");
                $(targetEl).slideToggle('slow', function(){
                    // change plus/minus icon when transition is complete
                    $($this).toggleClass('toggleOptionsActive');
                });
            });

            // Add WKT string to map button click
            $('#addWkt').click(function() {
                var wktString = $('#wktInput').val();

                if (wktString) {
                    drawWktObj($('#wktInput').val());
                } else {
                    alert("Please paste a valid WKT string"); // TODO i18n this
                }
            });

            /**
             * Load Spring i18n messages into JS
             */
            jQuery.i18n.properties({
                name: 'messages',
                path: '${request.contextPath}/messages/i18n/',
                mode: 'map',
                language: '${request.locale}' // default is to use browser specified locale
                //callback: function(){} //alert( "facet.conservationStatus = " + jQuery.i18n.prop('facet.conservationStatus')); }
            });

        }); // end $(document).ready()

        // extend tooltip with callback
        var tmp = $.fn.tooltip.Constructor.prototype.show;
        $.fn.tooltip.Constructor.prototype.show = function () {
            tmp.call(this);
            if (this.options.callback) {
                this.options.callback();
            }
        };

        var mbAttr = 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
            '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
            'Imagery © <a href="http://mapbox.com">Mapbox</a>';
        var mbUrl = 'https://{s}.tiles.mapbox.com/v3/{id}/{z}/{x}/{y}.png';
        var defaultBaseLayer = L.tileLayer(mbUrl, {id: 'examples.map-20v6611k', attribution: mbAttr});

        // Global var to store map config
        var MAP_VAR = {
            map : null,
            mappingUrl : "${mappingUrl}",
            query : "${searchString}",
            queryDisplayString : "${queryDisplayString}",
            //center: [-30.0,133.6],
            defaultLatitude : "${grailsApplication.config.map.defaultLatitude?:'-25.4'}",
            defaultLongitude : "${grailsApplication.config.map.defaultLongitude?:'133.6'}",
            defaultZoom : "${grailsApplication.config.map.defaultZoom?:'4'}",
            overlays : {
        <g:if test="${grailsApplication.config.map.overlay.url}">
            "${grailsApplication.config.map.overlay.name?:'overlay'}" : L.tileLayer.wms("${grailsApplication.config.map.overlay.url}", {
                        layers: 'ALA:ucstodas',
                        format: 'image/png',
                        transparent: true,
                        attribution: "${grailsApplication.config.map.overlay.name?:'overlay'}"
                    })
        </g:if>
        },
        baseLayers : {
            "Minimal" : defaultBaseLayer,
            //"Night view" : L.tileLayer(cmUrl, {styleId: 999,   attribution: cmAttr}),
            "Road" :  new L.Google('ROADMAP'),
            "Terrain" : new L.Google('TERRAIN'),
            "Satellite" : new L.Google('HYBRID')
        },
        layerControl : null,
        //currentLayers : [],
        //additionalFqs : '',
        //zoomOutsideScopedRegion: ${(grailsApplication.config.map.zoomOutsideScopedRegion == false || grailsApplication.config.map.zoomOutsideScopedRegion == "false") ? false : true}
        };

        function initialiseMap() {
            //alert('starting map');
            if(MAP_VAR.map != null){
                return;
            }

            //initialise map
            MAP_VAR.map = L.map('leafletMap', {
                center: [MAP_VAR.defaultLatitude, MAP_VAR.defaultLongitude],
                zoom: MAP_VAR.defaultZoom,
                minZoom: 1,
                scrollWheelZoom: false
//                fullscreenControl: true,
//                fullscreenControlOptions: {
//                    position: 'topleft'
//                }
            });

            //add edit drawing toolbar
            // Initialise the FeatureGroup to store editable layers
            MAP_VAR.drawnItems = new L.FeatureGroup();
            MAP_VAR.map.addLayer(MAP_VAR.drawnItems);

            // Initialise the draw control and pass it the FeatureGroup of editable layers
            MAP_VAR.drawControl = new L.Control.Draw({
                edit: {
                    featureGroup: MAP_VAR.drawnItems
                },
                draw: {
                    polyline: false,
                    rectangle: {
                        shapeOptions: {
                            color: '#bada55'
                        }
                    },
                    circle: {
                        shapeOptions: {
                            color: '#bada55'
                        }
                    },
                    marker: false,
                    polygon: {
                        allowIntersection: false, // Restricts shapes to simple polygons
                        drawError: {
                            color: '#e1e100', // Color the shape will turn when intersects
                            message: '<strong>Oh snap!<strong> you can\'t draw that!' // Message that will show when intersect
                        },
                        shapeOptions: {
                            color: '#bada55'
                        }
                    }
                }
            });
            MAP_VAR.map.addControl(MAP_VAR.drawControl);

            MAP_VAR.map.on('draw:created', function(e) {
                //setup onclick event for this object
                var layer = e.layer;
                //console.log("layer",layer, layer._latlng.lat);
                generatePopup(layer, layer._latlng);
                addClickEventForVector(layer);
                MAP_VAR.drawnItems.addLayer(layer);
            });

            MAP_VAR.map.on('draw:edited', function(e) {
                //setup onclick event for this object
                var layers = e.layers;
                layers.eachLayer(function (layer) {
                    generatePopup(layer, layer._latlng);
                    addClickEventForVector(layer);
                });
            });

            //add the default base layer
            MAP_VAR.map.addLayer(defaultBaseLayer);

            L.control.coordinates({position:"bottomleft", useLatLngOrder: true}).addTo(MAP_VAR.map); // coordinate plugin

            MAP_VAR.layerControl = L.control.layers(MAP_VAR.baseLayers, MAP_VAR.overlays, {collapsed:true, position:'topleft'});
            MAP_VAR.layerControl.addTo(MAP_VAR.map);

            L.Util.requestAnimFrame(MAP_VAR.map.invalidateSize, MAP_VAR.map, !1, MAP_VAR.map._container);
            L.Browser.any3d = false; // FF bug prevents selects working properly

            // Add a help tooltip to map when first loaded
            MAP_VAR.map.whenReady(function() {
                var opts = {
                    placement:'right',
                    callback: destroyHelpTooltip // hide help tooltip when mouse over the tools
                }
                $('.leaflet-draw-toolbar a').tooltip(opts);
                $('.leaflet-draw-toolbar').first().attr('title','Start by choosing a tool').tooltip({placement:'right'}).tooltip('show');
            });

            // Hide help tooltip on first click event
            var once = true;
            MAP_VAR.map.on('click', function(e) {
                if (once) {
                    $('.leaflet-draw-toolbar').tooltip('destroy');
                    once = false;
                }
            });
        }

        var once = true;
        function destroyHelpTooltip() {
            if ($('.leaflet-draw-toolbar').length && once) {
                $('.leaflet-draw-toolbar').tooltip('destroy');
                once = false;
            }
        }

    </r:script>
</head>

<body>
<!-- <div id="headingBar" class="heading-bar"> --->
    <g:img dir="/images" file="kingfisher-strip-logo.png" alt="kingfisher" />
<!--</div> -->
<g:if test="${flash.message}">
    <div class="message alert alert-info">
        <button type="button" class="close" onclick="$(this).parent().hide()">×</button>
        <b><g:message code="home.index.body.alert" default="Alert:"/></b> ${raw(flash.message)}
    </div>
</g:if>
<div class="row-fluid" id="content">
    <div class="span12" style="padding-left: 32px; padding-right: 32px">
<!--        <div style="padding-left: 14px; padding-right: 14px"> -->
            <h2 style="color:#00A18F">Browse the MDBA Portal</h3>
        <form name="advancedSearchForm" id="advancedSearchForm" action="${request.contextPath}/advancedSearch" method="POST">
            <input type="text" id="solrQuery" name="q" style="position:absolute;left:-9999px;" value="${params.q}"/>
            <input type="hidden" name="nameType" value="matched_name_children"/>
            <table border="0" width="100" cellspacing="2" class="compact">
                <thead/>
                <tbody>
                <tr style="" id="taxon_row_${i}">
                    <td class="labels">Browse by Species:</td>
                    <td>
                        <input type="text" value="" id="taxa_${i}" name="taxonText" class="name_autocomplete" size="60">
                        <input type="hidden" name="lsid" class="lsidInput" id="taxa_${i}" value=""/>
                    </td>
                </tr>
                <tr>
                    <td class="labels">Browse by Species Group:</td>
                    <td>
                        <select class="species_group" name="species_group" id="species_group">
                            <option value=""><g:message code="advancedsearch.table04col01.option.label" default="-- select a species group --"/></option>
                            <g:each var="group" in="${request.getAttribute(FacetsName.SPECIES_GROUP.fieldname)}">
                                <option value="${group.key}">${group.value}</option>
                            </g:each>
                        </select>
                    </td>
                </tr>
                <tr>
                     <td class="labels">Browse by IBRA region:</td>
                     <td>
                         <select class="biogeographic_region" name="ibra" id="ibra">
                             <option value=""><g:message code="advancedsearch.ibra.option.label" default="-- select an IBRA region --"/></option>
                             <g:each var="region" in="${request.getAttribute(FacetsName.IBRA.fieldname)}">
                             <option value="${region.key}">${region.value}</option>
                             </g:each>
                         </select>
                     </td>
                 </tr>
                 <tr>
                    <td class="labels">Browse by State:</td>
                    <td>
                        <select class="state" name="state" id="state">
                            <option value=""><g:message code="advancedsearch.table06col02.option.label" default="-- select a state/territory --"/></option>
                            <g:each var="state" in="${request.getAttribute(FacetsName.STATES.fieldname)}">
                                <option value="${state.key}">${state.value}</option>
                            </g:each>
                        </select>
                    </td>
                </tr>
                </tbody>
            </table>
            <input type="submit" value=<g:message code="advancedsearch.button.submit" default="Search"/> class="btn btn-primary" />
        &nbsp;&nbsp;
            <input type="reset" value="Clear all" id="clearAll" class="btn" onclick="$('input#solrQuery').val(''); $('input.clear_taxon').click(); return true;"/>
        </form>




    </div><!-- end .span12 -->
</div><!-- end .row-fluid -->
</body>
</html>
