 <%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>节目预览</title>
	<meta name="decorator" content="default"/>	
<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/program/preview.css">
<link rel="stylesheet" type="text/css" href="${ctxStatic}/audioplayerengine/initaudioplayer-1.css">
 <script src="${ctxStatic}/flowplayer_flash/flowplayer-3.2.13.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/js/program/getTime.js"></script>	
<script src="${ctxStatic}/js/program/getTimeAdd.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/program/kxbdSuperMarquee.js"></script>
<script src="${ctxStatic}/js/program/jquery.marquee.min.js"></script>
</head>
<body>
 ${dom}
<!--  测试用的 -->
  <!-- <div class="marquee" style="position:absolute;z-index:999" txtanimtype="right">
				
						水电费色地方说<span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">水电费色地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">水电费色地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">水电费色地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">水电费色地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">水电费色地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">水电费色地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">水电费色地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">水电费色地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">水电费色地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">水电费色地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span><span style="line-height: 18.5714px;">地方说</span>
				</div>  -->
<!-- <marquee scrollAmount=2  direction=right style="position:absolute;z-index:999;left:200px;top:500px;">
jquery HTML5 幻灯片插件 用 Canvas 制作类似百叶窗拍摄快门摄影拍摄效果<br>
</marquee> -->

 <script src="${ctxStatic}/audioplayerengine/amazingaudioplayer.js"></script>    
 <script src="${ctxStatic}/audioplayerengine/initaudioplayer-1.js"></script>

 <script src="${ctxStatic}/js/program/preview.js"></script>


<!--  测试用的 -->
<!-- <script type="text/javascript">
$(function(){
	$('.marquee').each(function(){
		$(this).kxbdSuperMarquee({
			isMarquee:true,
			isEqual:false,
			scrollDelay:20,		
			direction:$(this).attr("txtanimtype")
		});
		
	})
});
</script> -->

<!--  测试用的 -->
 <script type="text/javascript">
$(function(){
	$('.marquee').each(function(){
		$(this).marquee();
		
	})
});
</script>
</body>
</html>
 