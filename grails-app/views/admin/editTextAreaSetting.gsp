<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>MDBA | Admin | Edit Text</title>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <r:require modules="wmd" />
    <r:script>
        $(document).ready(function (e) {
            setup_wmd({
                output_format: "markdown",
                input: "textValue",
                output: "copy_html",
                button_bar: "notes-button-bar",
                preview: "notes-preview",
                helpLink: "${request.contextPath}/static/vendor/wmd/markdownhelp.html"
            });
        });
    </r:script>
</head>
<body data-offset="70" data-target="#page-nav" data-spy="scroll">
<h2>${params.editMode?.toBoolean() ? 'Edit ' + settingKey : settingKey}</h2>
<div class="inner row-fluid">
    <div class="row-fluid">
        <div class="span12" id="">
            <a href="${returnUrl}" class="btn"><i class="icon-hand-left"></i> back to ${returnLabel}</a>
            <g:if test="${params.editMode?.toBoolean()}">
                <g:form id="saveSettingContent" controller="admin" action="saveTextAreaSetting">
                    <g:set var="spanN" value="${ajax ? 'span12' : 'span10'}"/>
                    <g:hiddenField name="settingKey" value="${settingKey}" />
                    <g:hiddenField name="returnUrl" value="${returnUrl}" />
                    <div class="row-fluid">
                        <div class="${spanN}">
                            <div class="row-fluid" id="notes-button-bar" style="width:100%;background-color: white;"></div>
                            <div class="row-fluid" style="padding-right:12px;">
                                <g:textArea name="textValue" id="textValue" value="${textValue?:''.trim()}" rows="${!ajax ? 16 : 8}"
                                            cols="120" style="width:100%;margin:0;"></g:textArea>
                            </div>
                            <h4>Preview:</h4>
                            <div id="notes-preview" class="well well-small"></div>
                            <div class="hide"><input type="text" name="copy_html" value="" id="copy_html" class="hide"></div>
                        </div>
                    </div>
                    <g:if test="${!ajax}">
                        <div class="row-fluid">
                            <a class="btn" href="${returnUrl}">Cancel</a>
                            <button class="btn btn-primary">Save</button>
                        </div>
                    </g:if>
                    <g:else>
                    </g:else>
                </g:form>
            </g:if>
            <g:else>
                <h1>${settingTitle}<span>&nbsp;&nbsp;<a href="?editMode=true" class="btn btn-small">
                    <i class="icon-edit"></i>&nbsp;Edit
                </a></span></h1>
                <div class="well well-small">
                    <div>${textValue?:''.trim()}</div>
                </div>
            </g:else>
        </div>
    </div>
</div>
</div>
<div style="margin: 200px 0;">&nbsp;</div>
</body>
</html>