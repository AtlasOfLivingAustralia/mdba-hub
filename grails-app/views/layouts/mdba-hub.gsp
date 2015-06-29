<g:set var="orgNameLong" value="${grailsApplication.config.skin.orgNameLong}"/>
<g:set var="orgNameShort" value="${grailsApplication.config.skin.orgNameShort}"/>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <alatag:addApplicationMetaTags />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    %{--<link rel="shortcut icon" type="image/x-icon" href="favicon.ico">--}%

    <title><g:layoutTitle /></title>
    <r:require modules="mdba" />
    <style type="text/css">
    body {
        background-color: #ffffff !important;
    }
    #breadcrumb {
        margin-top: 10px;
    }
    #main-content #searchInfoRow #customiseFacetsButton > .dropdown-menu {
        background-color: #ffffff;
    }
    #footer {
        padding-top: 20px;
        font-size: 12px;
    }
    .navbar-footer {
        min-height: 40px;
        padding-right: 20px;
        padding-left: 20px;
        background-color: #000000;
        background-image: linear-gradient(to bottom, #222222, #111111);
        background-repeat: repeat-x;
        border: 1px solid #000000;
        -webkit-border-radius: 4px;
        -moz-border-radius: 4px;
        border-radius: 4px;
        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffffff', endColorstr='#fff2f2f2', GradientType=0);
        *zoom: 1;
        -webkit-box-shadow: 0 1px 4px rgba(0, 0, 0, 0.065);
        -moz-box-shadow: 0 1px 4px rgba(0, 0, 0, 0.065);
        box-shadow: 0 1px 4px rgba(0, 0, 0, 0.065);
    }
    .navbar-footer:before,
    .navbar-footer:after {
        display: table;
        line-height: 0;
        content: "";
    }
    .navbar-footer:after {
        clear: both;
    }

    #content .nav-tabs > li.active > a {
        background-color: #ffffff;
    }
    .nav {
        margin-top: 20px;
    }
    body > #main-content {
        margin-top: 0px;
    }

    </style>
    <r:script disposition='head'>
        // initialise plugins
        jQuery(function(){
            // autocomplete on navbar search input
            jQuery("form#search-form-2011 input#search-2011, form#search-inpage input#search, input#search-2013").autocomplete('http://bie.ala.org.au/search/auto.jsonp', {
                extraParams: {limit: 100},
                dataType: 'jsonp',
                parse: function(data) {
                    var rows = new Array();
                    data = data.autoCompleteList;
                    for(var i=0; i<data.length; i++) {
                        rows[i] = {
                            data:data[i],
                            value: data[i].matchedNames[0],
                            result: data[i].matchedNames[0]
                        };
                    }
                    return rows;
                },
                matchSubset: false,
                formatItem: function(row, i, n) {
                    return row.matchedNames[0];
                },
                cacheLength: 10,
                minChars: 3,
                scroll: false,
                max: 10,
                selectFirst: false
            });

            // Mobile/desktop toggle
            // TODO: set a cookie so user's choice is remembered across pages
            var responsiveCssFile = $("#responsiveCss").attr("href"); // remember set href
            $(".toggleResponsive").click(function(e) {
                e.preventDefault();
                $(this).find("i").toggleClass("icon-resize-small icon-resize-full");
                var currentHref = $("#responsiveCss").attr("href");
                if (currentHref) {
                    $("#responsiveCss").attr("href", ""); // set to desktop (fixed)
                    $(this).find("span").html("Mobile");
                } else {
                    $("#responsiveCss").attr("href", responsiveCssFile); // set to mobile (responsive)
                    $(this).find("span").html("Desktop");
                }
            });

            $('.helphover').popover({animation: true, trigger:'hover'});
        });
    </r:script>
    <r:layoutResources/>
    <g:layoutHead />
</head>
<body class="${pageProperty(name:'body.class')?:'nav-collections'}" id="${pageProperty(name:'body.id')}" onload="${pageProperty(name:'body.onload')}">
<g:set var="fluidLayout" value="${grailsApplication.config.skin.fluidLayout?.toBoolean()}"/>
<div class="navbar navbar-inverse navbar-static-top">
    <div class="navbar-inner">
        <div class="${fluidLayout?'container-fluid':'container'}">
            <div class="span8">
                <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="brand" href="http://ala.org.au/"> <g:img dir="/images" file="atlas-poweredby_rgb-darkbg-flat.png" alt="Powered by ALA logo"/></a>
                <div class="nav-collapse collapse" style="font-size: 18px; line-height: 32px; padding-top: 6px;">
                    <ul class="nav">
                        <li><a href="${request.contextPath}/index">Home</a></li>
                        <li><a href="${request.contextPath}/search">Search</a></li>
                        <li><a href="${request.contextPath}/about">About</a></li>
                        <li><a href="${request.contextPath}/help">Help</a></li>
                    </ul>
                </div><!--/.nav-collapse -->
            </div>
            <div class="span4">
                <div class="controls" style="padding-top: 18px">
                    <div class="input-append">
                        <input type="text" name="taxa" id="taxa" class="input-large">
                        <button id="locationSearch" type="submit" class="btn"><g:message code="home.index.simsplesearch.button" default="Search"/></button>
                    </div>
                </div>
            </div>
        </div><!--/.container-fluid -->
    </div><!--/.navbar-inner -->
</div><!--/.navbar -->


<div class="${fluidLayout?'container-fluid':'container'}" id="main-content">
    <g:layoutBody />
</div><!--/.container-->

<div id="footer">
   <div class="navbar navbar-inverse navbar-static-top">
       <div class="navbar-footer"> -->
           <a class="brand"></a>
           <div class="span6" style="text-align:right; padding-top: 12px; padding-bottom: 8px">
               <ul class="nav">
                   <li><a href="${request.contextPath}/contact">Contact us</a></li>
                   <li><a href="${request.contextPath}/access">Accessibility</a></li>
                   <li><a href="${request.contextPath}/disclaim">Disclaimer</a></li>
               </ul>
           </div><!--/.nav-collapse -->
           <div class="span1" style="text-align:right; padding-top: 8px; padding-bottom: 8px">
               <a href="https://twitter.com/MD_Basin_Auth"> <g:img dir="/images" file="twitter-icon.png" alt="MDBA on Twitter"/></a>
           </div>
           <div class="span1" style="text-align:right; padding-top: 8px; padding-bottom: 8px">
               <a href="https://www.youtube.com/user/mdbamedia"> <g:img dir="/images" file="youtube-icon.png" alt="MDBA on Youtube"/></a>
           </div>
           <div class="span1" style="text-align:right; padding-top: 8px; padding-bottom: 8px">
               <a href="https://www.facebook.com/MDBAuth"> <g:img dir="/images" file="facebook-icon.png" alt="MDBA on Facebook"/></a>
           </div>
           </div><!--/.container-fluid -->
       </div><!--/.navbar-inner -->
   </div><!--/.navbar -->
</div><!--/#footer -->
<br/>

<!-- JS resources-->
<r:layoutResources/>
</body>
</html>