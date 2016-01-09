function getTimeString(date, timezone){
    var tz = date.getTimezoneOffset();
    var dt = new Date();
    dt.setTime(date.getTime() + tz*60000 + timezone*3600000);	
    return dt;
}
//获取选定后的时间
function getTime(timezone,obj){	
	window.baidu_time(getTimeString(new Date(), timezone).getTime(),obj);	
}