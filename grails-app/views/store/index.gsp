<!doctype html>
<html>
    <head> 
		<meta name="layout" content="main"/> 
	</head>
    <body>

	<div class="mainpage container">

	<h1>一些杂货</h1>
	<div class="input-group">
	    <span class="input-group-addon glyphicon glyphicon-gift"></span>
		<select class="form-control" id="classes" onchange="ChangeClass();">
		<g:each var="item" status="index" in="${classes}">
		  <g:if test="${index==clas}">
		  <option selected value="${index}">${item}</option>
		  </g:if>
		  <g:if test="${index!=clas}">
		  <option value="${index}">${item}</option>
		  </g:if>
		</g:each>
		</select>
	    <span class="input-group-addon glyphicon glyphicon-gift"></span>
  	</div>
	<div class="seperator"></div>

	<div class="row">
	<g:each var="store" in="${stores}">
		<div class="col-sx-12 col-md-6 col-lg-3 store">
		<article>
			<h1><a href="${createLink(controller:'store', action:'detail', params:[sutid:store.sutid,contid:1,storetype:1])}">${store.title}</a></h1>
			<h2>${store.author}&nbsp;&nbsp;-&nbsp;&nbsp;<a href="${createLink(controller:'store', action:'detail', params:[sutid:store.sutid,contid:1,storetype:1])}">${store.storeclass}</a>&nbsp;&nbsp;-&nbsp;&nbsp;${store.createdate}</h2>
			<p>${store.cont}</p>
		</article>
		</div>
	</g:each>
	</div>

	</div>

	<script>
function ChangeClass () {
	window.location.href = window.location.pathname + '?classes=' + $('#classes').val();
}

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
