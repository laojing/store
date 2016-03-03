<!doctype html>
<html>
    <head> 
		<meta name="layout" content="main"/> 
	</head>
    <body>
    <asset:stylesheet src="detail.css"/>

	<div class="mainpage container">

	<g:if test="${conts.size()>1}">
	<p class="title">项目 >> ${store.title}</p>
	</g:if>
	<g:if test="${conts.size()==1}">
	<h1>${store.title}</h1>
	</g:if>
	<div class="seperatorindex"></div>

	<div class="maincont">
		${txt}
	</div>

	<g:if test="${conts.size()>1}">
	<nav>
	<ul class="pagination">

	<g:each var="cont" status="index" in="${conts}">

	<g:if test="${index==0}">
	<g:if test="${contid>1}">
	<li><a href="${createLink(controller:'project', action:'detail', params:[sutid:cont.sutid,contid:contid-1,storetype:storetype])}">
	<span aria-hidden="true">&laquo;</span></a></li>
	</g:if>
	</g:if>


	<g:if test="${contid!=cont.contid}">
	<li><a href="${createLink(controller:'project', action:'detail', params:[sutid:cont.sutid,contid:cont.contid,storetype:storetype])}">
	${cont.title}</a></li>
	</g:if>
	<g:if test="${contid==cont.contid}">
	<li class="active"><span>${cont.title}</span></li>
	</g:if>

	<g:if test="${index==conts.size()-1}">
	<g:if test="${contid<conts.size()}">
	<li><a href="${createLink(controller:'project', action:'detail', params:[sutid:cont.sutid,contid:contid+1,storetype:storetype])}">
	<span aria-hidden="true">&raquo;</span></a></li>
	</g:if>
	</g:if>

	</g:each>
	</ul>
	<nav>
	</g:if>

	</div>

	<script>

function Resize() {
	var height = $(window).height();		
	var width = $(window).width();		
}

$(document).ready(function(){
	Resize();
	$('.maincont').html(decodeHTML($('.maincont').html()));
});

$(window).resize(function(){
	Resize();
});
	</script>

    </body>
</html>

