<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>个人信息</title>
	<meta name="decorator" content="default"/>
</head>
<body>
<!--     <div style = "margin-top:20px;"> -->
    
	    <ul class="nav nav-tabs">
			<li class="active"><a href="${ctx}/sys/user/info">基本信息</a></li>
			<li><a href="${ctx}/sys/user/modifyPwd">修改密码</a></li>
		</ul><br/>
		
		<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/info" 
			style = "min-width:1080px;" method="post" class="form-horizontal">
		<tags:message content="${message}"/>
		
		<div class="form-group">
			<label class="col-sm-1 control-label" style = "text-align:left;">姓名:</label>
			<div class="col-sm-3">
				<form:input path="name" htmlEscape="false" maxlength="100" class="required form-control" readonly="true"/>
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-1 control-label" style = "text-align:left;">登录名:</label>
			<div class="col-sm-3">
				<form:input path="loginName" htmlEscape="false" maxlength="100" class="required form-control" readonly="true"/>
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-1 control-label" style = "text-align:left;">归属公司:</label>
			<div class="col-sm-3">
				${user.company.name}
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-1 control-label" style = "text-align:left;">归属部门:</label>
			<div class="col-sm-3">
				${user.office.name}
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-1 control-label" style = "text-align:left;">邮箱:</label>
			<div class="col-sm-3">
				<form:input path="email" htmlEscape="false" maxlength="200" class="email required form-control"/>
			</div>
			<label class="col-sm-3 emailWarn"></label>
		</div>
		
		<div class="form-group">
			<label class="col-sm-1 control-label" style = "text-align:left;">电话:</label>
			<div class="col-sm-3">
				<form:input path="phone" htmlEscape="false" maxlength="200" class="required form-control phone"/>
			</div>
			<label class="col-sm-3 phoneWarn"></label>
		</div> 
		
<%-- 		<div class="form-group">
			<label class="col-sm-1 control-label" style = "text-align:left;">手机:</label>
			<div class="col-sm-3">
				<form:input path="mobile" htmlEscape="false" maxlength="200" class="required form-control mobile"/>
			</div>
			<label class="col-sm-3 mobileWarn"></label>
		</div> --%>
		
		<div class="form-group">
			<label class="col-sm-1 control-label" style = "text-align:left;">备注:</label>
			<div class="col-sm-3">
				<form:textarea path="remarks" htmlEscape="false" rows="3"  maxlength="255" class="input-xlarge form-control remarks"/>
			</div>
			<label class="col-sm-3 remarksWarn"></label>
		</div>
		
		<div class="form-group">
			<label class="col-sm-1 control-label" style = "text-align:left;">用户类型:</label>
			<div class="col-sm-3">
				${fns:getDictLabel(user.userType, 'sys_user_type', '无')}
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-1 control-label" style = "text-align:left;">用户角色:</label>
			<div class="col-sm-3">
				${user.roleNames}
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-1 control-label" style = "text-align:left;">最后登陆:</label>
			<div class="col-sm-3">
				IP: ${user.loginIp}&nbsp;&nbsp;&nbsp;&nbsp;时间：<tags:prettyTime date="${user.loginDate}"></tags:prettyTime>
			</div>
		</div>
		
		<div class="form-actions" style = "margin-left:25%;">
			<input id="btnSubmit" class="btn btn-primary" onclick = "valiSubmit();" style = "width:70px;" value="保 存"/>
		</div>
	</form:form>
	
	<script type="text/javascript">
		function valiSubmit(){
			
			//每次点击重新校验，以前的警告由于新的修改可能会不显示，所以先全部清除
			$('.emailWarn').empty();
			$('.phoneWarn').empty();
			$('.remarksWarn').empty();
			
			var email = $('.email').val();
			var phone = $('.phone').val();
			var remarks = $('.remarks').val();
			
			//标识是否通过验证
			var validOK = true;

			//判断邮箱是否合理
			var reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
			if(!reg.test(email)) {
			    $('.emailWarn').empty();
			    $('.emailWarn').append("<span style = \"color:red;\">邮箱格式不正确，请输入正确邮箱！如：（lango@lms.com）</span>");
			    validOK = false;
			}
			
			//判断电话号码是否合理
			var regTel = /^0?1[3|4|5|8][0-9]\d{8}$/;
			if(!regTel.test(phone)) {
			    $('.phoneWarn').empty();
			    $('.phoneWarn').append("<span style = \"color:red;\">号码格式不正确，请输入正确号码（如：18620213358）！</span>");
			    validOK = false;
			}
			
			//判断备注是否合理
			if(remarks.length > 254){
				 $('.remarksWarn').empty();
				 $('.remarksWarn').append("<span style = \"color:red;\">备注过长，应该在200字以内！</span>");
				 validOK = false;
			}
			
			if(validOK == true){
				loading('正在提交，请稍等...');
				$('#inputForm').submit();
			}
			
			//每次重置
			else {
				validOK = true;
			}
		}
	</script>
</body>
</html>