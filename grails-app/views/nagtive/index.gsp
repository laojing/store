<!doctype html>
<html>
    <head> 
		<meta name="layout" content="main"/> 
	</head>
    <body>
	<asset:javascript src="nagtive.js"/>

	<div class="mainpage container">

	<g:if test="${nags.size() == 0}">
		<br/> <br/> <br/>
		<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<button type="button" onclick="InitNagtive();" class="btn btn-primary btn-block">初始化</button>
		</div>
		<br/> <br/> <br/>
		<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<h2 id="status" style="text-align:center;"></h2>
		</div>
		</div>
	</g:if>
	<g:set var="curclass" value=""/>
	<g:if test="${nags.size() > 0}">
		<br/>
		<div class="row">
		<g:each var="item" status="index" in="${nags}">
			<g:if test="${index == 0 || curclass != item.classname}">
			<div class="col-md-12">
			<div class="panel panel-default">
				<div class="panel-heading">${item.classname[2..-1]}</div>
				<div class="panel-body">
					<g:each var="nagitem" status="nagindex" in="${nags}">
					<g:if test="${item.classname == nagitem.classname}">
						<div style="margin:5px 0;border:1px dotted #ccc;" class="col-xs-6 col-md-3 col-lg-2">
						<a role="button" href="${nagitem.urlpath}" class="btn btn-link">${nagitem.title}</a>
						</div>
					</g:if>
					</g:each>
				</div>
			</div>
			</div>
			<g:set var="curclass" value="${item.classname}"/>
			</g:if>
		</g:each>
		</div>
	</g:if>

	</div>
<script>

var total = 0;
var cur = 0;
function InitNagtive() {
	total = nagtives.length;
	cur = 0;
	$('#status').html('初始化开始...');
	for ( var i=0; i<total; i++ ) {
		newUrl( nagtives[i] );
	}
}

function newUrl ( nags ) {
	$.getJSON("${createLink(controller='nagtive',action:'newurl')}", 
	{classname:nags[0],
	title:nags[2],
	urlpath:nags[1]},
	function(data) {
		if ( ++cur >= total ) {
			newLib();
		} else {
			$('#status').html( cur+'/'+total );
		}
	});
}

function newLib () {
	$.getJSON("${createLink(controller='nagtive',action:'newlib')}", 
	function(data) {
		$('#status').html( '初始化完成' );
	});
}

</script>
    </body>
</html>
