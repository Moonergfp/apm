<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>操作日志首页</title>
	<meta name="decorator" content="default"/>
	
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/systemManage/sysManage_common.css">

	<style type="text/css">
	.div_table{
		padding-top: 5px;
	   /*  margin: 0 10% 0 11%; */
	    background-color: #f2f2f2;
	    padding: 10px 0;
	    margin-top: 5px;
	    /* box-shadow: 0px 0px 5px #ddd; */
	}
	.table>tbody>tr>td,.table>thead>tr>td{
	  border-top: 0px;
	}
	.table-striped>tbody>tr:nth-of-type(odd){
	  background-color: #f2f2f2;
	}
	.table-striped>tbody>tr:nth-of-type(even){
	  background-color: #fff;
	}
	thead tr{
		font-weight: bold;
		border: 2px solid #ddd;
		background-color: #fff;
	}
	thead tr td:nth-child(6){
		text-align: left;
	}
	tbody tr td:nth-child(6){
		text-align: left;
	}
	.table_div{
	   /* width: 90%; */
	   margin: 0 0;
	}
	td{
		text-align: center;
	}
	.delete_span{
		padding-left: 10px;
	}
	</style>
</head>
<body>

	<div>
		<div class="div_top">
			<div class="div_bottom">
				<ul class="nav nav-tabs">
					<li class="active"><a href="/apm-web/a/sys/log">操作日志</a></li>
					<li><a href="">播放报表</a></li>
				</ul>
			</div>
		</div>
	<div class="div_table">
    	<div class="table_div">
    			
   		<form id = "searchForm" class = "form-inline" action="${ctx}/sys/log" method = "post">
   			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
            <div>
	            <div class = "text-left" style = "float:left">
	            	<span><a href="/apm-web/a/sys/log" class="btn btn-primary">刷新</a></span>
            	</div>
            	
            	<div class = "text-right">
		            <span>
			            <input id="beginDate" value="" placeholder="开始时间"
			            	name="beginDate" type="text" readonly="readonly"  class="form-control"   
			            	onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
			            	style = "width:140px;background-color: white;"/>
					</span>
					&nbsp;&nbsp;&nbsp;
		            <span>
		            	<input id="endDate" value="" placeholder="结束时间"  	
		            		name="endDate" type="text" readonly="readonly"  class="form-control"   
		            		onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
		            		style = "width:140px;background-color: white;"/>
		            </span>
		            
		            <span>&nbsp;&nbsp;&nbsp;&nbsp;<button class="btn btn-primary" type = "submit">搜索</button></span>
	            </div>
            </div>
           </form>
       </div>

			<table id="contentTable" class="table table-striped" style="margin-top: 10px;">
		<thead>
			<tr>
				<th>所在公司</th>
				<th>所在部门</th>
				<th>操作用户</th>
				<th>URI</th>
				<th>提交方式</th>
				<th>操作者IP</th>
				<th>创建时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${logList}" var="log">
			<tr>
				<td>${log.createBy.company.name}</td>
				<td>${log.createBy.office.name}</td>
				<td>${log.createBy.name}</td>
				<td><strong>${fns:abbr(log.uri,50)}</strong></td>
				<td>${log.method}</td>
				<td>${log.accessorIp}</td>
				<td><tags:prettyTime date="${log.createDate}"></tags:prettyTime></td>
			</tr>
			
		</c:forEach>
		</tbody>
		</table>
       </div>
	</div>
	
	<div class="pagination" style = "margin-top:15px;">${page}</div>
	
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</body>
</html>