(function($){
		$.fn.combox = function(options) {
			var defaults = {  
                borderCss: "combox_border",  
                inputCss: "combox_input",  
                buttonCss: "combox_btn",  
                selectCss: "combox_select",
                initId:"",//input框的ID
                initName:"",//input框的名字
				datas:[],//下拉值 <异步请求数据，和直传两种>
				showNumber:8,//默认显示8条记录
				fieldName:"",//字段名字 <若调用公共方法，此项为必填项>
				entityName:"",//如果为空，服务器为自定义方法，否则调用公共处理方法。<若调用公共方法，此项为必填项>
				initContent:"",//初始显示的内容
				issingle:true,//是否需要下拉三角符号默认显示
				ctx:"",//项目static路径,访问服务器  <异步加载数据，此项为必填：1.自定义请求服务器，2.调用公共方法请求>
				ctxStatic:"",//项目static路径，访问静态资源  <显示下拉三角 此项为必填>	
				doBigDatas:false,//处理大数据时使用此处理方式，默认不使用，大于1000条数据
				placeholder:"",//默认的提示语
				success:function(data){},//选中单个选项之后的回调函数
				singleTriggerBlur:false,//点击3下拉三角型符号，并选取值后，input发生失去焦点事件
				enterTriggerBlur:false,//输入框，输入回车键失去焦点
				isRequired:true,
				contentFiltering:[],
            };

			
			var contentFilterFlag = false;
			
            var options = $.extend(defaults, options);

            var datas=options.datas;

            var needxia=options.issingle;
            
            var fieldName = options.fieldName;
            
			var showNumber = options.showNumber;
			
			var entityName = options.entityName;
			
			var doBigFlag = options.doBigDatas;
            
			function _initBorder($border) {//初始化外框CSS
				$border.addClass(options.borderCss);
				return $border;
			}
			function _initInput($border){//初始化输入框
				var inputId=options.initId;
				var inputName=options.initName;
				if(inputName==""){
					inputName=inputId;
				}
				
				if(options.contentFiltering.length>0){
					contentFilterFlag = true;
				}
				
				var requiredClass = "";
				if(options.isRequired){
					requiredClass = " required ";
				}
				
				$border.append('<input type="text" autocomplete="off" name="'+inputName+'" id="'+inputId+'" class="'+requiredClass+options.inputCss+'" placeholder="'+options.placeholder+'"/>');
				if(needxia){
					$border.append('<img class="'+options.buttonCss+'" src="'+options.ctxStatic+'/frontEnd/autoComple/css/iconfont-triangle-down.png"/>');
				}		
				$border.append('<ul class="'+options.selectCss+'"></ul>');
				//绑定下拉特效
				$border.delegate('img', 'click', function() {
					var $ul = $border.children('ul');
				    var $li = $ul.children('li');
				    $li.remove();
					if($ul.is(":hidden")) {
						if(doBigFlag){			
							datas = getBigData("");
						}
						var size = datas.length;
						if(size>showNumber){
							size = showNumber;
						}

						if(contentFilterFlag){
							for (var i = 0; i < size ; i++) {
								if(contentFilter(datas[i])){
							    	$ul.append("<li><a href='javascript:void(0)'>"+datas[i]+"</a></li>").show();
								}
						    };
						}else{
							for (var i = 0; i < size ; i++) {
							    $ul.append("<li><a href='javascript:void(0)'>"+datas[i]+"</a></li>").show();
						    };
						}

						$ul.slideDown('fast');						
					}else {
						$ul.slideUp('fast');
					}
					$ul.find("li").eq(0).addClass("li-active");					
				});
				
				function getBigData(word){
					
					//判断所给的关键字是否是存在于上一次
					if (likeWord.length==0) {
						//发送请求
						getAjaxWord(word,1);
					}else{
						 
						var arrNow = word.split("");
						var arrOld = likeWord.split("");	
						var size = (arrNow.length >= arrOld.length ? arrOld.length : arrNow.length);
						var f = false;
						for (var i = 0; i < size; i++) {
							if (arrNow[i] != arrOld[i]) {
								f = true;
								break;
							};
						};
						if (f) {
							//发送请求
							getAjaxWord(word,1);
						};
					};
					likeWord = word;
					return datas;
				}
			
				var likeWord = "";
				$border.delegate('input','keyup',function(e){
					e.stopPropagation();
					if (e.keyCode!=38&&e.keyCode!=40) {
						var $nowdata=$(this).val();
						
						//处理记录数，在此判断
						if(doBigFlag){			
							datas = getBigData($nowdata);
						}
					    var a=fliter(datas,$nowdata);
					    var $ul = $border.children('ul');
				        var $li = $ul.children('li');
				        $li.remove();
				        var size = a.length;
					    if(size>showNumber){
						   size = showNumber;
					    }
					    
						if(contentFilterFlag){
							for (var i = 0; i < size ; i++) {
								if(contentFilter(datas[i])){
									$ul.append("<li><a href='javascript:void(0)'>"+a[i]+"</a></li>").show();
								}
						    };
						}else{
							for (var i = 0; i < size ; i++) {
								$ul.append("<li><a href='javascript:void(0)'>"+a[i]+"</a></li>").show();
						    };
						}
				        $ul.find("li").eq(0).addClass("li-active");
					};					
				});

				$(document).bind("click",function(event){										
					if($border.find(event.target).length==0){
						var $ul = $border.children('ul');
				    	$ul.slideUp('fast');
					}

					options.success($border.find("input").val());		           
			    });

                $border.bind('keydown',function(event){
                	var $ul = $border.children('ul');
				    var $li = $ul.children('li');
				    var nowa=0;
				    var selecrone;
				    for(var i=0;i<$li.length;i++){
				        var $self=$li.eq(i);				            	
				        if ($self.hasClass("li-active")) {
				        	selecrone=$self;
				        	nowa=i;
				        }
				    }
					switch(event.keyCode){
			    		case 13:{	      
					        if(options.enterTriggerBlur){
					        	setTimeout(function(){
					        		$border.find("input").focus().blur();
					        	},300);
					        }
			    			
					        $border.find("input").val(selecrone.text());

					        var selectData;

					        if (options.fieldName.indexOf(",")>0) {
					        	selectData={
						        	"icoUrl":selecrone.find("img").attr("src"),
						        	"id":selecrone.find("span").attr("uId"),
						        	"name":selecrone.text()
						        }
					        }else{
					        	selectData=selecrone.text();
					        }

					        options.success(selectData);

					        $ul.slideUp('fast');
			    		}
			    		break;
			    		case 38:{
			    			if (nowa!=0) {
			    				if ($li.eq(nowa-1).hasClass("li-mouseover")) {
			    					$li.eq(nowa-1).removeClass("li-mouseover");
			    				}
			    				$li.eq(nowa-1).addClass("li-active");
			    				$li.eq(nowa).removeClass("li-active");
			    			};
			    		}
			    		break;
			    		case 40:{
			    			if (nowa!=$li.length-1) {
			    				if ($li.eq(nowa+1).hasClass("li-mouseover")) {
			    					$li.eq(nowa+1).removeClass("li-mouseover");
			    				}
			    				$li.eq(nowa+1).addClass("li-active");
			    				$li.eq(nowa).removeClass("li-active");
			    			};
			    		}		    		
			    	}
				});

				return $border;//IE6需要返回值
			}
			
			function _initSelect($border) {//初始化下拉列表
				var $ul = $border.children('ul');
				
				if(doBigFlag){			
					getAjaxWord("",0);
				}else{
					getAjax();
				}
				var size = datas.length;
				if(size>showNumber){
					size = showNumber;
				}

				if(contentFilterFlag){
					for (var i = 0; i <size; i++) {	
						if(contentFilter(datas[i])){
							$ul.append("<li><a href='javascript:void(0)'>"+datas[i]+"</a></li>");
						}
					};
				}else{
					for (var i = 0; i <size; i++) {	
						$ul.append("<li><a href='javascript:void(0)'>"+datas[i]+"</a></li>");
					};
				}	

				$ul.delegate('li', 'click', function() {
					$border.find("input").val($(this).text());
					if(options.singleTriggerBlur){
						$border.find("input").focus().blur();
					}

					var selectData;

					if (options.fieldName.indexOf(",")>0) {
					    selectData={
						    "icoUrl":$(this).find("img").attr("src"),
						    "id":$(this).find("span").attr("uId"),
						    "name":$(this).text()
						}
					}else{
						selectData=$(this).text();
					}

					options.success(selectData);

					$ul.hide();					
				});

				$ul.delegate('li', 'mouseover', function() {
					if ($(this).hasClass("li-active")) {
						$(this).siblings("li").removeClass("li-mouseover");
					}else{
						$(this).siblings("li").removeClass("li-mouseover");
			    	    $(this).addClass("li-mouseover");
					}					
				});

				$ul.delegate('li', 'mouseout', function() {
					$(this).removeClass("li-mouseover");					
				});
                
				return $border;//IE6需要返回值
			}
			
			//返回true，代表不需要过滤，返回false，代表需要过滤掉
			function contentFilter(data){
				if(options.contentFiltering.indexOf(data)==-1){
					return true;
				}else{
					return false;
				}
			}
			
			function getAjaxWord(keyWord,flag){
				var urlctx=options.ctx;
				var arr = urlctx.split("/");
				if(arr.length >= 3){
					if(arr.length == 3&&entityName!=""&&fieldName!=""){
						urlctx = urlctx+"/config/autoComple";//公共访问路径
					}
					var number = "0"
					if (flag == 0) {
							number = showNumber;
							keyWord = "0";						
					}
					//console.log("urlctx:"+urlctx+" number:"+number+" keyWord:"+keyWord);
					$.ajax({
						url:urlctx,
						async:false,
						data:{'fieldName':fieldName,'entityName':entityName,'number':number,'keyWord':keyWord},
						type:'post',
						dataType:'json',
						success:function(data){
							datas=data;
					}});
				}
			}

			function getAjax(){
				var urlctx=options.ctx;
				if(urlctx!=""&&datas.length == 0){
					if(entityName!=""&&fieldName!=""){
						urlctx = urlctx+"/config/autoComple";//公共访问路径
					}
					$.ajax({
						url:urlctx,
						data:{'fieldName':fieldName,'entityName':entityName},
						type:'post',
						dataType:'json',
						success:function(data){
							//console.log(data);
							if (fieldName.indexOf(",")>0) {
								/*data=JSON.parse(data);*/
								//console.log(data[1].name);
								for (var i = 0; i < data.length; i++) {
									if(data[i].icoUrl==""){
										data[i].icoUrl="/lms-web/static/images/face-placeholder.png";
									}
									data[i]="<span uId='"+data[i].id+"'><img src='"+data[i].icoUrl+"' class='itemImg'/>"+data[i].name+"</span>";
								};
							};
							datas=data;
					}});
				}
			}
			
			function fliter(array,term){
				var matcher = new RegExp(escapeRegex( term ), "i" );
		        return $.grep( array, function( value ) {
			       return matcher.test( value);
		        }); 
			}

			function escapeRegex( term ){
				return term.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g, "\\$&");
			}

			function _initContent($border){
				var content=options.initContent;
				$border.find("input").val(content);
				return $border;
			}

			this.each(function() {				
				var _this = $(this);
				_this = _initBorder(_this);//初始化外框CSS
				_this = _initInput(_this);//初始化输入框
				_initSelect(_this);//初始化下拉列表
				_initContent(_this);				
			});
		};
})(jQuery);