<!doctype html>
<html>
    <head> 
		<meta name="layout" content="main"/> 
	</head>
    <body>

	<div class="mainpage container">

	<h1>整理项目</h1>

	<div class="seperator"></div>

	<table class="suttable">
	<tr>
		<td> <label> <input type="checkbox" id="selectall" onchange="SelectAll();">&nbsp;&nbsp;&nbsp;&nbsp;选择所有</label> </td>
		<td> <span id="update-0"></span></td>
		<td> <button class="btn btn-default" onclick="UpdateAllStore();" type="button">更新</button> </td>
		<td> <span id="delete-0"></span></td>
		<td> <button class="btn btn-default" onclick="DeleteAllStore();" type="button">删除</button> </td>
	</tr>
	<g:each var="store" status="index" in="${stores}">
	<tr>
		<td> <label><input type="checkbox" id="sel${index}" data-type="${store.sutid}">&nbsp;&nbsp;&nbsp;&nbsp;${store.title}</label> </td>
		<td> <span id="update${index}"></span></td>
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
		<td> <span id="delete${index}"></span></td>
		<td> <button class="btn btn-default" onclick="DeleteStore(${index},'${store.sutid}');" type="button">删除</button> </td>
	</tr>
	</g:each>
	</table>

	</div>

	<script>
var allindex = 0;
var allcurrent = 0;
function UpdateAllStore () {
	var rowcount = $('.suttable > tbody > tr').length;
	for ( var i=0; i<rowcount-1; i++ ) {
		if ( document.getElementById('sel'+i).checked ) {
			allindex++;
			UpdateStore ( i, $('#sel'+i).data('type') );
		}
	}
}

function DeleteAllStore () {
	var rowcount = $('.suttable > tbody > tr').length;
	for ( var i=0; i<rowcount-1; i++ ) {
		if ( document.getElementById('sel'+i).checked ) {
			allindex++;
			DeleteStore ( i, $('#sel'+i).data('type') );
		}
	}
}

function UpdateStore ( index, sutid ) {
	$('#update'+index).html('更新....');
	$.getJSON("${createLink(controller='manager', action:'updateproject')}", {sutid:sutid}, function(data) {
		$('#update'+index).html('更新完成');
		$('#update-0').html((++allcurrent)+'/'+(allindex));
		if ( allcurrent == allindex ) $('#update-0').html('更新完成');
	});
}

function DeleteStore ( index, sutid ) {
	$('#delete'+index).html('删除....');
	$.getJSON("${createLink(controller='manager', action:'deleteproject')}", {sutid:sutid}, function(data) {
		$('#delete'+index).html('删除完成');
		$('#delete-0').html((++allcurrent)+'/'+(allindex));
		if ( allcurrent == allindex ) $('#delete-0').html('删除完成');
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
