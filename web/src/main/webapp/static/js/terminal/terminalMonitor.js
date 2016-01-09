/*终端监控js*/


		$(function(){
			/*获取终端的基本信息*/
			var url = "/apm-web/a/terminalMonitor/getTerminalInfo";
			var tId = $("#terminalId").text(); //终端id
			var data={"id":tId};
			$.ajax({
				url:url,
				data:data,
				dataType:"json",
				type:"POST",
				success:function(terminalInfo){
					if(!terminalInfo){
						alert("系统错误，请联系管理员");
						return;
					}
					$(".terminal_info .terminal_status").find("span").text(terminalInfo.status);  
					$(".memery .all").find("span").text(terminalInfo.mem);
					$(".memery .occupation").find("span").text(terminalInfo.usedMem);
					$(".memery .remain").find("span").text(terminalInfo.avalialbeMem);
					$(".div_right .program .curretnProId").text(terminalInfo.programId);
					var spanList = $(".div_right .program .div_programlist .proId");
					console.log(spanList);
					console.log("当前播放终端ID==》" + terminalInfo.programId);
					spanList.each(function(){
						if(terminalInfo.programId == $(this).text()){
							console.log($(this).parent());
							$(this).parent().find("span").eq(0).addClass('glyphicon glyphicon-play-circle');
							
						}
					})
					console.log($(spanList[0]).text());
					//$(".div_right .program .curretnPro").prepend("<span class='glyphicon glyphicon-play-circle'></span>");
				}
			});

			// 滑动条效果
			scale = function (btn, bar, title) {
				this.btn = document.getElementById(btn);
				this.bar = document.getElementById(bar);
				this.title = document.getElementById(title);
				
				this.step = this.bar.getElementsByTagName("DIV")[0];
				this.init();
			};
			scale.prototype = {
				init: function () {
					var f = this, g = document, b = window, m = Math;
					f.btn.onmousedown = function (e) {
						var x = (e || b.event).clientX;
						var l = this.offsetLeft;
						var max = f.bar.offsetWidth - this.offsetWidth;
						g.onmousemove = function (e) {
							var thisX = (e || b.event).clientX;
							var to = m.min(max, m.max(-2, l + (thisX - x)));
							f.btn.style.left = to + 'px';
							f.ondrag(m.round(m.max(0, to / max) * 100), to);
							b.getSelection ? b.getSelection().removeAllRanges() : g.selection.empty();
						};
						g.onmouseup = new Function('this.onmousemove=null');
					};
				},
				ondrag: function (pos, x) {
					this.step.style.width = Math.max(0, x) + 'px';
					this.title.innerHTML = pos  + '';
				}
			}
			new scale('btn0', 'bar0', 'title0');
			new scale('btn1', 'bar1', 'title1');
			new scale('btn2', 'bar2', 'title2');
			new scale('btn3', 'bar3', 'title3');
			new scale('btn4', 'bar4', 'title4');

			$('#shutDownModal').on('show.bs.modal', function () {
				console.log($("body").css("padding-right"));
				$("body").css("padding-right","0px");
			})
			$('#shutDownModal').on('shown.bs.modal', function () {
				console.log($("body").css("padding-right"));
				$("body").css("padding-right","0px");
			})
				$("body").css("padding-right","0px");
		});
		

/*切换音量设置显示效果*/
function voicetoggle(){
	console.log("切换显示");
	console.log($(".bt_voicen_num"));
	$(".bt_voicen_num").toggle('slow');
}

var interval;  //定时器，定时去获取截屏图片
var times = 0;
//发送截屏命令
function sendScreenShootReq2Netty(){
	var tId = $("#terminalId").text(); //终端id
	console.log("terminaId==>" + tId);
	var data={"id":tId};
	$.ajax({	//向web服务器发送获取图片指令
		url:"/apm-web/a/terminalMonitor/sendScreenShootReq2Netty",
		data:data,
		dataType:"text",
		type:"POST",
		success:function(data){
			console.log(data);
			if("ok" == data){//指令发送成功
				//截屏面板loading
				$(".screen").find("img").remove();
				$(".screen").find(".div_img").append("<img class='fixedImg' src='/apm-web/static/images/terminal/loading.gif'>");
				$img = $(".screen").find(".fixedImg");
				$img.css({"width":"40px","height":"40px","position":"relative","left":"50%","margin-left":"-20px","top":"50%","margin-top":"-20px"});

				//定时器去获取截屏图
				var sysTime = new Date().getTime();//获取当前时间
				interval = setInterval(function(){getScreenShoot(tId,sysTime)}, "2000");    //10s
			}else{		//指令发送失败
				alert("系统错误，请联系管理员!!");
			}
		}	
	});
}
	
/*获取实截屏图片*/
function getScreenShoot(terminalId,sysTime){
	console.log("当前时间==>" + sysTime);
	times = times+1;
	if(times > 5){
		alert("请求超时");
		clearInterval(interval);
	}
	var url = "/apm-web/a/terminalMonitor/getScreenShoot";
	var data ={"terminalId":terminalId,"time":sysTime};
	$.ajax({
		data:data,
		url:url,
		success:function(imgUrl){
			console.log("获取图片路径==》" + imgUrl);
			if(!imgUrl){
				
			}else{
				clearInterval(interval);  //获取路径成功，则停止定时器
				$(".screen").find("img").remove();
				$(".screen").find(".div_img").append("<img src='"+imgUrl+"'>");
			}
		}
	});
}
var showAlertInfoInterval;//警告框定时器
function sendTerminalStatusReq2Netty(type){
	if(type == 10){	//重启
		$('#reStartModal').modal('hide');
	}else if(type == 9){
		$('#shutDownModal').modal('hide');
	}
	
	var tId = $("#terminalId").text(); //终端id
	var url = "/apm-web/a/terminalMonitor/sendTerminalStatusReq2Netty";
	var data ={"id":tId,"type":type};
	$.ajax({
		data:data,
		url:url,
		success:function(result){
			console.log(result);
			$("#showAlertInfo").show("slow");
			if(result == 'ok'){
				$("#showAlertInfo").removeClass("alert-danger");
				$("#showAlertInfo").addClass("alert-success");
				if(type == 10){
					$("#showAlertInfo").find(".info").text("重启成功");
				}else if(type == 9){
					$("#showAlertInfo").find(".info").text("关机成功");
				}else if(type == 14){
					$("#showAlertInfo").find(".info").text("开机成功");
				}
			}else{
				$("#showAlertInfo").removeClass("alert-success");
				$("#showAlertInfo").addClass("alert-danger");
				if(type == 10){
					$("#showAlertInfo").find(".info").text("系统错误,重启失败");
				}else if(type == 9){
					$("#showAlertInfo").find(".info").text("系统错误,关机失败");
				}else if(type == 14){
					$("#showAlertInfo").find(".info").text("系统错误,开机失败");
				}
			}
			showAlertInfoInterval = setInterval(function(){	//2s警告框消失
				$("#showAlertInfo").hide("slow");
			},2000);
		}
	});

}
