<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>截屏时间轴</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/terminal/fixedTimeAxis.css">
	<style type="text/css">
	</style>
	<script type="text/javascript">
		$(function(){
			$(".year").addClass("close");
			$(".year").first().removeClass("close");
		});
	</script>
</head>
<body>

<div class="content">
<div class="wrapper">
		<div class="main">
			<h1 class="title">截屏时间轴</h1>
			<c:forEach var="year" items="${times}">
				<div class="year">
					<h2><a href="#">${year.key }年<i></i></a></h2>
						<div class="list">
							<ul class="list_ul">
							<c:forEach var="monthDate" items="${year.value}">
									<li class="cls highlight">
										<p class="date">${monthDate.key.month+1}月${monthDate.key.date}日</p>
										<div class="more">
											<!-- <ul>
												<c:forEach var="img" items="${monthDate.value }">
													<li class="img">
														<dl>
															<dt>
																<img src="${ctxStatic}/images/terminal/1.jpg" alt="">
															</dt>
															<dd class="img_time">12:30</dd>
															<dd class="img_time">${img.name }</dd>
															<dd class="img_time">${img.createDate }</dd>
														</dl>
													</li>
												</c:forEach>
											</ul> -->
												<div id="four_flash">
													<div class="flashBg">
														<ul class="mobile">							
															 <c:forEach var="img" items="${monthDate.value }">
																<li>
																	<dl>
																		<dt>
																			<img src="${img.path}" alt="">
																		</dt>
																		<dd class="img_time">${img.createDate.hours }:${img.createDate.minutes }</dd>
																	</dl>
																</li>
															</c:forEach>
														</ul>
													</div>
													<div class="but_left but"><img src="${ctxStatic}/images/terminal/qianxleft.png" /></div>
													<div class="but_right but"><img src="${ctxStatic}/images/terminal/qianxr.png" /></div>
											    </div>
										
												<script type="text/javascript">
												var _index5=0;
												var pages = 0;
												$("#four_flash .but_right img").click(function(){
													console.log("but_right");
													console.log(_index5);
													_index5+=3;
													pages++;

													/*var len=$(".flashBg ul.mobile li").length;*/
													var len=$(this).parent().parent().find(".mobile li").length;
													if(_index5>len-6){
														_index5 = len-6;
														pages = _index5/3;
														/*$("#four_flash .flashBg ul.mobile").stop().append($("ul.mobile").html());*///停止当前动画
													}else{
													/*	$("#four_flash .flashBg ul.mobile").stop().animate({left:-pages*168*3},1000);*/
														$(this).parent().parent().find("ul.mobile").stop().animate({left:-pages*168*3},1000);

													}
												});

													
												$("#four_flash .but_left img").click(function(){

													console.log("but_left");
													console.log(_index5);
													console.log("pages");
													console.log(pages);
													_index5-=3;
													pages--;
													if(pages < 0){
														_index5 = 0;
														pages = 0;
														/*$("ul.mobile").prepend($("ul.mobile").html()); */
														/*$("ul.mobile").css("left","-1380px");
														_index5=6*/
													}else{
														/*$("#four_flash .flashBg ul.mobile").stop().animate({left:-pages*168*3},1000);*/
														$(this).parent().parent().find("ul.mobile").stop().animate({left:-pages*168*3},1000)
													}
													});
												</script>
										</div>
									</li>
								</c:forEach>
							</ul>
						</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>


<script type="text/javascript">
$(".main .year .list").each(function(e, target){
	console.log("111");
	var $target=  $(target),
	$ul = $target.find("ul.list_ul");
	$target.height($ul.outerHeight()), $ul.css("position", "absolute");
}); 
$(".main .year>h2>a").click(function(e){
	console.log("222");
	e.preventDefault();  //阻止默认动作
    $(this).parents(".year").toggleClass("close");
	// $(this).parent().toggleClass("close");
});
</script>
</body>
</html>
