document.domain="tianqi.com";
$id=function(id){return "string"==typeof id ? document.getElementById(id):id}
function loadJS(a,d){var b=document.body.appendChild(document.createElement("script"));d="utf-8"||d;b.language="javascript";b.charset=d;b.src=a;return b;}
function setHomePage(obj,homepage){if (document.all){document.body.style.behavior='url(#default#homepage)';document.body.setHomePage(homepage);}else if (window.sidebar){if(window.netscape){try{netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");}catch(e){alert("您的firefox安全限制限制您进行剪贴板操作，请在浏览器地址栏输入’about:config’并回车，然后将’signed.applets.codebase_principal_support’设置为’true’之后重试。");return;}};var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch);prefs.setCharPref('browser.startup.homepage',homepage);}}
function SetCookie(c,e,a,f,d){if(typeof(a) == 'undefined')a=365;var b=new Date();b.setDate(b.getDate()+a);a=b.toGMTString();f="/";d=".tianqi.com";document.cookie=c+"="+escape(e)+("; expires="+a)+("; path="+f)+("; domain="+d)+";"}
function getCookie(a){var b=a+"=";var c="";if(document.cookie.length>0){offset=document.cookie.lastIndexOf(b);if(offset!=-1){offset+=b.length;end=document.cookie.indexOf(";",offset);if(end==-1){end=document.cookie.length}c=unescape(document.cookie.substring(offset,end))}}return c};
function addFav(sURL, sTitle){var ua = navigator.userAgent.toLowerCase();if(ua.indexOf("msie 8")>-1){external.AddToFavoritesBar(sURL,sTitle,'实用工具');}else{try{window.external.addFavorite(sURL, sTitle);} catch(e){try{window.sidebar.addPanel(sTitle, sURL, "");} catch(e){alert("加入收藏失败，请使用Ctrl+D进行添加");}}}}
copyToClipboard=function(id){
	if(document.getElementById(id) != null)
		var txt = document.getElementById(id).value;
	else
		var txt = id;
	if(window.clipboardData){
		window.clipboardData.clearData();
		window.clipboardData.setData("Text",txt);
		return true;
	}else if(navigator.userAgent.indexOf("Opera")!=-1){
		window.location=txt;
		return true;
	}else if(window.netscape){
		try{
			netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
		}catch(e){
			alert("您的firefox安全限制限制您进行剪贴板操作，请在浏览器地址栏输入’about:config’并回车，然后将’signed.applets.codebase_principal_support’设置为’true’之后重试。");
			return;
		}
		var clip=Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);
		if(!clip)return false;
		
		var trans=Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);
		if(!trans)return false;
		
		trans.addDataFlavor('text/unicode');
		var str=new Object();
		var len=new Object();
		var str=Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
		var copytext=txt;str.data=copytext;
		trans.setTransferData("text/unicode",str,copytext.length*2);
		var clipid=Components.interfaces.nsIClipboard;
		if(!clip)return false;
		
		clip.setData(trans,null,clipid.kGlobalClipboard);
		return true;		
	}
	return false;
}

function copy(str){
	if(str){ 
		result = copyToClipboard(str);
		if(result){
			alert('复制成功！');
		}else if(result == false){
			alert('您的浏览器不支持剪贴板操作，请自行复制！');
		}
	}else{
		alert('内容为空！');
	}
}
function showrili(){
	//$id("light").style.display='block';
//location.href='http://wannianli.tianqi.com/';
window.open('http://wannianli.tianqi.com/');
	//$id("fade").style.display='block';
}
function closerili(){
	$id("light").style.display='none';
	//$id("fade").style.display='none';
}

var LightDrag = function ()
{
	var oWin = document.getElementById("light");
	var oH2 = oWin.getElementsByTagName("h2")[0];
	var bDrag = false;
	var disX = disY = 0;
	oH2.onmousedown = function (event)
	{
		var event = event || window.event;
		bDrag = true;
		disX = event.clientX - oWin.offsetLeft;
		disY = event.clientY - oWin.offsetTop;		
		this.setCapture && this.setCapture();		
		return false
	};
	document.onmousemove = function (event)
	{
		if (!bDrag) return;
		var event = event || window.event;
		var iL = event.clientX - disX;
		var iT = event.clientY - disY;
		var maxL = document.documentElement.clientWidth - oWin.offsetWidth;
		var maxT = document.documentElement.clientHeight - oWin.offsetHeight;		
		iL = iL < 0 ? 0 : iL;
		iL = iL > maxL ? maxL : iL; 		
		iT = iT < 0 ? 0 : iT;
		iT = iT > maxT ? maxT : iT;
		
		oWin.style.marginTop = oWin.style.marginLeft = 0;
		oWin.style.left = iL + "px";
		oWin.style.top = iT + "px";		
		return false
	};
	document.onmouseup = window.onblur = oH2.onlosecapture = function ()
	{
		bDrag = false;				
		oH2.releaseCapture && oH2.releaseCapture();
	};
}

function wrf_calendar(yy,mm,dd){var Today = new Date;var tY = Today.getFullYear();var tM = Today.getMonth();var tD = Today.getDate();var lichunDate=0,lunarInfo=[19416,19168,42352,21717,53856,55632,91476,22176,39632,21970,19168,42422,42192,53840,119381,46400,54944,44450,38320,84343,18800,42160,46261,27216,27968,109396,11104,38256,21234,18800,25958,54432,59984,28309,23248,11104,100067,37600,116951,51536,54432,120998,46416,22176,107956,9680,37584,53938,43344,46423,27808,46416,86869,19872,42416,83315,21168,43432,59728,27296,44710,43856,19296,43748,42352,21088,62051,55632,23383,22176,38608,19925,19152,42192,54484,53840,54616,46400,46752,103846,38320,18864,43380,42160,45690,27216,27968,44870,43872,38256,19189,18800,25776,29859,59984,27480,21952,43872,38613,37600,51552,55636,54432,55888,30034,22176,43959,9680,37584,51893,43344,46240,47780,44368,21977,19360,42416,86390,21168,43312,31060,27296,44368,23378,19296,42726,42208,53856,60005,54576,23200,30371,38608,19415,19152,42192,118966,53840,54560,56645,46496,22224,21938,18864,42359,42160,43600,111189,27936,44448,84835],yearInfo=[1901,1902,1903,1904,1905,1906,1907,1908,1909,1910,1911,1912,1913,1914,1915,1916,1917,1918,1919,1920,1921,1922,1923,1924,1925,1926,1927,1928,1929,1930,1931,1932,1933,1934,1935,1936,1937,1938,1939,1940,1941,1942,1943,1944,1945,1946,1947,1948,1949,1950,1951,1952,1953,1954,1955,1956,1957,1958,1959,1960,1961,1962,1963,1964,1965,1966,1967,1968,1969,1970,1971,1972,1973,1974,1975,1976,1977,1978,1979,1980,1981,1982,1983,1984,1985,1986,1987,1988,1989,1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,2E3,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030,2031,2032,2033,2034,2035,2036,2037,2038,2039,2040,2041,2042,2043,2044,2045,2046,2047,2048,2049],solarMonth=[31,28,31,30,31,30,31,31,30,31,30,31],Gan=["甲","乙","丙","丁","戊","己","庚","辛","壬","癸"],Zhi=["子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥"],Animals=["鼠","牛","虎","兔","龙","蛇","马","羊","猴","鸡","狗","猪"],solarTerm=["小寒","大寒","立春","雨水","惊蛰","春分","清明","谷雨","立夏","小满","芒种","夏至","小暑","大暑","立秋","处暑","白露","秋分","寒露","霜降","立冬","小雪","大雪","冬至"],sTermInfo=[0,21208,42467,63836,85337,107014,128867,150921,173149,195551,218072,240693,263343,285989,308563,331033,353350,375494,397447,419210,440795,462224,483532,504758],nStr1=["日","一","二","三","四","五","六","七","八","九","十"],nStr2=["初","十","廿","卅","□"],monthName=["JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"],sFtv=["0101 *元旦","0102 *","0103 *","0214 情人节","0305 雷锋日","0308 妇女节","0312 植树节","0315 315","0401 愚人节","0407 卫生日","0422 地球日","0501*劳动节","0502*","0503*","0504 青年节","0512 护士节","0531 无烟日","0601 儿童节","0605 环保日","0606 爱眼日","0625 土地日","0626 禁毒日","0701 建党日","0801 建军节","0910 教师节","0918 九一八","0920 爱牙日","1001*国庆节","1002*","1003*","1031 万圣节","1124 感恩节","1224 平安夜","1225 圣诞节"],lFtv=["0115 元宵节","0505 端午节","0707 七夕","0715 鬼节","0815 中秋节","0909 重阳节","1208 腊八","1223 小年","0100 除夕","0101 春节"],wFtv=["0150 世界麻风日","0520 国际母亲节","0530 全国助残日","0630 父亲节","0730 被奴役国家周","0932 国际和平日","0940 国际聋人节 世界儿童日","0950 世界海事日","1011 国际住房日","1013 国际减轻自然灾害日(减灾日)","1144 感恩节"],fFtv2011=["0101 *元旦","0102 *","0103 *","0130 _","0202 *除夕","0203 *春节","0204 *立春","0205 *","0206 *","0207 *","0208 *","0212 _","0402 _","0403 *","0404 *","0405 *清明节","0430 *","0501 *劳动节","0502 *","0604 *端午节","0605 *","0606 *","0910 *教师节","0911 *","0912 *中秋节","1001 *国庆节","1002 *","1003 *","1004 *","1005 *","1006 *","1007 *","1008 _","1009 _"];function lYearDays(a){var c,e=348;for(c=32768;c>8;c>>=1)e+=lunarInfo[a-1900]&c?1:0;return e+leapDays(a)}function leapDays(a){return leapMonth(a)?lunarInfo[a-1900]&65536?30:29:0}function leapMonth(a){return lunarInfo[a-1900]&15}function monthDays(a,c){return lunarInfo[a-1900]&65536>>c?30:29}function Lunar(a){var c=0,e=0,d=(Date.UTC(a.getFullYear(),a.getMonth(),a.getDate())-Date.UTC(1900,0,31))/864E5;for(a=1900;a<2050&&d>0;a++){e=lYearDays(a);d-=e}if(d<0){d+=e;a--}this.year=a;c=leapMonth(a);this.isLeap=false;for(a=1;a<13&&d>0;a++){if(c>0&&a==c+1&&this.isLeap==false){--a;this.isLeap=true;e=leapDays(this.year)}else e=monthDays(this.year,a);if(this.isLeap==true&&a==c+1)this.isLeap=false;d-=e}if(d==0&&c>0&&a==c+1)if(this.isLeap)this.isLeap=false;else{this.isLeap=true;--a}if(d<0){d+=e;--a}this.month=a;this.day=d+1}function solarDays(a,c){return c==1?a%4==0&&a%100!=0||a%400==0?29:28:solarMonth[c]}function cyclical(a){return Gan[a%10]+Zhi[a%12]}function calElement(a,c,e,d,b,f,g,h,j,k,l){this.isToday=false;this.sYear=a;this.sMonth=c;this.sDay=e;this.week=d;this.lYear=b;this.lMonth=["","正","二","三","四","五","六","七","八","九","十","冬","腊"][parseInt(f)]+"月";this.lDay=["","初一","初二","初三","初四","初五","初六","初七","初八","初九","初十","十一","十二","十三","十四","十五","十六","十七","十八","十九","二十","廿一","廿二","廿三","廿四","廿五","廿六","廿七","廿八","廿九","三十","三十一","三十二"][parseInt(g)];this.isLeap=h?"闰":"";this.cYear=j+"年";this.cMonth=k+"月";this.cDay=l+"日";this.animal=Animals[(parseInt(b)-4)%12];this.solarTerms="";this.solarFestival="";this.lunarFestival="";this.className=this.color=""}function sTerm(a,c){return(new Date(3.15569259747E10*(a-1900)+sTermInfo[c]*6E4+Date.UTC(1900,0,6,2,5))).getUTCDate()}function rili(a,c){var e,d,b,f,g=1,h=0,j,k,l=Array(3),m=0,n=0;e=new Date(a,c,1,0,0,0,0);this.length=solarDays(a,c);this.firstWeek=e.getDay();j=c<2?cyclical(a-1900+36-1):cyclical(a-1900+36);var o=sTerm(a,2);lichunDate=o;var p=sTerm(a,c*2);k=cyclical((a-1900)*12+c+12);for(var q=Date.UTC(a,c,1,0,0,0,0)/864E5+25567+10,i=0;i<this.length;i++){if(g>h){e=new Date(a,c,i+1);d=new Lunar(e);b=d.year;f=d.month;g=d.day;h=(d=d.isLeap)?leapDays(b):monthDays(b,f);if(m==0)n=f;l[m++]=i-g+1}if(c==1&&i+1==o)j=cyclical(a-1900+36);if(i+1==p)k=cyclical((a-1900)*12+c+13);e=cyclical(q+i);this[i]=new calElement(a,c+1,i+1,nStr1[(i+this.firstWeek)%7],b,f,g++,d,j,k,e)}b=sTerm(a,c*2)-1;f=sTerm(a,c*2+1)-1;solarTerm[c*2]&&(this[b].solarTerms=solarTerm[c*2]);solarTerm[c*2+1]&&(this[f].solarTerms=solarTerm[c*2+1]);for(i in sFtv)if(sFtv[i].match(/^(\d{2})(\d{2})([\s\*])(.+)$/))if(Number(RegExp.$1)==c+1)this[Number(RegExp.$2)-1].solarFestival+=RegExp.$4.indexOf("*")!==-1?RegExp.$4.split("*")[1]+"":RegExp.$4+"";if(a==2011)for(i in fFtv2011)if(fFtv2011[i].match(/^(\d{2})(\d{2})([\s\*])(.+)$/))if(Number(RegExp.$1)==c+1)if(RegExp.$4.indexOf("*")!==-1){this[Number(RegExp.$2)-1].solarFestival=RegExp.$4.split("*")[1]+"";this[Number(RegExp.$2)-1].className="holidays"}else if(RegExp.$4.indexOf("_")!==-1){this[Number(RegExp.$2)-1].solarFestival=RegExp.$4.split("_")[1]+"";this[Number(RegExp.$2)-1].className="works"}else this[Number(RegExp.$2)-1].solarFestival+=RegExp.$4+"";for(i in lFtv)if(lFtv[i].match(/^(\d{2})(.{2})([\s\*])(.+)$/)){b=Number(RegExp.$1)-n;if(b==-11)b=1;if(b>=0&&b<m){f=l[b]+Number(RegExp.$2)-1;if(f>=0&&f<this.length&&this[f].isLeap!=true){this[f].lunarFestival+=RegExp.$4+" ";if(RegExp.$3=="*")this[f].color="red"}}}if(a==tY&&c==tM)this[tD-1].isToday=true}function easter(a){var c=sTerm(a,5);c=new Date(Date.UTC(a,2,c,0,0,0,0));var e=new Lunar(c);a=e.day<15?15-e.day:(e.isLeap?leapDays(a):monthDays(a,e.month))-e.day+15;a=new Date(c.getTime()+864E5*a);a=new Date(a.getTime()+864E5*(7-a.getUTCDay()));this.m=a.getUTCMonth();this.d=a.getUTCDate()}var cld=new rili(yy,mm-1);return cld[dd-1];}

var Calendar = (function() {
	var Today = new Date;
	var tY = Today.getFullYear();
	var tM = Today.getMonth();
	var tD = Today.getDate();
	var wrf = wrf_calendar(tY,tM+1,tD);
	var min = Today.getMinutes();
	if (min < 10) {
        min = '0' + min;
    }
	function d(){
		return '<a href="javascript:void(0);" onclick="showrili();" rel="nr" title="点击查看万年历">'+wrf.sYear+'年'+wrf.sMonth+'月'+wrf.sDay+'日 <label id="t_hm">'+Today.getHours()+':'+min+'</label></a>';
	}
	function o(){
		return '<a href="javascript:void(0);" onclick="showrili();" rel="nr" title="点击查看万年历">农历 '+wrf.lMonth+wrf.lDay+' 星期'+wrf.week+'</a>';
	}
    return {
        day: d,
        cnday: o,
		all: wrf
    }
})();

function t_hm_fun() {
    clearTimeout(t_hm_timer);
    var d = new Date();
    var min = d.getMinutes();
    if (min < 10) {
        min = '0' + min;
    }
	var target = document.getElementById('t_hm');
	if(target){
		target.innerHTML = d.getHours() + ':' + min;
		t_hm_timer = setTimeout("t_hm_fun()", 3000);
	}
}
var t_hm_timer = setTimeout("t_hm_fun()", 3000);

//微信
$(document).ready(function(){		
	$("#tq_wx_txt").hover(function(){
	$("#tq_wx_txt").removeClass("tq_wx_txt1");
	$(".wx_box01").hide();  
	});
	
	$("#tq_wx_txt").mouseover(function(){
	$("#tq_wx_txt").addClass("tq_wx_txt1");
	$(".wx_box01").show();
	});
})