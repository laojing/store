<!doctype html>
<html>
    <head> 
		<meta name="layout" content="main"/> 
	</head>
    <body>

	<div class="mainpage container">

	<h1>一些项目</h1>

	<div class="row">
	<g:each var="store" in="${stores}">
		<div class="col-xs-6 col-md-6 col-lg-3 store">
		<div class="prjover thumbnail">
			<a href="${createLink(controller:'project', action:'detail', params:[sutid:store.sutid,contid:1,storetype:1])}">
			<img src="data:image/jpg;base64,${store.img}"/>
			</a>
			<div class="caption">
				<h1>${store.title}</h1>
				<h2>${store.author}&nbsp;&nbsp;-&nbsp;&nbsp;${store.storeclass}&nbsp;&nbsp;-&nbsp;&nbsp;${store.createdate}</h2>
				<p>${store.cont}</p>
			</div>
		</div>
		</div>
	</g:each>
	</div>

	</div>

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
