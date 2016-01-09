<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>机构管理</title>
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
	<style type="text/css">
		#inputForm{
			min-width:1080px;
		}
		#inputForm .form-actions{
			 margin-left:33.40%;
		}
	
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/sys/user">用户列表</a></li>
		<li><a href="${ctx}/sys/office/">机构管理</a></li>
		<shiro:hasPermission name="sys:office:edit"><li  class="active"><a href="${ctx}/sys/office/form"><c:choose><c:when test="${office.id != null}">机构修改</c:when><c:otherwise>机构添加</c:otherwise></c:choose></a></li></shiro:hasPermission>
		<li><a href="${ctx}/sys/role">角色管理</a></li>
		<li><a href="${ctx}/sys/role/form?id=${role.id}">角色<shiro:hasPermission name="sys:role:edit">${not empty role.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:role:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	
	<form:form id="inputForm" modelAttribute="office" action="${ctx}/sys/office/save" class="form-horizontal select_class"  method="post">
	
		<div class="form-group">
			<label for="company.id" class="col-sm-2 control-label"><font color="red">*</font>上级机构:</label>
			<div class="selectbox col-sm-5">
                <tags:treeselect id="office" name="parent.id" value="${office.parent.id}" labelName="parent.name" labelValue="${office.parent.name}"
					title="机构" url="/sys/office/treeData" extId="${office.id}" cssClass="form-control required" />
			</div>
		</div>
		
		
		<div class="form-group">
			<label for="company.id" class="col-sm-2 control-label"><font color="red">*</font>归属区域:</label>
			<div class="selectbox col-sm-5">
                <tags:treeselect id="area" name="area.id" value="${office.area.id}" labelName="area.name" labelValue="${office.area.name}"
					title="区域" url="/sys/area/treeData" cssClass="form-control required"/>
			</div>
		</div>
		
		<div class="form-group">
			<label for="loginName" class="col-sm-2 control-label"><font color="red">*</font>机构名称:</label>
			<div class="col-sm-5">
				<form:input path="name" htmlEscape="false" maxlength="100" class="required form-control"/>
			</div>
		</div>
		
		<!-- 机构类型 -->
		<div class="form-group">
			<label for="loginName" class="col-sm-2 control-label"><font color="red">*</font>机构类型:</label>
			<div class="col-sm-5">
				<input name="type" type="text" value="1"  class="form-control required"  />
			</div>
		</div>
		
		<div class="form-group">
			<label for="loginName" class="col-sm-2 control-label"><font color="red">*</font>机构级别:</label>
			<div class="col-sm-5">
				 <form:select path="grade" class="form-control">
					<form:options  items="${fns:getDictList('sys_office_grade')}" itemLabel="label" itemValue="value" htmlEscape="false"  maxlength="1" class="required"/>
				</form:select>
			</div>
		</div>
		
		<div class="form-group">
			<label for="loginName" class="col-sm-2 control-label">备注:</label>
			<div class="col-sm-5">
				<form:textarea  path="remarks" htmlEscape="false" rows="3" maxlength="255" class="input-xlarge form-control"/>
			</div>
		</div>
		<div class="form-actions">
			<div>
				<shiro:hasPermission name="sys:user:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
				<input id="btnCancel" class="btn btn-primary" type="button" value="返 回" onclick="history.go(-1)"/>
			</div>
		</div>
	</form:form>
</body>
</html>