<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<title>素材管理首页</title>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/systemManage/sysManage_common.css">
	<%-- <script type="text/javascript" src="${ctxStatic}/bootstrap-3.3.5-dist/js/bootstrap-switch.min.js"></script>
	 --%>
	 
	 <style type="text/css">
	 	#main{margin-top:15px;}
	 	table{border:1px solid #DDD;}
	 	.colorSelect{background-color: #E8E8E8;}
		.colorNotSelect{background-color: white;}
		
		.template-div{margin-top: 15px;}
		#inputForm select:first-child {width: 80px; display: inline-block}
		.input-search{width: 280px;}
		.select-display{display: none;}
		.select-width{width: 120px;}
		.select-dis{display: inline-block;}
		.form-border{height: 45px; border-bottom: 1px solid #ddd;}
		.template-create{font-size: 90px; line-height: 240px; color: #fff;}
		.white-template{width: 235px; height:240px; background-color: #bdd5ef; text-align: center;}
		
		.row{margin: 0;}
		.col-md-3{padding: 0;}
		.template-div .row-img{cursor: pointer; width: 235px; height: 300px; box-shadow: 0 2px 3px rgba(0,0,0,.3);float: left;position: relative;}
		.template-div .row-img:hover .hover-div{display: block}
		.template-div .row-img p{height: 60px; text-align: center;}
		.template-div .row-img span{line-height: 60px;}
		.row-margin{margin-left: 40px;}
		.template-div .row-img img{width: 235px; height: 240px;}
		.hover-div{position: absolute; top: 0;left: 0;display: none; width: 100%; height: 240px;}
		.hover-div a{width: 120px;background-color: #08a1ef;z-index: 2; position: relative;left: 60px; top:60px;}
		.hover-div a:last-child{margin-top: 40px;}
	 	
	 </style>
</head>

<body>
	<tags:message content="${message}"/>
	<div class="div_top">
		<div class="div_bottom">
			<ul class="nav nav-tabs">
				<li class="active"><a href="${ctx}/resManage/myRes">素材管理</a></li>
				<li><a href="">我的模板</a></li>
				<li><a href="">模板商城</a></li>
			</ul>
		</div>
	</div>
	
	<div id = "main"> 
		<div id = "left" style = "width:20%">
			<table class = "table" style = "width:150px;text-align:center;">
				<tr>
					<td>
						<div style = "display:inline;float:left;
							padding-top:8px;padding-left:53px;">
							类别
						</div>
						<div style = "display:inline;float:right;
							padding-top:8px;">
							<a href = "javascript:void(0);" onclick = "newClassify();">新建</a>
						</div>
						<div style = "clear:both"></div>
					</td>
				</tr>
				<c:forEach items="${dictList}" var="dict" varStatus="status">
					<c:choose>
						<c:when test="${ (status.index + 1) == 1}">
							<tr class = "classifyItem colorSelect">
						</c:when>
						<c:when test="${ (status.index + 1) != 1}">
							<tr class = "classifyItem colorNotSelect">
						</c:when>
					</c:choose>
						<td>
							<input type = "hidden" name = "dictId" id = "dictId" 
								value = "${dict.id}">
							<div style = "display:inline">${dict.chineseName}</div>
							<c:choose>
								<c:when test="${ dict.hasSubFolder == true}">
									<div style = "position:relative;float:right;" 
										class = "glyphicon glyphicon-triangle-right">
									</div>
									<div style = "clear:both"></div>
								</c:when>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		
		<div id = "right" style = "padding:10px 30px;width:80%;">
			<div style = "width:100%">
				<div style = "float:left">
					<span><input type = "checkbox"></span>
					<span>我的素材</span>
				</div>
				<div style = "float:right;width:200px;">
					<span>
						<input type = "text" class = "form-control" style = "width:140px;
							display:inline" placeholder="关键词">
						<button class = "btn btn-info ">搜索</button>
					</span>
				</div>
				<div style = "clear:both;"></div>
			</div>
			
			<div style = "margin-top:15px;">
				<div style = "float:left">
					<span><button class = "btn btn-info">上传素材</button></span>
					<span><button class = "btn btn-info">最新</button></span>
					<span><button class = "btn btn-info">最热</button></span>
				</div>
				
				<div style = "float:right;">
					<span><button class = "btn btn-info">网格</button></span>
					<span><button class = "btn btn-info">横条</button></span>
				</div>
				<div style = "clear:both;"></div>
			</div>
			
			<div class="template-div">
				<div class="row">
					<div class="col-md-3 row-img row-margin">
						<div><img src="${ctxStatic}/images/testImg/u9.jpg"></div>
		      			<p><span>系统模板</span></p>
		      			<div class="hover-div">
		      				<div style="background-color: #000; opacity: 0.5;
		      					width: 235px;height: 240px;z-index: 1;position: absolute;">
		      			 	</div>
		   			 		<a href="javascript:void(0);" class="btn btn-primary">预览</a>
		   				    <a href="javascript:void(0);" class="btn btn-primary" data-toggle="modal" data-target="#programModal">编辑</a>
		      			</div>
					</div>
					
					<div class="col-md-3 row-img row-margin">
						<div><img src="${ctxStatic}/images/testImg/u9.jpg"></div>
		      			<p><span>系统模板</span></p>
		      			<div class="hover-div">
		      				<div style="background-color: #000; opacity: 0.5;
		      					width: 235px;height: 240px;z-index: 1;position: absolute;">
		      			 	</div>
		   			 		<a href="javascript:void(0);" class="btn btn-primary">预览</a>
		   				    <a href="javascript:void(0);" class="btn btn-primary" data-toggle="modal" data-target="#programModal">编辑</a>
		      			</div>
					</div>
					
					<div class="col-md-3 row-img row-margin">
						<div><img src="${ctxStatic}/images/testImg/u9.jpg"></div>
		      			<p><span>系统模板</span></p>
		      			<div class="hover-div">
		      				<div style="background-color: #000; opacity: 0.5;
		      					width: 235px;height: 240px;z-index: 1;position: absolute;">
		      			 	</div>
		   			 		<a href="javascript:void(0);" class="btn btn-primary">预览</a>
		   				    <a href="javascript:void(0);" class="btn btn-primary" data-toggle="modal" data-target="#programModal">编辑</a>
		      			</div>
					</div>
					
					<div class="col-md-3 row-img row-margin">
						<div><img src="${ctxStatic}/images/testImg/u9.jpg"></div>
		      			<p><span>系统模板</span></p>
		      			<div class="hover-div">
		      				<div style="background-color: #000; opacity: 0.5;
		      					width: 235px;height: 240px;z-index: 1;position: absolute;">
		      			 	</div>
		   			 		<a href="javascript:void(0);" class="btn btn-primary">预览</a>
		   				    <a href="javascript:void(0);" class="btn btn-primary" data-toggle="modal" data-target="#programModal">编辑</a>
		      			</div>
					</div>
					
					<div class="col-md-3 row-img row-margin">
						<div><img src="${ctxStatic}/images/testImg/u9.jpg"></div>
		      			<p><span>系统模板</span></p>
		      			<div class="hover-div">
		      				<div style="background-color: #000; opacity: 0.5;
		      					width: 235px;height: 240px;z-index: 1;position: absolute;">
		      			 	</div>
		   			 		<a href="javascript:void(0);" class="btn btn-primary">预览</a>
		   				    <a href="javascript:void(0);" class="btn btn-primary" data-toggle="modal" data-target="#programModal">编辑</a>
		      			</div>
					</div>
					<div class="col-md-3 row-img row-margin">
						<div><img src="${ctxStatic}/images/testImg/u9.jpg"></div>
		      			<p><span>系统模板</span></p>
		      			<div class="hover-div">
		      				<div style="background-color: #000; opacity: 0.5;
		      					width: 235px;height: 240px;z-index: 1;position: absolute;">
		      			 	</div>
		   			 		<a href="javascript:void(0);" class="btn btn-primary">预览</a>
		   				    <a href="javascript:void(0);" class="btn btn-primary" data-toggle="modal" data-target="#programModal">编辑</a>
		      			</div>
					</div>
					<div class="col-md-3 row-img row-margin">
						<div><img src="${ctxStatic}/images/testImg/u9.jpg"></div>
		      			<p><span>系统模板</span></p>
		      			<div class="hover-div">
		      				<div style="background-color: #000; opacity: 0.5;
		      					width: 235px;height: 240px;z-index: 1;position: absolute;">
		      			 	</div>
		   			 		<a href="javascript:void(0);" class="btn btn-primary">预览</a>
		   				    <a href="javascript:void(0);" class="btn btn-primary" data-toggle="modal" data-target="#programModal">编辑</a>
		      			</div>
					</div>
					<div class="col-md-3 row-img row-margin">
						<div><img src="${ctxStatic}/images/testImg/u9.jpg"></div>
		      			<p><span>系统模板</span></p>
		      			<div class="hover-div">
		      				<div style="background-color: #000; opacity: 0.5;
		      					width: 235px;height: 240px;z-index: 1;position: absolute;">
		      			 	</div>
		   			 		<a href="javascript:void(0);" class="btn btn-primary">预览</a>
		   				    <a href="javascript:void(0);" class="btn btn-primary" data-toggle="modal" data-target="#programModal">编辑</a>
		      			</div>
					</div>
			    </div>
			</div>
			
			<div class="modal fade bs-example-modal-lg material-modal" 
				id="programModal" tabindex="-1" role="dialog" aria-labelledby="programModalLabel">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header" style="text-align: center;">
							<button type="button" class="close" data-dismiss="modal" 
								aria-label="Close"><span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="myModalLabel">新建节目</h4>
						</div>
						<div class="modal-body" style="text-align: center;">
							<form class="form-horizontal">
								<div class="form-group">
			    					<label for="programName" class="col-sm-4 control-label">
			    						节目名称</label>
			    					<div class="col-sm-5">
			      					<input type="text" class="form-control required" 
			      						id="programName" placeholder="请填写节目名称">
			    					</div>
			  					</div>
			  					<div class="form-group">
			    					<label for="adver" class="col-sm-4 control-label">选择广告商</label>
			    					<div class="col-sm-5">
			      						<select  class="form-control" id="adver">
			      							<option value="广告商A">广告商A</option>
			      							<option value="广告商B">广告商B</option>
			      							<option value="广告商C">广告商C</option>
			      						</select>
			    					</div>
			  					</div>
							</form>
      					</div>  
				        <div class="modal-footer">
				        	<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				        	<button type="button" class="btn btn-primary" onclick="save();">保存</button>
				        </div>  
					</div>
				</div>
			</div>
		
		<div style = "clear:both"></div>
	</div>
	</div>
	
	<script type="text/javascript">
		// ==================================================
		// ===============分类的背景颜色控制================
		// ==================================================
		$('.classifyItem').live("mouseover",function(){
			$(this).css("cursor","pointer");
			$(this).removeClass("colorNotSelect");
			$(this).addClass("colorSelect");
		})
		$('.classifyItem').live("mouseout",function(){	
			if($('.colorSelect').length == 2){
				$(this).removeClass("colorSelect");
				$(this).addClass("colorNotSelect");
			}
		})
		
		// ==================================================
		// ===============单击某个分类================
		// ==================================================
		$('.classifyItem').live("click",function(){
			$('.classifyItem').removeClass("colorSelect");
			$('.classifyItem').addClass("colorNotSelect");
			$(this).removeClass("colorNotSelect");
			$(this).addClass("colorSelect");
			
			//请求该组分类
			if( $('.colorSelect').find(".glyphicon-triangle-right").length == 1 )
				findClassifyFolder();
		})
		
		// ==================================================
		// ===============单击分类的新建================
		// ==================================================
		function newClassify(){
			
			//请求该组分类
			if( $('.colorSelect').find(".glyphicon-triangle-right").length == 1 )
				findClasssifyFolder();
			
			//创建新建输入框
			if($('.colorSelect').after().hasClass("addClassify")) ;
			else{
				$('.colorSelect').after(
					"<tr class = \"classifyItem colorSelect addClassify\">" +
						"<td>" +
							"<input class = \"form-control\" type = \"text\" style = \"width:100%\" >" +
						"</td>" +
					"</tr>"
				);
				
				$('.addClassify').prev().removeClass("colorSelect");
			}
		}
		
		function findClassifyFolder(){
			//先得到该类型下的所有文件夹
			var id = $('.colorSelect').find('#dictId').val();
			$.ajax({
				url:"${ctx}/resManage/getFolders",
				data:{
					dictId:id,
				},
				type:'post',
				dataType:'json',
				success:function(data){
					if(data.msg == "success"){
						for(var i = 0; i < data.dictList.length; ++i){
							var dict = data.dictList[i];
							$('.colorSelect').after(
								"<tr class = \"classifyItem colorNotSelect\">" +
									"<td>" +
										"<input type = \"hidden\" name = \"dictId\" id = \"dictId\" " +
											"value = \" "+ dict.id +" \"> " +
										"<span>"+ dict.chineseName +"</span>" +
									"</td>" +
								"</tr>"
							);
						}	
						
						var element = $('.colorSelect').find(".glyphicon-triangle-right");
						element.removeClass("glyphicon-triangle-right");
						element.addClass("glyphicon glyphicon-triangle-bottom");
						
					} else {
					}
				},
				error:function(){
				}
			}) 
		}
	</script>
	
</body>
</html>