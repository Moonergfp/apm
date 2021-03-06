<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>节目制作</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
	body{
		margin: 0;
		font-family: "Microsoft YaHei",Tahoma,Helvetica,Arial,sans-serif;
	}
	.sort{
	    color:#0663A2;cursor:pointer;
	}
	.div_top{
		margin-top: 2%;
	}
	.div_bottom ul{
		margin-left: 11%;
	}
	.nav, .breadcrumb {
		margin-bottom: 0px;
	}
	.nav-tabs {
		border-bottom: 0px;
	}
	.nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li>a:hover, .nav-tabs>li.active>a:hover{
		border: 0px;
		border-bottom: 5px solid #08C;
	}
	.div_bottom{
	    border-bottom: 1px solid #ddd;
	}
	.div_table{
		padding-top: 10px;
	    margin: 0 10% 0 11%;
	    background-color: #f5f5f5;
	    padding: 10px 0;
	    margin-top: 20px;
	    /* box-shadow: 0px 0px 5px #ddd; */
	}
	.template-div{margin-top: 10px;}
	#inputForm select:first-child {width: 80px; display: inline-block}
	.input-search{width: 280px;}
	.select-width{width: 120px;display: none;}
	.select-dis{display: inline-block;}
	.form-border{height: 45px; border-bottom: 1px solid #ddd;}
	.template-create{font-size: 90px; line-height: 240px; color: #fff;}
	.white-template{width: 235px; height:240px; background-color: #bdd5ef; text-align: center;}
	
	.row{margin: 0;}
	.col-md-3{padding: 0;}
	.template-div .row-img{cursor: pointer; width: 235px; height: 300px; box-shadow: 0 2px 3px rgba(0,0,0,.3);float: left;position: relative;}
	.template-div .row-img:hover .hover-div{display: block}
	.template-div .row-img p{height: 60px; text-align: center;}
	.template-div .row-img span{line-height: 60px;}
	.row-margin{margin-left: 40px;}
	.template-div .row-img img{width: 235px; height: 240px;}
	.hover-div{position: absolute; top: 0;left: 0;display: none; width: 100%; height: 240px;}
	.hover-div a{width: 120px;background-color: #08a1ef;z-index: 2; position: relative;left: 60px; top:60px;}
	.hover-div a:last-child{margin-top: 40px;}
	</style>
	<script type="text/javascript">
		$(function(){
			  $("#toCreate").click(function(){
				$("#programModal").modal({
					  keyboard: true
				});
		   });
		});	  
		function toChange(obj){
			var val = $(obj).val();
			if(val == "0"){
				$("#select-width0").addClass("select-dis");
				$("#select-width1").removeClass("select-dis");
			}else{
				$("#select-width1").addClass("select-dis");
				$("#select-width0").removeClass("select-dis");
			}
		}
		function save(){
			var pName = $("#programName").val();
			if(pName.trim().length < 1){
				top.$.jBox.tip("未输入节目名!",'warning');
				return ;
			}
			console.log($(".select-dis").val());
			$("#ratio").val($(".select-dis").val());
			$("#pName").val(pName);
			$("#advertiser").val($("#adver").val());
			$("#inputForm").submit();
			$("#programName").val("");
			$("#adver").val("广告商A");
			$("#programModal").modal("hide");
			 
		}
	</script>
</head>
<body>
<div class="div_top">
     <div class="div_bottom">
	   <ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/program/make">我的模板</a></li>
		<li><a href="${ctx}/program/make">商城模板</a></li>
	   </ul> 
    </div>
    <tags:message content="${message}"/>
    <div class="div_table">
      <form id="inputForm" action="${ctx}/program/form" method="post" target="_blank" class="form-border">
	     <!--  <button type="submit" class="btn btn-primary">制作节目</button> -->
	       <select class="form-control" name="direction" id="direction" onchange="toChange(this);"><option value="0">横屏</option><option value="1">竖屏</option></select>
	       <select class="form-control select-width select-dis" id="select-width0">
	          <option value="1024*768">1024*768</option>
	          <option value="1280*720">1280*720</option>
	          <option value="1280*800">1280*800</option>
	          <option value="1366*768">1366*768</option>
	          <option value="1928*1080">1928*1080</option>
	       </select>
	        <select class="form-control select-width" id="select-width1">
	          <option value="768*1024">768*1024</option>
	          <option value="720*1280">720*1280</option>
	          <option value="800*1280">800*1280</option>
	          <option value="768*1366">768*1366</option>
	          <option value="1080*1928">1080*1928</option>
	       </select>
	       <div class="input-search pull-right input-group">
	       	  <input type="text" class="form-control" placeholder="搜索关键词">
	       	  <span class="input-group-btn">
	       	  	<button class="btn btn-primary" type="button" onclick="search();">搜索</button>
	       	  </span>
	       </div>
	        <input type="hidden" name="pName" id="pName">
	        <input type="hidden" name="advertiser" id="advertiser">
	        <input type="hidden" name="ratio" id="ratio">
      </form>
      <div class="template-div">
		<div class="row">
			  <div class="col-md-3 row-img" id="toCreate">
			  	<div class="white-template">
      				<i class="glyphicon glyphicon-plus template-create"></i>
      			</div>
      			<p>
      				<span>自主创建</span>
      			</p>
			  </div>
			  <div class="col-md-3 row-img row-margin">
			  	<div>
      				<img src="${ctxStatic}/images/testImg/u9.jpg">
      			</div>
      			<p>
      				<span>系统模板</span>
      			</p>
      			<div class="hover-div">
      			 	<div style="background-color: #000; opacity: 0.5;width: 235px;height: 240px;z-index: 1;position: absolute;">
      			 	</div>
   			 		<a href="javascript:void(0);" class="btn btn-primary">预览</a>
   				    <a href="javascript:void(0);" class="btn btn-primary" data-toggle="modal" data-target="#programModal">编辑</a>
      			</div>
			  </div>
	      </div>
      </div>
   </div>
 </div>
 <div class="modal fade bs-example-modal-lg material-modal" id="programModal" tabindex="-1" role="dialog" aria-labelledby="programModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header" style="text-align: center;">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">新建节目</h4>
      </div>
      <div class="modal-body" style="text-align: center;">
       		<form class="form-horizontal">
			  <div class="form-group">
			    <label for="programName" class="col-sm-4 control-label">节目名称</label>
			    <div class="col-sm-5">
			      <input type="text" class="form-control required" id="programName" placeholder="请填写节目名称">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="adver" class="col-sm-4 control-label">选择广告商</label>
			    <div class="col-sm-5">
			      <select  class="form-control" id="adver"><option value="广告商A">广告商A</option><option value="广告商B">广告商B</option><option value="广告商C">广告商C</option></select>
			    </div>
			  </div>
			</form>
      </div>  
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" class="btn btn-primary" onclick="save();">保存</button>
      </div>  
    </div>
  </div>
</div>
</body>
</html>
