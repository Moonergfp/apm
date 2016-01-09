(function($){
	$.fn.webuploader = function(options) {
		var defaults = {  
            initPicker: "picker",//选择文件按钮，必填项，且在同页上唯一
            initList: "file_list",//
            initBtn: "file_btn",//状态按钮，必填项，且在同页上唯一
            initState:"uploadState",//状态标识，可选项            
			ctx:"",	//项目路径，必填项，用于访问服务器资源，删除文件使用
			ctxStatic:"",//访问静态资料，用户展示上传图标
			imgUrl:"",//文件按钮图像路径，如果设置为空 则 调用默认图片路径
			beUsed:false,//true 初始化文件选择按钮
			folderName:"",//文件夹名字，标识，路径。
			
            serverPath:"",//上传文件到服务器的地址
            pickNum:true,//单文件选取，默认为多选
            fileNum:5,//队列里的文件数量
            extenName:"",//允许上传文件的类型,""默认为允许上传所有 bmp,gif,jpg,jpeg,png,pcx,doc,docx,xls,xlsx,ppt,pptx,html,htm,txt,pdf,java,rar,zip,gz
            uploadAuto:false,//文件自动上传
            needNotes:false,//是否需要备注

            simpleAuto:false,//简单自动上传，适用于上传头像类，只调用上传成功的方法
            uploadDoValue:false,//是否调用uploader的input值的处理方法。如果为true，则值的处理交给调用者，如果为false，默认交给uploader
            uploadValueInput:"uploadValInput",//用于存储值得input框
            uploadValueInputArr:[],
            useModal:false,//使用弹出modal实现上传
            modalName:"uploaderModal",//弹出层的名字
            modalDesc:"",//弹出框下面进行的描述

            customlist:false,//是否自定义上传文件列表
            needDate:false,//是否需要显示每个文件上传的时间
            chunked:false,//是否分片上传
		    chunkSize:2097152,//分片尺寸默认2兆
		    threads:3, //[默认值：3] 上传并发数,允许同时最大上传进程数。
		    initPickerShowName:"选择上传文件",
		    uploadPassHideKey:false,//上传完成后隐藏上传按钮
		    listChangeFlag:false,//文件列表变更触发change事件
		    delBtnImg:false,//删除改为用图片
		    previewFlag:false,//上传成功的文件提供预览功能
		    previewSuffix:["bmp","gif","jpg","jpeg","png"],//预览支持的格式(数组的参数用小写字母，实际判断时会把文件后缀转为小写来判断)，配合previewFlag:true使用
        };

        var options = $.extend(defaults, options);
        var $btn = $("#"+options.initBtn);
        var $list = $("."+options.initList);
        var state = options.initState;
        
        /**
		 * initDiv 实例化上传必须的html元素
		 * @param $divBody
		 */	
	    function initDiv($divBody){
	    	var aBtn = '<a id="'+options.initPicker+'">'+options.initPickerShowName+'</a>'+'&nbsp&nbsp&nbsp<a id="'+options.initBtn+'" class="start_file">开始上传</a>';
	    	var divList = '<div class="'+options.initList+'"></div>';
	    	var divBody = '<div>';
	    	if(options.ctxStatic!=""){
	    		var imgUrl = options.imgUrl;
	            if(imgUrl==""){
	           	 imgUrl = options.ctxStatic+"/webupload/css/link1.png";
	            }
	       		var img = '<img src="'+imgUrl+'"/>';
	    		divBody = divBody +img;
	    	}
	    	if (!options.customlist) {
	    		divBody = divBody+aBtn+'</div>'+divList;
	    	}else{
	    		divBody = divBody+aBtn+'</div>';
	    	}
	    	
	    	if(options.useModal){//使用弹出层
	    		divBody = createModalHtml(divBody);
	    	}
	    	$divBody.append(divBody);
	        $btn = $("#"+options.initBtn);
	        $list = $("."+options.initList);
	        $list.addClass("fileList");
	        if(options.useModal){//添加样式
	    		$("#"+options.initPicker).addClass("xm-btn");
	    		$("#"+options.initBtn).addClass("xm-btn");
	    		$("#"+options.modalName).addClass("init-modal");
	    	}
	    	return $divBody;
	    }    
        
         /**
		 * createModalHtml 创建modal必须的html
		 * @param divBody
		 */	
	    function createModalHtml(divBody){
	    	var top = "<div id='"+options.modalName+"' class='modal xm-modal' style='width:500px'><div class='modal-header'><button type='button' class='close "+options.modalName+"_cbnt'>×</button><h4>上传文件</h4></div><div class='modal-body'>";
	    	var bottom = "</div><div class='modal-footer xm-footer'><div style='margin-top:5px;text-align:left;margin-left:10px;'>"+options.modalDesc+"</div><button class='xm-btn xm-back "+options.modalName+"_cbnt'>关闭</button></div></div>";
	    	divBody = top+ divBody + bottom;
	    	return divBody;
	    }

	    /**
		 * initModal 实例化监听操作modal
		 * @param $modal modal外框对象
		 */	
	    function initModal($modal){

	    	$modal.delegate("."+options.modalName,"click",function(){

			   	$("body").append('<div class="modal-backdrop fade in"></div>');
        		$("#"+options.modalName).css("z-index","1050").animate({"opacity":1,"top":"10%"},800);
		   });

	    	$modal.delegate("."+options.modalName+"_cbnt","click",function(){
			   	$("body").find('.modal-backdrop').remove();
	            $("#"+options.modalName).animate({"opacity":0,"top":"0","z-index":"-10"},800);
		   });
	    	return $modal;
	    }

		/**
		 * uploaderCreate 此方法用于实例化webupload对象
		 * @param path 服务上传的路径
		 * @param pickId HTML元素之上传按钮的ID值
		 * @param pickNum 添加文件到队列的个数 false，一个；true 为多个
		 * @param fileNum 队列文件的个数
		 * @param extenName 后缀名字，多个用逗号隔开
		 * @param auto true为自动上传文件，false为手动
		 */	
		function uploaderCreate(uploader){
			var path = options.serverPath;
	        if(path==""){
	        	path = options.ctx+"/fileInfosa/uploader";
	        }
	        path = path+"?folderName="+options.folderName+"&uploadType=" + options.uploadType+"&terminalId=" + options.terminalId  ;
			uploader = WebUploader.create({
				pick: {id:"#"+options.initPicker,multiple :options.pickNum},//只允许选择一个
				auto: options.uploadAuto,
				//threads :1, //[默认值：3] 上传并发数,允许同时最大上传进程数。
			    server:path,
			    fileNumLimit:options.fileNum, //验证文件总数量, 超出则不允许加入队列。注：有时不起作用
			    chunked:options.chunked,//是否分片上传
			    chunkSize:options.chunkSize,//分片尺寸默认2兆
			    threads:options.threads, //[默认值：3] 上传并发数,允许同时最大上传进程数。
			    accept: {
			        title: 'uploadFile',
			        extensions: options.extenName,
			        mimeTypes: '/*'
			    }
			 });
			//初始化时判断是否已存在目录,没有则创建
			validDir();
			return uploader;
		}
		
		/**
		 * 初始化时判断是否已存在目录结构,没有则创建
		 */
		function validDir(){
			 $.ajax({
				    async: false,
					url:"/apm-web/a/fileInfosa/validDir",
    				type:'post',
    				dataType:'text',
    				data:{},
    				success:function(data){
    					console.log(data);
    					 if(data != "ok"){
    						 top.$.jBox.tip("服务器未配置顶级目录,如:apm_file,无法上传文件");
    					 }
    				},error:function(){
    					top.$.jBox.tip("服务器出错");
    				}
    			});
		}
		
		/**
		 * uploaderSuccess 文件上传成功，提示，并返回封装好的json对象
		 * @function getFileDetail可自定义此方法，获得服务器端返回的数据，文件名，webupload生成的文件ID
		 */
		function uploadSuccess(uploader){
			 uploader.on( 'uploadSuccess', function( file ,response) {
		        $("#"+file.id).find("span[class='"+options.initState+"']").text('上传成功');
		        var msg = response["_raw"];
		        if(msg.indexOf("false")!=-1){
		     	    $("#"+file.id).find("span[class='"+options.initState+"']").text('上传出错，'+msg.split(",")[1]);
		     	    if (options.needNotes) {
				       	/*$( '#'+file.id ).find(".progressbg").fadeOut();*/
				       	$( '#'+file.id ).find(".msgerror").show().click(function(){
				       		$( '#'+file.id ).find(".progressbg").fadeOut();
				       		$(this).fadeOut();
				       	});
				       };
		        	return;
		        }else{
		        	$("#"+file.id).find("span[class='"+options.initState+"']").text('上传成功');
		        	if (options.needNotes) {
		        		$( '#'+file.id ).find(".filenote_content").attr("contenteditable","false").css("border-bottom",0);
				       	$( '#'+file.id ).find(".msgsucess").show().click(function(){
				       		$( '#'+file.id ).find(".progressbg").fadeOut();
				       		$(this).fadeOut();
				       	});
				    };
				    
				    if (options.uploadDoValue) {//使用系统的存值方式
				    	setFileValInput(msg,file.name,file.id);
				    }else{
				    	getFileDetail(msg,file.name,file.id);
				    };
		        	
		        	setFileId(msg,file.id);
		        	previewUrl = options.ctx+"/fileInfosa/readlocalPic?id="+$("#"+file.id).find(".deleteFile span").html()+"#";
		        	if(options.previewFlag){
		        		var fileExtension = $("#"+file.id).find(".filename").html().split('.').pop().toLowerCase();
		        		if(options.previewSuffix.indexOf(fileExtension)!=-1){
		        			/*$("#"+file.id).find(".deleteFile").after("<a href='"+previewUrl+"' rel='prettyPhoto[gallery2]' title='' class='previewFileBtn'><img class='previewFile eye-open' style='padding-left:8px;width:27px;height:17px;visibility:hidden' src='"+previewUrl+"' fid='"+$("#"+file.id).find(".deleteFile span").html()+"' fileName='"+$("#"+file.id).find(".name").html()+"' alt='"+$("#"+file.id).find(".name").html()+"'></a>");*/
		        			$("#"+file.id).find(".deleteFile").after("<a class='go' href='"+previewUrl+"' rel='gallery' title='"+$("#"+file.id).find(".name").html()+"'><img src='/lms-web/static/defindUpload/css/eye-open.png'></a>");
		        			
		        		}else{
		        			$("#"+file.id).find(".deleteFile").after("<img class='previewFile' style='padding-left:8px;' src='"+options.ctxStatic+"/defindUpload/css/eye-close.png'>");
		        				        		
		        		}
		        	}
		        }
		        function a(){
					$("#fullResImage").z("destroy").z()
				}
				function g(){
					$("#fullResImage").z("destroy")
				}
			 });
			 return uploader;
		}

		/**
		 * uploaderQueued 此方法用于将文件放入队列 并显示删除队列文件的按钮  显示开始上传按钮
		 * @param $list HTML元素 用于存放后新增的内容  
		 */
		function uploaderQueued(uploader){
			uploader.on( 'fileQueued', function( file ) {
				var new_file=document.createElement("div");
				var nowDate;
				if (options.needDate) {
					nowDate=getnowTime();
					$(new_file).attr({
						"createDate":nowDate,
					});
				};
				var delContent = null; 
				if(options.delBtnImg){
					delContent = "<img src='"+options.ctxStatic+"/defindUpload/css/del.png'>"
				}else{
					delContent = "删除"; 
				}
				
				$(new_file).attr({
					"id":file.id,
				});
				var filelist="<span style='display:none' class='name'>"+file.name+"</span>"+"<span class='filename'>"+getFileName(file.name)+"</span>"+"<span class='"+options.initState+"'> 等待上传....</span>"+"&nbsp;&nbsp;<a name='"+$btn.attr("id")+"' class='deleteFile'>"+delContent+"<span style='display:none'></span></a>";
				$(new_file).append(filelist);
				if (options.needNotes) {
					var new_note=document.createElement("div");

					var new_notes="<span class='filenote_name'>备注信息</span><div class='filenote_content' contenteditable='true'></div><input class='fileinput' type='hidden' name='"+file.id+"'/>";
					$(new_note).attr({
						"class":"filenote"
					}).append(new_notes).find(".filenote_content").blur(function(){
						var data=$(this).html();
						$(this).siblings("input").val(data);
					});

					$(new_file).attr({
						"class":"file filelistn"
					});

					$(new_file).append(new_note);
				}else{
					$(new_file).attr({
						"class":"file"
					});
				}

				$list.append(new_file);
				if(options.listChangeFlag){
					$list.change();
				}
				$btn.show();
		    });

		    return uploader;
		}

		//获取当前时间
		function getnowTime(){
			var now=new Date();
			var year=now.getFullYear();
	    	var month = now.getMonth() + 1;     //月
	        var day = now.getDate();            //日
	        var hh = now.getHours();            //时
	        var mm = now.getMinutes();          //分
	            
	        if(month<10){
	          month="0"+month;
	        }

	        if (day<10) {
	        	day="0"+day;
	        };
	            
	        if(mm<10){
	           mm="0"+mm;
	        }

	        var nowDate=year+"-"+month+"-"+day;

	        return nowDate;
		}

		/**
		 * uploaderBody 文件上传过程中的状态，正在上传、上传成功、暂停上传、上传失败等提示
		 */
		function uploaderBody(uploader){
			uploader.on( 'uploadProgress', function( file, percentage ) {
		        var $li = $( "#"+file.id );
		        if (options.needNotes) {
		        	$percent = $li.find(".progress .bar");
		        	if (!$percent.length) {
		        		var progressbg=document.createElement("div");
			        	$(progressbg).attr({
			        		"class":"progressbg"
			        	});
			        	var percent='<div class="progress progress-striped active lmsprogress"><div class="bar"></div></div>'
			        	$li.append(progressbg);
			        	$li.append(percent);
			        	$percent=$li.find(".progress .bar");

			        	var showmsg="<div class='msgsucess'><span class='icon-ok-sign'></span><div>上传成功</div></div><div class='msgerror'><span class='icon-remove-sign'></span><div>上传出错</div></div>";
			        	$li.append(showmsg);
		        	};
		        }else{
		        	$percent = $li.find('.progress .progress-bar');
			        if ( !$percent.length ) {
			            $percent = $('<div class="progress">' +
			             '<div class="progress-bar progress-bar-striped active">' +'</div>' +'</div>').appendTo( $li ).find('.progress-bar');
			        }
		        }
		        
		        $("#"+file.id).find("span[class='"+options.initState+"']").html(' 上传中....');
		        $percent.css( 'width', percentage * 100 + '%' );
		        if (options.needNotes) {
		        	$percent.text(parseInt(percentage * 100) + '%')
		        };
		    });

		   uploader.on( 'uploadError', function( file ) {
		       $("#"+file.id).find("span[class='"+options.initState+"']").text(' 上传出错');
		       $( '#'+file.id ).find('.progress').fadeOut();
		       if (options.needNotes) {
		       	/*$( '#'+file.id ).find(".progressbg").fadeOut();*/
		       	$( '#'+file.id ).find(".msgerror").show().click(function(){
		       		$( '#'+file.id ).find(".progressbg").fadeOut();
		       		$(this).fadeOut();
		       	});
		       };
		   });

		   uploader.on( 'uploadComplete', function( file) {
		      $( '#'+file.id ).find('.progress').fadeOut();
			 //上传完成后隐藏上传按钮
			 if(options.uploadPassHideKey){
				 var $lenght = uploader.getStats().queueNum;
				 if($lenght==0){
					 $btn.hide(); 
				 }
			 }
		   });
		   uploader.on( 'all', function( type ) {
		       if ( type === 'startUpload' ) {
		           state = 'uploading';
		       } else if ( type === 'stopUpload' ) {
		           state = 'paused';
		       } else if ( type === 'uploadFinished' ) {
		           state = 'done';
		       }

		       if ( state === 'uploading' ) {
		           $btn.text('暂停上传');
		       } else {
		           $btn.text('开始上传');
		       }
		   });

		   $btn.on( 'click', function() {
		       if ( state === 'uploading' ) {
		           uploader.stop();
		       } else {
		           uploader.upload();
		       }
		   });
		   
		   $list.delegate(".deleteFile","click",function(){	
			   deleteFile(this,uploader,this);
		   });
		   $("#iviewer .controls").delegate("#btn_del","click",function(){
			  deleteFile($list.find('.deleteFile').eq($(this).attr('title')),uploader,this);
			  
		   });
		   $("body").delegate(".previewSwitch","click",function(){
				var fid = $(this).attr("fid");
				var fileName = $(this).attr("fileName");
				$('#previewDiv').remove();
				$('#previewMask').remove();
				previewPic(fid,fileName);
		   });
		   
		   return uploader;
		}


		//暂时不做
		function uploaderMd5Blob(){
			//完整文件校验是否已上传
		    WebUploader.Uploader.register({
		        'before-send-file': 'preupload'
		    }, {
		        preupload: function( file ) {
		            var me = this,
		                owner = this.owner,
		                server = me.options.server,
		                deferred = WebUploader.Deferred(),
		                blob = file.source.getSource();

		            md5Blob( blob )

		                // 如果读取出错了，则通过reject告诉webuploader文件上传出错。
		                .fail(function() {
		                    deferred.reject();
		                })
		                // md5直接计算完成
		                .then(function( md5 ) {
		                    // 与服务安验证
		                    $.ajax({
							url:"${ctx}/projectFile/fileVal",
		       				type:'post',
		       				dataType:'text',
		       				data:{"md5":md5,"fileName":file.name},
		       				success:function(data){
		       					if(data =="true"){
		       					 	deferred.reject();
		       					 	var fileId =file.id;
		       					 	//uploader.removeFile(fileId);
		       					 	$("#"+fileId).remove();
		       					 	top.$.jBox.tip("文件重复，不能上传。");
		       					}else if(data == "false"){
		       						deferred.reject();
		       					 	var fileId =file.id;
		       					 	//uploader.removeFile(fileId);
		       					 	$("#"+fileId).remove();
		       					 	top.$.jBox.tip("此文件无后缀，请重新上传。");
		       					}else{
		       						deferred.resolve();
		       					}
		       				},error:function(){
		       					top.$.jBox.tip("服务器出错");
		       				}
		       			});
		             });
		            return deferred.promise();
		        }
		    });
		}

		/**
		 * setFileValInput 将数据库生成的文件ID存于input框待使用。
		 * @param $list<a> fileId数据库生成的文件id
		 */
		function setFileValInput(fileId,fileName,file_id){
			//判断是否存在存值input框，如果不存在则创建，如果存在则往里面放值
			var storeObj = options.uploadValueInputArr;
			//ID隐藏域
			var sId = options.uploadValueInput;
			var sObj = $("#"+sId);
			
			if(storeObj.length>0){//已经赋值过
				console.log("已经赋值过");
				console.log('oldVal');	
				var oldVal = storeObj;
				console.log(oldVal);
				console.log('newval');	
				storeObj.push(fileId);
				console.log(storeObj);
				//ID隐藏域赋值
				sObj.val(storeObj.join(","));
			}else{//第一次赋值
				console.log("第一次赋值");
				storeObj.push(fileId);
				//创建ID隐藏域
				var msgVal = "<input type='hidden' id='"+sId+"' name='"+sId+"' value='"+fileId+"' />";
				$('#'+file_id).append(msgVal);
			}
		}

		/**
		 * setFileId 将数据库生成的文件ID放入$list<a>中便于删除，当然可以用路径
		 * @param $list<a> fileId数据库生成的文件id
		 */
		function setFileId(fileId,file_id){
			$("#"+file_id).find(".deleteFile").children("span").html(fileId);
		}

		/**
		 * removeQue 删除队列里的文件
		 * @param fileId webupload生成的唯一的文件ID
		 */
		function removeQue(fileId,uploader){
			uploader.removeFile(fileId);
		}

		/**
		 * getFileName 用于封装文件名的长度，如果文件名过长，截取
		 * @param fileName 文件名字
		 */
		function getFileName(fileName){
			if(fileName.length>15){
				var s1 = fileName.substring(0,5);
				var s2 = fileName.substring(fileName.lastIndexOf("."),fileName.length);
				var s3 = fileName.substring(fileName.lastIndexOf(".")-2,fileName.lastIndexOf("."));
				fileName = s1+"..."+s3+s2;
			}
			return fileName;
		}

		/**
		 * uploadeDeleteFile 用于封装文件名的长度，如果文件名过长，截取
		 * @param fileName 文件名字
		 */
		function uploadeDeleteFile(fileId,fileName,file_Id){			
			var inputVal = options.uploadValueInputArr;
			console.log(inputVal);
			for(v in inputVal){
				if(inputVal[v] == fileId){
					console.log('删除的v');
			 		console.log(v);
					inputVal.splice(v,1);
			 		console.log("遍历删除后的数组");
			 		console.log(inputVal);
			 		break;
				}
			}
		 	//更新ID隐藏域
			var sObj = $("#"+options.uploadValueInput);
			sObj.val(inputVal.join(","));
		}

		//预览文件
		function previewFile(obj,uploader){
			var parent = $(obj).parent();
			var fid = $("#"+parent.attr("id")).find(".deleteFile span").html();
			var fileName = $("#"+parent.attr("id")).find(".filename").html();
			
			previewPic(fid,fileName);
			//var fids = $("#"+options.uploadValueInput).val();
/*			var fids = "";
			var eveOpen = $(".eye-open");
			for(var i=0;i<eveOpen.length;i++){
				if(i == 0){
					fids += $(eveOpen[i]).attr("fid");
				}else{
					fids += ","+$(eveOpen[i]).attr("fid");
				}				
			}
			
			
			
			//遮罩
			//$("html").css({height:"100%",width:"100%"});
			//$("body").css({height:"100%",width:"100%"});
			var iWidth = document.body.clientWidth;
			//var iHeight = window.screen.availHeight; 
			var preview_mask = document.createElement("div");
			$(preview_mask).attr("id","previewMask").css("z-index","29999").css("background-color","#000000").css("opacity","0.5").css("-moz-opacity","0.5").css("filter","alpha(opacity=50)").css({position:"fixed",top:"0px",left:"0px",width:"100%",height:"100%"});
			
			//画布
			var preview_div = document.createElement("div");
			$(preview_div).attr("id","previewDiv").css("z-index","30000").css({position:"absolute",left:"0",top:"0",width:"100%"}).attr("align","center");
			
			//行
			//var preview_close = document.createElement("span");
			//$(preview_close).attr("id","previewClose").addClass("pull-right").css({position:"absolute",left:"91%",top:"-30px",color:"red"}).css("font-size","30px").attr("onclick","$('#previewMask').remove();$('#previewDiv').remove();").html("x");
			var preview_line = document.createElement("div");
			$(preview_line).attr("id","previewLine").css({position:"absolute",left:"0",top:"0",color:"red",height:"22px",width:"100%"}).css("background-color","blue").css("line-height","22px").css("font-size","18px").attr("onclick","$('#previewMask').remove();$('#previewDiv').remove();");
			
			//文件名
			var preview_name = document.createElement("span");
			$(preview_name).attr("id","previewName").addClass("pull-left").css("line-height","22px").css("font-size","18px").css({color:"#FFF"}).html(fileName);
			
			//删除按钮
			var preview_close = document.createElement("span");
			$(preview_close).attr("id","previewClose").addClass("pull-right").css({color:"#FFF"}).css("font-size","15px").css("line-height","22px").attr("onclick","$('#previewMask').remove();$('#previewDiv').remove();").html("x");

			//上一页
			var preview_close = document.createElement("img");
			$(preview_close).attr("id","previewPrev").css({position:"fixed",top:"0px",left:"0px",width:"100%",height:"100%"}).attr("src",options.ctxStatic+"/defindUpload/css/del.png");
			
			//图片
			var previewUrl = options.ctx+"/fileInfosa/readlocalPic?id="+fid+"#";
			var preview_file = document.createElement("img");
			$(preview_file).attr("id","previewImg").css({top:"25px"}).attr("src",previewUrl);
			
			//var previewUrl = options.ctx+"/fileInfosa/readlocalPic?id="+fid+"#";
			//var preview_file = document.createElement("img");
			//$(preview_file).attr("id","previewImg").css({position:"absolute",width:"90%"}).attr("src",previewUrl);
			
			$(preview_line).append(preview_name);
			$(preview_line).append(preview_close);
			$(preview_div).append(preview_line);
			$(preview_div).append(preview_file);
			$("body").append(preview_mask);
			$("body").append(preview_div);*/
/*			
 			//iframe 图片和其他
 			var previewUrl = options.ctx+"/fileInfosa/previewFile?sourceFile="+fid+"&&fids="+fids+"#";
			
			var preview_file = document.createElement("iframe");
			var x = window.screen.width*0.8+"";
			var y = window.screen.height+"";
			$(preview_file).attr("id","previewIframe").css({position:"fixed",left:"5px",top:"5px",width:x,height:y}).attr("src",previewUrl);
			parent.before(preview_file);*/
		}
		
		//预览图片（显示）
		function previewPic(fid,fileName){
			var fids = "";
			var eveOpen = $(".eye-open");
			for(var i=0;i<eveOpen.length;i++){
				if(i == 0){
					fids += $(eveOpen[i]).attr("fid");
				}else{
					fids += ","+$(eveOpen[i]).attr("fid");
				}				
			}
			
			var prev = null;
			var prevName = null;
			var next = null;
			var nextName = null;
			if(eveOpen.length>0){
				for(var i=0;i<eveOpen.length;i++){
					if($(eveOpen[i]).attr("fid")==fid){
						if(i+1<eveOpen.length){
							next = $(eveOpen[i+1]).attr("fid");
							nextName = $(eveOpen[i+1]).attr("fileName");
						}
						break;
					}else{
						prev = $(eveOpen[i]).attr("fid");
						prevName = $(eveOpen[i+1]).attr("fileName");
					}
				}
			}
			
			//遮罩
			//$("html").css({height:"100%",width:"100%"});
			//$("body").css({height:"100%",width:"100%"});
			var iWidth = document.body.clientWidth*0.8+"px";
			//var iHeight = window.screen.availHeight; 
			var preview_mask = document.createElement("div");
			$(preview_mask).attr("id","previewMask").css("z-index","29999").css("background-color","#000000").css("opacity","0.5").css("-moz-opacity","0.5").css("filter","alpha(opacity=50)").css({position:"fixed",top:"0px",left:"0px",width:"100%",height:"100%"});
			
			//画布
			var preview_div = document.createElement("div");
			$(preview_div).attr("id","previewDiv").css("z-index","30000").css({position:"absolute",left:"0",top:"0",width:"100%"}).attr("align","center");
			
			//行
			//var preview_close = document.createElement("span");
			//$(preview_close).attr("id","previewClose").addClass("pull-right").css({position:"absolute",left:"91%",top:"-30px",color:"red"}).css("font-size","30px").attr("onclick","$('#previewMask').remove();$('#previewDiv').remove();").html("x");
			var preview_line = document.createElement("div");
			$(preview_line).attr("id","previewLine").css({position:"fixed",left:"0",top:"0",color:"red",height:"20px",width:"100%"}).css("background-color","#0C90D1").css("line-height","20px").css("font-size","18px");
			
			//文件名
			var preview_name = document.createElement("span");
			$(preview_name).attr("id","previewName").addClass("pull-left").css("line-height","20px").css("font-size","16px").css({color:"#FFF"}).html(fileName);
			
			//删除按钮
			var preview_close = document.createElement("span");
			$(preview_close).attr("id","previewClose").addClass("pull-right").css({color:"#FFF",height:"20px"}).css("font-size","17px").css("line-height","20px").attr("onclick","$('#previewMask').remove();$('#previewDiv').remove();").html("x");

			//上一页
			var preview_prev = document.createElement("img");
			$(preview_prev).attr("id","previewPrev").addClass("previewSwitch").attr("fid",prev).attr("fileName",prevName).css("max-width","80px").css({position:"fixed",top:"320px",left:"80px"}).attr("src",options.ctxStatic+"/defindUpload/css/prev.png");
			
			//下一页
			var preview_next = document.createElement("img");
			$(preview_next).attr("id","previewNext").addClass("previewSwitch").attr("fid",next).attr("fileName",nextName).css("max-width","80px").css({position:"fixed",top:"320px",right:"80px"}).attr("src",options.ctxStatic+"/defindUpload/css/next.png");

			//图片
			var previewUrl = options.ctx+"/fileInfosa/readlocalPic?id="+fid+"#";
			var preview_file = document.createElement("img");
			$(preview_file).attr("id","previewImg").css("padding-top","30px").css("max-width",iWidth).attr("src",previewUrl);
			
			//var previewUrl = options.ctx+"/fileInfosa/readlocalPic?id="+fid+"#";
			//var preview_file = document.createElement("img");
			//$(preview_file).attr("id","previewImg").css({position:"absolute",width:"90%"}).attr("src",previewUrl);
			
			$(preview_line).append(preview_name);
			$(preview_line).append(preview_close);
			if(prev!=null){
				$(preview_line).append(preview_prev);
			}
			if(next!=null){
				$(preview_line).append(preview_next);
			}
			$(preview_div).append(preview_line);
			$(preview_div).append(preview_file);
			$("body").append(preview_mask);
			$("body").append(preview_div);
		}
		
		//文件删除
		function deleteFile(obj,uploader,objThis){
		    	top.$.jBox.confirm("确认要删除该项吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						var file_Id = $(obj).parent().attr("id");
						var tr = $(obj).parent();
						var btn = $(obj).attr("name");
						var fileId = $(obj).children("span").html();						
						var fileName = $(obj).siblings(".name").html();
						if(fileId.length != 0){
							//发送异步删除文件，异步请求设置为同步
							if(ajaxDeleteFile(fileId,fileName)){								
								if (options.uploadDoValue) {//使用系统的存值方式
				    				uploadeDeleteFile(fileId,fileName,file_Id);
				    			}else{
				    				if (!options.needNotes) {
						  				toDeleteFile(fileId); //去除页面id
						  			};
				    			};				    			
								removeQue(file_Id,uploader);
						       	tr.remove();
						       	var $lenght=$("#"+file_Id).parent().find("div[class='file']").length;
						  		if($lenght==0){
						  			$("#"+btn).hide(); 
						  		}				  		
						       	top.$.jBox.tip("删除成功!");
							}else{
								top.$.jBox.tip("删除失败!");
							}
						}else{
							var num = uploader.getStats().queueNum;
							removeQue(file_Id,uploader);
					       	tr.remove();
					       	if(num == 1||num == 0){
					       		$("#"+btn).hide(); 
					       	}
						}
						if(options.listChangeFlag){
							$list.change();
							if($(objThis).hasClass('deleteFile')){
							}else{
								ob = true;							
								if($("#iviewer #nextLink").attr('href') !="#"){								 
								   $("#nextLink.go").click();
								}else if($("#iviewer #prevLink").attr('href') !="#"){								   
								   $("#prevLink.go").click();
								}else{
									$(".closePreview").click();
								}
								ob = false;
							}
							
						}
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css({'top':'55px'});
				
				
		}

		//文件删除
		function ajaxDeleteFile(fileId,fileName){
			
			var delUrl = options.ctx+"/fileInfosa/uploadDel";
			var t = 0;
			$.ajax({
		   		url:delUrl,
		   		type:'post',
		   		async:false,
		   		dataType:'text',
		   		data:{"fileId":fileId,"fileName":fileName},
		   		success:function(data){
		   			if(data == "true"){
		   				t=1;
		   			}
		   		},error:function(){
		   			top.$.jBox.tip("删除失败："+"服务器出错");
		   		}
		   	}); 
			if(t==1){
			
				return true;
			}else{
				return false;
			}
		}	

			this.each(function() {				
				var _this = $(this);
				if(options.beUsed){//初始化Div框
				  _this = initDiv(_this);
				}
				
				if (options.useModal) {//使用
					_this = initModal(_this);
				};

				if (options.simpleAuto) {
					options.uploadAuto = true;
					_this = uploaderCreate(_this);//初始化uploader
					_this = uploadSuccess(_this);//上传成功
				}else{
					_this = uploaderCreate(_this);//初始化uploader
					_this = uploadSuccess(_this);//上传成功
					_this = uploaderQueued(_this);//文件放置队列
					_this = uploaderBody(_this);//进度条显示
				}
			});
		};
})(jQuery);