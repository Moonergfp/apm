<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="decorator" content="default"/>
<title>终端管理-在线升级首页</title>

<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/terminal/terminalSettings.css">

	<style type="text/css">
	.colorSelect{
		background-color: #E8E8E8;
	}
	.colorNotSelect{
		background-color: white;
	}
	.showNetUpgradeDeltail{
		display: none;
	}
	.showNetAPKUpgradeDeltail{
		display: none;
	}
	.clickAddFileAPKDetail{
		display: none;
	}
	.clickAddFileDetail{
		display: none;
	}
	</style>
	
	<link href="${ctxStatic}/webupload/css/webuploader.css" type="text/css" rel="stylesheet"/>
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
					<li><a href="${ctx}/terminalSettings/volumeSetting">音量设置</a></li>
					<li><a href="${ctx}/terminalSettings/format">格式化</a></li>
					<li class="active"><a href="${ctx}/terminalUpgrade/upgrade">在线升级</a></li>
				</ul>
			</div>	
			<div class = "showDetail text-center" style = "padding:5px 5px;">
				<!-- 固件升级 -->
				<div class = "netUpgrade" style = "background-color:#D1D1D1;margin-top:10px;">
					<div style = "float:left">
						<h4 class = "netTitle" style = "padding-top:7px;">固件升级</h4>
					</div>
					<div class ="refreshBut" style = "float:right">
						<button class = "btn btn-info flag_netUpgrade" type = "button" onclick = "clickNetRefresh(this);">刷新</button>
					</div>
					<div style = "clear:both"></div>
				</div>
			
				<!-- 固件升级 点击刷新出现详细情况 -->
				<div class = "showNetUpgradeDeltail" style = "min-height:80px;padding-top:10px;font-weight:bold;font-size:17px;">
					<div style = "padding-left:50px;margin-top:10px;">
						<div style = "float:left">
							最新系统版本：<span class = "newestVersion"></span>
						</div>
						<div style = "float:right;margin-top:-5px;">
							<button class = "btn btn-info" type = "button" onclick = "upgradeSysCommon(this)">升级</button>
						</div>
						<div style = "clear:both;"></div>
						<div class = "upgradeSysCommonMsg" style = "color:red"></div>
						<div class = "terminalEmptyWarn_firmwareSys" style = "color:red"></div>
					</div>
					
					<div class = "showCustomedUpgradeDetail" style = "padding-left:50px;padding-top:30px;">
						<div style = "float:left">
							最新自定义系统版本：<span class = "newestCustomedVersion"></span>
						</div>
						<div style = "float:right;margin-top:-5px;">
							<button class = "btn btn-info" type = "button" onclick = "upgradeSysCustomed(this)">升级</button>
						</div>
						<div style = "clear:both"></div>
						<div class = "upgradeSysCustomedMsg" style = "color:red"></div>
						<div class = "terminalEmptyWarn_firmwareCustomed" style = "color:red"></div>
					</div>
					
				</div>
			
				<!-- 网络APK升级 -->
				<div class = "netAPKUpgrade" style = "background-color:#D1D1D1;margin-top:10px;">
					<div style = "float:left">
						<h4 class = "netAPKTitle" style = "padding-top:7px;">APK升级</h4>
					</div>
					<div class ="refreshAPKBut" style = "float:right">
						<button class = "btn btn-info flag_netAPKUpgrade" type = "button" onclick = "clickNetAPKRefresh(this);">刷新</button>
					</div>
					<div style = "clear:both"></div>
				</div>
			
			
				<!-- 网络APK升级 点击刷新出现详细情况 -->
				<div class = "showNetAPKUpgradeDeltail" style = "min-height:80px;padding-top:10px;font-weight:bold;font-size:17px;">
					<div style = "padding-left:50px;">
						<div style = "float:left;">
							最新系统APK版本：<span class = "newestAPKVersion"></span>
						</div>
						<div style = "float:right;margin-top:-5px;">
							<button class = "btn btn-info" type = "button" onclick = "upgradeAPKCommon(this)">升级</button>
						</div>	
						<div style = "clear:both;"></div>
						<div class = "upgradeAPKCommonMsg" style = "color:red"></div>
						<div class = "terminalEmptyWarn_apkSys" style = "color:red"></div>
					</div>
					<div style = "padding-top:30px;padding-left:50px;">
						<div style = "float:left">
							最新自定义系统APK版本：<span class = "newestCustomedAPKVersion"></span>
						</div>
						<div style = "float:right;margin-top:-5px;">
							<button class = "btn btn-info" type = "button" onclick = "upgradeAPKCustomed(this)">升级</button>
						</div>
						<div style = "clear:both"></div>
						<div class = "upgradeAPKCustomedMsg" style = "color:red"></div>
						<div class = "terminalEmptyWarn_apkCustomed" style = "color:red"></div>
					</div>
				</div>
			
			
				<!-- 上传系统更新包 -- 超级管理员才能看见 -->
				<div class = "uploadFile" style = "background-color:#D1D1D1;margin-top:10px;">
					<div style = "float:left">
						<h4 class = "localTitle" style = "padding-top:7px;">上传系统更新包</h4>
					</div>
					<div class = "addFileBut" style = "float:right">
						<button class = "btn btn-info flag_netUpload" type = "button" onclick = "clickAddSysFile(this);">添加文件</button>
					</div>
					<div style = "clear:both"></div>
				</div>
				<!-- 上传系统更新包 的具体信息 -- 超级管理员才能看见 -->
				<div class = "clickAddFileDetail" style = "min-height:80px;padding-top:10px;font-weight:bold;font-size:17px;">
					<div style = "padding-left:50px;margin-top:10px;">
						<div>最新公共版本：<span class = "newestfileVersion"></span></div>
						<div id="demo5" style = "padding-top:4px;font-size:14px;"></div>
						<!-- <div style = "padding-top:10px;"><button class = "btn btn-info btn-sm" onclick = "saveSysCommonFile();">确认</button></div>
					 --></div>
					
					<div style = "padding-left:50px;margin-top:10px;">
						<div>
							用户定制版本，机构选择：
							<span>
								<select class = "showSysUpdateSelect form-control" style = "display:inline;width:30%" name = "officeId"> 
								</select>
							</span>
						</div>
						<div id="demo6" style = "padding-top:4px;font-size:14px;"></div>
					 </div>
					
				</div>
				
				<!-- 上传系统APK更新包 -- 超级管理员才能看见 -->
				<div class = "uploadAPKFile" style = "background-color:#D1D1D1;margin-top:10px;">
					<div style = "float:left">
						<h4 class = "localTitle" style = "padding-top:7px;">上传系统APK更新包</h4>
					</div>
					<div class = "addAPKFileBut" style = "float:right">
						<button class = "btn btn-info flag_netAPKUpload" type = "button" onclick = "clickAddSysAPKFile(this);">添加文件</button>
					</div>
					<div style = "clear:both"></div>
				</div>
				
				<!-- 上传系统更新包 的具体信息 -- 超级管理员才能看见 -->
				<div class = "clickAddFileAPKDetail" style = "min-height:80px;padding-top:10px;font-weight:bold;font-size:17px;">
					<div style = "padding-left:50px;margin-top:10px;">
						<div>最新公共版本：<span class = "newestAPKFileVersion"></span></div>
						<div id="demo7" style = "padding-top:4px;font-size:14px;"></div>
						<!-- <div style = "padding-top:10px;"><button class = "btn btn-info btn-sm" onclick = "saveUploadFile();">确认</button></div>
					 --></div>
					
					<div style = "padding-left:50px;margin-top:10px;">
						<div>
							用户定制版本，机构选择：
							<span>
								<select class = "showCustomedAPKSelect form-control" style = "display:inline;width:30%" name = "officeId"> 
								</select>
							</span>
						</div>
						<div id="demo8" style = "padding-top:4px;font-size:14px;"></div>
						<!-- <div style = "padding-top:10px;"><button class = "btn btn-info btn-sm" onclick = "saveUploadFile();">确认</button></div>
					 --></div>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript"src="${ctxStatic}/webupload/webuploader.min.js"></script>
	<script type="text/javascript"src="${ctxStatic}/webupload/jquery.uploader.js"></script>
	
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
		
		// ==================================================
		// ==================固件升级的刷新功能==================
		// ==================================================
		function clickNetRefresh(element){
			//false 表示不是管理员
			getUpdatePackageVersion(false,"sys_update_package",element);
	    }
		
		// ==================================================
		// ===================网络APK升级的刷新功能==============
		// ==================================================
		function clickNetAPKRefresh(element){
			//false 表示不是管理员
			getUpdatePackageVersion(false,"apk_update_package",element);
	    }
		
		// ==================================================
		// ===================上传系统更新包 添加文件==============
		// ==================================================
		function clickAddSysFile(element){
			//true 表示是管理员
			getUpdatePackageVersion(true,"sys_update_package",element);
	    }
		
		// ==================================================
		// ===================上传系统APK更新包 添加文件===========
		// ==================================================
		function clickAddSysAPKFile(element){
			//true 表示是管理员
			getUpdatePackageVersion(true,"apk_update_package",element);
	    }
		
		
		// type = 1 :系统升级；type = 0：apk升级
		function getUpdatePackageVersion(isManager,type,element){
			
			//1表示：点击固件升级的升级，2表示：固件升级 APK升级 的刷新
			//3表示：上传系统更新包的添加文件  4表示：上传系统APK更新包 的添加文件
			var flag;
			if($(element).hasClass("flag_netUpgrade")) flag = 1;
			if($(element).hasClass("flag_netAPKUpgrade")) flag = 2;
			if($(element).hasClass("flag_netUpload")) flag = 3;
			if($(element).hasClass("flag_netAPKUpload")) flag = 4;
			
			$.ajax({
	    		url:'${ctx}/terminalUpgrade/getTerminalNewestVersion',
				dataType:'json',
				type:'post',
				data:{
					isManager:isManager,
					type:type,
				},
				success:function(data){
					if(data.msg == "success"){
						if(flag == 1){
							$('.showNetUpgradeDeltail').slideDown();
							
							$('.newestVersion').empty();
							
							if(data.newestPackage != null){
								$('.newestVersion').append(data.newestPackage.name);
							} else {
								$('.newestVersion').append("暂无");
							}
							
							$('.newestCustomedVersion').empty();
							if(data.customedNewestPackage == null){
								$('.newestCustomedVersion').append("暂无");
							} else {
								$('.newestCustomedVersion').append(data.customedNewestPackage.name);
							}
						}
						if(flag == 2){
							$('.showNetAPKUpgradeDeltail').slideDown();
							
							$('.newestAPKVersion').empty();
							if(data.newestPackage != null){
								$('.newestAPKVersion').append(data.newestPackage.name);
							} else {
								$('.newestAPKVersion').append("暂无");
							}
							
							$('.newestCustomedAPKVersion').empty();
							if(data.customedNewestPackage == null){
								$('.newestCustomedAPKVersion').append("暂无");
							} else {
								$('.newestCustomedAPKVersion').append(data.customedNewestPackage.name);
							}
						}
						if(flag == 3){
							$('.clickAddFileDetail').slideDown();
							
							$('.newestfileVersion').empty();
							
							if(data.newestPackage != null){
								$('.newestfileVersion').append(data.newestPackage.name);
							} else {
								$('.newestfileVersion').append("暂无");
							}
							
							$('#demo5').empty();
							$("#demo5").webuploader({
								initPicker: "picker_demo5",  
							    initList: "file_list_demo5",  
							    initBtn: "file_btn_demo5",  
							    ctx:"${ctx}",
							    ctxStatic:"${ctxStatic}",//上传图标路径
							    folderName:"sys_update_package",
							    beUsed:true,//使用插件初始化样式，默认为false
							    chunked:true,//是否分片上传
								chunkSize:5242880,//分片尺寸默认5兆,单位字节
								threads:3,//片的并发的数量
								uploadType:false,				//上传头像类型文件
							});
							

							$('.showSysUpdateSelect').empty();
							for(var i = 0; i < data.officeList.length; ++i){
								var office = data.officeList[i];
								$('.showSysUpdateSelect').append("<option value = \""+office.id+"\">"+office.name+"</option>")
							}
							
							$('#demo6').empty();
							$("#demo6").webuploader({
								initPicker: "picker_demo6",  
							    initList: "file_list_demo6",  
							    initBtn: "file_btn_demo6",  
							    ctx:"${ctx}",
							    ctxStatic:"${ctxStatic}",//上传图标路径
							    folderName:"customed_sys_update_package",
							    beUsed:true,//使用插件初始化样式，默认为false
							    chunked:true,//是否分片上传
								chunkSize:5242880,//分片尺寸默认5兆,单位字节
								threads:3,//片的并发的数量
								uploadType:false,				//上传头像类型文件
							});
							
						}
						if(flag == 4){
							$('.clickAddFileAPKDetail').slideDown();
							
							$('.newestAPKFileVersion').empty();
							
							if(data.newestPackage != null){
								$('.newestAPKFileVersion').append(data.newestPackage.name);
							} else {
								$('.newestAPKFileVersion').append("暂无");
							}
							
							$("#demo7").empty();
							$("#demo7").webuploader({
								initPicker: "picker_demo7",  
							    initList: "file_list_demo7",  
							    initBtn: "file_btn_demo7",  
							    ctx:"${ctx}",
							    ctxStatic:"${ctxStatic}",//上传图标路径
							    folderName:"apk_update_package",
							    beUsed:true,//使用插件初始化样式，默认为false
							    chunked:true,//是否分片上传
								chunkSize:5242880,//分片尺寸默认5兆,单位字节
								threads:3,//片的并发的数量
								uploadType:false,				//上传头像类型文件
							});
							
							$('.showCustomedAPKSelect').empty();
							for(var i = 0; i < data.officeList.length; ++i){
								var office = data.officeList[i];
								$('.showCustomedAPKSelect').append("<option value = \""+office.id+"\">"+office.name+"</option>")
							}
							$("#demo8").empty();
							$("#demo8").webuploader({
								initPicker: "picker_demo8",  
							    initList: "file_list_demo8",  
							    initBtn: "file_btn_demo8",  
							    ctx:"${ctx}",
							    ctxStatic:"${ctxStatic}",//上传图标路径
							    folderName:"customed_apk_update_package",
							    beUsed:true,//使用插件初始化样式，默认为false
							    chunked:true,//是否分片上传
								chunkSize:5242880,//分片尺寸默认5兆,单位字节
								threads:3,//片的并发的数量
								uploadType:false,				//上传头像类型文件
							});
					    	
						  }
						  
					} else {
						alert("服务器出错，请重新登录，以避免不必要的错误");
					}
				},
				error:function(){
					alert("服务器出错，请重新登录，以避免不必要的错误");
				}
	    	})
		}
		
     	// ==================================================
	    //  鼠标移动到 分组前面的图片，鼠标显示箭头类型
		// ==================================================
	    $('.imgArea').live("mouseover",function(){
	    	$(this).css("cursor","default");
	    })
	    
	    
		 
	    // ==================================================
	    //  用于文件上传功能
		// ==================================================
		/**
		 * 由于uploader自己来管理存值，包括删除值后input框内的ID减少。如果调用者自己自定义处理值和删除的方法，需要实现以下的两个方法
		 * 在uploadDoValue:false的情况下，必须都要调用 	getFileDetail toDeleteFile
		 */
		function getFileDetail(fileId,fileName,file_id){
			/* alert(fileId+" -- "+fileName+" -- "+file_id); */
			
		}
		function toDeleteFile(fileId){
			alert(fileId);			
		}
		
		
		// ==================================================
	    //  用于点击具体的升级
		// ==================================================
		function upgradeSysCommon(element){
			upgrade("firmware","sys",element);
		}
		function upgradeSysCustomed(element){
			upgrade("firmware","customed",element);
		}
		function upgradeAPKCommon(element){
			upgrade("apk","sys",element);
		}
		function upgradeAPKCustomed(element){
			upgrade("apk","customed",element);
		}
		
		//firmware_apk = 1：固件升级 ；firmware_apk = 0：APK升级 
		//sys_customed = 1：系统升级 ；sys_customed = 0：自定义升级 
		function upgrade(firmware_apk,sys_customed,element){
			
			if(terminalIds.length == 0){
				
				if(firmware_apk == "firmware"){
					if(sys_customed == "sys"){
						$('.terminalEmptyWarn_firmwareSys').empty();
						$('.terminalEmptyWarn_firmwareSys').append("请选择终端！");
					} else{
						$('.terminalEmptyWarn_firmwareCustomed').empty();
						$('.terminalEmptyWarn_firmwareCustomed').append("请选择终端！");
					}
				}
				if(firmware_apk == "apk"){
					if(sys_customed == "sys"){
						$('.terminalEmptyWarn_apkSys').empty();
						$('.terminalEmptyWarn_apkSys').append("请选择终端！");
					} else{
						$('.terminalEmptyWarn_apkCustomed').empty();
						$('.terminalEmptyWarn_apkCustomed').append("请选择终端！");
					}
				}
				
			} else {
				var _terminalIds = terminalIds.join(",");
				$.ajax({
		    		url:'${ctx}/terminalUpgrade/concreteUpgrade',
					dataType:'json',
					type:'post',
					data:{
						firmware_apk:firmware_apk,
						sys_customed:sys_customed,
						terminalIds:_terminalIds,
					},
					success:function(data){
						if(data.msg == "success"){
							if(firmware_apk == "firmware"){
								if(sys_customed == "sys"){
									$('.terminalEmptyWarn_firmwareSys').empty();
									$('.upgradeSysCommonMsg').empty();
									$('.upgradeSysCommonMsg').append("升级成功！");
								} else{
									$('.terminalEmptyWarn_firmwareCustomed').empty();
									$('.upgradeSysCustomedMsg').empty();
									$('.upgradeSysCustomedMsg').append("升级成功！");
								
								}
							}
							if(firmware_apk == "apk"){
								if(sys_customed == "sys"){
									$('.terminalEmptyWarn_apkSys').empty();
									$('.upgradeAPKCommonMsg').empty();
									$('.upgradeAPKCommonMsg').append("升级成功！");
								} else{
									$('.terminalEmptyWarn_apkCustomed').empty();
									$('.upgradeAPKCustomedMsg').empty();
									$('.upgradeAPKCustomedMsg').append("升级成功！");
								}
							}
							
						} else {
							alert("服务器出错，请重新登录，以避免不必要的错误");
						}
					},
					error:function(){
						alert("服务器出错，请重新登录，以避免不必要的错误");
					}
		    	})
			}
		}
	</script>
</body>
</html>
