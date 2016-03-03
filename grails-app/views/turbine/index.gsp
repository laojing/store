<!doctype html>
<html>
	<head>
		<meta name="layout" content="main"/> 
	</head>
	<body>
	<asset:javascript src="sprintf.js"/>
	<asset:javascript src="curve.js"/>
	<asset:javascript src="three.js"/>
	<asset:javascript src="OrbitControls.js"/>
	<asset:javascript src="OBJLoader.js"/>
	<asset:javascript src="turbine.js"/>
	<asset:javascript src="winddir.js"/>
	<asset:javascript src="turbdata.js"/>
	<asset:javascript src="turbctl.js"/>

	<div class="mainpage container-fluid">
<div class="row" style="margin-top:20px;">

<div class="col-xs-12 col-sm-6 col-lg-6">
<div class="panel panel-default">
	<div class="panel-heading">3D风机</div>
	<div class="panel-body">
		<div id="threecanvas"></div>
	</div>
</div>
</div>

<div class="col-xs-12 col-sm-6 col-lg-6">
<div id="inputctl" class="panel panel-default">
	<div class="panel-heading">输入控制</div>
	<div class="panel-body">
	<canvas id="winddir"></canvas>
<form class="form-horizontal">
  <div style="padding:0 15px;" class="form-group form-group-sm">
	<input type="range" id="trackbar" onchange="WindSet();" min="1" max="30" step="0.5" value="10"/>
  </div>
  <div class="form-group">
    <label class="col-sm-3 control-label" for="windset">恒定风速：</label>
    <div class="col-sm-3">
      <input class="form-control" type="text" id="windset" value="10" readonly>
    </div>
    <label class="col-sm-3 control-label" for="windreal">扰动风速：</label>
    <div class="col-sm-3">
      <input class="form-control" type="text" id="windreal" readonly>
    </div>
  </div>
  <div style="padding:0;" class="form-group form-group-sm">
    <div class="col-sm-6">
		<input onclick="StartTurb();" class="btn btn-default btn-block" type="button" value="启动">
	</div>
    <div class="col-sm-6">
		<input onclick="StopTurb();" class="btn btn-default btn-block" type="button" value="停止">
	</div>
  </div>
</form>

	</div>
</div>
</div>

<div class="col-xs-12 col-sm-6 col-lg-6">
<div class="panel panel-default">
	<div class="panel-heading">运行曲线</div>
	<div class="panel-body">
		<canvas id="operation"></canvas>
	</div>
</div>
</div>

</div>
	</div>
	<script>

var turbstart = false;
function StartTurb() {
	turbstart = true;
}

function StopTurb() {
	turbstart = false;
}

function WindSet() {
	$('#windset').val($('#trackbar').val());	
	$('#windreal').val(Math.sin($('#trackbar').val()));	
}

function Resize() {
	var height = $(window).height();		
	var width = $(window).width();
	if ( width < 768 ) {
		$('#threecanvas').height( 0.8*width );
		$('#threecanvas').width( 0.6*width );
		$('#threecanvas').css( "margin-left", 0.2*width+"px" );
	} else {
		$('#threecanvas').css( "margin-left", "0px" );
		$('#threecanvas').width( $('#threecanvas').parent().width() );
		$('#threecanvas').height( height - 160 );
	}
	DrawWindDir( false );
	DrawOperation( false );
}

$(document).ready(function(){
	$('footer').hide();
	Resize();
	turbine3d("${assetPath(src: 'turbine')}");
	turbctl();
});

$(window).resize(function(){
	Resize();
	ResizeTurb();
});

	</script>
	</body>
</html>
