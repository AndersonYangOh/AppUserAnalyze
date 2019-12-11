<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
           + request.getServerName() + ":" + request.getServerPort()
           + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>存量运营数据分析平台</title>
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<base href="<%=basePath %>" />
<link rel="Bookmark" href="img/favorite.png" > 
<link rel="Shortcut Icon" href="img/favorite.png" />
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/general.css">
<link rel="stylesheet" href="css/layout.css">
<link rel="stylesheet" href="css/core.css">
<link rel="stylesheet" href="css/swiper.min.css">

<script type="text/javascript" src="js/jquery-2.1.4.js"></script> 
<script type="text/javascript" src="js/validate/jquery.validate.min.js"></script> 
<script type="text/javascript" src="js/validate/additional-methods.min.js"></script> 
<script type="text/javascript" src="js/validate/messages_zh.js"></script> 
<script type="text/javascript" src="js/kkpager/kkpager.js"></script> 
<script type="text/javascript" src="js/app.js"></script>
<script type="text/javascript" src="js/sms.js"></script>

<script type="text/javascript">
$(function(){
    $("#operAccount").focus();
});

/**登录验证*/
function login() {
	if($("#operAccount").val()==""){
		$("#msg").html("请输入用户名");
	 	$("#operAccount").focus();
	 	return false;
	}
	if($("#operPwd").val()==""){
	 	$("#msg").html("请输入密码");
	 	$("#operPwd").focus();
	 	return false;
	}
	$("#msg").html("");//清空
	$("#sub").hide();
	$("#loadDiv").show();
	//登录验证
	$.ajax({
		type: "POST",
		url: "<%=basePath %>sysLogin/checkSysLogin.do",
		data: $("#loginForm").serialize(),
		datatype: "json",
		success: function(data){
			if (data.flag) {//登录成功
				window.location.href="<%=basePath %>sysMenu/getLoginMenus.do";
				return;
			} else {
				$("#msg").html(data.msg);
				$("#loadDiv").hide();
				$("#sub").show();
			}
		}
   	});
}

/**登录验证*/
function loginCode() {
	var phone = $("#jbPhone").val();  
    var flag = "code";
    var param = {"phone":phone,"flag":flag};
	if($("#jbPhone").val()==""){
		$("#msg1").html("请输入手机号");
	 	$("#jbPhone").focus();
	 	return false;
	}
	if($("#code").val()==""){
	 	$("#msg1").html("请输入验证码");
	 	$("#code").focus();
	 	return false;
	}
	$("#msg1").html("");//清空
	$("#sub1").hide();
	$("#loadDiv1").show();
	//登录验证
	$.ajax({
		type: "POST",
		async: true, 
		data: param,
		url: "./sysLogin/checkSysLogin.do",
		datatype: "json",
		success: function(data){
			if (data.flag) {//登录成功
				window.location.href="<%=basePath %>sysMenu/getLoginMenus.do";
				return;
			} else {
				$("#msg1").html(data.msg);
				$("#loadDiv1").hide();
				$("#sub1").show();
			}
		}
   	});
}

/**回车事件*/
function enterEnvent(evt){
	evt = (evt) ? evt : ((window.event) ? window.event : "")
	keyCode = evt.keyCode ? evt.keyCode : (evt.which ? evt.which : evt.charCode);
	if (keyCode == 13){
		login();
	}
}

function clearPwd(){
	//alert(123);
	$("#operPwd").val("");
}

function clearPhone(){
	//alert(123);clearPwd
	//$("#jbPhone").val("");
}

//返回顶层登录页面
if(top != self){
	top.location.href = self.location.href;
}

function trim(str) {  
    var strnew = str.replace(/^\s*|\s*$/g, "");  
    return strnew;  
}  

function checkPhone(){
	var jbPhone = $("#jbPhone").val();
	var param = {"phone":jbPhone};
    var re= /(^1[3|4|5|6|7|8][0-9]{9}$)/;  
    
    if (trim(jbPhone) == "") {  
    	$("#msg1").html("<font color='red'>× 手机号码不能为空</font>");  
        return false;  
    } else if(trim(jbPhone) != ""){  
        if(!re.test(jbPhone)){  
        	$("#msg1").html("<font color='red'>× 请输入有效的手机号码</font>");  
            return false;  
        }else{  
        	$("#msg1").html("<font color='#339933'>√ 手机号码输入正确</font>");  
            // 向后台发送处理数据  
            $.ajax({
					type: "POST",
					data: param,
					async : true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
					url: "./sysLogin/checkPhone.do",
					datatype: "json",
					success: function(data){
						if (data.flag) {//登录成功
							return;
						} else {
							$("#msg1").html(data.msg);
						}
					}
   			});
            return true;  
        }  
    }  
	
}
</script>
</head>
<body class="login">
  
<!-- LOGIN --->   
<div class="login-wrap">
	<div class="logo-unicom">
		<img src="img/logo.svg" alt="">
	</div>
    <div class="login-box">
      	<div class="left-box">
      		<div class="ico-login">
      			<img src="img/ico-login.jpg" alt="">
      		</div>
        	<div class="login-title">存量运营数据分析平台</div>
        	<div class="login-option">
        		<ul>
        			<li class="user-name-btn"><a class="active">用户名</a></li>
        			<li class="phone-btn"><a>手机号</a></li>
        		</ul>
        	</div>
        	<br>
            <!-- 用户名密码登录 -->
          	<form id="loginForm" class="loginForm user-name-box">
                <!-- 账号 -->
                <input class="input-text input-text-login user-name" id="operAccount" name="operAccount" type="text" value="" onkeyup="clearPwd()" onkeydown="enterEnvent(event)" placeholder="&nbsp;请在此输入您的用户名" onblur="true">
                <!-- 密码 -->
                <input class="input-text input-text-login user-password" id="operPwd" name="operPwd" type="password" value="" onkeydown="enterEnvent(event)" autocomplete="off" placeholder="&nbsp;请在此输入密码">
             	<div class="btn-login">
                  	<button class="button" type="button" id="sub" onclick="login()">登&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;录</button>
				  	<div id="loadDiv" class="loading" style="display:none;">
				  		<span>正在登录中</span>
				  		<!-- <img id="loading" src="resources/images/loading.gif" /> -->
				  	</div>
              	</div>
                <div id="msg" class="msg"></div>
          	</form>
          			
          	<!-- 手机号登录 -->
          	<form id="loginForm1" class="loginForm phone-box" style="display:none">
                <!-- 手机号 -->
                <input class="input-text input-text-login user-name" id="jbPhone" name="jbPhone"  type="text" onBlur="checkPhone()" placeholder="&nbsp;请在此输入您的手机号" onblur="true"/>
                <!-- 验证码 -->
                <input class="input-text input-text-login user-password nerification-number" id="code" name="code" type="text" onkeydown="enterEnvent(event)" autocomplete="off" placeholder="&nbsp;请在此输入验证码"/>
		        <input type="button" id="btnSendCode" name="btnSendCode" value="发送验证码" onclick="sendMessage()" class="user-password send-nerification-number" />
             	<div class="btn-login">
                  	<button class="button" type="button" id="sub1" onclick="loginCode()">登&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;录</button>
				  	<div id="loadDiv1" class="loading" style="display:none;">
				  		<span>正在登录中</span>
				  		<!-- <img id="loading" src="resources/images/loading.gif" /> -->
				  	</div>
              	</div>
                <div id="msg1" class="msg"></div>
          	</form>
		</div>
        <div class="right-box"><iframe src="page/banner.html" style="width:350px;height:430px;border:none;"></iframe></div>
    </div>
     <footer class="footer-login">
		<p style="color:#516397">Copyright &copy;2018&nbsp;ChinaUnicom中国联通&nbsp;版权所有&nbsp;&nbsp;&nbsp;技术支持：中国联通研究院-大数据研究中心<br></p>
	 </footer>
</div>

<!-- 登录类型切换 -->
<script>
	$(".phone-btn").on("click", function(e) {
		$(".phone-box").show();
		$(".user-name-box").hide();
		
		$(".user-name-btn").on("click", function() {
			$(".phone-box").hide();
			$(".user-name-box").show();
		});
	});
	
	$(document).ready(function() {
		$(".login-option a").click(function() {
			$(".login-option a").removeClass("active");
			$(this).addClass("active");
		});
	});	
</script>
</body>
</html>