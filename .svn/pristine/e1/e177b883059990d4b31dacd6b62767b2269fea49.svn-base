<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>节目审核</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/program/check_pro.css">
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#searchForm").submit();
	    	return false;
        }
         //按条件搜索审核发布节目
        function searchInfo(){
        	$("#searchForm").submit();
        }

        //审核
        function check(pubProId,checkStatus){
        	console.log("proId===>" + pubProId);
        	var url = "${ctx}/publishProgram/checkPubPro";
        	var remark = $("#remark" + pubProId).val();
        	console.log("checkStatus==>" + checkStatus);
        	console.log("remark==>" + remark);
        	var data = {id:pubProId,checkStatus:checkStatus,remarks:remark};
        	$.ajax({
        		url:url,
        		data:data,
        		type:"POST",
        		success:function(data){    			
        			window.location.href="${ctx}/publishProgram/checklist";
        		}
        	});
        }

        function showRemark(){
			console.log("审核不通过");
        	$(".check").hide();
        	$(".remark").show();
        }
         function showCheck(){
			console.log("审核不通过");
        	$(".check").show();
        	$(".remark").hide();
        }
	</script>
	<style type="text/css">
		#contentTable thead td{
			height: 34px;
  		    line-height: 34px;
		}
		    
	</style>
</head>
<body>
	<div class="div_top">
   		<tags:message content="${message}"/>
	     <div class="div_bottom">
			<ul class="nav nav-tabs">
	     	    <li class="active"><a href="${ctx}/publishProgram/checklist">节目审核</a></li>
	     	     <li><a href="${ctx}/publishMessage/checklist">消息审核</a></li>
			</ul>
	    </div>
	    <form action="${ctx}/publishProgram/checklist" id="searchForm">
		    <div style="height:34px; line-height:34px;margin-top:10px;">
					<div class="serach row"style="overflow: hidden;float: right; width: 900px;">
							<div class="col-sm-2"></div>
							<label for="name" class="col-sm-1 control-label">所属机构：</label>
							<div class="col-sm-3">
								<input id="search_office_name" name="office.name" class="form-control" type="text" value="" maxlength="100">
							</div>
							<label for="name" class="col-sm-1 control-label"  style="margin-left: 50px;">节目名称：</label>
							<div class="col-sm-3">
								<input id="search_program_name" name="program.name" class="form-control" type="text" value="" maxlength="100">
							</div>
						<button class="btn btn-primary col-sm-1" onclick="searchInfo()" style="margin-left: 10px;">搜索</button>
					</div>
			</div>
		    <!-- 节目列表 -->
		    <div class="div_table">
		    	<div class="table_div">
		    		
					<table id="contentTable" class="table table-striped">
						<thead><tr><td>更新人</td><td>节目名称</td><td>所属机构</td><td>广告商</td><td>提交时间</td><td>
							<select class="form-control" style="min-width: 80px; width: 50%; margin: 0 auto;font-size:13px;" name="checkStatus" id="" onchange="searchInfo()">
								<option value="-1" <c:if test="${checkStatus eq '-1' }">selected='selected'</c:if>>全部</option>
								<option value="0" <c:if test="${checkStatus eq '0' }">selected='selected'</c:if>>待审核</option>
								<option value="1" <c:if test="${checkStatus eq '1' }">selected='selected'</c:if>>已审核</option>
							</select>

						</td></tr></thead>
						<tbody>
						<c:forEach items="${pubPros}" var="pubPro">  
							<tr>
								<td>${pubPro.publishUser.name}</td>
								<td>${pubPro.program.name}</td>
								<td>${pubPro.office.name}</td>
								<c:choose> 
									  <c:when test="${empty pubPro.advertiserId}">   
										<td>无</td>
									  </c:when> 
									  <c:otherwise>   
									  	<td>${pubPro.advertiserId}</td>  
									  </c:otherwise> 
								</c:choose>
								<td><fmt:formatDate value="${pubPro.createDate}" pattern="yyyy-MM-dd" /> </td>

								<c:choose> 
									  <c:when test="${pubPro.checkStatus eq '0'}">   
										 <td style="text-align: center;"><a href="" data-target="#modal${pubPro.id}" data-toggle="modal" class="shenhe">审核</a></td>
									  </c:when> 
									    <c:when test="${pubPro.checkStatus eq '4'}">   
										 <td style="text-align: center;">审核不通过</td>
									  </c:when> 
									  <c:otherwise>   
									 	  <td style="text-align: center;"><a href="">导出</a></td>
									  </c:otherwise> 
								</c:choose>
								<div class="modal fade" id="modal${pubPro.id}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
								  <div class="modal-dialog" role="document">
								    <div class="modal-content">
								      <div class="modal-body" >
								      	<div class="info">
									      	<!-- 节目场景切换 -->
											<div class="program">场景</div>	      	
											<!--  节目基本信息-->
											<div class="program_info">
												<div class="row">
													<div class="col-md-4"><span>分辨率：${pubPro.program.ratio}</span></div>
													<div class="col-md-4"><span>节目名称：${pubPro.program.name}</span></div>
													<div class="col-md-4">
														<span>广告商：
														<c:choose> 
															  <c:when test="${empty pubPro.advertiserId}">   
																无
															  </c:when> 
															  <c:otherwise>   
															  	${pubPro.advertiserId}
															  </c:otherwise> 
														</c:choose>
														</span>
													</div>
												</div>
											</div>
											<!-- 节目播放日期时间段 -->
											<div class="playTimes items">
												<div class="row">
													<div class="col-md-4 row-label"><span>播放日期段</span></div>
													<div class="col-md-8 row-content" >
														<c:forEach items="${pubPro.timeSettings}" var="settings">  
															<div><span>日期：${settings.sSegment}~${settings.eSegment}</span>
																<span>时间段</span>
																<c:forEach items="${settings.times}" var="time">  
																	<span>${time}</span>
																</c:forEach>
															</div>
														</c:forEach>
													</div>

												</div>

											</div>
											
											<!-- 节目播放终端 -->
											<div class="terminals items">
												<div class="row">
													<div class="col-md-4 row-label"><span>播放终端</span></div>
													<div class="col-md-8 row-content" > 
														<c:forEach items="${pubPro.terminals}" var="terminal">  
														<div><span>${terminal.name}</span></div>
														</c:forEach>
													</div>
												</div>
									     	</div>
								     		
								     		<div class="btn_box row">
								     			<div class="check" style="overflow: hidden;">
									     			<div class="col-md-6"><span><a href="javascript:void(0)" class="btn btn-primary" onclick="check(${pubPro.id},1)">通过</a></span></div>
									     			<div class="col-md-6"><span><a href="javascript:void(0)" class="btn btn-primary" onclick="showRemark()">不通过</a></span></div>
								     			</div>
								     			<div class="remark" style="display:none">
								     				<div class="form-inline">
									     				 <div class="form-group">
									     				 	<textarea class="form-control" id="remark${pubPro.id}" cols="30" rows="3" placeholder="备注"></textarea>
									     				 </div>
									     				<button class="btn btn-primary" onclick="check(${pubPro.id},4)">确定</button>
									     				<button class="btn btn-primary" onclick="showCheck()">取消</button>
								     				</div>
								     			</div>
								     		</div>

								      </div>
								    </div>
								  </div>
								</div>
							</tr>
						  </c:forEach>
						</tbody>
					 </table>
				 	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					<div class="pagination">${page}</div>
				</div>
   			</div>
		</form>
   		</div>
	<script>
		$(".modal").on('shown.bs.modal', function () {
			$(this).find(".items").find(".row").each(function(){
				var height = $(this).find(".row-content")[0].offsetHeight + "px";
				$(this).find(".row-label").css("height",height);
				$(this).find(".row-label").css("line-height",height);
			})
		});
	</script>
</body>
</html>
