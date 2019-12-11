<%@ page language="java" pageEncoding="utf-8" isELIgnored="false" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path1 = request.getContextPath();
    String basePath1 = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort() + path1 + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>汇总报表</title>
<base href="<%=basePath1 %>" />
<!--[if lt IE 9]>
<script src="http://apps.bdimg.com/libs/html5shiv/3.7/html5shiv.min.js"></script>
<![endif]-->
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/general.css">
    <link rel="stylesheet" href="css/layout.css">
    <link rel="stylesheet" href="css/core.css">
    <link rel="stylesheet" href="css/table.css">
    <link rel="stylesheet" href="js/jbox/jbox.css">
    <script type="text/javascript" src="js/jquery-2.1.4.js"></script>
    <script type="text/javascript" src="js/validate/jquery.validate.min.js"></script>
    <script type="text/javascript" src="js/validate/additional-methods.min.js"></script>
    <script type="text/javascript" src="js/validate/messages_zh.js"></script>
    <script type="text/javascript" src="js/modal/bootstrap-modal.js"></script>
    <script type="text/javascript" src="js/modal/bootstrap-modalmanager.js"></script>
    <script type="text/javascript" src="resources/js/organize/managerOrganize.js"></script>
    <script type="text/javascript" src="resources/easyui13/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="resources/easyui13/locale/easyui-lang-en.js"></script>
    <script type="text/javascript" src="resources/artDialog4.1.7/jquery.artDialog.js?skin=chrome"></script>
    <script type="text/javascript" src="js/jbox/jquery.jBox-2.3.min.js"></script>
    <script type="text/javascript" src="js/jbox/jquery.jbox-zh-cn.js"></script>
    <script type="text/javascript" src="js/json2.js"></script>

    <!--[if IE 6]>
<script type="text/javascript" src="Lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('.pngfix,.icon');</script>
<![endif]-->
</head>
<script type="text/javascript">
// $(function(){ 
// 	getColumnData();
// });
function getColumnData(){
	var year = $("#year").val().trim();
	var month = $("#month").val().trim();
	$.ajax({
        url : "statistic/toStatisticList.do",
        type : 'post',
        async:false, 
        data :{"year" : year,
                "month" : month
        	},
        dataType:"json",
        success :function (result) {
        	var dataItem=eval(result);
        	$("#dataList").empty();  
        	var temp="";
        	temp+="<tr>";
        	temp+="<th rowspan='2' class='table-statisticTH' style='white-space: nowrap;'>"+dataItem.columnName[0]+"</th>";
        	for(i=1;i<dataItem.categoryName.length;i++){
        		temp+="<td colspan="+dataItem.width[i]+" class='table-statisticTD' width='"+dataItem.width[i]+"*80px'>"+dataItem.categoryName[i]+"</td>";
        	}
        	temp+="</tr>";
        	temp+="<tr>";
        	for(i=1;i<dataItem.columnName.length;i++){
        		temp+="<th class='table-statisticTH' style='white-space: nowrap;'>"+dataItem.columnName[i]+"</th>";
        	}
        	temp+="</tr>";
			for(i=0;i<dataItem.dataList.length;i++){
				temp+="<tr>";
				for(var key in dataItem.dataList[i]) {
					temp+="<td style='white-space: nowrap;'>"+dataItem.dataList[i][key]+"</td>";
				}
				temp+="</tr>";
			}
			$("#dataList").html(temp);
			$.jBox.tip("查询成功","success");
        },error : function () {
            $.jBox.error("查询出现错误","提示");
        }
	});
}
var rootPath = '<%=basePath1%>';
function exportExcel(){
	var year = $("#year").val().trim();
	var month = $("#month").val().trim();
	window.location.href=rootPath +"statistic/export.do?year="+year+"&month="+month;
}
function exportSceneExcel(){
	var year = $("#year").val().trim();
	var month = $("#month").val().trim();
	window.location.href=rootPath +"statistic/exportScene.do?year="+year+"&month="+month;
}
</script>

<body style="width:100%;height:100%;overflow:auto">

<div class="u-body">
	<div class="u-title">
		<span>汇总报表</span>
		<div class="button-up"></div>
		<script>
			$(document).ready(function(){
			     // 搜索收缩
			    $(".button-up").click(function(){
			        $('.u-search').toggleClass('u-search-close');
			        $('.button-up').toggleClass('button-down');
			    });  
			});
		</script>
	</div>
	<div class="u-search">
		<div class="search-f">
		<div class="z-search">
			<div class="search">
		        <label class="name" for="">年份：</label>
		        <input type="text" class="u-input-text search-box box-input" name="year" id="year" value="${Year}">
		    </div>
		</div>
		<div class="z-search z-top">
			<div class="search">
		        <label class="name" for="">月份：</label>
		        <input type="text" class="u-input-text search-box box-input" name="month" id="month" value="${Month}">
		    </div>
		</div>
		</div>
		<div class="button-box-h">
		     <a class="button chaxun" onclick="getColumnData()">查询</a>
		     <a class="button daochu" onclick="exportExcel()">导出汇总表</a>
		</div>
	</div>
	<div class="data d2">
		<a class="button daochu" onclick="exportSceneExcel()">导出场景统计表></a>
		<div style="width:100%;overflow:auto;">
			<table id="dataList" class="table table-bordered table-bordered2"></table>
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