var TQCODER = {
	_this: null,
	settings:{'id':1,'color':'','bgc':'', 'bdc':'','icon':1,'py':'','wind':0,'temp':0,'num':0,'w':0,'h':0,'nid':0,'wid':0},
	isworld:0,
	codeurl:"",
	codehost:"http://i.tianqi.com",
	changeTemplate:function($obj) {
		_this.settings.id = $obj.val();
		_this.settings.wind = $obj.find("option:selected").attr('wind');
		_this.settings.temp = $obj.find("option:selected").attr('temp');
		_this.settings.w = $obj.find("option:selected").attr('width');
		_this.settings.h = $obj.find("option:selected").attr('height');
		_this.settings.num = $obj.find("option:selected").attr('num');

		if (_this.settings.num > 0) {
			var numOptions = '';
			for (var i = _this.settings.num; i >= 1; i--) {
				numOptions += '<option value="' + i + '">' + i + '</option>';
			}
			$("#select_num").html(numOptions);
		}

		$("#field_width").val(_this.settings.w);
		$("#field_height").val(_this.settings.h);

		_this.resetOption();
	},
	changeColor:function($obj) {
		_this.settings.color = '%23' + $obj.val();
		$(".weather_edit").find("iframe").remove();
		_this.preview();
	/*	$("#for_weather_edit").click();*/
		//模拟天气click
		weatherinit();
		
	},
	changeBgColor:function($obj) {
		_this.settings.bgc = '%23' + $obj.val();
		$(".weather_edit").find("iframe").remove();
		_this.preview();
		//模拟天气click
		weatherinit();		
	},
	changeBdColor:function($obj) {
		_this.settings.bdc = '%23' + $obj.val();
	},
	changeIcon:function($obj) {
		_this.settings.icon = $obj.val();
		$obj.parent().find('img').attr('src', $obj.find("option:selected").attr('img'));
		$(".weather_edit").find("iframe").remove();
		_this.preview();
/*		$("#for_weather_edit").click();*/
		//模拟天气click
		weatherinit();
		
	},
	changeTemp:function($obj) {
		_this.settings.temp = $obj.val();
	},
	changeWind:function($obj) {
		_this.settings.wind = $obj.val();
	},
	changeNum:function($obj) {
		_this.settings.num = $obj.val();
		if (_this.settings.id == 4) {
			_this.settings.h = 20 +　_this.settings.num*100;
		}
	},
	changeWidth:function($obj) {
		_this.settings.w = $obj.val();
	},
	changeHeight:function($obj) {
		getcity(this.value)
		_this.settings.h = $obj.val();
	},
	changeProvince:function($obj) {
		console.log("changeProvince");
		if ($obj.val() == '') {
			console.log("$obj.val() == ''");
			$("#selCity").hide();
			$("#selCounty").hide();
			return false;
		}

		var py = $obj.find("option:selected").attr('py');
		if (py == 'asia' || py == 'europe' || py == 'america' || py == 'oceania' || py == 'africa') {
			console.log("ifififififi");
			_this.isworld = 1;
			var b = loadJS("http://www.tianqi.com/weather.php?a=getworldInfo&type=1&pid="+$obj.val()+"&callback=getDzWorldcityFun");
			console.log(b);
			return b;
		} else {
			console.log("elseelse");
			_this.isworld = 0;
			_this.settings.nid = 0;
			_this.settings.wid = 0;
			var b = loadJS("http://www.tianqi.com/weather.php?a=getZoneInfo&type=1&pid="+$obj.val()+"&callback=getDzcityFun");
			console.log(b);
			return b;
		}
		
		
	},
	changeCity:function($obj) {
		console.log("changeCity");
		if ($obj.val() == '') {
			console.log("$obj.val() == ''");
			$("#selCounty").hide();
			return false;
		}
		if (_this.isworld == 1) {
			console.log("csdfsdfs");
			_this.settings.nid = $obj.val();
			var b = loadJS("http://www.tianqi.com/weather.php?a=getworldInfo&type=2&cid="+$obj.val()+"&pid="+$('#selProvince').val()+"&callback=getDzWorldzoneFun");
			console.log(b);
			return b;
		} else {
			console.log("dsdsgsdgfsdgsgs");
			var b = loadJS("http://www.tianqi.com/weather.php?a=getZoneInfo&type=2&cid="+$obj.val()+"&pid="+$('#selProvince').val()+"&callback=getDzzoneFun");
			console.log(b);
			return b;
		}
		
	},
	changeCounty:function($obj) {
		_this.settings.py = $obj.find("option:selected").attr('py');
		if (_this.isworld == 1) {
			_this.settings.wid = $obj.val();
		}
		$(".weather_edit").find("iframe").remove();
		_this.preview();
		/*$("#for_weather_edit").click();*/
		//模拟天气click
		weatherinit();
		
	},
	resetOption:function() {
		if (_this.settings.wind) {
			$("#dz_wind").show();
		} else {
			$("#dz_wind").hide();
		}
		if (_this.settings.temp) {
			$("#dz_temp").show();
		} else {
			$("#dz_temp").hide();
		}
		if (_this.settings.num > 0) {
			$("#dz_num").show();
		} else {
			$("#dz_num").hide();
		}

		if (_this.settings.id == 4 || _this.settings.id == 10) {
			$("#dz_wh").hide();
		} else {
			$("#dz_wh").show();
		}
	},
	preview:function() {
		_this.generateCode();
		//window.location.hash = 'dz_id';
	},
	copyCode:function() {
		$('#field_code').focus().select(); window.clipboardData.setData('Text',$('#field_code').val());
		alert('代码已复制到剪贴板'); 
		return true;
	},
	generateCode:function() {
		_this.codeurl = _this.codehost + "/index.php?c=code";
		$.each(_this.settings, function(key, val){
			if (key != 'w' && key != 'h') {
				if (val) {
					_this.codeurl += '&' + key + '=' + val;
				}
			}
		});

		var code = '<iframe width="' + _this.settings.w + '" scrolling="no" ';
		code += 'height="' + _this.settings.h + '" frameborder="0" allowtransparency="true" src="CODEURL"></iframe>';
		
		$("#field_code").val(code.replace("CODEURL", _this.codeurl));
		var iframeUrl = $("#field_code").val();
		var iframe = $(iframeUrl);
		console.log(pUrl);
		/*curScene.append(iframe);
		curScene.find("iframe").hide();*/
		$(".weather_edit").append(iframe);
		$(".weather_edit").find("iframe").hide();
		//window.location.hash = 'dz_id';
	},

	init:function(){
		_this = this;
		// 初始化模板
		_this.changeTemplate($("#select_id"));
		// 初始化宽高
		_this.generateCode();
		$("#selCity").hide();
		$("#selCounty").hide();
	}
};
TQCODER.init();

function getDzcityFun(json)
{   console.log("call back");
	console.log("getDzcityFungetDzcityFun");
	var str='';
	str += "<option ishot='0' py='' value=''>请选择市</option>";
	for(var key in json[0].py)
	{
		//if(json[0].defval==key) str += "<option selected ishot='"+json[0].ishot[key]+"' py='"+json[0].py[key]+"' value='"+key+"'>"+json[0].value[key]+"</option>";
		//else str += "<option ishot='"+json[0].ishot[key]+"' py='"+json[0].py[key]+"' value='"+key+"'>"+json[0].value[key]+"</option>";
		str += "<option py='"+json[0].py[key]+"' value='"+key+"'>"+json[0].value[key]+"</option>";
	}
	$("#selCity").html(str);
	$("#selCity").show();
	console.log($("#selCity").val());
	console.log(curelement.attr("selCity"));
	$("#selCity").val(curelement.attr("selCity"));
	console.log($("#selCity").val());
	$("#selCounty").hide();
}

function getDzzoneFun(json)
{   console.log("call back");
    console.log("getDzcityFungetDzcityFun");
	str = '';
	str += "<option ishot='0' py='' value=''>请选择县</option>";
	for(var key in json[0].py)
	{
		str += "<option py='"+json[0].py[key]+"' value='"+key+"'>"+json[0].value[key]+"</option>";
	}
	$("#selCounty").html(str);
	$("#selCounty").show();
	console.log($("#selCounty").val());
	console.log(curelement.attr("selCounty"));
	$("#selCounty").val(curelement.attr("selCounty"));
	console.log($("#selCounty").val());
	
}


function getDzWorldcityFun(json)
{
	var str='';
	str += "<option py='' value=''>请选国家</option>";
	for(var key in json)
	{
		str += "<option py='"+json[key]['pinyin']+"' value='"+json[key]['id']+"'>"+json[key]['name']+"</option>";
	}
	$("#selCity").html(str);
	$("#selCity").show();
	console.log($("#selCity").val());
	console.log(curelement.attr("selCity"));
	$("#selCity").val(curelement.attr("selCity"));
	console.log($("#selCity").val());
	$("#selCounty").hide();
	console.log($("#selCounty").val());
	console.log(curelement.attr("selCounty"));
	$("#selCounty").val(curelement.attr("selCounty"));
	console.log($("#selCounty").val());
}

function getDzWorldzoneFun(json)
{
	str = '';
	str += "<option py='' value=''>请选城市</option>";
	for(var key in json)
	{
		str += "<option py='"+json[key]['pinyin']+"' value='"+json[key]['id']+"'>"+json[key]['name']+"</option>";
	}
	$("#selCounty").html(str);
	$("#selCounty").show();
	console.log($("#selCounty").val());
	console.log(curelement.attr("selCounty"));
	$("#selCounty").val(curelement.attr("selCounty"));
	console.log($("#selCounty").val());
}