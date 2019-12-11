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
<title>角色管理页-大数据运营后台管理系统</title>
<base href="<%=basePath1 %>" />

    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/general.css">
    <link rel="stylesheet" href="css/layout.css">
    <link rel="stylesheet" href="css/core.css">
    <link rel="stylesheet" href="js/kkpager/kkpager_blue.css">
    <link rel="stylesheet" href="js/jbox/jbox.css">
    <script type="text/javascript" src="js/jquery-2.1.4.js"></script> 
    <script type="text/javascript" src="js/validate/jquery.validate.min.js"></script> 
    <script type="text/javascript" src="js/validate/additional-methods.min.js"></script> 
    <script type="text/javascript" src="js/validate/messages_zh.js"></script> 
    <script type="text/javascript" src="js/kkpager/kkpager.min.js"></script> 
    <script type="text/javascript" src="js/modal/bootstrap-modal.js"></script> 
    <script type="text/javascript" src="js/modal/bootstrap-modalmanager.js"></script> 
    <script type="text/javascript" src="js/jbox/jquery.jBox-2.3.min.js"></script> 
    <script type="text/javascript" src="js/jbox/jquery.jbox-zh-cn.js"></script> 
    
<%-- main.js用于获取当前登录用户可操作功能数据 --%>
<script type="text/javascript" src="resources/easyui13/jquery.easyui.min.js"></script>
<script type="text/javascript" src="resources/easyui13/locale/easyui-lang-en.js"></script>
<script type="text/javascript" src="resources/common/easyui-expand.js"></script>
<script type="text/javascript" src="resources/common/easyui-validate.js"></script>

<script type="text/javascript" src="resources/js/system/main.js"></script>
<script type="text/javascript" src="resources/js/menu.js"></script>
</head>
<script type="text/javascript">
	$(function(){
		searchList();
	});
	function beforDel(roleId){
		$("#roleId").val(roleId);
	}
	function del(){
		$("#Modal-delete").modal('hide');
		var roleCode = $("#roleId").val();
  		$.ajax({
  			type: "POST",
  			url: "sysRole/delRole.do",
  			data: {roleCode:roleCode},
  			datatype: "json",
  			success: function(data){
  				if (data.flag) {
	  				searchList();
				}else{
		            $.jBox.error(data.msg, '提示');
				}
  			}
  		});
	}
</script>
<input type="hidden" id="roleId" />
<!-- 获取列表 -->
<script type="text/javascript">
	var totalPage;
	var totalRecords;
	var page = 1;
	var param = {};
	function searchList(){
		page = 1;
  		var roleCode = $("#roleCode").val()==undefined?"":$("#roleCode").val();
  		var roleName = $("#roleName").val()==undefined?"":$("#roleName").val();
  		//var status = $("#status option:selected").val()==undefined?"":$("#status option:selected").val();
  		param["roleCode"] = roleCode.trim();
  		param["roleName"] = roleName.trim();
  		//param["status"] = status;
  		param["page"] = page;
  		getList();
	}
	function changPage(){
		page = $(".curr").text()==undefined||$(".curr").text()==""?1:$(".curr").text();
  		param["page"] = page;
  		getList();
	}
	function getList(){
  		$.ajax({
  			type: "POST",
  			url: "sysRole/getRoleList.do",
  			data: param,
  			datatype: "json",
  			success: function(data){
  				if (data!=null) {
  					var sysRoleList = data.rows;
  					totalPage = data.totalPage;
  					totalRecords = data.totalNumber;
  					$("#rolList").empty();
  					var temp = "<tr><th>角色名称</th><th>角色编码</th><th>描述</th><th>操作</th></tr>";
  					for(x in sysRoleList){
  						var roleStatus = sysRoleList[x].status==1?"<b class=\"c-primary\">有效</b>":"无效";
  						temp+="<tr>"
  					    +"<td>"+sysRoleList[x].roleName+"</td>"
  					    +"<td>"+sysRoleList[x].roleCode+"</td>"
  					    /* +"<td>"+roleStatus+"</td>" */
  					    +"<td>"+sysRoleList[x].roleDesc+"</td>"
  					    +"<td>"
  					    +"<c:if test='${sessionScope.funOperate["SYS_USER_ROLE_CHECK"] }'>"
						+"<a class=\"btn btn-op\" onClick=\"roleDetail(\'"+sysRoleList[x].roleCode+"\')\" data-toggle=\"modal\" href=\"#Modal-detail\" title=\"查看\"><i class=\"fa fa-search\"></i></a>"
						+"</c:if>"
						+"<c:if test='${sessionScope.funOperate["SYS_USER_ROLE_UPDATE"] }'>"
						+"<a class=\"btn btn-op ml-10\" href=\"sysRole/toPage.do?roleCode="+sysRoleList[x].roleCode+"&operType=edit\" title=\"修改\"><i class=\"fa fa-edit\"></i></a>"
						+"</c:if>"
						+"<c:if test='${sessionScope.funOperate["SYS_USER_ROLE_DELETE"] }'>"
						+"<a class=\"btn btn-op ml-10\" onClick=\"beforDel('"+sysRoleList[x].roleCode+"');\" data-toggle=\"modal\" href=\"#Modal-delete\" title=\"删除\"><i class=\"fa fa-trash\"></i></a>"
  					    +"</c:if>"
  					    +"</td>"
  					+"</tr>"
  					}
  					$("#rolList").append(temp);
  					toPage();
  				}else{
  					
  				}
  			}
  		});
	}
</script>
<!-- 加载分页控件 -->
<script type="text/javascript">
	function toPage(){
		kkpager.total = totalPage;
		kkpager.totalRecords = totalRecords;
		kkpager.pno = page;
		kkpager.hasPrv = (kkpager.pno > 1)
		kkpager.hasNext = (kkpager.pno < kkpager.total);
		kkpager.generPageHtml({
		     pno : page,
		     mode : 'click', 
		     total : totalPage,  
		     totalRecords : totalRecords,
		     click : function(n){
		         this.selectPage(n);
		  		 changPage();
		         return false;
		     },
		     getHref : function(n){
		         return 'javascript:void(0)';
		     }
			 },true);
	}
</script>

<body style="width:100%;height:100%;overflow:auto">

<div class="u-body">
	<div class="u-title">
		<span>角色管理</span>
		<div class="button-up"></div>
		<script>
		$(document).ready(function(){
	     // 搜索收缩
	    $(".button-up").click(function(){
	        $('.u-search').toggleClass('u-search-close');
	        $('.button-up').toggleClass('button-down');
	    });  
	    getAllThreeNatural();
	  });
		</script>
	</div>
	<div class="u-search">
		<div class="search">
			<label class="name n2" for="">角色名称：</label>
			<input id="roleName" name="roleName" type="text" class="u-input-text search-box box-input" >
		</div>
		<div class="search" style="margin-left:10px;">
			<label class="name n2" for="">角色编码：</label>
			<input id="roleCode" name="roleCode" type="text" class="u-input-text search-box box-input" >
		</div>
		<div class="button-box-m">
			<a onClick="searchList();" class="button chaxun">查询</a>  
            <c:if test="${sessionScope.funOperate['SYS_USER_ROLE_ADD'] }">
            <a href="sysRole/toPage.do?operType=add" class="button xinzeng">新增</a>
            </c:if>
		</div>
	</div>
	<div class="data d2 ">
		<table id="rolList" class="table table-bordered table-bordered2"></table>
		<!--分页-->
		<div id="kkpager" class="kkpager"></div>
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

 <!--查看对话框--->
 <script type="text/javascript">
 	function roleDetail(roleCodeDetail){
  		$.ajax({
  			type: "POST",
  			url: "sysRole/toDetail.do",
  			data: {roleCode:roleCodeDetail},
  			datatype: "json",
  			success: function(data){
  				$("#roleCodeDetail").val(data.roleCode);
  				$("#roleNameDetail").val(data.roleName);
  				$("#roleDescDetail").val(data.roleDesc);
  			}
  		});
 	}
 </script>
    <div id="Modal-detail" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="Modal-edit-box">
        <div class="modal-header">
            <h3 id="myModalLabel">角色信息</h3><a class="close" data-dismiss="modal" aria-hidden="true" href="javascript:void();"><i class="fa fa-times"></i></a>
        </div>
        <div class="modal-body">
            <div class="form-group cl">
				<label class=" fl">角色编码：</label>
				<input class="input-text fl" type="text" disabled="" id="roleCodeDetail" value="">
			</div>
	        <div class="form-group cl">
				<label class=" fl">角色名：</label>
				<input class="input-text fl" type="text" disabled="" id="roleNameDetail" value="">
				</div>
	        <div class="form-group cl">
	            <label class="fl" for="">角色描述：</label>
	            <div class="formControls fl">
	                <textarea class="textarea" name="" id="roleDescDetail" cols="40" rows="5" disabled="" ></textarea>
	            </div>
	        </div> 
        </div>
		    <div class="button-box">
		        <<button class="button close" data-dismiss="modal" aria-hidden="true">关闭</button>
		 	</div>
    </div>
    </div>

<!--删除对话框--->
<div id="Modal-delete" class="modal w300 hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<div class="Modal-edit-box">
 <div class="modal-header">
    <h3 id="myModalLabel">删除</h3><a class="close" data-dismiss="modal" aria-hidden="true" href="javascript:void();"><i class="fa fa-times"></i></a>
 </div>
  <div class="modal-body">
 <p class="tsxx">确定删除此角色用户？</p>
 </div>
    <div class="button-box">
       <button onclick="del();" class="button queding">确定</button> 
	   <button class="button quxiao" data-dismiss="modal" aria-hidden="true">取消</button>
	</div>
</div>
</div>
</body>
</html>
