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

<base href="<%=basePath1%>" />
<meta charset="UTF-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>组织机构管理页-大数据运营后台管理系统</title>
<!--[if lt IE 9]>
      <script src="http://apps.bdimg.com/libs/html5shiv/3.7/html5shiv.min.js"></script>
    <![endif]-->
<%@ include file="/commons/pages/common.jsp"%>
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/general.css">
<link rel="stylesheet" href="css/layout.css">
<link rel="stylesheet" href="css/core.css">
<link rel="stylesheet" href="js/kkpager/kkpager_blue.css">
<link rel="stylesheet" href="js/jbox/jbox.css">
<link rel="stylesheet" href="js/zTree_v3/css/zTreeStyle/zTreeStyle.css">
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
<!-- <script type="text/javascript"
	src="resources/js/organize/managerOrganize.js"></script> -->
<script type="text/javascript" src="js/jbox/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="js/jbox/jquery.jbox-zh-cn.js"></script>
	
<!-- <script type="text/javascript" src="js/app.js"></script> -->
<!--[if IE 6]> 
      <script type="text/javascript" src="Lib/DD_belatedPNG_0.0.8a-min.js" ></script>
      <script>DD_belatedPNG.fix('.pngfix,.icon');</script> 
    <![endif]-->
<script type="text/javascript">
	//点击组织管理加载页面
    $(document).ready(function() {
       		 getOrganizeTree();
    });
	function orgAdd() {
		window.location.href = "organize/orgAdd.do?type="+0;
	}
	//组织管理加载页面
	var totalPage;
	var totalRecords;
	var pageNo = 1;
	var param = {};
	$(function() {
		organizeList();
	});
	function organizeList(OnorgCode) {
		/*if (OnorgCode==(undefined)){
			OnorgCode="";
		} */
		/* if (OnorgCode!=""){
		var OnorgCode = $("#orgCode").val(OnorgCode);
		} */
		var orgName = $("#orgName").val().trim();
		var orgCode = $("#orgCode").val().trim();
		var status = $("#status").val()==undefined?"":$("#status").val();
		
				$.ajax({
					url : "organize/getOrganizeList.do",
					data : {
						"orgName" : orgName,
						"orgCode" : orgCode,
						"OnorgCode" : OnorgCode,
						"status" : status,
						"pageNo" : pageNo
					},
					type : "post",
					dataType : "json",
					success : function(result) {
						var html = "";
						$("#organizeList").html("");
						var list = result.objects;
						for ( var i in list) {
							/* var status = list[i].status;
							status  = status=="0"?"<b>无效</b>":"<b class=\"c-primary\">有效</b>"; */
							html += "<tr>";
							html += "<td>" + list[i].orgName + "</td>";
							html += "<td>" + list[i].orgCode + "</td>";
							/* html += "<td>"+status+"</td>"; */
							html += '<td><c:if test='${sessionScope.funOperate["SYS_ORGANIZE_CHECK"] }'><a class="btn btn-op ml-10" data-toggle="modal"" href="#Modal-edit" title="查看" onclick="getOrganizeDetail(\''
									+ list[i].orgCode
									+ '\',\'0\')"><i class="fa fa-search"></i></a></c:if>'
									+ '<c:if test='${sessionScope.funOperate["SYS_ORGANIZE_UPDATE"] }'><a class="btn btn-op ml-10"" data-toggle="modal""title="修改"  onclick="OrganizeModify(\''
									+ list[i].orgCode
									+ '\',\'1\')"><i class="fa fa-edit"></i></a></c:if>'
									+ '<c:if test='${sessionScope.funOperate["SYS_ORGANIZE_DELETE"] }'><a class="btn btn-op ml-10" onclick="OrganizeDelete(\''
									+ list[i].orgCode
									+ '\',\'1\')" data-toggle=\"modal\" href=\"#Modal-delete\" title=\"删除\"><i class=\"fa fa-trash\"></i></a></c:if>'
									+ '</td>';
							/* 	if("1" == list[i].status){
									 html +=' <td><div class="switch"><label class="switch-radio" for="switchOption7">启用</label>' +
							        '<input type="radio" checked="checked">' +
							        '<label class="switch-radio" for="switchOption8">禁用</label><input type="radio" name="switchOptions4" id="switchOption8" value="option8" ></div></td>';
								}else{
									html +='<td><div class="switch switch-off"><label class="switch-radio" for="switchOption7">启用</label>' +
							        '<input type="radio"  checked="checked"><label class="switch-radio" for="switchOption7">禁用</label>' +
							        '<input type="radio" checked="checked"></div></td>';
								} */
							html += "</tr>";
						}
						$("#organizeList").html(html);
						totalPage = result.totalPage;
						totalRecords = result.totalNumber;
						pageNo = result.currentPage;
						toPage();
					},
					error : function() {
					    $.jBox.error('查询菜单列表失败!', '提示');
						return false;
					}
				});
	}

	//查看
	function getOrganizeDetail(orgCode, type) {
		$.ajax({
			url : "organize/getOrganizeDetail.do",
			type : "post",
			data : {
				"orgCode" : orgCode
			},
			dataType : 'json',
			success : function(sysOrganizeVo) {
				/* var obj = data.object; */
				$("#orgCodeShow").val(sysOrganizeVo.orgCode);
				$("#orgNameShow").val(sysOrganizeVo.orgName);
				$("#parentOrgCodeShow").val(sysOrganizeVo.parentOrgCode);
				$("#orgDescShow").val(sysOrganizeVo.orgDesc);
			},
			error : function() {
				alert("查看失败");
				return false;
			}
		});
	}
	//修改
	function OrganizeModify(orgCode, type) {
		window.location.href = "organize/orgModify.do?orgCode=" + orgCode+"&type="+type;
	}
	function OrganizeDelete(orgCode){
		$("#orgCodeHide").val(orgCode);
	}
	//删除
	function del(orgCode, type) {
		$("#Modal-delete").modal('hide');
		var orgCode = $("#orgCodeHide").val();
		$.ajax({
			type : "POST",
			url : "organize/delete.do",
			data : {
				orgCode : orgCode
			},
			datatype : "json",
			success : function(data) {
				if (!data.flag) {
					alert(data.msg);
				}
				organizeList();
				getOrganizeTree();
			}
		});
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
		              				onClick : zTreeOnClickNum
		                }
		            }, result);
		        }
		    });
		}
   		 // 树点击事件
   	    var addMenuId = [];//记录系统菜单中选中的node.id(包含父级)
		function zTreeOnClickNum(event, treeId, treeNode) {
			addMenuId = [];
			getNodeId(addMenuId,treeNode);
			organizeList(addMenuId.join(","));
		}
		function getNodeId(addMenuId, treeNode) {
			addMenuId.push(treeNode.id);
			var childrenNode = treeNode.children;
			 if (childrenNode != undefined) {//存在子节点
			 	for (i in childrenNode) {
					getNodeId(addMenuId, childrenNode[i])
				}
			 }
		}

</script>
<script>
	$(function() {
		//switch 按钮开关效果
		var toggleHandler = function(toggle) {
			var toggle = toggle;
			var radio = $(toggle).find("input");

			var checkToggleState = function() {
				if (radio.eq(0).is(":checked")) {
					$(toggle).removeClass("switch-off");
				}
				if (radio.eq(1).is(":checked")) {
					$(toggle).addClass("switch-off");
				}
			};

			checkToggleState();

			radio.eq(0).click(function() {
				$(toggle).toggleClass("switch-off");
			});

			radio.eq(1).click(function() {
				$(toggle).toggleClass("switch-off");
			});
		};

		$(document).ready(function() {

			$(".switch").each(function(index, toggle) {
				toggleHandler(toggle);
			});
		});
	});
</script>
<script type="text/javascript">
	function changPage() {
		pageNo = $(".curr").text() == undefined || $(".curr").text() == "" ? 1
				: $(".curr").text();
		param["pageNo"] = pageNo;
		organizeList();
	}
	function toPage() {
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
			click : function(n) {
				this.selectPage(n);
				changPage();
				return false;
			},
			getHref : function(n) {
				return 'javascript:void(0)';
			}
		},true);
	}
</script>



<body style="width:100%;height:100%;overflow:auto">

<div class="u-body">
	<div class="u-title">
		<span>组织机构管理</span>
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
		  <div class="search">
			<input type="hidden" id="commonStatusJson" value='${WCS_COMMON_STATUS_MAP_JSON}' />
			<label class="name n2" for="">机构名称：</label>
			<input type="text" id="orgName" name="orgName" class="u-input-text search-box box-input" >
		</div>
		</div>
		<div class="search" style="margin-left:10px;">
			<label class="name n2" for="">机构编码：</label>
			<input type="text" id="orgCode" name="orgCode" class="u-input-text search-box box-input" >
		</div>
		<div class="button-box-m">
			<button class="button chaxun" onclick="organizeList()" style="border:0">查询</button>
			<c:if test="${sessionScope.funOperate['SYS_ORGANIZE_ADD'] }">
			<button href="javascript:void();" class="button xinzeng"onclick="orgAdd()" style="border:0">新增</button>
			</c:if>
		</div>
	</div>
	<div class="data d2">
		<div class="left-tree" style="height:436px">
			<ul id="organizeTree" class="ztree lt"></ul>
		</div>
		<div class="right-table">
			<table class="table table-bordered">
			    <thead>
				    <tr>
					    <th>机构名称</th>
					    <th>机构编码</th>
					    <th colspan="2">操作</th>
				    </tr>
			    </thead>
		        <tbody id="organizeList"></tbody>
		    </table>
			<!--分页-->
			<div id="kkpager" class="kkpager"></div>
		</div>
	</div>	
</div>		
<div class="index-footer"  style="margin-top:80px">
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
	<!-- 查看 -->
	<div id="Modal-edit" class="modal hide fade" tabindex="-1"role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="Modal-edit-box">
		<div class="modal-header">
			<h3 id="myModalLabel">组织机构信息</h3>
			<a class="close" data-dismiss="modal" aria-hidden="true"
				href="javascript:void();"><i class="fa fa-times"></i> </a>
		</div>
		<div class="modal-body">
			<div class="form-group cl">
				<label class=" fl">机构名称</label> <input readonly disabled=""
					class="input-text fl" type="text" onblur="true" value=""
					name="orgCodeShow" id="orgCodeShow">
			</div>
			<div class="form-group cl">
				<label class=" fl">机构编码：</label> <input readonly disabled=""
					class="input-text fl" type="text" value="" name="orgNameShow"
					id="orgNameShow">
			</div>
			<div class="form-group cl">
				<label class=" fl">上级机构编码：</label> <input readonly disabled=""
					class="input-text fl" type="text" value="" name="parentOrgCodeShow"
					id="parentOrgCodeShow">
			</div>
			<div class="form-group cl">
				<label class=" fl">机构描述：</label>
				<textarea class="textarea" name="orgDescShow" readonly disabled=""
					id="orgDescShow" cols="30" rows="3"></textarea>
			</div>
		</div>
		<div class="button-box">
			<button class="button close" data-dismiss="modal" aria-hidden="true">关闭</button>
		</div>
	</div>

	<!--------------------------MODAL---------------------------->

	<!--删除对话框--->
	<input type="hidden" id="orgCodeHide" value="" />
	<div id="Modal-delete" class="modal w300 hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="Modal-edit-box">
		<div class="modal-header">
			<h3 id="myModalLabel">删除</h3>
			<a class="close" data-dismiss="modal" aria-hidden="true"
				href="javascript:void();"><i class="fa fa-times"></i> </a>
		</div>
		<div class="modal-body">
			<p class="tsxx">确定删除此组织机构？</p>
		</div>
		<div class="button-box">
		    <button class="button queding onclick="del();">确定</button>
			<button class="button quxiao" data-dismiss="modal" aria-hidden="true">取消</button>
		</div>
		</div>
	</div>


</body>

