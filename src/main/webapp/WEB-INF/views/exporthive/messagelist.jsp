<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
    String path1 = request.getContextPath();
    String basePath1 = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort() + path1 + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>用户管理页-大数据运营后台管理系统</title>
<base href="<%=basePath1 %>" />
<!--[if lt IE 9]>
<script src="http://apps.bdimg.com/libs/html5shiv/3.7/html5shiv.min.js"></script>
<![endif]-->
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/general.css">
<link rel="stylesheet" href="css/layout.css">
<link rel="stylesheet" href="css/core.css">
<link rel="stylesheet" href="js/kkpager/kkpager_blue.css">
    <link rel="stylesheet" href="js/jbox/jbox.css">
    <link rel="stylesheet" href="js/jbox/jbox.css">

    <script type="text/javascript" src="js/jquery-2.1.4.js"></script>
<script type="text/javascript" src="js/validate/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/validate/additional-methods.min.js"></script>
<script type="text/javascript" src="js/validate/messages_zh.js"></script>
<script type="text/javascript" src="js/kkpager/kkpager.min.js"></script>
<script type="text/javascript" src="js/modal/bootstrap-modal.js"></script>
<script type="text/javascript" src="js/modal/bootstrap-modalmanager.js"></script>
<script type="text/javascript" src="js/modal/bootstrap-modal.js"></script>
<script type="text/javascript" src="js/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="js/jbox/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="js/jbox/jquery.jbox-zh-cn.js"></script>
    <script type="text/javascript" src="js/jbox/jquery.jBox-2.3.min.js"></script>
    <script type="text/javascript" src="js/jbox/jquery.jbox-zh-cn.js"></script>

    <!--[if IE 6]>
<script type="text/javascript" src="Lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('.pngfix,.icon');</script>
<![endif]-->
<script type="text/javascript">
    var totalPage;
    var totalRecords;
    var pageNo = 1;
    $(function(){
    	getList();
    });
    //列表
    function getList() {
       
        $.ajax({
            url : "exporthive/getMessageList.do",
            type : 'post',
            data :{"page" : pageNo},
            dataType : 'json',
            success :function (data) {
                var  html ="";
                var list=data.rows;
                for(var i in list){
                    html += "<tr>";
                    html += "<td>"+list[i].exportComment+"</td>";
                    html += "<td>"+list[i].exportTime+"</td>";
                   
                    
                    if(list[i].exportState=="00"){
                        html += "<td>发起导出</td>";
                    }else if(list[i].exportState=="01"){
                        html += "<td>开始导出</td>";
                    }else if(list[i].exportState=="02"){
                        html += "<td>导出完毕</td>";
                    }else if(list[i].exportState=="10"){
                        html += "<td><b class='c-primary'>异常</b></td>";
                    }else if(list[i].exportState=="03"){
                        html += "<td>停止</td>";
                    }
                    if(list[i].exportAddress == null){
                    	html += "<td></td>";
                    }else{
                    	html += "<td>"+list[i].exportAddress+"</td>";
                    }
                    //在发起导出和开始导出阶段可以停止导出
                    if(list[i].exportState=="00" || list[i].exportState=="01"){
                    	html +="<td>"
                    		+"<a class=\"btn btn-op ml-10\" onClick=\"exportStop('"+list[i].exportId+"');\" data-toggle=\"modal\"  title=\"停止导出\"><i class=\"fa fa-trash\"></i></a>";
                    		+"</td>";
                    }else{
                    	html += "<td></td>";
                    }
                    html += "</tr>";
                }
                $("#exportList").html(html);
                totalPage = data.totalPage;
                totalRecords = data.totalNumber;
//                pageNo = data.currentPage;
                toPage();
            },
            error : function () {
                
            }
        });
    }
    //格式化时间
    function FormatDate (strTime) {
        var date = new Date(strTime);
        var mon;var day;var hour;var min;
        var  temp=date.getMonth()+1;
        if(temp<10){mon="0"+temp;}else {mon=temp;}
        if(date.getDate()<10){day="0"+date.getDate();}else {day=date.getDate();}
        if(date.getHours()<10){hour="0"+date.getHours();}else {hour=date.getHours();}
        if(date.getMinutes()<10){min="0"+date.getMinutes();}else {min=date.getMinutes();}
        return date.getFullYear()+"-"+mon+"-"+day+" "+hour+":"+min;
    }
    function changPage(){
        pageNo = $(".curr").text()==undefined||$(".curr").text()==""?1:$(".curr").text();
        getList();
    }
    //分页
    function toPage(){
        //alert("总页数"+totalPage+"-总数据"+totalRecords+"-当前页"+pageNo);
        kkpager.total = totalPage;
        kkpager.totalRecords = totalRecords;
        kkpager.pno = pageNo;
        kkpager.hasPrv = (kkpager.pno > 1)
        kkpager.hasNext = (kkpager.pno < kkpager.total);
        kkpager.generPageHtml({
            pno : pageNo,
            mode : 'click',
            total : totalPage,
            totalRecords : totalRecords,
            click : function(n){
                this.selectPage(n);
                changPage();
                return false;
            },
            getHref : function(n){
                return "javascript:void(0)";
            }
        },true);
    }
   
   
    function exportStop(exportId){
    	
		$.ajax({
			url : "exporthive/stopExport.do",
			type : "post",
			data : {"exportId" : exportId},
			dataType : 'json',
			success :function (msg) {
				if (msg.flag) {
					$.jBox.success(msg.msg, "提示",'warning');
					getList();
				}else{
					$.jBox.error(msg.msg, '提示');
				}
			},
			error : function(e) {
				$.jBox.error("提交数据异常", '提示');
			}
		});
    }
</script>
</head>
<body style="width:100%;height:100%;overflow-y:auto">

<div class="u-body">
	<div class="u-title">
		<span>导出任务</span>
	</div>
    <div class="data d2">
	    <table class="table table-bordered">
			<thead class="thead">
			<tr>
				<th style="width:20%">任务名称</th>
				<th style="width:20%">导出时间</th>
				<th style="width:15%">导出状态</th>
				<th style="width:35%">下载地址</th>
				<th style="width:10%">操作</th>
			</tr>
		    </thead>
			    <tbody id="exportList" class="table"></tbody>
		</table>
		<!--分页-->
		<div id="kkpager" class="kkpager"></div>
	</div>
</div>		
<div class="index-footer" style="margin-top:80px">
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



<!--删除对话框--->
<div id="Modal-delete" class="modal w300 hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-header">
        <h3 id="myModalLabel">删除</h3><a class="close" data-dismiss="modal" aria-hidden="true" href="javascript:void();"><i class="fa fa-times"></i></a>
    </div>
    <div class="modal-body">
        <p>确定删除此角色用户？</p>
    </div>
    <div class="modal-footer text-c">
        <button class="btn btn-close" data-dismiss="modal" aria-hidden="true">关闭</button>
        <button class="btn btn-primary">确定</button>
    </div>
</div>


</body>
</html>