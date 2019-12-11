<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String path1 = request.getContextPath();
	String basePath1 = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path1 + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>组织机构管理页-大数据运营后台管理系统</title>
<base href="<%=basePath1 %>" />
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/general.css">
<link rel="stylesheet" href="css/layout.css">
<link rel="stylesheet" href="css/core.css">
<link rel="stylesheet" href="js/kkpager/kkpager_blue.css">
<link rel="stylesheet" href="js/zTree_v3/css/zTreeStyle/zTreeStyle.css">
<link rel="stylesheet" href="js/jbox/jbox.css">
<script type="text/javascript" src="js/jquery-2.1.4.js"></script>
<script type="text/javascript" src="js/validate/jquery.validate.min.js"></script>
<script type="text/javascript"
	src="js/validate/additional-methods.min.js"></script>
<script type="text/javascript" src="js/validate/messages_zh.js"></script>
<script type="text/javascript" src="js/kkpager/kkpager.min.js"></script>
<script type="text/javascript" src="js/modal/bootstrap-modal.js"></script>
<script type="text/javascript" src="js/modal/bootstrap-modalmanager.js"></script>
<script type="text/javascript"
	src="js/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="resources/js/menu.js"></script>
<script type="text/javascript" src="resources/js/system/main.js"></script>

<script type="text/javascript" src="js/jbox/jquery.jBox-2.3.min.js"></script> 
<script type="text/javascript" src="js/jbox/jquery.jbox-zh-cn.js"></script>

<!--[if IE 6]> 
      <script type="text/javascript" src="Lib/DD_belatedPNG_0.0.8a-min.js" ></script>
      <script>DD_belatedPNG.fix('.pngfix,.icon');</script> 
    <![endif]-->

<script type="text/javascript">
	$(document).ready(function() {
		getOrganizeTree();
	});
	function parentOrgCodeShow() {

		$.ajax({
			type : 'POST',
			url : 'organize/getOrganizeTree.do',
			datatype : 'text',
			success : function(result) {
				$.fn.zTree.init($("#organizeTree1"), {
					data : {
						simpleData : {
							enable : true
						}
					},
					callback : {
						onClick : zTreeOnClickNum
					}
				}, result);
			}
		});
	}

	// 树点击事件
	function zTreeOnClickNum(event, treeId, treeNode) {
		/*     $("#organizeTable1").datagrid('load', {
		        parentOrgCode : treeNode.pkId == "-1" ? "" : treeNode.pkId
		       
		    }); */
		$('#parentOrgCode').val(treeNode.pkId == "-1" ? "-1" : treeNode.pkId);
		$('#Modal-select').modal('hide');
		 changeTip(); 

		/*  $('#orgName').val("");
		 $('#orgCode').val("");
		 $('#status').val(""); */
	}

	// 加载组织机构树结构
	function getOrganizeTree() {
		$.ajax({
			type : 'POST',
			url : 'organize/getOrganizeTree.do',
			datatype : 'text',
			success : function(result) {
				$.fn.zTree.init($("#organizeTree"), {
					data : {
						simpleData : {
							enable : true
						}
					},
					callback : {

					}
				}, result);
			}
		});
	}
	function changeTip() {
		var orgName = $("#orgName").val();
		var orgCode = $("#orgCode").val();
		var parentOrgCode = $("#parentOrgCode").val();
		if (null != orgName || "" != orgName) {
			$("#orgNameTip").hide();
		}
		if (null != orgCode || "" != orgCode) {
			$("#orgCodeTip").hide();
		}
		if (null != parentOrgCode || "" != parentOrgCode) {
			$("#parentOrgCodeTip").hide();
		}
	}

	// 保存
	function save() {
		var RegularExp=/^[A-Za-z0-9]+$/;
		var orgName = $("#orgName").val();
		if (orgName == null || orgName == "") {
			$("#orgNameTip").show();
			return false;
		}
		var orgCode = $("#orgCode").val();
		if (orgCode == null || orgCode == "") {
			$("#orgCodeTip").show();
			return false;
		}else{
			if (!RegularExp.test(orgCode)){
				$("#orgCodeTip1").show();
				return false;
			}
		}
		
		var parentOrgCode = $("#parentOrgCode").val();
		if (parentOrgCode == null || parentOrgCode == "") {
			$("#parentOrgCodeTip").show();
			return false;
		}
		var orgCode = $("#orgCode").val();
		var orgName = $("#orgName").val();
		var parentOrgCode = $("#parentOrgCode").val();
		var orgDesc = $("#orgDesc").val();
		var status = $("#status").val();
	    var type = $("#type").val();

		$
				.ajax({
					type : 'POST',
					url : 'organize/update.do',
					data : {
						orgCode : orgCode,
						orgName : $.trim(orgName),
						parentOrgCode : parentOrgCode,
						status : status,
						type : type,
						orgDesc : orgDesc
					},
					datatype : 'json',
					success : function(msg) {
					if (msg.flag) { 
							$.jBox.tip(msg.msg, '提示'); 
							getOrganizeTree();
							setTimeout("window.location.href='organize/index.do'",500);
						} else {
							//$.jBox.error(msg.msg, '提示');
							    $.jBox.error('新增失败！<br/>失败原因：'+msg.msg, '提示');
							return false;
						} 
						//history.go(-1);
					},
					error : function() {
						$.jBox.error(msg.msg, '提示');
						return false;
					}
				});
	}
</script>


</head>

<body style="width:100%;height:100%;overflow-y:auto;overflow-x:hidden">

<div class="u-body">
	<div class="u-title">
		<span>新增组织机构</span>
	</div>
	<div class="data d2">
		<div class="left-tree" style="height:315px">
			<ul id="organizeTree" class="ztree lt">
			</ul>
		</div>
		<div class="right-table">
			<form id="orgAddForm" action=""method="post">
				<div class="biaodan">
					<label class="name" for="" onchange="changeTip()">机构名称：</label>
					<input type="hidden" class="b-input-text" id="type" name="type" maxlength="64" value="${type}">
					<input type="text" class="b-input-text" id="orgName" maxlength="64" onchange="changeTip()"value="${sysOrganize.orgName}">
					<span class="c-red" style="display:none" id="orgNameTip" name="orgNameTip">请输入机构名称</span>
				</div>
				<div class="biaodan">
					<label class="name" for="">机构编码：</label>
					<input type="text" class="b-input-text" id="orgCode" maxlength="32" onchange="changeTip()" value="${sysOrganize.orgCode}" readonly disabled="">
					<span class="c-red" style="display:none" id="orgCodeTip" name="orgCodeTip">请输入机构编码</span>
				</div>
				<div class="biaodan">
					<label class="name" for="">上级机构：</label>
					<input type="text" class="b-input-text input-min fl" id="parentOrgCode" maxlength="32"onchange="changeTip()" style="width:170px" value="${sysOrganize.parentOrgCode}">
					<input type="hidden" class="b-input-text input-min fl" id="status" name="status" maxlength="32" value="${sysOrganize.status}">
					<a href="#Modal-select" data-toggle="modal" class="btn btn-third fl" onclick="parentOrgCodeShow()" style="margin-left:20px">选择上级机构</a>
				</div>
				<div class="biaodan">
					<label class="name n2">机构描述：</label>
					<div class="b-input-text b2">
						<textarea name="orgDesc" id="orgDesc" cols="40" rows="5" maxlength="500" value="">${sysOrganize.orgDesc}</textarea>
					</div>
				</div>
			</form>
			<div class="button-box-v">
				<a class="button baocun baocun-2" onclick="save()">提交</a>
				<a class="button quxiao quxiao-2" href="javascript:history.go(-1);">取消</a>
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
<!--删除对话框--->

<div id="Modal-select" class="modal w300 hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="Modal-edit-box">
		<div class="modal-header">
			<h3 id="myModalLabel">选择上级机构</h3>
			<a class="close" data-dismiss="modal" aria-hidden="true" href="javascript:void();"><i class="fa fa-times"></i></a>
		</div>
		<div class="modal-body">
			<!--树状菜单-->
			<ul id="organizeTree1" class="ztree">
			</ul>
		</div>
	</div>
</div>
</body>

</html>