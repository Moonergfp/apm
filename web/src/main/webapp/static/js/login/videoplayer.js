!function(f){function d(){var a="",b=navigator;if(b.plugins&&b.plugins.length){for(var c=0;c<b.plugins.length;c++){if(-1!=b.plugins[c].name.indexOf("Shockwave Flash")){a=b.plugins[c].description.split("Shockwave Flash ")[1],a=a.split(" ").join(".");break}}}else{if(window.ActiveXObject){var i=new ActiveXObject("ShockwaveFlash.ShockwaveFlash");i&&(a=i.GetVariable("$version").toLowerCase(),a=a.split("win ")[1],a=a.split(",").join("."))}}return a}function e(b,i,l){function n(g){return b.replace(l||/\\?\{([^}]+)\}/g,function(h,j){return"\\"==h.charAt(0)?h.slice(1):void 0!=g[j]?g[j]:""})}"[object Array]"!==Object.prototype.toString.call(i)&&(i=[i]);for(var a=[],o=0,c=i.length;c>o;o++){a.push(n(i[o]))}return a.join("")}f.NTES_createVideo||(f.NTES_createVideo=function(b,n){var m="";for(var c in b){if(c=="width"||c=="height"||c=="url_mp4"){continue}m+=c+"="+b[c]+"&"}m=m.substring(0,m.length-1);var a,o='<embed src="http://v.163.com/swf/video/NetEaseFlvPlayerV3.swf" flashvars="'+m+'" allowFullScreen="true" allowScriptAccess="always" quality="high" width="{width}" height="{height}" {vars} allowScriptAccess="always" type="application/x-shockwave-flash"></embed>',l=['<video width="{width}" height="{height}" controls {autoplay} preload="auto" {vars}>','<source src="{url_mp4}" type="video/mp4">',"\u60a8\u7684\u6d4f\u89c8\u5668\u6682\u65f6\u65e0\u6cd5\u64ad\u653e\u6b64\u89c6\u9891.","</video>"].join("");d()?a=o:(a=l,b.autoplay=b.autoplay?"autoplay":""),n.innerHTML=e(a,b),n.style.width=b.width+("100%"==b.width?"":"px"),n.style.height=b.height+("100%"==b.height?"":"px")})}(window);
