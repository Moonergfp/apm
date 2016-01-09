<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>终端监控</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/terminal/terminalMonitor.css">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/terminal/terminalSettings.css">
	<script type="text/javascript" src="${ctxStatic}/js/terminal/terminalMonitor.js"></script>

</head>
<body>
	<tags:message content="${message}"/>
	<div class="div_top">
		<div class="div_bottom">
			<ul class="nav nav-tabs">
				<li><a href="${ctx}/terminal/info">终端信息</a></li>
				<li class="active"><a href="${ctx}/terminalMonitor/monitor">终端监控</a></li>
				<li><a href="${ctx}/terminalSettings/screenShootPage">终端设置</a></li>
			</ul>
		</div>
	</div>
	
	<div id="monitor">
		<!--警告框 -->
		<div class="alert alert-danger alert-dismissible" id="showAlertInfo" role="alert" style="display:none">
			 <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<span class="info"></span>
		</div>
		<!-- 终端分组面板-->
		<div class="div_left">
			<div class="title">所有分组（${totalNum}）</div>
			<div class="container">
				<div class="leftsidebar_box">
					<div class="line"></div>
					 <c:forEach var="group" items="${terminalGroupList}">
						<dl>
							<dt>${group.name}（${group.terminalNum}）<span class="groupid" hidden>${group.id}</span>
								<img src="${ctxStatic}/images/terminal/select_xl01.png"></dt>
							<!--  <dd class="first_dd"><a href="#">充值记录</a></dd>
							<dd><a href="#">短信充值记录</a></dd>
							<dd><a href="#">消费记录</a></dd>
							<dd><a href="#">操作记录</a></dd> -->
						</dl>
					</c:forEach>
				</div>
			
			</div>
				<script type="text/javascript">
				$(".leftsidebar_box dt").css({"background-color":"#F2F2F2"});
				$(".leftsidebar_box dt img").attr("src","${ctxStatic}/images/terminal/select_xl01.png");
				$(function(){
					$(".leftsidebar_box dd").hide();
					$(".leftsidebar_box dt").click(function(){
						$(".leftsidebar_box dt").css({"background-color":"#F2F2F2"})
						$(this).css({"background-color": "#F2F2F2"});
						$(this).parent().find('dd').removeClass("menu_chioce");
						
						/*切换下拉图标  */
						var img = $(this).find("img").attr("src");
						if(img == '${ctxStatic}/images/terminal/select_xl01.png'){
							$(this).find("img").attr("src",'${ctxStatic}/images/terminal/select_xl.png');
						}else{
							$(this).find("img").attr("src",'${ctxStatic}/images/terminal/select_xl01.png');
						}
						//获取分组终端列表，动态创建DOM分组列表
						var groupid = $(this).find('.groupid').text();
						var obj = $(this);
						var url = '${ctx}/terminalMonitor/findTerminals?terminalGroup.id=' +groupid;
						if($(this).parent().find("dd").size() == 0 ){
							$.ajax({
								url:url,
								success:function(terminalList){
									var html = "";
									for(var item in terminalList){   //apend终端
										html = html + "<dd><a href=\"${ctx}/terminalMonitor/monitor?id="+terminalList[item].id+"\">"+terminalList[item].name+"</a></dd>";
									}
									obj.after(html);
									
								}
							});
						}
						$(".menu_chioce").slideUp(); 
						$(this).parent().find('dd').slideToggle();
						$(this).parent().find('dd').addClass("menu_chioce");
					});
					
				})
			</script>
		</div>
		
		
		
		
		<!-- 终端监控信息面板 -->
		<div class="div_mid">
			<span style="display:none" id="terminalId">${fisrtTerminal.id}</span>
			<div class="title">
				<span>上次截屏时间：2015-07-19  20:45 </span>
				<button class="btn btn-primary" type="button" onclick="sendScreenShootReq2Netty()">实时截屏</button>
			</div>
			<!-- 屏幕 -->
			<div class="screen">
				<div class="div_img">
					<img src="${screenShoot.path}" alt="">
				</div>
			</div>
			<!-- 终端设置按钮 -->
			<div class="btBox">
				<button class="btn_voice btn btn-primary" type="button" onclick="voicetoggle()">音量设置</button>
				<div class="bt_voicen_num" style="display:none">
					<div class="grade_warp">
						<div class="User_ratings User_grade">
							<div class="ratings_bars">
								<span id="title0">0</span>
								<span class="bars_10">0</span>
								<div class="scale" id="bar0">
									<div></div>
									<span id="btn0"></span>
								</div>
								<span class="bars_10">100</span>
							</div>
						</div>
					</div>	
				</div>
				<div class="bt_nomal">
					<button class="btn btn-primary" type="button" data-toggle="modal" data-target="#reStartModal">重启</button>
					<button class="btn btn-primary" type="button" data-toggle="modal" data-target="#shutDownModal">关机</button>
					<!-- <button class="btn btn-primary" type="button" onclick="sendTerminalStatusReq2Netty(14)">开机</button>
					 -->
					<!-- Modal -->
					
					<div class="warning">
						<div class="modal fade" id="reStartModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
						  <div class="modal-dialog" role="document">
						    <div class="modal-content">
						      <div class="modal-body" style="margin-top: 50px;">
						      	<div><img style="width: 100px;" src="${ctxStatic}/images/terminal/warning.png" alt=""></div>
						      	<div style="margin-top:5px font-size: 20px;"><span>确定要重启？</span></div>
						      </div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-primary" onclick="sendTerminalStatusReq2Netty(10)">确定</button>
						        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						      </div>
						    </div>
						  </div>
						</div>
					</div>

					<div class="warning">
						<div class="modal fade" id="shutDownModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
						  <div class="modal-dialog" role="document">
						    <div class="modal-content">
						      <div class="modal-body" style="margin-top: 50px;">
						      	<div><img style="width: 100px;" src="${ctxStatic}/images/terminal/warning.png" alt=""></div>
						      	<div style="margin-top:5px font-size: 20px;"><span>确定要关机？</span></div>
						      </div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-primary" onclick="sendTerminalStatusReq2Netty(9)">确定</button>
						        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						      </div>
						    </div>
						  </div>
						</div>
					</div>
				</div>
			</div>
			<hr>
			<!-- 终端状态，时间 -->
			<div class="staticinfo">
				<div class="terminal_info">
					<div class="terminal"><span>终端名称：${fisrtTerminal.name}</span></div>
					<div class="terminal_status">终端状态：<span><span></div>
				</div>
				<div class="terminal_worktime">
					<div class="work">
						<span>工作时间：</span>
						<ul>
							<c:forEach var="time" items="${workTime}">
								<li>${time }</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
			<hr>

			<!-- 截屏查看 -->
			<div class="fixedScreen">	
				<div class="div_findmore">
					<a class="btn btn-primary" href="${ctx}/terminalMonitor/fixedTimeAxis?id=${fisrtTerminal.id}">查看更多</a>
				</div>
				<div id="four_flash">
					<div class="flashBg">
						<ul class="mobile">							
							 <c:forEach var="img" items="${screenShoots}">
								<li><img src="${img.path}"></li>
							</c:forEach>
						</ul>
					</div>
					<div class="but_left but"><img src="${ctxStatic}/images/terminal/qianxleft.png" /></div>
					<div class="but_right but"><img src="${ctxStatic}/images/terminal/qianxr.png" /></div>
			    </div>
		
				<script type="text/javascript">
				var _index5=0;
				var pages = 0;
				$("#four_flash .but_right img").click(function(){
					console.log("but_right");
					console.log(_index5);
					_index5+=3;
					pages++;
					var len=$(".flashBg ul.mobile li").length;

					if(_index5>len-6){
						_index5 = len-6;
						pages = _index5/3;
						/*$("#four_flash .flashBg ul.mobile").stop().append($("ul.mobile").html());*///停止当前动画
					}else{
						$("#four_flash .flashBg ul.mobile").stop().animate({left:-pages*168*3},1000);


					}
				});

					
				$("#four_flash .but_left img").click(function(){

					console.log("but_left");
					console.log(_index5);
					console.log("pages");
					console.log(pages);
					_index5-=3;
					pages--;
					if(pages < 0){
						_index5 = 0;
						pages = 0;
						/*$("ul.mobile").prepend($("ul.mobile").html()); */
						/*$("ul.mobile").css("left","-1380px");
						_index5=6*/
					}else{
						$("#four_flash .flashBg ul.mobile").stop().animate({left:-pages*168*3},1000);


					}
					
					});
				</script>
			</div>
		</div>
		<!-- 终端节目列表，存储面板 -->
		<div class="div_right">
			<div class="program">
				<div class="title"><span>节目列表</span><button class="btn btn-primary">清空</button></div>
				<div class="div_programlist">
					<span class="curretnProId" style="display:none"></span>
					<hr>
					<ul>
						<c:forEach var="pro" items="${pros }">
							<li>
								<div class="div_program">
									<span title="${pro.name}">${pro.name}</span>
									<span title="${pro.id}" class="proId" style="display:none">${pro.id}</span>
								</div>
								<button class="btn btn-primary delpro">删除</button>
							</li>
							<hr>
						</c:forEach>
					</ul>
				</div>
			</div>
			<!-- 内存面板 -->
			<div class="memery">
				<div>
					<dl>
						<dt>本地存储<button class="btn btn-primary">格式化</button></dt>
						<dd class="all">总容量：<span></span>M</dd>
						<dd class="occupation">已使用：<span></span>M</dd>
						<dd class="remain">剩余：<span></span>M</dd>
					</dl>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
