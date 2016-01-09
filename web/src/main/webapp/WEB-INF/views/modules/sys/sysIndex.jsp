<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${fns:getConfig('productName')}</title>
	<%@include file="/WEB-INF/views/include/dialog.jsp" %>
	<meta name="decorator" content="default"/>
	<link type="text/css" href="${ctxStatic}/css/index/font-awesome.css" rel="stylesheet" />
	<link type="text/css" href="${ctxStatic}/css/index/style.css" rel="stylesheet" />
	<script type="text/javascript" src="${ctxStatic}/js/index/script.js"></script>
	<style type="text/css">
	 #footer{
	 	/* margin: 20px 0 0 0; */
	 }
	 
	 .index_buttom{
	     /* padding: 0 0 0 10%; */
	     width: 100%;
	     height: 100%;
    }
    
    .frame_buttom{
    	width: 100%;
    }
    
    .index_top{
        height: 56px;
    }
    
    .footer_buttom{
	    border-top: 2px solid #0663A2;
	    width: 100%;
	    font-size: 11px;
	    text-align: center;
	    color: #999;
	    padding-top: 3px;
    }
    
    .divider{
        padding: 0px;
        border-bottom: 1px solid #eee;
    }
	</style>
	<script type="text/javascript"> 
		$(document).ready(function() {
			 $(".venus-menu a").bind("click", function(e){
				 //点击之前去掉所有li的active
				 $(".venus-menu li").removeClass("active");
				 //给当前点击的li加上active
				 $(this).parent().addClass("active");
				 //给父级的所有li加上active
				 $(this).parent().parents("li").addClass("active");
				 //默认选中第一个子节点
				 $(this).parent().find("li").eq(0).addClass("active");
				 e.stopPropagation();
			 })
		});
	</script>
</head>
<body>
<div id="main">
   <div class="index_top" id="header">
	<ul class="venus-menu">
		<li class="active"><a href="${ctx}/sys/menu/index_default" target="mainFrame"><i class="icon-home"></i>朗国电子</a></li>
		<c:forEach items="${fns:getMenuList()}" var="menu">
			<c:if test="${menu.parent.id eq '1' && menu.isShow eq '1'}">
				<li>
				  <a href="javascript:void(0);"><i class="icon-magic"></i>${menu.name}</a>
				  <ul>
				  	<c:forEach items="${fns:getMenuList()}" var="childMenu">
				  		<c:if test="${childMenu.parent.id eq menu.id && childMenu.isShow eq '1'}">
				  			<li><a href="${fn:indexOf(childMenu.href, '://') eq -1?ctx : ''}${not empty childMenu.href?childMenu.href: '/404'}" target="${not empty childMenu.target?childMenu.target:'mainFrame'}">${childMenu.name}</a></li>
				  		</c:if>
				  	</c:forEach>
				  </ul>
				</li>	
			</c:if> 
		</c:forEach>
		<li style="float: right;">
			<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="true">您好,<shiro:principal property="name"/>&nbsp;<span class="caret"></span></a>
			<ul>
			    <li><a href="/apm-web/a/sys/user/info" target="mainFrame"><i class="icon-user"></i>&nbsp; 个人信息</a></li>
			    <li><a href="/apm-web/a/sys/user/modifyPwd" target="mainFrame"><i class="icon-lock"></i>&nbsp;  修改密码</a></li>
			    <li class="divider"></li>
			    <li><a href="/apm-web/a/logout" title="退出登录">退出</a></li>
			</ul>
		</li>
	</ul>
</div>
	<div class="index_buttom">
  	<iframe id="mainFrame" src="${ctx}/sys/menu/index_default" name="mainFrame" style="overflow:scroll;overflow-x:auto;overflow-y:auto;height:650px" scrolling="yes" frameborder="0" width="100%"></iframe>
  </div>
  <div id="footer" class="row">
	    <div class="footer_buttom">
	     Copyright &copy; 2012-${fns:getConfig('copyrightYear')} Powered By veasy ${fns:getConfig('version')}<!-- ${fns:getConfig('productName')} - -->
	    </div>
</div>
</div>
<script>
var getWindowSize = function(){
	return ["Height","Width"].map(function(name){
	  return window["inner"+name] ||
		document.compatMode === "CSS1Compat" && document.documentElement[ "client" + name ] || document.body[ "client" + name ];
	});
};

function wSize(){
	var minHeight = 500, minWidth = 980;
	var strs=getWindowSize().toString().split(",");
	$("#mainFrame").height((strs[0]<minHeight?minHeight:strs[0])-$("#header").height()-$("#footer").height()-6);
	if(strs[1]<minWidth){
		$("#main").css("width",minWidth-10);
		$("html,body").css({"overflow":"auto","overflow-x":"auto","overflow-y":"auto"});
	}else{
		$("#main").css("width","auto");
		$("html,body").css({"overflow":"hidden","overflow-x":"hidden","overflow-y":"hidden"});
	}
}	

$(window).resize(function(){
	wSize();
});
wSize(); // 在主窗体中定义，设置调整目标
</script>
</body>
</html>