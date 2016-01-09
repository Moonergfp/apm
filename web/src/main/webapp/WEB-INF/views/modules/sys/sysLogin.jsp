<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>${fns:getConfig('productName')}登录</title>
<meta name="decorator" content="default" />
<style type="text/css">
    /* 初始化CSS */
    html, body, ul, li, ol, dl, dd, dt, p, h1, h2, h3, h4, h5, h6, form, fieldset, legend, img { margin:0; padding:0; }
    fieldset, img { border:none; }
    img{display: block;}
    address, caption, cite, code, dfn, th, var { font-style:normal; font-weight:normal; }
    ul, ol { list-style:none; }
    input { padding-top:0; padding-bottom:0; font-family: "Microsoft YaHei", "Arial", "宋体";}
    input::-moz-focus-inner { border:none; padding:0; }
    select, input { vertical-align:middle; }
    select, input, textarea { font-size:12px; margin:0; }
    input[type="text"], input[type="password"], textarea { outline-style:none; -webkit-appearance:none; }
    textarea { resize:none; }
    table { border-collapse:collapse; }
    body { color:#333; padding:5px 0; font:12px/20px "Microsoft YaHei", "Arial Narrow", "宋体",HELVETICA; background:#fff;/* overflow-y:scroll;*/ }
    .clearfix:after { content:"."; display:block; height:0; visibility:hidden; clear:both; }
    .clearfix { zoom:1; }
    .clearit { clear:both; height:0; font-size:0; overflow:hidden; }
    a { color:#666; text-decoration:none; outline: none}
    a:visited { color:#666; }
    a:hover, a:active, a:focus { color:#ff8400; text-decoration:underline; }
    .hidden{visibility:hidden;}
</style>
<link type="text/css" rel="stylesheet" href="${ctxStatic}/css/login/style.css" />
<style type="text/css">
    /*page start*/
    .loaded_show{display:none;}
    .page_section{width:100%;}
    .wrap_index{position:relative;overflow:hidden;}
    #wrap_logo{width:140px;height:140px;position:absolute;top:0px;left:120px;z-index:99;overflow:hidden;zoom:1;}
    #wrap_download{position:absolute;top:245px;left:22%;z-index:99; display: none;}
    #wrap_title{width: 230px; height: 139px; position: absolute;top:0px; left: 260px;z-index: 99;}
    #wrap_download .wrap_download{position:relative;}
    .download_info{position:relative;width:670px;height:170px;}
    .download_info li{width:667px;height:170px;position:absolute;bottom:0px;left:0px;}
    #wrap_download .info_mj{background:url(/apm-web/static/images/login/news_app_bg_focus_mj.png) 0px 0px no-repeat;display:none;}
    #wrap_download .info_sk{background:url(/apm-web/static/images/login/news_app_bg_focus_sk.png) 0px 0px no-repeat;display: none;}
    #wrap_download .download_btn,#wrap_download .download_btn:visited{display:block;width:300px;height:72px;margin-top:55px;background:url(/apm-web/static/images/login/news_app_icon_common.png) 0px -440px no-repeat;}
    #wrap_download .download_btn:hover{background:url(/apm-web/static/images/login/news_app_icon_common.png) 0px -520px no-repeat;}
    #wrap_download .download_btn:active{background:url(/apm-web/static/images/login/news_app_icon_common.png) 0px -600px no-repeat;}
    #slides{min-height:480px;}
    .wrap_action{position:relative;}
    .wrap_action img{width:100%;}
    .wrap_action .btn,.wrap_action .btn:visited{display:block;position:absolute;right:20%;top:65%;width:297px;height:99px;text-decoration:none;background:url(/apm-web/static/images/login/news_app_icon_common.png) 0px -690px no-repeat;opacity:1;filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=100);z-index:70;_filter:none;}
    .wrap_action .btn:hover{opacity:0.7;filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=70);_filter:none;}
    .wrap_action .btn:active{opacity:0.9;filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=90);_filter:none;}
    .wrap_person{position:relative;overflow:hidden;}
    .wrap_person img{height:100%;}
    #slide_person_start{position:absolute;top:0px;left:0px;overflow:hidden;z-index:99;background:url(/apm-web/static/images/login/news_app_img_taidu_index.jpg) center center no-repeat;_display:none;}
    #slide_person_start img{height:auto;width:100%;}
    .slide_imgs_sep{
        border-left: solid 1px #eeeeee;
    }
    .wrap_mobile{background:#f9f9f9;text-align:center;padding-top:35px;position:relative;width:100%;height:495px;overflow:hidden;}
    .wrap_mobile h2{text-indent:-999999px;width:458px;height:51px;margin:0px auto;margin-bottom:40px;background:url(/apm-web/static/images/login/news_app_bg_h2_mobile.png) 0px 0px no-repeat;}
    .wrap_mobile ul{position:absolute;width:100%;bottom:0px;width:900px;left:50%;margin:0px 0px 0px -450px;border-bottom:solid 1px #e5e5e5;padding-bottom:20px;}
    .wrap_mobile p{font-size:16px;line-height:24px;/*padding:10px 0px;*/color:#4c4c4c;text-align:center;visibility:hidden;position:absolute;bottom:0;opacity:0; left:50%;margin-left:-86px;width:100%;}
    .wrap_mobile .active p{visibility:visible; bottom: 0px;opacity: 1}
    /*
    .wrap_mobile li{display:inline-block;*display:inline;*zoom:1;padding:0px 15px;overflow:hidden;padding-bottom:40px;}*/
    .wrap_mobile li{position:relative;display:inline-block;*display:inline;*zoom:1;padding:0px;overflow:hidden;/*padding-bottom:40px;*/width:172px;min-height:388px;_height:388px;text-align:center;}
    .wrap_mobile a{display:inline-block;/*position: relative; */*display:inline;*zoom:1;}
    .wrap_mobile li img{position:absolute;width:128px;height:244px;left:50%;top:50%;margin-left:-64px;margin-top:-132px;}
    .wrap_mobile .active img{width:172px;height:338px;margin-left:-86px;margin-top:-179px;}
    .wrap_follow{text-align:center;background:#f9f9f9;padding:25px 0;}
    .wrap_follow p{font-size:14px;color:#333333;line-height:23px;}
    .wrap_follow h2{text-indent:-999999px;width:154px;height:58px;margin:0px auto;background:url(/apm-web/static/images/login/news_app_bg_h2_follow.png) 0px 0px no-repeat;}
    .focusNetease{display:inline-block;*display:inline;*zoom:1;width:90px;height:90px;background:url("/apm-web/static/images/login/news_app_icon_common.png") no-repeat 0px -200px;}
    .focusNetease:hover{background:url("/apm-web/static/images/login/news_app_icon_common.png") no-repeat -100px -200px;}
    .focusNetease:active{background:url("/apm-web/static/images/login/news_app_icon_common.png") no-repeat -200px -200px;}
    .focusSina{display:inline-block;*display:inline;*zoom:1;width:90px;height:90px;background:url("/apm-web/static/images/login/news_app_icon_common.png") no-repeat 0px -100px;}
    .focusSina:visited{background:url("/apm-web/static/images/login/news_app_icon_common.png") no-repeat 0px -100px;}
    .focusSina:hover{background:url("/apm-web/static/images/login/news_app_icon_common.png") no-repeat -100px -100px;}
    .focusSina:active{background:url("/apm-web/static/images/login/news_app_icon_common.png") no-repeat -200px -100px;}
    .focusTencent{display:inline-block;*display:inline;*zoom:1;width:90px;height:90px;background:url("/apm-web/static/images/login/news_app_icon_common.png") no-repeat 0px 0px;}
    .focusTencent:visited{background:url("/apm-web/static/images/login/news_app_icon_common.png") no-repeat 0px 0px;}
    .focusTencent:hover{background:url("/apm-web/static/images/login/news_app_icon_common.png") no-repeat -100px 0px;}
    .focusTencent:active{background:url("/apm-web/static/images/login/news_app_icon_common.png") no-repeat -200px 0px;}
    .focus_area{padding:20px 0;}
    .focus_area a{margin:0 27px;outline:none;}
    .footer{padding:10px 0px;background-color:#444;}
    .footer a{font-size:12px;color:#d0d0d0;}
    .cooperation{width:780px;margin:0px auto;}
    .cooperation ul{display:block;margin-bottom:5px;}
    .cooperation ul li{float:left;margin-right:50px;width:130px;}
    .cooperation ul .last{margin:0px;width:60px;}
    .cooperation ul li a:hover{text-decoration:underline;}
    .footer_info{font-size:12px;line-height:21px;color:#616161;text-align:center;}
    .footer_conTop{margin-top:10px;}
    /* nav-bottom */
    .N-nav-bottom { color:#616161;}
    .N-nav-bottom-copyright { color: #ddd; padding-right: 2px; }
    .N-nav-bottom-copyright-icon { font-family: Arial; }
    .N-nav-bottom-main { margin: 0 auto; width: 960px; height: 39px; line-height:39px; }
    .N-nav-bottom-main a, .N-nav-bottom-main a:visited,.N-nav-bottom-main a:hover  { padding:0 4px; color: #dddddd; }
    .N-nav-bottom-main a:hover { text-decoration: underline; }
    /* nav-channel */
    .N-nav-channel { padding: 14px 0 14px; line-height: 13px; text-align: center; width: 960px; margin: 0 auto; }
    .N-nav-channel a { padding: 0 7px 0 7px; border-left: 1px solid #dddddd; }
    .N-nav-channel a:link, .N-nav-channel a:visited { color: #252525; }
    .N-nav-channel a:hover, .N-nav-channel a:active { color: #cc1b1b; }
    .N-nav-channel a.first { border-left: 0; padding-left: 0; padding-right: 6px; }
    .N-nav-channel a.last { padding-right: 0; padding-left: 6px; }
    .arr_wrap{position:fixed;height:27px;padding-right:4px;display:none;z-index:99;}
    .arr_wrap .arr{height:27px;width:4px;position:absolute;right:0px;top:0px;background:url(/apm-web/static/images/login/news_app_icon_common.png) -30px -300px no-repeat;}
    .arr_wrap .cnt{font-size:14px;line-height:27px;padding:0 12px;background:url(/apm-web/static/images/login/news_app_bg_arr_bg.png) top left repeat-x;color:#e2e2e2;}
    .dialog_wrap{position:absolute;width:100%;height:100%;left:0px;top:0px;z-index:99;display:none;}
    .dialog_mask{position:absolute;z-index:100;width:100%;height:100%;left:0px;top:0px;background:#000000;opacity:0.7;filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=70);}
    .dialog_close,.dialog_close:visited{position:absolute;display:block;width:40px;height:40px;top:0px;right:-40px;z-index:102;cursor:pointer;background:url(/apm-web/static/images/login/news_app_icon_common.png) -189px -309px no-repeat;}
    .dialog_close:hover,.dialog_close:active{background-position:-189px -369px;}
    .dialog_cnt{position:fixed;_position:absolute;left:50%;top:50%;width:938px;height:484px;margin:-242px 0px 0px -469px;z-index:101;}
    /*page end*/
    .slides-navigation{
        display: none;
    }
    .loading-container{
        position: fixed;
        _position:absolute;
    }
    /*bottom button */
    #btn_bottom{position:fixed;display:none;width:300px;height:72px;bottom:0px;left:120px;z-index:999;overflow:hidden;}
    #btn_bottom .btn_icon{display:block;position:absolute;top:0px;left:0px;width:72px;height:72px;background:url(/apm-web/static/images/login/news_app_icon_download_bottom.png) 0px 0px no-repeat;z-index:1001;cursor:pointer;}
    #btn_bottom .btn_link,#btn_bottom .btn_link:visited,#btn_bottom .btn_link:hover,#btn_bottom .btn_link:active{display:block;position:absolute;left:-300px;top:0px;width:300px;height:72px;z-index:1000;background:url(/apm-web/static/images/login/news_app_icon_common.png) 0px -440px no-repeat;}
    .top-menu{
        position: absolute;
        top:25px;
        right: 240px;
        font-size: 16px;
        vertical-align: middle;
        z-index: 9999;
    }
    .top-menu a{
        text-decoration: none;
    }
    .top-menu li{
        display: inline-block;
        height: 46px;
        color: #ffffff;
    }
    
    /* 登陆表单样式 */
    .form_wrapper{
          background: #50a3a2;
          background: -webkit-linear-gradient(top left, #50a3a2 0%, #53e3a6 100%);
          background: linear-gradient(to bottom right, #50a3a2 0%, #020102 100%);
          opacity: 0.9;
          position: absolute;
          top: 50%;
          left: 15%;
          width: 400px;
          height: 300px;
          margin-top: -200px;
          overflow: hidden;
          z-index:99;
    }
    .from_container{
        max-width: 500px;
        margin: 0 auto;
        padding: 30px 0;
        text-align: center;
    }
    .from_container h1{
        font-size: 40px;
        -webkit-transition-duration: 1s;
        transition-duration: 1s;
        -webkit-transition-timing-function: ease-in-put;
        transition-timing-function: ease-in-put;
        font-weight: 200;
    }
    .login_form{
        padding: 20px 0;
        position: relative;
        z-index: 100;
    }
    .login_form input:hover {
      background-color: rgba(255, 255, 255, 0.4);
    }
    .login_form input:focus {
      background-color: white;
      width: 300px;
      color: #53e3a6;
    }
    .login_form button:hover {
      background-color: #f5f7f9;
    }
    .from_bg_bubbles{
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: 99;
    }
    .from_bg_bubbles li{
        position: absolute;
        list-style: none;
        display: block;
        width: 40px;
        height: 40px;
        background-color: rgba(255, 255, 255, 0.15);
        bottom: -160px;
        -webkit-animation: square 25s infinite;
        animation: square 25s infinite;
        -webkit-transition-timing-function: linear;
        transition-timing-function: linear;
    }
    .bg-bubbles li:nth-child(1) {
          left: 10%;
        }
        .bg-bubbles li:nth-child(2) {
          left: 20%;
          width: 80px;
          height: 80px;
          -webkit-animation-delay: 2s;
                  animation-delay: 2s;
          -webkit-animation-duration: 17s;
                  animation-duration: 17s;
        }
        .bg-bubbles li:nth-child(3) {
          left: 25%;
          -webkit-animation-delay: 4s;
                  animation-delay: 4s;
        }
        .bg-bubbles li:nth-child(4) {
          left: 40%;
          width: 60px;
          height: 60px;
          -webkit-animation-duration: 22s;
                  animation-duration: 22s;
          background-color: rgba(255, 255, 255, 0.25);
        }
        .bg-bubbles li:nth-child(5) {
          left: 70%;
        }
        .bg-bubbles li:nth-child(6) {
          left: 80%;
          width: 120px;
          height: 120px;
          -webkit-animation-delay: 3s;
                  animation-delay: 3s;
          background-color: rgba(255, 255, 255, 0.2);
        }
        .bg-bubbles li:nth-child(7) {
          left: 32%;
          width: 160px;
          height: 160px;
          -webkit-animation-delay: 7s;
                  animation-delay: 7s;
        }
        .bg-bubbles li:nth-child(8) {
          left: 55%;
          width: 20px;
          height: 20px;
          -webkit-animation-delay: 15s;
                  animation-delay: 15s;
          -webkit-animation-duration: 40s;
                  animation-duration: 40s;
        }
        .bg-bubbles li:nth-child(9) {
          left: 25%;
          width: 10px;
          height: 10px;
          -webkit-animation-delay: 2s;
                  animation-delay: 2s;
          -webkit-animation-duration: 40s;
                  animation-duration: 40s;
          background-color: rgba(255, 255, 255, 0.3);
        }
        .bg-bubbles li:nth-child(10) {
          left: 90%;
          width: 160px;
          height: 160px;
          -webkit-animation-delay: 11s;
                  animation-delay: 11s;
        }
        @-webkit-keyframes square {
          0% {
            -webkit-transform: translateY(0);
                    transform: translateY(0);
          }
          100% {
            -webkit-transform: translateY(-700px) rotate(600deg);
                    transform: translateY(-700px) rotate(600deg);
          }
        }
        @keyframes square {
          0% {
            -webkit-transform: translateY(0);
                    transform: translateY(0);
          }
          100% {
            -webkit-transform: translateY(-700px) rotate(600deg);
                    transform: translateY(-700px) rotate(600deg);
          }
        }
    .login_form input{
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
        outline: 0;
        border: 1px solid rgba(255, 255, 255, 0.4);
        background-color: rgba(255, 255, 255, 0.2);
        width: 250px;
        border-radius: 3px;
        padding: 10px 15px;
        margin: 0 auto 10px auto;
        display: block;
        text-align: center;
        font-size: 18px;
        color: white;
        -webkit-transition-duration: 0.25s;
        transition-duration: 0.25s;
        font-weight: 300;
    }
    .login_form button{
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
        outline: 0;
        background-color: white;
        border: 0;
        padding: 10px 15px;
        color: #488A89;
        border-radius: 3px;
        width: 250px;
        cursor: pointer;
        font-size: 18px;
        -webkit-transition-duration: 0.25s;
        transition-duration: 0.25s;
    }
    .form_login_button{
        background-color: #2d8eed;
        border-radius: 3px;
        -moz-border-radius: 3px;
        -webkit-border-radius: 0px;
        cursor: pointer;
        border: 0;
        color: #fff;
        font-size: 14px;
        z-index: 99;
        margin-top: 2%;
        left: 90%;
        position: fixed;
        width:80px;
        height: 40px;
        line-height: 40px;
        text-align:center;
        font-family: Helvetica Neue,Tahoma,Arial,'Hiragino Sans GB',"Microsoft Yahei","å®‹ä½“","é»‘ä½“";
    }
     .form_login_button:visited{
       text-decoration: none;
     }
     .form_login_button:hover{
       text-decoration: none;
     }
     .form_login_button:link{
       text-decoration: none;
     }
</style>
<script type="text/javascript" src="${ctxStatic}/js/login/jquery.external-v0.1.2.js"></script>
<script type="text/javascript">
	function toLogin(){
		var u = $("#userName").val();
		var p = $("#password").val();
		console.log("u ---- "+u + "--- p"+ p);
		if(u.trim().length < 1 || p.trim().length < 1){
			alert("请填写用户名和密码");
			return ;
		}
		  $.ajax({
			url:"${ctx}/login",
       		type:'post',
       		dataType:'text',
       		data:{"username":u, "password": p, "loginFlag": "login"},
       		success: function(data){
       			console.log(data);
       			if(data == "true"){
       				//已存在用户,直接访问登录页即可
       				window.location = "${ctx}/login";
       			}else{
       				$("#userName").val("");
       				$("#password").val("");
       				alert("登录失败!");
       			}
       		},error: function(data){
       			alert("服务器出错!");
       		}
		})  
	}
</script>
</head>
<body>  
<div class="loading-container">
    <div class="pulse"></div>
</div>
<div id="btn_bottom">
    <span class="btn_icon"></span>
    <a href="#" class="btn_link"></a>
</div>
<div class="wrap" id="wrap">
    <div class="page_section wrap_index" data-info="用户登录" id="section_app">
        <%-- <a id="wrap_logo" class="loaded_show" href="#" title="朗国" target="_self"><img src="${ctxStatic}/images/login/news_app_download_logo.png" /></a> --%>
       <!--  <ul class="top-menu">
            <li style=""><a  style="color: #ffffff;">首&nbsp;页</a><div style="border-top: 1px solid #ffffff;width: 38px;opacity: 0.7;margin-top:2px;"></div></li>
            <li id="listPage" style="opacity: 0.7;"><a href="#" style="color: #ffffff;margin-left: 52px;">活动新闻</a></li>
            <li id="logPage" style="opacity: 0.7;"><a href="#" style="color: #ffffff;margin-left: 52px;">更新日志</a></li>
        </ul> -->
        <div class="form_wrapper">
          <div class="from_container">
          	<h1>Welcome</h1>
          	<form class="login_form">
          		<input type="text" placeholder="用户名" name="userName" id="userName">
          		<input type="password" placeholder="密码" name="password" id="password">
          		<button type="button" onclick="toLogin();">登录</button>
          	</form>
          </div>
          <ul class="from_bg_bubbles">
            <li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li>
          </ul>
        </div>
        	<a href="#1" class="form_login_button" onclick="">登&nbsp;&nbsp;录</a>
        <!-- <div id="wrap_download" class="loaded_show">
            <ul class="download_info">
                <li class="info_sk" style="display: block"></li>
                <li class="info_mj"></li>
            </ul>
            <a href="#" class="download_btn transition_bg_img" target="_self"></a>
        </div> -->
        <div id="slides">
            <ul class="slides-container">
                <li>
                    <img src="${ctxStatic}/images/login/news_app_img_sk.jpg" alt="我们喜欢戴套，贴膜，都是小时候包书皮养成的。--讥诮军事" title="" />
                </li>
                <li>
                    <img src="${ctxStatic}/images/login/news_app_img_ds.jpg" alt="要不是为了让我深更半夜起来找吃的，冰箱里干嘛装个等。--妙笔大圣" title="" />
                </li>
                <li>
                    <img src="${ctxStatic}/images/login/news_app_img_cr.jpg" alt="在北京买房，就像鼻涕虫想变蜗牛那么难。--吐槽超人" title="" />
                </li>
                <li>
                    <a  id="btn_video_play" target="_blank">
                        <img src="${ctxStatic}/images/login/news_app_img_sp.jpg" alt="网易跟帖十年视频" title="" />
                    </a>
                </li>
            </ul>
            <nav class="slides-navigation">
                <a  class="next"></a>
                <a  class="prev"></a>
            </nav>
        </div>
    </div>
    <div class="page_section wrap_action" data-info="活动" id="section_action">
        <ul class="slides-container">
           <li><img src="${ctxStatic}/images/login/5version.jpg" alt="5.0版本预告" title="5.0版本预告" /></li>
           <li><img src="${ctxStatic}/images/login/fouryears.jpg" alt="网易新闻客户端四周年" title="网易新闻客户端四周年" /></li>
           <li><img src="${ctxStatic}/images/login/toutiao.jpg" alt="我要上头条" title="我要上头条" /></li>
           <li><img src="${ctxStatic}/images/login/pcdiy0807.jpg" alt="DIY态度封面" title="DIY态度封面" /></li>
         </ul>
        <nav class="slides-navigation">
            <a  class="next"></a>
            <a  class="prev"></a>
        </nav>
    </div>
    <div  class="page_section wrap_cj" data-info="感谢有你，亲爱的用户" id="section_cj">
        <ul class="slides-container">
            <%-- <li>
              <img src="${ctxStatic}/images/login/news_app_img_cj_01.jpg" alt="" title="" />
            </li>  --%>
            <li>
                <img src="${ctxStatic}/images/login/news_app_img_cj_02.jpg" alt="" title="" />
            </li>
            <li>
                <img src="${ctxStatic}/images/login/news_app_img_cj_03.jpg" alt="" title="" />
            </li>
            <li>
                <img src="${ctxStatic}/images/login/news_app_img_cj_04.jpg" alt="" title="" />
            </li>
            <li>
                <img src="${ctxStatic}/images/login/news_app_img_cj_05.jpg" alt="" title="" />
            </li>
            <li>
                <img src="${ctxStatic}/images/login/news_app_img_cj_06.jpg" alt="" title="" />
            </li>
        </ul>
        <nav class="slides-navigation">
            <a  class="next"></a>
            <a  class="prev"></a>
        </nav>
    </div>
    <div class="page_section wrap_person loaded_show" data-info="遇见有态度的人" id="section_attitude">
        <div id="slide_person_start"></div>
        <div id="slide_person_cnt">
            <ul class="slide_imgs">
                <li><img data-title="陈坤，行走只会开始，不会结束。" src="${ctxStatic}/images/login/news_app_img_taidu_chk.jpg" /></li>
                <li class="slide_imgs_sep"><img data-title="范冰冰，人生最大的惊喜是遇见自己。" src="${ctxStatic}/images/login/news_app_img_taidu_fbb.jpg" /></li>
                <li class="slide_imgs_sep"><img data-title="刘烨，有一种力量，为消灭邪恶而存在。" src="${ctxStatic}/images/login/news_app_img_taidu_ly.jpg" /></li>
            </ul>
        </div>
    </div>
    <div class="page_section wrap_mobile loaded_show"  data-info="朗国广告机" id="section_mobile">
        <h2>朗国广告机展览</h2>
        <ul>
            <li>
                <a href="#" target="_blank">
                    <img class="transition_all" src="${ctxStatic}/images/login/news_app_img_phone_lnk900.jpg" />
                </a>
                <p class="transition_all">联想 K900</p>
            </li>
            <li>
                <a href="#" target="_blank">
                    <img class="transition_all" src="${ctxStatic}/images/login/news_app_img_phone_hwmate.jpg" />
                </a>
                <p class="transition_all">华为 Mate</p>
            </li>
            <li class="active" id="mobile_active_default">
                <a href="#" target="_blank">
                    <img class="transition_all" src="${ctxStatic}/images/login/news_app_img_phone_oppon1.jpg" />
                </a>
                <p class="transition_all">OPPO N1</p>
            </li>
            <li>
                <a href="#" target="_blank">
                    <img class="transition_all" src="${ctxStatic}/images/login/news_app_img_phone_vivo.jpg" />
                </a>
                <p class="transition_all">步步高 vivo X3</p>
            </li>
            <li>
                <a href="#" target="_blank">
                    <img class="transition_all" src="${ctxStatic}/images/login/news_app_img_phone_yj.jpg" />
                </a>
                <p class="transition_all">一加手机</p>
            </li>
        </ul>
    </div>
    <div class="page_section wrap_follow loaded_show" data-info="公众号关注" id="section_share">
        <h2>关注我们 follow us</h2>
        <div class="focus_area">
            <a target="_blank" href="http://t.163.com/newsapp" class="focusNetease" title="微信公众号关注我们" alt="微信公众号关注我们"></a>
            <a target="_blank" href="http://e.weibo.com/newsapp" class="focusSina" title="在新浪微博关注我们" alt="在新浪微博关注我们"></a>
            <a target="_blank" href="http://t.qq.com/newsapp" class="focusTencent" title="在腾讯微博关注我们" alt="在腾讯微博关注我们"></a>
        </div>
        <style type="text/css">
            .contact_area{
                width: 830px;
                margin: 0px auto 35px;
                text-align: left;
            }
            .contact_area p{
                float: left;
                width: 415px
            }
            .contact_area .right{
                width: 366px;
               /*  padding-left: 60px; */
            }
        </style>
        <div class="contact_area clearfix">
            <p>朗国广告机客户端apm：<span>&nbsp;apm登陆</span></p>
            <p class="weiMessage right">朗国广告机客户端微信：<span>&nbsp;neteasenewsapp或1400488533</span></p>
            <p>朗国广告机客户端用户交流QQ群：<span>&nbsp;190991883</span></p>
            <p class="right">朗国广告机客户端媒体开放平台QQ群：<span>&nbsp;137953917</span></p>
            <p>朗国广告机客户端邮箱：<span>&nbsp;newsclub@vip.163.com</span></p>
        </div>
    </div>
    <div class="footer loaded_show">
        <div class="footer_con">
            <div class="footer_conTop" style="display: none;">
                <div class="cooperation">
                    <ul class="clearfix">
                        <li><a target="_blank" href="#" title="网易应用">网易应用</a></li>
                        <li><a target="_blank" href="#" title="网易电视指南">网易电视指南</a></li>
                        <li><a target="_blank" href="#" title="中国移动">中国移动</a></li>
                        <li><a target="_blank" href="#" title="中国联通?沃商店">中国联通</a></li>
                        <li class="last"><a target="_blank" href="#" title="中国电信?天翼空间">中国电信</a></li>
                    </ul>
                    <ul class="clearfix">
                        <li><a target="_blank" href="#" title="宇龙酷派">宇龙酷派</a></li>
                        <li><a target="_blank" href="#" title="魅族软件中心">魅族软件中心</a></li>
                        <li><a target="_blank" href="#" title="App Store">App Store</a></li>
                        <li><a target="_blank" href="#" title="联想乐商店">联想乐商店</a></li>
                        <li class="last"><a target="_blank" href="#" title="华为智汇云">华为智汇云</a></li>
                    </ul>
                </div>
            </div>
            <!-- footer.html start -->
            <div class="N-nav-bottom">
				<div class="N-nav-bottom-main">
					<div class="ntes_foot_link">
						<span class="N-nav-bottom-copyright"><span class="N-nav-bottom-copyright-icon">&copy;</span> 1997-2015 朗国公司版权所有</span> 
						<a href="#">About NetEase</a> | 
						<a href="#">公司简介</a> | 
						<a href="#">联系方法</a> | 
						<a href="#">招聘信息</a> | 
						<a href="#">客户服务</a> | 
						<a href="#">隐私政策</a> | 
						<a href="#">广告服务</a> | 
						<a href="#">网站地图</a> | 
						<a href="#" class="ne_foot_feedback_link">意见反馈</a> | 
						<a href="#">不良信息举报</a>
					</div>
				</div>
				<style>
				.N-nav-bottom-sub{width: 960px; margin:0 auto; position: relative; height: 0px; z-index: 1000; }
				.ne_foot_feedback_box{width: 360px; height: 270px; position: absolute; z-index: 9999; bottom: 34px; right: 0; display: none; }
				.ne_foot_feedback_box .feedback_close{width: 11px; height: 11px; background: url(style/images/img/box_close.png) no-repeat; position: absolute; right: 8px; top: 7px; font-size: 0; overflow: hidden; text-indent: -9990em; }
				.ne_foot_feedback_box .feedback_cor{width: 19px; height: 13px; background: url(style/images/img/box_cor.png) no-repeat; position: absolute; left: 236px; top: 250px; }
				.ne_foot_feedback_box .feedback_box{border:1px solid #cdcdcd; background: #fff; width: 358px; height: 250px; overflow: hidden; }
				.ne_foot_feedback_box .feedback_box iframe{display: block; border: 0; width: 100%; height: 250px; overflow: hidden; }
				</style>
				<div class="N-nav-bottom-sub" id="N-nav-bottom-sub"></div>
				<script>
	(function(){
		if(!window.NTES) return;
		function showFeedbackBox(x,y){
			var footmainNd = NTES('.N-nav-bottom-main')[0];
			var feedbacklinkNd = NTES('.ne_foot_feedback_link')[0];
			if(!footmainNd){
				window.open(feedbacklinkNd.href);
				return;
			};
			var x = x;
			var y = y;
			if(x){
				NTES(".ne_foot_feedback_box")[0].style.top = x +"px";
			}else{
				x = feedbacklinkNd.offsetLeft - footmainNd.offsetLeft + (feedbacklinkNd.offsetWidth/2) - 246;
				if(NTES.browser.msie && (parseInt(NTES.browser.version) == 7 ||parseInt(NTES.browser.version) == 6)){
					x = feedbacklinkNd.offsetLeft + (feedbacklinkNd.offsetWidth/2) - 246;
				}
				NTES(".ne_foot_feedback_box")[0].style.left = x +"px";
			}
			if(y){
				NTES(".ne_foot_feedback_box")[0].style.top = y +"px";
			}
			NTES(".ne_foot_feedback_box")[0].style.display = "block";
		}
		function bindFeedbackBoxClose(){
			NTES(".ne_foot_feedback_box .feedback_close").addEvent("click",function(){
				NTES(".ne_foot_feedback_box")[0].style.display = "none";
				return false;
			});
		}
		NTES(".ne_foot_feedback_link").addEvent("click",function(){
			if(NTES("#ne_foot_feedback_box")){
				showFeedbackBox();
			}else{
				var boxNd = document.createElement("div");
				boxNd.className = "ne_foot_feedback_box";
				boxNd.id = "ne_foot_feedback_box";
				boxNd.innerHTML = '<a href="javascript:;" target="_self" class="feedback_close">关闭</a> <span class="feedback_cor"></span> <div class="feedback_box"> <iframe src="http://www.163.com/special/0077450P/feedback_window.html" frameborder="0" witdh="100%" height="290" scrolling="no"></iframe> </div>';
				document.getElementById('N-nav-bottom-sub').appendChild(boxNd);
				window.setTimeout(function(){
					showFeedbackBox();
					bindFeedbackBoxClose();
				},500);
			}
			return false;
		});
	})();
	</script>
           </div>
        </div>
        <!-- footer.html end -->
    </div>
</div>
 
<script type="text/javascript">
    jQuery.support.transition = (function(){
        var thisBody = document.body || document.documentElement,
                thisStyle = thisBody.style,
                support = thisStyle.transition !== undefined || thisStyle.WebkitTransition !== undefined || thisStyle.MozTransition !== undefined || thisStyle.MsTransition !== undefined || thisStyle.OTransition !== undefined;
        return support;
    })();
</script>
<script type="text/javascript">
var isIE6 = window.ActiveXObject && !window.XMLHttpRequest;
var taiduSlideHasShow = false;
var taiduSlideShowTimer = null;
var taiduSlideShowDelay = 1000;
var startShowTaiduSlide = function(){
    if(taiduSlideHasShow){
        return;
    }
    if(taiduSlideShowTimer){
        clearTimeout(taiduSlideShowTimer);
    }
    taiduSlideShowTimer = setTimeout(function(){
        jQuery("#slide_person_start").fadeOut(1500);
        taiduSlideHasShow = true;
    }, taiduSlideShowDelay);
};
var init_page_flash = function(){
    jQuery(function(){
        var arr_elm = null;
        var arr_cnt = null;
        var arr_wrap = null;
        var arr_timer = null;
        var arr_duration = 3000;
        var main_wrap = jQuery("#wrap");
        var win = jQuery(window);
        var bd = jQuery("body");
        var elm_bottom = jQuery("#btn_bottom");
        var btn_icon = jQuery(".btn_icon", btn_bottom);
        var btn_link = jQuery(".btn_link", btn_bottom);
        var bottom_btn_show = false;
        var hashLock = false;
        var scrollLock = false;
        var scrollTimer = null;
        var scrollDuration = 500;
        var scrollDelta = 100;
        var func_get_scroll_top_for_page = function(){
            return Math.max(bd.scrollTop(), win.scrollTop());
        };
        var lastScrollTop = func_get_scroll_top_for_page();
        var min_nav_y = 50;
        var max_nav_y = 150;
        var func_show_slide_tip = function(index){
            if(arr_timer){
                clearTimeout(arr_timer);
                arr_timer = null;
            }
            try{
                /*
                 if(index < 2){
                 arr_wrap.css("bottom", min_nav_y);
                 }else{
                 arr_wrap.css("bottom",max_nav_y);
                 }*/
                var current = jQuery("li", arr_wrap).eq(index);
                var wrapPos = arr_wrap.position();
                var currentPos = current.position();
                var msg = jQuery(".page_section").eq(index).attr("data-info") || "";
                arr_elm.hide();
                arr_elm.css({right: win.width() - wrapPos.left + 3, top: currentPos.top + wrapPos.top + 6});
                arr_cnt.html(msg);
                arr_elm.fadeIn();
                arr_timer = setTimeout(function(){
                    arr_elm.fadeOut();
                }, arr_duration);
            }catch(e){
                throw e;
            }
        };
        main_wrap.onepage_scroll({
            sectionContainer: ".page_section",
            responsiveFallback: false,
            animationTime: 800
        });
        main_wrap.bind("slideStart", function(e, index){
            scrollLock = true;
            hashLock = true;
            if(index == 0 || index > 3){
                if(bottom_btn_show){
                    elm_bottom.fadeOut();
                    bottom_btn_show = false;
                }
            }
            func_show_slide_tip(index);
        })
                .bind("slideEnd", function(e, index){
                    setTimeout(function(){
                        scrollLock = false;
                        hashLock = false;
                    }, scrollDuration);
                    lastScrollTop = func_get_scroll_top_for_page();
                    if(index == 3){
                        startShowTaiduSlide();
                    }
                    if(index != 0 && index <= 3){
                        if(!bottom_btn_show){
                            elm_bottom.fadeIn();
                            bottom_btn_show = true;
                        }
                    }
                    var id = jQuery(".page_section").eq(index).attr("id") || "";
                    id && (window.location.hash = "#" + id);
                });
        jQuery(".onepage-pagination a").bind("mouseover", function(){
            var index = jQuery(this).attr("data-index");
            index && func_show_slide_tip(parseInt(index) - 1);
        });
        win.bind("hashchange", function(){
            if(hashLock){
                return;
            }
            var currentElm = jQuery(location.hash);
            var index = currentElm.attr("data-index") || 1;
            try{
                main_wrap.moveTo(index);
            }catch(e){
                //
            }
        });
        arr_elm = jQuery(".arr_wrap");
        arr_cnt = jQuery(".arr_wrap .cnt");
        arr_wrap = jQuery(".onepage-pagination");
        btn_icon.bind("mouseover", function(){
            btn_icon.fadeOut();
            btn_link.animate({left: 0});
        });
        btn_link.bind("mouseout", function(){
            btn_icon.fadeIn();
            btn_link.animate({left: -300});
        });
        win.bind("scroll", function(){
            if(scrollLock){
                return;
            }
            if(scrollTimer){
                clearTimeout(scrollTimer);
                scrollTimer = null;
            }
            scrollTimer = setTimeout(function(){
                if(scrollLock){
                    scrollTimer = null;
                    return;
                }
                var pages_elm = jQuery(".page_section");
                var direction = 0; //0 down 1 up
                var i = 0;
                var len = pages_elm.length;
                var tmp;
                var lastTmp;
                var scrollTop = func_get_scroll_top_for_page();
                var top = 0;
                var height = 0;
                if(scrollTop > lastScrollTop){
                    direction = 0;
                }else if(scrollTop < lastScrollTop/* && (lastScrollTop - scrollTop) > scrollDelta*/){
                    direction = 1;
                }
                for(; i < len; i++){
                    tmp = pages_elm.eq(i);
                    top = tmp.offset().top;
                    height = tmp.height();
                    if(direction == 0){
                        if( top + height - scrollDelta  > scrollTop + win.height()){
                            lastTmp = tmp;
                            break;
                        }
                    }else if(direction == 1){
                        if(top  + height - scrollDelta > scrollTop){
                            lastTmp = tmp;
                            break;
                        }
                    }
                }
                lastScrollTop = func_get_scroll_top_for_page();
                lastTmp && main_wrap.moveTo(parseInt(lastTmp.attr("data-index")));
                scrollTimer = null;
            }, scrollDuration);
        });
        function getUrlParam(name){
            var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|jQuery)");
            var r = window.location.search.substr(1).match(reg);
            if (r!=null) return unescape(r[2]); return null;
        }
        var page = getUrlParam("page");
        if(page){
            scrollLock = true;
            window.location.hash = "#" + page;
            scrollLock = false;
        }
        win.trigger("hashchange");
    });
};
var init_slide_imgs = function(){
    jQuery(function() {
        var win = jQuery(window);
        var slide_imgs_elm = jQuery("#slide_person_cnt .slide_imgs");
        var orig_height = 956;
        var orig_width = 1242;
        var orig_menu_width = 200;
        var min_menu_width = 50;
        var orig_full_ratio = 250/1902;
        var orig_main_ratio = orig_width/orig_height;
        var init_acod = function(){
            var width = win.width();
            var height = Math.min(win.height(), orig_height);
            var current_width = height * orig_main_ratio;
            var menu_width = (width - current_width)/2;
            menu_width = menu_width < min_menu_width ?  orig_menu_width : menu_width;
            slide_imgs_elm.zAccordion({
                width: width,
                height: height,
                tabWidth: menu_width,
                invert : false,
                auto: false,
                speed: 800,
                easing: "easeInOutCubic"
            });
            jQuery("#slide_person_start").css({width: width, height: height});
        };
        init_acod();
        win.bind("resize", function(){
            slide_imgs_elm.zAccordion("destroy");
            init_acod();
        });
    });
};
</script>
<script type="text/javascript">
jQuery("#slides").on('init.slides', function() {
    var imgCount = 4;
    var loadedCount = 0;
    var maxLoadingTime = 20000;
    var loaderTimer = null;
    var hadLoaded = false;
    var onloaded = function(){
        if(loadedCount < imgCount || hadLoaded){
            return;
        }
        hadLoaded = true;
        setTimeout(function(){
            jQuery('.loading-container').fadeOut(function() {
                jQuery(this).remove();
                jQuery(".loaded_show").fadeIn();
                jQuery(".slides-navigation").fadeIn();
                if(!isIE6){
                    init_page_flash();
                }
                init_slide_imgs();
                setTimeout(function(){
                    //jQuery("#slides").superslides("start");
                }, 5000);
            });
        }, 0);
    };
    var imgSrces = [
        "/apm-web/static/images/login/news_app_img_sk.jpg",
        "/apm-web/static/images/login/news_app_img_ds.jpg",
        "/apm-web/static/images/login/news_app_img_cr.jpg",
        "/apm-web/static/images/login/news_app_img_sp.jpg"
    ];
    for(var i = 0, len = imgCount; i < len; i++){
        var img = new Image();
        img.src = imgSrces[i];
        if (img.complete) {
            loadedCount++;
            onloaded();
            img = null;
        } else {
            (function(elm){
                elm.onload = elm.onerror = function (){
                    loadedCount++;
                    onloaded();
                    elm.onload = null;
                    elm.onerror = null;
                    elm = null;
                };
            })(img);
        }
    }
    loaderTimer = setTimeout(function(){
        loadedCount = imgCount;
        onloaded();
    }, maxLoadingTime);
});
(function(){
    var download_info_item_sk_selector = ".info_sk";
    var download_info_item_mj_selector = ".info_mj";
    var download_info_older_show_item_selector = download_info_item_sk_selector;
    var download_wrap_elm = jQuery("#wrap_download");
    var isStartUp = true;
    jQuery("#slides").superslides({
        play: false,
        slide_easing: 'easeInOutCubic',
        animation_speed: 0,
        slide_speed: 800,
        max_height: 900,
        pagination: false,
        hashchange: false,
        scrollable: false
    })
            .bind("animating.slides", function(e, data){
                var upcoming_slide = data.upcoming_slide;
                var outgoing_slide = data.outgoing_slide;
                var selector = "";
                if(upcoming_slide == 0){
                    selector = download_info_item_sk_selector;
                }else if(upcoming_slide == 1 || upcoming_slide == 2){
                    selector = download_info_item_mj_selector;
                }else{
                    download_wrap_elm.find("li").fadeOut();
                }
                if(!selector){
                    download_wrap_elm.fadeOut(function(){
                        //download_wrap_elm.find(download_info_older_show_item_selector).hide();
                    });
                }else if(selector != download_info_older_show_item_selector){
                    if(isIE6){
                        download_wrap_elm.show();
                    }else{
                        download_wrap_elm.fadeIn();
                    }
                    if(selector){
                        download_wrap_elm.find(download_info_older_show_item_selector).fadeOut();
                        download_wrap_elm.find(selector).fadeIn();
                    }
                }
                download_info_older_show_item_selector = selector;
            });
    //jQuery("#slides").superslides("stop");
    jQuery("#section_action").superslides({
        play: false,
        slide_easing: 'easeInOutCubic',
        animation_speed: 800,
        slide_speed: 800,
        max_height: 954,
        pagination: false,
        hashchange: false,
        scrollable: false
    });
    jQuery("#section_cj").superslides({
        play: false,
        slide_easing: 'easeInOutCubic',
        animation_speed: 800,
        slide_speed: 800,
        max_height: 954,
        pagination: false,
        hashchange: false,
        scrollable: false
    });
})();
(function(){
    var active_class = "active";
    var trigger_duration = 100;
    var trigger_timer_out = null;
    var active_default = jQuery("#mobile_active_default");
    var func_scale_max_elm = function(elm){
        if(jQuery.support.transition){
            elm.addClass(active_class);
        }else{
            elm.addClass(active_class);
        }
    };
    var func_scale_normal_elm = function(elm){
        if(jQuery.support.transition){
            elm.removeClass(active_class);
        }else{
            elm.removeClass(active_class);
        }
    };
    jQuery(".wrap_mobile li")
            .bind("mouseover", function(){
                var self = jQuery(this);
                var isDefault = this.id == "mobile_active_default";
                if(self.trigger_timer_out){
                    clearTimeout(self.trigger_timer_out);
                    self.trigger_timer_out = null;
                }
                if(self.trigger_timer_over){
                    return;
                }
                self.trigger_timer_over = setTimeout(function(){
                    if(!isDefault){
                        func_scale_normal_elm(active_default);
                    }
                    func_scale_max_elm(self);
                    //self.find("img").animate({width: 200, height: 390});
                    self.trigger_timer_over = null;
                }, trigger_duration);
            })
            .bind("mouseout", function(){
                var self = jQuery(this);
                var isDefault = this.id == "mobile_active_default";
                if(self.trigger_timer_out){
                    clearTimeout(self.trigger_timer_out);
                    self.trigger_timer_out = null;
                }
                self.trigger_timer_out = setTimeout(function(){
                    func_scale_normal_elm(self);
                    //self.find("img").animate({width: 140, height: 272});
                    self.trigger_timer_out = null;
                    if(isDefault){
                        trigger_timer_out = null;
                    }
                }, trigger_duration);
                if(isDefault){
                    trigger_timer_out = self.trigger_timer_out;
                }
            });
    jQuery(".wrap_mobile").bind("mouseout", function(){
        if(trigger_timer_out){
            clearTimeout(trigger_timer_out);
            trigger_timer_out = null;
        }
        setTimeout(function(){
            func_scale_max_elm(active_default);
        },trigger_duration);
    });
    active_default.trigger("mouseover");
})();
</script>
<script type="text/javascript">
    jQuery(function(){
        var dialog_wrap_elm = jQuery(".dialog_wrap");
        var video_wrap_elm = jQuery("#video_wrap");
        var win = jQuery(window);
        var bd = jQuery("body");
        var video_width = 938;
        var video_height = 484;
        var load_video = function(){
            return NTES_createVideo({
                "width" : video_width,
                "height" : video_height,
                "pltype": "6",
                "topicid": "0085",
                "vid": "V9FA2AMUC",
                "sid": "V82FPTKK4",
                "coverpic": "http://vimg1.ws.126.net/image/snapshot/2013/12/U/D/V9FA2AMUD.jpg",
                "autoplay": true,
                "showend": false,
                "url_mp4": "http://flv.bn.netease.com/videolib3/1312/16/zkLrM1202/HD/zkLrM1202-mobile.mp4"
            }, video_wrap_elm.get(0));
        };
        var dialog_closed = true;
        var video = null;
        var func_show_video = function(){
            if(!dialog_closed){
                return false;
            }
            jQuery('#slides').superslides('stop');
            dialog_wrap_elm.width(win.width()).height(Math.max(bd.height(), win.height()));
            if(isIE6){
                var video_left = (win.width() - video_width)/2;
                var video_top = (win.height() - video_height)/2;
                jQuery(".dialog_cnt").css({
                    left: video_left,
                    top: video_top,
                    margin: 0
                });
            }
            try{
                load_video();
            }catch(e){
                //TODO
            }
            dialog_wrap_elm.fadeIn(function(){
                dialog_closed = false;
            });
        };
        var func_hide_video = function(){
            /*
             if(video){
             try{
             video.stop();
             //video = null;
             }catch(e){
             //TODO
             }
             }*/
            dialog_wrap_elm.fadeOut(function(){
                dialog_closed = true;
                setTimeout(function(){
                    //jQuery("#slides").superslides("start");
                }, 5000);
                video_wrap_elm.html("");
            });
        };
        jQuery(".dialog_close").bind("click", function(){
            func_hide_video();
        });
        jQuery("#btn_video_play").bind("click", function(){
            func_show_video();
            return false;
        });
    });
</script>
<div class="plugin_wrap">
    <div class="arr_wrap">
        <div class="arr"></div>
        <div class="cnt"></div>
    </div>
    <div class="dialog_wrap">
        <div  class="dialog_mask transition_all"></div>
        <div class="dialog_cnt"><a class="dialog_close"></a><div id="video_wrap"></div></div>
    </div>
</div>
<script src="${ctxStatic}/js/login/videoplayer.js"></script>
<script type="text/javascript">
    if(isIE6){
        jQuery(function(){jQuery("a").attr("hideFocus", true);});
    }
</script>
</body>
</html>