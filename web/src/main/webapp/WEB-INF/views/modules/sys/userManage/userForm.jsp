<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新建用户</title>
	<meta name="decorator" content="default"/>
	<style>
		.uploadify-button {
			background-color: rgb(67, 145, 187);
			background-image: -webkit-gradient(linear, left bottom, left top, color-stop(0, rgb(67,
				145, 187) ), color-stop(1, rgb(67, 145, 187) ) );
			max-width: 70px;
			max-height: 20px;
			border-radius: 1px;
			border: 0px;
			font: bold 12px Arial, Helvetica, sans-serif;
			display: block;
			text-align: center;
			text-shadow: 0 0px 0 rgba(0, 0, 0, 0.25);
		}
		
		.uploadify:hover .uploadify-button {
			background-color: rgb(67, 145, 187);
			background-image: -webkit-gradient(linear, left bottom, left top, color-stop(0, rgb(67,
				145, 187) ), color-stop(1, rgb(67, 145, 187) ) );
		}
		#adduser{
			overflow: hidden;
		    margin: auto;
		   /*  width: 80%; */
		    margin-top: 30px;
		}
		#headimage{
			float:left;
			width:30% 
		}
		#userform{
			float: left;
		    margin-left: 20px;
			width:60%;
		}
	/* 	
		body{
		margin: 0;
	} */
	.div_top{
		margin-top: 2%;
	}/* 
	.div_bottom ul{
		margin-left: 11%;
	} */
	.nav, .breadcrumb {
		margin-bottom: 0px;
	}
	.nav-tabs {
		border-bottom: 0px;
	}
	.nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li>a:hover, .nav-tabs>li.active>a:hover{
		border: 0px;
		border-bottom: 5px solid #08C;
	}
	.div_bottom{
	    border-bottom: 1px solid #ddd;
	}
	
	.div_table{
		padding-top: 10px;
	    /* margin: 0 10% 0 11%; */
	    background-color: #f2f2f2;
	    padding: 30px 0;
	    margin-top: 20px;
	    /* box-shadow: 0px 0px 5px #ddd; */
	}
	</style>
	<script type="text/javascript" src="${ctxStatic}/uploadify/jquery.uploadify-3.1.min.js"></script>
	<script type="text/javascript" src="${ctxStatic}/uploadify/jquery.jalert.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$("#loginName").focus();
			$("#inputForm").validate({
				rules: {
					loginName: {remote: "${ctx}/sys/user/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')},
					name:{required:true},
				},
				messages: {
					loginName: {remote: "账号已存在"},
					name:{required:"请填写用户名"},
					newPassword:{required:"请填写密码"},
					roleNameList:{required:"请选择角色"},
					confirmNewPassword: {required:"请填写密码",equalTo: "两次密码不相同"},
				},
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
			showRoleList();//如果是修改用户信息，则显示选中的角色
			
		});

		/*设置选中角色*/
		function checkRoles(){
			showRoleList();
			$('#myModal').modal('toggle');
		}
		
		function showRoleList(){
			var value = '';
			$("input[name='roleIdList']:checked").each(function(){
				var name =  $(this).next().text();
				value = name+'  '+value;
			});
			$("#roleList_input").val(value);
			$("#roleList_input").attr("title",value);
		}
	</script>
</head>
<body>
 <div class="div_top">
  <div class="div_bottom">
	<ul class="nav nav-tabs">
	   <li><a href="${ctx}/sys/user">用户列表</a></li>
		<c:if test="${user.id!=null}">
			<li class="active"><a href="#">用户修改</a></li>
		</c:if>
		<c:if test="${user.id==null}">
			<li class="active"><a href="#">新建用户</a></li>
		</c:if>
		<li><a href="${ctx}/sys/office">机构管理</a></li>
		<li><a href="${ctx}/sys/role">角色管理</a></li>
		<li><a href="${ctx}/sys/role/form?id=${role.id}">角色<shiro:hasPermission name="sys:role:edit">${not empty role.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:role:edit">查看</shiro:lacksPermission></a></li>
	 </ul>
    </div>
    <div class="div_table">
    	<div id="adduser" style="position:relative" class="select_class">
		<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/save" method="post" class="form-horizontal"
			style = "min-width:1000px;">
			<c:if test="${not empty user.id}">
				<form:hidden path="id"/>
			</c:if>
			<tags:message content="${message}"/>
			<!-- 头像 -->
			<div id="headimage" class="form-group">
				<span class="control-label" style = "font-weight:bold"></span>
				<div class="controls">
					<input type="hidden" id="icoUrl" name="icoUrl" value="${user.icoUrl}" />
					<table cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<div style = "float:left;margin-right:10px;">
								<a>
									<c:choose>
										<c:when test="${not empty user.icoUrl}">
											<img id="imgshow" style="width: 70px; height: 70px" align="bottom" src="src="${actx}/${user.icoUrl}"" />
										</c:when>
										<c:otherwise>
											<img id="imgshow" style="width: 70px; height: 70px" src="${ctxStatic}/images/face-placeholder.png">
										</c:otherwise>
									</c:choose>
								</a>
								</div> 
								<div style = "padding-top:3%;width:250px;">
									<span class="help-inline">
										支持JPG\JPEG、PNG、BMP格式的图片建议文件小于2M。
									</span>
								</div>
							</td>
						</tr>
						<tr>
							<td class = "text-center">
								<div style="position: relative;top:-3px;">
									<a id="picker" class="uploadify-button webuploader-container">上传</a>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
			
			<!-- 表单 -->
			<div id="userform">
				<div class="form-group">
					<label for="name" class="col-sm-2 control-label"><font color="red">*</font>用户姓名:</label>
					<div class="col-sm-5">
						<form:input path="name" htmlEscape="false" maxlength="100" class="required form-control"/>
					</div>
				</div>
				<div class="form-group">
					<input type = "hidden" value = "${user.loginName }" name = "oldLoginName">
					<label for="loginName" class="col-sm-2 control-label"><font color="red">*</font>用户账号:</label>
					<div class="col-sm-5">
						<form:input path="loginName" htmlEscape="false" maxlength="100" class="required form-control"/>
					</div>
				</div>
				
				<div class="form-group">
					<label for=newPassword class="col-sm-2 control-label"><font color="red">*</font>用户密码:</label>
					<div class="col-sm-5">
						<input id="newPassword" name="newPassword" type="password" class="form-control ${empty user.id?'required':''}">
					</div>
				</div>
				<div class="form-group">
					<label for="confirmNewPassword" class="col-sm-2 control-label"><font color="red">*</font>确认密码:</label>
					<div class="col-sm-5">
						<input id="confirmNewPassword" name="confirmNewPassword" class="form-control ${empty user.id?'required':''}" type="password" value="" maxlength="100" minlength="1" equalTo="#newPassword"/>
					</div>
				</div>
				<div class="form-group">
					<label for="email" class="col-sm-2 control-label"><font color="red">*</font>联系邮箱:</label>
					<div class="col-sm-5">
						<form:input path="email" htmlEscape="false" maxlength="100" class="required email form-control"/>
					</div>
				</div>

				<div class="form-group">
					<label for="phone_0" class="col-sm-2 control-label">&nbsp;联系电话:</label>
					<div class="col-sm-5">
						<input id="phone_0" name="phone_0" onblur="phoneValid(this)" class="form-control"/>
					</div>
				</div>
				
				<div class="form-group">
					<label for="company.id" class="col-sm-2 control-label"><font color="red">*</font>所属机构:</label>
					<div class="selectbox col-sm-5">
		                <tags:treeselect id="company" name="company.id" value="${user.company.id}" labelName="company.name" labelValue="${user.company.name}"
							title="公司" url="/sys/office/treeData?type=1" cssClass="form-control required" />
					</div>
				</div>
	
				<div class="form-group">
					<label for="roleNameList" class="col-sm-2 control-label"><font color="red">*</font>用户角色:</label>
					<div class="selectbox col-sm-5">
						<input type="text" id="roleList_input" name="roleNameList" class="form-control ${empty user.id?'required':''}" readonly>
						<a id="${id}Button"  href="javascript:" class="btn selectbox_btn" data-toggle="modal" data-target="#myModal"  for="roleList_input"><i class="icon-search"></i></a>&nbsp;&nbsp;
					</div>
					<!-- Modal -->
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
					  <div class="modal-dialog" role="document">
					    <div class="modal-content">
					      <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					        <h4 class="modal-title" id="myModalLabel">用户角色</h4>
					      </div>
					      <div class="modal-body">
					        <form:checkboxes path="roleIdList" items="${allRoles}" itemLabel="name" itemValue="id" htmlEscape="false" class="required"/>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					        <button id="getRole_button" type="button" class="btn btn-primary" onclick="checkRoles()">确定</button>
					      </div>
					    </div>
					  </div>
					</div>
					</div>
				<div class="form-group">
					<label for="remarks" class="col-sm-2 control-label">&nbsp;备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:</label>
					<div class="col-sm-5">
						<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="255" class="form-control" style = "width:90%;"/>
					</div>
				</div>
				
				<div class="form-actions" style = "margin-left:30%">
						<shiro:hasPermission name="sys:user:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
						<input id="btnCancel" class="btn btn-primary" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</div>
		</form:form>
	</div>
   </div>
  </div>
</body>
</html>