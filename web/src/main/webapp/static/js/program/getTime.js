	(function(){
		var week = '日一二三四五六';
		var innerHtml = '{0}:{1}:{2}';
		var dateHtml = "{0}月{1}日 &nbsp;星期{2}";
		var timer = 0;
		var beijingTimeZone = 8;
		
		function format(str, json){
			return str.replace(/{(\d)}/g, function(a, key) {
				return json[key];
			});
		}
		
		function p(s) {
			return s < 10 ? '0' + s : s;
		}
		
		window.baidu_time = function(time,obj){
			console.log("window.baidu_time");
			console.log(obj);
			initTime = time;
			show(time,obj);
			clearTimeout(timer);
			timer = setInterval(function(){
				time += 1000;
				show(time,obj);
			}, 1000);
			
		}
		
		function show(time,obj){				
			var timeOffset = ((-1 * (new Date()).getTimezoneOffset()) - (beijingTimeZone * 60)) * 60000;
			var now = new Date(time - timeOffset);
			obj.find('.op-time').html( p(now.getHours())+'<span>:</span>'+p(now.getMinutes())+'<span class="op-beijingtime-small c-gap-left">'+p(now.getSeconds())+'</span>');
			obj.find('.op-date').html( '<span class="op-beijingtime-week">星期'+week.charAt(now.getDay())+'</span><span class="op-beijingtime-date">'+p((now.getFullYear()))+'年'+p((now.getMonth()+1))+'月'+p(now.getDate())+'日</span>' );
			var fontSize55;var fontSize30;var fontSize20;
			
			if(obj.find(".element").length){
				fontSize55 = parseInt(obj.find(".element").css("font-size").replace(/px/,""));
				 fontSize30 = parseInt(obj.find(".element").css("font-size").replace(/px/,""));
			    fontSize20 = parseInt(obj.find(".element").css("font-size").replace(/px/,""));
			}else if(obj.hasClass(".element")){
				fontSize55 = parseInt(obj.css("font-size").replace(/px/,""));
				 fontSize30 = parseInt(obj.css("font-size").replace(/px/,""));
			    fontSize20 = parseInt(obj.css("font-size").replace(/px/,""));
			}
			
			fontSize55 = (fontSize55+42)+"px";
	      	fontSize30 = (fontSize30+17)+"px";
	    	fontSize20 = (fontSize20+7)+"px";
	    	obj.find('.op-time').find(".op-beijingtime-time").css("font-size",fontSize55);
	    	obj.find('.op-time').find(".op-beijingtime-small").css("font-size",fontSize30);
	    	obj.find('.op-date').find(".op-beijingtime-week").css("font-size",fontSize20);				
			
		}
		function init(){
			var elm = document.createElement('SCRIPT');
			elm.src = 'http://open.baidu.com/app?module=beijingtime&t=' + new Date().getTime();
			document.getElementsByTagName('HEAD')[0].appendChild(elm);
			setTimeout(function(){init()}, 60000);
		}
		
		
})();