<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${fns:getConfig('productName')}</title>
	<%@include file="/WEB-INF/views/include/dialog.jsp" %>
	<meta name="decorator" content="default"/>
	<link type="text/css" href="${ctxStatic}/css/index/base.css" rel="stylesheet" />
	<script type="text/javascript" src="${ctxStatic}/js/index/base.js"></script>
	<script type="text/javascript" src="${ctxStatic}/js/index/jquery.easing.js"></script>
	<style type="text/css">
	 .img_index{
	        width: 100%;
    		height: 100%;
	 }
	 .index_buttom{
	 	    margin-top: 5%;
		    float: right;
		    padding-right: 8%;
		    width: 40%;
		    height: 420px;
	 }
	</style>
	
</head>
<body>
   <div class="s-mod w1100">
	<div class="s-mod-loding"><img src="/apm-web/static/images/login/loading_d.gif" tppabs="http://www.17sucai.com/preview/2293/2014-02-20/win8%E9%A3%8E%E6%A0%BC/images/loading_d.gif"></div>
	<ul>
		<li class="s-mod-item" w="266" h="127" l="0" t="0" bg="#e8443a" cbg="#d92e24">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>素材管理</span></div>
				<div class="s-mod-cur"><span>自主添加产品类别，不限级数。后台对产品实现增、查、删、改等功能。前端对产品进行列表展示、详细页面展示。详细页面包含产品小图、大图、详细参数、文字内容介绍、多图滚动展示、图片放大展示、关联资讯介绍展示。</span></div>
			</div>
		</li>
		<li class="s-mod-item" w="266" h="127" l="278" t="0" bg="#aa5096" cbg="#922a7b">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>节目制作</span></div>
				<div class="s-mod-cur"><span>管理会员注册信息、会员列表，建立会员等级权限组，分配会员至权限组，然后根据权限使用网站的其它各个功能模块。</span></div>
			</div>
		</li>
		<li class="s-mod-item" w="266" h="127" l="0" t="139" bg="#0C6DB2" cbg="#09578E">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>模板商城</span></div>
				<div class="s-mod-cur"><span>管理会员注册信息、会员列表，建立会员等级权限组，分配会员至权限组，然后根据权限使用网站的其它各个功能模块。</span></div>
			</div>
		</li>
		<li class="s-mod-item" w="266" h="127" l="278" t="139" bg="#FF0198" cbg="#D80683">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>消息制作</span></div>
				<div class="s-mod-cur"><span>在网站管理平台对产品型号、类别、价格；产品图片等数据进行批量上传，批量下载的管理。</span></div>
			</div>
		</li>
		<li class="s-mod-item" w="266" h="127" l="278" t="278" bg="#4837cd" cbg="#3c2bb7">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>终端监控</span></div>
				<div class="s-mod-cur"><span>包含在线订购单提交，可在线提交单个或连续多个订单，在线支付、物流管理、退换货管理。必须与会员系统配合。</span></div>
			</div>
		</li>
		<li class="s-mod-item" w="266" h="127" l="0" t="278" bg="#bf7030" cbg="#ae6021">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>快速入门</span></div>
				<div class="s-mod-cur"><span>不限层级添加新闻资讯类别，可自主管理公司简介、公司新闻、产品新闻、行业知识等。在后台进行增、删、查、改等一系列操作。</span></div>
			</div>
		</li>
		<!-- <li class="s-mod-item" w="266" h="127" l="834" t="278" bg="#4392ec" cbg="#206fc8">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>13.友情链接管理模块</span></div>
				<div class="s-mod-cur"><span>与客户网站交换文字链接、图片链接均可，通过链接提升网站的PR值，有利于SEO优化排名。</span></div>
			</div>
		</li> -->
	</ul>
</div>
   <div class="index_buttom" style="margin-top: 5%; border: 1px"; bg="#4392ec" h="405" l="600">
   		<img class="img_index" alt="" src="${ctxStatic}/images/login/testIndex.PNG">
   </div>
</body>
</html>