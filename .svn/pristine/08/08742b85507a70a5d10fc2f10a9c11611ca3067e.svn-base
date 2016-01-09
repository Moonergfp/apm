<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>终端设置实体类</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/bootstrap-3.3.5-dist/css/bootstrap-switch.min.css">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/terminal/terminalSettings.css">
	<script type="text/javascript" src="${ctxStatic}/bootstrap-3.3.5-dist/js/bootstrap-switch.min.js"></script>
	<script type="text/javascript" src="${ctxStatic}/js/terminal/terminalSettings.js"></script>
</head>
<body>
	<div class="main">
		<!-- 列表 （分组和终端列表）-->
		<div class="list"></div>
		<!-- 设置面板 -->
		<div class="settings">
			<div class="navication">
				<ul class="nav nav-tabs">
					<li class="active"><a href="#">截屏设置</a></li>
					<li><a href="#">桌面设置</a></li>
					<li><a href="${ctx}/terminalSettings/onOffModePage">定时开关</a></li>
					<li><a href="${ctx}/terminalSettings/brightSetting">亮度设置</a></li>
					<li><a href="${ctx}/terminalSettings/volumeSetting">音量设置</a></li>
					<li><a href="${ctx}/terminalSettings/format">格式化</a></li>
					<li><a href="#">在线升级</a></li>
				</ul>
			</div>
			<!-- 截屏设置 -->
			<div class="screenShootSettings">
				<div class="head">
					<span><a href="#" class="btn btn-primary" onclick="saveScreenShootTimes()">保存并设置更改</a></span>
					<span>定时截屏</span>
					<!-- 总开关 -->
					<input id="switch-all" class="switch" type="checkbox">
				</div>
					<!-- 截屏时间 -->
				<div class="screen_times" style="display:none">
					<form action="${ctx}/terminalSettings/test">
						<ul>
							<li>
								 <div class="form-group">
									<label class="col-sm-2 control-label">1</label>
									<div class="col-sm-5">
										<input  class="form-control"  value="" placeholder="选择时间"  	
				            		name="screentime1" type="text" readonly="readonly"  class="form-control"   
				            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
				            		style = "width:140px;"/>
									</div>
									<div class="col-sm-5">
										<input type="checkbox" class="switch" id="screen_shoot_checkbox1">
									</div>
				            		
			            		</div>
							</li>
							<li>
								 <div class="form-group">
									<label class="col-sm-2 control-label">2</label>
									<div class="col-sm-5">
										<input  class="form-control" value="" placeholder="选择时间"  	
				            		name="screentime2" type="text" readonly="readonly"  class="form-control"   
				            		onclick="WdatePicker({dateFmt:'HH:mm'});"
				            		style = "width:140px;"/>
									</div>
									<div class="col-sm-5">
										<input type="checkbox" class="switch" id="screen_shoot_checkbox2">
									</div>
				            		
			            		</div>
							</li>
							<li>
								 <div class="form-group">
									<label class="col-sm-2 control-label">3</label>
									<div class="col-sm-5">
										<input  class="form-control" value="" placeholder="选择时间"  	
				            		name="screentime3" type="text" readonly="readonly"  class="form-control"   
				            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
				            		style = "width:140px;"/>
									</div>
									<div class="col-sm-5">
										<input type="checkbox" class="switch" id="screen_shoot_checkbox3">
									</div>
				            		
			            		</div>
							</li>
							<li>
								 <div class="form-group">
									<label class="col-sm-2 control-label">4</label>
									<div class="col-sm-5">
										<input  class="form-control" value="" placeholder="选择时间"  	
				            		name="screentime4" type="text" readonly="readonly"  class="form-control"   
				            		onclick="WdatePicker({dateFmt:'HH:mm',alwaysUseStartDate:false});"
				            		style = "width:140px;"/>
									</div>
									<div class="col-sm-5">
										<input type="checkbox" class="switch" id="screen_shoot_checkbox4">
									</div>
				            		
			            		</div>
							</li>
						</ul>
					</form>
				</div>
			</div>

		</div>
	</div>
</body>
</html>
