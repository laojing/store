var winddata = new Array();
function DrawOperation( isdata ) {
	var width = $(window).width()-50;
	var height = width/2;
	if ( width > 768 ) {
		width = $('#operation').parent().width();
		height = $(window).height() - $('#inputctl').height() - 187;
	}
	var can = document.getElementById ( 'operation' );
	can.width = width;
	can.height = height;
	var context = can.getContext ( '2d' );

	drawBackground ( context, width, height, 20, 25, 55, 20, 3, 6, 0.1, '#666666' );
	drawYLabel ( context, width, height, 20, 25, 0, 55, 35, 3, 5, "%.0f", 0.8, '#0000fff', 0, 30, '风速(rpm)' );
	drawXLabel ( context, width, height, 20, 25, 55, 20, 3, 4, "%.0f", 0.8, '#666666', new Date()-600000, new Date(), '', 2 );
	if ( winddata.length > 0 ) {
		var end = winddata[winddata.length-1].x;
		//drawLine ( context, width, height, 20, 25, 55, 20, 2, '#0000ff', end-600, end, 0, 30, winddata );
	var Left = 55;
	var Right = 20;
	var Top = 20;
	var Bottom = 25;
	var LineWidth = 2;
	var LineColor = '#0000ff';
	var XMin = end - 600;
	var XMax = end;
	var YMin = 0;
	var YMax = 30;
	var Data = winddata;
	context.save();
	context.beginPath();
	var span = ( width - Left - Right ) / (Data.length-1);
	//alert ( Left + ((Data[0].x-XMin)/(XMax-XMin))*(width-Left-Right) );
	context.moveTo ( 
					Left + ((Data[0].x-XMin)/(XMax-XMin))*(width-Left-Right),
					Top + (1-(Data[0].y-YMin)/(YMax-YMin))*(height-Top-Bottom) );
	for ( var i=1; i<Data.length; i++ ) {
		context.lineTo (
						Left + ((Data[i].x-XMin)/(XMax-XMin))*(width-Left-Right),
						Top + (1-(Data[i].y-YMin)/(YMax-YMin))*(height-Top-Bottom) );
	}

	context.lineWidth = LineWidth;
	context.strokeStyle = LineColor;
	context.stroke();
	context.restore();
	}
}

var windindex = 0;
function turbctl() {
	$('#windreal').val ( $('#windset').val()-10+wind[windindex++] );
	if ( windindex >= windlen ) windindex = 0;

	if ( winddata.length >= 600 ) winddata.shift ();
	winddata.push ( {x:Math.floor(new Date().getTime()/1000),y:$('#windreal').val()} );
	DrawOperation ( true );
	setTimeout ( turbctl, 500 );
}
