<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
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
	
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/systemManage/sysManage_common.css">
</head>
<body>
	<div class="div_top">
		<div class="div_bottom">
			<ul class="nav nav-tabs">
				<li><a href="${ctx}/sys/menu/">菜单列表</a></li>
				<li class="active"><a href="${ctx}/sys/menu/form?id=${menu.id}&parent.id=${menu.parent.id}">菜单<shiro:hasPermission name="sys:menu:edit">${not empty menu.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:menu:edit">查看</shiro:lacksPermission></a></li>
			</ul>
		</div>
	</div>
	
	<br/>
	<div class="select_class">
	<form:form id="inputForm" modelAttribute="menu" action="${ctx}/sys/menu/save" method="post" class="form-horizontal ">
		<c:if test="${not empty menu.id}">
			<form:hidden path="id"/>
		</c:if>
		<tags:message content="${message}"/>
		<div class="form-group">
			<label for="menu"  class="col-sm-2 control-label">上级菜单:</label>
			<div class="col-sm-5">
				 <tags:treeselect id="menu" name="parent.id" value="${menu.parent.id}" labelName="parent.name" labelValue="${menu.parent.name}"
					title="菜单" url="/sys/menu/treeData" extId="${menu.id}" cssClass="required form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label for="name" class="col-sm-2 control-label">名称:</label>
			<div class="col-sm-5">
				<form:input path="name" htmlEscape="false" maxlength="100" class="required form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label for="href" class="col-sm-2 control-label">链接:</label>
			<div class="col-sm-5">
				<form:input path="href" htmlEscape="false" maxlength="255" class="form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label for="target" class="col-sm-2 control-label">目标:</label>
			<div class="col-sm-5">
				<form:input path="target" htmlEscape="false" maxlength="20" class="form-control"/>
			</div>
		</div>
		<%-- <div class="form-group">
			<label for="icon" class="col-sm-2 control-label">图标:</label>
			<div class="col-sm-3">
				<tags:iconselect id="icon" name="icon" value="${menu.icon}"></tags:iconselect>
			</div>
		</div> --%>
		<div class="form-group">
			<label for="sort" class="col-sm-2 control-label">排序:</label>
			<div class="col-sm-5">
				<form:input path="sort" htmlEscape="false"  class="required digits form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label for="isShow" class="col-sm-2 control-label">可见:</label>
			<div class="col-sm-5">
				<form:radiobuttons path="isShow" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false"   maxlength="1" class="required"/>
			</div>
		</div>
		<div class="form-group">
			<label for="permission" class="col-sm-2 control-label">权限标识:</label>
			<div class="col-sm-5">
				<form:input path="permission" htmlEscape="false" maxlength="200" class="form-control"/>
			</div>
		</div>
		  <div class="form-group">
		    <div class="col-sm-offset-2 col-sm-10">
		      	<shiro:hasPermission name="sys:menu:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			    <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		    </div>
		 </div>
	</form:form>
	</div>
</body>
</html>