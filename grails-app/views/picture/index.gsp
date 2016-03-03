<!doctype html>
<html>
    <head> 
		<meta name="layout" content="main"/> 
	</head>
    <body>

	<div class="mainpage container">

	<h1>一些图片</h1>
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
		<div class="col-xs-4 col-md-3 col-lg-2">
		<div class="thumbnail">
			<a href="${createLink(controller:'picture', action:'gallery', params:[sutid:store.sutid])}">
			<img src="${createLink(controller:'picture',action:'thumbpic',params:[sutid:store.sutid])}"/>
			</a>
			<div class="caption">
			<h2><a href="${createLink(controller:'picture', action:'gallery', params:[sutid:store.sutid])}">${store.title}</a></h2>
			<h3>${store.author}&nbsp;&nbsp;-&nbsp;&nbsp;
			${store.total}张
			&nbsp;&nbsp;-&nbsp;&nbsp;${store.createdate}</h3>
			</div>
		</div>
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
