<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		var pid = '${office.parent.id}';	
			$(function(){
				$.ajax({
					url:'${ctx}/sys/office/treeData?extId=${office.id}',
					success:function(zNodes){
						var html;
						if(pid == null || pid == undefined || pid == ''){  //总部
							pid = '${office.id}';
							html=new treeMenu(zNodes).init(0);
						}else{
							html=new treeMenu(zNodes).init('${office.id}');  //普通机构
						}
						var s = '<div id = "tree_main">';
						var e = '</div>';
						html = s + html + e;
						$('#office_tree').append(html);
					}
				});
				
				/*属性结构的js动态效果  */
				$('.tree li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');
				var TimeFn = null;//设置单击延时
				
			    $('.tree li.parent_li .office_div >span> i').live('click', function (e) {
			    	//clearTimeout(TimeFn);
		    		 var children = $(this).parent().parent().parent().find(' > ul > li');
				        if (children.is(":visible")) {
				            children.hide('fast');
				            //$(this).attr('title', 'Expand this branch').find(' > i').addClass('icon-plus-sign').removeClass('icon-minus-sign');
				            $(this).addClass('icon-plus-sign').removeClass('icon-minus-sign');
				        } else {
				            children.show('fast');
				            $(this).attr('title', 'Collapse this branch').find(' > i').addClass('icon-minus-sign').removeClass('icon-plus-sign');
				            $(this).addClass('icon-minus-sign').removeClass('icon-plus-sign');
				        }
				        e.stopPropagation();
			      /*   },300);			//300ms触发单击操作 */
			    });
			    
			    /*为每个机构添加双击事件，双击后，出现修改机构名输入框*/
 			     $('.tree li .office_div').live('dblclick',function(event){ 			  
					console.log("dblclick");
					$(this).find('.office_span_update').css("display","inline-block");
					$(this).find('input').focus();
					$(this).find('.office_span_name').css("display","none");
 			     });
 
 			     $('.tree li .office_div').live('mouseover mouseout',function(event){
 			      	//clearTimeout(TimeFn);
 			      	if(event.type == 'mouseover'){
				    	$(this).find(".office_span_a").show();
 			      	}
 			      	if(event.type=='mouseout'){
 			      		$(this).find(".office_span_a").hide();	
 			      	}
			    });



 			     $('.li_input').live('blur',function(event){
 			    	console.log("blur");
 			    	var office_name = $(this).val();
 			    	if(!office_name){
 			    		$(this).parent().parent().parent().parent().remove();
 			    		return;
 			    	}
 			    
 			    });
		});
		/*修改机构名*/
		function updateOfficeName(e,val){
			console.log("========修改机构名==========");
			var value = $(e).parent().find('.office_update_input').val();
			if(val != value){
				var id = $(e).parent().parent().find('.office_id').text();
				var pid=$(e).parent().parent().find('.office_pId').text();
				console.log('id===>' + id);
				$.ajax({
					url:'${ctx}/sys/office/save?id=' + id + '&name=' + value + '&parent.id' + pid,
					success:function(){
						console.log("修改成功");
						window.location.href="${ctx}/sys/office"
					}

				});
			}
		}
	
		function cancelUpdateOffice(e){
			console.log("取消修改机构名");
			$(e).parent().parent().find('.office_span_update').css("display","none");
			$(e).parent().parent().find('.office_span_name').css("display","inline-block");
		}
		/*添加下级机构标签  */
		function addNewOfficeElement(e,event){
			var pId = $(e).parent().parent().find('.office_id').text();
	    	var content ='<ul><li><div class="office_div"> <span class=\'office_class\'>'+
								'<span style="display:none" class=\'office_pId\'>'+pId+'</span>'+
								'<i class=\'icon-leaf\'></i>'+
								'<input class=\'li_input\' placeHolder=\'请输入机构名\' type=\"text\" value=\'\'/> <button class="btn btn-primary" onclick="addNewOffice(this)">确定</button><button class="btn btn-primary" onclick="cancelAddOffice(this)">取消</button></span>'
		        				'</span></div></li></ul>'; 

			var li = $(e).parent().parent().parent();
			li.find('i').addClass('icon-minus-sign').removeClass('icon-leaf');
			li.append(content);
	    	li.find('input').focus();
	    	event.stopPropagation();
		}
		/*确认添加机构  */
		function addNewOffice(e){
			// 请求后台，保存机构
	    	var pId = $(e).parent().parent().find('.office_pId').text();
	    	console.log('input  pid===>' + pId);
	    	$.ajax({
	    		url:'${ctx}/sys/office/save',
	    		method:'POST',
	    		data:'name=' + office_name + '&parent.id=' + pId,
	    		success:function(data){
	    			console.log('===添加机构成功====');
	    			window.location.href="${ctx}/sys/office/list";
	    		}
	    	});
		}
		/*取消添加机构*/
		function cancelAddOffice(btn){
			$(btn).parent().parent().parent().parent().remove();
 			return;
		}
		function treeMenu(a){
				    this.tree=a||[];
				    this.groups={};
		};
		treeMenu.prototype={
		    init:function(pid){
		    	console.log(pid);
		        this.group();
		        return this.getDom(this.groups[pid]);
		    },
		    group:function(){
		        for(var i=0;i<this.tree.length;i++){
		            if(this.groups[this.tree[i].pId]){
		                this.groups[this.tree[i].pId].push(this.tree[i]);
		            }else{
		                this.groups[this.tree[i].pId]=[];
		                this.groups[this.tree[i].pId].push(this.tree[i]);
		            }
		        }
		    },
		    getDom:function(a){
		        if(!a){return '';}  //当前节点不存在的时候，退出
		        var html='\n<ul >\n';
		        for(var i=0;i<a.length;i++){
		        	var delete_url = '${ctx}/sys/office/delete?id=' + a[i].id;
		        	if(!(this.groups[a[i].id])){	//如果是当前节点为叶子节点,设置叶子节点样式
		        		html+='<li><div class="office_div">'+
		        				'<span class=\'office_class\'>'+
			        				'<span style="display:none" class=\'office_id\'>'+a[i].id+'</span>'+
									'<span style="display:none" class=\'office_pId\'>'+a[i].pId+'</span>'+
			        				'<i class=\'icon-leaf\'></i>'+
			        				'<span class="office_span_name">'+a[i].name+'</span>'+
			        				'<span class="office_span_update" style="display:none"><input class=\'office_update_input\' type=\"text\" value='+a[i].name+'> <button class="btn btn-primary" onclick="updateOfficeName(this,\''+a[i].name+'\')">确定</button><button class="btn btn-primary" onclick="cancelUpdateOffice(this)">取消</button></span>'+
		        				'</span>'+
		        				'<span class=\'office_span_a\'><a href=\"javascript:void(0)\" onclick=\'addNewOfficeElement(this,event)\'>添加下级机构</a> <a href='+delete_url+'>删除</a></span></div>'; 
		        	}else{  //设置非叶子节点样式
		        		 if(a[i].id != '${office.id}'){  //有子节点而且有父节点
				            html+='<li class=\'parent_li\'><div class="office_div"> '+
									'<span class=\"office_class badge badge-success\" title="Expand this branch">'+
									'<span style="display:none" class=\'office_id\'>'+a[i].id+'</span>'+
									'<span style="display:none" class=\'office_pId\'>'+a[i].pId+'</span>'+
									'<i class="icon-minus-sign"></i>'+
									'<span class="office_span_name">'+a[i].name+'</span>'+
			        				'<span class="office_span_update" style="display:none"><input class=\'office_update_input\' type=\"text\" value='+a[i].name+'> <button class="btn btn-primary" onclick="updateOfficeName(this,\''+a[i].name+'\')">确定</button><button class="btn btn-primary" onclick="cancelUpdateOffice(this)">取消</button></span>'+
									'</span>'+
									'<span class=\'office_span_a\'><a href=\"javascript:void(0)\" onclick=\'addNewOfficeElement(this,event)\'>添加下级机构</a> <a href='+delete_url+'>删除</a></span></div>'; 
		        		}else{
				            html+='<li class=\'parent_li\'><div class="office_div">'+
				            		'<span class=\'office_class\' title="Expand this branch">'+
				            		'<span style="display:none" class=\'office_id\'>'+a[i].id+'</span>'+
									'<span style="display:none" class=\'office_pId\'>'+a[i].pId+'</span>'+
				            		'<i class="icon-folder-open icon-minus-sign"></i>'+
				            		'<span class="office_span_name">'+a[i].name+'</span>'+
			        				'<span class="office_span_update" style="display:none"><input class=\'office_update_input\' type=\"text\" value='+a[i].name+'> <button class="btn btn-primary" onclick="updateOfficeName(this,\''+a[i].name+'\')">确定</button><button class="btn btn-primary" onclick="cancelUpdateOffice(this)">取消</button></span>'+
				            		'</span>'+
				            		'<span class=\'office_span_a\'><a href=\"javascript:void(0)\" onclick=\'addNewOfficeElement(this,event)\'>添加下级机构</a> <a href='+delete_url+'>删除</a></span></div>'; 
		        		} 
		        	}
		            html+=this.getDom(this.groups[a[i].id]);
		            html+='</li>\n';
		        };
		        html+='</ul>\n';
		        return html;
		    }
		};
	</script>
	<style type="text/css">
		#office_tree{
    		width: 100%;
		}
		#tree_main{
		    width: 80%;
			margin: auto;
		}
		
		.tree {
		    min-height:20px;
		    padding:19px;
		    margin-bottom:20px;
		    background-color:#fbfbfb;
		    border:1px solid #999;
		    -webkit-border-radius:4px;
		    -moz-border-radius:4px;
		    border-radius:4px;
		    -webkit-box-shadow:inset 0 1px 1px rgba(0, 0, 0, 0.05);
		    -moz-box-shadow:inset 0 1px 1px rgba(0, 0, 0, 0.05);
		    box-shadow:inset 0 1px 1px rgba(0, 0, 0, 0.05)
		}
		.tree .badge{
			 background-color: #468847;
			 
		}
		.tree li {
		    list-style-type:none;
		    margin:0;
		    padding:10px 5px 0 5px;
		    position:relative
		}
		.tree li .office_div{
			height: 50px;
    		width: 500px;
    		
		}
		.tree li .office_div a{
			    text-decoration: none;
		}
		.tree li .office_div .office_span_name{
			font-family: Helvetica,Georgia,Arial,sans-serif,宋体;
    		font-size: 13px;
   		    color: #333;
		}
		
		.tree li .office_div input{
		    height: 36px;
		    margin-left: 5px;
		    color: #333;
		}
		.tree li .office_div button{
		    position: relative;
	    	top: -5px;
	    	margin-left:5px;
	    	color: #333;
		}
		.tree li::before, .tree li::after {
		    content:'';
		    left:-20px;
		    position:absolute;
		    right:auto
		}
		.tree li::before {
		    border-left:1px solid #999;
		    bottom:50px;
		    height:100%;
		    top:0;
		    width:1px
		}
		.tree li::after {
		    border-top:1px solid #999;
		    height:20px;
		    top:25px;
		    width:25px
		}
		.tree li span.office_class {
		    height: 45px;
    		line-height: 38px;	
		    -moz-border-radius:5px;
		    -webkit-border-radius:5px;
		    border:1px solid #999;
		    border-radius:0px;
		    display:inline-block;
		    padding:3px 8px;
		    text-decoration:none
		}
		.tree li span.office_span_a{
			display:none;
		    margin-left: 6px;
		}
		.tree li.parent_li>span.office_class {
		    cursor:pointer
		}
		.tree>ul>li::before, .tree>ul>li::after {
		    border:0
		}
		.tree li:last-child::before {
		    height:30px
		}
		.tree li.parent_li>span.office_class:hover, .tree li.parent_li>span.office_class:hover+ul li span {
		    background:#eee;
		    border:1px solid #94a0b4;
		    color:#364279;
		}
	</style>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/systemManage/sysManage_common.css">
	
</head>
<body>
	<div class="div_top">
		<div class="div_bottom">
			<ul class="nav nav-tabs">
				<li><a href="${ctx}/sys/user">用户列表</a></li>
				<li class="active"><a href="${ctx}/sys/office/">机构管理</a></li>
				<li><a href="${ctx}/sys/role">角色管理</a></li>
				<li><a href="${ctx}/sys/role/form?id=${role.id}">角色<shiro:hasPermission name="sys:role:edit">${not empty role.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:role:edit">查看</shiro:lacksPermission></a></li>
			</ul>
		</div>
	</div>
	<br/>
	<div id="office_tree" class="tree well box-shadow"></div>
</body>
</html>