<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>个人信息</title>
	<meta name="decorator" content="default"/>
	
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/systemManage/sysManage_common.css">
	
	<style type="text/css">
	body{
		 margin-left:0px;
		 margin-right:0px;
		 padding-left:11%;
		 padding-right:10%;
	 }
	</style>
	
	<script type="text/javascript">
	 jQuery(function(){ 
		 $('.showEmailModifyBut').hide();
		 $('.showEmailSaveBut').hide();
		 $('.displayEmailModify').hide();
		 
		 $('.showPhoneModifyBut').hide();
		 $('.showPhoneSaveBut').hide();
		 $('.displayPhoneModify').hide();
		 
		 $('.showRemarksModifyBut').hide();
		 $('.showRemarksSaveBut').hide();
		 $('.displayRemarksModify').hide();
		 
		 $('.showPwdModify').hide();
		 $('.savePwdSucc').hide();
		 $('.saveEmailSucc').hide();
		 $('.savePhoneSucc').hide();
		 $('.saveRemarksSucc').hide();
		 
	 });
		
	</script>
</head>
<body>
<!--     <div style = "margin-top:20px;"> -->
	<div class="div_top">
		<div class="div_bottom">
		    <ul class="nav nav-tabs">
				<li class="active"><a href="${ctx}/sys/user/info">基本信息</a></li>
				<li><a href="javascript:void(0)">系统消息</a></li>
			</ul>
		</div>
	</div>
		
		<br/>
		
		<div class = "row" style = "margin:0 auto;padding-bottom:10px;min-width:800px;max-width:800px;box-shadow: 0 0 3px #000;">
		<div style = "float:left;width:300px;padding-top:10px;padding-left:10px;">
			<span><img src = "${ctxStatic}/images/testP.jpg" width="200px;" height="200px;"></span>
			<br/><br/>
			<span style = "font-weight:bold;font-size:17px;">机构：${user.company.name}</span><br/>
			<span style = "font-weight:bold;font-size:17px;">角色：${user.roleNames}</span>
		</div>
		
		<div style = "width:500px;float:left;">
			<div class = "row" style = "min-height:50px;">
				<span style = "font-weight:bold;font-size:25px;">${user.name}</span>
				<span style = "padding-left:20px;font-size:20px;">${user.loginName}</span>
			</div>

			<div class = "row" style = "min-height:50px;">
				<div class = "pwdFont" style = "float:left;width:150px;">
				<span style = "font-weight:bold;font-size:17px;">密码：</span>
				<span class = "pwdModify" style = "padding-left:20px;font-size:17px;">
					<a href = "javascript:void(0)" style = "text-decoration:none;"
						onclick = "clickModifyPwd();">修改密码</a>
				</span>&nbsp;&nbsp;
				<span class = "savePwdSucc glyphicon glyphicon-saved" 
						style = "fonr-size:14px;color:green">保存成功</span>
				</div>
				<div class = "showPwdModify" style = "float:left;width:250px;text-align:left;padding-left:18px;margin-right:5px;">
				<span class="" style= "padding-top:5px;">
					<input type = "password" placeholder="原密码" name = "oldPassword" 
					id = "oldPassword" class = "form-control" style = "width:255px;">
				</span>
				<span class = "oldPwdNotEmpty" style = "color:red;font-weight:bold;"></span>
				<br/>

				<span class="" style= "padding-top:5px;">
					<input type = "password" placeholder="新密码" name = "newPassword" 
						id = "newPassword" class = "form-control" style = "width:255px;">
				</span>
				<span class = "pwdNotEmptyWarn" style = "color:red;font-weight:bold;"></span>
				<br/>
				
				<span class="" style= "padding-top:5px;">
					<input type = "password" placeholder="再次输入新密码" name = "confirmNewPassword" 
						id = "confirmNewPassword" class = "form-control" style = "width:255px;">
				</span>
				<span class = "pwdIsSameWarn" style = "color:red;font-weight:bold;"></span>
				<br/>
				
				<span class="" style= "padding-top:5px;padding0left:76%;">
					<input type = "button" class = "btn btn-primary btn-sm"
						style = "width:24%" onclick = "savePwd();" value = "保存">
				</span>
				<br/><br/>
				</div>
			</div>
				
			
			<div class = "row emailArea" style = "min-height:50px;margin-right:5px;">
				<span style = "font-weight:bold;font-size:17px;">邮箱：</span>
				<span class = "displayEmail" style = "padding-left:20px;font-size:20px;">${user.email }</span>
				<span class = "displayEmailModify" style = "padding-left:20px;font-size:20px;">
					<input type = "text" style = "display:inline;width:50%;" value = ${user.email }
						name = "newEmail" id = "newEmail" required class = "form-control email">
				</span>
				&nbsp;&nbsp;
				<span class="showEmailModifyBut" style= "padding-top:5px;">
					<a href = "javascript:void(0);" class = "glyphicon glyphicon-pencil" 
						style = "text-decoration:none;" onclick = "emailClickModify()">修改</a>
				</span>
				<span class="showEmailSaveBut" style= "padding-top:4px;">
					<button class = "btn btn-sm btn-primary" onclick = "saveEmail()">保存</button>
				</span>
				&nbsp;&nbsp;
				<span class = "saveEmailSucc glyphicon glyphicon-saved" 
						style = "fonr-size:14px;color:green">保存成功</span>
				<span class="emailWarn" style= "color:red;font-weight:bold;"></span>
			</div>
			
			<div class = "row phoneArea" style = "min-height:50px;margin-right:5px;">
				<span style = "font-weight:bold;font-size:17px;">电话：</span>
				<span class = "displayPhone" style = "padding-left:20px;font-size:20px;">${user.phone }</span>
				<span class = "displayPhoneModify" style = "padding-left:20px;font-size:20px;">
					<input type = "text" style = "display:inline;width:50%;" value = ${user.phone }
						name = "newPhone" id = "newPhone" required class = "form-control">
				</span>
				&nbsp;&nbsp;
				<span class="showPhoneModifyBut" style= "padding-top:5px;">
					<a href = "javascript:void(0);" class = "glyphicon glyphicon-pencil" 
						style = "text-decoration:none;" onclick = "phoneClickModify()">修改</a>
				</span>
				<span class="showPhoneSaveBut" style= "padding-top:4px;">
					<button class = "btn btn-sm btn-primary" onclick = "savePhone()">保存</button>
				</span>
				&nbsp;&nbsp;
				<span class = "savePhoneSucc glyphicon glyphicon-saved" 
						style = "fonr-size:14px;color:green">保存成功</span>
				<span class="phoneWarn" style= "color:red;font-weight:bold;"></span>
				<br>
				<hr/>
			</div>
			
			<div class = "row remarksArea" style = "min-height:50px;margin-right:5px;word-break:break-all;">
				<span style = "font-weight:bold;font-size:17px;">备注：</span>
				&nbsp;&nbsp;
				<span class = "saveRemarksSucc glyphicon glyphicon-saved" 
						style = "fonr-size:14px;color:green">保存成功</span>
				<span class="showRemarksModifyBut" style= "padding-top:5px;">
					<a href = "javascript:void(0);" class = "glyphicon glyphicon-pencil" 
						style = "text-decoration:none;" onclick = "remarksClickModify()">修改</a>
				</span><br/>
				<span class = "displayRemarks" style = "font-size:20px;">${user.remarks }</span>
				<span class = "displayRemarksModify" style = "font-size:20px;padding-left:15%;">
					<textarea rows="3"style = "display:inline;width:255px;"
						name = "newRemarks" id = "newRemarks" class = "form-control">
						${user.remarks }
					</textarea>
				</span>
				
				<span class="showRemarksSaveBut" style= "padding-top:4px;">
					&nbsp;&nbsp;
					<button class = "btn btn-sm btn-primary" style = "margin-bottom:15px;"
						 onclick = "saveRemarks()">保存</button>
				</span>
				<br/>
				<span class="remarksWarn" style= "color:red;font-weight:bold;padding-left:15%;"></span>
			</div>
			
		</div>
		</div>
		<%-- <form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/info" 
			 method="post" class="form-horizontal">
		<tags:message content="${message}"/>
		
		<div class="form-group">
			<label class="col-sm-2 control-label" style = "text-align:left;">姓名:</label>
			<div class="col-sm-6">
				${user.name}
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-1 control-label" style = "text-align:left;">登录名:</label>
			<div class="col-sm-3">
				${user.loginName}
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
		
		<div class="form-group emailArea" style = "min-height:34px;">
			<label class="col-sm-1 control-label" style = "text-align:left;margin-top:3px;">邮箱:</label>
			<div class="col-sm-3" style = "padding-top:5px;">
				<span class = "displayEmail" style = "padding-left:0px;">${user.email}</span>
				<span class="showEmailBut" style= "padding-top:5px;"></span>
				<span class="emailWarn" style= "color:red;font-weight:bold;"></span>
			</div>
		</div>
		
		<div class="form-group phoneArea" style = "min-height:34px;">
			<label class="col-sm-1 control-label" style = "text-align:left;margin-top:3px;">电话:</label>
			<div class="col-sm-3" style = "padding-top:5px;">
				<span class = "displayPhone" style = "padding-left:0px;">${user.phone}</span>
				<span class="showPhoneBut" style= "padding-top:5px;"></span>
				<span class="phoneWarn" style= "color:red;font-weight:bold;"></span>
			</div>
		</div> 
		
		<div class="form-group">
			<label class="col-sm-1 control-label" style = "text-align:left;">手机:</label>
			<div class="col-sm-3">
				<form:input path="mobile" htmlEscape="false" maxlength="200" class="required form-control mobile"/>
			</div>
			<label class="col-sm-3 mobileWarn"></label>
		</div>
		
		<div class="form-group remarksArea" style = "min-height:34px;">
			<label class="col-sm-1 control-label" style = "text-align:left;margin-top:3px;">备注:</label>
			<div class="col-sm-3" style = "padding-top:5px;">
				<span class = "displayRemarks" style = "padding-left:0px;">${user.remarks}</span>
				<span class="showRemarksBut" style= "padding-top:5px;"></span>
				<span class="remarksWarn" style= "color:red;font-weight:bold;"></span>
			</div>
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
		
		<!-- <div class="form-actions" style = "margin-left:25%;">
			<input id="btnSubmit" class="btn btn-primary" onclick = "valiSubmit();" style = "width:70px;" value="保 存"/>
		</div> -->
	</form:form> --%>
	
	<script type="text/javascript">
		
		var emailVal = $('.displayEmail').text();
		var phoneVal = $('.displayPhone').text();
		var remarksVal = $('.displayRemarks').text();
		
		//该变量保证在鼠标移出input框的时候，input框不会被清空。
		//如果没有，那么由于使用了hover,再empty的话，鼠标一移出马上就会被清空。
		var showEmailEdit = false;
		var showPhoneEdit = false;
		var showRemarksEdit = false;
		
		
		//==================================================
		//      				修改邮箱
		//==================================================
			
		//显示修改按钮
		$('.emailArea').hover(
			function(){
				if(showEmailEdit == false) $('.showEmailModifyBut').show();
			},
			function(){
				if(showEmailEdit == false) $('.showEmailModifyBut').hide();
			}
		);
		
		//显示 输入框 和 保存按钮
		function emailClickModify(){
			showEmailEdit = true;

			$('.displayEmail').hide();
			
			//原来Email的可能是旧的数据，所以需要先赋值再显示
			$('#newEmail').val(emailVal);
			$('.displayEmailModify').show();
			
			$('.showEmailModifyBut').hide();
			$('.showEmailSaveBut').show();
		}
		
		/* //在input 框外如果点击了，证明用户不再想要修改，则样式返回原来的。
		//Ps：但是鼠标移出的话可能是误操作，所以会有上面的showEmailEdit变量
		$("body",parent.document).click(function(event){
			if( ($(".emailArea").find(event.target).length == 0) 
					&& (showEmailEdit == true) )
					resetEmail();
		});
		$("body").click(function(event){			
			if( ($(".emailArea").find(event.target).length == 0) 
					&& (showEmailEdit == true))
				resetEmail();
		}); */
		
		//保存新的邮箱
		function saveEmail(){
			var newEmail = $('#newEmail').val();
			var validOK = true;
			
			//判断邮箱是否合理
			var reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
			if(!reg.test(newEmail)) {
			    $('.emailWarn').empty();
			    $('.emailWarn').append("邮箱格式不正确");
			    validOK = false;
			}
			if(newEmail.length > 40){
				$('.emailWarn').empty();
			    $('.emailWarn').append("邮箱不合理！");
			    validOK = false;
			}
			
			if(validOK == true){
				$.ajax({
					url:'updateEmail',
					data:{
						newEmail:newEmail
					},
					method:'post',
					dataType:'json',
					success:function(data){
						if(data.msg == "success"){
							
							emailVal = newEmail;
							//保存成功后重置
							resetEmail();
							
							$('.saveEmailSucc').show(300).delay(3000).hide(300);
						}
					},
					error:function(){
						alert("opps,出错了！");
					}
				});
			}
			
			//重置
			validOK == true
		};
		
		//由于在鼠标在编辑的时候移出输入框单击，以及保存成功后都需要重置，所以用公共方法
		function resetEmail(){
			
			//原来Email的可能是旧的数据，所以需要先赋值再显示
			$('.displayEmail').empty();
			$('.displayEmail').append(emailVal);
			$('.displayEmail').show();
			
			$('.displayEmailModify').hide();
			$('.showEmailSaveBut').hide();
			
			$('.emailWarn').empty();
			showEmailEdit = false;
		}
		
		
		//==================================================
		//      				修改电话
		//==================================================
			
		//显示修改按钮
		$('.phoneArea').hover(
			function(){
				if(showPhoneEdit == false) $('.showPhoneModifyBut').show();
			},
			function(){
				if(showPhoneEdit == false) $('.showPhoneModifyBut').hide();
			}
		);
		
		//显示 输入框 和 保存按钮
		function phoneClickModify(){
			showPhoneEdit = true;

			$('.displayPhone').hide();
			
			//原来Phone的可能是旧的数据，所以需要先赋值再显示
			$('#newPhone').val(phoneVal);
			$('.displayPhoneModify').show();
			
			$('.showPhoneModifyBut').hide();
			$('.showPhoneSaveBut').show();
		}
		
		/* //在input 框外如果点击了，证明用户不再想要修改，则样式返回原来的。
		//Ps：但是鼠标移出的话可能是误操作，所以会有上面的showPhoneEdit变量
		$("body",parent.document).click(function(event){
			if( ($(".phoneArea").find(event.target).length == 0) 
					&& (showPhoneEdit == true) )
					resetPhone();
		});
		$("body").click(function(event){			
			if( ($(".phoneArea").find(event.target).length == 0) 
					&& (showPhoneEdit == true))
				resetPhone();
		}); */
		
		//保存新的电话
		function savePhone(){
			var newPhone = $('#newPhone').val();
			var validOK = true;
			
			//判断电话号码是否合理
			var regTel = /^0?1[3|4|5|8][0-9]\d{8}$/;
			if(!regTel.test(newPhone)) {
			    $('.phoneWarn').empty();
			    $('.phoneWarn').append("号码格式有误！");
			    validOK = false;
			}
			
			if(validOK == true){
				$.ajax({
					url:'updatePhone',
					data:{
						newPhone:newPhone
					},
					method:'post',
					dataType:'json',
					success:function(data){
						if(data.msg == "success"){
							
							phoneVal = newPhone;
							//保存成功后重置
							resetPhone();
							
							$('.savePhoneSucc').show(300).delay(3000).hide(300);
						}
					},
					error:function(){
						alert("opps,出错了！");
					}
				});
			}
			
			//重置
			validOK == true
		};
		
		//由于在鼠标在编辑的时候移出输入框单击，以及保存成功后都需要重置，所以用公共方法
		function resetPhone(){
			
			//原来phone的可能是旧的数据，所以需要先赋值再显示
			$('.displayPhone').empty();
			$('.displayPhone').append(phoneVal);
			$('.displayPhone').show();
			
			$('.displayPhoneModify').hide();
			$('.showPhoneSaveBut').hide();
			
			$('.phoneWarn').empty();
			showPhoneEdit = false;
		}	
		
		
		//==================================================
		//      				修改备注
		//==================================================
			
		//显示修改按钮
		$('.remarksArea').hover(
			function(){
				if(showRemarksEdit == false) $('.showRemarksModifyBut').show();
			},
			function(){
				if(showRemarksEdit == false) $('.showRemarksModifyBut').hide();
			}
		);
		
		//显示 输入框 和 保存按钮
		function remarksClickModify(){
			showRemarksEdit = true;

			$('.displayRemarks').hide();
			
			//原来Remarks的可能是旧的数据，所以需要先赋值再显示
			$('#newRemarks').val(remarksVal);
			$('.displayRemarksModify').show();
			
			$('.showRemarksModifyBut').hide();
			$('.showRemarksSaveBut').show();
		}
		
		//在input 框外如果点击了，证明用户不再想要修改，则样式返回原来的。
		//Ps：但是鼠标移出的话可能是误操作，所以会有上面的showRemarksEdit变量
		/* $("body",parent.document).click(function(event){
			if( ($(".remarksArea").find(event.target).length == 0) 
					&& (showRemarksEdit == true) )
					resetRemarks();
		});
		$("body").click(function(event){			
			if( ($(".remarksArea").find(event.target).length == 0) 
					&& (showRemarksEdit == true))
				resetRemarks();
		}); */
		
		//保存新的备注
		function saveRemarks(){
			var newRemarks = $('#newRemarks').val();
			var validOK = true;
			
			//判断备注是否合理
			if(newRemarks.length > 200){
				$('.remarksWarn').empty();
			    $('.remarksWarn').append("备注字数过长，需要在200字符以内！");
			    validOK = false;
			}
			
			if(validOK == true){
				$.ajax({
					url:'updateRemark',
					data:{
						newRemark:newRemarks
					},
					method:'post',
					dataType:'json',
					success:function(data){
						if(data.msg == "success"){
							
							remarksVal = newRemarks;
							//保存成功后重置
							resetRemarks();
							
							$('.saveRemarksSucc').show(300).delay(3000).hide(300);
						}
					},
					error:function(){
						alert("opps,出错了！");
					}
				});
			}
			
			//重置
			validOK == true
		};
		
		//由于在鼠标在编辑的时候移出输入框单击，以及保存成功后都需要重置，所以用公共方法
		function resetRemarks(){
			
			//原来Remarks的可能是旧的数据，所以需要先赋值再显示
			$('.displayRemarks').empty();
			$('.displayRemarks').append(remarksVal);
			$('.displayRemarks').show();
			
			$('.displayRemarksModify').hide();
			$('.showRemarksSaveBut').hide();
			
			$('.remarksWarn').empty();
			showRemarksEdit = false;
		}
		
		//==================================================
		//      				修改密码
		//==================================================
			
		//点击修改密码
		function clickModifyPwd(){
			$('.pwdModify').hide();
			$('.showPwdModify').show();
			$('.pwdFont').css("width","60px");
		}
		//保存修改的密码
		function savePwd(){
			
			//再次点击保存的时候，可能已经修改成合适的值，那么不需要显示warn。
			$('.pwdNotEmptyWarn').empty();
			$('.pwdIsSameWarn').empty();
			$('.oldPwdNotEmpty').empty();
			
			var oldPassword = $('#oldPassword').val();
			var newPassword = $('#newPassword').val();
			var newPassword1 = $('#confirmNewPassword').val();
			
			var validOK = true;
			
			console.log("oldPassword = " + oldPassword);
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
				$.ajax({
					url:'updatePwd',
					data:{
						oldPassword:oldPassword,
						newPassword:newPassword
					},
					method:'post',
					dataType:'json',
					success:function(data){
						if(data.msg == "success"){
							
							$('.pwdFont').css("width","300px");
							$('.pwdModify').show();
							$('.showPwdModify').hide();
							
							$('.savePwdSucc').show(300).delay(3000).hide(300);
						} else {
							$('.oldPwdNotEmpty').append("旧密码有误，保存失败！");
						}
					},
					error:function(){
						alert("opps,出错了！");
					}
				});
			}
			validOK = true;
		}
	</script>
</body>
</html>