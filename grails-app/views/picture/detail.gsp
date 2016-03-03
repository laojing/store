<!doctype html>
<html>
    <head> 
		<meta name="layout" content="main"/> 
	</head>
    <body>

	<div class="mainpage container">

	<div class="row">
		<div class="col-sx-12 col-md-12 col-lg-12">
		<div class="thumbnail">
			<img id="detail" onclick="NextPic();" src=""/>
			<div class="caption">
			<h2><span id="caption"></span></h2>
			<span id="width"></span>-
			<span id="height"></span>-
			<span id="space"></span>
			<button type="button" id="btnauto" onclick="ChangeAuto();" style="margin-left:10px;float:right;" class="btn btn-default btn-xs">幻灯片</button>
			<button type="button" id="btnreverse" onclick="ChangeReverse();" style="margin-left:10px; float:right;" class="btn btn-default btn-xs">逆序</button>
			<button type="button" id="btnreverse" onclick="DeletePic();" style="float:right;" class="btn btn-default btn-xs">删除</button>
			</div>
		</div>
		</div>
	</div>

	</div>

	<script>
var picurl = "${createLink(controller:'picture',action:'pic')}";
var picjson = "${createLink(controller:'picture',action:'detailjson')}";
var picdel = "${createLink(controller:'picture',action:'detaildel')}";
var sutid = "${sutid}";
var contid = ${contid}-1;
var total = ${total};
var bauto = false;
var breverse = false;
function ChangeAuto() {
	bauto = !bauto;
	if ( bauto ) {
		$('#btnauto').removeClass('btn-default');
		$('#btnauto').addClass('btn-primary');
		$('footer').hide();
		$('nav').hide();
		$('.mainpage').css('margin-top', '0px');
		//$('body').css('background','black');
		Resize();
		NextPic();
	} else {
		$('#btnauto').removeClass('btn-primary');
		$('#btnauto').addClass('btn-default');
		$('footer').show();
		$('nav').show();
		$('.mainpage').css('margin-top', '50px');
		//$('body').css('background','url("../images/bg.jpg")');
		Resize();
	}
}

function ChangeReverse() {
	breverse = !breverse;
	if ( breverse ) {
		$('#btnreverse').removeClass('btn-default');
		$('#btnreverse').addClass('btn-primary');
	} else {
		$('#btnreverse').removeClass('btn-primary');
		$('#btnreverse').addClass('btn-default');
	}
}

function DeletePic() {
	$.getJSON(picdel,{sutid:sutid,contid:contid,total:total},function(data) {
		total--;
		NextPic();
	});
}

var img;
var imgwidth = 0;
var imgheight = 0;
function NextPic() {
	if ( breverse ) {
		if ( --contid < 1 ) contid = total;
	} else {
		if ( ++contid > total ) contid = 1;
	}

	img = new Image();
	img.onload = function() {
		$.getJSON(picjson,{sutid:sutid,contid:contid},function(data) {
			imgwidth = data.detail.width;
			imgheight = data.detail.height;
			$('#detail').fadeOut(500,function(){

				$('#caption').html( data.detail.caption );
				$('#width').html( data.detail.width );
				$('#height').html( data.detail.height );


				Resize();
				$('#detail').attr("src", picurl+'?sutid='+sutid+'&contid='+(contid) );
				$('#detail').fadeIn(1000);

				if ( data.detail.duration > 0.001 ) {
					$('#space').html( data.detail.space + '-' + data.detail.duration + '-' + contid + '/' + total );
					if ( bauto ) setTimeout ( NextPic, (data.detail.duration+1)*1000 );
				} else {
					$('#space').html( data.detail.space + '-' + contid + '/' + total );
					if ( bauto ) setTimeout ( NextPic, 3000 );
				}

			});
		});
	};
	img.src = picurl+'?sutid='+sutid+'&contid='+(contid);
}

function Resize() {
	var height = $(window).height() - 101;
	var width = $(window).width()-30;
	if ( bauto ) height += 100;

	var oldheight = $('.caption').height() + 28 + 1.0*imgheight*(width-10)/imgwidth;

	if ( oldheight <= height ) {
		$('.thumbnail').css('margin-left', '0px');
		$('.thumbnail').css('margin-top', (height-oldheight)/2+'px');
		$('.thumbnail').css('margin-bottom', (height-oldheight)/2+'px');
		$('#detail').width( width-10 );
		$('#detail').height( 1.0*imgheight*(width-10)/imgwidth );
		$('.thumbnail').width( width );
		$('.thumbnail').height( oldheight-10 );
	} else {
		var curimgheight = height - 58 - $('.caption').height();
		var curimgwidth = 1.0*imgwidth*(curimgheight/imgheight);
		$('#detail').width( curimgwidth );
		$('#detail').height( curimgheight );
		$('.thumbnail').width( curimgwidth + 10 );
		$('.thumbnail').height( height - 40 );

		$('.thumbnail').css('margin-left', (width-curimgwidth-10)/2+'px');
		$('.thumbnail').css('margin-top', '15px');
		$('.thumbnail').css('margin-bottom', '15px');
	}
	$('footer').css('margin-top', '0px');
}

$(document).ready(function(){
	NextPic();
});
$(window).resize(function(){
	Resize();
});
	</script>

    </body>
</html>
