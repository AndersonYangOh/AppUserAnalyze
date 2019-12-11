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
<link rel="stylesheet" href="js/zTree_v3/css/zTreeStyle/zTreeStyle.css">
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
        getUserList();
    });
    //用户列表
    function getUserList(type) {
        if (type=="1"){
            pageNo = 1;
        }
        var operAccount=$.trim($("#operAccount").val());
        var operName=$.trim($("#operName").val());
        var status=$.trim($("#status").val());
        $.ajax({
            url : "sysUser/getUserList.do",
            type : 'post',
            data :{"operAccount" : operAccount,
                    "operName" : operName,
                    "status" : status,
                    "pageNo" : pageNo},
            dataType : 'json',
            success :function (data) {
                var  html ="";
                var list=data.objects;
                for(var i in list){
                    html += "<tr>";
                    html += "<td>"+list[i].operAccount+"</td>";
                    html += "<td>"+list[i].orgName+"</td>";
                    html += "<td>"+list[i].operName+"</td>";
                    if(list[i].status=="1"){
                        html += "<td id=\"option"+i+"\"><b class='c-primary'>有效</b></td>";
                    }else{
                        html += "<td id=\"option"+i+"\">无效</td>";
                    }
                    var time=FormatDate(list[i].lastLoginTime);
                    var operId=list[i].operId;
                    html += "<td>"+time+"</td>";
                    html += '<td>'+
	                  	'<c:if test="${sessionScope.funOperate[\'USER_LIST_CHECK\'] }">'+
                    		'<a class="btn btn-op" data-toggle="modal"" href="#userDetail" title="查看"onclick="getOperateDetail(\''+list[i].operId+'\',\'0\')"><i class="fa fa-search"></i></a>'+
	  	                '</c:if>'+
                    	'<c:if test="${sessionScope.funOperate[\'USER_LIST_UPDATE\'] }">'+
                            '<a class="btn btn-op ml-10" href="sysUser/toUserAdd.do?operType=0&operId='+operId+'" title="修改"><i class="fa fa-edit"></i></a>'+
                        '</c:if>'+
                            '</td>';
                    if(list[i].status=="1"){
                        html +=' <td>'+
                    	'<c:if test="${sessionScope.funOperate[\'USER_LIST_INVALID\'] }">'+
                        '<div class="switch switch-off">'+
                        '<label class="switch-radio" onClick="changStatus('+i+',\''+list[i].operId+'\')" for="oneOption'+i+'" >启用&nbsp;</label>' +
                        '<input id="oneOption'+i+'" type="radio" name="option'+i+'"   >&nbsp;' +
                        '<label class="switch-radio" onClick="changStatus('+i+',\''+list[i].operId+'\')" for="twoOption'+i+'">禁用&nbsp;</label>'+
                        '<input id="twoOption'+i+'" type="radio" name="option'+i+'" checked="checked">'+
                        '</div>'+
                        '</c:if>'+
                        '</td>';
                    }else {
                        html +=' <td>'+
                    	'<c:if test="${sessionScope.funOperate[\'USER_LIST_EFFECT\'] }">'+
                        '<div class="switch">'+
                        '<label class="switch-radio" onClick="changStatus('+i+',\''+list[i].operId+'\')" for="oneOption'+i+'">启用&nbsp;</label>' +
                        '<input id="oneOption'+i+'" type="radio" name="option'+i+'" checked="checked">&nbsp;' +
                        '<label class="switch-radio" onClick="changStatus('+i+',\''+list[i].operId+'\')" for="twoOption'+i+'">禁用&nbsp;</label>'+
                        '<input id="twoOption'+i+'" type="radio" name="option'+i+'"  >'+
                        '</div>'+
                        '</c:if>'+
                        '</td>';
                    }
                    html += "</tr>";
                }
                $("#userList").html(html);
                totalPage = data.totalPage;
                totalRecords = data.totalNumber;
                pageNo = data.currentPage;
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
        getUserList();
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
    
    
    //查看
    function getOperateDetail(operId,type) {
        $.ajax({
            url : "sysUser/getOperateDetail.do",
            type : "post",
            data : {"operId" : operId},
            dataType : 'json',
            success :function (sysOperate) {
              var list=sysOperate.sysOperRole;
              var  html ="";
                for(var i in list){
                	html+="<span  class=\"btn\" >"+list[i].roleName+"</span>";
                }
                $("#operAccountShow").val(sysOperate.operAccount);
                $("#operNameShow").val(sysOperate.operName);
                $("#operCardNoShow").val(sysOperate.operCardNo);
                $("#operMobileShow").val(sysOperate.operMobile);
                $("#operMobileShow").val(sysOperate.operMobile);
                $("#operEmailShow").val(sysOperate.operEmail);
                $("#operAddrShow").val(sysOperate.operAddr);
                $("#positionShow").val(sysOperate.position);
                $("#OrgCodeShow").val(sysOperate.orgName);
                $("#roleNameShow").html(html);
            },
            error : function () {
                $.jBox.error("查看失败", '提示');
                return false;
            }
        });
    }

</script>
<script>
    $(function(){
        //switch 按钮开关效果
		$(document).on("click",".switch label",function(){
        	$(this).parent(".switch").toggleClass("switch-off");
        });
    });
    function changStatus(i,operId){
    	var operType = "";
    	if ($("#option"+i).text()=="有效") {
			$("#option"+i).text("无效");
			operType = 0;
		}else{
			$("#option"+i).html("<b class=\'c-primary\'>有效</b>");
			operType = 1;
		}
		$.ajax({
			url : "sysUser/changStatus.do",
			type : "post",
			data : {"operId" : operId, "operType":operType},
			dataType : 'json',
			success :function (sysOperateVo) {
				
			}
		});
    }
</script>
</head>
<body style="width:100%;height:100%;overflow-y:auto">

<div class="u-body">
	<div class="u-title">
		<span>用户管理</span>
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
		  <div class="earch">
              <label class="name n2" for="">用户姓名：</label>
              <input type="text" class="u-input-text search-box box-input" name="operName" id="operName" >
          </div>
			<div class="search" style="margin-left:10px">
				<label class="name n2" for="">机构编码：</label>
				<input type="text" class="u-input-text search-box box-input " id="orgCode" name="orgCode">
		   </div>
		<div class="search" style="margin-left:10px">
			<label class="name" for="">状态：</label>
			<select class="u-input-text search-box" name="status" id="status">
				<option value="">全部</option>
				<option value="1">有效</option>
				<option value="0">无效</option>
			</select>
        </div>
		<div class="button-box-m">
			<a  class="button chaxun menu" onclick="getUserList('1')">查询</a>
			<c:if test="${sessionScope.funOperate['USER_LIST_ADD'] }">
			<a href="sysUser/toUserAdd.do?operType=1" class="button xinzeng menu">新增</a>
			</c:if>
		</div>
	</div>
	    <div class="data d2">
		    <table class="table table-bordered">
                <thead class="thead">
                <tr>
                    <th style="width:14%">登录账号</th>
                    <th style="width:14%">所属机构</th>
                    <th style="width:14%">用户姓名</th>
                    <th style="width:14%">状态</th>
                    <th style="width:14%">最后登录时间</th>
                    <th style="width:14%">操作</th>
                    <th style="width:16%">状态</th>
                </tr>
                </thead>
                <tbody id="userList" class="table"></tbody>
            </table>
            <script>
                $(function(){
                    //switch 按钮开关效果
                    var toggleHandler = function(toggle) {
                        var toggle = toggle;
                        var radio = $(toggle).find("input");

                        var checkToggleState = function() {
                            if (radio.eq(0).is(":checked")) {
                                $(toggle).removeClass("switch-off");
                            }
                            if (radio.eq(1).is(":checked")){
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
		<!--分页-->
		<div id="kkpager" class="kkpager"></div>
	</div>
</div>		
<div class="index-footer"  style="margin-top:60px">
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
<div id="userDetail" class="modal hide fade" tabindex="-1"role="dialog" aria-labelledby="myModalLabel" >
<div class="Modal-edit-box" style="margin-top:-300px">
           <div class="modal-header">
			<h3 id="myModalLabel">查看用户信息</h3>
			<a class="close" data-dismiss="modal" aria-hidden="true"
				href="javascript:void();"><i class="fa fa-times"></i>
			</a>
		</div>
		<div class="modal-body">
			<div class="form-group cl">
				<label class=" fl">登录账号:</label> <input readonly class="input-text fl" disabled=""
					type="text" onblur="true" value="" name="operAccountShow"
					id="operAccountShow">
			</div>
			<div class="form-group cl">
				<label class=" fl">姓名：</label> <input readonly class="input-text fl" disabled=""
					type="text" value="" name="operNameShow" id="operNameShow">
			</div>
			<div class="form-group cl">
				<label class=" fl">身份证号码：</label> <input readonly class="input-text fl" disabled=""
					type="text" value="" name="operCardNoShow"
					id="operCardNoShow">
			</div>
			<div class="form-group cl">
				<label class=" fl">联系号码：</label>
				<input readonly class="input-text fl" disabled=""
					type="text" value="" name="operMobileShow"
					id="operMobileShow">
			</div>
			<div class="form-group cl">
				<label class=" fl">EMAIL：</label> <input readonly class="input-text fl" disabled=""
					type="text" value="" name="operEmailShow"
					id="operEmailShow">
			</div>
			<div class="form-group cl">
				<label class=" fl">联系地址：</label> <input readonly class="input-text fl" disabled=""
					type="text" value="" name="operAddrShow"
					id="operAddrShow">
			</div>
			<div class="form-group cl">
				<label class=" fl">职位：</label> <input readonly class="input-text fl" disabled=""
					type="text" value="" name="positionShow"
					id="positionShow">
			</div>
			<div class="form-group cl">
				<label class=" fl">所属机构：</label> <input readonly class="input-text fl" disabled=""
					type="text" value="" name="OrgCodeShow"
					id="OrgCodeShow">
			</div>
			<div class="form-group cl">
				<label class=" fl">关联角色：</label>
						  <div class="role-wrap fl"name="roleNameShow" 	id="roleNameShow"> </div>
                               
			</div>
			 
		</div>
		<div class="button-box">
			<button class="button close" data-dismiss="modal" aria-hidden="true">关闭</button>
			<!-- <button id="btn-sure" class="btn btn-primary">确定</button> -->
		</div>
	</div> 
	</div> 

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