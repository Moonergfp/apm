
		
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	
	<%@include file="/WEB-INF/views/include/dialog.jsp" %>
	
	<style type="text/css">
	/* 
	body{
		margin: 0;
	} */
	.sort{
	    color:#0663A2;cursor:pointer;
	}
	.div_top{
		margin-top: 2%;
	}
/* 	.div_bottom ul{
		margin-left: 11%;
	} */
	.nav, .breadcrumb {
		margin-bottom: 0px;
	}
	.nav-tabs {
		border-bottom: 0px;
	}
	.nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li>a:hover, .nav-tabs>li.active>a:hover{
		border: 0px;
		border-bottom: 5px solid #08C;
	}
	.div_bottom{
	    border-bottom: 1px solid #ddd;
	}
	
	.div_table{
		padding-top: 10px;
	   /*  margin: 0 10% 0 11%; */
	    background-color: #f2f2f2;
	    padding: 30px 0;
	    margin-top: 20px;
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
	   width: 90%;
	   margin: 0 auto;
	}
	td{
		text-align: center;
	}
	.delete_span{
		padding-left: 10px;
	}
	</style>
	
	<script type="text/javascript">
		$(document).ready(function() {

		});
		
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/sys/user/");
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
 <div class="div_top">
   <tags:message content="${message}"/>
     <div class="div_bottom">
		<ul class="nav nav-tabs">
     	    <li class="active"><a href="${ctx}/sys/user">用户列表</a></li>
     	    <li><a href="${ctx }/sys/user/form">新建用户</a></li>
			<li><a href="${ctx}/sys/office">机构管理</a></li>
			<li><a href="${ctx}/sys/role">角色管理</a></li>
			<li><a href="${ctx}/sys/role/form?id=${role.id}">角色<shiro:hasPermission name="sys:role:edit">${not empty role.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:role:edit">查看</shiro:lacksPermission></a></li>
		</ul>
    </div>
    
    <div class="div_table">
      <div class="table_div">
		<table id="contentTable" class="table table-striped">
			<thead><tr><td>归属公司</td><td>登录名</td><td>姓名</td><td>电话</td><td>手机</td><td>角色</td><shiro:hasPermission name="sys:user:edit"><td>操作</td></shiro:hasPermission></tr></thead>
			<tbody>
			<c:forEach items="${page.list}" var="user">
				<tr>
					<td>${user.company.name}</td>
					<td>${user.loginName}</td>
					<td>${user.name}</td>
					<td>${user.phone}</td>
					<td>${user.mobile}</td>
					<td id="roleNames_${user.id}"></td>
						<script type="text/javascript">
							var arr="${user.roleNames}".split(",");
							var insertText = "";
							var insertEl = document.getElementById("roleNames_${user.id}");
							for(var i=0;i<arr.length;i++){
								insertText += '<span class="label label-success">' + arr[i] + '</span> ';
							}
							insertEl.innerHTML = insertEl.innerHTML + insertText;
						</script>
					<shiro:hasPermission name="sys:user:edit"><td>
	    				<a href="${ctx}/sys/user/form?id=${user.id}" title="修改"><span class="glyphicon glyphicon-check"></span></a>
						<a href="${ctx}/sys/user/delete?id=${user.id}" onclick="return confirmx('确认要删除该用户吗？', this.href)" title="删除"><span  class="glyphicon glyphicon-trash delete_span"></span></a>
					</td></shiro:hasPermission>
				</tr>
			</c:forEach>
			</tbody>
		 </table>
		 <div class="pagination">${page}</div>
	</div>
   </div>
 </div>
</body>
</html>