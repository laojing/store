<!doctype html>
<html>
    <head> 
		<meta name="layout" content="main"/> 
	</head>
    <body>


	<div class="mainpage container">
	<div id="homesize" hidden>${homes.size()}</div>
	<div class="row">
		<div style="margin:10px;" class="col-xs-4 col-md-3 col-lg-2">
			<button type="button" onclick="CloseAll();" class="btn btn-default">全关闭</button>
		</div>
		<div style="margin:10px;" class="col-xs-4 col-md-3 col-lg-2">
			<button type="button" onclick="OpenAll();" class="btn btn-default">全打开</button>
		</div>
	<g:each var="home" in="${homes}">
		<div style="margin:10px;" class="col-xs-4 col-md-3 col-lg-2">
		<g:if test="${home.state==0}">
			<button type="button" onclick="ChangeLight(${home.nameid});" id="btn${home.nameid}" class="btn btn-default"></button>
		</g:if>
		<g:if test="${home.state==1}">
			<button type="button" onclick="ChangeLight(${home.nameid});" id="btn${home.nameid}" class="btn btn-primary"></button>
		</g:if>
		</div>
	</g:each>
	</div>

	</div>

	<script>
var LightNames = [
"Live","客厅灯",
"Sofa","沙发灯",
"Bars","吧台灯",
"Door","入门灯",
"Wall","门前灯",
"Hall","门厅灯",
"Atmo","过渡灯",
"Rest","餐厅灯",
"Pass","走廊灯",
"Kich","厨房灯",
"Toil","次卫灯",
"Bath","主卫灯",
"Book","书房灯",
"Coat","衣帽灯",
"Main","主卧灯",
"Secd","次卧灯",
"Suns","阳台灯" ];

var homechange = "${createLink(controller:'index',action:'homechange')}";
var homeclose = "${createLink(controller:'index',action:'homeclose')}";
var homeopen = "${createLink(controller:'index',action:'homeopen')}";
function ChangeLight ( nameid ) {
	$.getJSON(homechange,{nameid:nameid},function(data) {
	});
}
function CloseAll () {
	$.getJSON(homeclose,function(data) {});
}
function OpenAll () {
	$.getJSON(homeopen,function(data) {});
}
function InitHomes( url ) {
	for ( var i=0; i<LightNames.length/2; i++ ) {
		$.getJSON(url,{index:(i+1),names:LightNames[i*2]},function(data) {
		});
	}
	$.getJSON(url,{index:18,names:'Hman'},function(data) {
	});
}

var homeurl = "${createLink(controller:'index',action:'homenew')}";

var homeupdate = "${createLink(controller:'index',action:'homeupdate')}";
function UpdateOver() {
	$.getJSON(homeupdate,function(data) {
		var len = data.homes.length;
		for ( var i=0; i<len; i++ ) {
			$('#btn'+(i+1)).removeClass ( 'btn-default' );
			$('#btn'+(i+1)).removeClass ( 'btn-primary' );
			if ( data.homes[i].state == 1 ) {
				$('#btn'+(i+1)).addClass ( 'btn-primary' );
			} else {
				$('#btn'+(i+1)).addClass ( 'btn-default' );
			}
		}
	});
	window.setTimeout ( UpdateOver, 1000 );
}

function Resize() {
	var height = $(window).height();		
	var width = $(window).width();		
}

$(document).ready(function(){
	if ( $('#homesize').html() <= 0 ) {
		InitHomes( homeurl );
	}
	for ( var i=0; i<LightNames.length/2; i++ ) {
		$('#btn'+(i+1)).html ( LightNames[i*2+1] );
	}
	$('#btn18').html ( "激活感应" );
	Resize();
	window.setTimeout ( UpdateOver, 1000 );
});

$(window).resize(function(){
	Resize();
});

	</script>

    </body>
</html>
