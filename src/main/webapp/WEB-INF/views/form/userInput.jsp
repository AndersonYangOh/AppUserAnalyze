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
<title>省分信息录入-大数据运营后台管理系统</title>
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
    
    $(function(){
        getTimeList();
    });

function getTimeList(){
    $.ajax({
        url : "timeManage/getTimeList.do",
        type : 'post',
        dataType : 'json',
        data : {},
        success : function (data) {
        	var list=data;
        	for(var i in list){
        		if(list[i].code=="iniTimeStart"){
        			$("#iniTimeStart").val(list[i].value);
            	}
        		if(list[i].code=="iniTimeEnd"){
        			$("#iniTimeEnd").val(list[i].value);
            	}
        		if(list[i].code=="iniAdjustTimeStart"){
        			$("#iniAdjustTimeStart").val(list[i].value);
            	}
        		if(list[i].code=="iniAdjustTimeEnd"){
        			$("#iniAdjustTimeEnd").val(list[i].value);
            	}
        		if(list[i].code=="oprTimeStart"){
        			$("#oprTimeStart").val(list[i].value);
            	}
        		if(list[i].code=="oprTimeEnd"){
        			$("#oprTimeEnd").val(list[i].value);
            	}
        		if(list[i].code=="oprAdjustTimeStart"){
        			$("#oprAdjustTimeStart").val(list[i].value);
            	}
        		if(list[i].code=="oprAdjustTimeEnd"){
        			$("#oprAdjustTimeEnd").val(list[i].value);
            	}
            }
        },
        error : function () {

        }

    });
}
    //保存
    function save(type) {
        var temp=validateMessage();
        if(temp==false){
            return;
        }
        var iniTimeStart=$("#iniTimeStart").val();
        var iniTimeEnd=$("#iniTimeEnd").val();
        var iniAdjustTimeStart=$("#iniAdjustTimeStart").val();
        var iniAdjustTimeEnd=$("#iniAdjustTimeEnd").val();
        var oprTimeStart=$("#oprTimeStart").val();
        var oprTimeEnd=$("#oprTimeEnd").val();
        var oprAdjustTimeStart=$("#oprAdjustTimeStart").val();
        var oprAdjustTimeEnd=$("#oprAdjustTimeEnd").val();
        $.ajax({
            url : "timeManage/saveOrUpdateTime.do",
            type : "post",
            dataType : 'json',
            data : {"iniTimeStart": iniTimeStart,
                    "iniTimeEnd" : iniTimeEnd,
                    "iniAdjustTimeStart" : iniAdjustTimeStart,
                    "iniAdjustTimeEnd" : iniAdjustTimeEnd,
                    "oprTimeStart" : oprTimeStart,
                    "oprTimeEnd" : oprTimeEnd,
                    "oprAdjustTimeStart" : oprAdjustTimeStart,
                    "oprAdjustTimeEnd" : oprAdjustTimeEnd
                },
            success : function (data) {
            	if (data.flag) {
					$.jBox.tip(data.msg,"success");
					getTimeList();
				} else {
		            $.jBox.error(msg.msg, '提示');
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
    	jiaoyanIniTimeStart();
    	jiaoyanInTimeEnd();
    	jiaoyanIniAdjustTimeStart();
    	jiaoyanIniAdjustTimeEnd();
    	jiaoyanOprTimeStart();
    	jiaoyanOprTimeEnd();
    	jiaoyanOprAdjustTimeStart();
    	jiaoyanOprAdjustTimeEnd();
    }
    function jiaoyanIniTimeStart(){ 
		if ($("#iniTimeStart").val()==null||$("#iniTimeStart").val()=="") {
            $.jBox.error("接口人新建时间不能为空", '提示');
			return false;
		}
		/* var r = new RegExp
		("(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)");
		if(!r.test($("#iniTimeStart").val())){
			$.jBox.error("接口人新建开始时间格式错误", '提示');
		} */
		
		return true;
	}
    function jiaoyanInTimeEnd(){ 
		if ($("#iniTimeEnd").val()==null||$("#iniTimeEnd").val()=="") {
            $.jBox.error("接口人新建结束时间不能为空", '提示');
			return false;
		}
		/* var r = new RegExp
		("(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)");
		if(!r.test($("#iniTimeEnd").val())){
			$.jBox.error("接口人新建结束时间格式错误", '提示');
		} */
		
		return true;
	}
    function jiaoyanIniAdjustTimeStart(){ 
		if ($("#iniAdjustTimeStart").val()==null||$("#iniAdjustTimeStart").val()=="") {
            $.jBox.error("接口人调整开始时间不能为空", '提示');
			return false;
		}
		/* var r = new RegExp
		("(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)");
		if(!r.test($("#iniAdjustTimeStart").val())){
			$.jBox.error("接口人调整开始时间格式错误", '提示');
		} */
		
		return true;
	}
    function jiaoyanIniAdjustTimeEnd(){ 
		if ($("#iniAdjustTimeEnd").val()==null||$("#iniAdjustTimeEnd").val()=="") {
            $.jBox.error("接口人调整开始时间不能为空", '提示');
			return false;
		}
		/* var r = new RegExp
		("(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)");
		if(!r.test($("#iniAdjustTimeEnd").val())){
			$.jBox.error("接口人调整开始时间格式错误", '提示');
		} */
		
		return true;
	}
    function jiaoyanOprTimeStart(){ 
		if ($("#oprTimeStart").val()==null||$("#oprTimeStart").val()=="") {
            $.jBox.error("归口人新建开始时间不能为空", '提示');
			return false;
		}
		/* var r = new RegExp
		("(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)");
		if(!r.test($("#oprTimeStart").val())){
			$.jBox.error("归口人新建开始时间格式错误", '提示');
		} */
		
		return true;
	}
    function jiaoyanOprTimeEnd(){ 
		if ($("#oprTimeEnd").val()==null||$("#oprTimeEnd").val()=="") {
            $.jBox.error("归口人新建结束时间不能为空", '提示');
			return false;
		}
		/* var r = new RegExp
		("(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)");
		if(!r.test($("#oprTimeEnd").val())){
			$.jBox.error("归口人新建结束时间格式错误", '提示');
		} */
		
		return true;
	}
    function jiaoyanOprAdjustTimeStart(){ 
		if ($("#oprAdjustTimeStart").val()==null||$("#oprAdjustTimeStart").val()=="") {
            $.jBox.error("归口人调整开始时间不能为空", '提示');
			return false;
		}
		/* var r = new RegExp
		("(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)");
		if(!r.test($("#oprAdjustTimeStart").val())){
			$.jBox.error("归口人调整开始时间格式错误", '提示');
		} */
		
		return true;
	}
    function jiaoyanOprAdjustTimeEnd(){ 
		if ($("#oprAdjustTimeEnd").val()==null||$("#oprAdjustTimeEnd").val()=="") {
            $.jBox.error("归口人调整结束时间不能为空", '提示');
			return false;
		}
		/* var r = new RegExp
		("(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)");
		if(!r.test($("#oprAdjustTimeEnd").val())){
			$.jBox.error("归口人调整结束时间格式错误", '提示');
		} */
		
		return true;
	}

</script>
</head>
<body>
<!-------------------------CONT---------------------------->
<form id="userForm" method="post">
    <input type="hidden" name="oldOperId" id="oldOperId" value="${sysOperator.operId}"/>
<div class="Edit-cont box-cont">
    <div class="panel panel-default">
        <div class="panel-header">
            <h4>时间管理</h4>
        </div>
        <div class="panel-body">
            <div class="panel panel-primary">
                <div class="panel-header">
                    <%-- <c:if test="${flag=='1'}">
                        <h4>新增用户</h4>
                    </c:if>
                    <c:if test="${flag=='0'}">
                        <h4>修改用户</h4>
                    </c:if> --%>
                </div>
                <div class="panel-body">
                    <div class="user-form">
                        <form>
                            <div class="form-group">
                                <label class="form-label" for="" style="width:50%;">接口人新建开始时间：</label>
			                    <input type="text" class="input-text" style="width:10%;" id="iniTimeStart"  name="iniTimeStart" onblur="jiaoyanIniTimeStart();"/>
			                    <span style="color: #ee3170;font-size: 14px;">
									*请填写dd日期
								</span>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="" style="width:50%;">接口人新建结束时间：</label>
			                    <input type="text" class="input-text" style="width:10%;" id="iniTimeEnd"  name="iniTimeEnd" onblur="jiaoyanInTimeEnd();"/>
			                    <span style="color: #ee3170;font-size: 14px;">
									*请填写dd日期
								</span>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="" style="width:50%;">接口人调整开始时间：</label>
			                    <input type="text" class="input-text" style="width:10%;" id="iniAdjustTimeStart"  name="iniAdjustTimeStart"  onblur="jiaoyanIniAdjustTimeStart();"/>
			                    <span style="color: #ee3170;font-size: 14px;">
									*请填写dd日期
								</span>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="" style="width:50%;">接口人调整结束时间：</label>
										<input type="text" class="input-text" style="width:10%;" id="iniAdjustTimeEnd"
											name="iniAdjustTimeEnd"
											onblur="jiaoyanIniAdjustTimeEnd();" />
											<span style="color: #ee3170;font-size: 14px;">
												*请填写dd日期
											</span>
									</div>
                            <div class="form-group">
                                <label class="form-label" for="" style="width:50%;">归口人新建开始时间：</label>
			                    <input type="text" class="input-text" id="oprTimeStart"  style="width:10%;" name="oprTimeStart" onblur="jiaoyanOprTimeStart();"/>
			                    <span style="color: #ee3170;font-size: 14px;">
									*请填写dd日期
								</span>
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label" for="" style="width:50%;">归口人新建结束时间：</label>
			                    <input type="text" class="input-text" style="width:10%;" id="oprTimeEnd"  name="oprTimeEnd" onblur="jiaoyanOprTimeEnd();"/>
			                    <span style="color: #ee3170;font-size: 14px;">
									*请填写dd日期
								</span>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="" style="width:50%;">归口人调整开始时间：</label>
			                    <input type="text" class="input-text" style="width:10%;" id="oprAdjustTimeStart"  name="oprAdjustTimeStart"  onblur="jiaoyanOprAdjustTimeStart();"/>
			                    <span style="color: #ee3170;font-size: 14px;">
									*请填写dd日期
								</span>
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label" for="" style="width:50%;">归口人调整结束时间：</label>
			                    <input type="text" class="input-text" style="width:10%;" id="oprAdjustTimeEnd"  name="oprAdjustTimeEnd"  onblur="jiaoyanOprAdjustTimeEnd();"/>
			                    <span style="color: #ee3170;font-size: 14px;">
									*请填写dd日期
								</span>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
                <div class="btn-wrap pl-20 mt-10" style="text-align:center"><a class="btn btn-primary ml-10" onclick="save()">保存</a></div>
            </div>
        </div>
    </div>

</form>

</body>
</html>