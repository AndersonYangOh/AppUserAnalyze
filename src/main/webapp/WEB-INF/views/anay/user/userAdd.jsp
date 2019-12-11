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
    <link rel="stylesheet" href="js/zTree_v3/css/zTreeStyle/zTreeStyle.css">
    <link rel="stylesheet" href="js/jbox/jbox.css">
    <script type="text/javascript" src="js/jquery-2.1.4.js"></script>
    <script type="text/javascript" src="js/validate/jquery.validate.min.js"></script>
    <script type="text/javascript" src="js/validate/additional-methods.min.js"></script>
    <script type="text/javascript" src="js/validate/messages_zh.js"></script>
    <script type="text/javascript" src="js/kkpager/kkpager.min.js"></script>
    <script type="text/javascript" src="js/modal/bootstrap-modal.js"></script>
    <script type="text/javascript" src="js/modal/bootstrap-modalmanager.js"></script>
    <script type="text/javascript" src="js/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="resources/js/organize/managerOrganize.js"></script>
    <script type="text/javascript" src="resources/easyui13/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="resources/easyui13/locale/easyui-lang-en.js"></script>
    <script type="text/javascript" src="resources/artDialog4.1.7/jquery.artDialog.js?skin=chrome"></script>
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
    var roleCodes=[];
    var oldRoleCodes="${orgCode}";
    var flag="${flag}";
    $(function(){
        getRoleList();
    });
    function parentOrgCodeShow(){
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
    function zTreeOnClickNum(event, treeId, treeNode) {
        $("#organizeTable1").datagrid('load', {
            orgCode : treeNode.pkId == "-1" ? "" : treeNode.pkId
        });
        $('#orgCode1').val(treeNode.name);
        $("#orgId").val(treeNode.id);
        $("#Modal-organization").modal("hide")

    }

function getRoleList(type) {
    if(type=="1"){
        pageNo=1;
    }
    var roleName=$("#roleName").val().trim();
    var roleCode=$("#roleCode").val().trim();
    $.ajax({
        url : "sysUser/getRoleList.do",
        type : 'post',
        dataType : 'json',
        data : {"roleName" : roleName,
                "roleCode" : roleCode,
                 "pageNo" : pageNo},
        success : function (data) {
            var list=data.objects;
            if(list.length>0){
                var html="";
                $("#roleList").html("");
                for (var i in list){
                    var temp=null==list[i].roleDesc?"":list[i].roleDesc;
                    html += "<tr>";
                    html += "<td><input type='checkbox' onclick='saveRole(this)'></td>";
                    html += "<td>"+list[i].roleName+"</td>";
                    html += "<td>"+list[i].roleCode+"</td>";
                    html += "<td>"+temp+"</td>";
                    html += "</tr>";
                }
                $("#roleList").html(html);
                totalPage = data.totalPage;
                totalRecords = data.totalNumber;
                pageNo = data.currentPage;
                toPage();
            }
        },
        error : function () {

        }

    });
}
function changPage(){
    pageNo = $(".curr").text()==undefined||$(".curr").text()==""?1:$(".curr").text();
    getRoleList();
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
    });
}   var roleNames=[];
    function saveRole(obj) {
        var str=obj.parentNode.parentNode;
        if(obj.checked){
            roleCodes.push(str.cells[2].innerText);
            roleNames.push(str.cells[1].innerText);
        }else{
            for(var i in roleCodes){
                if(roleCodes[i]==str.cells[2].innerText){
                    roleCodes.splice(i,1);
                }
            }
            for(var j in roleNames){
                if(roleNames[j]==str.cells[3].innerText){
                    roleNames.splice(j,1);
                }
            }
        }
    }
    //选择角色
    function selectRole() {
        unique(roleCodes);
        unique(roleNames);
        $("#Modal-role").modal("hide");
        for(var i in roleNames){
            $("#roles").append("<span class='btn btn-primary-outline '  data-value="+roleCodes[i]+">"+roleNames[i]+"<i class='fa fa-times'></i></span>");
        }
    }

    function unique(arr) {
        var result = [], hash = {};
        for (var i = 0, elem; (elem = arr[i]) != null; i++) {
            if (!hash[elem]) {
                result.push(elem);
                hash[elem] = true;
            }
        }
        return result;
    }
    //保存用户
    function saveUser(type) {
        var temp=validateMessage();
        if(temp==false){
            return;
        }
        var temp=[];
        $('.btn-wrap .btn').each(function (index) {
            temp.push($(this).attr('data-value'));
        })
        var operAccount=$("#operAccount").val();//账号
        var operPwd=$("#operPwd").val();//密码
        var operName=$("#operName1").val();//姓名
        var idCard=$("#idCard").val();//身份证
        var email=$("#email").val();//邮箱
        var mobile=$("#mobile").val();//联系号码
        var position=$("#position").val();//职位
        var orgCode=$("#orgId").val();//组织机构
        var operAddr=$("#operAddr").val();//地址
        var oldOperId=$("#oldOperId").val();
        $.ajax({
            url : "sysUser/saveOrUpdateUser.do",
            type : "post",
            dataType : 'json',
            data : {"operAccount": operAccount,
                    "operPwd" : operPwd,
                    "operName" : operName,
                    "idCard" : idCard,
                    "email" : email,
                    "mobile" : mobile,
                    "position" : position,
                    "orgCode" : orgCode,
                    "operAddr" : operAddr,
                    "roleCode" : temp.join(","),
                    "operType" : type,
                    "oldOperId" :oldOperId
                },
            success : function (data) {
                if(data.success==true){
                    $.jBox.tip(data.message,'success');
                    setTimeout("window.location.href='sysUser/toUserList.do'",3000);
                }else {
                    $.jBox.error(data.message, '提示');
                    return false;
                }

            },
            error : function () {
                $.jBox.error(data.message, '提示');
                return false;
            }
        });


    }
    
    function validateMessage() {
        var operAccount=$("#operAccount").val().trim();//账号
        if (null==operAccount || ""== operAccount){
            $("#accountTip").show();
            return false;
        }else{
            $("#accountTip").hide();
        }
        var operPwd=$("#operPwd").val().trim();//密码
        var  uspassword = /(?!^\d+$)(?!^[a-zA-Z]+$)[0-9a-zA-Z]{8,18}/;
        if(flag=="1" || (operPwd!=null && ""!=operPwd)){
            if(null==operPwd || ""==operPwd){
                $("#pwdTip").show();
                return false;
            }else {
                $("#pwdTip").hide();
                if(!uspassword.test(operPwd)){
                    $("#pwdTip2").show();
                    return false;
                }else{
                    $("#pwdTip2").hide();
                }
            }
        }

        var operName=$("#operName1").val().trim();//姓名
        if(null==operName ||"" ==operName){
            $("#nameTip").show();
            return false;
        }else {
            $("#nameTip").hide();
        }

        var mobile=$("#mobile").val().trim();//联系号码
        if(null==mobile || ""==mobile){
            $("#mobileTip").show();
            return false;
        }else {
            $("#mobileTip").hide();
            var phoneRegNoArea = /^[1][358][0-9]{9}$/;
            if (!phoneRegNoArea.test(mobile)) {
                $("#mobileTip2").show();
                return false;
            }else{
                $("#mobileTip2").hide();
            }
        }
        var email=$("#email").val().trim();//邮箱
        if(null==email || ""==email){
            $("#emailTip").show();
            return false;
        }else {
            $("#emailTip").hide();
            var szReg=/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
            if(!szReg.test(email)){
                $("#emailTip2").show();
                return false;
            }else{
                $("#emailTip2").hide();
            }
        }

        var orgId=$("#orgId").val().trim();//组织机构
        if(null==orgId || ""==orgId){
            $("#orgCodenTip").show();
            return false;
        }else {
            $("#orgCodenTip").hide();
        }
    }
</script>
</head>
<body style="width:100%;height:100%;overflow-y:auto">

<div class="u-body u-body-phone">
	<div class="u-title">
		<c:if test="${flag=='1'}"><span>新增用户</span></c:if>
        <c:if test="${flag=='0'}"><span>修改用户</span></c:if>
	</div>

	<div class="data d2">
	    <form>
	        <div class="biaodan">
	            <label class="name n1" for="">登录账号：</label>
				<c:if test="${flag=='1'}">
	      	 		<input type="text" class="b-input-text" id="operAccount"  name="operAccount" onkeyup="value=value.replace(/[^0-9a-zA-Z]/g,'')"onblur="validateMessage()"/>
	   			</c:if>
	   			<c:if test="${flag=='0'}">
	        		<input type="text" readonly class="b-input-text" id="operAccount"  name="operAccount" onkeyup="value=value.replace(/[^0-9a-zA-Z]/g,'')"onblur="validateMessage()" value="${sysOperator.operAccount}"/>
	   			</c:if>
	            <input type="hidden" name="oldAccount" id="oldAccount" readonly value="${sysOperator.operAccount}"/>
	            <span id="accountTip" style="color: red;display: none">登录账号不能为空</span>
	        </div>
	        <div class="biaodan">
	            <label class="name n1" for="">登录密码：</label>
	            <input type="password" class="b-input-text" id="operPwd" name="operPwd" onblur="validateMessage()">
	            <span id="pwdTip" style="color: red;display: none">登录密码不能为空</span>
	            <span id="pwdTip2" style="color: red;display: none">密码必须是数字和字母的组合，6~16位！</span>
	        </div>
	        <div class="biaodan">
	            <label class="name n1" for="">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</label>
	            <input type="text" class="b-input-text" name="operName1" id="operName1" onblur="validateMessage()" value="${sysOperator.operName}">
	            <span id="nameTip" style="color: red;display: none">姓名不能为空</span>
	        </div>
	        
	        <div class="biaodan">
	            <label class="name n1" for="">联系号码：</label>
	            <input type="text" class="b-input-text" name="mobile" id="mobile" onblur="validateMessage()" value="${sysOperator.operMobile}">
	            <span id="mobileTip" style="color: red;display: none">联系号码不能为空</span>
	            <span id="mobileTip2" style="color: red;display: none">请输入正确的联系号码</span>
	        </div>
	        <div class="biaodan">
	            <label class="name n1" for="">EMAIL：</label>
	            <div class="box">
	            <input type="text" class="b-input-text" name="email" id="email" onblur="validateMessage()" value="${sysOperator.operEmail}">
	            <span id="emailTip" style="color: red;display: none">EMAIL不能为空</span>
	            <span id="emailTip2" style="color: red;display: none">请输入正确的EMAIL</span>
	        </div>
	        <div class="biaodan">
	            <label class="name n1" for="">所属组织机构：</label>
	            <input type="text"   class="b-input-text" name="orgCode1" id="orgCode1"  readonly onblur="validateMessage()" value="${sysOrganize.orgName}"> 
	            <input type="hidden"  class="b-input-text" name="orgId" id="orgId" value="${sysOrganize.orgCode}"/>
	            <span id="orgCodenTip" style="color: red;display: none">所属组织机构不能为空</span>
	            <a href="#Modal-organization" data-toggle="modal"  class="btn btn-third ml-5" onclick="parentOrgCodeShow()" style="margin-left:10px;">选择组织机构</a>
	        </div>
	        <div class="biaodan" >
	            <label class="name n1 n2" for="">关联角色：</label>
	            <div  class="btn-wrap role-wrap b-input-text b2" id="roles" >
		            <c:forEach items="${list}" varStatus="vtStatus" var="vt">
		                <span class="btn btn-primary-outline "  data-value="${vt.roleCode}">${vt.roleName}<i class="fa fa-times"></i></span>
		            </c:forEach>
	            </div>
	            <a href="#Modal-role" data-toggle="modal"  class="btn btn-third ml-5" style="margin-left:10px;">选择角色</a>
	        </div>
	        <script>
	            //删除关联角色功能
	            $(document).on('click', '.btn-wrap .fa-times',function(){
	                $(this).parent(".btn").remove();
	            });
	        </script>
	        
	        <div class="button-box-v">
	        	<input type="hidden" name="oldOperId" id="oldOperId" value="${sysOperator.operId}"/>
				<c:if test="${flag=='1'}">
				<a class="button baocun baocun-3" onclick="saveUser('1')">保存</a>
				<a class="button quxiao quxiao-3" onclick="javascript:history.go(-1);">取消</a>
				</c:if>
				<c:if test="${flag=='0'}">
				<a class="button baocun baocun-3" onclick="saveUser('0')">保存</a>
				<a class="button quxiao quxiao-3" onclick="javascript:history.go(-1);" >取消</a>
				</c:if>
			</div>
		</form>   
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

<!--选择组织机构对话框--->
<div id="Modal-organization" class="modal w300 hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="Modal-edit-box-2">
	    <div class="modal-header">
	        <h3 id="myModalLabel">选择组织机构</h3><a class="close" data-dismiss="modal" aria-hidden="true" href="javascript:void();"><i class="fa fa-times"></i></a>
	    </div>
	    <div class="modal-body">
	        <!--树状菜单-->
	        <ul id="organizeTree" class="ztree"></ul>
	    </div>
	</div>
</div>

<!--选择角色对话框--->
<div id="Modal-role" class="modal full  hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="Modal-edit-box-2">
	    <div class="modal-header">
	        <h3 id="myModalLabel">选择角色</h3><a class="close" data-dismiss="modal" aria-hidden="true" href="javascript:void();"><i class="fa fa-times"></i></a>
	    </div>
	    
	    
	    <div class="u-body" style="margin:0;padding:0;border:0;top:25px;bottom:0">
			<div class="u-search"style="height:0px;padding:0;overflow:hidden">
				<div class="z-search m2">
					<div class="search">
		                 <label class="name" for="">角色名称：</label>
		                 <div class="box" style="background:#fff;height:26px; border:1px solid #e6e6e6;">
		                    <input type="text" class="u-input-text" id="roleName" name="roleName">
		                  </div>
		            </div>
				</div>
				<div class="z-search m2">
					<label class="name" for="">角色编码：</label>
					<div class="box" style="background:#fff;height:26px; border:1px solid #e6e6e6;">
					    <input type="text" class="u-input-text" name="roleCode" id="roleCode">
					</div>
				</div>
				<div class="button-box-m" style="margin:0;padding:0">
		            <a  class="button chaxun" onclick="getRoleList('0')">查询</a>
		        </div>
			</div>
			<div class="u-data-menu menu2">
				<table class="table table-bordered bordered2" style="margin-top:20px">
		            <thead>
		            <tr>
		                <th>选择</th>
		                <th>角色名称</th>
		                <th>角色编码</th>
		                <th>描述</th>
		            </tr>
		            </thead>
		            <tbody id="roleList">
		            </tbody>
		        </table>
				<!--分页-->
				<div id="kkpager" class="kkpager" style="background:#fff;"></div>
				<style>
				.pageBtnWrap{margin-right:50px}
				.m2{height:60px}
				#kkpager span.disabled{background:#fff;border:1px solid #e6e6e6}
				#kkpager a{background:#fff;border:1px solid #e6e6e6}
				</style>
				<div class="button-box" style="position:relative;bottom:0;margin-top:20px">
					<button class="button baocun" onclick="selectRole()">确定</button>
			        <button class="button quxiao" data-dismiss="modal" aria-hidden="true">关闭</button> 
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>