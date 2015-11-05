<div class="span4 homePageNav">
    <button class="well nav-well text-center" data-href="${href}">
        <g:if test="${browseBy}"><h4>Browse by</h4></g:if>
        <h3 class="${(label.size() > 12) ? 'condensed' : ''}">${label}</h3>
    </button>
</div><!-- end .span4 -->