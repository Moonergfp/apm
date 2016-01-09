	/* 终端设置 */
$(function(){
		$(".switch").bootstrapSwitch({'onSwitchChange':function(event, state){
			if(state == true){
				$(this).attr("checked","checked");
			}else{
				$(this).removeAttr("checked");
			}
		}});//初始化开关控件
		$('#switch_all').on('switchChange.bootstrapSwitch', function(event, state) {
			  console.log(event); // jQuery event
			  console.log(state); // true | false
			if(state == true){
				$(".screen_times").show("slow");
			}else{
				$(".screen_times").hide("slow");
			}
		});
});

/*保存截屏时间*/
function saveScreenShootTimes(){
	var tIds = terminalIds.join(",");
	var t1 = $("[name='screentime1']").val()
	var t2 = $("[name='screentime2']").val()
	var t3 = $("[name='screentime3']").val()
	var t4 = $("[name='screentime4']").val()
	
	var checkedAll = $("#switch_all").attr("checked");
	var checked1 = $("#screen_shoot_checkbox1").attr("checked");
	var checked2 = $("#screen_shoot_checkbox2").attr("checked");
	var checked3 = $("#screen_shoot_checkbox3").attr("checked");
	var checked4 = $("#screen_shoot_checkbox4").attr("checked");
	var url = "/apm-web/a/terminalSettings/saveScreenShootTimes";
	var fixedTimeFlag;
	if(!checkedAll){
		fixedTimeFlag = '0';
	}else{
		fixedTimeFlag = "1";
	}

	var data = {"terminalIds":tIds,"fixedTimeFlag":fixedTimeFlag,"t1":t1,"t2":t2,"t3":t3,"t4":t4,"checked1":(!checked1)?0:1,"checked2":(!checked2)?0:1,"checked3":(!checked3)?0:1,"checked4":(!checked4)?0:1};
	$.ajax({
		url:url,
		data:data,
		type:"POST",
		success:function(data){
			if(data == 'ok'){//成功
				top.$.jBox.tip("保存成功","success");
			}else{
				top.$.jBox.tip("保存失败","warning");
			}
		}
	});
}

//保存开关机模式
var weekOnOffModeTimes = [];//星期日到星期六的所有开关机时间
function saveOnOffModeTimes(){
	var tIds = terminalIds.join(",");
	console.log("tIds===>" + tIds);
	var on_off_mode = $("#on_off_mode").val();//开关模式
	var on_off_mode_switch = $("#on_off_mode_switch").val();//开关控制
	console.log(on_off_mode + "   "+on_off_mode_switch);
	var workTimes = [];
	var data;
	if(on_off_mode == '0' && on_off_mode_switch == '0' ){				//00
		data = {"terminalIds":tIds,"mode":on_off_mode,"modeSwitch":on_off_mode_switch};

	}else if(on_off_mode == '0' && on_off_mode_switch == '1' ){			//01
		for(var i = 1 ; i <= 4 ;i++){
			var flag;
			if(!$("#everyMode  .on_off_mode_checkbox" + i).attr("checked")){
				flag = 0;
			}else{
				flag = 1;
			}
			var time = {"stime":$("#everyMode [name='s"+i+"']").val(),"etime":$("#everyMode [name='e"+i+"']").val(),"checked":flag};
			workTimes.push(time);
		}
		data = {"terminalIds":tIds,"mode":on_off_mode,"modeSwitch":on_off_mode_switch,"workTimes":JSON.stringify(workTimes)};

	}else if(on_off_mode == '1' && on_off_mode_switch == '1' ){			//11 星期模式
		console.log("星期模式");
		var MonArray = [];
		var TueArray = [];
		var WedArray = [];
		var ThursArray = [];
		var FriArray = [];
		var SatArray = [];
		var SunArray = [];
		//星期一
		for(var i = 1 ; i <= 4 ;i++){
			var flag;
			if(!$("#Mon .on_off_mode_checkbox" + i).attr("checked")){
				flag = 0;
			}else{
				flag = 1;
			}
			var time = {"stime":$("#Mon [name='s"+i+"']").val(),"etime":$("#Mon [name='e"+i+"']").val(),"checked":flag,"week":2};
			MonArray.push(time);

		}
		//星期二
		for(var i = 1 ; i <= 4 ;i++){
			var flag;
			if(!$("#Tue .on_off_mode_checkbox" + i).attr("checked")){
				flag = 0;
			}else{
				flag = 1;
			}
			var time = {"stime":$("#Tue [name='s"+i+"']").val(),"etime":$("#Tue [name='e"+i+"']").val(),"checked":flag,"week":3};
			TueArray.push(time);
		}
			//星期三
		for(var i = 1 ; i <= 4 ;i++){
			var flag;
			if(!$("#Wed .on_off_mode_checkbox" + i).attr("checked")){
				flag = 0;
			}else{
				flag = 1;
			}
			var time = {"stime":$("#Wed [name='s"+i+"']").val(),"etime":$("#Wed [name='e"+i+"']").val(),"checked":flag,"week":4};
			WedArray.push(time);
		}
			//星期四
		for(var i = 1 ; i <= 4 ;i++){
			var flag;
			if(!$("#Thurs .on_off_mode_checkbox" + i).attr("checked")){
				flag = 0;
			}else{
				flag = 1;
			}
			var time = {"stime":$("#Thurs [name='s"+i+"']").val(),"etime":$("#Thurs [name='e"+i+"']").val(),"checked":flag,"week":5};
			ThursArray.push(time);
		}
			//星期五
		for(var i = 1 ; i <= 4 ;i++){
			var flag;
			if(!$("#Fri .on_off_mode_checkbox" + i).attr("checked")){
				flag = 0;
			}else{
				flag = 1;
			}
			var time = {"stime":$("#Fri [name='s"+i+"']").val(),"etime":$("#Fri [name='e"+i+"']").val(),"checked":flag,"week":6};
			FriArray.push(time);
		}
			//星期六
		for(var i = 1 ; i <= 4 ;i++){
			var flag;
			if(!$("#Sat .on_off_mode_checkbox" + i).attr("checked")){
				flag = 0;
			}else{
				flag = 1;
			}
			var time = {"stime":$("#Sat [name='s"+i+"']").val(),"etime":$("#Sat [name='e"+i+"']").val(),"checked":flag,"week":7};
			SatArray.push(time);
		}

			//星期日
		for(var i = 1 ; i <= 4 ;i++){
			var flag;
			if(!$("#Sun .on_off_mode_checkbox" + i).attr("checked")){
				flag = 0;
			}else{
				flag = 1;
			}
			var time = {"stime":$("#Sun [name='s"+i+"']").val(),"etime":$("#Sun [name='e"+i+"']").val(),"checked":flag,"week":1};
			SunArray.push(time);
		}
		data = {"terminalIds":tIds,"mode":on_off_mode,"modeSwitch":on_off_mode_switch
					,"Sun":JSON.stringify(SunArray),"Mon":JSON.stringify(MonArray),"Tue":JSON.stringify(TueArray)
					,"Wed":JSON.stringify(WedArray),"Thurs":JSON.stringify(ThursArray),"Fri":JSON.stringify(FriArray)
					,"Sat":JSON.stringify(SatArray),"weekMode":true};
	}
	//向web服务器发送更改保存信息
	var url = "/apm-web/a/terminalSettings/saveOnOffModeTimes";
	console.log("data===>" + data);
	$.ajax({
		url:url,
		data:data,
		type:"POST", 
		dataType:'text',
		success:function(result){
			console.log("result==>" + result);
			if(result == 'ok'){
				top.$.jBox.tip("保存成功","success");
			}else{
				top.$.jBox.tip("保存失败","warning");
			}
		}

	});
}



//监听开关模式变化
function onOffModeSelectChange(){
	var on_off_mode = $("#on_off_mode").val();//开关模式
	if(on_off_mode == '0'){  //每天模式
		$("#weekMode").css("display","none");
		$("#everyMode").show("fast");
		$("#on_off_mode_switch").empty();
		$("#on_off_mode_switch").html("<option value='0'>常开</option><option value='1'>定时</option>");
		$("#everyMode").css("display","none");
	}else{					//星期模式
		$("#everyMode").css("display","none");
		$("#weekMode").show("fast");
		$("#on_off_mode_switch").empty();
		$("#on_off_mode_switch").html("<option value='1'>定时</option>");
	}
}
function onOffModeSwitchSelectChange () {
	var on_off_mode_switch = $("#on_off_mode_switch").val();
	if(on_off_mode_switch == '0'){	//常开
		$("#everyMode").hide("fast");
	}else{							//定时
		$("#everyMode").show("fast");
	}
}