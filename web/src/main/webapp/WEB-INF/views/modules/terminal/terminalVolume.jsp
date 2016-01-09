<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>终端设置音量设置</title>
	<meta name="decorator" content="default"/>
	
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/terminal/terminalSettings.css">
	
	<!-- 实现开关功能 -->
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/bootstrap-3.3.5-dist/css/bootstrap-switch.min.css">
	<script type="text/javascript" src="${ctxStatic}/bootstrap-3.3.5-dist/js/bootstrap-switch.min.js"></script>
	
	<!-- 实现音量拖动功能 -->
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/terminal/terminalMonitor.css">
	<script type="text/javascript" src="${ctxStatic}/js/terminal/terminalMonitor.js"></script>
	
	<script type="text/javascript" src="${ctxStatic}/js/terminal/terminalSettings.js"></script>
	
	<style type="text/css">
	.colorSelect{
		background-color: #E8E8E8;
	}
	.colorNotSelect{
		background-color: white;
	}
		.timeSwitch{
	 		display: none; 	
		}
		.setVol1{
	 		display: none; 	
		}
		.setVol2{
	 		display: none; 	
		}
		.setVol3{
	 		display: none; 	
		}
		.setVol4{
	 		display: none; 	
		}
		.volSetBtn1{
	 		display: none; 	
		}
		.volSetBtn2{
	 		display: none; 	
		}
		.volSetBtn3{
	 		display: none; 	
		}
		.volSetBtn4{
	 		display: none; 	
		}
		
	</style>
</head>

<body>
	<tags:message content="${message}"/>
	<div class="div_top">
		<div class="div_bottom">
			<ul class="nav nav-tabs">
				<li><a href="${ctx}/terminal/info">终端信息</a></li>
				<li><a href="${ctx}/terminalMonitor/monitor">终端监控</a></li>
				<li class="active"><a href="${ctx}/terminalSettings/screenShootPage">终端设置</a></li>
			</ul>
		</div>
	</div>
	
	<div class="main">
	<!-- 列表 （分组和终端列表）-->
		<div class="list">
			<div class = "group" style = "float:left;padding-left:5px;">
					<table class="table table-responsive" style="border: 1px solid #D1D1D1;min-width:200px;">
						<tr>
							<td class = "allgroup">
								<!-- <input type = "checkbox"> -->
								<img src="${ctxStatic}/images/terminal/empty.png" width="17px;" height="17px;">
								<span class = "paddingTop5px">所有组（${totalTerminalNum }）</span>
							</td>
						</tr>
							<c:choose>
								<c:when test="${terminalGroup.name == '未分组' }">
									<tr class = "unDividedgroup colorSelect">
								</c:when>
								
								<c:when test="${terminalGroup.name != '未分组' }">
									<tr class = "unDividedgroup">
								</c:when>
							</c:choose>
							<td style = "cursor:pointer">
								<input type = "hidden" id = "unDividedgroupId" value = "${unDividedGroup.id}">
								<!-- <input type = "checkbox" id = "groupSelectAll"> -->
								<img class = "imgArea_group empty" src="${ctxStatic}/images/terminal/empty.png" width="17px;" height="17px;" >
								
								<a href = "javascript:void(0)" style = "text-decoration:none;">
									未分组（${unDividedGroup.terminalNum }）
								</a>
							</td>
						</tr>
						<c:forEach items="${terminalGroupList }" var="terminalGroup">
							<tr class = "groupItem">
								<td style = "cursor:pointer">
									<input type = "hidden" id = "terminalGroupId" value = "${terminalGroup.id}">
									<!-- <input id = "groupSelectAll" type = "checkbox"> -->
									<img class = "imgArea_group empty" src="${ctxStatic}/images/terminal/empty.png" width="17px;" height="17px;" >
									<a href = "javascript:void(0)" style = "text-decoration:none">
										${terminalGroup.name }（${terminalGroup.terminalNum }）
									</a>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			<div class = "terminalList" style = "float:left;padding-left:12px;">
						<table class="table table-responsive" style="border: 1px solid #D1D1D1;min-width:200px;">
							<tr class = "terminalGroupName">
								<td>
									<input type = "hidden" id = "selectedGroupId" value = "${terminalGroup.id}">
									<input type = "hidden" id = "selectedGroupName" value = "${terminalGroup.name}">
									<input type = "hidden" id = "selectedGroupNum" value = "${terminalGroup.terminalNum}">
									
									<a class = "terminalGroupName_a" href = "javascript:void(0)" style = "text-decoration:none">
										${terminalGroup.name}（${terminalGroup.terminalNum }）
									</a>
								</td>
							</tr>
							<c:forEach items="${terminalList }" var="terminal">
								<tr class = "terminalItem">
									<td>
										<input type = "hidden" value = "${ terminal.id}" id = "terminalId">
										<!-- <input type = "checkbox" class = "terminalCheckbox"> -->
										<img class = "imgArea_terminal empty" src="${ctxStatic}/images/terminal/empty.png" width="17px;" height="17px;" >
										<a href = "javascript:void(0)" style = "text-decoration:none">
											${terminal.name }
										</a>
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
		</div>
		
		<!-- 设置面板 -->
		<div class="settings">
			<div class="navication">
				<ul class="nav nav-tabs">
					<li><a href="${ctx}/terminalSettings/screenShootPage">截屏设置</a></li>
					<li><a href="#">桌面设置</a></li>
					<li><a href="${ctx}/terminalSettings/onOffModePage">定时开关</a></li>
					<li><a href="${ctx}/terminalSettings/brightSetting">亮度设置</a></li>
					<li class="active"><a href="${ctx}/terminalSettings/volumeSetting">音量设置</a></li>
					<li><a href="${ctx}/terminalSettings/format">格式化</a></li>
					<li><a href="${ctx}/terminalUpgrade/upgrade">在线升级</a></li>
				</ul>
			</div>
			
			<div class = "showDetail" style = "padding:5px 5px;">
				<div class = "text-right">
					<span class = "setVolmsg" style = "color:red;font-size:17px;font-weight:bold"></span>
					<button class = "btn btn-info" onclick = "setAndSave();">设置并保存</button>
				</div>
				<div class = "text-right">
					<span class = "terminalEmptyWarn" style = "color:red;font-size:17px;font-weight:bold;"></span>
				</div>				
				<div style = "background-color:#D1D1D1;margin-top:10px;">
					<div style = "float:left;padding-top:5px;">
						<span style = "font-weight:bold;font-size:17px;">音量控制</span>
					</div>
					<div style = "float:right;width: 20%; margin-right: 25px;">
						<select class = "form-control selectPattern">
							<option onclick = "always();" value = "1">常开</option>
							<option onclick = "timing();" value = "0">定时</option>
						</select>
					</div>
					<div style = "clear:both"></div>
				</div>		
				
				<div class="bt_voicen_num _always" style = "margin-top:10px;">
					<div class="grade_warp">
						<div class="User_ratings User_grade">
							<div class="ratings_bars">
								<span id="title0" style = "padding-left:5px;font-weight:bold;color:#808080">0</span>
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
			
				<div class="timeSwitch">
					<ul>
						<li style = "padding-top:10px;">
							<div>
								<input  class="form-control s1"  value="" placeholder="开始时间"  	
			            			name="s1" type="text" readonly="readonly"  class="form-control"   
			            			onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
			            			style = "width:120px;display:inline"/>
				            	&nbsp;&nbsp;		
		            			<input  class="form-control e1"  value="" placeholder="结束时间"  	
				            		name="e1" type="text" readonly="readonly"  class="form-control"   
				            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
				            		style = "width:120px;display:inline"/>
				            	&nbsp;&nbsp;
				            	<button class = "btn btn-primary volSetBtn1" onclick = "showSetVol1(this);">音量设置</button>
				            	&nbsp;&nbsp;
				            	<span class = "vol1" style = "padding-left:5px;font-weight:bold;color:#808080"></span>
				            	&nbsp;&nbsp;
				            	<input type = "hidden" class = "flag_switch1">
				            	<input type="checkbox" name = "my-checkbox1" class="switch" id="screen_shoot_checkbox1">				            		
							</div>
							<div class = "timeWarn1" style = "color:red;font-weight:bold"></div>
							<div class="bt_voicen_num setVol1" style = "margin-top:10px;">
								<div class="grade_warp">
									<div class="User_ratings User_grade">
										<div class="ratings_bars">
										    <span id="title1" style = "padding-left:5px;font-weight:bold;color:#808080">0</span> 
											<span class="bars_10">0</span>
											<div class="scale" id="bar1"> 
												<div></div>
												 <span id="btn1"></span> 
											</div>
											<span class="bars_10">100</span>
										</div>
									</div>
								</div>	
							</div>
							<div style = "clear:both;"></div>
						</li>

						<li style = "padding-top:10px;">
							<div>
								<input  class="form-control s2"  value="" placeholder="开始时间"  	
			            			name="s1" type="text" readonly="readonly"  class="form-control"   
			            			onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
			            			style = "width:120px;display:inline"/>
				            	&nbsp;&nbsp;		
		            			<input  class="form-control e2"  value="" placeholder="结束时间"  	
				            		name="e1" type="text" readonly="readonly"  class="form-control"   
				            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
				            		style = "width:120px;display:inline"/>
				            	&nbsp;&nbsp;
				            	<button class = "btn btn-primary volSetBtn2" onclick = "showSetVol2(this);">音量设置</button>
				            	&nbsp;&nbsp;
				            	<span class = "vol2" style = "padding-left:5px;font-weight:bold;color:#808080"></span>
				            	&nbsp;&nbsp;
				            	<input type = "hidden" class = "flag_switch2">
				            	<input type="checkbox" name = "my-checkbox2"  class="switch" id="screen_shoot_checkbox1">
							</div>
							<div class = "timeWarn2" style = "color:red;font-weight:bold"></div>
							<div class="bt_voicen_num setVol2" style = "margin-top:10px;">
								<div class="grade_warp">
									<div class="User_ratings User_grade">
										<div class="ratings_bars">
											<span id="title2" style = "padding-left:5px;font-weight:bold;color:#808080">0</span>
											<span class="bars_10">0</span>
											<div class="scale" id="bar2">
												<div></div>
												<span id="btn2"></span>
											</div>
											<span class="bars_10">100</span>
											
										</div>
									</div>
								</div>	
							</div>
							<div style = "clear:both;"></div>
						</li>

						<li style = "padding-top:10px;">
							<div>
								<input  class="form-control s3"  value="" placeholder="开始时间"  	
			            			name="s1" type="text" readonly="readonly"  class="form-control"   
			            			onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
			            			style = "width:120px;display:inline"/>
				            	&nbsp;&nbsp;		
		            			<input  class="form-control e3"  value="" placeholder="结束时间"  	
				            		name="e1" type="text" readonly="readonly"  class="form-control"   
				            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
				            		style = "width:120px;display:inline"/>
				            	&nbsp;&nbsp;
				            	<button class = "btn btn-primary volSetBtn3" onclick = "showSetVol3(this);">音量设置</button>
				            	&nbsp;&nbsp;
				            	<span class = "vol3" style = "padding-left:5px;font-weight:bold;color:#808080"></span>
				            	&nbsp;&nbsp;
				            	<input type = "hidden" class = "flag_switch3">
				            	<input type="checkbox" name = "my-checkbox3"  class="switch" id="screen_shoot_checkbox1">
							</div>
							<div class = "timeWarn3" style = "color:red;font-weight:bold"></div>
							<div class="bt_voicen_num setVol3" style = "margin-top:10px;">
								<div class="grade_warp">
									<div class="User_ratings User_grade">
										<div class="ratings_bars">
											<span id="title3" style = "padding-left:5px;font-weight:bold;color:#808080">0</span>
											<span class="bars_10">0</span>
											<div class="scale" id="bar3">
												<div></div>
												<span id="btn3"></span>
											</div>
											<span class="bars_10">100</span>
											
										</div>
									</div>
								</div>	
							</div>
							<div style = "clear:both;"></div>
						</li>

						<li style = "padding-top:10px;">
						    <div>
								<input class="form-control s4 "  value="" placeholder="开始时间"  	
			            			name="s1" type="text" readonly="readonly"  class="form-control"   
			            			onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
			            			style = "width:120px;display:inline"/>
				            	&nbsp;&nbsp;		
		            			<input  class="form-control e4"  value="" placeholder="结束时间"  	
				            		name="e1" type="text" readonly="readonly"  class="form-control"   
				            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
				            		style = "width:120px;display:inline"/>
				            	&nbsp;&nbsp;
				            	<button class = "btn btn-primary volSetBtn4" onclick = "showSetVol4(this);">音量设置</button>
				            	&nbsp;&nbsp;
				            	<span class = "vol4" style = "padding-left:5px;font-weight:bold;color:#808080"></span>
				            	&nbsp;&nbsp;
				            	<input type = "hidden" class = "flag_switch4">
				            	<input type="checkbox" name = "my-checkbox4"  class="switch" id="screen_shoot_checkbox1">
							</div>
							<div class = "timeWarn4" style = "color:red;font-weight:bold"></div>
							<div class="bt_voicen_num setVol4" style = "margin-top:10px;">
								<div class="grade_warp">
									<div class="User_ratings User_grade">
										<div class="ratings_bars">
											<span id="title4" style = "padding-left:5px;font-weight:bold;color:#808080">0</span>
											<span class="bars_10">0</span>
											<div class="scale" id="bar4">
												<div></div>
												<span id="btn4"></span>
											</div>
											<span class="bars_10">100</span>
											
										</div>
									</div>
								</div>	
							</div>
							<div style = "clear:both;"></div>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">

		// ======================================
		// ===============点击未分组===============
		// ======================================
		$('.unDividedgroup').live('click',function(){
			var terminalGroup_id = $('#unDividedgroupId').val();
			getTerminalInfo(terminalGroup_id,$(this));
		})
		
		// ======================================
		// ===============点击其他分组===============
		// ======================================
		$('.groupItem').live('click',function(){
			var terminalGroup_id = $(this).find('#terminalGroupId').val();
			getTerminalInfo(terminalGroup_id,$(this));
		})
		
		//存放选中的终端
		var terminalIds = new Array();
		
		//判断是否点击复选框，如果点击复选框，那么终端列表需要全部选中
		var addAllTerminal = false;
		
		function getTerminalInfo(terminalGroup_id,element){
			
			$.ajax({
				url:'${ctx}/terminalUpgrade/getTerminalInfo_ajax',
				dataType:'json',
				type:'post',
				data:{
					terminalGroup_id:terminalGroup_id,
				},
				success:function(data){
					if(data.msg == 'success'){
						
						//中间标题的修改
						$('.terminalGroupName_a').empty();
						$('.terminalGroupName_a').append(
								data.selectedTerminalGroup.name + "（"+ 
								data.selectedTerminalGroup.terminalNum +"）");
						
						//中间显示新的终端列表
						$(".terminalItem").remove();
						var size = data.terminalList.length;
						
						for(var i = size-1 ; i >= 0; i--){
							var terminal = data.terminalList[i];
							$('.terminalGroupName').after(
									"<tr class = \"terminalItem\">" + 
										"<td>" + 
											"<input type = \"hidden\" value = \""+terminal.id+"\" " + 
												"id = \"terminalId\" >"+
											/* "<input class = \"terminalCheckbox\" type = \"checkbox\">" +  */
											"<img class = \"imgArea_terminal empty\" src=\"${ctxStatic}/images/terminal/empty.png\" " + 
												"width=\"17px;\" height=\"17px;\" >" +
											"&nbsp;&nbsp;<a href = \"javascript:void(0)\""+ 
												"style = \"text-decoration:none\">" + 
												terminal.name +
											"</a>" +
										"</td>" +
									"</tr>");
						}
						
						$('#selectedGroupId').val(data.selectedTerminalGroup.id);
						$('#selectedGroupName').val(data.selectedTerminalGroup.name);
						$('#selectedGroupNum').val(data.selectedTerminalGroup.terminalNum);
						//去掉之前的背景色，该项选中背景色
						$('.groupItem').removeClass("colorSelect");
						$('.groupItem').addClass("colorNotSelect");
						$('.unDividedgroup').removeClass("colorSelect");
						$('.unDividedgroup').addClass("colorNotSelect");
						$(element).removeClass("colorNotSelect");
						$(element).addClass("colorSelect");
						
						//如果该分组没有终端，那么左侧分组的标志就要变为空
						if(size == 0){
							$($($('.colorSelect').children().get(0)).children().get(1)).attr("src","${ctxStatic}/images/terminal/empty.png");
							$($($('.colorSelect').children().get(0)).children().get(1)).removeClass("notFull");
							$($($('.colorSelect').children().get(0)).children().get(1)).removeClass("full");
							$($($('.colorSelect').children().get(0)).children().get(1)).addClass("empty");
						}
						
						//如果 addAllTerminal 为ture，那么 终端列表需要成为全选状态。并且id值需要给全局变量
						if(addAllTerminal == true){
							
							$('.imgArea_terminal').each(function(){
								$(this).attr("src","${ctxStatic}/images/terminal/full.png");
					    		$(this).addClass("full");
					    		$(this).removeClass("empty");
								
								//如果是已经存在的，那么就不要重复放了
								var isExist = false;
								for(var i = 0; i < terminalIds.length; ++i){
									if(terminalIds[i] == $(this).prev().val()){
										isExist = true;
										break;
									}
								}
								if(isExist != true){
									terminalIds.push($(this).prev().val());
								} else {
									isExist = false;
								}
							});
							
							addAllTerminal = false;
						}

						//如果 removeTheseTerminal = true
						//之后请求后台终端的时候，不会让终端显示为勾选状态，并且会在全局分组中
						//去掉这些终端
						if(removeTheseTerminal == true){
							$('.imgArea_terminal').each(function(){
								var id = $(this).prev().val();
								var j = 0;
								for(var i = 0; i < terminalIds.length; ++i){
									if(terminalIds[i] == id){
										j = i;
										break;
									}
								}
								terminalIds.splice(j,1);
							});
							removeTheseTerminal = false;
						}
						
						//如果选中的终端ID数组有，那么就加入全局样式。
						$('.imgArea_terminal').each(function(){
							for(var i = 0; i < terminalIds.length; ++i){
								if(terminalIds[i] == $(this).prev().val()){
									$(this).attr("src","${ctxStatic}/images/terminal/full.png");
						    		$(this).addClass("full");
						    		$(this).removeClass("empty");
						    		break;
								}
							}
						})
						
						//判断此时需不需要在左侧分组显示半选状态
						//如果上述的全部终端在 全局变量中都有，那么就显示全选；如果部分有，那就显示半选，否则显示不选
						var _size = data.terminalList.length;
						var _existArray = new Array();
						
						for(var i = size-1 ; i >= 0; i--){
							var terminal = data.terminalList[i];
							for(var j = 0;  j < terminalIds.length; ++j){
								if(terminalIds[j] == terminal.id){
									_existArray.push(terminal.id);
									break;
								}
							}
						}
						
						if(_existArray.length == 0){
							$($($('.colorSelect').children().get(0)).children().get(1)).attr("src","${ctxStatic}/images/terminal/empty.png");
							$($($('.colorSelect').children().get(0)).children().get(1)).removeClass("notFull");
							$($($('.colorSelect').children().get(0)).children().get(1)).removeClass("full");
							$($($('.colorSelect').children().get(0)).children().get(1)).addClass("empty");
						
							//如果相同，表示全部存在，那么 左侧分组显示全选
						} else if(_existArray.length == _size){
							$($($('.colorSelect').children().get(0)).children().get(1)).attr("src","${ctxStatic}/images/terminal/full.png");
							$($($('.colorSelect').children().get(0)).children().get(1)).removeClass("empty");
							$($($('.colorSelect').children().get(0)).children().get(1)).removeClass("notFull");
							$($($('.colorSelect').children().get(0)).children().get(1)).addClass("full");
							
						//_existArray != 0，那么 左侧分组显示半选
						} else if(_existArray.length != 0){
							$($($('.colorSelect').children().get(0)).children().get(1)).attr("src","${ctxStatic}/images/terminal/notFull.png");
							$($($('.colorSelect').children().get(0)).children().get(1)).removeClass("empty");
							$($($('.colorSelect').children().get(0)).children().get(1)).removeClass("full");
							$($($('.colorSelect').children().get(0)).children().get(1)).addClass("notFull");
						}
						
						$('.showSelectNum').empty();
						$('.showSelectNum').append(terminalIds.length);
					} else{
						alert("服务器出错，请重新登录，以避免不必要的错误");
					}
				},
				error:function(){
					alert("服务器出错，请重新登录，以避免不必要的错误");
				}
			}) 
		}
		
	
		// ==================================================
		// ===============终端分组背景色的显示和取消================
		//    		鼠标扫到分组上，分组背景被灰，鼠标移走，背景色变白
		// ==================================================
			
		$('.groupItem').live("mouseover",function(){
			$(this).css("cursor","pointer");
			$(this).removeClass("colorNotSelect");
			$(this).addClass("colorSelect");
		})
		$('.groupItem').live("mouseout",function(){	
			if($('.colorSelect').length == 2){
				$(this).removeClass("colorSelect");
				$(this).addClass("colorNotSelect");
			}
		})
		
		// ==================================================
		// ===================终端分组点击全选===================
		// ==================================================
		// 全选的 Item 会保存在该数组中，以判断此次点击是全选还是取消
		var groupSelectAllContainer = new Array();
		//设置 removeTheseTerminal = true
		//之后请求后台终端的时候，不会让终端显示为勾选状态，并且会在全局分组中
		//去掉这些终端
		var removeTheseTerminal = false;
	    $('.imgArea_group').live("click",function(){
	    	
	    	//判断此时 再点击是想要全选，还是想要全部取消
	    	//wantSelectAll = true 表示想要全选，wantSelectAll = false 表示想要全部取消
	    	var wantSelectAll = false; 
	    	if( $(this).hasClass('full')) wantSelectAll = false;
	    	if( $(this).hasClass('empty')) wantSelectAll = true;
	    	if( $(this).hasClass('notFull')) wantSelectAll = true;
	    	
	    	//1.如果是需要全部取消
	    	if(wantSelectAll == false){
	    		//1.1 加入取消的样式,去掉半选和全选样式
	    		$(this).attr("src","${ctxStatic}/images/terminal/empty.png");
	    		$(this).removeClass("full");
	    		$(this).removeClass("notFull");
	    		$(this).addClass("empty");
	    		
	    		//1.2全局已选终端变量 清除 该分组的全部Id
	    		//此时表示已经存在，那么 设置 removeTheseTerminal = true
	    		//之后请求后台终端的时候，不会让终端显示为勾选状态，并且会在全局分组中
	    		//去掉这些终端
	    		removeTheseTerminal = true;
	    		
	    	} else {
	   		 	//2.如果是需要全选
	    		//2.1 加入全选的样式,去掉半选和empty样式
	    		$(this).attr("src","${ctxStatic}/images/terminal/full.png");
	    		$(this).removeClass("empty");
	    		$(this).removeClass("notFull");
	    		$(this).addClass("full");
	    		//2.2全局已选终端变量 加入 该分组的全部Id（判断如果已经有了，那么就不加）
	    		// 设置 addAllTerminal(该变量用于之后请求后台终端的时候，让终端显示为勾选状态)
	    		addAllTerminal = true;
	    	}
		})
		
		
		
		// ==================================================
		// ===================终端列表点击单选===================
		// ==================================================
		$('.imgArea_terminal').live("click",function(){
			
			//如果原来被选中，那么此时表示取消
			if($(this).hasClass('full')){
				//自身加入空样式
				$(this).attr("src","${ctxStatic}/images/terminal/empty.png");
	    		$(this).removeClass("full");
	    		$(this).addClass("empty");
	    		
	    		//设置此时的左侧分组样式
	    		setLeftGroupStyle();
				
	    		//在全局变量中去除 选中的分组 和去除 选中的 id
				var _terminalId = $(this).prev().val();
				for(var i = 0; i < terminalIds.length; ++i){
					if(_terminalId == terminalIds[i]){
						j = i;
						break;
					}
				}
				terminalIds.splice(j,1);
				
			} else {
				//如果原来没有被选中，那么此时表示选中
				//自身加入空样式
				$(this).attr("src","${ctxStatic}/images/terminal/full.png");
	    		$(this).removeClass("empty");
	    		$(this).addClass("full");
				
	    		//设置此时的左侧分组样式
	    		setLeftGroupStyle();
	    		
				//在全局变量中加入 选中的 id
				terminalIds.push($(this).prev().val());
			}
			
			$('.showSelectNum').empty();
			$('.showSelectNum').append(terminalIds.length);
		})
		
		function setLeftGroupStyle(){
	    	//左侧分组的全选框需要取消(需要判断此时是添加半选样式，还是空样式)
			var count = 0;
			$('.imgArea_terminal').each(function(){
				if($(this).hasClass('full')) count = count + 1;
			})
			if(count == $('#selectedGroupNum').val()){
				$($($('.colorSelect').children().get(0)).children().get(1)).attr("src","${ctxStatic}/images/terminal/full.png");
				$($($('.colorSelect').children().get(0)).children().get(1)).removeClass("empty");
				$($($('.colorSelect').children().get(0)).children().get(1)).removeClass("notFull");
				$($($('.colorSelect').children().get(0)).children().get(1)).addClass("full");
			} else if( count != 0) {
				$($($('.colorSelect').children().get(0)).children().get(1)).attr("src","${ctxStatic}/images/terminal/notFull.png");
				$($($('.colorSelect').children().get(0)).children().get(1)).removeClass("empty");
				$($($('.colorSelect').children().get(0)).children().get(1)).removeClass("full");
				$($($('.colorSelect').children().get(0)).children().get(1)).addClass("notFull");
			} else{
				$($($('.colorSelect').children().get(0)).children().get(1)).attr("src","${ctxStatic}/images/terminal/empty.png");
				$($($('.colorSelect').children().get(0)).children().get(1)).removeClass("notFull");
				$($($('.colorSelect').children().get(0)).children().get(1)).removeClass("full");
				$($($('.colorSelect').children().get(0)).children().get(1)).addClass("empty");
			}
			
			count = 0;
	    }
	    
	    //==================================
	    //============设置并保存音量============
	    //==================================
	    function setAndSave(){
	    	if(terminalIds.length == 0){
	    		$('.terminalEmptyWarn').empty();
	    		$('.terminalEmptyWarn').append("请选择终端");
	    	} else {
	    		
	    		//验证设置的时间的合法性
	    		var validTime = true;
	    		var errorMsg1 = "";
	    		var errorMsg2 = "";
	    		var errorMsg3 = "";
	    		var errorMsg4 = "";
		    	
	    		//判断点击的是常开还是定时 1：常开；0：定时
		    	var flag = $('.selectPattern').val();
				if(flag == 1){
					var _terminalIds = terminalIds.join(",");
					// -1 表示不设置
					var alwaysVol = $('.title0').text();
					doSave(_terminalIds,alwaysVol,-1,-1,-1,-1,-1,-1,-1,-1);
				}  else {
					var _terminalIds = terminalIds.join(",");
					
					var timingVol1;
					var s1 = "";
					var e1 = "";
					if(flag_show1 == true){
						errorMsg1 = validT(1);
						if(errorMsg1 != "") validTime = false;
						timingVol1 = $('#title1').text();
						s1 = $('.s1').val();
						e1 = $('.e1').val();
					}
					else timingVol1 = -1;
					
					var timingVol2;
					var s2 = "";
					var e2 = "";
					if(flag_show2 == true){
						errorMsg2 = validT(2);
						if(errorMsg2 != "") validTime = false;
						timingVol2 = $('#title2').text();
						s2 = $('.s2').val();
						e2 = $('.e2').val();
					}
					else timingVol2 = -1;
					
					var timingVol3;
					var s3 = "";
					var e3 = "";
					if(flag_show3 == true){
						errorMsg3 = validT(3);
						if(errorMsg3 != "") validTime = false;
						timingVol3 = $('#title3').text();
						s3 = $('.s3').val();
						e3 = $('.e3').val();
					}
					else timingVol3 = -1;
					
					var timingVol4;
					var s4 = "";
					var e4 = "";
					if(flag_show4 == true){
						errorMsg4 = validT(4);
						if(errorMsg4 != "") validTime = false;
						timingVol4 = $('#title4').text();
						s4 = $('.s4').val();
						e4 = $('.e4').val();
					}
					else timingVol4 = -1;
					
					if(validTime == true)
					{
						if( (timingVol1 == -1) && (timingVol2 == -1) 
								&& (timingVol3 == -1) && (timingVol4 == -1)){
							$('.terminalEmptyWarn').empty();
			    			$('.terminalEmptyWarn').append("请设置音量");
						} else
							doSave(_terminalIds,-1,timingVol1,timingVol2,timingVol3,timingVol4,
									s1,e1,s2,e2,s3,e3,s4,e4);
					} else {
						$('.timeWarn1').empty();
						$('.timeWarn1').append(errorMsg1);
						$('.timeWarn2').empty();
						$('.timeWarn2').append(errorMsg2);
						$('.timeWarn3').empty();
						$('.timeWarn3').append(errorMsg3);
						$('.timeWarn4').empty();
						$('.timeWarn4').append(errorMsg4);
						
						validTime == true;
					}
				}	    	
	    	}
	    }
	    
	    //验证时间设置的合法性
	    function validT(flag){
	    	if(flag == "1"){
	    		if($('.s1').val() == '') return "起始时间不能为空";
	    		if($('.e1').val() == '') return "结束时间不能为空";
	    		if($('.s1').val() >= $('.e1').val()) return "起始时间不能大于等于结束时间";
	    		return "";
	    	}
			if(flag == "2"){
				if($('.s2').val() == '') return "起始时间不能为空";
	    		if($('.e2').val() == '') return "结束时间不能为空";
	    		if($('.s2').val() >= $('.e2').val()) return "起始时间不能大于等于结束时间";
	    		return "";
			}
			if(flag == "3"){
				if($('.s3').val() == '') return "起始时间不能为空";
	    		if($('.e3').val() == '') return "结束时间不能为空";
	    		if($('.s3').val() >= $('.e3').val()) return "起始时间不能大于等于结束时间";
	    		return "";
			}
			if(flag == "4"){
				if($('.s4').val() == '') return "起始时间不能为空";
	    		if($('.e4').val() == '') return "结束时间不能为空";
	    		if($('.s4').val() >= $('.e4').val()) return "起始时间不能大于等于结束时间";
	    		return "";
			}				
	    }
	    
	    
	    function doSave(_terminalIds,alwaysVol,timingVol1,timingVol2,timingVol3,timingVol4,
	    		s1,e1,s2,e2,s3,e3,s4,e4){
	    	$.ajax({
	    		url:'${ctx}/terminalSettings/doSetVolume',
				dataType:'json',
				type:'post',
				data:{
					terminalIds:_terminalIds,
					alwaysVol:alwaysVol,
					timingVol1:timingVol1,
					timingVol2:timingVol2,
					timingVol3:timingVol3,
					timingVol4:timingVol4,
					s1:s1,
					e1:e1,
					s2:s2,
					e2:e2,
					s3:s3,
					e3:e3,
					s4:s4,
					e4:e4,
				},
				success:function(data){
					if(data.msg == "success"){
						$('.setVolmsg').empty();
						$('.terminalEmptyWarn').empty();
						$('.timeWarn1').empty();
						$('.timeWarn2').empty();
						$('.timeWarn3').empty();
						$('.timeWarn4').empty();
						
						$('.setVolmsg').append("设置成功");
						
					} else {
						alert("服务器出错，请重新登录，以避免不必要的错误");
					}
				},
				error:function(){
					alert("服务器出错，请重新登录，以避免不必要的错误");
				}
	    	})
	    }
	    
	    
	    //==================================
	    //==============点击定时==============
	    //==================================
	    function timing(){
	    	$('._always').css("display","none");
	    	$('.timeSwitch').css("display","inline");
	    };
	    
	    function always(){
	    	$('.timeSwitch').css("display","none");
	    	$('._always').css("display","inline");
	    }
	    
	  	//==================================
	    //============点击定时->音量设置========
	    //==================================
	    function showSetVol1(element){
	    	if($(element).parent().find(".bootstrap-switch-on").length == 1){
		    	$('.setVol1').css("display","inline");
		    	$('.setVol2').css("display","none");
		    	$('.setVol3').css("display","none");
		    	$('.setVol4').css("display","none");
		    	$('.vol1').empty();
		    	$('.vol2').empty();
		    	$('.vol3').empty();
		    	$('.vol4').empty();
		    	
		    	if(flag_show2 == true)$('.vol2').append($('#title2').text());
		    	if(flag_show3 == true)$('.vol3').append($('#title3').text());
		    	if(flag_show4 == true)$('.vol4').append($('#title4').text());
	    	}
	    }
	    function showSetVol2(element){
	    	if($(element).parent().find(".bootstrap-switch-on").length == 1){
		    	$('.setVol1').css("display","none");
		    	$('.setVol2').css("display","inline");
		    	$('.setVol3').css("display","none");
		    	$('.setVol4').css("display","none");
		    	$('.vol1').empty();
		    	$('.vol2').empty();
		    	$('.vol3').empty();
		    	$('.vol4').empty();
		    	
		    	if(flag_show1 == true)$('.vol1').append($('#title1').text());
		    	if(flag_show3 == true)$('.vol3').append($('#title3').text());
		    	if(flag_show4 == true)$('.vol4').append($('#title4').text());
	    	}
	    }
	    function showSetVol3(element){
	    	if($(element).parent().find(".bootstrap-switch-on").length == 1){
		    	$('.setVol1').css("display","none");
		    	$('.setVol2').css("display","none");
		    	$('.setVol3').css("display","inline");
		    	$('.setVol4').css("display","none");
		    	$('.vol1').empty();
		    	$('.vol2').empty();
		    	$('.vol3').empty();
		    	$('.vol4').empty();
		    	
		    	if(flag_show1 == true)$('.vol1').append($('#title1').text());
		    	if(flag_show2 == true)$('.vol2').append($('#title2').text());
		    	if(flag_show4 == true)$('.vol4').append($('#title4').text());	
	    	}
	    }
	    function showSetVol4(element){
	    	if($(element).parent().find(".bootstrap-switch-on").length == 1){
		    	$('.setVol1').css("display","none");
		    	$('.setVol2').css("display","none");
		    	$('.setVol3').css("display","none");
		    	$('.setVol4').css("display","inline");
		    	$('.vol1').empty();
		    	$('.vol2').empty();
		    	$('.vol3').empty();
		    	$('.vol4').empty();
		    	if(flag_show1 == true)$('.vol1').append($('#title1').text());
		    	if(flag_show2 == true)$('.vol2').append($('#title2').text());
		    	if(flag_show3 == true)$('.vol3').append($('#title3').text());
		    	
	    	}
	    }
	   
	    var flag_show1 = false;
		$('input[name="my-checkbox1"]').on('switchChange.bootstrapSwitch', function(event, state) {
			  if(flag_show1 == false) flag_show1 = true;
			  else flag_show1 = false;
			  
			  if(flag_show1 == true){
			  	$('.volSetBtn1').css("display","inline");
			  	$('.vol1').css("display","inline");
			  }
			  else  {
			    $('.volSetBtn1').css("display","none");
			    $('.setVol1').css("display","none");
			    $('.vol1').css("display","none");
			  }
		});
		
		var flag_show2 = false;
		$('input[name="my-checkbox2"]').on('switchChange.bootstrapSwitch', function(event, state) {
			  if(flag_show2 == false) flag_show2 = true;
			  else flag_show2 = false;
			  
			  if(flag_show2 == true){
			  	$('.volSetBtn2').css("display","inline");
			  	$('.vol2').css("display","inline");
			  }
			  else {
			    $('.volSetBtn2').css("display","none");
			    $('.setVol2').css("display","none");
			    $('.vol2').css("display","none");
			  }
		});
		
		var flag_show3 = false;
		$('input[name="my-checkbox3"]').on('switchChange.bootstrapSwitch', function(event, state) {
			  if(flag_show3 == false) flag_show3 = true;
			  else flag_show3 = false;
			  
			  if(flag_show3 == true){
			  	$('.volSetBtn3').css("display","inline");
			  	$('.vol3').css("display","inline");
			  }
			  else {
			    $('.volSetBtn3').css("display","none");
			    $('.setVol3').css("display","none");
			    $('.vol3').css("display","none");
			  }
		});
		
		var flag_show4 = false;
		$('input[name="my-checkbox4"]').on('switchChange.bootstrapSwitch', function(event, state) {
			  if(flag_show4 == false) flag_show4 = true;
			  else flag_show4 = false;
			  
			  if(flag_show4 == true){
			  	$('.volSetBtn4').css("display","inline");
			  	$('.vol4').css("display","inline");
			  }
			  else {
			    $('.volSetBtn4').css("display","none");
			    $('.setVol4').css("display","none");
			    $('.vol4').css("display","none");
			  }
		});
	    
	</script>
</body>
</html>