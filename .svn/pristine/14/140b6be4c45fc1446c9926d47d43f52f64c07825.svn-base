<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>发布记录</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/program/check_pro.css">
	<style type="text/css">
	#contentTable thead td{ height: 34px; line-height: 34px;}
	tbody tr td:nth-child(6){ text-align: center;}
	thead tr td:nth-child(6){ text-align: center;}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<div class="div_top">
     <div class="div_bottom">
	   <ul class="nav nav-tabs">
	   <c:if test="${publishProgram.type eq 'program'}">
		<li><a href="${ctx}/program/list">节目列表</a></li>
		</c:if>
		<c:if test="${publishProgram.type eq 'message'}">
		<li><a href="${ctx}/message/list">消息列表</a></li>
		</c:if>
		<li class="active"><a href="${ctx}/publishProgram/list?type=${publishProgram.type}">发布记录</a></li>
	   </ul> 
    </div>
  <%--   <tags:message content="${message}"/> --%>
     <form:form id="searchForm" action="${ctx}/publishProgram/list" method="post" modelAttribute="publishProgram">
            <input type="hidden" name="type" value="${publishProgram.type}">
            <c:if  test="${publishProgram.type eq 'program'}">
            	 <div style="height:34px; line-height:34px;margin-top:10px;">
					<div class="serach row"style="overflow: hidden;float: right; width: 900px;">
							<div class="col-sm-2"></div>
							<label for="tName" class="col-sm-1 control-label">终端名称：</label>
							<div class="col-sm-3">
								<input  name="tName" id="tName" class="form-control" type="text" value="${publishProgram.tName}" maxlength="100">
							</div>
							<label for="name" class="col-sm-1 control-label"  style="margin-left: 50px;">节目名称：</label>
							<div class="col-sm-3">
								<input  name="program.name" class="form-control" type="text" value="${publishProgram.program.name}" maxlength="100">
							</div>
						<button type="submit" class="btn btn-primary col-sm-1" style="margin-left: 10px;">搜索</button>
					</div>
			</div>
            </c:if>
             <c:if  test="${publishProgram.type eq 'message'}">
            	 <div style="height:34px; line-height:34px;margin-top:10px;">
					<div class="serach row"style="overflow: hidden;float: right; width: 900px;">
							<div class="col-sm-2"></div>
							<label for="tName" class="col-sm-1 control-label">终端名称：</label>
							<div class="col-sm-3">
								<input  name="tName" id="tName" class="form-control" type="text" value="${publishProgram.tName}" maxlength="100">
							</div>
							<label for="name" class="col-sm-1 control-label"  style="margin-left: 50px;">消息名称：</label>
							<div class="col-sm-3">
								<input  name="messageId.name" class="form-control" type="text" value="${publishProgram.messageId.name}" maxlength="100">
							</div>
						<button type="submit" class="btn btn-primary col-sm-1" style="margin-left: 10px;">搜索</button>
					</div>
			  </div>
            </c:if>
		    <!-- 节目列表 -->
		    <div class="div_table">
		    	<div class="table_div">
					<table id="contentTable" class="table table-striped">
					 <c:if  test="${publishProgram.type eq 'program'}">
            				<thead><tr><td>更新人</td><td>节目名称</td><td>节目预览</td><td>审核人
						</td><td>播放终端</td><td>广告商</td><td>发布状态</td></tr></thead>
						<tbody>
						<c:forEach items="${page.list}" var="pp">  
							<tr>
								<td>${pp.updateBy.name}</td>
								<td>${pp.program.name}</td>
								<td>预览</td>
								<td>${pp.checkUser.name}</td>
								<td><a href="" data-target="#tModal${pp.id}" data-toggle="modal">${pp.count}</a></td>
								<td>${pp.advertiserId}</td>
								<td>
									<a href="javascript:void(0);">
									<c:choose>
									 <c:when test="${pp.checkStatus eq '0'}">
									  未审核
									 </c:when>
									 <c:when test="${pp.checkStatus eq '1'}">
									  已发布
									 </c:when>
									 <c:when test="${pp.checkStatus eq '2'}">
									   发布失败
									 </c:when>
									 <c:when test="${pp.checkStatus eq '3'}">
									  审核未通过
									 </c:when>
									 <c:otherwise>
									         已过期
									 </c:otherwise>
									</c:choose>
									</a>
								</td>
							</tr>
						  </c:forEach>
						</tbody>
                    </c:if>
                     <c:if  test="${publishProgram.type eq 'message'}">
            				<thead><tr><td>更新人</td><td>消息名称</td><td>消息预览</td><td>审核人
						</td><td>播放终端</td><td>广告商</td><td>发布状态</td></tr></thead>
						<tbody>
						<c:forEach items="${page.list}" var="pp">  
							<tr>
								<td>${pp.updateBy.name}</td>
								<td>${pp.messageId.name}</td>
								<td>预览</td>
								<td>${pp.checkUser.name}</td>
								<td><a href="" data-target="#tModal${pp.id}" data-toggle="modal">${pp.count}</a></td>
								<td>${pp.advertiserId}</td>
								<td>
									<a href="javascript:void(0);">
									<c:choose>
									 <c:when test="${pp.checkStatus eq '0'}">
									  未审核
									 </c:when>
									 <c:when test="${pp.checkStatus eq '1'}">
									  已发布
									 </c:when>
									 <c:when test="${pp.checkStatus eq '2'}">
									   发布失败
									 </c:when>
									 <c:when test="${pp.checkStatus eq '3'}">
									  审核未通过
									 </c:when>
									 <c:otherwise>
									         已过期
									 </c:otherwise>
									</c:choose>
									</a>
								</td>
							</tr>
						  </c:forEach>
						</tbody>
                   </c:if>
					 </table>
					<div class="pagination">${page}</div>
				</div>
   			</div>
		</form:form>
 </div>
 <c:if  test="${publishProgram.type eq 'program'}">
 <c:forEach items="${page.list}" var="pub">
 	<div class="modal fade" id="tModal${pub.id}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
								  <div class="modal-dialog" role="document">
								    <div class="modal-content">
								      <div class="modal-header" style="text-align: center;">
								        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
								        <h4 class="modal-title">节目信息</h4>
								      </div>
								      <div class="modal-body" style="text-align: center;">
								       		 <table class="table table-bordered table-striped  table-condensed">
								       		 	<tr>
								       		 	  <td>节目名称</td>
								       		 	  <td>${pub.program.name}</td>
								       		 	</tr>
								       		 	<tr>
								       		 	  <td>节目时长</td>
								       		 	  <td>${pub.program.playTime}</td>
								       		 	</tr>
								       		 	<tr>
								       		 		<td>分辨率</td>
								       		 		<td>${pub.program.ratio}</td>
								       		 	</tr>
								       		 	<c:forEach items="${pub.terminals}" var="t" varStatus="in">
								       		 	 <tr>
								       		 	 	<c:if test="${in.index == 0}">
								       		 		 <td rowspan="${pub.count}" style="vertical-align: middle">播放终端</td>
								       		 		</c:if>
								       		 		<td>${t.name}</td>
								       		 	 </tr>
								       		 	</c:forEach>
								       		 </table>
								      </div>  
								    </div>
								  </div>
								</div>
				 </c:forEach>
		 </c:if>
 
  <c:if  test="${publishProgram.type eq 'message'}">
 <c:forEach items="${page.list}" var="pub">
 	<div class="modal fade" id="tModal${pub.id}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
								  <div class="modal-dialog" role="document">
								    <div class="modal-content">
								      <div class="modal-header" style="text-align: center;">
								        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
								        <h4 class="modal-title">节目信息</h4>
								      </div>
								      <div class="modal-body" style="text-align: center;">
								       		 <table class="table table-bordered table-striped  table-condensed">
								       		 	<tr>
								       		 	  <td>消息名称</td>
								       		 	  <td>${pub.messageId.name}</td>
								       		 	</tr>
								       		 	<tr>
								       		 	  <td>消息时长</td>
								       		 	  <td>${pub.messageId.playTime}</td>
								       		 	</tr>
								       		 	<c:forEach items="${pub.terminals}" var="t" varStatus="in">
								       		 	 <tr>
								       		 	 	<c:if test="${in.index == 0}">
								       		 		 <td rowspan="${pub.count}" style="vertical-align: middle">播放终端</td>
								       		 		</c:if>
								       		 		<td>${t.name}</td>
								       		 	 </tr>
								       		 	</c:forEach>
								       		 </table>
								      </div>  
								    </div>
								  </div>
								</div>
 </c:forEach>
 </c:if>
</body>
</html>
