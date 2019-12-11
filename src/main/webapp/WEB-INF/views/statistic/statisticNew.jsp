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
    <script type="text/javascript" src="js/tableExport.js"></script>
    <script type="text/javascript" src="js/json2.js"></script>

    <!--[if IE 6]>
<script type="text/javascript" src="Lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('.pngfix,.icon');</script>
<![endif]-->
</head>
<script type="text/javascript">
$(function(){ 
	$("#monthDiv").hide();
	$("#product").bind("change",function(){
		var dataname = $(this).val();
		if(dataname=="6"){
			$("#monthDiv").show();
		}else if(dataname=="7"){
			$("#monthDiv").show();
		}else{
			$("#monthDiv").hide();
		}
	});
	getColumnData();
});
Number.prototype.toFixed = function(s)  {  
	return (parseInt(this * Math.pow( 10, s ) + 0.5)/ Math.pow( 10, s )).toString();  
}  
function isNull(arg1){
	return !arg1 && arg1!==0 && typeof arg1!=="boolean"?true:false;
}
function getColumnData(){
	var year = $("#year").val().trim();
	var month = $("#month").val().trim();
	var type = $("#product").val().trim();
	$.ajax({
        url : "statisticNew/getTableData.do",
        type : 'post',
        async:false, 
        data :{"year" : year,
                "month" : month,
                "type" : type
        	},
        dataType:"json",
        success :function (result) {
        	var m = parseInt(result.result.month);
        	if(type=="1"){
        		table1(m,result.result.dataList);
        	}else if(type=="2"){
        		table2(m,result.result.dataList);
        	}else if(type=="3"){
        		table3(m,result.result.dataList);
        	}else if(type=="4"){
        		table6(m,result.result.dataList);
        	}else if(type=="5"){
        		table3(m,result.result.dataList);
        	}else if(type=="6"){
        		table4(10,result.result.dataList);
        	}else if(type=="7"){
        		table5(m,result.result.dataList);
        	}else if(type=="8"){
        		table3(m,result.result.dataList);
        	}else if(type=="9"){
        		table3(m,result.result.dataList);
        	}else if(type=="10"){
        		table3(m,result.result.dataList);
        	}else if(type=="11"){
        		table3(m,result.result.dataList);
        	}
        },error : function () {
            $.jBox.error("查询出现错误","提示");
        }
	});
}
function table1(m,list){
	$("#dataList").empty(); 
	var temp="";
	temp+="<table class='table table-bordered'>";
	temp+="<thead><tr>";
	temp+="<th> </th>";
	for(var i=1;i<=m;i++){
		temp+="<th>"+i+"月</th>";
	}
	temp+="<th>总计</th>";
	temp+="<th>和上月差值</th>";
	temp+="<th>环比</th>";
	temp+="</tr></thead>";
	var total=0;
	var month=["01","02","03","04","05","06","07","08","09","10","11","12"];
	
	for(i=0;i<list.length;i++){
		if(list[i].type=="流量包总收入(万)"){
			temp+="<tr>";
			temp+= "<td>"+list[i].type+"</td>";
			for(var n=0;n<m;n++){
				if(isNull(list[i][month[n]])){
					temp+="<td>0</td>";
					total+=0;
				}else{
					temp+="<td>"+Number(list[i][month[n]]).toFixed(2)+"</td>";
					total+=list[i][month[n]];
				}
			}
			temp+="<td>"+Number(total).toFixed(2)+"</td>";
			if(m>1){
				if(isNull(list[i][month[m-1]])){
					if(isNull(list[i][month[m-2]])){
						temp+="<td>0</td>";
						temp+="<td>0%</td>";
					}else{
						temp+="<td>-"+Number((list[i][month[m-2]])).toFixed(2)+"</td>";
						temp+="<td>-100%</td>";
					}
				}else{
					if(isNull(list[i][month[m-2]])){
						temp+="<td>"+Number(list[i][month[m-1]]).toFixed(2)+"</td>";
						temp+="<td>100%</td>";
					}else{
						temp+="<td>"+Number((list[i][month[m-1]]-list[i][month[m-2]])).toFixed(2)+"</td>";
						temp+="<td>"+Number(((list[i][month[m-1]]-list[i][month[m-2]])/list[i][month[m-2]])*100).toFixed(2)+"%</td>";
					}
				}
			}else{
				if(isNull(list[i][month[m-1]])){
					if(isNull(list[i]["12P"])){
						temp+="<td>0</td>";
						temp+="<td>0</td>";
					}else{
						temp+="<td>"+Number((0-list[i]["12P"])).toFixed(2)+"</td>";
						temp+="<td>"+Number(((0-list[i][month[m-2]])/list[i][month["12P"]])*100).toFixed(2)+"%</td>";
					}
				}else{
					if(isNull(list[i]["12P"])){
						temp+="<td>"+Number(list[i][month[m-1]]).toFixed(2)+"</td>";
						temp+="<td>100%</td>";
					}else{
						temp+="<td>"+Number((list[i][month[m-1]]-list[i]["12P"])).toFixed(2)+"</td>";
						temp+="<td>"+Number(((list[i][month[m-1]]-list[i][month["12P"]])/list[i][month["12P"]])*100).toFixed(2)+"%</td>";
					}
				}
			}
			total=0;
			temp+="</tr>";
		}else{
			temp+="<tr>";
			temp+= "<td>"+list[i].type+"</td>";
			for(var n=0;n<m;n++){
				if(isNull(list[i][month[n]])){
					temp+="<td>0</td>";
					total+=0;
				}else{
					temp+="<td>"+Number(list[i][month[n]]/10000).toFixed(2)+"</td>";
					total+=list[i][month[n]];
				}
			}
			temp+="<td>"+Number(total/10000).toFixed(2)+"</td>";
			if(m>1){
				if(isNull(list[i][month[m-1]])){
					if(isNull(list[i][month[m-2]])){
						temp+="<td>0</td>";
						temp+="<td>0%</td>";
					}else{
						temp+="<td>-"+Number((list[i][month[m-2]])/10000).toFixed(2)+"</td>";
						temp+="<td>-100%</td>";
					}
				}else{
					if(isNull(list[i][month[m-2]])){
						temp+="<td>"+Number(list[i][month[m-1]]/10000).toFixed(2)+"</td>";
						temp+="<td>100%</td>";
					}else{
						temp+="<td>"+Number((list[i][month[m-1]]-list[i][month[m-2]])/10000).toFixed(2)+"</td>";
						temp+="<td>"+Number(((list[i][month[m-1]]-list[i][month[m-2]])/list[i][month[m-2]])*100).toFixed(2)+"%</td>";
					}
				}
			}else{
				if(isNull(list[i][month[m-1]])){
					if(isNull(list[i]["12P"])){
						temp+="<td>0</td>";
						temp+="<td>0</td>";
					}else{
						temp+="<td>"+Number((0-list[i]["12P"])/10000).toFixed(2)+"</td>";
						temp+="<td>"+Number(((0-list[i][month[m-2]])/list[i][month["12P"]])*100).toFixed(2)+"%</td>";
					}
				}else{
					if(isNull(list[i]["12P"])){
						temp+="<td>"+Number(list[i][month[m-1]]/10000).toFixed(2)+"</td>";
						temp+="<td>100%</td>";
					}else{
						temp+="<td>"+Number((list[i][month[m-1]]-list[i]["12P"])/10000).toFixed(2)+"</td>";
						temp+="<td>"+Number(((list[i][month[m-1]]-list[i][month["12P"]])/list[i][month["12P"]])*100).toFixed(2)+"%</td>";
					}
				}
			}
			total=0;
			temp+="</tr>";
		}
	}
	
	$("#dataList").html(temp);
	$.jBox.tip("查询成功","success");
}
function table2(m,list){
	$("#dataList").empty(); 
	var temp="";
	temp+="<table class='table table-bordered'>";
	temp+="<thead><tr>";
	temp+="<th> </th>";
	for(var i=1;i<=m;i++){
		temp+="<th>"+i+"月</th>";
	}
	temp+="<th>年度累计</th>";
	temp+="</tr></thead>";
	var total=0;
	var month=["01","02","03","04","05","06","07","08","09","10","11","12"];
	for(i=0;i<list.length;i++){
		temp+="<tr>";
		temp+= "<td>"+list[i].type+"</td>";
		for(var n=0;n<m;n++){
			if(isNull(list[i][month[n]])){
				temp+="<td>0</td>";
				total+=0;
			}else{
				temp+="<td>"+Number(list[i][month[n]]/10000).toFixed(2)+"</td>";
				total+=list[i][month[n]];
			}
		}
		temp+="<td>"+Number(total/10000).toFixed(2)+"</td>";
		total=0;
		temp+="</tr>";
	}
	$("#dataList").html(temp);
	$.jBox.tip("查询成功","success");
}

function table3(m,list){
	$("#dataList").empty(); 
	var temp="";
	temp+="<table class='table table-bordered'>";
	temp+="<thead><tr>";
	temp+="<th> </th>";
	for(var i=1;i<=m;i++){
		temp+="<th>"+i+"月</th>";
	}
	temp+="<th>年度累计</th>";
	temp+="<th>和上月差值</th>";
	temp+="</tr></thead>";
	var total=0;
	var month=["01","02","03","04","05","06","07","08","09","10","11","12"];
	
	for(i=0;i<list.length;i++){
		temp+="<tr>";
		temp+= "<td>"+list[i].province+"</td>";
		for(var n=0;n<m;n++){
			if(isNull(list[i][month[n]])){
				temp+="<td>0</td>";
				total+=0;
			}else{
				temp+="<td>"+Number(list[i][month[n]]/10000).toFixed(2)+"</td>";
				total+=list[i][month[n]];
			}
		}
		temp+="<td>"+Number(total/10000).toFixed(2)+"</td>";
		if(m>1){
			if(isNull(list[i][month[m-1]])){
				if(isNull(list[i][month[m-2]])){
					temp+="<td>0</td>";
				}else{
					temp+="<td>-"+Number((list[i][month[m-2]])/10000).toFixed(2)+"</td>";
				}
			}else{
				if(isNull(list[i][month[m-2]])){
					temp+="<td>"+Number(list[i][month[m-1]]/10000).toFixed(2)+"</td>";
				}else{
					temp+="<td>"+Number((list[i][month[m-1]]-list[i][month[m-2]])/10000).toFixed(2)+"</td>";
				}
			}
		}else{
			if(isNull(list[i][month[m-1]])){
				if(isNull(list[i]["12P"])){
					temp+="<td>0</td>";
				}else{
					temp+="<td>-"+Number((list[i]["12P"])/10000).toFixed(2)+"</td>";
				}
			}else{
				if(isNull(list[i]["12P"])){
					temp+="<td>"+Number(list[i][month[m-1]]/10000).toFixed(2)+"</td>";
				}else{
					temp+="<td>"+Number((list[i][month[m-1]]-list[i]["12P"])/10000).toFixed(2)+"</td>";
				}
			}
		}
		total=0;
		temp+="</tr>";
	}
	
	$("#dataList").html(temp);
	$.jBox.tip("查询成功","success");
}

function table4(m,list){
	$("#dataList").empty(); 
	var temp="";
	temp+="<table class='table table-bordered'>";
	temp+="<thead><tr>";
	temp+="<th class='table-statisticTH' style='white-space: nowrap;'> </th>";
	temp+="<th colspan='2'>流量包</th>";
	temp+="<th colspan='2'>低销	</th>";
	temp+="<th colspan='2'>畅视	</th>";
	temp+="<th colspan='2'>合约续约</th>";
	temp+="<th colspan='2'>终端换机</th>";
	temp+="<th colspan='3'> </th>";
	temp+="</tr>";
	temp+="<tr>";
	temp+="<th class='table-statisticTH' style='white-space: nowrap;'>省分</th>";
	temp+="<th>总部</th>";
	temp+="<th>省分</th>";
	temp+="<th>总部</th>";
	temp+="<th>省分</th>";
	temp+="<th>总部</th>";
	temp+="<th>省分</th>";
	temp+="<th>总部</th>";
	temp+="<th>省分</th>";
	temp+="<th>总部</th>";
	temp+="<th>省分</th>";
	temp+="<th>总部总计</th>";
	temp+="<th>省分总计</th>";
	temp+="<th>全部</th>";
	temp+="</tr></thead>";
	var total1=0;
	var total2=0;
	var month=["11","12","21","22","31","32","41","42","51","52"];
	
	for(i=0;i<list.length;i++){
		temp+="<tr>";
		temp+= "<td>"+list[i].province+"</td>";
		for(var n=0;n<m;n++){
			temp+="<td>"+Number(list[i][month[n]]).toFixed(0)+"</td>";
			var test = month[n].substr(1,1);
			if(month[n].substr(1,1)=="1"){
				total1+=list[i][month[n]];
			}else if(month[n].substr(1,1)=="2"){
				total2+=list[i][month[n]];
			}
		}
		temp+="<td>"+Number(total1).toFixed(0)+"</td>";
		temp+="<td>"+Number(total2).toFixed(0)+"</td>";
		temp+="<td>"+Number(total1+total2).toFixed(0)+"</td>";
		total1=0;
		total2=0;
		temp+="</tr>";
	}
	
	$("#dataList").html(temp);
	$.jBox.tip("查询成功","success");
}

function table5(m,list){
	$("#dataList").empty(); 
	var temp="";
	temp+="<table class='table table-bordered'>";
	temp+="<thead><tr>";
	temp+="<th>业务类型</th>";
	temp+="<th>触达用户(万)</th>";
	temp+="<th>成功订购(万)</th>";
	temp+="<th>成功率</th>";
	temp+="<th>订购量环比增加(万)</th>";
	temp+="<th>环比</th>";
	temp+="</tr></thead>";
	var month=["01","02","03","04","05","06","07","08","09","10","11","12"];
	var monthR=["01R","02R","03R","04R","05R","06R","07R","08R","09R","10R","11R","12R"];
	for(var i=0;i<5;i++){
		temp+="<tr>";
		temp+= "<td>"+list[i].type+"</td>";
		if(isNull(list[i][monthR[m-1]])){
			if(isNull(list[i][month[m-1]])){
				temp+="<td>0</td>";
				temp+="<td>0</td>";
				temp+="<td>0%</td>";
			}else{
				temp+="<td>0</td>";
				temp+="<td>"+Number(list[i][month[m-1]]/10000).toFixed(2)+"</td>";
				temp+="<td>100%</td>";
			}
		}else{
			if(isNull(list[i][month[m-1]])){
				temp+="<td>"+Number(list[i][monthR[m-1]]/10000).toFixed(2)+"</td>";
				temp+="<td>0</td>";
				temp+="<td>0%</td>";
			}else{
				temp+="<td>"+Number(list[i][monthR[m-1]]/10000).toFixed(2)+"</td>";
				temp+="<td>"+Number(list[i][month[m-1]]/10000).toFixed(2)+"</td>";
				temp+="<td>"+Number((list[i][month[m-1]]/list[i][monthR[m-1]])*100).toFixed(2)+"%</td>";
			}
		}
		if(m>1){
			if(isNull(list[i][month[m-1]])){
				if(isNull(list[i][month[m-2]])){
					temp+="<td>0</td>";
					temp+="<td>0</td>";
				}else{
					temp+="<td>-"+Number((list[i][month[m-2]])/10000).toFixed(2)+"</td>";
					temp+="<td>-100%</td>";
				}
			}else{
				if(isNull(list[i][month[m-2]])){
					temp+="<td>"+Number(list[i][month[m-1]]/10000).toFixed(2)+"</td>";
					temp+="<td>100%</td>";
				}else{
					temp+="<td>"+Number((list[i][month[m-1]]-list[i][month[m-2]])/10000).toFixed(2)+"</td>";
					temp+="<td>"+Number(((list[i][month[m-1]]-list[i][month[m-2]])/list[i][month[m-2]])*100).toFixed(2)+"%</td>";
				}
			}
		}else{
			if(isNull(list[i][month[m-1]])){
				if(isNull(list[i]["12P"])){
					temp+="<td>0</td>";
					temp+="<td>0%</td>";
				}else{
					temp+="<td>"+Number((0-list[i]["12P"])/10000).toFixed(2)+"</td>";
					temp+="<td>"+Number(((0-list[i][month[m-2]])/list[i][month["12P"]])*100).toFixed(2)+"%</td>";
				}
			}else{
				if(isNull(list[i]["12P"])){
					temp+="<td>"+Number(list[i][month[m-1]]/10000).toFixed(2)+"</td>";
					temp+="<td>100%</td>";
				}else{
					temp+="<td>"+Number((list[i][month[m-1]]-list[i]["12P"])/10000).toFixed(2)+"</td>";
					temp+="<td>"+Number(((list[i][month[m-1]]-list[i][month["12P"]])/list[i][month["12P"]])*100).toFixed(2)+"%</td>";
				}
			}
		}
		temp+="</tr>";
	}
	$("#dataList").html(temp);
	$.jBox.tip("查询成功","success");
}
function table6(m,list){
	$("#dataList").empty(); 
	var temp="";
	temp+="<table class='table table-bordered'>";
	temp+="<thead><tr>";
	temp+="<th> </th>";
	for(var i=1;i<=m;i++){
		temp+="<th>"+i+"月</th>";
	}
	temp+="<th>年度累计</th>";
	temp+="<th>和上月差值</th>";
	temp+="</tr></thead>";
	var total=0;
	var month=["01","02","03","04","05","06","07","08","09","10","11","12"];
	
	for(i=0;i<list.length;i++){
		temp+="<tr>";
		temp+= "<td>"+list[i].province+"</td>";
		for(var n=0;n<m;n++){
			if(isNull(list[i][month[n]])){
				temp+="<td>0</td>";
				total+=0;
			}else{
				temp+="<td>"+Number(list[i][month[n]]).toFixed(2)+"</td>";
				total+=list[i][month[n]];
			}
		}
		temp+="<td>"+Number(total).toFixed(2)+"</td>";
		if(m>1){
			if(isNull(list[i][month[m-1]])){
				if(isNull(list[i][month[m-2]])){
					temp+="<td>0</td>";
				}else{
					temp+="<td>"+Number((0-list[i][month[m-2]])).toFixed(2)+"</td>";
				}
			}else{
				if(isNull(list[i][month[m-2]])){
					temp+="<td>"+Number(list[i][month[m-1]]).toFixed(2)+"</td>";
				}else{
					temp+="<td>"+Number((list[i][month[m-1]]-list[i][month[m-2]])).toFixed(2)+"</td>";
				}
			}
		}else{
			if(isNull(list[i][month[m-1]])){
				if(isNull(list[i]["12P"])){
					temp+="<td>0</td>";
				}else{
					temp+="<td>"+Number((0-list[i]["12P"])).toFixed(2)+"</td>";
				}
			}else{
				if(isNull(list[i]["12P"])){
					temp+="<td>"+Number(list[i][month[m-1]]).toFixed(2)+"</td>";
				}else{
					temp+="<td>"+Number((list[i][month[m-1]]-list[i]["12P"])).toFixed(2)+"</td>";
				}
			}
		}
		total=0;
		temp+="</tr>";
	}
	
	$("#dataList").html(temp);
	$.jBox.tip("查询成功","success");
}
function exportCurrentTable() {
	var sFileName = $("#product").find("option:selected").text();
	$("#dataList").tableExport({fileName:sFileName, type:"excel", escape:"false"});
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
		    <div class="search" id="monthDiv">
		        <label class="name" for="">月份：</label>
		        <input type="text" class="u-input-text search-box box-input" name="month" id="month" value="${Month}">
		    </div>
		</div>
		<div class="z-search z-top">
			<div class="search" id="productDiv">
				<label class="name" for="">产品：</label>
				<select class="u-input-text search-box" name="product" id="product">
					<option value="1">总览1</option>
					<option value="2">总览2</option>
					<option value="3">订购量</option>
					<option value="4">收入</option>
					<option value="5">触达数</option>
					<option value="6">场景</option>
					<option value="7">分类汇总</option>
					<option value="8">流量包</option>
					<option value="9">畅越</option>
					<option value="10">合约续约</option>
					<option value="11">终端换机</option>
				</select>
			</div>
		</div>
		</div>
		<div class="button-box-h">
		     <a class="button chaxun" onclick="getColumnData()">查询</a>
		     <a class="button daochu" onclick="exportCurrentTable()">导出汇总表</a>
		</div>
	</div>
	<div class="data d2">
		<div style="width:100%;overflow:auto;">
			<table id="dataList" class="table table-bordered"></table>
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