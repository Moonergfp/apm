<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>字典管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#value").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio") || element.parent().hasClass("input-append")){
						error.appendTo(element.parents(".controls:first"));
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
	<style type="text/css">
		#inputForm{
			min-width:1080px;
		}
		
		#inputForm input.form-control{
			display:inline-block;
			width:65%;
		}
		
		#inputForm .form-actions{
			margin-left:33.40%;
		}
	</style>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/systemManage/sysManage_common.css">
	
</head>
<body>
	<div class="div_top">
		<div class="div_bottom">
			<ul class="nav nav-tabs">
				<li><a href="${ctx}/sys/dict/">字典列表</a></li>
				<li class="active"><a href="${ctx}/sys/dict/form?id=${dict.id}">字典<shiro:hasPermission name="sys:dict:edit">${not empty dict.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:dict:edit">查看</shiro:lacksPermission></a></li>
			</ul>
		</div>
	</div>
	<br/>
	<form:form id="inputForm" modelAttribute="dict" action="${ctx}/sys/dict/save" method="post" class="form-horizontal">
		<c:if test="${not empty dict.id}">
			<form:hidden path="id"/>
		</c:if>
		<tags:message content="${message}"/>
		
		
		<div class="form-group">
			<label class="control-label col-sm-2 ">标签:</label>
			<div class="col-sm-5">
				<form:input path="label" htmlEscape="false" maxlength="100" class="form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-2 ">键值:</label>
			<div class="col-sm-5">
				<form:input path="value" htmlEscape="false" maxlength="100" class="required form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-2 ">类型:</label>
			<div class="col-sm-5">
				<form:input path="type" htmlEscape="false" maxlength="100" class="required form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-2 ">描述:</label>
			<div class="col-sm-5">
				<form:input path="description" htmlEscape="false" maxlength="100" class="required form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-2 ">排序:</label>
			<div class="col-sm-5">
				<form:input path="sort" htmlEscape="false" maxlength="100" class="required form-control digits"/>
			</div>
		</div>
		<div class="form-actions">
			<div class="ol-md-offset-4">
			<shiro:hasPermission name="sys:dict:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
			</div>
		</div>
	</form:form>
</body>
</html>