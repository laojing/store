<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>老井</title>
        <asset:stylesheet src="bootstrap.min.css"/>
        <asset:stylesheet src="application.css"/>
		<asset:javascript src="jquery-1.11.3.js"/>
		<asset:javascript src="bootstrap.min.js"/>
		<asset:javascript src="application.js"/>
    </head>
    <body>
    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="${createLink([action:'index',controller:'index'])}" style="margin-top:-5px;"><img src="${assetPath(src:'logo_small.png')}"></a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
			<sec:ifNotLoggedIn>
		  	<li><a href="${createLink([action:'logindex',controller:'index'])}">登录</a></li>
			</sec:ifNotLoggedIn>
			<sec:ifLoggedIn>
		  	<li><a href="${resource(file: 'j_spring_security_logout')}">退出</a></li>
			</sec:ifLoggedIn>

		  <li><a href="${createLink([action:'index',controller:'store'])}">杂货</a></li>
		  <li><a href="${createLink([action:'index',controller:'picture'])}">图片</a></li>
		  <li><a href="${createLink([action:'index',controller:'project'])}">项目</a></li>
		  <li><a href="${createLink([action:'index',controller:'graduation'])}">毕业</a></li>
		  <li class="dropdown">
		  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">课程<span class="caret"></span></a>
			<ul class="dropdown-menu">
		  		<li><a href="${createLink([action:'c',controller:'course'])}">c语言</a></li>
				<li role="separator" class="divider"></li>
		  		<li><a href="${createLink([action:'matlab',controller:'course'])}">MATLAB</a></li>
			</ul>
		  </li>

		  <li><a href="${createLink([action:'index',controller:'nagtive'])}">导航</a></li>

		<sec:ifLoggedIn>
		<li><a class="slidenav" href="${createLink([action:'passwd',controller:'manager'])}">密码</a></li>
		</sec:ifLoggedIn>
		  <sec:ifAllGranted roles="ROLE_ADMIN">
		  <li class="dropdown">
		  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">管理<span class="caret"></span></a>
			<ul class="dropdown-menu">
		  		<li><a href="${createLink([action:'store',controller:'manager'])}">杂货管理</a></li>
				<li role="separator" class="divider"></li>
		  		<li><a href="${createLink([action:'picture',controller:'manager'])}">图片管理</a></li>
				<li role="separator" class="divider"></li>
		  		<li><a href="${createLink([action:'project',controller:'manager'])}">项目管理</a></li>
				<li role="separator" class="divider"></li>
		  		<li><a href="${createLink([action:'user',controller:'manager'])}">用户管理</a></li>
			</ul>
		  </li>
		  </sec:ifAllGranted>
          </ul>
        </div>
      </div>
    </nav>
	<g:layoutBody/>

    <footer class="navbar-fixed-bottom">
		<p>©2015&nbsp;井艳军(mail@jingyanjun.cn)&nbsp;&nbsp;&nbsp;辽ICP备15002351号 </p>
	</footer><!-- End footer -->

<!--
尊敬的用户井艳军 ，您的ICP备案申请已通过审核，备案/许可证编号为：辽ICP备15002351号，
备案密码为：VCN975，审核通过日期：2015-02-10 13:32:27。
请牢记和妥善保管您的备案号、备案密码，备案密码将是以后变更备案信息的重要依据。
工业和信息化部网站备案系统
-->

<script>
function FooterBottom() {
	if ( $(window).height() > $('.mainpage').height() + 120 ) {
		$('footer').addClass('navbar-fixed-bottom');
	} else {
		$('footer').removeClass('navbar-fixed-bottom');
	}
}

$(document).ready(function(){
	FooterBottom();
});
$(window).resize(function(){
	FooterBottom();
});
</script>

    </body>
</html>
