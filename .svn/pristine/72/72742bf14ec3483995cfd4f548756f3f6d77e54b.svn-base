<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>修改密码</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/sys/user/info">个人信息</a></li>
		<li class="active"><a href="${ctx}/sys/user/modifyPwd">修改密码</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/modifyPwd" method="post" 
		class="form-horizontal" style = "min-width:1380px;">
		<c:if test="${not empty user.id}">
			<form:hidden path="id"/>
		</c:if>
		<tags:message content="${message}"/>
		
		<div class="form-group">
			<label class="col-sm-1 control-label" style = "text-align:left;">旧密码:</label>
			<div class="col-sm-4">
				<input id="oldPassword" name="oldPassword" type="password" value="" maxlength="100" 
				minlength="1" class="required form-control" style = "display:inline;width:46%"/>
				&nbsp;&nbsp;
				<span class = "oldPwdNotEmpty" style = "color:red;font-weight:bold;"></span>
			</div>
		</div>
			
		<div class="form-group">
			<label class="col-sm-1 control-label" style = "text-align:left;">新密码:</label>
			<div class="col-sm-4">
				<input id="newPassword" name="newPassword" type="password" value="" maxlength="100" minlength="1" 
				class="form-control required" style = "display:inline;width:46%"/>
				&nbsp;&nbsp;
				<span class = "pwdNotEmptyWarn" style = "color:red;font-weight:bold;"></span>
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-1 control-label" style = "text-align:left;">确认新密码:</label>
			<div class="col-sm-4">
				<input id="confirmNewPassword" name="confirmNewPassword" type="password" 
					value="" maxlength="100" minlength="1" class="required form-control" equalTo="#newPassword"
					style = "display:inline;width:46%"/>
				&nbsp;&nbsp;
				<span class = "pwdIsSameWarn" style = "color:red;font-weight:bold;"></span>
			</div>
		</div>
		
		<div class="form-actions" style = "margin-left:19%;">
			<input id="btnSubmit" class="btn btn-primary" type="button" onclick = "validSubmit()" value="保 存"/>
		</div>
	</form:form>
	
	<script type="text/javascript">
		function validSubmit(){
			
			//再次点击保存的时候，可能已经修改成合适的值，那么不需要显示warn。
			$('.pwdNotEmptyWarn').empty();
			$('.pwdIsSameWarn').empty();
			$('.oldPwdNotEmpty').empty();
			
			var oldPassword = $('#oldPassword').val();
			var newPassword = $('#newPassword').val();
			var newPassword1 = $('#confirmNewPassword').val();
			
			var validOK = true;
			
			//旧密码不能为空
			if(oldPassword.length == 0) {
				$('.oldPwdNotEmpty').append("旧密码不能为空！");
				validOK = false;
			}
			
			//密码不能为空
			if(validOK == true){
				if(newPassword.length == 0) {
					$('.pwdNotEmptyWarn').append("密码不能为空！");
					validOK = false;
				}
			}
			
			//确认密码一致性验证
			//如果新设置的密码为空，就没有必须再判断一致
			if(validOK == true){
				if(newPassword1 != newPassword){
					$('.pwdIsSameWarn').append("两次输入的密码不一致！");
					validOK = false;
				}
			}
			
			//验证成功提交请求，失败则重置validOK 变量
			if(validOK == true){
				loading('正在提交，请稍等...');
				$('#inputForm').submit();
			}
			else{
				validOK = true;
			}
		}
	</script>
</body>
</html>