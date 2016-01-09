<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>终端信息列表</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
	/* 这两个背景色针对左侧分组 */
	.colorSelect{
		background-color: #E8E8E8;
	}
	.colorNotSelect{
		background-color: white;
	}
	/* 这两个背景色针对右侧终端 */
	._colorSelect{
		background-color: #E8E8E8;
	}
	._colorNotSelect{
		background-color: white;
	}
	body{
	 	margin-left:0;
	 	margin-right:0;
	 	padding-left:11%;
	 	padding-right:10%;
	 }
	 .div_top{
		margin-top: 2%;
	}
	.nav, .breadcrumb {
		margin-bottom: 0px;
	}
	.nav-tabs {
		border-bottom: 0px;
	}
	.div_bottom{
	   	border-bottom: 1px solid #ddd;
	}
	.nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li>a:hover, .nav-tabs>li.active>a:hover{
		border: 0px;
		border-bottom: 5px solid #08C;
	}
	</style>
</head>
<body>
	<tags:message content="${message}"/>
	<div class="div_top">
		<div class="div_bottom">
			<ul class="nav nav-tabs">
				<li class="active"><a href="${ctx}/terminal/info">终端信息</a></li>
				<li><a href="${ctx}/terminalMonitor/monitor">终端监控</a></li>
				<li><a href="${ctx}/terminalSettings/screenShootPage">终端设置</a></li>
			</ul>
		</div>
	</div>
	
	<div style = "width:1070px;overflow:auto;box-shadow:0px 0px 3px #000;margin-top:15px;">
	
	<div style = "width:330px;float:left">
        <table class="table table-responsive table_left" style="border: 1px solid #D1D1D1;">
            <tr class = "addGroup">
            	<td>
            		<div style = "float:left;padding-top:7px;">
            			所有组（${totalTerminalNum }）&nbsp;&nbsp;
            		</div>
            		<div style = "float:right" class = "newButArea">
	            		<button type="button" class="btn btn-sm btn-info">
	            			新建
	            		</button>
            		</div>
            	</td>
            </tr>
            <tr class = "fixedUnDividedGroup" ondrop="drop(event)" ondragover="allowDrop(event)">
            	
            	<!-- 如果是初次进入此页面，那么默认选中未分组
            		   如果是删除终端后再返回此页面，则不会选中未分组，而选中删除的那个分组
            	 -->
            	<c:choose>
            		<c:when test="${selectedTerminalGroup.name == '未分组'}">
            			<td style = "cursor:pointer" class = "unDividedGroup colorSelect">
            		</c:when>
            		
            		<c:when test="${selectedTerminalGroup.name != '未分组'}">
            			<td style = "cursor:pointer" class = "unDividedGroup">
            	</c:when>
            	</c:choose>
            	
            		<input type = "hidden" value = "${unDivideGroup.id}" name = "unDivideGroup_id" id = "unDivideGroup_id">
            		<input type = "hidden" value = "${unDivideGroup.name}" name = "unDivideGroup_name" id = "unDivideGroup_name">
            		<a href = "javascript:void(0)" style = "text-decoration:none">
	            		未分组（${unDivideGroup.terminalNum}）
	            	</a>
            	</td>
            </tr>
            
            <c:forEach items="${terminalGroupList}" var="terminalGroup">
            	<!-- 如果是初次进入此页面，那么默认选中未分组
            		   如果是删除终端后再返回此页面，则不会选中未分组，而选中删除的那个分组
            	 -->
            	<tr ondrop="drop(event)" ondragover="allowDrop(event)">
            	<c:choose>
            		<c:when test="${empty selectedTerminalGroup.name}">
            			<td style = "cursor:pointer" class = "group">
            		</c:when>
            		<c:when test="${(not empty selectedTerminalGroup.name) && (selectedTerminalGroup.name == terminalGroup.name) }">
            			<td style = "cursor:pointer" class = "group colorSelect">
            		</c:when>
            		
            		<c:when test="${(not empty selectedTerminalGroup.name) && (selectedTerminalGroup.name != terminalGroup.name) }">
            			<td style = "cursor:pointer" class = "group">
            		</c:when>
            	</c:choose>
            	
            			<input type = "hidden" value = "${terminalGroup.id}" name = "terminalGroup_id" class = "terminalGroup_id">
            			<input type = "hidden" value = "${terminalGroup.name}" name = "terminalGroup_name" class = "terminalGroup_name">
            			<input type = "hidden" value = "${terminalGroup.terminalNum}" name = "terminalGroup_terminalNum" class = "terminalGroup_terminalNum">
            			<div style = "float:left">	
	            			<a href = "javascript:void(0)" style = "text-decoration:none">
	            				${terminalGroup.name }（${terminalGroup.terminalNum}）
	            			</a>
            			</div>
            		</td>
            	</tr>
            </c:forEach>
        </table>
    </div>
    
    <div style = "width:740px;float:left">
        <table class="table table-responsive terminalList table_right" style="border:1px solid #D1D1D1;">
            <tr>
            	<td colspan="7" class = "terminalList_header" style = "font-size:17px;font-weight:bold;">
            		<input type = "hidden" value = "${selectedTerminalGroup.id}" class = "selectedTerminalGroup_id" 
            			name = "selectedTerminalGroup_id">
            		<input type = "hidden" value = "${selectedTerminalGroup.name}" class = "selectedTerminalGroup_name" 
            			name = "selectedTerminalGroup_name">
            		${selectedTerminalGroup.name}（${selectedTerminalGroup.terminalNum }）
            	</td>
            </tr>
            <tr class = "terminalListTitle">
            	<td></td>
            	<td>终端ID</td>
                <td>终端名</td>
                <td>分辨率</td>
                <td>上线时间</td>
                <td>网络状态</td>
                <td>型号</td>
                <td>日志</td>
                <td style = "width:60px;"></td>
            </tr>
            
            <c:forEach items="${terminalList }" var="terminal" varStatus="status">
	            <tr class = "terminal_info">
	            	<td><input type = "hidden" id = "terminal_id" name = "terminal_id" value = "${ terminal.id}"></td>
	            	<td>${status.index+1}</td>
	                <td>${terminal.name }</td>
	                <td>${terminal.ratio }</td>
	                <td>${terminal.updateDate }</td>
	                <td>${terminal.status }</td>
	                <td>${terminal.terminalVersion }</td>
	                <td><a href = "javascript:void(0)" style = "text-decoration:none">查看</a></td>
	                <td></td>
	            </tr>
            </c:forEach>
        </table> 
        <div class="pagination">${page}</div>
    </div>   
    
    </div>
    
	<script type="text/javascript">

		// ==========================================
		// =================分页功能===================
		// ==========================================
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }

		
		// ==========================================
		// ================新建分组功能=================
		//  1. 需要判断是否已经锁屏（根据需要，不能点击其他，因为如果修改分组的时候，修改事务没结束，不能点击新建）
		//  2. 需要判断是否已经点击修改分组（根据需要，如果点击了修改，按其他的任何地方先保存。比如点击了修改分组，
		//		那么此时再点新建，则先保存，再点击新建才执行真正的新建代码）
		// ==========================================
		
		// block = true 表示锁屏；block = false 表示不锁屏
		var block = false;
		$('.newButArea').live("click",function(){
			if(block == false){
				//如果出现修改，删除按钮，但是未点修改，此时点击新建分组，那么去掉分组的删除，修改按钮
				$(".modifyAndRemoveBtn").remove();
				//防止重复点击新建，创建多条新建输入行
				$('.newGroupRow').remove();
				//再未分组下新增一个新建输入行
				$('.fixedUnDividedGroup').after(
					"<tr class = \"newGroupRow\">" +
						"<td class = \"newGroupRow_td\">" +
							"<div>" +
								"<input type = \"text\" maxlength=\"20\" name = \"newGroupName\"" + 
									"id = \"newGroupName\" class = \"form-control\" placeholder = \"分组名\"" +  
									"title=\"<h3>保存失败</h3>\" data-html=\"true\" data-placement=\"left\"" + 
									"data-content=\"原因：已有相同名字\">" +
							"</div>" +
						"</td>" +
					"</tr>"
				);
				
				//其他行取消背景，该新建输入行增加背景
				removeAllGroupRowBackgroundColor();
				$('.newGroupRow').removeClass("colorNotSelect");
				$('.newGroupRow').addClass("colorSelect");
				
				//点击了新建，那么就相当于锁屏了，需要先处理完新建的事务
				block = true;
			}
		})
		
		//取消全部行的背景选中状态
		function removeAllGroupRowBackgroundColor(){
			$('.group').removeClass("colorSelect");
			$('.group').addClass("colorNotSelect");
			$('.unDividedGroup').removeClass("colorSelect");
			$('.unDividedGroup').addClass("colorNotSelect");
			$('.newGroupRow').removeClass("colorSelect");
			$('.newGroupRow').addClass("colorNotSelect");
		}
		
		// ==========================================
		// ================点击 保存功能=================
		//  点击页面的任何一个地方，都进行保存。那么至于对 新建分组保存，
		//  还是对 修改分组名字保存，则需要再判断。
		//  Ps:由于使用 iframe，所以需要以下两个函数，不然捕捉不到所有的点击
		// ==========================================
			
		$("body",parent.document).click(function(event){
			saveNewGroupOrSaveModifyGroupName(event);
		});
		$("body").click(function(event){	
			saveNewGroupOrSaveModifyGroupName(event);
		});
		function saveNewGroupOrSaveModifyGroupName(event){
			//点击 新建文本框 和 修改名字文本框 不会当做保存操作
			if( ($(".newButArea").find(event.target).length == 1) ||
				($(".hasClickModify").find(event.target).length == 1) ||
				($(".newGroupRow_td").find(event.target).length == 1) 
			   )
				;
			else {
				//newGroupRow样式 用于 点击别的地方会保存该修改。是否保存的依据就是根据该样式
				var count = $('.newGroupRow').length;
				if(count > 0){
					//有新建的分组需要保存
					saveNewGroup();
				}
				
				//hasClickModify样式 用于 点击别的地方会保存该修改。是否保存的依据就是根据该样式
				var _count = $('.hasClickModify').length;
				if(_count > 0){
					//有修改的分组需要保存
					saveModifyGroupName();
				}
			}
		}
		
		// ==========================================
		// ================保存新建的分组=================
		// 如果新建分组名为空 默认命名为 未命名分组_20150215173423
		// ==========================================
			
		function saveNewGroup(){
			var newGroupName = $('#newGroupName').val();
			
			//如果新建分组名为空，那么按照Windows新建文件夹的思路，也可以新建，
			//名字为 未命名分组_20150215173423
			if(newGroupName.length == 0 ){
				var mydate = new Date();
				newGroupName = "未命名分组_" + mydate.getYear() + mydate.getMonth() 
								+ mydate.getDate() + mydate.getHours() 
								+ mydate.getMinutes() + mydate.getSeconds();
			}	
			
			$.ajax({
				url:'addNewGroup',
				dataType:'json',
				type:'post',
				data:{
					newGroupName:newGroupName
				},
				success:function(data){
					if(data.msg == 'success'){
						//插入新增加的数据
						$('.newGroupRow').remove();
						$('.fixedUnDividedGroup').after(
							"<tr ondrop=\"drop(event)\" ondragover=\"allowDrop(event)\">" +
								"<td class = \"group colorNotSelect\" style = \"cursor: pointer;\">" +
									"<input type = \"hidden\" value = \"" + data.terminalGroup.id +
										"\" name = \"terminalGroup_id\">" +
									"<input type = \"hidden\" value = \""+data.terminalGroup.name+
										"\" name = \"terminalGroup_name\">" +
									"<input type = \"hidden\" value = \"0\" " +
										"name = \"terminalGroup_terminalNum\">" +
									"<div style = \"float:left\">" + 
										"<a href = \"javascript:void(0)\" style = \"text-decoration:none\">" + 
											data.terminalGroup.name+"（0）</a>" + 
									"</div>" +
								"</td></tr>");
						
						//设置背景色为刚新建的分组
						removeAllGroupRowBackgroundColor();
						$($('.fixedUnDividedGroup').next().children().get(0)).removeClass("colorNotSelect");
						$($('.fixedUnDividedGroup').next().children().get(0)).addClass("colorSelect");
						
						block = false;
					} else{
						$('#newGroupName').popover('show');
						block = true;
					}
				},
				error:function(){
					alert("服务器出错，请重新登录，以避免不必要的错误");
					block = true;
				}
			})
		}
		
		
		// ==================================================
		// ===============终端分组背景色的显示和取消================
		//    		鼠标扫到分组上，分组背景被灰，鼠标移走，背景色变白
		// ==================================================
			
		$('.group').live("mouseover",function(){
			if(block == false){
				$(this).css("cursor","pointer");
				$(this).removeClass("colorNotSelect");
				$(this).addClass("colorSelect");
			}
		})
		$('.group').live("mouseout",function(){	
			if(block == false){
				if($('.colorSelect').length == 2){
					$(this).removeClass("colorSelect");
					$(this).addClass("colorNotSelect");
				}	
			}
		})
		
		
		// ==========================================
		// ===============点击某个分组================
		//    如果点击了其他的分组，会显示 修改，删除按钮，那么需要把其去掉，恢复正常；
		//		1.出现背景色 2.出现修改，删除按钮 3.并且右侧得到数据
		// ==========================================
			
		//记录这次点击修改的信息
		//因为如果下一步再点击其他分组项的时候，那么需要恢复
		var prevModify_id;
		var prevModify_name;
		var prevModify_num;
		
		$('.group').live("click",function(){
			if(block == false){
				//如果点击了其他的分组，那么把其他分组的修改，删除按钮去掉，当正常处理
				$(".modifyAndRemoveBtn").remove();
				 
				//该项出现修改，删除按钮
				$(this).append("<div class=\"modifyAndRemoveBtn\" " + 
									"style = \"float:right\">" + 
									"<button class=\"btn btn-sm btn-info modifyBut\" " + 
										"type=\"button\" \">修改</button>&nbsp;&nbsp; " + 
									"<a href=\"javascript:void(0);\" class=\"btn btn-sm " + 
										"btn-info\" onclick = \"deleteGroup(this);\" >删除</a> " + 
								"</div>");
				
				//加入背景色
				removeAllGroupRowBackgroundColor();
				$(this).addClass("colorSelect");
				$(this).removeClass("colorNotSelect");
					
				//请求该分组的终端信息
				var terminalGroup_id = $($(this).children().get(0)).val();
					
				 $.ajax({
					url:'getTerminalInfo_ajax',
					dataType:'json',
					type:'post',
					data:{
						terminalGroup_id:terminalGroup_id,
					},
					success:function(data){
						if(data.msg == 'success'){

							//右侧显示标题
							$('.terminalList_header').empty();
							$('.terminalList_header').append(
									data.selectedTerminalGroup.name + "（"+ 
									data.selectedTerminalGroup.terminalNum +"）");
							
							//右侧显示新的终端列表
							$(".terminal_info").remove();
							var size = data.terminalList.length;
							for(var i = size - 1; i >=  0; i--){
								var terminal = data.terminalList[i];
								$('.terminalListTitle').after(
										"<tr class = \"terminal_info\">" + 
											"<td><input type = \"hidden\" id = \"terminal_id\"" + 
													"name = \"terminal_id\" " + 
													"value = \""+ terminal.id +"\">" + 
											"</td>" + 
											"<td>"+ (i+1) +"</td>" + 
											"<td>"+terminal.name+"</td> " + 
											"<td> "+terminal.ratio+"</td> " + 
											"<td>"+ terminal.updateDate +"</td> " + 
											"<td>"+terminal.status+"</td> " + 
											"<td>"+terminal.terminalVersion+"</td> " + 
											"<td><a href = \"javascript:void(0)\" " + 
													"style = \"text-decoration:none\">查看</a> " + 
											"</td>" + 
											"<td></td>" + 
										"</tr>");
							}
							
							$('.pagination').empty();
							$('.pagination').append(data.page);
							
							$('.selectedTerminalGroup_id').val(data.selectedTerminalGroup.id);
							$('.selectedTerminalGroup_name').val(data.selectedTerminalGroup.name);
							
						} else{
							alert("服务器出错，请重新登录，以避免不必要的错误");
						}
					},
					error:function(){
						alert("服务器出错，请重新登录，以避免不必要的错误");
					}
				}) 
			
			}
		})
		
		
		// ==========================================
		// ===============点击未分组================
		//由于未分组和  一般的分组不一样，比如需要置顶，不能有编辑，删除按钮等。所以需要特殊处理
		//    如果点击了其他的分组，会显示修改，删除按钮，那么需要把其去掉，恢复正常；
		//    本身  1.出现背景色  2.并且右侧得到数据
		// ==========================================
		$('.unDividedGroup').live("click",function(){
			//如果保存新建的分组没有成功，会锁定屏幕
			if(block == false){
				//如果点击了其他的分组，那么把其他分组的修改，删除按钮去掉，当正常处理
				$(".modifyAndRemoveBtn").remove();
				//加入背景色
				removeAllGroupRowBackgroundColor();
				$('.unDividedGroup').addClass("colorSelect");
				$('.unDividedGroup').removeClass("colorNotSelect");
				
				//请求未分组的资源
				var terminalGroup_id = $('#unDivideGroup_id').val();
				$.ajax({
					url:'getTerminalInfo_ajax',
					dataType:'json',
					type:'post',
					data:{
						terminalGroup_id:terminalGroup_id,
					},
					success:function(data){
						if(data.msg == 'success'){
							
							//右侧标题的修改
							$('.terminalList_header').empty();
							$('.terminalList_header').append(
									data.selectedTerminalGroup.name + "（"+ 
									data.selectedTerminalGroup.terminalNum +"）");
							
							//右侧显示新的终端列表
							$(".terminal_info").remove();
							var size = data.terminalList.length;
							for(var i = size-1 ; i >= 0; i--){
								var terminal = data.terminalList[i];
								$('.terminalListTitle').after(
										"<tr class = \"terminal_info\">" + 
											"<td><input type = \"hidden\" id = \"terminal_id\"" + 
													"name = \"terminal_id\" " + 
													"value = \""+ terminal.id +"\">" + 
											"</td>" + 
											"<td>"+ (i+1) +"</td>" + 
											"<td>"+terminal.name+"</td> " + 
											"<td> "+terminal.ratio+"</td> " + 
											"<td>"+ terminal.updateDate +"</td> " + 
											"<td>"+terminal.status+"</td> " + 
											"<td>"+terminal.terminalVersion+"</td> " + 
											"<td><a href = \"javascript:void(0)\" " + 
													"style = \"text-decoration:none\">查看</a> " + 
											"</td>" + 
											"<td></td>" + 
										"</tr>");
							}
							
							$('.pagination').empty();
							$('.pagination').append(data.page);
							
							$('.selectedTerminalGroup_id').val(data.selectedTerminalGroup.id);
							$('.selectedTerminalGroup_name').val(data.selectedTerminalGroup.name);
						} else{
							alert("服务器出错，请重新登录，以避免不必要的错误");
						}
					},
					error:function(){
						alert("服务器出错，请重新登录，以避免不必要的错误");
					}
				}) 
				
			}
		})
		
		
		// ==========================================
		// ===============点击修改按钮================
		//                 出现输入框 
		// ==========================================
		$('.modifyBut').live("click",function(){
			
			//只要点击了修改，那么就会对屏幕进行锁定
			block = true;
			
			//hasClickModify样式 用于 点击别的地方会保存该修改。是否保存的依据就是根据该样式
			$(this).parent().parent().addClass("hasClickModify");
			
			//得到 该 分组的 id，name，num（该分组下有多少个终端），
			//并且放入全局变量，因为点击其他地方，会对修改进行保存
			var id = $($(this).parent().parent().children().get(0)).val();
			var name = $($(this).parent().parent().children().get(1)).val();
			var num = $($(this).parent().parent().children().get(2)).val();
			prevModify_id = id;
			prevModify_name = name;
			prevModify_num = num;
			
			//显示修改输入框
			var element_td = $($(this).parent().parent());
			$(element_td).empty();
			$(element_td).append("<div>" + 
									"<input type = \"text\" maxlength = \"10\" " + 
										"name = \"newModifyName\" id = \"newModifyName\" " + 
										"class = \"form-control\" value = \"" + name+ "\" " + 
										"title=\"<h3>保存失败</h3>\" data-html=\"true\" " + 
										"data-placement=\"left\" data-content=\"原因：已有相同名字\"> " + 
								"</div>");
		})
		
		
		// ==========================================
		// =============输入修改的分组名字后==============
		//             具体保存修改的组别名字 
		// ==========================================
		
		function saveModifyGroupName(){
			//得到新修改的分组名字
			var element_td = $($('#newModifyName').parent().parent());
			var newModifyName = $('#newModifyName').val();
			
			var valid = true;
			
			//验证新修改的名字的合理性
			if( (newModifyName.length == 0) || (newModifyName == prevModify_name) ) {
				//为空的时候，默认不修改，还是原来的
				$(element_td).empty();
				$(element_td).append("<input type = \"hidden\" value = \""+ prevModify_id + 
											"\" name = \"terminalGroup_id\">");
				$(element_td).append("<input type = \"hidden\" value = \"" + prevModify_name +
											"\" name = \"terminalGroup_name\">");
				$(element_td).append("<input type = \"hidden\" value = \""+ prevModify_num + 
											"\" name = \"terminalGroup_terminalNum\">");
				$(element_td).append("<div style = \"float:left\">" + 
										"<a href = \"javascript:void(0)\" " + 
											"style = \"text-decoration:none\">" + 
											prevModify_name+"（"+prevModify_num+"）" + 
										"</a>" + 
									"</div>");
				$(element_td).removeClass("hasClickModify");
				valid = false;
			}
			
			if(valid == true){
				$.ajax({
					url:'modifyGroupName',
					dataType:'json',
					type:'post',
					data:{
						id:prevModify_id,
						name:newModifyName
					},
					success:function(data){
						if(data.msg == 'success'){
							$(element_td).empty();
							$(element_td).append("<input type = \"hidden\" value = \""+prevModify_id + 
													"\" name = \"terminalGroup_id\">");
							$(element_td).append("<input type = \"hidden\" value = \""+newModifyName + 
													"\" name = \"terminalGroup_name\">");
							$(element_td).append("<input type = \"hidden\" value = \""+prevModify_num + 
													"\" name = \"terminalGroup_terminalNum\">");
							$(element_td).append("<div style = \"float:left\">" + 
													"<a href = \"javascript:void(0)\" " + 
														"style = \"text-decoration:none\">" + newModifyName + 
														"（"+prevModify_num+"）" + 
													"</a>" + 
												"</div>");
							
							$('.terminalList_header').empty();
							$('.terminalList_header').append(
									newModifyName + "（"+ prevModify_num +"）");
							
							$(element_td).removeClass("hasClickModify");
							block = false;
						} 
					},
					error:function(){
						alert("服务器出错，请重新登录，以避免不必要的错误");
						block = true;
					}
				})
			} else{
				valid = true;
				block = false;
			}
		}
		
		
		// ==========================================
		// =============删除分组==============
		//             具体保存修改的组别名字 
		// ==========================================
		function deleteGroup(element){
			var id = $($(element).parent().parent().children().get(0)).val();
			var href = "${ctx}/terminal/deleteGroup?id=" + id;
			return confirmx('确认要删除该用户吗？', href);
		}
		
		
		// ==========================================
		// =============终端部分背景色扫过===============
		// ==========================================
			
		//固定选中的终端背景色的数组
		var fixedBackgroundColorElement = new Array();
		
		$('.terminal_info').live("mouseover",function(){
			if(block == false){
				$(this).css("cursor","pointer");
				$(this).removeClass("_colorNotSelect");
				$(this).addClass("_colorSelect");
			}
		})
		
		$('.terminal_info').live("mouseout",function(){	
			if($(this).hasClass("fixedColor") == true) ;
			else {
				$(this).removeClass("_colorSelect");
				$(this).addClass("_colorNotSelect");
			}
		})
		
		// ==========================================
		// ===============单击终端信息==================
		// 1. 判断是否重复点击（有取消功能） --是：取消背景色；取消删除按钮，全局变量删除该项
		//                            不是：加入背景色，加入删除按钮，保存到全局变量中
		// ==========================================
		$('.terminal_info').live("click",function(){	
			if(block == false){
				//如果是点删除，那么该就不响应如下代码
				if(clickDeleteTerminal == false){
						
					//表明该点击是否取消操作
					var isCancel = false;
					
					//判断是否重复点击
					var flag = -1;
				    if($(this).hasClass("fixedColor") == true){
						for(var i = 0; i < fixedBackgroundColorElement.length; ++i){
							if( fixedBackgroundColorElement[i] == 
								$($($(this)).children().get(0)).find("#terminal_id").val() ){
								flag = i;
								isCancel = true;
								break;
							}
						}
					} 
				    
				    //如果是取消：取消背景色；取消删除按钮，全局变量删除该项
					if(isCancel == true){
						$(this).addClass("_colorNotSelect");
						$(this).removeClass("_colorSelect");
						$(this).removeClass("fixedColor");
						
						$($(this).children().get(8)).empty();
						
						fixedBackgroundColorElement.splice(i,1);
					}
					
					//如果不是取消：加入背景色，加入删除按钮，保存到全局变量中
					if(isCancel == false) {
						$(this).addClass("_colorSelect");
						$(this).removeClass("_colorNotSelect");
						$(this).addClass("fixedColor");
						
						//加入拖动的支持
						$(this).attr("draggable","true");
						$(this).attr("ondragstart","drag(event)");
						
						$($(this).children().get(8)).append("<a class = \"deleteArea\" href = \"javascript:void(0);\">删除</a>");
						
						fixedBackgroundColorElement.push($($($(this)).children().get(0)).find("#terminal_id").val());
					}
					
					//重置
					isCancel = false;
				} else {
					clickDeleteTerminal = false;
				}
			}
		})

		
		// ==========================================
		// ===============终端拖动功能==================
		// ==========================================
		function drag(ev){
			//这句不要也可以，因为数据放在了全局数组中，但是没有的话会没有阴影效果
			ev.dataTransfer.setData("Text",ev.target.id);
		}
		
		function drop(ev){
			ev.preventDefault();
			
			var groupId = $(ev.target).find(".terminalGroup_id").val();
			if(groupId == null){
				groupId = $(ev.target).find("#unDivideGroup_id").val();
			}
			if(fixedBackgroundColorElement.length != 0){
				var idArray = fixedBackgroundColorElement.join(",");
				
				var href = "${ctx}/terminal/transferTerminal?idArray=" + idArray + "&groupId=" + groupId;
				return confirmx('确认要删除该用户吗？', href);
			}
		}

		function allowDrop(ev){
			ev.preventDefault();
		}
			
		// ==========================================
		// ===============终端删除功能==================
		//  1. 在全局变量中清除该条记录 2.删除该项
		// ==========================================
		
		var clickDeleteTerminal = false; 
		$('.deleteArea').live("click",function(){	
			clickDeleteTerminal = true;
			
			var delete_id = $(this).parent().parent().find("#terminal_id").val();
			var terminalGroup_id = $('.selectedTerminalGroup_id').val();
			var terminalGroup_name = $('.selectedTerminalGroup_name').val();
			
			var href = "${ctx}/terminal/delete_terminal?delete_id=" + delete_id + 
					"&terminalGroup_id=" + terminalGroup_id + "&terminalGroup_name=" +
					terminalGroup_name;
			return confirmx('确认要删除该用户吗？', href);
		})
	</script>	
</body>
</html>
