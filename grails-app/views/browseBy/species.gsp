%{--
  - Copyright (c) 2015 Atlas of Living Australia
  - All Rights Reserved.
  - The contents of this file are subject to the Mozilla Public
  - License Version 1.1 (the "License"); you may not use this file
  - except in compliance with the License. You may obtain a copy of
  - the License at http://www.mozilla.org/MPL/
  - Software distributed under the License is distributed on an "AS
  - IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
  - implied. See the License for the specific language governing
  - rights and limitations under the License.
  --}%

<%--
  Created by IntelliJ IDEA.
  User: dos009@csiro.au
  Date: 5/11/15
  Time: 9:53 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Browse Basin Records By Species</title>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <r:require modules="browseBy"/>
    <r:script>
        $(document).ready(function(){
            // BS affix plugin for groups menu
            $('#groupsNav').affix({
                offset: { top: $('#groupsNav').offset().top }
            });

            $('.imgCon img').error(function(){
                $(this).attr('src', '${g.createLink(uri:'/images/infobox_info_icon.png')}').addClass("infoboxImg");
            });

        }); // end document ready
    </r:script>
</head>
<body data-offset="70" data-target="#page-nav" data-spy="scroll">
<h2>Browse Species</h2>
<div class="inner row-fluid">
    <div class="span3" id="page-nav">
        <ul id="groupsNav" class="nav nav-list bs-docs-sidenav affix-top">
            %{--<g:set var="fqs" value="${params.list('fq')}" />--}%
            <g:each in="${speciesGroupMap}" var="group" status="s">
                <g:set var="active" value="${(s == 0) ? 'active' : ''}"/>
                <li class="${active}"><a href="#species_${group.key}">${group.key} (${group.value?.size()})<i class="icon-chevron-right"></i> </a></li>
            </g:each>
        </ul>
    </div> <!-- /span3 -->
    <div class="span9">
        <g:each in="${speciesGroupMap}" var="group" status="s">
            <div id="species_${group.key}" class="gridView">
                <h3>${group.key}</h3>
                <g:each in="${group.value}" var="taxon">
                    <div class="imgCon">
                        <g:set var="searchUrl">/occurrences/search?q=lsid:${taxon.guid}</g:set>
                        <a class="thumbImage viewRecordButton" rel="thumbs" title="click to view records for ${taxon.commonName?:taxon.name}" href="${g.createLink(uri:searchUrl)}"
                           data-id="${taxon.guid}"><img src="${taxon.imageUrl?:g.createLink(uri:'/images/infobox_info_icon.png')}" alt="species image"/>
                        </a>
                        <div class="meta brief">
                            ${taxon.commonName?:taxon.name}
                        </div>
                    </div>
                </g:each>
            </div>
        </g:each>
    </div> <!-- .span9 -->
</div>
<div style="margin: 250px 0;"></div>
</body>
</html>