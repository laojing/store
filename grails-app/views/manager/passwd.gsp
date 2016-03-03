<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
	</head>
	<body>

	<div class="mainpage">
	<div class="container">
	<div class="row">
	<div class="col-md-12 col-lg-6 col-lg-offset-3">

	<h1>修改密码<span class="text-danger">${error}</span></h1>
	<div class="seperator"></div><br/><br/>

<form class="form-horizontal" id="loginForm" action="${createLink(controller='manager',action:'changepw')}" method="POST" autocomplete="on">
  <div class="form-group">
	<label for="password" class="youpasswd col-sm-2 control-label" data-icon="p">现密码：</label>
    <div class="col-sm-10">
		<input id="j_password" name="j_password" class="form-control" required="required" type="password" placeholder="现密码" /> 
	</div>
  </div>
  <br/>
  <div class="form-group">
	<label for="password_new" class="youpasswd col-sm-2 control-label" data-icon="p">新密码：</label>
    <div class="col-sm-10">
		<input id="j_password_new" name="j_password_new" class="form-control" required="required" type="password" placeholder="新密码" /> 
	</div>
  </div>
  <br/>
  <div class="form-group">
    <label for="password" class="youpasswd col-sm-2 control-label" data-icon="p">重复新密码：</label>
    <div class="col-sm-10">
		<input id="j_password_new_2" name="j_password_new_2" class="form-control" required="required" type="password" placeholder="重复新密码" /> 
	</div>
  </div>
  <br/>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" class="btn btn-default btn-block" id="submit">修改</button>
    </div>
  </div>
</form>

	</div>
	</div>
	</div>
	</div>
	</body>
</html>
