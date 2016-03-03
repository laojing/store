
function drawText ( context, value, rad, radius, x, y, span ) {
	context.save();
	var len = context.measureText(value.toString());
	var x1 = (radius) * Math.cos(rad);
	var y1 = (radius) * Math.sin(rad);
	context.translate ( x, y );
	context.rotate ( rad + Math.PI/2 );
	context.fillText ( value.toString(), -len.width/2, -span-radius );
	context.restore();
}

function drawLine ( context, rad, radius1, radius2, x, y ) {
	var x1 = x + radius1 * Math.cos(rad);
	var y1 = y + radius1 * Math.sin(rad);
	var x2 = x + radius2 * Math.cos(rad);
	var y2 = y + radius2 * Math.sin(rad);
	context.moveTo ( x1, y1 );
	context.lineTo ( x2, y2 );
}

var dirrose = ['东','东南','南','西南', '西','西北','北','东北'];
var winddir = 0.0;

function DrawWindDir ( isdown ) {

	var width = $(window).width();
	var height = width/2;
	if ( width > 768 ) {
		height = $(window).height()/4;
		width = $('#winddir').parent().width();
	}
	var can = document.getElementById ( 'winddir' );
	can.addEventListener ( 'mousedown', MouseDownCanvas, false );
	can.addEventListener ( 'mousemove', MouseMoveCanvas, false );
	can.addEventListener ( 'mouseup', MouseUpCanvas, false );

	can.width = width;
	can.height = height;
	var context = can.getContext ( '2d' );

	var radius = width/2;
	if ( height < width ) radius = height/2;
	radius -= 30;
	context.lineWidth = 1;
	var start = 0;
	var end = Math.PI*2;

	context.beginPath(); 
	context.strokeStyle = "#ddd";
	context.fillStyle = "#666"; 
	context.arc ( width/2, height/2, radius, 0, Math.PI*2, true); 
	context.arc ( width/2, height/2, radius*4/5, 0, Math.PI*2, true); 
	context.closePath(); 
	context.strokeStyle = "#ddd";
	context.stroke();

	context.font = "10px 'LiHei Pro'";
	for ( var i=0; i<8; i++ ) {
		context.beginPath(); 
		context.fillStyle = "#666"; 
		var r = i*(Math.PI*2)/8;
		drawLine ( context, r, radius, radius*3/5, width/2, height/2 );
		drawText ( context, dirrose[i], r, radius, width/2, height/2, 15 );
		context.closePath(); 
		context.stroke();
		context.strokeStyle = "#ddd";
	}

	var path = new Path2D();
	var x1 = width/2 + radius * Math.cos(winddir - Math.PI/2);
	var y1 = height/2 + radius * Math.sin(winddir - Math.PI/2);
	if ( isdown ) {
		path.arc ( x1, y1, 6, 0, Math.PI*2 );
	} else {
		path.arc ( x1, y1, 4, 0, Math.PI*2 );
	}
	context.fillStyle = "#a00";
	context.fill( path );
	context.font = "12px serif";
	var lab = sprintf ( "%03d°", winddir*180/Math.PI );
	context.fillText ( lab, width/2-10, height/2+5 );
}

 
function wrap2pi ( angle ) {
	while ( angle > Math.PI ) angle = angle - 2*Math.PI;
	while ( angle < -Math.PI ) angle = angle + 2*Math.PI;
	return angle;
}

var isPress = false;
function MouseDownCanvas(ev) {
	var canvas = ev.target;
	var legendx = ev.pageX - $('#winddir').offset().left;
	var legendy = ev.pageY - $('#winddir').offset().top;
	var temp = Math.PI - Math.atan2 ( legendx - canvas.width/2, 
			legendy - canvas.height/2 );

	if ( Math.abs(temp-winddir)%(Math.PI*2) < 0.3 ) {
		winddir = temp;
		isPress = true;
		DrawWindDir ( true );
	}
}

function MouseMoveCanvas(ev) {
	if ( isPress ) {
		var canvas = ev.target;
		var legendx = ev.pageX - $('#winddir').offset().left;
		var legendy = ev.pageY - $('#winddir').offset().top;
		winddir = Math.PI - Math.atan2 ( legendx - canvas.width/2, 
				legendy - canvas.height/2 );
		DrawWindDir ( true );
	}
}

function MouseUpCanvas(ev) {
	isPress = false;
	DrawWindDir ( false );
}

