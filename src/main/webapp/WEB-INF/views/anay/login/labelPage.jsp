<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
String path1 = request.getContextPath();
String basePath1 = request.getScheme() + "://"
          + request.getServerName() + ":" + request.getServerPort() + path1 + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>存量运营数据分析平台</title>
<base href="<%=basePath1 %>" />

    <link rel="Bookmark" href="img/favorite.png" > 
    <link rel="Shortcut Icon" href="img/favorite.png" />
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/general.css">
    <link rel="stylesheet" href="css/layout.css">
    <link rel="stylesheet" href="js/jbox/jbox.css">
    <link rel="stylesheet" href="css/fenlei.css">
    
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
<script type="text/javascript" src="resources/window/lhgdialog.min.js?skin=chrome"></script>
<%-- main.js用于获取当前登录用户可操作功能数据 --%>
<script type="text/javascript" src="resources/js/system/main.js"></script>
<script type="text/javascript" src="resources/js/menu.js"></script>


<script type="text/javascript">

function getCunliang(){
	$.ajax({
        type : 'POST',
        url : 'busiAnalysisMonth/toResultChart.do',
		datatype : 'json',
        success : function(result,msg) {
        	
        	
        	if (result.result[5].rateFlag == "↑"){
        		document.getElementById("userRateUp").innerHTML = "↑&nbsp;"+result.result[5].rate+"%";
        	}else{
        		document.getElementById("userRateDown").innerHTML = "↓&nbsp;"+result.result[5].rate+"%"
        	}
        	if (result.result[0].rateFlag == "↑"){
        		document.getElementById("incomeRateUp").innerHTML = "↑&nbsp;"+result.result[0].rate+"%";
        	} else{
        		document.getElementById("incomeRateDown").innerHTML = "↓&nbsp;"+result.result[0].rate+"%";
        	}
        	if (result.result[1].rateFlag == "↑"){
        		document.getElementById("douRateUp").innerHTML = "↑&nbsp;"+result.result[1].rate+"%";
        	} else{
        		document.getElementById("douRateDown").innerHTML = "↓&nbsp;"+result.result[1].rate+"%";
        	}
        	if (result.result[6].rateFlag == "↑"){
        		document.getElementById("mouRateUp").innerHTML = "↑&nbsp;"+result.result[6].rate+"%";
        	} else{
        		document.getElementById("mouRateDown").innerHTML = "↓&nbsp;"+result.result[6].rate+"%";
        	}
        	if (result.result[2].rateFlag == "↑"){
        		document.getElementById("highRateUp").innerHTML = "↑&nbsp;"+result.result[2].rate+"%";
        	} else{
        		document.getElementById("highRateDown").innerHTML = "↓&nbsp;"+result.result[2].rate+"%";
        	}
        	
        	
        	document.getElementById("userValue").innerHTML = result.result[5].value+"亿";
        	
        	document.getElementById("incomeValue").innerHTML = result.result[0].value+"亿";
        	
        	var dou = parseFloat(result.result[1].value);
        	var user = parseFloat(result.result[5].value);
        	var douValue = dou/user;
        	douValue = douValue/100000000;
        	var douValueF = douValue.toFixed(2)
        	document.getElementById("douValue").innerHTML = douValueF+"GB";
        	
        	/* var mouValue = parseFloat(result.result[6].value);
        	var s1 = result.result[6].value.substring(0,result.result[6].value.length-7);  
        	alert(s1); */
        	document.getElementById("mouValue").innerHTML = result.result[6].value+"分钟";
        	document.getElementById("highValue").innerHTML = result.result[2].value+"&nbsp;万";
        	
        	//; 
        	//alert(num5);
        	document.getElementById("platformMon").innerHTML = result.result[3].value+"个";
        	document.getElementById("userLabel").innerHTML = result.result[4].value+"个";
        	
        	//document.getElementById("cunLiangMonth").innerHTML = result.result[5].month.substr(0,4)+"年"+result.result[5].month.substring(4)+"月";
        	//存量用户除（2I）数据月份
        	var currentYear = result.result[0].month.substring(0, 4);
        	var currentMonth = result.result[0].month.substr(4);
        	cunLiangMonth.innerHTML="截止"+currentYear+"年"+currentMonth+"月";
        	
        	/*if (msg.flag){
        		var obj = eval('(' + str + ')');
                $.jBox.tip(msg.msg,'success');
        		$("#Modal-update").modal('hide');
        	} else {
                $.jBox.error(msg.msg, '提示');
        	} */
        }
	});
}

window.onload=getCunliang;
</script>
</head>
<body style="width:100%;height:100%;overflow:auto;">

<div class="fenlei">
	<div class="box">
		<div class="left-data">
        	<iframe src="lei/yiwang.html" style="width:100%;height:100%;border:none;overflow:hidden"></iframe>
        </div>
        <div class="right-data">
			<div class="cunliang">
				<div class="title">
					<span class="tl">存量用户概况(除2I)</span>
					<span  id="cunLiangMonth" class="tl-2" style="color:#93a0b2;text-align:right;"></span>
				    <script>
				       //var d = new Date();
				       //var year = d.getFullYear();
				      // var month_O = parseFloat(d.getMonth());
				       //var month = month_O + 1;
				     
				        //cunLiangMonth.innerHTML="截止"+year+"年"+month+"月";
				    </script>
				</div>
				<div class="box">
					<ul>
						<li>
							<span class="lt bt">名称</span>
							<span class="cr bt">数据</span>
							<span class="rt bt">环比</span>
						</li>
						<li>
							<span class="lt bt">出账用户数</span>
							<span class="cr" id="userValue"><p>加载中</p></span>
							<span class="rt up" id="userRateUp"><p></p></span>
							<span class="rt down" id="userRateDown"><p></p></span>
							<!-- <span class="rt up" id="userRate">↑<p></p></span>
							<span class="rt down" id="#">↓<p>%</p></span> -->
						</li>
						<li>
							<span class="lt bt">出账用户收入</span>
							<span class="cr" id="incomeValue"><p>加载中</p></span>
							<span class="rt up" id="incomeRateUp"><p></p></span>
							<span class="rt down" id="incomeRateDown"><p></p></span>
						</li>
						<li>
							<span class="lt bt">DOU</span>
							<span class="cr" id="douValue"><p>加载中</p></span>
							<span class="rt up" id="douRateUp"><p></p></span>
							<span class="rt down" id="douRateDown"><p></p></span>
						</li>
						<li>
							<span class="lt bt">主叫时长</span>
							<span class="cr" id="mouValue"><p>加载中</p></span>
							<span class="rt up" id="mouRateUp"><p></p></span>
							<span class="rt down" id="mouRateDown"><p></p></span>
						</li>
						<li>
							<span class="lt bt">高价值用户数</span>
							<span class="cr" id="highValue"><p>加载中</p></span>
							<span class="rt up" id="highRateUp"><p></p></span>
							<span class="rt down" id="highRateDown"><p></p></span>
						</li>
					</ul>
				</div>
			</div>
			<div class="pingtai">
				<div class="title">
					<span class="tl tl-3">平台监控</span>
					<span id="show_time_last" class="tl-2" style="color:#93a0b2;text-align:right;"></span>
				    <!--<script>
				       var d = new Date();
				       var year = d.getFullYear();
				       var month_O = parseFloat(d.getMonth());
				       var month = month_O + 1;
				       var day_O = parseFloat(d.getDate());
				       var day = day_O;
				       if (day > 1){
				      	 day = day_O - 1;
				       }
				       //var day = day_O - 1;
				       //alert("截止"+year+"年"+month+"月"+day+"日");
				       show_time_last.innerHTML="截止"+year+"年"+month+"月"+day+"日";
				    </script>-->
				</div>
				<ul>
					<li class="list-1">
						<p class="p1" id="platformMon"></p>
                        <p class="p2">探针数据文件数</p>
                    </li>
                    <li>
                        <p class="p1" id="userLabel" class="list-2"></p>
                        <p class="p2" >用户标签文件数</p>
                    </li>
                </ul>
            </div>
         </div>
     </div>
</div>
<div class="index-footer">
 <p>Copyright &copy;2018&nbsp;ChinaUnicom中国联通&nbsp;版权所有&nbsp;&nbsp;&nbsp;技术支持：中国联通研究院-大数据研究中心&nbsp;&nbsp;&nbsp;</br>
 当前在线人数：<span id="lineCount"></span>&nbsp;人&nbsp;&nbsp;&nbsp;本月总点击数：<span id="monthCount"></span>&nbsp;️次</p>
</div>   
<script>
	//统计点击数
	getLineCount();
	setInterval("getLineCount()", 60000);
		function getLineCount(){
		$.ajax({
	        url : "sysLogin/lineCount.do",
	        type : 'get',
	        async:false, 
	        data :{},
	        dataType:"json",
	        success :function (result) {
	        	document.getElementById("lineCount").innerHTML = result.lineCount;
	        	document.getElementById("monthCount").innerHTML = result.monthCount;
	        },error : function () {
	        }
		});
	}
 </script>     
</body>
</html>
