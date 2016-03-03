<!doctype html>
<html>
    <head> 
		<meta name="layout" content="main"/> 
	</head>
    <body>

	<asset:javascript src="jquery.form.min.js"/>

	<div class="mainpage container">

	<h1>${year}本科毕业设计</h1>

	<table class="table table-striped">
	<tr><th>学号</th><th>姓名</th><th>题目</th></tr>
	<g:each var="grad" in="${grads}">
		<tr>
		<td>${grad.sutid}</td>
		<td>${grad.name}</td>
		<td>${grad.title}</td>
		</tr>
	</g:each>
	</table>

    <ul id="myTabs" class="nav nav-tabs" role="tablist">
	<g:each var="grad" status="index" in="${grads}">
	<g:if test="${index==0}">
        <li role="presentation" class="active"><a href="#home${grad.sutid}" id="home-tab${grad.sutid}" role="tab" data-toggle="tab" aria-controls="home${grad.sutid}" aria-expanded="true">${grad.name}</a></li>
	</g:if>
	<g:else>
        <li role="presentation"><a href="#home${grad.sutid}" role="tab" id="home-tab${grad.sutid}" data-toggle="tab" aria-controls="home${grad.sutid}">${grad.name}</a></li>
	</g:else>
	</g:each>
    </ul>
    <div id="myTabContent" class="tab-content">
	<g:each var="grad" status="index" in="${grads}">
	<g:if test="${index==0}">
        <div role="tabpanel" class="tab-pane fade in active" id="home${grad.sutid}" aria-labelledBy="home-tab${grad.sutid}">
	</g:if>
	<g:else>
        <div role="tabpanel" class="tab-pane fade" id="home${grad.sutid}" aria-labelledBy="home-tab${grad.sutid}">
	</g:else>

	<h2 style="font-size:16px;">${grad.title}</h2>
	<table class="table table-striped">
	<tr><th>名称</th><th>上传日期</th></tr>
	<g:each var="cont" in="${templates}">
	<g:if test="${cont.sutid==grad.sutid}">
		<tr> <td><a href="${createLink(controller:'graduation', action:'download', params:[id:''+cont.id])}">${cont.filename}</a></td>
		<td>${cont.uploadDate}</td> </tr>
	</g:if>
	</g:each>
	</table>

	<h2 style="font-size:16px;">主要工作内容</h2>
	<table class="table table-striped">
		<g:each var="prove" in="${proves}">
		<g:if test="${prove.conttype==1 && prove.sutid ==grad.sutid}">
			<tr> <td>${prove.txt}</td> </tr>
		</g:if>
		</g:each>
	</table>

	<h2 style="font-size:16px;">每周工作计划</h2>
	<table class="table table-striped">
		<g:each var="prove" in="${proves}">
		<g:if test="${prove.conttype==2 && prove.sutid ==grad.sutid}">
			<tr> <td>第${prove.contid}周、${prove.txt}</td> </tr>
		</g:if>
		</g:each>
	</table>

	<h2 style="font-size:16px;">参考书籍</h2>
	<table class="table table-striped">
		<g:each var="prove" in="${proves}">
		<g:if test="${prove.conttype==3 && prove.sutid ==grad.sutid}">
			<tr> <td>${prove.txt}</td> </tr>
		</g:if>
		</g:each>
	</table>


      </div>
	</g:each>
    </div>

	<nav><ul class="pager">

	<g:each var="yearitem" in="${years}">
		<g:if test="${yearitem!=year}">
		<li><a href="${createLink(controller:'graduation', action:'index', params:[year:yearitem])}">${yearitem}</a></li>
		</g:if>
		<g:else>
		<li class="disabled"><a href="${createLink(controller:'graduation', action:'index', params:[year:yearitem])}">${yearitem}</a></li>
		</g:else>
	</g:each>

	</ul></nav>


	<div class="panel panel-default">
		<div class="panel-heading">毕业设计模板(直接在模板上修改不要新建文件)</div>
		<ul class="list-group">
			<g:each var="cont" in="${templates}">
			<g:if test="${cont.sutid=='0'}">
				<li class="list-group-item"><a href="${createLink(controller:'graduation', action:'download', params:[id:''+cont.id])}">${cont.filename}</a>
					<span style="float:right;">${cont.uploadDate}</span>
				</li>
			</g:if>
			</g:each>
		</ul>
	</div>


	<g:if test="${curyear==year}">

	<div class="panel panel-default">
		<div class="panel-heading">上传文件</div>
		<div class="panel-body">

<g:form id="fileform" class="form-inline" url="[action:'fileupload',controller:'graduation']" method="post" enctype="multipart/form-data">
  <div class="form-group">
    <label for="upyear">年份</label>
    <input type="text" style="width:60px;"class="form-control" id="upyear" name="upyear" readonly value="${year}">
  </div>
  <div class="form-group">
    <label for="upid">学生</label>
	<select name="upid" id="upid" class="form-control">
		<option value="0">--请选择--</option>
		<g:each var="grad" in="${grads}">
			<g:if test="${grad.sutid==curuser}">
			<option value="${grad.sutid}">${grad.name}</option>
			</g:if>
		</g:each>
	</select>
  </div>
  <div class="form-group">
    <label for="uptype">文件类型</label>
	<select name="uptype" id="uptype" class="form-control">
		<option value="0">--请选择--</option>
		<option value="2">毕业翻译(译文)</option>
		<option value="3">开题报告</option>
		<option value="4">毕业答辩ppt</option>
		<option value="5">毕业设计word</option>
		<option value="6">毕业设计pdf</option>
	</select>
  </div>
  <div class="form-group">
    <label for="upfile">选择文件</label>
	<input type="file" name="upfile" id="upfile" class="form-control">
  </div>

  	<a onclick=onUploadButtonClicked() class="btn btn-default">上传</a>
</g:form>

		</div>
	</div>





	</g:if>


	</div> 


	<script> 
function onUploadButtonClicked() {
	if ( $('#upid').val() == 0 ) {
		alert ( '请选择学生姓名' );
		return;
	}
	if ( $('#uptype').val() == 0 ) {
		alert ( '请选择文件类型' );
		return;
	}
	if ( $('#upfile').val() == '' ) {
		alert ( '请选择要上传的文件' );
		return;
	}
	var reg1 = new RegExp('[p,P][d,D][f,F]$');
	var reg2 = new RegExp('[d,D][o,O][c,C]$');
	var reg3 = new RegExp('[d,D][o,O][c,C][x,X]$');
	var reg4 = new RegExp('[p,P][p,P][t,T]$');
	if ( reg1.test($('#upfile').val()) 
	     || reg2.test($('#upfile').val())
	     || reg3.test($('#upfile').val())
	     || reg4.test($('#upfile').val()) ) {
	var options = {
		success: upok,
		type: 'post',
		clearForm:false
	};
	$('#fileform').ajaxSubmit( options );
	} else {
		alert ( '只能上传word或pdf格式！' );
	}
}

function upok ( data ) {
	if ( data.data == 'success' ) {
		alert ( "上传附件成功！刷新页面看结果！" );
	}else if ( data.data == 'error' ) {
		alert ( "上传失败！" );
	}else{
		alert ( "没有上传权限！" );
	}
}
		</script>



	</body>
</html>
