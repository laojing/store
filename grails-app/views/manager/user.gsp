<!doctype html>
<html>
    <head> 
		<meta name="layout" content="main"/> 
	</head>
    <body>

	<div class="mainpage container">

	<h1>用户管理</h1>
	<div class="seperator"></div>
	<table class="suttable" id="usertable">
	<g:each var="user" in="${users}">
	<tr>
		<td><input type="checkbox"/></td>
		<td>${user.username}</td>
		<td>&nbsp;</td>
		<td><a href="${createLink(controller:'manager', action:'deleteuser', params:[username:user.username])}">删除</a></td>
	</tr>
	</g:each>
	<tr><td colspan="4"><div class="seperatorindex"></div></td></tr>
	<tr>
		<td>权限：</td>
		<td><select name="upid" id="upid">"
		<g:each var="user" in="${roles}">
			<option value="${user.authority}">${user.authority}</option>
		</g:each>
		</select></td>

		<td width="200px"><a onclick=addRole() class="sutbtn">增加</a></td>
		<td><a onclick=delRole() class="sutbtn">去掉</a></td>
	</tr>
	</table>

	<h1>用户角色</h1>
	<div class="seperator"></div>
	<table class="suttable">
	<g:each var="ur" in="${userrole}">
	<tr>
		<td>${ur.user.username}</td>
		<td>${ur.role.authority}</td>
	</tr>
	</g:each>
	</table>

	<h1>新建用户</h1>
	<div class="seperator"></div><br/>
<form id="newuser" class="form-horizontal" action="newuser" method="post" enctype="multipart/form-data">
  <div class="form-group">
    <label for="username" class="col-sm-2 control-label">用户名：</label>
    <div class="col-sm-10">
		<input type="text" name="username" id="username" class="form-control" value=""></input>
    </div>
  </div>
  <div class="form-group">
    <label for="password" class="col-sm-2 control-label">密码：</label>
    <div class="col-sm-10">
		<input type="password" name="password" id="password" class="form-control" value=""></input>
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="button" onclick="onNewUser();" class="btn btn-default btn-block" id="submit">新建</button>
    </div>
  </div>
</form>

	</div>

	<script>

function addRole() {

	var rolename = $('#upid').val();
	var rowcount = $('#usertable >tbody >tr').length;
	for ( var i=0; i<rowcount-1; i++ ) {
		var ch = $('#usertable >tbody >tr input')[i];
		if ( ch.checked ) {
		var trs = $('#usertable >tbody >tr')[i];
		var addname = trs.children[1].textContent;	
		$.getJSON("${createLink(controller='manager',action:'addrole')}", {addname:addname,rolename:rolename}, function(data) {
			alert ( 'ok' );
		});
		}
	}
}

function delRole() {

	var rolename = $('#upid').val();
	var rowcount = $('#usertable >tbody >tr').length;
	for ( var i=0; i<rowcount-1; i++ ) {
		var ch = $('#usertable >tbody >tr input')[i];
		if ( ch.checked ) {
		var trs = $('#usertable >tbody >tr')[i];
		var addname = trs.children[1].textContent;	
		$.getJSON("${createLink(controller='manager',action:'delrole')}", {addname:addname,rolename:rolename}, function(data) {
			alert ( 'ok' );
		});
		}
	}
}
function onNewUser() {
	if ( $('#username').val() == 0 ) {
		alert ( '请输入用户名' );
		return;
	}
	if ( $('#password').val() == 0 ) {
		alert ( '请输入密码' );
		return;
	}

	$.getJSON("${createLink(controller='manager',action:'newuser')}", {username:$('#username').val(),password:$('#password').val()}, function(data) {
		if ( data.data == 'success' ) {
			alert ( "新建用户成功！" );
		}else if ( data.data == 'error' ) {
			alert ( "上传失败！" );
		}else{
			alert ( "没有上传权限！" );
		}
	});
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
