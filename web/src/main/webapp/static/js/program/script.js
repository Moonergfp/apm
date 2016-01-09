//项目访问地址
var pUrl = $("#pUrl").val();
var curDiv;
var curScene = $("#topfd1");
$("#for_backg_edit").addClass("active");
var curSceneCount = 1;
var total = 0;
var curelement = null;
var preelement = null;
var prev = null;
var $curImgList = [];
var zindex = 0;
var widget = [];
function weatherinit(){	
	var selStyle = $('#selStyle').val();
	var selProvince = $("#selProvince").val();
	var selCity = $("#selCity").val();	
	var selCounty = $("#selCounty").val();	
	var selColor =  $("#selColor").val();
	var selBgColor = $("#selBgColor").val();	
	if(curScene.find(".weather").length > 0 ){
		//修改
		console.log("存在 修改");
		console.log(curScene.find(".weather").find("iframe").length);
		curScene.find(".weather").find("iframe").remove();
		console.log(curScene.find(".weather").find("iframe").length);
		var add = curScene.find(".weather");
		console.log(curelement);
	}else{
		//新建天气
		curScene.find(".weather").remove();//一个场景只能有一个天气
		total++;
		var add = $("<div id='weather_"+total+"' class='weather element active' title='' curimglist='' from='weather_edit' style='left:0px;top:0px;z-index:"+total+";position:absolute;width:664px; height:110px;background-color:#fff'></div>");
		
	}	
	
	$(add).attr({
		"selStyle":selStyle,
		"selProvince":selProvince,
		"selCity":selCity,
		"selCounty":selCounty,
		"selColor":selColor,
		"selBgColor":selBgColor,
	});
	
	var iframe  = $(".weather_edit").find("iframe").clone();
	$(iframe).show();
	$(add).append(iframe);	
	var frameOverlay  = $('<div class="frameOverlay"></div>');	
	$(add).append(frameOverlay);
	$(add).draggable({
		containment: ".content-center",
		scroll: false, 
		cursor: "move",
		cancel: "input",
		iframeFix: true
     });
	$(add).resizable({containment: ".content-center",handles: "n, e, s, w, ne, se, sw, nw"}); 
	curScene.append(add);
	$(add).click();
}	

/**
* 将秒数换成时分秒格式
*/
 function formatSeconds(value) {
    var theTime = parseInt(value);// 秒
    var theTime1 = 0;// 分
    var theTime2 = 0;// 小时
    if(theTime >= 60) {
        theTime1 = parseInt(theTime/60);
        theTime = parseInt(theTime%60);
            if(theTime1 >= 60) {
            theTime2 = parseInt(theTime1/60);
            theTime1 = parseInt(theTime1%60);
            }
    }
    console.log("传入的参数---------------"+value);
    console.log("秒-----------------"+theTime);
    console.log("分-----------------"+theTime1);
    console.log("时-----------------"+theTime2);
     if(theTime < 10){
    	theTime = "0" + theTime;
     }
     var result = ""+theTime;     
     if(theTime1 > 0) {    	
    	 if(theTime1 < 10){
    		 theTime1 = "0" + theTime1;
   	     }
    	 result = ""+theTime1+":"+result;
     }else{
    	 result = ""+"00"+":"+result;
     }
     if(theTime2 > 0) {    	
    	 result = ""+theTime2+":"+result;
     }
    return result;
}
 
 function sortNumber(a,b){
	return a - b;
	}
$(function(){	
	function redo(){
	 	 console.log("redo");
	     var index =   $("body").data("index");
	     console.log(index);
	     index  = (index != undefined)? index + 1  : 0; //记录次数
	     $("body").data("index",index);
	     console.log( curScene.data("index"));
	     var body = $("body");
	     $("body").data("body"+index,body.html()); //缓存拷贝对象	      
	     console.log( $("body").data("body"+index));
	}
	//回退
	/*$(".menu-drawback").click(function(){
		console.log("undo");
	     var index =   $("body").data("index");
	     console.log(index);
	   	 if (index == "undefined" || index < 0) {
	   		 console.log("return");
	        return;
	     };
	    var cacheData =  $("body").data("body"+index);
	    
	    $("body").html("");	
	    console.log("空");
	    $("body").html(cacheData); //重新加载缓存的对象
	    console.log("重新加载缓存的对象");
	    console.log("单次结束");	    
	    $("body").data("body"+index,"");
	    console.log($("body").data("body"+index));
	    $("body").data("index",index - 1); //把已经回退的对象清空，计数减一，
	    console.log($("body").data("index"));
	});*/
	
	
	
	
	$(".pauseMusic").hide();
	$(".playMusic").live("click",function(){
		$(".pauseMusic").click();
		$(this).parent().find(".pauseMusic").show();
		$(this).hide();
		$(this).parent().find(".amazingaudioplayer-play").click();
	});
	$(".pauseMusic").live("click",function(){
		$(this).parent().find(".playMusic").show();
		$(this).hide();
		$(this).parent().find(".amazingaudioplayer-pause").click();
	});
/*	$("#provinceCity").ProvinceCity();*/
/*	var stack = new Undo.Stack(),
	EditCommand = Undo.Command.extend({
		constructor: function(textarea, oldValue, newValue) {
			this.textarea = textarea;
			this.oldValue = oldValue;
			this.newValue = newValue;
		},
		execute: function() {
		},
		undo: function() {
			this.textarea.html(this.oldValue);
		},
		
		redo: function() {
			this.textarea.html(this.newValue);
		}
	});
stack.changed = function() {
	stackUI();
};

var undo = $(".undo"),
	redo = $(".redo"),
	dirty = $(".dirty");
function stackUI() {
	undo.attr("disabled", !stack.canUndo());
	redo.attr("disabled", !stack.canRedo());
	dirty.toggle(stack.dirty());
}
stackUI();

$(document.body).delegate(".undo, .redo, .save", "click", function() {
	var what = $(this).attr("class");
	stack[what]();
	return false;
});

var text = $("body"),
	startValue = text.html(),
	timer;
$("body").bind("keyup", function() {
	// a way too simple algorithm in place of single-character undo
	clearTimeout(timer);
	timer = setTimeout(function() {
		var newValue = text.html();
		// ignore meta key presses
		if (newValue != startValue) {
			// this could try and make a diff instead of storing snapshots
			stack.execute(new EditCommand(text, startValue, newValue));
			startValue = newValue;
		}
	}, 250);
});

$(".bold").click(function() {
	document.execCommand("bold", false);
	var newValue = text.html(); 
	stack.execute(new EditCommand(text, startValue, newValue));
	startValue = newValue;
});

$(document).keydown(function(event) {
	if (!event.metaKey || event.keyCode != 90) {
		return;
	}
	event.preventDefault();
	if (event.shiftKey) {
		stack.canRedo() && stack.redo()
	} else {
		stack.canUndo() && stack.undo();
	}
});*/
	
	

	
	/*  $(".element").draggable({containment: ".content-center",scroll: false,  cursor : "auto"});  */
	 $(".element").resizable({containment: ".content-center",handles: "n, e, s, w, ne, se, sw, nw"});
	 curScene.width($("#width").val());
	 curScene.height($("#height").val());
	 var getWindowSize = function(){
			return ["Height","Width"].map(function(name){
			  return window["inner"+name] ||
				document.compatMode === "CSS1Compat" && document.documentElement[ "client" + name ] || document.body[ "client" + name ];
			});
	};
	function getScrollbarWidth(op) {	
	    return op[0].offsetWidth - op[0].clientWidth;
	}
	function wSize(){
		var strs=getWindowSize().toString().split(",");
		var width = strs[1] - $(".content-left").width() - $(".content-right").width();
		var scrollbarWidth = getScrollbarWidth($("body"));
		 if(document.body.style.overflow!="hidden"&&document.body.scroll!="no"&&
				    document.body.scrollHeight > document.body.offsetHeight){
						 var lastWidth = width - 17;
					}else{ 
						 var lastWidth = width;
					}
		$(".content-main").css("width", lastWidth);			
		$(".content-main").css("height", strs[0] - 101);	
		$(".content-main").css("margin-left", $(".content-left").width());	
	
	 	$(".content-main-edit").css("width", lastWidth);
		$(".content-main-edit").css("height", strs[0] - 101);	
		console.log(getScrollbarWidth($(".content-main")));
	}

	$(window).resize(function(){
		wSize();
	});
	wSize(); // 在主窗体中定义，设置调整目标
	
	
	
	//导航栏图标点击 切换编辑状态
	$(".create-icon ul li").click(function(){
		if(!$(this).hasClass("active")){
			$(".create-icon ul li").removeClass("active");
			$(this).addClass("active");
		}
		//使得对应的编辑框显示			
		$(".content-right").find(".op-label").hide();
		$(".content-right").find("."+$(this).attr("for")).show();
		if($(this).attr("id") == "for_backg_edit"){
			$(".backg_tpl_item.active").click();
		}
		
	});
	//背景图片项的点击事件
	$("#backModal").find(".backmodal-m-i").live("click",function(){
		console.log("backmodal-m-i");
		var url = "url(http://localhost:8080"+$(this).find("img").attr("src")+")";
		var name = $(this).find("img").attr("alt");
		var attrid = $(this).find("img").attr("attrid");
		//给编辑区加背景
		curScene.css("background-image",url);
		curScene.attr("attrid",attrid);
		//更换选中元素的状态图
		$(".backg_edit").find(".backg_img_item img").attr("src",$(this).find("img").attr("src"));
		$(".backg_edit").find(".backg_img_item .backg_img_item_name").text(name);		
		$('#backModal').modal('hide');
		//给模板添加属性
		var index = parseInt(curScene.attr("id").replace(/topfd/,""));
		console.log(index);
		$("#tpl_item_"+index).attr("backsrc",$(this).find("img").attr("src"));
		$("#tpl_item_"+index).attr("backname",$(this).find("img").attr("alt"));
		
	});
	//删除背景
	$(".delBackImgBtn").live("click",function(){
		curScene.css("background-image","");
		curScene.attr("attrid","");
		$(this).parent().find("img").attr("src","");
		$(".backg_edit").find(".backg_img_item .backg_img_item_name").text("");	
		var index = parseInt(curScene.attr("id").replace(/topfd/,""));		
		$("#tpl_item_"+index).attr("backsrc","");		
		$("#tpl_item_"+index).attr("backname","");
		
	});
	//点击背景颜色图标之后为背景添加颜色
	$(".backg_edit").find(".color_wrap .bgcolor_item").live("click",function(){
		console.log("background-color1111");
		curScene.css("background-color",$(this).css("background-color"));
		$(this).addClass("active").siblings().removeClass("active");
		//给模板加背景颜色的属性
		var index = parseInt(curScene.attr("id").replace(/topfd/,""));		
		$("#tpl_item_"+index).attr("backcolor",$(this).css("background-color"));		
		
	});	
	
	//添加文本
	
	/* var initLeftOffset,initTopOffset; */
	
	function addtxt() {	
		console.log("for_text_edit click");
		/*if(curelement !=null){
			preelement = curelement;
			console.log("addtxt preelement");
			console.log(preelement);
		}*/
		total++;
       var add = $("<div  id='fonts_"+total+"' class='ui-state-active element font active' title='' from='text_edit' style='width:320px;min-height:38px;position: absolute;top:0px;left:0px;z-index:"+total+";color:#000;text-align:left;background-color:#fff' txtanimtype='none' />");
       $(add).append("<textarea id='textarea_fonts_"+total+"' class='selected' style='width:100%;height:100%'><span class='palceholder'>双击此处进行编辑</span></textarea>");
     /*  var frameOverlay  = $('<div class="frameOverlay"></div>');	
		$(add).append(frameOverlay);*/

       
       
       
	/*	$.undone("register",
		        function () { */
		    		//redo 	
					$(add).draggable({containment: ".content-center",scroll: false,  cursor: "move",cancel: "input"});
					$(add).resizable({containment: ".content-center",handles: "n, e, s, w, ne, se, sw, nw"});
		       	   curScene.append(add);
			       	var editor = $('#textarea_fonts_'+total).wangEditor({
			     	   'menuConfig': [
			     	          		['fontSize'],
			     	          		['foreColor'],
			     	          		['justify'],
			     	          		['bold'],
			     	          		['underline'],
			     	          		['italic']
			     	          	]
			        });		      
		       	    
			       	$(".wangEditor-textarea-container").css("height","100%");
			       	$(".wangEditor-textarea").css("height","100%");
			        $(add).find(".wangEditor-textarea").attr("contenteditable",true);		
			       /* editor.html("<span class='palceholder'>双击此处进行编辑</span>");
			        $(add).find(".palceholder").css({"background-color":"#08a1ef","color":"#fff"});*/
			     	
			    /* 	curelement = $(add);*/
			     	
		         /*  $(add).find(".elements").select();*/
			        
		           
		           /*curScene.addClass("active").siblings().removeClass("active"); */             
		          $(add).click();
		           /* redo();*/
		       /* },
		        function () { 
		        	//undo 
		        	 $(add).remove();
		        }
		    );*/
		
	}	
		
	function addimg() {
		console.log("for_img_edit click");
		total++;
		var add = $("<div id='image_"+total+"' class='element active image' title='' curimglist='' from='img_edit' style='top:0px;left:0px;display:block;width:200px;height:200px;position: absolute;z-index:"+total+";background-color:#fff' ><img src='' style='width:100%;height:100%'></div>");
		$(add).draggable({containment: ".content-center",scroll: false,  cursor: "move",cancel: "input"});
		$(add).resizable({containment: ".content-center",handles: "n, e, s, w, ne, se, sw, nw"}); 	
        curScene.append(add);
        $(add).click();
        /* redo();*/
	
	}	
	function addvideo(){
		total++;
		var add = $("<div id='video_"+total+"' class='video element active' title='' curimglist='' from='video_edit' style='left:0px;top:0px;z-index:"+total+";position:absolute;width:200px; height:200px;background-color:#fff' ><img src='' style='width:100%;height:100%'></div>");
		$(add).draggable({containment: ".content-center",scroll: false,  cursor: "move",cancel: "input"});
		 $(add).resizable({containment: ".content-center",handles: "n, e, s, w, ne, se, sw, nw"});
		 curScene.append(add);
		 $(add).click();
		 /* redo();*/
	}
	function addmusic(){
		if(curScene.find(".music").length > 0 ){
			console.log("yicunzai");
			curScene.find(".music").click();
		}else{
			console.log("不存在");
			total++;
			var add = $("<div id='music_"+total+"' class='music element active' title='' curimglist='' from='music_edit' style='left:0px;top:0px;z-index:"+total+";position:absolute;width:200px; height:200px;background-color:#fff'><img src='' style='width:100%;height:100%'></div>");
			$(add).draggable({containment: ".content-center",scroll: false,  cursor: "move",cancel: "input"});
			$(add).resizable({containment: ".content-center",handles: "n, e, s, w, ne, se, sw, nw"}); 
			curScene.append(add);
			$(add).click();
		}	
		/* redo();*/
		
	}
	function addppt(){
		total++;
		var add = $("<div id='ppt_"+total+"' class='ppt element active' title='' curimglist='' from='ppt_edit' style='left:0px;top:0px;z-index:"+total+";position:absolute;width:200px; height:200px;background-color:#fff'><img src='' style='width:100%;height:100%'></div>");
		$(add).draggable({containment: ".content-center",scroll: false,  cursor: "move",cancel: "input"});
		$(add).resizable({containment: ".content-center",handles: "n, e, s, w, ne, se, sw, nw"}); 
		curScene.append(add);
		$(add).click();
		/* redo();*/
	}
	function addword(){
		total++;
		var add = $("<div id='word_"+total+"' class='word element active' title='' curimglist='' from='word_edit' style='left:0px;top:0px;z-index:"+total+";position:absolute;width:200px; height:200px;background-color:#fff'><img src='' style='width:100%;height:100%'></div>");
		$(add).draggable({containment: ".content-center",scroll: false,  cursor: "move",cancel: "input"});
		$(add).resizable({containment: ".content-center",handles: "n, e, s, w, ne, se, sw, nw"}); 
		curScene.append(add);
		$(add).click();
		/* redo();*/
	}
	function addexcel(){
		total++;
		var add = $("<div id='excel_"+total+"' class='excel element active' title='' curimglist='' from='excel_edit' style='left:0px;top:0px;z-index:"+total+";position:absolute;width:200px; height:200px;background-color:#fff'><img src='' style='width:100%;height:100%'></div>");
		$(add).draggable({containment: ".content-center",scroll: false,  cursor: "move",cancel: "input"});
		$(add).resizable({containment: ".content-center",handles: "n, e, s, w, ne, se, sw, nw"}); 
		curScene.append(add);
		$(add).click();
		/* redo();*/
	}
	function addweather(){
		//清空初始化操作
		console.log("清空数据操作22222");
		$("#selStyle").val("1");	
		TQCODER.changeIcon($("#selStyle"));
		$("#selProvince").val("");
		TQCODER.changeProvince($("#selProvince"));		
		$("#selCounty").val("");
		TQCODER.changeCounty($("#selCounty"));		
		$("#selColor").val("");
		TQCODER.changeColor($("#selColor"));
		$("#selBgColor").val("");
		TQCODER.changeBgColor($("#selBgColor"));		
		$(".weather_edit").find("iframe").remove();
		TQCODER.preview();
		weatherinit();		
		/* redo();*/
	}	
	
	function adddate(){
		if(curScene.find(".date").length > 0 ){			
			curScene.find(".date").click();
		}else{			
			total++;
			var add = $("<div id='date_"+total+"' class='date element active' title='' timetype=8 datestyle=1 from='date_edit' style='font-size:13px;color:rgb(255,255,255);left:0px;top:0px;z-index:"+total+";position:absolute;width:400px; height:100px;background-color:#fff'><div class='op-beijingtime-box c-clearfix'> <p class='op-beijingtime-time op-time' id=''></p><p class='op-beijingtime-datebox op-date' id=''> </p></div></div>");
			$(add).draggable({containment: ".content-center",scroll: false,  cursor: "move",cancel: "input"});
			$(add).resizable({containment: ".content-center",handles: "n, e, s, w, ne, se, sw, nw"}); 
			curScene.append(add);
			$(add).click();
			window.baidu_time(new Date().getTime(),curScene);
		}
		/* redo();*/
		
	}	
	
	function left() {	
		curelement.css("text-align","left");
		curelement.find("textarea").css("text-align","left");
		       
	}
	function center() {
	
		curelement.css("text-align","center");
		curelement.find("textarea").css("text-align","center");
		      
		
	}

	function right() {
		
		curelement.css("text-align","right");
		curelement.find("textarea").css("text-align","right");
		      
		
	}
	function justify() {
		
		curelement.css("text-align","justify");
		curelement.find("textarea").css("text-align","justify");
		       
		
	}
	function bold() {
		/*curelement.css("font-weight","bold");*/
		document.execCommand("Bold");      
	}
	function itallic() {
		curelement.css("font-style","italic");	
	
	}
	function setline() {
		curelement.css("text-decoration","underline");	
		curelement.find("textarea").css("text-decoration","underline");
	}

	function setstrike() {
		
	}

	
	$("#for_text_edit").live("click",addtxt);
	$("#for_img_edit").live("click",addimg);
	$("#for_video_edit").live("click",addvideo);
	$("#for_music_edit").live("click",addmusic);
	$("#for_ppt_edit").live("click",addppt);
	$("#for_word_edit").live("click",addword);
	$("#for_excel_edit").live("click",addexcel);
	$("#for_weather_edit").live("click",addweather);
	$("#for_date_edit").live("click",adddate);
	
	$(".element").live("mousedown",function(event){		
	   if (event.button == 0) {  // 鼠标左键		  
	      if (event.ctrlKey) { //  ctrl
	    	  $(this).addClass("active");
	      } else {
	    	  $(this).addClass("active").siblings().removeClass("active");
	    	/*  $(this).click();*/
		  }
	   }
	})	
	//元素拖拽
	$(".element").live("click",function(){
		console.log("33333333333333");			
		$(".wangEditor-btn-container").hide();
    	$(this).find(".wangEditor-btn-container").show();    
    	
		/*if(curelement == null || curelement.attr("id") !== $(this).attr("id")){	
			curelement = $(this);
			if(curelement.attr("id") != $(this).attr("id")){		
				console.log("切换");
				preelement = curelement;
				console.log(preelement);
				console.log("element click");
			}
		}*/		
	    if (event.button == 0) {  // 鼠标左键		
	    	console.log("444444444444");
	      if (event.ctrlKey) { //  ctrl
	    	  console.log("55555555555555");
	    	  $(this).addClass("active");
	    	  widget.push($(this));
	      } else {
	    	  console.log("66666666666666666");
	    	  widget.length = 0;
	    	  widget.push($(this));	    
	    	  console.log("element click");
	    	$(this).addClass("active").siblings().removeClass("active");
	    	$(this).draggable({containment: ".content-center",scroll: false,  cursor: "move",cancel: "input"});
			$("#for_"+$(this).attr("from")).addClass("active").siblings().removeClass("active");
			if(curelement == null || curelement.attr("id") !== $(this).attr("id")){
				curelement = $(this);
				
				$(".element").find(".wangEditor-textarea").attr("contenteditable",false);
				$(".element").draggable("enable");
				
				$curimglist = [];	
				$(".op-label").hide();
				$("."+$(this).attr("from")).show();
				switch($(this).attr("from")){
				case "backg_edit":
					break;
				case "text_edit":
					//获取当前对象的css属性
					console.log("文本单击还没能编辑");
					console.log($(this).attr("txtanimtype"));
					if(!$(this).find("elements").attr("disabled")){
						console.log("没有disable 可编辑");					
					}else{					
					}
					 /* $(this).find(".elements").attr("contenteditable",true);  */
					$(".text_edit").find(".txtanim").val($(this).attr("txtanimtype"));
					if($(this).css("font-size")){
						$(".text_edit").find(".fontsize").val($(this).css("font-size"));
					}
					if($(this).css("color")){
						$(".text_edit").find(".txtcolor").val($(this).css("color"));
					}
					if($(this).css("text-align")){
						$(".text_edit").find(".glyphicon-align[type='"+	$(this).css("text-align")+"']").addClass("active").siblings(".glyphicon-align").removeClass("active");
					}
					if($(this).css("font-weight") == "bold"){
						$(".text_edit").find(".glyphicon-bold").addClass("active");
					}else{
						$(".text_edit").find(".glyphicon-bold").removeClass("active");
					}
					if($(this).css("font-style") == "italic"){
						$(".text_edit").find(".glyphicon-italic").addClass("active");
					}else{
						$(".text_edit").find(".glyphicon-italic").removeClass("active");
					}
					if($(this).css("text-decoration") == "underline"){
						$(".text_edit").find(".glyphicon-underline").addClass("active");
					}else{
						$(".text_edit").find(".glyphicon-underline").removeClass("active");
					}
					
					break;
				case "img_edit":	
					$(".imgdelay").val($(this).attr("delay"));					
					$(".img_edit").find(".img_wrap").html("");
					if($(this).attr("curimglist") !=""){					
						$curimglist = JSON.parse($(this).attr("curimglist"));					
						for(v in $curimglist){
							var index = parseInt(v)+1;
							$(".img_edit").find(".img_wrap")
							.append('<div class="img_item"><img src='+$curimglist[v].src+' alt='+$curimglist[v].name+' attrid='+$curimglist[v].attrid+'><span class="img_item_index">'+index+'</span><span class="img_item_name ellipsis">'+$curimglist[v].name+'</span><span class="glyphicon glyphicon-trash"></span></div>');
						}					
					}
					break;
				case "video_edit":
					$(".video_edit").find(".video_wrap").html("");
					if($(this).attr("curimglist") !=""){					
						$curimglist = JSON.parse($(this).attr("curimglist"));					
						for(v in $curimglist){
							var index = parseInt(v)+1;
							$(".video_edit").find(".video_wrap")
							.append('<div class="video_item"><img src='+$curimglist[v].src+' alt='+$curimglist[v].name+' source='+$curimglist[v].source+' long='+$curimglist[v].long+' attrid='+$curimglist[v].attrid+'><span class="video_item_index">'+index+'</span><span class="long video_item_time">'+formatSeconds($curimglist[v].long)+'</span><span class="video_item_name ellipsis">'+$curimglist[v].name+'</span><span class="glyphicon glyphicon-trash"></span></div>');
						}					
					}
					break;
				case "music_edit":
					$(".music_edit").find(".music_wrap").html("");
					if($(this).attr("curimglist") !=""){					
						$curimglist = JSON.parse($(this).attr("curimglist"));					
						for(v in $curimglist){
							var index = parseInt(v)+1;
							$(".music_edit").find(".music_wrap")
							.append('<div class="music_item"><img src='+$curimglist[v].src+' alt='+$curimglist[v].name+' long='+$curimglist[v].long+' source='+$curimglist[v].source+' attrid='+$curimglist[v].attrid+'><span class="music_item_index">'+index+'</span><span class="long music_item_time">'+formatSeconds($curimglist[v].long)+'</span><span class="music_item_name ellipsis">'+$curimglist[v].name+'</span><span class="glyphicon glyphicon-trash"></span></div>');
						}					
					}
					break;
				case "ppt_edit":
					$(".ppt_edit").find(".ppt_wrap").html("");
					if($(this).attr("curimglist") !=""){					
						$curimglist = JSON.parse($(this).attr("curimglist"));					
						for(v in $curimglist){
							var index = parseInt(v)+1;
							console.log($curimglist[v].imglist);
							$(".ppt_edit").find(".ppt_wrap")
							.append('<div class="ppt_item"><img src='+$curimglist[v].src+' alt='+$curimglist[v].name+' imglist='+$curimglist[v].imglist+' note='+$curimglist[v].note+' attrid='+$curimglist[v].attrid+'><span class="ppt_item_index">'+index+'</span><span class="ppt_item_note">'+$curimglist[v].note+'</span><span class="ppt_item_name ellipsis">'+$curimglist[v].name+'</span><span class="glyphicon glyphicon-trash"></span></div>');
						}					
					}
					break;
				case "word_edit":
					$(".word_edit").find(".word_wrap").html("");
					$(".word_edit .speed_wrap .btn").removeClass("active");
					if($(this).attr("curimglist") !=""){					
						$curimglist = JSON.parse($(this).attr("curimglist"));					
						for(v in $curimglist){
							var index = parseInt(v)+1;
							$(".word_edit").find(".word_wrap")
							.append('<div class="word_item"><img src='+$curimglist[v].src+' alt='+$curimglist[v].name+' note='+$curimglist[v].note+' wordurl='+$curimglist[v].wordurl+' htmlurl='+$curimglist[v].htmlurl+' attrid='+$curimglist[v].attrid+'><span class="word_item_index">'+index+'</span><span class="word_item_note">'+$curimglist[v].note+'</span><span class="word_item_name ellipsis">'+$curimglist[v].name+'</span><span class="glyphicon glyphicon-trash"></span></div>');
						}	
					}
					if($(this).attr("delay") !=""){
						$(".word_edit .speed_wrap .btn").each(function(){
							if($(this).attr("delay") == curelement.attr("delay")){
								$(this).addClass("active").siblings().removeClass("active");
							}							
						});
					}
					break;
				case "excel_edit":
					$(".excel_edit").find(".excel_wrap").html("");
					$(".excel_edit .speed_wrap .btn").removeClass("active");
					if($(this).attr("curimglist") !=""){					
						$curimglist = JSON.parse($(this).attr("curimglist"));					
						for(v in $curimglist){
						/*	var index = parseInt(v)+1;*/
							$(".excel_edit").find(".excel_wrap")
							.append('<div class="excel_item"><img src='+$curimglist[v].src+' alt='+$curimglist[v].name+' note='+$curimglist[v].note+' excelurl='+$curimglist[v].excelurl+' htmlurl='+$curimglist[v].htmlurl+' attrid='+$curimglist[v].attrid+'><span class="excel_item_note">'+$curimglist[v].note+'</span><span class="excel_item_name ellipsis">'+$curimglist[v].name+'</span><span class="glyphicon glyphicon-trash"></span></div>');
						}	
					}
					if($(this).attr("delay") !=""){
						$(".excel_edit .speed_wrap .btn").each(function(){
							if($(this).attr("delay") == curelement.attr("delay")){
								$(this).addClass("active").siblings().removeClass("active");
							}							
						});
					}
					
					break;
				case "weather_edit":					
					$("#selStyle").val("");
					$("#selProvince").val("");
					$("#selCity").val("");					
					$("#selCounty").val("");
					$("#selColor").val("");
					$("#selBgColor").val("");					
					var selStyle = curelement.attr("selStyle");
					var selProvince = curelement.attr("selProvince");
					var selCity = curelement.attr("selCity");
					var selCounty = curelement.attr("selCounty");
					var selColor = curelement.attr("selColor");
					var selBgColor = curelement.attr("selBgColor");					
					$("#selStyle").val(selStyle);					
					console.log(selProvince);
					if(selProvince != "" && selProvince != undefined){
						$("#selProvince").val(selProvince);						
						$(TQCODER.changeProvince($("#selProvince"))).load(function(){						
							if(selCity != "" && selCity != undefined){								
								TQCODER.changeCity($("#selCity"));
								if(selCounty != "" && selCounty != undefined){								
								}
						     }
						});
							
					}else{
						$("#selCity").hide();
						$("#selCounty").hide();
					}	
					$("#selCity").val(selCity);
					$("#selCounty").val(selCounty);
					$("#selColor").val(selColor);					
					$("#selBgColor").val(selBgColor);
					console.log("天气现在点选的是"+$("#selCounty").val());
					break;
				case "date_edit":
					if($(this).attr("timetype")){
						$(".date_edit").find(".getTime").val($(this).attr("timetype"));
					}					
					if($(this).attr("datestyle")){
						$(".date_edit").find(".dateStyle").val($(this).attr("datestyle"));
					}
					if($(this).css("font-size")){
						$(".date_edit").find(".fontsize").val($(this).css("font-size"));
					}
					if($(this).css("color")){
						$(".date_edit").find(".txtcolor").val($(this).css("color"));
					}
					
					if($(this).css("font-weight") == "bold"){
						$(".date_edit").find(".glyphicon-bold").addClass("active");
					}else{
						$(".date_edit").find(".glyphicon-bold").removeClass("active");
					}
					if($(this).css("font-style") == "italic"){
						$(".date_edit").find(".glyphicon-italic").addClass("active");
					}else{
						$(".date_edit").find(".glyphicon-italic").removeClass("active");
					}
					if($(this).css("text-decoration") == "underline"){
						$(".date_edit").find(".glyphicon-underline").addClass("active");
					}else{
						$(".date_edit").find(".glyphicon-underline").removeClass("active");
					}
										
					break;
				case "rss_edit":
					break;
				}
			}	
		  }
	   }
	  return false;
	});

	$(".element").live("dblclick",function(){
		if($(this).attr("from") == "text_edit" ){
			console.log("双击");
			$(this).draggable("disable");
			/*$(this).find(".elements").removeAttr("disabled");
			$(this).find(".elements").removeAttr("readonly");*/
			var wEdT = $(this).find(".wangEditor-textarea");
			wEdT.attr("contenteditable",true);
			 var palceholder = wEdT.find(".palceholder");
			if(wEdT.find(".palceholder").length){
				wEdT.find(".palceholder").remove();
				wEdT.focus();
			}
			
		
		/*	$(this).find(".elements").attr("contenteditable",true);*/
			/*$(this).find(".elements").select();*/
		}
	});
	$(".element").find(".elements").live("blur",function(){
		console.log("blur");	
		$(this).parent().removeClass("active");
	/*	$(this).attr("disabled","disabled");
		$(this).attr("readonly","readonly");*/
		$(this).parent().draggable("enable");
	});
	
	//元素可拉大拉小	
	$(".text-align").find(".glyphicon-align").live("click",function(){
		var oldval = curelement.css("text-align");
		var obj = $(this);
	/*	
		$.undone("register",
	        function () { */
	    		//redo 		
				if(obj.hasClass("active")){
					obj.removeClass("active");
					left();
				}else{					
					obj.addClass("active").siblings(".glyphicon-align").removeClass("active");				
					switch(obj.attr("type")){
					case "left":
						left();
						break;
					case "center":
						center();
						break;
					case "right":
						right();
						break;
					case "justify":
						justify();
						break;
					}
				}
	        /*},
	        function () { 
	        	//undo 
	        	curelement.css("text-align",oldval);
				curelement.find("textarea").css("text-align",oldval);
				$(".text-align").find(".glyphicon-align[type="+oldval+"]").addClass("active").siblings(".glyphicon-align").removeClass("active");		
	        }
	    );*/
		
		
		
		/* redo();*/
	});
	$(".text-align").find(".glyphicon-bold").live("click",function(){
		var obj = $(this);
	/*	$.undone("register",
		        function(){ */
		    		//redo 
					if($(obj).hasClass("active")){
						$(obj).removeClass("active");
						curelement.css("font-weight","normal");
					}else{
						$(obj).addClass("active");
						bold();
					}
		        /*},
		        function(){ 
		        	//undo 
		        	curelement.css("font-weight","normal");
		        	$(".text-align").find(".glyphicon-bold").removeClass("active");		
			        
		        }
		    );*/
		
		
	});
	$(".text-align").find(".glyphicon-italic").live("click",function(){
		if($(this).hasClass("active")){
			$(this).removeClass("active");
			curelement.css("font-style","normal");
		}else{
			$(this).addClass("active");
			itallic();
		}
		
	});
	$(".text-align").find(".glyphicon-underline").live("click",function(){
		if($(this).hasClass("active")){
			$(this).removeClass("active");
			curelement.css("text-decoration","none");			
			curelement.find("textarea").css("text-decoration","none");
		}else{
			$(this).addClass("active");
			setline();
		}
		
	});
	$(".clearstyle").live("click",function(){
		curelement.css("text-align","left");
		curelement.css("font-weight","normal");
		curelement.css("font-style","normal");
		curelement.css("text-decoration","none");
		curelement.css("font-size","inherit");
		curelement.css("color","#000");
		$(".text_edit").find(".txtcolor").val("");
		/* $('.txtcolor').colpick({
			layout:'rgbhex',
			color:'#000',
			onSubmit:function(hsb,hex,rgb,el) {
				$(el).css('background-color', '#'+hex);
				curelement.css("color", '#'+hex);
				$(el).colpickHide();
			}
		}).css('background-color', '#000'); */
		$(".text-align").find(".glyphicon").removeClass("active");
		
	});
	
	$(".text_edit").find(".fontsize").live("change",function(){
		/*curelement.css("font-size",$(this).val());
		curelement.find("textarea").css("font-size",$(this).val());*/
		 document.execCommand("FontSize",false,1);
		
		
	});	
	$(".date_edit").find(".fontsize").live("change",function(){
		curelement.css("font-size",$(this).val());
		
		var fontSize55 = (parseInt($(this).val().replace(/px/,""))+42)+"px";
      	var fontSize30 = (parseInt($(this).val().replace(/px/,""))+17)+"px";
    	var fontSize20 = (parseInt($(this).val().replace(/px/,""))+7)+"px";
		curelement.find(".op-beijingtime-time").css("font-size",fontSize55);
		curelement.find(".op-beijingtime-box .op-beijingtime-small").css("font-size",fontSize30);
		curelement.find(".op-beijingtime-datebox .op-beijingtime-week").css("font-size",fontSize20);
	
	});
	
	$(".text_edit").find(".txtcolor").live("change",function(){		
		/*curelement.css("color",$(this).val());		*/
		document.execCommand("ForeColor", "false", $(this).val()); 
		
	});
	$(".date_edit").find(".txtcolor").live("change",function(){		
		curelement.css("color",$(this).val());		
		//附加
		curelement.find(".op-beijingtime-box").css("color",$(this).val());
		
	});
	
	
	$(".text_edit").find(".txtanim").live("change",function(){		
		curelement.attr("txtanimtype",$(this).val()); //0表示静态,1表示动态
		
	});
	function sceneLong(){
		var curELong = 0;	
		if(curScene.find(".element").length == 0){
			//没有元素了，清空时长
			curScene.attr("long",0);
			$(".backg_tpl_item.active").attr("long",0);
			$(".backg_tpl_item.active").find(".time").html("");
		}else{
			//多个元素，当前元素时长与场景中各个元素的时长相比较
			var longArr = [];
			//目前先只针对img
			curScene.find(".element").each(function(){	
				var thisELong = 0;
				//目前只计算图片和视频的时长
				if($(this).attr("curimglist") != "" && $(this).attr("curimglist") != undefined){		
					var curimglistObj = JSON.parse($(this).attr("curimglist"));
					switch($(this).attr("from")){
						case "img_edit":
							thisELong = curimglistObj.length*$(this).attr("delay");
							break;
						case "video_edit":
							for(v in curimglistObj){
								thisELong += parseInt(curimglistObj[v].long);
							}
							break;
					}
				}				
				longArr.push(thisELong);
			});
			console.log("最终的时间是");
			longArr.sort(sortNumber);
			curELong = longArr[longArr.length-1];
			console.log(curELong);
			curScene.attr("long",curELong);
			$(".backg_tpl_item.active").attr("long",curELong);
			$(".backg_tpl_item.active").find(".time").html(formatSeconds(curELong));
			
		}
	}
	$(".img_edit").find(".imgdelay").live("change",function(){	
		/* if(curelement.attr("curimglist") != ""){ */	
		if($(".imgdelay").val() ==""){
			$(".imgdelay").val(3);
		}
		if(curelement){
			curelement.attr("delay",$(".imgdelay").val());
		}
		sceneLong();	
		
		/* }	 */	
	});
	
	$(".ppt_edit").find(".pptdelay").live("change",function(){
		curelement.attr("delay",$(this).val());
		
	});
	$(".date_edit").find(".dateStyle").live("change",function(){
		curelement.attr("dateStyle",$(this).val());
		
		//可能会操作DOM更改样式
	});
	$(".date_edit").find(".getTime").live("change",function(){
		
		/*adddate();*/
	});

	//jq颜色选择器
	 $('.addColor').colpick({
		layout:'rgbhex',
		color:'#fff',
		onSubmit:function(hsb,hex,rgb,el) {
		/*	$(el).css('background-color', '#'+hex);	
		*/
			curScene.css('background-color', '#'+hex);	
			$(".backg_tpl_item.active").attr('backcolor', curScene.css('background-color'));
			$(".bgcolor_item").removeClass("active");
			$(".bgcolor_item").each(function(){
				if($(this).css('background-color') == curScene.css('background-color')){
					$(this).addClass("active");
				}
			})
			/*var add = $('<span style="background-color:#'+hex+'" class="bgcolor_item"></span>');		
			$('.color_wrap').append(add);*/
		
			$(el).colpickHide();
		}
	}).css('background-color', '#337ab7'); 
	
	//图片素材列表
	$("#imgModal").find(".imgmodal-m-i").live("click",function(){
		if($(this).hasClass("active")){
			$(this).removeClass("active");
		}else{
			$(this).addClass("active");
		}
	});
	
	//视频素材列表	
	$("#videoModal").find(".videomodal-m-i").live("click",function(){
		if($(this).hasClass("active")){
			$(this).removeClass("active");
		}else{
			$(this).addClass("active");
		}
	});
	//ppt素材列表
	$("#pptModal").find(".pptmodal-m-i").live("click",function(){
		if($(this).hasClass("active")){
			$(this).removeClass("active");
		}else{
			$(this).addClass("active");
		}
	});
	//word素材列表
	$("#wordModal").find(".wordmodal-m-i").live("click",function(){
		if($(this).hasClass("active")){
			$(this).removeClass("active");
		}else{
			$(this).addClass("active");
		}
	});	
	//excel素材列表excelmodal-m-i
	$("#excelModal").find(".excelmodal-m-i").live("click",function(){
		if($(this).hasClass("active")){
			$(this).removeClass("active");
		}else{
			$(this).addClass("active");
		}
	});
	
	$("#musicModal").find(".musicmodal-m-i").live("click",function(){
		if($(this).hasClass("active")){
			$(this).removeClass("active");
		}else{
			$(this).addClass("active");
		}
	});
	
	
	
	//img素材的确定按钮
	$("#imgModal").find(".confirm").live("click",function(){
		console.log("未添加之前的$curImgList");
		console.log($curImgList);
		if(prev){
			if(prev.attr("id") != curelement.attr("id")){
				console.log("切换了元素  先清空curImgList 以及 img_wrap");
				$curImgList.length = 0;
				if(curelement.attr("curimglist") != ""){
					$curImgList = JSON.parse(curelement.attr("curimglist"));
				}
				/* $(".img_edit").find(".img_wrap").html(""); */
			}else{
				console.log("当前元素   图片添加的操作");
			}
		}else{
			console.log("不存在prev 就是页面中第一个img");
		}
		
		$("#imgModal").find(".imgmodal-m-i").each(function(){
			if($(this).hasClass("active")){
				var src = $(this).find("img").attr("src");
				var name = $(this).find("img").attr("alt");
				var attrid = $(this).find("img").attr("attrid");
				console.log("确定之前的$curImgList");
				console.log($curImgList.length);
				if(!$curImgList.length){
					console.log(curelement);
					curelement.find("img").attr("src",src);					
				}
				$curImgList.push({"src":src,"name":name,"attrid":attrid});
				$(".img_edit").find(".img_wrap")
				.append('<div class="img_item"><img src='+src+' alt='+name+' attrid='+attrid+'><span class="img_item_index">'+$curImgList.length+'</span><span class="img_item_name ellipsis">'+name+'</span><span class="glyphicon glyphicon-trash"></span></div>');
			}
		});	
		if(!$curImgList.length){
			console.log("没有选中任何元素");
			curelement.find("img").attr("src","");
			curelement.attr("curimglist","");
		}else{
			curelement.attr("curimglist",JSON.stringify($curImgList));			
			//比较场景时长
			//设置默认的图片切换时间		
			if($(".imgdelay").val() ==""){
				$(".imgdelay").val(3);
			}
			if(curelement){
				curelement.attr("delay",$(".imgdelay").val());
			}
			sceneLong();
		}
		
		$("#imgModal").find(".imgmodal-m-i").removeClass("active");
		$("#imgModal").modal("hide");
		prev = curelement;
		
		
		
		
	});
	//video素材的确定按钮
	$("#videoModal").find(".confirm").live("click",function(){
		console.log("未添加之前的$curImgList");
		console.log($curImgList);
		if(prev){
			if(prev.attr("id") != curelement.attr("id")){
				console.log("切换了元素  先清空curImgList 以及 img_wrap");
				$curImgList.length = 0;
				if(curelement.attr("curimglist") != ""){
					$curImgList = JSON.parse(curelement.attr("curimglist"));
				}
				/* $(".img_edit").find(".img_wrap").html(""); */
			}else{
				console.log("当前元素   图片添加的操作");
			}
		}else{
			console.log("不存在prev 就是页面中第一个img");
		}
		
		$("#videoModal").find(".videomodal-m-i").each(function(){
			if($(this).hasClass("active")){
				var src = $(this).find("img").attr("src");
				var name = $(this).find("img").attr("alt");
				var long = $(this).find("img").attr("long");
				var source = $(this).find("img").attr("source");
				var attrid = $(this).find("img").attr("attrid");
				console.log("确定之前的$curImgList");
				console.log($curImgList.length);
				if(!$curImgList.length){
					console.log(curelement);
					curelement.find("img").attr("src",src);					
				}
				$curImgList.push({"src":src,"name":name,"source":source,"long":long,"attrid":attrid});
				$(".video_edit").find(".video_wrap")
				.append('<div class="video_item"><img src='+src+' alt='+name+' source='+source+' long='+long+' attrid='+attrid+'><span class="video_item_index">'+$curImgList.length+'</span><span class="long video_item_time">'+formatSeconds(long)+'</span><span class="video_item_name ellipsis">'+name+'</span><span class="glyphicon glyphicon-trash"></span></div>');
			}
		});	
		if(!$curImgList.length){
			console.log("没有选中任何元素");
			curelement.find("img").attr("src","");
			curelement.attr("curimglist","");
		}else{
			curelement.attr("curimglist",JSON.stringify($curImgList));
		}
		
		$("#videoModal").find(".videomodal-m-i").removeClass("active");
		$("#videoModal").modal("hide");
		prev = curelement;
		sceneLong();
		
	});	
	
	//music素材的确定按钮
	$("#musicModal").find(".confirm").live("click",function(){	
		if(prev){
			if(prev.attr("id") != curelement.attr("id")){
				console.log("切换了元素  先清空curImgList 以及 img_wrap");
				$curImgList.length = 0;
				if(curelement.attr("curimglist") != ""){
					console.log("1111111111111111");
					$curImgList = JSON.parse(curelement.attr("curimglist"));
					console.log("1111111111111111");
				}
			}else{			
			}
		}else{
			
		}
		$("#musicModal").find(".musicmodal-m-i").each(function(){
			console.log("22222222222222222222");
			if($(this).hasClass("active")){
				console.log("333333333333333333");
				var src = $(this).find("img").attr("src");
				var name = $(this).find("img").attr("alt");
				var long = $(this).find("img").attr("long");
				var source = $(this).find("img").attr("source");
				var attrid = $(this).find("img").attr("attrid");
				console.log("确定之前的$curImgList");
				console.log($curImgList.length);
				if(!$curImgList.length){
					console.log(curelement);
					curelement.find("img").attr("src",src);					
				}
				$curImgList.push({"src":src,"name":name,"long":long,"source":source,"attrid":attrid});
				$(".music_edit").find(".music_wrap")
				.append('<div class="music_item"><img src='+src+' alt='+name+' long='+long+' source='+source+' attrid='+attrid+'><span class="music_item_index">'+$curImgList.length+'</span><span class="long music_item_time">'+formatSeconds(long)+'</span><span class="music_item_name ellipsis">'+name+'</span><span class="glyphicon glyphicon-trash"></span></div>');
			}
		});	
		if(!$curImgList.length){
			console.log("没有选中任何元素");
			curelement.find("img").attr("src","");
			curelement.attr("curimglist","");
		}else{
			curelement.attr("curimglist",JSON.stringify($curImgList));
		}
		
		$("#musicModal").find(".musicmodal-m-i").removeClass("active");
		$("#musicModal").modal("hide");
		prev = curelement;
		
		
	});	
	//ppt素材的确定按钮
	$("#pptModal").find(".confirm").live("click",function(){
		console.log("ppt未添加之前的$curImgList");
		console.log($curImgList);
		if(prev){
			if(prev.attr("id") != curelement.attr("id")){
				console.log("切换了元素  先清空curImgList 以及 ppt_wrap");
				$curImgList.length = 0;
				if(curelement.attr("curimglist") != ""){
					$curImgList = JSON.parse(curelement.attr("curimglist"));
				}
				/* $(".img_edit").find(".img_wrap").html(""); */
			}else{
				console.log("当前元素   ppt添加的操作");
			}
		}else{
			console.log("不存在prev 就是页面中第一个img");
		}
		
		$("#pptModal").find(".pptmodal-m-i").each(function(){
			if($(this).hasClass("active")){
				var src = $(this).find("img").attr("src").replace(/\\/g,"/");
				var name = $(this).find("img").attr("alt");
				var imglist = $(this).find("img").attr("imglist");
				var attrid = $(this).find("img").attr("attrid");
				console.log('$("#pptModal").find(".pptmodal-m-i").each(function(){');
				console.log(imglist);
				var note = $(this).find("img").attr("note");
				console.log("确定之前的$curImgList");
				console.log($curImgList.length);
				if(!$curImgList.length){
					console.log(curelement);
					curelement.find("img").attr("src",src);					
				}			
				$curImgList.push({"src":src,"name":name,"imglist":imglist.replace(/\\/g,"/"),"note":note,"attrid":attrid});
				console.log($curImgList);				
				$(".ppt_edit").find(".ppt_wrap")
				.append('<div class="ppt_item"><img src='+src+' alt='+name+' imglist="'+imglist.replace(/\\/g,"/")+'" note='+note+' attrid='+attrid+'><span class="ppt_item_index">'+$curImgList.length+'</span><span class="ppt_item_note">'+note+'</span><span class="ppt_item_name ellipsis">'+name+'</span><span class="glyphicon glyphicon-trash"></span></div>');
			}
		});	
		if(!$curImgList.length){
			console.log("没有选中任何元素");
			curelement.find("img").attr("src","");
			curelement.attr("curimglist","");
		}else{
			curelement.attr("curimglist",JSON.stringify($curImgList));
		}
		
		$("#pptModal").find(".pptmodal-m-i").removeClass("active");
		$("#pptModal").modal("hide");
		prev = curelement;
		
	});
	//word素材的确定按钮
	$("#wordModal").find(".confirm").live("click",function(){
		console.log("ppt未添加之前的$curImgList");
		console.log($curImgList);
		if(prev){
			if(prev.attr("id") != curelement.attr("id")){
				console.log("切换了元素  先清空curImgList 以及 ppt_wrap");
				$curImgList.length = 0;
				if(curelement.attr("curimglist") != ""){
					$curImgList = JSON.parse(curelement.attr("curimglist"));
				}
				/* $(".img_edit").find(".img_wrap").html(""); */
			}else{
				console.log("当前元素   ppt添加的操作");
			}
		}else{
			console.log("不存在prev 就是页面中第一个img");
		}
		
		
	
		var curdiv = curelement;
		console.log("1111");
		console.log(curdiv);
		$("#wordModal").find(".wordmodal-m-i").each(function(){
			if($(this).hasClass("active")){
				var obj = $(this);				
				$.ajax({
					url:pUrl + "/fileInfosa/download",
					async:false,
					data:{"id": $(this).find("img").attr("attrid")},
					success:function(data){
						console.log(data);
						console.log($(obj));
						var src = $(obj).find("img").attr("src");
						var name = $(obj).find("img").attr("alt");
						var note = $(obj).find("img").attr("note");
						var wordurl = $(obj).find("img").attr("wordurl");
						var htmlurl = $(obj).find("img").attr("htmlurl");
						var attrid = $(obj).find("img").attr("attrid");
						console.log("word确定之前的$curImgList");
						console.log($curImgList.length);
						if(!$curImgList.length){
							console.log(curelement);
							curelement.find("img").attr("src",src);					
						}			
						$curImgList.push({"src":src,"name":name,"note":note,"wordurl":wordurl,"htmlurl":data,"attrid":attrid});
						console.log($curImgList);
						$(".word_edit").find(".word_wrap")
						.append('<div class="word_item"><img src='+src+' alt='+name+' note='+note+' wordurl='+wordurl+' htmlurl='+data+' attrid='+attrid+'><span class="word_item_index">'+$curImgList.length+'</span><span class="word_item_note">'+note+'</span><span class="word_item_name ellipsis">'+name+'</span><span class="glyphicon glyphicon-trash"></span></div>');	
					}
				});
			}
		});	
		if(!$curImgList.length){
			console.log("没有选中任何元素");
			curelement.find("img").attr("src","");
			curelement.attr("curimglist","");
		}else{
			curelement.attr("curimglist",JSON.stringify($curImgList));
		}
		
		$("#wordModal").find(".wordmodal-m-i").removeClass("active");
		$("#wordModal").modal("hide");
		prev = curelement;
		
	});
	
	//excel素材的确定按钮
	$("#excelModal").find(".confirm").live("click",function(){	
		if(prev){
			if(prev.attr("id") != curelement.attr("id")){			
				$curImgList.length = 0;
				if(curelement.attr("curimglist") != ""){
					$curImgList = JSON.parse(curelement.attr("curimglist"));
				}			
			}else{				
			}
		}else{		
		}
		
		$("#excelModal").find(".excelmodal-m-i").each(function(){
			if($(this).hasClass("active")){
				var obj = $(this);				
				$.ajax({
					url:pUrl + "/fileInfosa/download",
					async:false,
					data:{"id": $(obj).find("img").attr("attrid")},
					success:function(data){
						console.log("hahah");
						var src = $(obj).find("img").attr("src");
						var name = $(obj).find("img").attr("alt");
						var note = $(obj).find("img").attr("note");
						var excelurl = $(obj).find("img").attr("excelurl");
						var htmlurl = $(obj).find("img").attr("htmlurl");		
						var attrid = $(obj).find("img").attr("attrid");		
						if(!$curImgList.length){
							console.log(curelement);
							console.log(data);
							curelement.find("img").attr("src",src);					
						}			
						$curImgList.push({"src":src,"name":name,"note":note,"excelurl":excelurl,"htmlurl":data,"attrid":attrid});
						console.log($curImgList);
						$(".excel_edit").find(".excel_wrap")
						.append('<div class="excel_item"><img src='+src+' alt='+name+' note='+note+' excelurl='+excelurl+' htmlurl='+data+' attrid='+attrid+'><span class="excel_item_index">'+$curImgList.length+'</span><span class="excel_item_note">'+note+'</span><span class="excel_item_name ellipsis">'+name+'</span><span class="glyphicon glyphicon-trash"></span></div>');
					}
				})
			}
		});	
		if(!$curImgList.length){
			console.log("没有选中任何元素");
			curelement.find("img").attr("src","");
			curelement.attr("curimglist","");
		}else{
			curelement.attr("curimglist",JSON.stringify($curImgList));
		}
		
		$("#excelModal").find(".excelmodal-m-i").removeClass("active");
		$("#excelModal").modal("hide");
		prev = curelement;
		
	});
	
	
	$(".img_edit .glyphicon-trash").live("click",function(){
		console.log($curImgList);				
		$(this).parent().remove();
		$curImgList = [];
		curelement.attr("curimglist","");
		if($(".img_edit").find(".img_item").length){
			$(".img_edit").find(".img_item").each(function(){
				$(this).find(".img_item_index").text($(this).index()+1);
				var src = $(this).find("img").attr("src");
				var name = $(this).find("img").attr("alt");
				$curImgList.push({"src":src,"name":name});
				if($curImgList.length == 1 ){
					curelement.find("img").attr("src",src);
				}
			});
			curelement.attr("curimglist",JSON.stringify($curImgList));
		}else{
			curelement.find("img").attr("src","");
		}
		sceneLong();
		
	});
	$(".video_edit .glyphicon-trash").live("click",function(){
		console.log($curImgList);				
		$(this).parent().remove();
		$curImgList = [];
		curelement.attr("curimglist","");
		if($(".video_edit").find(".video_item").length){
			$(".video_edit").find(".video_item").each(function(){
				$(this).find(".video_item_index").text($(this).index()+1);
				var src = $(this).find("img").attr("src");
				var name = $(this).find("img").attr("alt");
				var source = $(this).find("img").attr("source");
				var long = $(this).find("img").attr("long");
				$curImgList.push({"src":src,"name":name,"source":source,"long":long});
				if($curImgList.length == 1 ){
					curelement.find("img").attr("src",src);
				}
			});
			curelement.attr("curimglist",JSON.stringify($curImgList));
		}else{
			curelement.find("img").attr("src","");
		}
		sceneLong();
		
	});
	
	$(".music_edit .glyphicon-trash").live("click",function(){				
		$(this).parent().remove();
		$curImgList = [];
		curelement.attr("curimglist","");
		if($(".music_edit").find(".music_item").length){
			$(".music_edit").find(".music_item").each(function(){
				$(this).find(".music_item_index").text($(this).index()+1);
				var src = $(this).find("img").attr("src");
				var name = $(this).find("img").attr("alt");
				var long = $(this).find("img").attr("long");
				var source = $(this).find("img").attr("source");
				$curImgList.push({"src":src,"name":name,"long":long,"source":source});
				if($curImgList.length == 1 ){
					curelement.find("img").attr("src",src);
				}
			});
			curelement.attr("curimglist",JSON.stringify($curImgList));
		}else{
			curelement.find("img").attr("src","");
		}	
		
	});
	
	
	
	$(".ppt_edit .glyphicon-trash").live("click",function(){
		console.log($curImgList);				
		$(this).parent().remove();
		$curImgList = [];
		curelement.attr("curimglist","");
		if($(".ppt_edit").find(".ppt_item").length){
			$(".ppt_edit").find(".ppt_item").each(function(){
				$(this).find(".ppt_item_index").text($(this).index()+1);
				var src = $(this).find("img").attr("src");
				var name = $(this).find("img").attr("alt");
				var imglist = $(this).find("img").attr("imglist");
				var note = $(this).find("img").attr("note");
				$curImgList.push({"src":src,"name":name,"imglist":imglist.replace(/\\/g,"/"),"note":note});
				if($curImgList.length == 1 ){
					curelement.find("img").attr("src",src);
				}
			});
			curelement.attr("curimglist",JSON.stringify($curImgList));
		}else{
			curelement.find("img").attr("src","");
		}
		
	});
	
	$(".word_edit .glyphicon-trash").live("click",function(){
		console.log($curImgList);				
		$(this).parent().remove();
		$curImgList = [];
		curelement.attr("curimglist","");
		if($(".word_edit").find(".word_item").length){
			$(".word_edit").find(".word_item").each(function(){
				$(this).find(".word_item_index").text($(this).index()+1);
				var src = $(this).find("img").attr("src");
				var name = $(this).find("img").attr("alt");
				var note = $(this).find("img").attr("note");
				var wordurl = $(this).find("img").attr("wordurl");
				var htmlurl = $(this).find("img").attr("htmlurl");
				$curImgList.push({"src":src,"name":name,"note":note,"wordurl":wordurl,"htmlurl":htmlurl});
				if($curImgList.length == 1 ){
					curelement.find("img").attr("src",src);
				}
			});
			curelement.attr("curimglist",JSON.stringify($curImgList));
		}else{
			curelement.find("img").attr("src","");
		}
		
	});
	
	
	$(".excel_edit .glyphicon-trash").live("click",function(){					
		$(this).parent().remove();
		$curImgList = [];
		curelement.attr("curimglist","");
		if($(".excel_edit").find(".excel_item").length){
			$(".excel_edit").find(".excel_item").each(function(){
				$(this).find(".excel_item_index").text($(this).index()+1);
				var src = $(this).find("img").attr("src");
				var name = $(this).find("img").attr("alt");
				var note = $(this).find("img").attr("note");
				var excelurl = $(this).find("img").attr("excelurl");
				var htmlurl = $(this).find("img").attr("htmlurl");
				$curImgList.push({"src":src,"name":name,"note":note,"excelurl":excelurl,"htmlurl":htmlurl});
				if($curImgList.length == 1 ){
					curelement.find("img").attr("src",src);
				}
			});
			curelement.attr("curimglist",JSON.stringify($curImgList));
		}else{
			curelement.find("img").attr("src","");
		}
		
	});
	
	
	$(".word_edit .speed_wrap .btn").live("click",function(){
		$(this).addClass("active").siblings().removeClass("active");
		curelement.attr("delay",$(this).attr("delay"));
		
	});
	$(".excel_edit .speed_wrap .btn").live("click",function(){
		$(this).addClass("active").siblings().removeClass("active");
		curelement.attr("delay",$(this).attr("delay"));
		
	});
	//点击backg_tpl_item切换场景
	$(".backg_tpl_item").live("click",function(){
		console.log(curelement);
		/*if(curelement.attr("from") == "text_edit"){		*/
			$(".element").find(".wangEditor-textarea").attr("contenteditable",false);
			$(".element").find(".wangEditor-btn-container").hide();
			$(".element").draggable("enable");
			/*curelement.find(".frameOverlay").show();*/
		/*}*/
				
		
		if(!$(this).hasClass("active")){
			$(this).addClass("active").siblings().removeClass("active");
			curScene = $(".content-main-edit").find(".content-center-topfd").eq($(this).index());
		 	curScene.addClass("content-center").show().siblings().removeClass("content-center").hide();
		}
		//背景图标处于选中状态
		$("#for_backg_edit").addClass("active").siblings().removeClass("active");
		//背景编辑显示
		$(".backg_edit").show().siblings().hide();
		//初始化背景编辑
		console.log($(this).attr("backsrc"));
		if($(this).attr("backsrc") != ""){
			console.log("有 src");
			var url = "url(http://localhost:8080"+$(this).attr("backsrc")+")";
			var name = $(this).attr("backname");
			//给编辑区加背景
			curScene.css("background-image",url);
			//更换选中元素的状态图
			$(".backg_edit").find(".backg_img_item img").attr("src",$(this).attr("backsrc"));
			$(".backg_edit").find(".backg_img_item .backg_img_item_name").text(name);	
		}else{
			console.log("没 src");
			//给编辑区加背景
			curScene.css("background-image","");
			//更换选中元素的状态图
			$(".backg_edit").find(".backg_img_item img").attr("src","");
			$(".backg_edit").find(".backg_img_item .backg_img_item_name").text("");	
		}
		if($(this).attr("backcolor") != ""){
			var color = $(this).attr("backcolor");
			//给编辑区加背景
			curScene.css("background-color",color);
			$(".bgcolor_item").each(function(){
				if($(this).css("background-color") == color){
					$(this).addClass("active").siblings().removeClass("active");
				}else{
					$(this).removeClass("active");
				}
			});			
		}else{
			curScene.css("background-color","#fff");
			$(".bgcolor_item").removeClass("active");
		}
		if(curScene.find(".date").length > 0){
			var timeType = curScene.find(".date").attr("timeType");	
			console.log(timeType);
			//切换时钟
			window.baidu_time(getTimeString(new Date(), timeType).getTime(),curScene);	
		}
		/*$("#visRuler").click();*/
		//标尺始终显示
	
		$("#zxxScaleRulerH").css("display","block");
		$("#zxxScaleRulerV").css("display","block");;
		$("#zxxRefDotH").css("display","block");
		$("#zxxRefDotV").css("display","block");
		$("#zxxScaleBox").show();
		$("#zxxScaleBox").css("display","block");		
		$(".element").removeClass("active");
		curelement = null;
	});
	$(".backg_tpl_op").find(".scene-add").live("click",function(){		
		//背景图标处于选中状态
		$("#for_backg_edit").addClass("active").siblings().removeClass("active");
		//背景编辑显示
		$(".backg_edit").show().siblings().hide();
		curSceneCount++;
		var index = $(".backg_tpl_item").length +1;
		var newbackg_tpl_item = $('<div class="backg_tpl_item" long=0 id="tpl_item_'+curSceneCount+'" to="topfd'+curSceneCount+'" backsrc="" backname="" backcolor=""><div class="pull-left"><span class="tpl_item_index">'+index+'</span> <span class="time"></span> <a href="javascript:void(0)" class="glyphicon glyphicon-trash scene-del"></a></div><img src="" alt="" class="tpl_item_thumbnail pull-right"> </div>');
		$(".backg_tpl").append(newbackg_tpl_item);
		//默认的场景时间为long=0
		var newScene = $('<div id="topfd'+curSceneCount+'" long=0 class="ui-widget-content content-center-topfd lfettop" style="position: relative;background-color: rgb(255, 255, 255); background-size: 100% 100%; background-repeat: no-repeat;"></div>');
		/*$(".content-main-edit").append(newScene);*/
		newScene.width($("#width").val());		
		newScene.height($("#height").val());
		$(".content-main-edit").find("#zxxScaleRulerH").before(newScene);
		curScene = $("#topfd"+curSceneCount);
		curScene.addClass("content-center").show().siblings().removeClass("content-center").hide();
		$("#tpl_item_"+curSceneCount).addClass("active").siblings().removeClass("active");		
		//初始化背景编辑
		curScene.css("background-image","");
		curScene.css("background-color","#fff");
		//更换选中元素的状态图
		$(".backg_edit").find(".backg_img_item img").attr("src","");
		$(".backg_edit").find(".backg_img_item .backg_img_item_name").text("");	
		$(".backg_edit").find(".bgcolor_item").removeClass("active");
		//清空模板的背景属性
		var index = parseInt(curScene.attr("id").replace(/topfd/,""));
		console.log(index);
		$("#tpl_item_"+index).attr("backsrc","");		
		$("#tpl_item_"+index).attr("backname","");
		//标尺始终显示
		$("#zxxScaleRulerH").css("display","block");
		$("#zxxScaleRulerV").css("display","block");;
		$("#zxxRefDotH").css("display","block");
		$("#zxxRefDotV").css("display","block");
		$("#zxxScaleBox").show();
		$("#zxxScaleBox").css("display","block");		
		$(".element").removeClass("active");
		
	});
	
	
	function copyinit(add,obj){
		//初始化元素样式
		 $(add).attr("delay",$(obj).attr("delay"));	
		 $(add).attr("curimglist",$(obj).attr("curimglist"));				
	      //初始化元素内容	          
	      $(add).append($(obj).find("img").clone());
	}
	//复制场景
	$(".backg_tpl_op").find(".scene-copy").live("click",function(){		
		//复制场景
		var backg_tpl_itemC = $(".backg_tpl_item.active").clone();		
		//背景图标处于选中状态
		$("#for_backg_edit").addClass("active").siblings().removeClass("active");
		//背景编辑显示
		$(".backg_edit").show().siblings().hide();
		curSceneCount++;
		var index = $(".backg_tpl_item").length +1;
		backg_tpl_itemC.attr("id","tpl_item_"+curSceneCount);
		backg_tpl_itemC.attr("to","topfd"+curSceneCount);
		backg_tpl_itemC.find(".tpl_item_index").html(index);
		/*var newbackg_tpl_item = $('<div class="backg_tpl_item" id="tpl_item_'+curSceneCount+'" to="topfd'+curSceneCount+'" backsrc="'++'" backname="" backcolor=""><img src="" alt="" class="tpl_item_thumbnail pull-right"> <span class="tpl_item_index">'+index+'</span> <span class="time"></span> <a href="javascript:void(0)" class="glyphicon glyphicon-trash scene-del"></a></div>');
		*/
		var newbackg_tpl_item = backg_tpl_itemC;
		$(".backg_tpl").append(newbackg_tpl_item);
		//不同于添加的部分
		
		var newScene = $('<div id="topfd'+curSceneCount+'" long=0 class="ui-widget-content content-center-topfd lfettop" style="position: relative; width: 1024px; height: 768px; background-color: rgb(255, 255, 255); background-size: 100% 100%; background-repeat: no-repeat;"></div>');
		//场景初始化
		newScene.css("background-image",curScene.css("background-image"));
		newScene.css("background-color",curScene.css("background-color"));		
		$(".content-main-edit").find("#zxxScaleRulerH").before(newScene);
	
		curScene.find(".element").each(function(){			
			total++;
			var from = $(this).attr("from");
			//类型为txt ,addtxt
			if(from == "text_edit"){
	           var add = $("<div  id='fonts_"+total+"' class='ui-state-active element font active' title='' from='text_edit' style='width:320px;min-height:38px;position: absolute;top:0px;left:0px;z-index:"+total+";color:#000;text-align:left;background-color:#fff' txtanimtype='none' />");
	          /* //初始化元素样式和属性	         
	           	 $(add).attr("txtanimtype",$(this).attr("txtanimtype"));		
	        	 $(add).css("font-size",$(this).css("font-size"));			
				 $(add).css("color",$(this).css("color"));			
				 $(add).css("text-align",$(this).css("text-align"));			
				 $(add).css("font-weight",$(this).css("font-weight"));			
				 $(add).css("font-style",$(this).css("font-style"));		
				 $(add).css("text-decoration",$(this).css("text-decoration"));				 
	           //初始化元素内容	          
	           $(add).append($(this).find("textarea").clone());*/
	          
			}
			if(from == "img_edit"){
				var add = $("<div id='image_"+total+"' class='element active image' title='' curimglist='' from='img_edit' style='top:0px;left:0px;display:block;width:200px;height:200px;position: absolute;z-index:"+total+";background-color:#fff' ></div>");
				copyinit(add,$(this));   
			}		
			if(from == "video_edit"){
				var add = $("<div id='video_"+total+"' class='video element active' title='' curimglist='' from='video_edit' style='left:0px;top:0px;z-index:"+total+";position:absolute;width:200px; height:200px;background-color:#fff' ></div>");
				//初始化元素样式				
				 $(add).attr("curimglist",$(this).attr("curimglist"));				
	           //初始化元素内容	          
	           $(add).append($(this).find("img").clone());   
			}
			if(from == "music_edit"){
				var add = $("<div id='music_"+total+"' class='music element active' title='' curimglist='' from='music_edit' style='left:0px;top:0px;z-index:"+total+";position:absolute;width:200px; height:200px;background-color:#fff'></div>");
				//初始化元素样式				
				 $(add).attr("curimglist",$(this).attr("curimglist"));				
	           //初始化元素内容	          
	           $(add).append($(this).find("img").clone());   
			}
			if(from == "ppt_edit"){
				var add = $("<div id='ppt_"+total+"' class='ppt element active' title='' curimglist='' from='ppt_edit' style='left:0px;top:0px;z-index:"+total+";position:absolute;width:200px; height:200px;background-color:#fff'></div>");
				copyinit(add,$(this));
			}
			if(from == "word_edit"){
				var add = $("<div id='word_"+total+"' class='word element active' title='' curimglist='' from='word_edit' style='left:0px;top:0px;z-index:"+total+";position:absolute;width:200px; height:200px;background-color:#fff'></div>");
				copyinit(add,$(this)); 
			}
			if(from == "excel _edit"){
				var add = $("<div id='excel _"+total+"' class='excel element active' title='' curimglist='' from='excel_edit' style='left:0px;top:0px;z-index:"+total+";position:absolute;width:200px; height:200px;background-color:#fff'></div>");
				//初始化元素样式	
				copyinit(add,$(this));
			}
			
			if(from == "date_edit"){
				var add = $("<div id='date_"+total+"' class='date element active' title='' timetype=8 datestyle=1 from='date_edit' style='font-size:13px;color:rgb(255,255,255);left:0px;top:0px;z-index:"+total+";position:absolute;width:400px; height:100px;background-color:#fff'><div class='op-beijingtime-box c-clearfix'> <p class='op-beijingtime-time op-time' id=''></p><p class='op-beijingtime-datebox op-date' id=''> </p></div></div>");
				//初始化元素样式					
				add.attr("timetype",$(this).attr("timetype"));
				add.css("font-size",$(this).css("font-size"));
				add.css("color",$(this).css("color"));
				add.css("font-weight",$(this).css("font-weight"));
				add.css("font-style",$(this).css("font-style"));
				add.css("text-decoration",$(this).css("text-decoration"));			
	            //初始化元素内容	          
	            $(add).append($(this).find(".op-beijingtime-box").clone());   
			}
					
			 //初始化基本样式
			 $(add).css("width",$(this).css("width"));		
			 $(add).css("height",$(this).css("height"));
			 $(add).css("left",$(this).css("left"));		
			 $(add).css("top",$(this).css("top"));
			 $(add).css("z-index",$(this).css("z-index"));
			 //初始化元素拖拽和放大缩小	  
			 $(add).draggable({containment: ".content-center",scroll: false,  cursor: "move",cancel: "input"});
	       	 $(add).resizable({containment: ".content-center",handles: "n, e, s, w, ne, se, sw, nw"}); 
			 //往场景中添加元素
			 newScene.append(add);
			 if(from == "text_edit"){
				   $(add).append("<textarea id='textarea_fonts_"+total+"' class='selected' style='width:100%;height:100%'></textarea>");
		           var editor = $('#textarea_fonts_'+total).wangEditor({
			     	   'menuConfig': [
			     	          		['fontSize'],
			     	          		['foreColor'],
			     	          		['justify'],
			     	          		['bold'],
			     	          		['underline'],
			     	          		['italic']
			     	          	]
			        });		
		            var html = $(this).find("textarea").val();
		            editor.html(html);
			       	$(".wangEditor-textarea-container").css("height","100%");
			       	$(".wangEditor-textarea").css("height","100%");
			        $(add).find(".wangEditor-textarea").attr("contenteditable",false);
			 }
			 
			 
		});
		$(".element").removeClass("active");
		curelement = null;
		//自动触发场景切换
		newbackg_tpl_item.removeClass("active");		
		newbackg_tpl_item.click();		
		
		
	});

	$(".backg_tpl_item").find(".scene-del").live("click",function(){	
		var hasprev = $(this).parents(".backg_tpl_item").prev().hasClass("backg_tpl_item");
		var hasnext = $(this).parents(".backg_tpl_item").next().hasClass("backg_tpl_item");
		
		if(!hasprev && !hasnext){
			console.log("删除的是第一个也是最后一个");				
			$(".backg_tpl_op").find(".scene-add").click();
			$(".backg_tpl_item").find(".tpl_item_index").text("1");
			
		/* 	$(".backg_tpl_item").eq(0).click(); */
		}else if(!hasnext){
			console.log("删除的是最后一个");
			$(this).parents(".backg_tpl_item").prev().click();
		}else{
			console.log("删除的是中间的");		
			var index = $(this).parents(".backg_tpl_item").find(".tpl_item_index").text();
			$(this).parents(".backg_tpl_item").next().click();
			$(this).parents(".backg_tpl_item").nextAll().each(function(){
				$(this).find(".tpl_item_index").text(index);
				index++;
			});
		}
		$(this).parents(".backg_tpl_item").remove();
		$("#"+$(this).parents(".backg_tpl_item").attr("to")).remove();	
		
		return false;
		
		/* $("#"+$(this).attr("to")).remove();		
		$(this).parents(".backg_tpl_item").remove(); */
		
	});
	$(document).click(function(e){		
		console.log(e);
		if($(e.target).hasClass("content-center") || $(e.target).hasClass("zxxScaleBox")){
			$(".backg_tpl_item.active").click();
			return false;
		}
		e.stopPropagation();
	});
	
	//重做
	/*$(".menu-reset").live("click",function(){
		if(curScene != null){
			curScene.empty();
			$(".delBackImgBtn").click();	
			//清空模板的背景属性
			var index = parseInt(curScene.attr("id").replace(/topfd/,""));		
			$("#tpl_item_"+index).attr("backcolor","");
			$("#tpl_item_"+index).click();
		}
	});*/
	//删除
	$(".menu-del").live("click",function(){
		console.log("hahha");
		if(curelement != null){
			//对不同的元素进行不同的操作	
			var last = false;
			if($(".element").length == 1){
				//删除的是最后一个
				var last = true;
			}
			curelement.remove();
			/*if(last){
				preelement = null;
				curelement = null;
				curScene.click();
			}else{
				if(preelement != null){
					curelement = preelement;
					console.log("preelement");
					console.log(preelement);
					curelement.click();
				}
			}*/
			
			sceneLong();
			curScene.click();
		}
		
	})
	//置顶
	$(".menu-popup").click(function() {
		console.log("置顶");
        var c = curelement.siblings();
        console.log(c);
        d = c.last();
        console.log(d);
        d.after(curelement);
        console.log(c.length);
        curelement.css("zIndex", c.length + 1);
        c.each(function(a, b) {
            $(b).css("zIndex", a + 1);
            console.log( $(b).css("zIndex"));
        });
        
    });
	//置底
	$(".menu-popdown").click(function() {
        var c = curelement.siblings();
        d = c.first();
        d.before(curelement);
        curelement.css("zIndex", 1);
        c.each(function(a, b) {
            $(b).css("zIndex", a + 2);
        });
        
    });
	//上一层
	$(".menu-upper").click(function() {
        var c = curelement.next();
        if (! (c.length <= 0)) {
            var d = curelement.css("zIndex");
            curelement.css("zIndex", c.css("zIndex"));
            c.css("zIndex", d);
            c.after(curelement);
        }
        
    });
	//下一层
	$(".menu-downner").click(function(b) {
        var c = curelement.prev();
        if (! (c.length <= 0)) {
            var d = curelement.css("zIndex");
            curelement.css("zIndex", c.css("zIndex"));
            c.css("zIndex", d);
            c.before(curelement);
        }
        
    });
	

	//左对齐
	$(".menu-left").live("click",function(){
		console.log(widget);
		if(widget.length == 1){
			console.log('widget.length == 1');
			curelement.css("left","0px");
		}else if(widget.length > 1){			
			var left = widget[0].css("left");
			for(v in widget){
				widget[v].css("left",left);
			}		
		}
		
	});
	$(".menu-right").live("click",function(){
		console.log(widget);
		if(widget.length == 1){
			curelement.css("left",(curelement.parent().width() - curelement.width())+"px");
		}else if(widget.length > 1){				
			var pleft1 = parseInt(widget[0].css("left").replace(/px/,"")) + widget[0].width();
			console.log(parseInt(widget[0].css("left").replace(/px/,"")));
			console.log(widget[0].width());
			for(v in widget){			
				if(v > 0){
					var pleft2 = parseInt(widget[v].css("left").replace(/px/,"")) + widget[v].width();
					var left =  pleft1 - pleft2;
					widget[v].css("left",(pleft2+left-widget[v].width())+"px");
				}
				
			}		
		}
		
	});
	$(".menu-top").live("click",function(){
		console.log(widget);
		if(widget.length == 1){
			console.log('widget.length == 1');
			curelement.css("top","0px");
		}else if(widget.length > 1){			
			var top = widget[0].css("top");
			for(v in widget){
				widget[v].css("top",top);
			}		
		}
		
	});
	$(".menu-bottom").live("click",function(){		
		if(widget.length == 1){
			curelement.css("top",(curelement.parent().height() - curelement.height())+"px");
		}else if(widget.length > 1){				
			var ptop1 = parseInt(widget[0].css("top").replace(/px/,"")) + widget[0].height();			
			for(v in widget){			
				if(v > 0){
					var ptop2 = parseInt(widget[v].css("top").replace(/px/,"")) + widget[v].height();
					var top =  ptop1 - ptop2;
					widget[v].css("top",(ptop2+top-widget[v].height())+"px");
				}				
			}		
		}
		
	});
	
	$(".menu-middle").live("click",function(){		
		if(widget.length == 1){
			curelement.css("left",(curelement.parent().width()/2 - curelement.width()/2)+"px");
		}else if(widget.length > 1){				
			var pleft1 = parseInt(widget[0].css("left").replace(/px/,"")) + widget[0].width()/2;			
			for(v in widget){			
				if(v > 0){
					var pleft2 = parseInt(widget[v].css("left").replace(/px/,"")) + widget[v].width()/2;
					var left =  pleft1 - pleft2;
					widget[v].css("left",(pleft2+left-widget[v].width()/2)+"px");
				}				
			}		
		}
		
	});
	$(".menu-center").live("click",function(){		
		if(widget.length == 1){
			curelement.css("top",(curelement.parent().height()/2 - curelement.height()/2)+"px");
		}else if(widget.length > 1){				
			var ptop1 = parseInt(widget[0].css("top").replace(/px/,"")) + widget[0].height()/2;			
			for(v in widget){			
				if(v > 0){
					var ptop2 = parseInt(widget[v].css("top").replace(/px/,"")) + widget[v].height()/2;
					var top =  ptop1 - ptop2;
					widget[v].css("top",(ptop2+top-widget[v].height()/2)+"px");
				}				
			}		
		}
		
	});
	function sortTop(a,b){
		 return a.css("top") - b.css("top");
	}
	$(".menu-topavg").live("click",function(){		
		 if(widget.length >=3){	
			widget.sort(sortTop);
			console.log(widget);
			var toptotal = 0;
			for(var i = 0;i<widget.length-1;i++){
				toptotal= toptotal + (parseInt(widget[i+1].css("top").replace(/px/,""))- (parseInt(widget[i].css("top").replace(/px/,""))+widget[i].height()));
			}	
			console.log('toptotal');
			console.log(toptotal);
			var topavg = parseInt(toptotal/(widget.length-1));		
			console.log('topavg');
			console.log(topavg);
			for(v in widget){			
				if(v > 0 && v < (widget.length-1)){
					console.log("v");
					console.log(v);
					console.log("3333333333333333333");
					var top = topavg + parseInt(widget[v-1].css("top").replace(/px/,""))+widget[v-1].height();
					widget[v].css("top",top+"px");
				}				
			}		
		}
		
	});
	$(".menu-leftavg").live("click",function(){		
		 if(widget.length >=3){	
			widget.sort(sortTop);
			console.log(widget);
			var lefttotal = 0;
			for(var i = 0;i<widget.length-1;i++){
				lefttotal= lefttotal + (parseInt(widget[i+1].css("left").replace(/px/,""))- (parseInt(widget[i].css("left").replace(/px/,""))+widget[i].width()));
			}			
			var leftavg = parseInt(lefttotal/(widget.length-1));	
			for(v in widget){			
				if(v > 0 && v < (widget.length-1)){				
					var left = leftavg + parseInt(widget[v-1].css("left").replace(/px/,""))+widget[v-1].width();
					widget[v].css("left",left+"px");
				}				
			}		
		}
		
	});
	
	/*$(".menu-drawback").live("click",function(){
		
	});*/
	
	
	function scenePreview(obj){
		 console.log("预览");
		 var topdiv = obj;
		 var seecontent="";
		 var content="";	
		 seecontent+="<div id='"+curScene.attr('id')+"' class='content-center-topfd' style='border:1px solid #000;overflow: hidden; position: absolute;left:0px;top:0px;background-image:"+topdiv.css('background-image')+";background-color:"+topdiv.css('background-color')+"; background-size: 100% 100%; background-repeat: no-repeat;width:"+topdiv.css('width')+";height:"+topdiv.css('height')+"'></div>";
		 var div;
	     var left;
	     var top;
	     var width;
	     var height;
	     var key;
	     //图片预览
	     var imgs=topdiv.find(".image");
	     var doimg=false;
	     var tttt;
	     var tadf;
	     var curimglist;
	     var delay;
	     imgs.each(function(){
	    	  div=$(this);
		      left=div.css("left");
		      top=div.css("top");
		      width=div.css("width");
		      height=div.css("height");
		      zIndex = div.css("z-index");
			
			  curimglist = div.attr("curimglist");
			  delay = div.attr("delay");
			  if(curimglist != ""){
				  var curimglistObj = JSON.parse(curimglist);
				  console.log(curimglistObj);	
				  var title = [];
				  if(delay != undefined){
					  title.push(delay);
				  }else{
					  title.push("3");
				  }
				  for(v  in curimglistObj){
					  title.push(curimglistObj[v].src);
				  }
				  console.log(title);
				  if(curimglistObj.length == 1){
					  console.log("静态图");
					  seecontent+="<img class='newimage' style='z-index:"+zIndex+";position: absolute;left:"+left+";top:"+top+";width:"+width+";height:"+height+"'   src='"+curimglistObj[0].src+"'/>"; 
					 
				  }else{
					  console.log("动态轮播图");
					  if(!doimg){						 
						 doimg=true;
						 //根据切换时间参数来设置轮播时间
						/* var duration = delay*1000;*/
						 seecontent+="<script>" +
						 		"var cur=0;" +
						 		"var dorun=false;" +
						 		"var imgs;" +
						 		"var iframes;" +
						 		"var iframe;" +
						 		"var img;" +
						 		"var spis;" +
						 		"setInterval(\"startShow()\",1000);" +
						 		"function startShow() { " +
						 			"if(cur>36000){" +
						 				"cur=0;" +
						 			"}" +
						 			"cur++;" +
						 			"if(!dorun){" +
						 				"dorun=true;" +
						 				"imgs=$(\".newimage\");" +
						 				"iframes=document.getElementsByTagName(\"iframe\");" +
						 			"}" +
						 		   "imgs.each(function(){" +
						 		   		"img=$(this);" +
							 		   	"if(img.attr(\'title\') != undefined){" +
							 		   		"if(img.attr(\'title\').length>0){" +
							 		   			"spis=img.attr(\'title\').split(\',\');" +
							 		   			"if(cur%spis[0]==0){" +
							 		   				"var idc =img.attr(\'id\');idc++;img.attr(\'id\',idc);" +
							 		   				"if(img.attr(\'id\') >= spis.length){" +
							 		   					"img.attr(\'id\',1);" +
							 		   				"}" +
							 		   				"img.attr(\'src\',spis[img.attr(\'id\')]);" +
							 		   			"}" +
							 		   		"}" +
							 		   	"}" +
						 		   "});" +
						 		   "for(var i = 0;i<iframes.length;i++){" +
						 		   		"iframe=iframes[i];" +
						 		   		"if(iframe.title.length>0){" +
					 		   				"if(cur%iframe.title==0){" +
						 		   				"iframe.src=iframe.src;" +
						 		   			"}" +
						 		   		"}" +
						 		   "}" +
						 	"}" +
						 "<\/script>";
						
					   }
					   seecontent+="<img id='1' class='newimage' style='z-index:"+zIndex+";position: absolute;left:"+left+";top:"+top+";width:"+width+";height:"+height+"' title='"+title.join(",")+"' src='"+curimglistObj[0].src+"'/>"; 
					
				  }
			  }
			
	     });	
	     
	     
	     //文本预览
	     var txts=topdiv.find(".font");
	     txts.each(function(){
		  div=$(this);
	      left=div.css("left");
	      top=div.css("top");
	      width=div.css("width");
	      height=div.css("height");
	      zIndex = div.css("z-index");
	      var color = div.css("color");
	      var textalign = div.css("text-align");
	      var fontsize = div.css("font-size");
	      var fontweight = div.css("font-weight");
	      var textdecoration = div.css("text-decoration");
	      var fontstyle = div.css("font-style");
	      var backgroundcolor = div.css("back-groundcolor");
	      var txtanimtype = div.attr("txtanimtype");
	      var content = div.find("textarea").val();	    
	    /*  if(txtanimtype == "none"){*/
	    	  seecontent += "<div id='fonts' style='overflow:hidden;word-break:break-all;width: "+width+"; height:"+height+"; position: absolute; top: "+top+"; left: "+left+"; z-index:"+zIndex+";color: "+color+"; text-align: "+textalign+"; font-size: "+fontsize+"; font-weight: "+fontweight+"; text-decoration: "+textdecoration+"; font-style: "+fontstyle+"; background-color: "+backgroundcolor+";' txtanimtype='"+txtanimtype+"'>";
			  seecontent += content;		 
			  seecontent += "</div>";
	    /*  }else{	    	  
	    	  seecontent += "<marquee scrollAmount=2  direction="+txtanimtype+" style='width: "+width+"; height:"+height+"; position: absolute; top: "+top+"; left: "+left+"; z-index:"+zIndex+";color: "+color+"; text-align: "+textalign+"; font-size: "+fontsize+"; font-weight: "+fontweight+"; text-decoration: "+textdecoration+"; font-style: "+fontstyle+"; background-color: "+backgroundcolor+";' txtanimtype='"+txtanimtype+"'>";
			  seecontent += content;		
			  seecontent += "</marquee>";
	      }*/
		  if(txtanimtype != "none"){
			  seecontent +='<script>$("#fonts").marquee({direction: "'+txtanimtype+'",}); </script>';
		  }
		
	   });  
	    //视频预览 
	    var videos=topdiv.find(".video");
	    videos.each(function(){
	    	if($(this).attr("curimglist") != ""){
	    		div=$(this);
		    	left=div.css("left");
	      	    top=div.css("top");
	      	    width=div.css("width");
	      	    height=div.css("height");
	      	    var curimglist = JSON.parse(div.attr("curimglist"));
	      	    var playlistArr = [];
	      	    for(v in curimglist){
	      	    	console.log()
	      	    	playlistArr.push(curimglist[v].source);	      	  
	      	    }	      	    
	      	    console.log(playlistArr);
	      	    var playlistStr = playlistArr.join(',');
	      	    console.log(playlistStr);
				seecontent+="<a href='"+$curImgList[0].source+"' playlistStr='"+playlistStr+"' class='player' id='player"+$(this).index()+"' style='position: absolute;z-index:11;left:"+left+";top:"+top+";width:"+width+";height:"+height+"'></a>";
	  	    
	    	}
	    	
		
	    })
		 //音频预览    
	      var musics=topdiv.find(".music");
	      musics.each(function(){
	    	if($(this).attr("curimglist") != ""){
	    		div=$(this);
		    	left=div.css("left");
	      	    top=div.css("top");
	      	    width=div.css("width");
	      	    height=div.css("height");
	      	    var curimglist = JSON.parse(div.attr("curimglist"));
	      	    var playlistArr = [];
	      	    for(v in curimglist){
	      	    	console.log("");
	      	    	playlistArr.push(curimglist[v].source);	
	      	    	var index = parseInt(v)+1;
	      	    	seecontent+='<div id="amazingaudioplayer-'+index+'" style="display:block;position:absolute;width:300px;height:auto;margin:0px auto 0px;visibility:hidden" class="amazingaudioplayer">'+
				       ' <ul class="amazingaudioplayer-audios" style="display:none;">'+
				           ' <li data-artist="CNBLUE" data-title="'+curimglist[v].name+'" data-album="'+curimglist[v].name+'" data-info="" data-image="" data-duration="238">'+
				             '<div class="amazingaudioplayer-source" data-src="'+curimglist[v].source+'" data-type="audio/mpeg" /> '+
				         '</li>'+
				       '</ul>'+
				   ' </div>';
	      	    	
	      	     }
	    	}
		
	    });
	      
	    //ppt预览    
	      var ppts=topdiv.find(".ppt");
	      ppts.each(function(){
	    	if($(this).attr("curimglist") != ""){
	    		div=$(this);
		    	left=div.css("left");
	      	    top=div.css("top");
	      	    width=div.css("width");
	      	    height=div.css("height");
	      	    var zIndex =div.css("z-index");
	      	    var curimglist = div.attr("curimglist");	      	    
	      	    var curimglistObj = JSON.parse(curimglist);
	      	    var delay = div.attr("delay");
	      	    var title = [];
			    if(delay != undefined){
				  title.push(delay);
			    }else{
				  title.push("3");
			    }
			    for(v in curimglistObj){
			    	 var imglist = curimglistObj[v].imglist.substr(1,curimglistObj[v].imglist.length-2);
					 title.push(imglist);
			    }
	      	    seecontent += "<img id='1' class='newimage' style='z-index:"+zIndex+";position: absolute;left:"+left+";top:"+top+";width:"+width+";height:"+height+"' title='"+title.join(",")+"' src='"+curimglistObj[0].src+"'/>"; 
		    }		
	    });
	      
	    //天气预览    
	      var weathers=topdiv.find(".weather");
	      weathers.each(function(){	  
	    		div=$(this);
		    	left=div.css("left");
	      	    top=div.css("top");
	      	    width=div.css("width");
	      	    height=div.css("height");
	      	   var zIndex =div.css("z-index");	      	   
	      	   seecontent+='<iframe scrolling="no" height="60" frameborder="0" allowtransparency="true" src="'+$(this).find("iframe").eq(0).attr("src")+'" style="left:'+left+';top:'+top+';z-index:'+zIndex+';position:absolute;width:'+width+'; height:'+height+';background-color:#fff"></iframe>';
	    });
	    
	      	      
	      //日期预览    
	      var dates=topdiv.find(".date");
	      dates.each(function(){	  
    		div=$(this);
	    	left=div.css("left");
      	    top=div.css("top");
      	    width=div.css("width");
      	    height=div.css("height");
	      	var zIndex =div.css("z-index");	
	      	var fontSize =div.css("font-size");
	      	var fontSize55 = (parseInt(fontSize.replace(/px/,""))+42)+"px";
	      	var fontSize30 = (parseInt(fontSize.replace(/px/,""))+17)+"px";
	    	var fontSize20 = (parseInt(fontSize.replace(/px/,""))+7)+"px";
	    	var color = div.css("color");
	    	console.log(color);
	      	var bold =div.css("font-weight");    
	      	var italic = div.css("font-style"); 
	      	var underline = div.css("text-decoration");
	      	var timetype = div.attr("timetype");
	      	seecontent+="<div id='date"+zIndex+"' class='date element' title='' timetype=8 datestyle=1 style='left:"+left+";top:"+top+";z-index:"+zIndex+";position:absolute;width:"+width+"; height:"+height+";font-size:"+fontSize+";color:"+color+";font-weight:"+bold+";font-style:"+italic+";text-decoration:"+underline+";'><div class='op-beijingtime-box c-clearfix'> <p class='op-beijingtime-time op-time' id=''></p><p class='op-beijingtime-datebox op-date' id=''> </p></div></div>";
	      	seecontent+='<script>getTime('+timetype+',$("#date'+zIndex+'"));$("#date'+zIndex+'").find(".op-beijingtime-box").css("color","'+color+'");	$("#date'+zIndex+'").find(".op-beijingtime-time").css("font-size","'+fontSize55+'"); 	$("#date'+zIndex+'").find(".op-beijingtime-small").css("font-size","'+fontSize30+'");	$("#date'+zIndex+'").find(".op-beijingtime-week").css("font-size","'+fontSize20+'");</script>';
	      }); 
	      //word预览    
	      var words=topdiv.find(".word");
	      words.each(function(){	  
	    	if($(this).attr("curimglist") != ""){
	    		div=$(this);
		    	left=div.css("left");
	      	    top=div.css("top");
	      	    width=div.css("width");
	      	    height=div.css("height");
		      	var zIndex =div.css("z-index");	
		      	var curimglist = div.attr("curimglist");	      	    
	      	    var curimglistObj = JSON.parse(curimglist);
	      	    var delay = div.attr("delay")?div.attr("delay"):20;
		      	seecontent+="<div id='word"+zIndex+"' class='word' style='left:"+left+";top:"+top+";z-index:"+zIndex+";position:absolute;width:"+width+"; height:"+height+";'><div style='margin-right:-17px;'>";
		      	
			    for(v in curimglistObj){
			    	 var iframelist = curimglistObj[v].htmlurl;
			    	 seecontent+='<iframe id="word'+zIndex+'-ifr'+v+'" src="'+iframelist+'" frameborder="0" width="100%" style=""></iframe>';
			    }
		      	seecontent+='</div></div>';
		      	
		      	seecontent+=' <script> $(function(){'+
		        	'var i = 0;'+
		        	'var ifr = document.getElementById("word'+zIndex+'-ifr"+i);'+
		        	' ifr.onload = function(){'+
		        	'	var iDoc = ifr.contentDocument || ifr.document;'+
		        	' var height = calcPageHeight(iDoc);'+
		        	'ifr.style.height = height + "px";'+
		        	'testifr(i);'+
		        	' }; '+
			  
		        	' function testifr(i){'+
		        	'console.log(i);	i++;'+
		        	'  if(i < '+curimglistObj.length+'){'+
		        	'console.log("多个");console.log(i);var ifr = document.getElementById("word'+zIndex+'-ifr"+i);'+
		        	'ifr.onload = function(){'+
		        	'var iDoc = ifr.contentDocument || ifr.document;'+
		        	'   var height = calcPageHeight(iDoc);'+
		        	'   ifr.style.height = height + "px"; 	'+	                	
		        	' testifr(i);'+
		        	' };'+
		        	'}else{'+
		        	'  console.log("index-------"+i);console.log("要初始化了");$("#word'+zIndex+'").kxbdSuperMarquee({'+
		        	' isMarquee:true,'+
		        	' isEqual:false,'+
		        	' scrollDelay:'+delay+',	'+	
		        	' direction:"up"'+
		        	'  }); '+
		        	' }'+
		        	'   }'+
		        	' });</script> ';
	    	}
	      }); 
	      
	      //excel预览    
	      var excels=topdiv.find(".excel");
	      excels.each(function(){	  
	    	if($(this).attr("curimglist") != ""){
	    		div=$(this);
		    	left=div.css("left");
	      	    top=div.css("top");
	      	    width=div.css("width");
	      	    height=div.css("height");
		      	var zIndex =div.css("z-index");	
		      	var curimglist = div.attr("curimglist");	      	    
	      	    var curimglistObj = JSON.parse(curimglist);
	      	    var delay = div.attr("delay")?div.attr("delay"):20;
		      	seecontent+="<div id='excel"+zIndex+"' class='excel' style='left:"+left+";top:"+top+";z-index:"+zIndex+";position:absolute;width:"+width+"; height:"+height+";'><div>";
		      	
			    for(v in curimglistObj){
			    	 var iframelist = curimglistObj[v].htmlurl;
			    	 seecontent+='<iframe id="excel'+zIndex+'-ifr'+v+'" src="'+iframelist+'" frameborder="0" width="100%" style=""></iframe>';
			    }
		      	seecontent+='</div></div>';
		      	
		      	seecontent+=' <script> $(function(){'+
		        	'var i = 0;'+
		        	'var ifr = document.getElementById("excel'+zIndex+'-ifr"+i);'+
		        	' ifr.onload = function(){'+
		        	'	var iDoc = ifr.contentDocument || ifr.document;'+
		        	' var height = calcPageHeight(iDoc);'+
		        	'ifr.style.height = height + "px";'+
		        	'testifr(i);'+
		        	' }; '+
			  
		        	' function testifr(i){'+
		        	'console.log(i);	i++;'+
		        	'  if(i < '+curimglistObj.length+'){'+
		        	'console.log("多个");console.log(i);var ifr = document.getElementById("excel'+zIndex+'-ifr"+i);'+
		        	'ifr.onload = function(){'+
		        	'var iDoc = ifr.contentDocument || ifr.document;'+
		        	'   var height = calcPageHeight(iDoc);'+
		        	'   ifr.style.height = height + "px"; 	'+	                	
		        	' testifr(i);'+
		        	' };'+
		        	'}else{'+
		        	'  console.log("index-------"+i);console.log("要初始化了");$("#excel'+zIndex+'").kxbdSuperMarquee({'+
		        	' isMarquee:true,'+
		        	' isEqual:false,'+
		        	' scrollDelay:'+delay+',	'+	
		        	' direction:"up"'+
		        	'  }); '+
		        	' }'+
		        	'   }'+
		        	' });</script> ';
	    	}
	      });
	   return seecontent;
	}
	//点击预览
	$(".menu-preview").live("click",function(){
		 var html = scenePreview(curScene);	     	
	     $("#dom").val(html);
	     $("#previewForm").submit();	    
		/* $("body").append(seecontent);*/
	   /*  console.log("");
		 seecontent="";*/
	});
	
	//组装元素的函数
	function epush(jsonobj,typeobj){
		for(v in jsonobj){			
			typeobj.push(jsonobj[v].attrid);
		}
	}
	function uni(arrobj){		
		arrobj.filter(function(v,i) { return arrobj.indexOf(v) == i; });
	}
	$(".menu-save").live("click",function(){
		//遍历生成各个场景的预览和界面html文件		
		var terminalJSON = {
				images:[],
				video:[],
				music:[],
				html:[],
				playTimeall:0
				
		};
		$(".content-center-topfd").each(function(){
			
			var sceneTime = $(this).attr("long");
			terminalJSON.playTimeall += sceneTime;
			//节目总时长
			 var timePlay = $('<input name="playTime" type="text" hidden>');
			 $("#saveForm").append(timePlay);
			 timePlay.val(terminalJSON.playTimeall);
			//应用服务器上保存的预览文件
			 var html = scenePreview($(this));	
			 var htmlInput = $('<input name="htmlInput" type="text" hidden>');
			 $("#saveForm").append(htmlInput);
			 htmlInput.val(html);
			 console.log( htmlInput.val());
			 //广告机终端上预览的文件 需要替换资源路径
			 var terminalHtml = html.replace(/http:\/\/localhost:8080\/apm-web\/apm_file\/back_img_path/g,"../images")
			 .replace(/\/apm-web\/apm_file\/img_path/g,"../images")
			 .replace(/\/apm-web\/apm_file\/program_video_path/g,"../video")
			 .replace(/\/apm-web\/apm_file\/music_path/g,"../music")
			 .replace(/\/apm-web\/apm_file\/ppt_img_path/g,"../images")
			 .replace(/\/apm-web\/apm_file\/word_html_path/g,"../word") //路径可能需要修改
			 .replace(/\/apm-web\/apm_file\/excel_html_path/g,"../excel");			
			 var terminalInput = $('<input name="terminalInput" type="text" hidden>');
			 $("#saveForm").append(terminalInput);
			 terminalInput.val(terminalHtml);
			 console.log( terminalInput.val());
			 //组装背景图片attid
		/*	 console.log("组装场景图片attrid");
			 console.log($(this).attr("attrid"));*/
			 if($(this).attr("attrid") != undefined && $(this).attr("attrid") != ""){
				 terminalJSON.images.push($(this).attr("attrid"));
				 
			 }
		});
		
		//组装元素element attrid
		$(".element").each(function(){
			var curimglist =$(this).attr("curimglist"); 
			var from =$(this).attr("from"); 
			if(curimglist != undefined && curimglist !="" && curimglist !=null){
				curimglist = JSON.parse(curimglist);
				
				switch(from){
					case "img_edit":
						console.log(curimglist);
						epush(curimglist,terminalJSON.images);
						break;
					case "video_edit":
						epush(curimglist,terminalJSON.video);
						break;
					case "music_edit":
						epush(curimglist,terminalJSON.music);
						break;
					case "ppt_edit":
						epush(curimglist,terminalJSON.images);
						break;
					case "word_edit":
						epush(curimglist,terminalJSON.html);
						break;
					case "excel_edit":
						epush(curimglist,terminalJSON.html);
						break;
				}
				
			}
		})
		
		 //除去重复id 取唯一值
		 terminalJSON.images = terminalJSON.images.filter(function(v,i) { return terminalJSON.images.indexOf(v) == i; });
		 terminalJSON.video = terminalJSON.video.filter(function(v,i) { return terminalJSON.video.indexOf(v) == i; });
		 terminalJSON.music = terminalJSON.music.filter(function(v,i) { return terminalJSON.music.indexOf(v) == i; });	
		 terminalJSON.html = terminalJSON.html.filter(function(v,i) { return terminalJSON.html.indexOf(v) == i; });
	
		 console.log(terminalJSON);
		 var tJHtml = JSON.stringify(terminalJSON);
		 var tJH = $('<input name="terminalJH" type="hidden">');
		 $("#saveForm").append(tJH);
		 tJH.val(tJHtml);
		 console.log(tJH.val());
		 
		//保存当前编辑页面
		$("#editHtml").val($("body").html());	
		$("#saveForm").submit();
	})
	
	//视频上传
	 $("#videoUpload").webuploader({
		 initPicker: "videoUpload", 
		 pickNum: false, //视频上传限制为一个
		 ctx: pUrl,
	     folderName:"program_video_path",
	     simpleAuto: true, //简单自动上传
	     uploadAuto: true, //自动上传
	     chunked:true,//是否分片上传
	     chunkSize:5242880,//分片尺寸,5兆
		 extenName: "mp4,avi,flv,f4v,MPG,ts", //上传格式  
		 uploadType: false,
	 });
	 
	 //背景图片上传
	  $("#backUpload").webuploader({
		 initPicker: "backUpload", 
		 ctx: pUrl,
	     folderName:"back_img_path",
	     simpleAuto: true, //简单自动上传
	     uploadAuto: true, //自动上传
	     chunked:true,//是否分片上传
	     chunkSize:2097152,//分片尺寸,2兆
		 extenName: "png,bmp,pict,jpeg,xbm,tga,psd,xpm,pcx,ico,jpg", //上传格式  
		 uploadType: false,
	 });

	  //图片上传
	   $("#imgUpload").webuploader({
		 initPicker: "imgUpload", 
		 ctx: pUrl,
	     folderName:"img_path",
	     simpleAuto: true, //简单自动上传
	     uploadAuto: true, //自动上传
	     chunked:true,//是否分片上传
	     chunkSize:2097152,//分片尺寸,2兆
		 extenName: "png,bmp,pict,jpeg,xbm,tga,psd,xpm,pcx,ico,jpg", //上传格式  
		 uploadType: false,
	 });

	  //ppt上传
	  $("#pptUpload").webuploader({
	  	 initPicker: "pptUpload", 
		 ctx: pUrl,
	     folderName:"ppt_path",
	     simpleAuto: true, //简单自动上传
	     uploadAuto: true, //自动上传
	     chunked:true,//是否分片上传
	     chunkSize:2097152,//分片尺寸,2兆
		 extenName: "ppt,pptx", //上传格式  
		 uploadType: false,
	  });

	  //word上传
	  $("#wordUpload").webuploader({
	  	 initPicker: "wordUpload", 
		 ctx: pUrl,
	     folderName:"word_path",
	     simpleAuto: true, //简单自动上传
	     uploadAuto: true, //自动上传
	     chunked:true,//是否分片上传
	     chunkSize:2097152,//分片尺寸,2兆
		 extenName: "doc,docx", //上传格式  
		 uploadType: false,
	  });

	  //excel上传
	  $("#excelUpload").webuploader({
	  	 initPicker: "excelUpload", 
		 ctx: pUrl,
	     folderName:"excel_path",
	     simpleAuto: true, //简单自动上传
	     uploadAuto: true, //自动上传
	     chunked:true,//是否分片上传
	     chunkSize:2097152,//分片尺寸,2兆
		 extenName: "xls,xlsx", //上传格式  
		 uploadType: false,
	  });

	  //音乐上传
	  $("#musicUpload").webuploader({
	  	 initPicker: "musicUpload", 
		 ctx: pUrl,
	     folderName:"music_path",
	     simpleAuto: true, //简单自动上传
	     uploadAuto: true, //自动上传
	     chunked:true,//是否分片上传
	     chunkSize:2097152,//分片尺寸,2兆
		 extenName: "mp3,wma,mpeg,wave", //上传格式  
		 uploadType: false,
	  });
	  
	  //database 
	  $(".material-left .material-type").live("click",function(){
		  if(!$(this).hasClass("active")){
			  console.log("hahahh");
			  $(this).addClass("active").siblings().removeClass("active");
		  }
	  });
	  $('[data-toggle="tooltip"]').tooltip();
	  
});

//上传文件成功之后的处理方法
function getFileDetail(fileId, fileName, file_id){
	console.log(fileId + "       "+ fileName + "            "+ file_id);	
	$.ajax({
		url:pUrl+"/fileInfosa/getFile",
   		type:'post',
   		dataType:'text',
   		data:{"fileId": fileId},
   		success: function(data){
   			console.log(data);
   			//从后台得到的数据转成json格式
   			if(data != null && data != ""){
   				var obj = $.parseJSON(data);
	   			console.log(obj);
	   			//截取时间
	   			var ymd = obj.file.updateDate.split(" ")[0];
	   			//视频上传
	   			if(obj.flag == "program_video_path"){
	   				var divHtml = "<div class='ovh material-item videomodal-m-i'><img class='pull-left' src='"+obj.imgPath+"' alt="+obj.file.name+" source="+obj.file.path+" long="+obj.file.note+"><div class='pull-left'><span class='videoname ellipsis'>"+obj.file.name+"</span><span>"+obj.file.size+"</span><span>"+ymd+"</span></div></div>"
	   				$("#videoModal .material-mainer").prepend(divHtml);
	   			}
	   			//背景图片上传
	   			if(obj.flag == "back_img_path"){
	   				 var divHtml = "<div class='material-item col-sm-6 col-md-4 backmodal-m-i'><div class='thumbnail'><img src="+obj.file.path+" alt="+obj.file.name+"/><div class='caption'><h3 class='ellipsis'>"+obj.file.name+"</h3></div></div></div>";
	   				 $("#backModal .row").prepend(divHtml);
	   			}
	   			//图片上传
	   			if(obj.flag == "img_path"){
	   				 var divHtml = "<div class='col-sm-6 col-md-4 imgmodal-m-i'><div class='thumbnail'><img src="+obj.file.path+" alt="+obj.file.name+"/><div class='caption'><h3 class='ellipsis'>"+obj.file.name+"</h3></div></div></div>";
	   				 $("#imgModal .row").prepend(divHtml);
	   			}
	   			//ppt上传
	   			if(obj.flag == "ppt_path"){
	   				var divHtml = "<div class='material-item row pptmodal-m-i'><span class='col-md-5 ellipsis'><img src='/apm-web/static/images/program/www.png' alt=''>"+obj.file.name+"</span><span class='col-md-2'>"+obj.file.note+"</span><span class='col-md-2'>"+obj.file.size+"</span><span class='col-md-3'>"+ymd+"</span></div>";
	   				$("#pptModal .top-span").after(divHtml);
	   			}
	   			//word上传
	   			if(obj.flag == "word_path"){
	   				var divHtml = "<div class='material-item row wordmodal-m-i'><span class='col-md-5 ellipsis'><img src='/apm-web/static/images/program/testimg1.png' alt=''>"+obj.file.name+"</span><span class='col-md-2'>"+obj.file.size+"</span><span class='col-md-2'>"+obj.file.size+"</span><span class='col-md-3'>"+ymd+"</span></div>";
	   				$("#wordModal .top-span").after(divHtml);
	   			}
	   			//excel上传
	   			if(obj.flag == "excel_path"){
	   				var divHtml = "<div class='material-item row excelmodal-m-i'><span class='col-md-5 ellipsis'><img src='/apm-web/static/images/program/testimg1.png' alt=''>"+obj.file.name+"</span><span class='col-md-2'>"+obj.file.size+"</span><span class='col-md-2'>"+obj.file.size+"</span><span class='col-md-3'>"+ymd+"</span></div>";
	   				$("#excelModal .top-span").after(divHtml);
	   			}
	   			//音乐上传
	   			if(obj.flag == "music_path"){
	   				var divHtml = "<div class='material-item row musicmodal-m-i'><span class='col-md-5 ellipsis'><img src='"+obj.imgPath+"' alt="+obj.file.name+" source="+obj.file.path+" long="+obj.file.note+">"+obj.file.name+"</span><span class='col-md-2'>"+obj.file.note+"</span><span class='col-md-2'>"+obj.file.size+"</span><span class='col-md-3'>"+ymd+"</span></div>";
	   				$("#musicModal .top-span").after(divHtml);
	   			}
   			}
   		},error: function(data){
   			alert("服务器出错!");
   		}
	});
}

/**
 * 根据时区获取相应的时间
 * @author hutia
 * @param {Date} date 日期时间对象
 * @param {number} timezone 时区
 * @return {string} 返回时间字符串
 */
function getTimeString(date, timezone){
    var tz = date.getTimezoneOffset();
    var dt = new Date();
    dt.setTime(date.getTime() + tz*60000 + timezone*3600000);
   /* var month = dt.getMonth() + 1;
    return  dt.getFullYear() + "-" +  format(month) + "-" + format(dt.getDate()) + " " + format(dt.getHours()) + ':' + format(dt.getMinutes()) + ':' + format(dt.getSeconds());
    function format(n) {
        if (n < 10) return '0' + n;
        return ''+n;
    }*/
    
    return dt;
}

//获取选定后的时间
function getTime(obj){
	console.log($(obj).val());
	console.log(getTimeString(new Date(), $(obj).val()));	
	curelement.attr("timeType",$(obj).val()); 
	window.baidu_time(getTimeString(new Date(), $(obj).val()).getTime(),curScene);	
}

//验证RSS是否合格
function validRss(){
	var site = $("#rssSite").val();
	if(site.trim().length < 1){
		alert("请填写地址");
		return ;
	}
	$.ajax({
		url: pUrl + '/program/rssValid',
		type: 'post',
		dataType: "text",
		data: {"site": site},
		success: function(data){
			console.log(data)
			if(data != "true"){
				alert("非法路径!");
			}
		},error: function(data){
			/* Act on the event */
			alert("服务器出错!");
		}
	})
}
