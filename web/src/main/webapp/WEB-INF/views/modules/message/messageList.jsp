<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>消息列表</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/program/check_pro.css">
	<style type="text/css">
	#contentTable thead td{ height: 34px; line-height: 34px;}
	tbody tr td:nth-child(6){ text-align: center;}
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
		function searchInfo(){
			$("#searchForm").submit();
		}
	</script>
</head>
<body>
	<div class="div_top">
     <div class="div_bottom">
	   <ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/message/list">消息列表</a></li>
		<li><a href="${ctx}/publishProgram/list?type=message">发布记录</a></li>
	   </ul> 
    </div>
    <%-- <tags:message content="${message}"/> --%>
     <form:form id="searchForm" action="${ctx}/message/list" method="post" modelAttribute="message">
		    <div style="height:34px; line-height:34px;margin-top:10px;">
					<div class="serach row"style="overflow: hidden;float: right; width: 900px;">
							<div class="col-sm-2"></div>
							<label for="tName" class="col-sm-1 control-label">终端名称：</label>
							<div class="col-sm-3">
								<input  name="tName" id="tName" class="form-control" type="text" value="${message.tName}" maxlength="100">
							</div>
							<label for="name" class="col-sm-1 control-label"  style="margin-left: 50px;">消息名称：</label>
							<div class="col-sm-3">
								<input  name="name" class="form-control" type="text" value="${message.name}" maxlength="100">
							</div>
						<button type="submit" class="btn btn-primary col-sm-1" style="margin-left: 10px;">搜索</button>
					</div>
			</div>
		    <!-- 节目列表 -->
		    <div class="div_table">
		    	<div class="table_div">
					<table id="contentTable" class="table table-striped">
						<thead><tr><td>更新人</td><td>制作时间</td><td>节目名称</td><td>节目预览</td><td>广告商</td><td>
							<select class="form-control" style="min-width: 80px; width: 50%; margin: 0 auto;font-size:13px;" name="type" id="" onchange="searchInfo()">
								<option value="1" <c:if test="${message.type eq '1' }">selected='selected'</c:if>>机构消息</option>
								<option value="0" <c:if test="${message.type eq '0' }">selected='selected'</c:if>>我的消息</option>
							</select>
						</td></tr></thead>
						<tbody>
						<c:forEach items="${page.list}" var="message">  
							<tr>
								<td>${message.updateBy.name}</td>
								<td><fmt:formatDate value="${message.createDate}" pattern="yyyy-MM-dd" /></td>
								<td>${message.name}</td>
								<td>预览</td>
								<td>${message.advertiserId}</td>
								<td><a href="${ctx}/publishProgram/list?message.id=${message.id}&type=message">查看</a></td>
							</tr>
						  </c:forEach>
						</tbody>
					 </table>
					<div class="pagination">${page}</div>
				</div>
   			</div>
		</form:form>
 </div>
</body>
</html>
