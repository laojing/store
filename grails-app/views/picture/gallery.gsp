<!doctype html>
<html>
    <head> 
		<meta name="layout" content="main"/> 
	</head>
    <body>

	<div class="mainpage container">

	<h1>${curstore.title}</h1>

	<div class="seperator"></div>

	<div class="row">
	<g:each var="store" in="${stores}">
		<div class="col-xs-4 col-md-3 col-lg-2">
		<div class="thumbnail">
			<a href="${createLink(controller:'picture', action:'detail', params:[sutid:store.sutid,contid:store.contid])}">
			<img src="${createLink(controller:'picture',action:'thumb',params:[sutid:store.sutid,contid:store.contid])}"/>
			</a>
			<div class="caption">
			<h2><a href="${createLink(controller:'picture', action:'full', params:[sutid:store.sutid,contid:store.contid])}">${store.caption}</a></h2>
			<h3>${store.width}&nbsp;&nbsp;-&nbsp;&nbsp;
			${store.height}
			&nbsp;&nbsp;-&nbsp;&nbsp;${store.space}
			&nbsp;&nbsp;-&nbsp;&nbsp;${store.contid}
			</h3>
			</div>
		</div>
		</div>
	</g:each>
	</div>

	</div>

	<g:if test="${total>12}">
	<nav>
	<ul class="pagination">
	<g:set var="counter" value="${0}"/>
	<g:while test="${counter<total}">
		<g:if test="${counter==(offset as int)}">
			<li class="active"><span>第${counter/12+1}页</span></li>
		</g:if>
		<g:else>
		<li><a href="${createLink(controller:'picture', action:'gallery', params:[sutid:curstore.sutid,offset:counter])}">
		第${counter/12+1}页</a></li>
		</g:else>
		<g:set var="counter" value="${counter+12}"/>
	</g:while>
	</ul>
	</nav>
	</g:if>

	<script>
function Resize() {
	var height = $(window).height();		
	var width = $(window).width();		
}
$(document).ready(function(){
	Resize();
});

$(window).resize(function(){
	Resize();
});
	</script>

    </body>
</html>
