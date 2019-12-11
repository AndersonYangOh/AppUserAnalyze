<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path1 = request.getContextPath();
	String basePath1 = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path1 + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>存量运营数据分析平台</title>
<!-- <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">-->
<base href="<%=basePath1%>" />

<link rel="Bookmark" href="img/favorite.png">
<link rel="Shortcut Icon" href="img/favorite.png" />
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/general.css">
<link rel="stylesheet" href="css/layout.css">
<link rel="stylesheet" href="css/core.css">
<link rel="stylesheet" href="js/jbox/jbox.css">
<link rel="stylesheet" href="css/indexmenu_style.css">

<script type="text/javascript" src="js/jquery-2.1.4.js"></script>
<script type="text/javascript" src="js/modal/bootstrap-modal.js"></script>
<script type="text/javascript" src="js/modal/bootstrap-modalmanager.js"></script>
<script type="text/javascript" src="js/jbox/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="js/jbox/jquery.jbox-zh-cn.js"></script>
<script type="text/javascript" src="resources/js/system/indexmenu.js"></script>

<script type="text/javascript" src="resources/jquery/jquery.sizes.js"></script>
<script type="text/javascript" src="resources/jquery/jlayout.border.js"></script>
<script type="text/javascript" src="resources/jquery/jquery.jlayout.js"></script>
<script type="text/javascript" src="resources/js/common_jq.js"></script>
<script type="text/javascript"
	src="resources/window/lhgdialog.min.js?skin=chrome"></script>
<script type="text/javascript" src="js/echarts.common.min.js"></script>
<%-- main.js用于获取当前登录用户可操作功能数据 --%>
<script type="text/javascript" src="resources/js/system/main.js"></script>
<script type="text/javascript" src="resources/js/menu.js"></script>
<script type="text/javascript" src="js/pass.js"></script>

<script type="text/javascript">var rootPath = '<%=basePath1%>';</script>
</head>
<body>
<div class="Modal-edit-box">
	<div class="pass">
		<div class="modal-header">
			<h3 id="myModalLabel">修改密码</h3>
			<a class="close" data-dismiss="modal" aria-hidden="true" href="javascript:void();"></a>
		</div>
		<br>
		<span style="margin:30px 0 0 20px">提示：新用户首次登陆需要修改密码，密码必须由数字字母和特殊字符组成</span>
		<form class="modal-body" action="" id="pwdForm" name="pwdForm">
			<input type="hidden" id="id" name="id" value="${sessionScope.operator.operId }" />
			<div class="box">
				<label class="name">旧密码：</label> 
				<input class="input-text" type="password" value="" name="oldPwd" id="oldPwd" onblur="checkOldPwd();">
			</div>
			<div style="width: 250px; height: 16px; margin: 0 auto; color: red; text-align: left; padding-left: 65px;">
				<label id="oldPwdErorr"></label>
			</div>
			<div class="box">
				<label class="name">新密码：</label> 
				<input class="input-text" type="password" value="" name="newPwd" id="newPwd" onblur="checkNewPwd();">
			</div>
			<div style="width: 250px; height: 16px; margin: 0 auto; color: red; text-align: left; padding-left: 65px;">
				<label id="newPwdErorr"></label>
			</div>
			<div class="box">
				<label class="name">确认密码：</label> 
				<input class="input-text" type="password" value="" name="reNewPwd" id="reNewPwd" onblur="checkReNewPwd();">
			</div>
			<div style="width: 250px; height: 16px; margin: 0 auto; color: red; text-align: left; padding-left: 65px;">
				<label id="reNewPwdErorr"></label>
			</div>
		</form>
		<div class="button-box">
			<button class="button baocun-pass" onclick="savePwdPassPage();" >保存</button>
		</div>
	</div>
</div>
</body>
</html>
