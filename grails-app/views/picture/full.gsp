<!doctype html>
<html>
    <head> 
		<meta name="layout" content="main"/> 
	</head>
    <body>
	<img id="detail" onclick="NextPic();" src=""/>
	<script>
var picurl = "${createLink(controller:'picture',action:'pic')}";
var picjson = "${createLink(controller:'picture',action:'detailjson')}";
var picdel = "${createLink(controller:'picture',action:'detaildel')}";
var sutid = "${sutid}";
var contid = ${contid}-1;
var total = ${total};

var img;
var imgwidth = 0;
var imgheight = 0;
function NextPic() {
	if ( ++contid > total ) contid = 1;
	img = new Image();
	img.onload = function() {
		$.getJSON(picjson,{sutid:sutid,contid:contid},function(data) {
			imgwidth = data.detail.width;
			imgheight = data.detail.height;
			$('#detail').fadeOut(500,function(){
				Resize();
				$('#detail').attr("src", picurl+'?sutid='+sutid+'&contid='+(contid) );
				$('#detail').fadeIn(1000);
				if ( data.detail.duration > 0.001 ) {
					setTimeout ( NextPic, (data.detail.duration+1)*1000 );
				} else {
					setTimeout ( NextPic, 5000 );
				}
			});
		});
	};
	img.src = picurl+'?sutid='+sutid+'&contid='+(contid);
}

function Resize() {
	var height = $(window).height();
	var width = $(window).width();

	var oldheight = 1.0*imgheight*width/imgwidth;

	if ( oldheight <= height ) {
		$('#detail').css('margin-left', '0px');
		$('#detail').css('margin-top', (height-oldheight)/2+'px');
		$('#detail').width( width );
		$('#detail').height( 1.0*imgheight*(width-10)/imgwidth );
	} else {
		var curimgheight = height;
		var curimgwidth = 1.0*imgwidth*(curimgheight/imgheight);
		$('#detail').css('margin-left', (width-curimgwidth)/2+'px');
		$('#detail').css('margin-top', '0px');
		$('#detail').width( curimgwidth );
		$('#detail').height( curimgheight );
	}
}

$(document).ready(function(){
/*
	var can = document.getElementById ( 'detail' );
	can.addEventListener ( 'mousedown', MouseDownCanvas, true );
	can.addEventListener ( 'touchstart', MouseDownTouch, false );
	*/
	$('footer').hide();
	$('nav').hide();
	NextPic();
});

$(window).resize(function(){
	Resize();
});
function MouseDownTouch(ev) {
	if ( document.mozFullScreen ) {
		document.mozCancelFullScreen();
	} else {
		document.getElementById("detail").mozRequestFullScreen();
	}
}
function MouseDownCanvas(ev) {
	if ( document.mozFullScreen ) {
		document.mozCancelFullScreen();
	} else {
		document.getElementById("detail").mozRequestFullScreen();
	}
}
	</script>
    </body>
</html>
