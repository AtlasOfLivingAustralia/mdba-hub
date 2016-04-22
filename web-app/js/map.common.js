function generatePopup(layer, latlng) {
    //console.log('generatePopup', layer, latlng);
    var params = "";
    if (jQuery.isFunction(layer.getRadius)) {
        // circle
        params = getParamsForCircle(layer);
    } else {
        var wkt = new Wkt.Wkt();
        wkt.fromObject(layer);
        params = getParamsforWKT(wkt.write());
    }

    if (latlng == null) {
        latlng = layer.getBounds().getCenter();
    }
    //console.log('latlng', latlng);
    L.popup()
        .setLatLng([latlng.lat, latlng.lng])
        .setContent("species count: <b id='speciesCountDiv'>calculating...</b><br>" +
        "occurrence count: <b id='occurrenceCountDiv'>calculating...</b><br>" +
        "dataset count: <b id='datasetCountDiv'>calculating...</b><br>" +
        "<a id='showOnlyTheseRecords' href='" + BC_CONF.contextPath + "/occurrences/search" +
        params + "'>" + jQuery.i18n.prop("search.map.popup.linkText") + "</a>")
        .openOn(MAP_VAR.map);

    //layer.openPopup();

    getSpeciesCountInArea(params);
    getOccurrenceCountInArea(params);
    getDataSetInArea(params)
}

function getDataSetInArea(params) {
    speciesCount = -1;
    $.getJSON(BC_CONF.biocacheServiceUrl + "/occurrence/facets.json" + params + "&facets=data_resource_uid&callback=?",
        function( data ) {
            var speciesCount = data[0].count;
            document.getElementById("datasetCountDiv").innerHTML = speciesCount;
        });
}
