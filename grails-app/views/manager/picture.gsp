<!doctype html>
<html>
    <head> 
		<meta name="layout" content="main"/> 
	</head>
    <body>

	<div class="mainpage container">

	<h1>整理图片</h1>
	<div class="input-group">
	    <span class="input-group-addon glyphicon glyphicon-gift"></span>
		<select class="form-control" id="classes" onchange="ChangeClass();">
		<g:each var="item" status="index" in="${classes}">
		  <g:if test="${index==clas}">
		  <option selected value="${index}">${item}</option>
		  </g:if>
		  <g:if test="${index!=clas}">
		  <option value="${index}">${item}</option>
		  </g:if>
		</g:each>
		</select>
	    <span class="input-group-addon glyphicon glyphicon-gift"></span>
  	</div>
	<div class="seperator"></div>

	<table class="suttable">
	<tr>
		<td> <label> <input type="checkbox" id="selectall" onchange="SelectAll();">&nbsp;&nbsp;&nbsp;&nbsp;选择所有</label> </td>
		<td colspan="4"> <span id="display-0"></span></td>
		<td> <button class="btn btn-default" onclick="UpdateAllStore();" type="button">更新</button> </td>
		<td> <button class="btn btn-default" onclick="DeleteAllStore();" type="button">删除</button> </td>
	</tr>
	<g:each var="store" status="index" in="${stores}">
	<tr>
		<td> <label><input type="checkbox" id="sel${index}" data-type="${store.sutid}">&nbsp;&nbsp;&nbsp;&nbsp;${store.title}</label> </td>
		<td> <span id="display${index}"></span></td>
		<td> <button class="btn btn-default" onclick="RenameStore(${index},'${store.sutid}');" type="button">顺序命名</button> </td>
		<td> <button class="btn btn-default" onclick="HandleStore(${index},'${store.sutid}');" type="button">整理</button> </td>
		<td> <button class="btn btn-default" onclick="ClearStore(${index},'${store.sutid}');" type="button">清除</button> </td>
		<g:set var="isfind" value="0"/>
		<g:each var="storein" in="${storeins}">
		  <g:if test="${storein.sutid==store.sutid}">
		  	<g:set var="isfind" value="1"/>
		  </g:if>
		</g:each>
		<g:if test="${isfind=="0"}">
			<td> <button class="btn btn-default" onclick="UpdateStore(${index},'${store.sutid}');" type="button">添加</button> </td>
		</g:if>
		<g:else>
			<td> <button class="btn btn-default" onclick="UpdateStore(${index},'${store.sutid}');" type="button">更新</button> </td>
		</g:else>
		<td> <button class="btn btn-default" onclick="DeleteStore(${index},'${store.sutid}');" type="button">删除</button> </td>
	</tr>
	</g:each>
	</table>

	</div>

	<script>
function ChangeClass () {
	window.location.href = window.location.pathname + '?classes=' + $('#classes').val();
}

var allindex = 0;
var allcurrent = 0;
function UpdateAllStore () {
	var rowcount = $('.suttable > tbody > tr').length;
	allcurrent = 0;
	allindex = 0;
	for ( var i=0; i<rowcount-1; i++ ) {
		if ( document.getElementById('sel'+i).checked ) {
			allindex++;
			UpdateStore ( i, $('#sel'+i).data('type') );
		}
	}
}

function DeleteAllStore () {
	var rowcount = $('.suttable > tbody > tr').length;
	allcurrent = 0;
	allindex = 0;
	for ( var i=0; i<rowcount-1; i++ ) {
		if ( document.getElementById('sel'+i).checked ) {
			allindex++;
			DeleteStore ( i, $('#sel'+i).data('type') );
		}
	}
}

function UpdateStore ( index, sutid ) {
	$('#display'+index).html('更新....');
	$.getJSON("${createLink(controller='manager', action:'updatepicture')}", {sutid:sutid}, function(data) {
		$('#display'+index).html('更新完成');
		if ( allindex > 0 ) {
			$('#display-0').html((++allcurrent)+'/'+(allindex));
			if ( allcurrent == allindex ) {
				$('#display-0').html('更新完成');
				allindex = 0;
			}
		}
	});
}

function DeleteStore ( index, sutid ) {
	$('#display'+index).html('删除....');
	$.getJSON("${createLink(controller='manager', action:'deletepicture')}", {sutid:sutid}, function(data) {
		$('#display'+index).html('删除完成');
		if ( allindex > 0 ) {
			$('#display-0').html((++allcurrent)+'/'+(allindex));
			if ( allcurrent == allindex ) {
				$('#display-0').html('删除完成');
				allindex = 0;
			}
		}
	});
}

function HandleStore ( index, sutid ) {
	$('#display'+index).html('整理....');
	$.getJSON("${createLink(controller='manager', action:'handlepicture')}", {sutid:sutid}, function(data) {
		if ( data.result ) {
			$('#display'+index).html('整理完成');
		} else {
			$('#display'+index).html('整理有残余');
		}
	});
}

function ClearStore ( index, sutid ) {
	$('#display'+index).html('清除....');
	$.getJSON("${createLink(controller='manager', action:'clearpicture')}", {sutid:sutid}, function(data) {
		if ( data.result ) {
			$('#display'+index).html('清除完成');
		} else {
			$('#display'+index).html('清除有残余');
		}
	});
}
function RenameStore ( index, sutid ) {
	$('#display'+index).html('重命名....');
	$.getJSON("${createLink(controller='manager', action:'renamepicture')}", {sutid:sutid}, function(data) {
		$('#display'+index).html('重命名完成');
	});
}

function SelectAll () {
	var rowcount = $('.suttable > tbody > tr').length;
	for ( var i=0; i<rowcount-1; i++ ) {
		if ( document.getElementById('selectall').checked ) {
			document.getElementById('sel'+i).checked = true;
		} else {
			document.getElementById('sel'+i).checked = false;
		}
	}
}

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
