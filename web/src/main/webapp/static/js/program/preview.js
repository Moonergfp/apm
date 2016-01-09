

/* 计算页面的实际高度，iframe自适应会用到*/
function calcPageHeight(doc) {
 /*   console.log($(doc.body).html());	 
   $("#testdiv").append($($(doc.body).html())); */
    var cHeight = Math.max(doc.body.clientHeight, doc.documentElement.clientHeight);
    var sHeight = Math.max(doc.body.scrollHeight, doc.documentElement.scrollHeight);
    var height  = Math.max(cHeight, sHeight);
    return height;
}
$(".player").each(function(){	  		 
	  var playlistArr = $(this).attr("playlistStr").split(",");
	  flowplayer($(this).attr("id"), "/apm-web/static/flowplayer_flash/flowplayer-3.2.18.swf",{
		  loop: true,
		  playlist: playlistArr,
		  clip: { 	
			    scaling: 'fit', 
		        autoPlay: true,  
		        autoBuffering: true,
		        linkUrl:'',//加一个无动作的链接
		        onBegin: function () { this.getPlugin("play").click().hide(); } //隐藏按钮
		  },
		 plugins:{	controls:{	playlist:true	}}
	  })
});

jQuery(document).ready(function(){

    var scripts = document.getElementsByTagName("script");

    var jsFolder = "";

    for (var i= 0; i< scripts.length; i++)

    {

        if( scripts[i].src && scripts[i].src.match(/initaudioplayer-1\.js/i))

            jsFolder = scripts[i].src.substr(0, scripts[i].src.lastIndexOf("/") + 1);

    }
    
    
    for(var i=0;i < $(".amazingaudioplayer").length;i++){
    	var objId = $(".amazingaudioplayer").eq(i).attr("id");
    	console.log(objId);
    	  jQuery("#"+objId).amazingaudioplayer({
   	        jsfolder:jsFolder,
   	        skinsfoldername:"",
   	        titleinbarwidthmode:"fixed",
   	        timeformatlive:"%CURRENT% / LIVE",
   	        volumeimagewidth:24,
   	        barbackgroundimage:"",
   	        tracklistarrowimageheight:16,
   	        showtime:true,
   	        titleinbarwidth:80,
   	        showprogress:true,
   	        random:false,
   	        titleformat:"%TITLE%",
   	        height:600,
   	        loadingformat:"Loading...",
   	        prevnextimage:"prevnext-24-24-0.png",
   	        showinfo:false,
   	        imageheight:100,
   	        skin:"Bar",
   	        loopimage:"loop-24-24-0.png",
   	        loopimagewidth:24,
   	        showstop:false,
   	        prevnextimageheight:24,
   	        infoformat:"By %ARTIST% %ALBUM%<br />%INFO%",
   	        showloading:false,
   	        volumebarheight:80,
   	        tracklistarrowimagewidth:48,
   	        imagefullwidth:false,
   	        skinsfoldername:"",
   	        width:300,
   	        showimage:false,
   	        showtracklist:false,
   	        volumeimage:"volume-24-24-0.png",
   	        playpauseimagewidth:24,
   	        loopimageheight:24,
   	        tracklistitemformat:"%ID%. %TITLE% <span style='position:absolute;top:0;right:0;'>%DURATION%</span>",
   	        prevnextimagewidth:24,
   	        tracklistarrowimage:"tracklistarrow-48-16-0.png",
   	        playpauseimageheight:24,
   	        showbackgroundimage:false,
   	        imagewidth:100,
   	        stopimage:"stop-24-24-0.png",
   	        showvolume:true,
   	        playpauseimage:"playpause-24-24-0.png",
   	        showprevnext:true,
   	        backgroundimage:"",
   	        volumebarpadding:8,
   	        progressheight:8,
   	        showtracklistbackgroundimage:false,
   	        showtitle:false,
   	        showtitleinbar:false,
   	        heightmode:"auto",
   	        titleinbarformat:"%TITLE%",
   	        stopimageheight:24,
   	        stopimagewidth:24,
   	        fullwidth:false,
   	        tracklistbackgroundimage:"",
   	        showloop:true,
   	        showbarbackgroundimage:false,
   	        volumeimageheight:24,
   	        timeformat:"%CURRENT% / %DURATION%",
   	        autoplay:true,
   	        showvolumebar:true,
   	        loop:0,
   	        tracklistitem:10
   	    });
    }
});
var cur=0;var dorun=false;var imgs;var iframes;var iframe;var img;var spis;setInterval("startShow()",1000);function startShow() { if(cur>36000){cur=0;}cur++;if(!dorun){dorun=true;imgs=$(".newimage");iframes=document.getElementsByTagName("iframe");}imgs.each(function(){img=$(this);if(img.attr('title') != undefined){if(img.attr('title').length>0){spis=img.attr('title').split(',');if(cur%spis[0]==0){var idc =img.attr('id');idc++;img.attr('id',idc);if(img.attr('id') >= spis.length){img.attr('id',1);}img.attr('src',spis[img.attr('id')]);}}}});for(var i = 0;i<iframes.length;i++){iframe=iframes[i];if(iframe.title.length>0){if(cur%iframe.title==0){iframe.src=iframe.src;}}}}
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