<%@ page import="grails.converters.JSON" %>

<div class="row-fluid row-eq-height" id="resourceList">

    <div class="span4">

        <div class="btn-toolbar text-right">
            <div class="input-prepend input-append text-left">
                <span class="add-on"><i class="fa fa-filter"></i></span>
                <input type="text" data-bind="textInput: documentFilter">
                <div class="btn-group">
                    <button type="button" class="btn dropdown-toggle" data-toggle="dropdown">
                        <span data-bind="text: documentFilterField().label"></span>
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" data-bind="foreach: documentFilterFieldOptions">
                        <li><a data-bind="{ text: $data.label, click: $parent.documentFilterField }"></a></li>
                    </ul>
                </div>
            </div>
        </div>


        <div class="well well-small fc-docs-list-well">
            <!-- ko if: filteredDocuments().length == 0 -->
                <h4 class="text-center">No documents</h4>
            <!-- /ko -->
            <ul class="nav nav-list fc-docs-list" data-bind="foreach: { data: filteredDocuments }">
                <li class="pointer" data-bind="{ click: $parent.selectDocument, css: { active: $parent.selectedDocument() == $data } }">
                    <div class="clearfix space-after media" data-bind="template:$parent.documentTemplate($data)"></div>
                </li>
            </ul>
        </div>
        <g:if test="${admin}"><button class="btn" data-bind="click:attachDocument">New Resource</button></g:if>
    </div>
    <div class="fc-resource-preview-container span8" data-bind="{ template: { name: previewTemplate } }"></div>
</div>

<script id="iframeViewer" type="text/html">
<div class="well fc-resource-preview-well">
    <iframe class="fc-resource-preview" data-bind="attr: {src: selectedDocumentFrameUrl}">
        <p>Your browser does not support iframes <i class="fa fa-frown-o"></i>.</p>
    </iframe>
</div>
</script>

<script id="xssViewer" type="text/html">
<div class="well fc-resource-preview-well" data-bind="html: selectedDocument().embeddedVideo"></div>
</script>

<script id="noPreviewViewer" type="text/html">
    <div class="well fc-resource-preview-well">
        <p>There is no preview available for this file.</p>
    </div>
</script>

<script id="noViewer" type="text/html">
    <div class="well fc-resource-preview-well">
        <p>Select a document to preview it here.</p>
    </div>
</script>

<g:render template="documentTemplate"></g:render>
<r:script>

    $(window).load(function () {

        var options = {
            imageLocation:"${resource(dir:'/images', plugin: 'document-preview-plugin')}",
            pdfgenUrl: "${createLink(controller: 'preview', action: 'pdfUrl')}",
            pdfViewer: "${createLink(controller: 'preview', action: 'viewer')}",
            imgViewer: "${createLink(controller: 'preview', action: 'imageviewer')}",
            audioViewer: "${createLink(controller: 'preview', action: 'audioviewer')}",
            videoViewer: "${createLink(controller: 'preview', action: 'videoviewer')}",
            errorViewer: "${createLink(controller: 'preview', action: 'error')}",
            documentUpdateUrl: "${createLink(controller:"resource", action:"documentUpdate")}",
            documentDeleteUrl: "${g.createLink(controller:"resource", action:"deleteDocument")}",
            admin: ${admin || false}
        }

        var documents = JSON.parse('${documents.toString()}');
        var docListViewModel = new DocListViewModel(documents || [], options);
        ko.applyBindings(docListViewModel, document.getElementById('resourceList'));

    });

</r:script>