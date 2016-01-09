<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>400 - 无效请求</title>
<%@include file="/WEB-INF/views/include/head.jsp"%>
</head>
<body>
	<div class="container-fluid">
		<div id="page-content" class="clearfix">
			<div class="row-fluid">
				<!-- PAGE CONTENT BEGINS HERE -->
				<div class="error-container">
					<div class="well">
						<h2 style="color: red;" class="lighter">400 - 请求无效。</h2>
						<hr />
						<div>
							<div class="space"></div>
							<h4 class="smaller">请尝试以下操作：</h4>
							<ul class="unstyled spaced inline">
								<li><i class="icon-hand-right"></i>&nbsp;请检查请求是否有效（检查Controller form表单验证是否通过！）。</li>
								<li><i class="icon-hand-right"></i>&nbsp;告诉我们。</li>
							</ul>
						</div>
						<hr />
						<div class="space"></div>
						<div class="row-fluid">
							<div class="center">
								<a href="javascript:" onclick="history.go(-1);"
									class="btn btn-grey"><i class="icon-arrow-left"></i>&nbsp;返回上一页</a>
								<a href="${ctx}#" class="btn btn-primary"><i
									class="icon-home"></i>&nbsp;返回首页</a>
							</div>
						</div>
					</div>
				</div>
				<script>try{top.$.jBox.closeTip();}catch(e){}</script>
			</div>
		</div>
	</div>
</body>
</html>