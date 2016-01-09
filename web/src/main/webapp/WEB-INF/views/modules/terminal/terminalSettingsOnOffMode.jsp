<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>终端设置实体类</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/bootstrap-3.3.5-dist/css/bootstrap-switch.min.css">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/terminal/terminalSettings.css">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/terminal/terminalSettingsOnOffMode.css">
	<script type="text/javascript" src="${ctxStatic}/bootstrap-3.3.5-dist/js/bootstrap-switch.min.js"></script>
	<script type="text/javascript" src="${ctxStatic}/js/terminal/terminalSettings.js"></script>
<style type="text/css">
	.colorSelect{
		background-color: #E8E8E8;
	}
	.colorNotSelect{
		background-color: white;
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
	    
	    
	    
				</script>
		</div>

		<!-- 设置面板 -->
		<div class="settings">
			<div class="navication">
				<ul class="nav nav-tabs">
					<li><a href="${ctx}/terminalSettings/screenShootPage">截屏设置</a></li>
					<li><a href="#">桌面设置</a></li>
					<li  class="active"><a href="${ctx}/terminalSettings/onOffModePage">定时开关</a></li>
					<li><a href="${ctx}/terminalSettings/brightSetting">亮度设置</a></li>
					<li><a href="${ctx}/terminalSettings/volumeSetting">音量设置</a></li>
					<li><a href="${ctx}/terminalSettings/format">格式化</a></li>
					<li><a href="${ctx}/terminalUpgrade/upgrade">在线升级</a></li>
				</ul>
			</div>
			<div class="on_off_mode_settings">
				<div class="head">
					<span><a href="#" class="btn btn-primary" onclick="saveOnOffModeTimes()">保存并设置更改</a></span>
					<div class="form-group">
						<span>开关机模式 </span>
						<div class="div_select">
							<select name="" id="on_off_mode" class="form-control" onchange="onOffModeSelectChange()">
								<option value="0">每天</option>
								<option value="1">星期模式</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<span>开关机控制</span>
						<div class="div_select">
							<select name="" id="on_off_mode_switch" class="form-control" onchange="onOffModeSwitchSelectChange()">
								<option value="0">常开</option>
								<option value="1">定时</option>
							</select>
						</div>
					</div>
				</div>

				<!-- 每天-定时模式 -->
				<div class="times" id="everyMode" style="display:none">
					<div class="timeSwitch">
						<ul>
							<li>
								 <div class="form-group">
									<label class="col-sm-2 control-label">1</label>
									<div class="col-sm-3">
									<input  class="form-control"  value="" placeholder="开始时间"  	
				            		name="s1" type="text" readonly="readonly"  class="form-control"   
				            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
				            		style = "width:140px;"/>
				            		
									</div>
									<div class="col-sm-3">
									<input  class="form-control"  value="" placeholder="结束时间"  	
				            		name="e1" type="text" readonly="readonly"  class="form-control"   
				            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
				            		style = "width:140px;"/>
				            		
									</div>
									<div class="col-sm-3">
										<input type="checkbox" class="switch on_off_mode_checkbox1">
									</div>
				            		
			            		</div>
							</li>

							<li>
								 <div class="form-group">
									<label class="col-sm-2 control-label">2</label>
									<div class="col-sm-3">
									<input  class="form-control"  value="" placeholder="开始时间"  	
				            		name="s2" type="text" readonly="readonly"  class="form-control"   
				            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
				            		style = "width:140px;"/>
				            		
									</div>
									<div class="col-sm-3">
									<input  class="form-control"  value="" placeholder="结束时间"  	
				            		name="e2" type="text" readonly="readonly"  class="form-control"   
				            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
				            		style = "width:140px;"/>
				            		
									</div>
									<div class="col-sm-3">
										<input type="checkbox" class="switch on_off_mode_checkbox2">
									</div>
				            		
			            		</div>
							</li>

							<li>
								 <div class="form-group">
									<label class="col-sm-2 control-label">3</label>
									<div class="col-sm-3">
									<input  class="form-control"  value="" placeholder="开始时间"  	
				            		name="s3" type="text" readonly="readonly"  class="form-control"   
				            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
				            		style = "width:140px;"/>
				            		
									</div>
									<div class="col-sm-3">
									<input  class="form-control"  value="" placeholder="结束时间"  	
				            		name="e3" type="text" readonly="readonly"  class="form-control"   
				            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
				            		style = "width:140px;"/>
				            		
									</div>
									<div class="col-sm-3">
										<input type="checkbox" class="switch on_off_mode_checkbox3">
									</div>
				            		
			            		</div>
							</li>

							<li>
								 <div class="form-group">
									<label class="col-sm-2 control-label">4</label>
									<div class="col-sm-3">
									<input  class="form-control"  value="" placeholder="开始时间"  	
				            		name="s4" type="text" readonly="readonly"  class="form-control"   
				            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
				            		style = "width:140px;"/>
				            		
									</div>
									<div class="col-sm-3">
									<input  class="form-control"  value="" placeholder="结束时间"  	
				            		name="e4" type="text" readonly="readonly"  class="form-control"   
				            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
				            		style = "width:140px;"/>
									</div>
									<div class="col-sm-3">
										<input type="checkbox" class="switch on_off_mode_checkbox4">
									</div>
			            		</div>
							</li>
						</ul>
					</div>
				</div>
				
				<!-- 星期-定时模式 -->
				<div class="times" id="weekMode" style="display:none">
					<ul class="nav nav-tabs" role="tablist">
					    <li role="presentation" class="active"><a href="#Sun" aria-controls="Sun" role="tab" data-toggle="tab">星期日</a></li>
					    <li role="presentation"><a href="#Mon" aria-controls="Mon" role="tab" data-toggle="tab">星期一</a></li>
					    <li role="presentation"><a href="#Tue" aria-controls="Tue" role="tab" data-toggle="tab">星期二</a></li>
					    <li role="presentation"><a href="#Wed" aria-controls="Wed" role="tab" data-toggle="tab">星期三</a></li>
					    <li role="presentation"><a href="#Thurs" aria-controls="Thurs" role="tab" data-toggle="tab">星期四</a></li>
					    <li role="presentation"><a href="#Fri" aria-controls="Fri" role="tab" data-toggle="tab">星期五</a></li>
					    <li role="presentation" ><a href="#Sat" aria-controls="Sat" role="tab" data-toggle="tab">星期六</a></li>
					 </ul>
					 <!-- Tab panes -->
					<div class="tab-content">
						<!--星期一 -->
					    <div role="tabpanel" class="tab-pane" id="Mon">
							<span class="weekNum" style="display:none">2</span>
							<div class="timeSwitch">
								<ul>
									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">1</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s1" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e1" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox1">
											</div>
						            		
					            		</div>
									</li>

									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">2</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s2" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e2" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox2">
											</div>
						            		
					            		</div>
									</li>

									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">3</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s3" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e3" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox3">
											</div>
						            		
					            		</div>
									</li>

									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">4</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s4" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e4" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox4">
											</div>
					            		</div>
									</li>
								</ul>
							</div>
					    </div>


						<!--星期二-->
					    <div role="tabpanel" class="tab-pane" id="Tue">
							<span class="weekNum" style="display:none">3</span>
							<div class="timeSwitch">
								<ul>
									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">1</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s1" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e1" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox1">
											</div>
						            		
					            		</div>
									</li>

									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">2</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s2" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e2" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox2">
											</div>
						            		
					            		</div>
									</li>

									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">3</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s3" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e3" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox3">
											</div>
						            		
					            		</div>
									</li>

									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">4</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s4" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e4" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox4">
											</div>
					            		</div>
									</li>
								</ul>
							</div>
					    </div>
						<!--星期三-->
					    <div role="tabpanel" class="tab-pane" id="Wed">
							<span class="weekNum" style="display:none">4</span>
							<div class="timeSwitch">
								<ul>
									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">1</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s1" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e1" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox1">
											</div>
						            		
					            		</div>
									</li>

									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">2</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s2" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e2" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox2">
											</div>
						            		
					            		</div>
									</li>

									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">3</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s3" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e3" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox3">
											</div>
						            		
					            		</div>
									</li>

									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">4</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s4" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e4" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox4">
											</div>
					            		</div>
									</li>
								</ul>
							</div>
					    </div>
						<!--星期四-->
					    <div role="tabpanel" class="tab-pane" id="Thurs">
							<span class="weekNum" style="display:none">5</span>
							<div class="timeSwitch">
								<ul>
									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">1</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s1" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e1" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox1">
											</div>
						            		
					            		</div>
									</li>

									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">2</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s2" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e2" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox2">
											</div>
						            		
					            		</div>
									</li>

									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">3</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s3" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e3" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox3">
											</div>
						            		
					            		</div>
									</li>

									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">4</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s4" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e4" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox4">
											</div>
					            		</div>
									</li>
								</ul>
							</div>
					    </div>
						<!--星期五-->
					    <div role="tabpanel" class="tab-pane" id="Fri">
							<span class="weekNum" style="display:none">6</span>
							<div class="timeSwitch">
								<ul>
									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">1</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s1" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e1" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox1">
											</div>
						            		
					            		</div>
									</li>

									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">2</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s2" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e2" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox2">
											</div>
						            		
					            		</div>
									</li>

									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">3</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s3" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e3" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox3">
											</div>
						            		
					            		</div>
									</li>

									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">4</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s4" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e4" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox4">
											</div>
					            		</div>
									</li>
								</ul>
							</div>
					    </div>
						<!--星期六-->
					    <div role="tabpanel" class="tab-pane" id="Sat">
							<span class="weekNum" style="display:none">7</span>
							<div class="timeSwitch">
								<ul>
									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">1</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s1" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e1" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox1">
											</div>
						            		
					            		</div>
									</li>

									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">2</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s2" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e2" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox2">
											</div>
						            		
					            		</div>
									</li>

									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">3</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s3" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e3" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox3">
											</div>
						            		
					            		</div>
									</li>

									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">4</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s4" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e4" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox4">
											</div>
					            		</div>
									</li>
								</ul>
							</div>
					    </div>
						<!--星期日-->
					    <div role="tabpanel" class="tab-pane active" id="Sun">
							<span class="weekNum" style="display:none">1</span>
							<div class="timeSwitch">
								<ul>
									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">1</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s1" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e1" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox1">
											</div>
						            		
					            		</div>
									</li>

									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">2</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s2" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e2" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox2">
											</div>
						            		
					            		</div>
									</li>

									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">3</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s3" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e3" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox3">
											</div>
						            		
					            		</div>
									</li>

									<li>
										 <div class="form-group">
											<label class="col-sm-2 control-label">4</label>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="开始时间"  	
						            		name="s4" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
						            		
											</div>
											<div class="col-sm-3">
											<input  class="form-control"  value="" placeholder="结束时间"  	
						            		name="e4" type="text" readonly="readonly"  class="form-control"   
						            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
						            		style = "width:140px;"/>
											</div>
											<div class="col-sm-3">
												<input type="checkbox" class="switch on_off_mode_checkbox4">
											</div>
					            		</div>
									</li>
								</ul>
							</div>
					    </div>
					</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
