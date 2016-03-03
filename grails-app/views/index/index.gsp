<!doctype html>
<html>
    <head> 
		<meta name="layout" content="main"/> 
	</head>
    <body>
    <asset:stylesheet src="index.css"/>



	<div class="mainpage">

<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
  </ol>

  <!-- Wrapper for slides -->
  <div class="carousel-inner" role="listbox">
    <div class="item active">
      <img src="${assetPath(src:'billboard1.jpg')}" alt="...">
    </div>
    <div class="item">
      <img src="${assetPath(src:'billboard2.jpg')}" alt="...">
    </div>
    <div class="item">
      <img src="${assetPath(src:'billboard3.jpg')}" alt="...">
    </div>
  </div>

  <!-- Controls -->
  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>

	<div class="container" style="width:100%;padding:0;">

	<section width="100%" style="padding:15px;">
		<h2 style="font-size: 20px;text-align: center;">杂货</h2>

	<div class="row">
	<g:each var="store" in="${stores}">
		<div class="col-lg-3 col-md-3 col-xs-6">
		<article>
			<h1><a href="${createLink(controller:'store', action:'detail', params:[sutid:store.sutid,contid:1,storetype:1])}">${store.title}</a></h1>
			<h2>${store.author}&nbsp;&nbsp;-&nbsp;&nbsp;<a href="${createLink(controller:'store', action:'detail', params:[sutid:store.sutid,contid:1,storetype:1])}">${store.storeclass}</a>&nbsp;&nbsp;-&nbsp;&nbsp;${store.createdate}</h2>
			<p class="storep">${store.cont}</p>
		</article>
		</div>
	</g:each>
	</div>
	</section><!-- End services -->








	<section width="100%" style="background-color:#ddd;padding:15px;">
		<h2 style="font-size: 20px;text-align: center;">项目</h2>
	<div class="row">
		<g:each var="store" in="${projects}">
	<div class="col-lg-3 col-md-3 col-xs-6">
		<div class="prjover thumbnail">
			<a href="${createLink(controller:'project', action:'detail', params:[sutid:store.sutid,contid:1,storetype:1])}">
			<img src="data:image/jpg;base64,${store.img}"/>
			</a>
			<div class="caption">
				<h1>${store.title}</h1>
				<h2>${store.author}&nbsp;&nbsp;-&nbsp;&nbsp;${store.storeclass}&nbsp;&nbsp;-&nbsp;&nbsp;${store.createdate}</h2>
				<p style="height:80px;">${store.cont}</p>
			</div>
		</div>
	</div>
		</g:each>
	</div>
	</section><!-- End services -->

	<div class="seperatorindex"></div>

	<section class="course" style="padding:15px;">
	<h3>主要课程</h3>
	<div class="row">
	<div class="col-lg-6 col-md-6 col-xs-12">
		<a href="${createLink([action:'c',controller:'course'])}">
		<img src="${assetPath(src: 'c_logo.png')}" alt=""/> </a>
		<h2>C语言程序设计</h2>
		<p>使学生熟悉C语言程序设计的基本方法和理论，熟练掌握C语言的语法，并使学生具有很强的阅读、分析程序能力和程序开发设计能力，为开发大型应用程序和其它后续语言课程的学习打下良好的基础。</p>
	</div>
	<div class="col-lg-6 col-md-6 col-xs-12">
		<a href="${createLink([action:'matlab',controller:'course'])}">
		<img class="avatar" src="${assetPath(src: 'matlab_logo.png')}" alt=""/> </a>
		<h2>MATLAB与风力发电系统仿真</h2>
		<p>介绍了MATLAB基本操作指令、数据类型及图形的绘制功能以及数值计算和符号计算功能。同时还介绍了MATLAB的编程方法，提高学生的分析问题和仿真系统的能力，拓展思路并为进一步深入学习提供必要的分析工具。</p>
	</div>
	</div>
	</section><!-- End testimonials -->


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
