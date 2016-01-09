<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>节目实体类列表</title>
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
		<li class="active"><a href="${ctx}/program/list">节目列表</a></li>
		<li><a href="${ctx}/publishProgram/list?type=program">发布记录</a></li>
	   </ul> 
    </div>
    <tags:message content="${message}"/>
     <form:form id="searchForm" action="${ctx}/program/list" method="post" modelAttribute="program">
		    <div style="height:34px; line-height:34px;margin-top:10px;">
					<div class="serach row"style="overflow: hidden;float: right; width: 900px;">
							<div class="col-sm-2"></div>
							<label for="tName" class="col-sm-1 control-label">终端名称：</label>
							<div class="col-sm-3">
								<input  name="tName" id="tName" class="form-control" type="text" value="${program.tName}" maxlength="100">
							</div>
							<label for="name" class="col-sm-1 control-label"  style="margin-left: 50px;">节目名称：</label>
							<div class="col-sm-3">
								<input  name="name" class="form-control" type="text" value="${program.name}" maxlength="100">
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
								<option value="1" <c:if test="${program.type eq '1' }">selected='selected'</c:if>>机构节目</option>
								<option value="0" <c:if test="${program.type eq '0' }">selected='selected'</c:if>>我的节目</option>
							</select>
						</td></tr></thead>
						<tbody>
						<c:forEach items="${page.list}" var="program">  
							<tr>
								<td>${program.updateBy.name}</td>
								<td><fmt:formatDate value="${program.createDate}" pattern="yyyy-MM-dd" /></td>
								<td>${program.name}</td>
								<td>预览</td>
								<td>${program.advertiserId}</td>
								<td><a href="${ctx}/publishProgram/list?program.id=${program.id}&type=program">查看</a></td>
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
