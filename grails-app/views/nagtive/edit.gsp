<!doctype html>
<html>
    <head> 
		<meta name="layout" content="main"/> 
	</head>
    <body>
	<asset:javascript src="nagtive.js"/>

	<div class="mainpage container">
	<g:set var="curclass" value=""/>
	<br/>
	<div class="row">
	<g:each var="item" status="index" in="${nags}">
		<g:if test="${index == 0 || curclass != item.classname}">
		<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">${item.classname[0..1]}、${item.classname[2..-1]}</div>
			<div class="panel-body">
				<g:each var="nagitem" status="nagindex" in="${nags}">
				<g:if test="${item.classname == nagitem.classname}">
					<div style="margin:5px 0;padding:5px;border:1px dotted #ccc;" class="col-xs-12 col-md-4 col-lg-3">
					<a role="button" href="${nagitem.urlpath}" class="btn btn-link">${nagitem.title}</a>
					<a class="btn btn-default" style="float:right;" href="${createLink(controller:'nagtive', action:'deleteurl', params:[id:nagitem.id])}">删除</a>
					<button onclick="ShowEditUrl(${nagitem.id},'${nagitem.classname}','${nagitem.title}','${nagitem.urlpath}');" style="float:right;" class="btn btn-default">修改</a>
					</div>
				</g:if>
				</g:each>
			</div>
		</div>
		</div>
		<g:set var="curclass" value="${item.classname}"/>
		</g:if>
	</g:each>
	</div>

<form class="form-horizontal">
  <div class="form-group">
    <label for="classname" class="col-sm-2 control-label">类名：</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="classname">
    </div>
  </div>
  <div class="form-group">
    <label for="urltitle" class="col-sm-2 control-label">名称：</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="urltitle">
    </div>
  </div>
  <div class="form-group">
    <label for="urlpath" class="col-sm-2 control-label">地址：</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="urlpath">
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="buttom" onclick="newUrl();" class="btn btn-default">新建</button>
    </div>
  </div>
</form>





<div id="changedialog" class="modal fade" role="dialog" aria-labelledby="gridSystemModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="gridSystemModalLabel">修改</h4>
      </div>
      <div class="modal-body">
        <div class="container-fluid">

<form class="form-horizontal">
  <div class="form-group">
    <label for="curlid" class="col-sm-2 control-label">标号：</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="curlid" readonly>
    </div>
  </div>
  <div class="form-group">
    <label for="cclassname" class="col-sm-2 control-label">类名：</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="cclassname">
    </div>
  </div>
  <div class="form-group">
    <label for="curltitle" class="col-sm-2 control-label">名称：</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="curltitle">
    </div>
  </div>
  <div class="form-group">
    <label for="curlpath" class="col-sm-2 control-label">地址：</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="curlpath">
    </div>
  </div>
</form>

      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" onclick="EditUrl();" class="btn btn-primary">修改</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->





	</div>
<script>

function DeleteUrl ( id, classname, title, urlpath ) {
	$.getJSON("${createLink(controller='nagtive',action:'deleteurl')}", 
		{id:id},
		function(data) {
	});
}

function ShowEditUrl ( id, classname, title, urlpath ) {
	$('#curlid').val(id);
	$('#cclassname').val(classname);
	$('#curltitle').val(title);
	$('#curlpath').val(urlpath);
	$('#changedialog').modal();
}

function newUrl () {
	$.getJSON("${createLink(controller='nagtive',action:'newurl')}", 
	{classname:$('#classname').val(),
	title:$('#urltitle').val(),
	urlpath:$('#urlpath').val()},
	function(data) {
		alert ( "OK!" );
	});
}


function EditUrl () {
	$.getJSON("${createLink(controller='nagtive',action:'editurl')}", 
		{id:$('#curlid').val(),
		classname:$('#cclassname').val(),
		title:$('#curltitle').val(),
		urlpath:$('#curlpath').val()},
	function(data) {
		$('#changedialog').modal('hide');
	});
}

</script>
    </body>
</html>
