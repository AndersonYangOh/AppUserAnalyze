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
    <link rel="stylesheet" href="css/core.css">
    <link rel="stylesheet" href="js/jbox/jbox.css">
    <link rel="stylesheet" href="css/indexmenu_style.css">
    <link rel="stylesheet" href="css/index.css">
    
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
<script type="text/javascript" src="js/echarts.common.min.js"></script>
<%-- main.js用于获取当前登录用户可操作功能数据 --%>
<script type="text/javascript" src="resources/js/system/main.js"></script>
<script type="text/javascript" src="resources/js/menu.js"></script>
</head>
<body style="margin:0;padding:0;overflow:auto;">

<div class="index">

	<p class="tishi"><strong style="color:#d6aa63;">
		温馨提示：</strong> *由于兼容性问题，本站未做低版本IE兼容性处理，请使用IE9+、chrome、safari、firefox或opera等现代浏览器。
		<span id="show_time0" class="time"></span>
		<script>
		 setInterval("show_time0.innerHTML=new Date().toLocaleString()+' 星期'+'日一二三四五六'.charAt(new Date().getDay());",1000);  
		</script>
	</p>
	<ul>
		<li class="box b1 box-shadow">
			<div class="title">重点产品<p id="time1"></p></div>
			<span class="line"></span>
			<div class="data">
		   		<a class="link l1" href="/stockmanagement-bi/busiAnay/toPage.do?pageName=accountSum1&flag=1">
		       		<h6 class="bt">存量不限量</h6>
		       		<div class="list">
			       		<p class="p1">当日</p>
			       		<p class="p2" id="changyue1Day"></p>
		       		</div>
		       		<div class="list t1">
			       		<p class="p1">当月</p>
			       		<p class="p2" id="changyue1Month"></p>
		       		</div>
		       		<div class="chart s1">
			            <div class="chart-box" id="changyue1Chart"></div>
			        </div> 
		   		</a>
		   		<a class="link l1 l1-2" href="/stockmanagement-bi/busiAnay/toPage.do?pageName=accountSum2&flag=2">
		     		<h6 class="bt">承诺低消</h6>
		       		<div class="list">
			       		<p class="p1">当日</p>
			       		<p class="p2" id="changyue2Day"></p>
		       		</div>
		       		<div class="list t1">
			       		<p class="p1">当月</p>
			       		<p class="p2" id="changyue2Month"></p>
		       		</div>
		       		<div class="chart s2">
		          		<div class="chart-box" id="changyue2Chart"></div>
		       		</div> 
		   		</a>
			</div>
		</li>
	 		<li class="box b2 box-shadow" >
	 		 <div class="title">移网新发展用户<p id="time2"></p></div>
	 			<span class="line"></span>
	 			<div class="data">
	    			<a class="link l2"  href="/stockmanagement-bi/busiAnay/toPage.do?pageName=accountSum4&flag=4">
	        			<h6 class="bt">真实用户</h6>
	        			<div class="list t2">
		        			<p class="p3" id="userReal"></p>
	        			</div>
	        			<div class="chart s3" id=""></div>
	    			</a>
	    			<a class="link l2 l2-2"  href="/stockmanagement-bi/busiAnay/toPage.do?pageName=accountSum4&flag=4">
	      				<h6 class="bt">异网用户</h6>
	        			<div class="list t2">
		        			<p class="p3" id="userReturn"></p>
	        			</div>
	        			<div class="chart s4" id=""></div>
	    			</a>
	    			<a class="link l2 l2-3"  href="/stockmanagement-bi/busiAnay/toPage.do?pageName=accountSum4&flag=4">
	      				<h6 class="bt">重入网用户</h6>
	        			<div class="list t2">
		        			<p class="p3" id="userOther"></p>
	        			</div>
	        			<div class="chart s5" id=""></div>
	    			</a>
	 			</div>
	 		</li>
	 		<li class="box b3 box-shadow">
	 			<div class="title">固网发展情况<p id="time3"></p></div>
	 			<span class="line"></span>
	 			<div class="data">
	    			<a class="link l3" href="/stockmanagement-bi/fixedNet/toPage.do?pageName=fixedNet">
	        			<h6 class="bt">总用户数</h6>
	        			<div class="list t2">
	        				<p class="p3" id="customerNum1"></p>
	        			</div>
					</a>
					<a class="link l3 l3-2" href="/stockmanagement-bi/busiAnay/toPage.do?pageName=billFix">
	 					<h6 class="bt">总缴费</h6>
	    				<div class="list t2">
	    					<p class="p3" id="topUpNum1"></p>
	    				</div>
	  				</a>
			</div>
		</li>
		<li class="box b4 box-shadow">
			<div class="title">自然人<p id="time4"></p></div>
			<span class="line"></span>
			<div class="data l9">
				<a class="link l4" href="/stockmanagement-bi/naturalperson/toPage.do?pageName=AllProvince">
			    	<h6 class="bt">总用户数</h6>
			       	<div class="list t2">
			       		<p class="p4" id ="allnature" ></p>
			       	</div>
			   	</a>
			   	<a class="link l4" href="/stockmanagement-bi/naturalperson/toPage.do?pageName=AllProvince">
			     	<h6 class="bt">单移</h6>
			       	<div class="list t2">
			       		<p class="p4" id ="mobile"></p>
			       	</div>
			   	</a>
			   	<a class="link l4 l4-3" href="/stockmanagement-bi/naturalperson/toPage.do?pageName=AllProvince" >
			       	<h6 class="bt">单固</h6>
			       	<div class="list t2">
			       		<p class="p4" id ="broadband"></p>
			       	</div>
			   	</a>
			   	<a class="link l4 l4-4" href="/stockmanagement-bi/naturalperson/toPage.do?pageName=AllProvince">
			     	<h6 class="bt">移固融合</h6>
			       	<div class="list t2">
			       		<p class="p4" id ="mixed"></p>
			       	</div>
			   	</a>
			</div>
		</li>
		<li class="box b5 box-shadow">
			<div class="title">自动化运营<p id="time5"></p></div>
			<span class="line"></span>
			<div class="data">
		   		<a class="link l5" href="/stockmanagement-bi/report/toPage.do?pageName=total">
		       		<h6 class="bt">总订购量</h6>
		       		<div class="list t2">
			       		<p class="p1">本年度</p>
			       		<p class="p2" id="totalOrder"></p>
		       		</div>
		 		</a>
		 		<a class="link l5 l5-2" href="/stockmanagement-bi/report/toPage.do?pageName=total">
		   			<h6 class="bt">流量包总收入</h6>
		     		<div class="list t2">
			     		<p class="p1">本年度</p>
			     		<p class="p2" id="totalIncome"></p>
		     		</div>
		    	</a>
		 	</div>
		</li>
		<li class="box b6 box-shadow">
			<div class="title">策略中心<p id="time6"></p></div>
			<span class="line"></span>
			<div class="data">
		   		<a class="link l1" href="/stockmanagement-bi/policy/toPage.do">
		       		<h6 class="bt">总访问量</h6>
		       		<div class="list">
			       		<p class="p1">当日</p>
			       		<p class="p2" id="celue1Day"></p>
		       		</div>
		       		<div class="list t1">
			       		<p class="p1">当月</p>
			       		<p class="p2" id="celue1Month"></p>
		       		</div>
		   		</a>
		   		<a class="link l1 l1-2" >
		     		<h6 class="bt">有效访问量</h6>
		       		<div class="list">
			       		<p class="p1">当日</p>
			       		<p class="p2" id="celue2Day"></p>
		       		</div>
		       		<div class="list t1">
			       		<p class="p1">当月</p>
			       		<p class="p2" id="celue2Month"></p>
		       		</div> 
		   		</a>
			</div>
		</li>
	</ul>
</div>
<div class="index-footer">
	<p>Copyright &copy;2018&nbsp;ChinaUnicom中国联通&nbsp;版权所有&nbsp;&nbsp;&nbsp;技术支持：中国联通研究院-大数据研究中心&nbsp;&nbsp;&nbsp;</br>
	当前在线人数：<span id="lineCount"></span>&nbsp;人&nbsp;&nbsp;&nbsp;本月总点击数：<span id="monthCount"></span>&nbsp;️次</p>
</div> 
           <!-- <div class="home">
		      <div class="home-box b1">
			     <div class="title">重点产品（畅越）</div>
			     <span class="line"></span>
			     <div class="data">
			        <a class="cunliang c1" href="/stockmanagement-bi/busiAnay/toPage.do?pageName=accountSum1&flag=1">
			            <h6 class="bt-1">存量不限量</h6>
			            <div class="list"><p class="p1 p3">当日</p><p class="p2" id="changyue1Day">37977</p></div>
			            <div class="list t1"><p class="p1 p3">当月</p><p class="p2" id="changyue1Month">37977</p></div>
			            < <div class="chart s1">
			               <div class="chart-box" id="changyue1Chart"></div>
			            </div> 
			        </a>
			        <a class="cunliang c2" href="/stockmanagement-bi/busiAnay/toPage.do?pageName=accountSum2&flag=2">
			          <h6 class="bt-1">承诺低消</h6>
			            <div class="list"><p class="p1 p3">当日</p><p class="p2" id="changyue2Day">37977</p></div>
			            <div class="list t1"><p class="p1 p3">当月</p><p class="p2" id="changyue2Month">37977</p></div>
			            <div class="chart s2">
			               <div class="chart-box" id="changyue2Chart"></div>
			            </div> 
			        </a>
			     </div>
		      </div>
		      <div class="home-box b2">
			     <div class="title">移网发展质量</div>
			     <span class="line"></span>
			     
			     <div class="data">
			        <a class="cunliang c3">
			            <h6 class="bt-1">真实用户</h6>
			            <div class="list"><p class="p1 p3 p5"></p><p class="p2" id="userReal">37977</p></div>
			            <div class="chart s3" id="">3333</div>
			        </a>
			        <a class="cunliang c4">
			          <h6 class="bt-1">异网用户</h6>
			            <div class="list"><p class="p1 p3 p5"></p><p class="p2" id="userReturn">37977</p></div>
			            <div class="chart s4" id="">4444</div>
			        </a>
			        <a class="cunliang c5">
			          <h6 class="bt-1">重入网用户</h6>
			            <div class="list"><p class="p1 p3 p5"></p><p class="p2" id="userOther">37977</p></div>
			            <div class="chart s5" id="">5555</div>
			        </a>
			     </div>
		      </div>
		      <div class="home-box b3">
			     <div class="title">固网发展情况</div>
			     <span class="line"></span>
			     
			     <div class="data">
			        <a class="cunliang c6" href="/stockmanagement-bi/fixedNet/toPage.do?pageName=fixedNet">
			            <h6 class="bt-1">总用户数</h6>
			            <div class="list"><p class="p2 p4" id="customerNum1">37977</p></div>
			            <div class="chart s6">
			               <div class="chart-box" id="customerNum"></div>
			            </div>
			        </a>
			        <a class="cunliang c7" href="/stockmanagement-bi/busiAnay/toPage.do?pageName=billFix">
			          <h6 class="bt-1">总缴费</h6>
			            <div class="list"><p class="p2 p4" id="topUpNum1">37977</p></div>
			            <div class="chart s7">
			                <div class="chart-box" id="topUpNum"></div>
			            </div>
			        </a>
			     </div>
		      </div>
		      <div class="home-box b4">
			     <div class="title">自然人</div>
			     <span class="line"></span>
			     
			     <div class="data c9">
			        <a class="cunliang c8" href="/stockmanagement-bi/naturalperson/toPage.do?pageName=AllProvince">
			            <h6 class="bt-1">总用户数</h6>
			            <div class="list"><p class="p2" id ="allnature" ></p></div>
			            <div class="chart s11">
			               <div class="chart-box" id="naturalChart"></div>
			            </div>
			        </a>
			        <a class="cunliang c9" href="/stockmanagement-bi/naturalperson/toPage.do?pageName=AllProvince">
			          <h6 class="bt-1">单移</h6>
			            <div class="list"><p class="p2" id ="mobile"></p></div>
			        </a>
			        <a class="cunliang c10" href="/stockmanagement-bi/naturalperson/toPage.do?pageName=AllProvince" >
			            <h6 class="bt-1">单固</h6>
			            <div class="list"><p class="p2" id ="broadband"></p></div>
			        </a>
			        <a class="cunliang c11" href="/stockmanagement-bi/naturalperson/toPage.do?pageName=AllProvince">
			          <h6 class="bt-1">移固融合</h6>
			            <div class="list"><p class="p2" id ="mixed"></p></div>
			        </a>
			     </div>
		      </div>
		      <div class="home-box b5">
			     <div class="title">自动化运营</div>
			     <span class="line"></span>
			     
			     <div class="data">
			        <a class="cunliang c12" href="/stockmanagement-bi/report/toPage.do?pageName=total">
			            <h6 class="bt-1">总订购量</h6>
			            <div class="list"><p class="p1 p3">本年度</p><p class="p2" id="totalOrder"></p></div>
			            <div class="chart s12">
			                <div class="chart-box" id="totalOrderchart1"></div>
			            </div>
			        </a>
			        <a class="cunliang c13" href="/stockmanagement-bi/report/toPage.do?pageName=total">
			          <h6 class="bt-1">流量包总收入</h6>
			            <div class="list"><p class="p1 p3">本年度</p><p class="p2" id="totalIncome"></p></div>
			            <div class="chart s13">
			                <div class="chart-box" id="totalOrderchart2"></div> 
			            </div>
			        </a>
			     </div>
		      </div>
		       <div class="home-box b6">
			    <div class="title">线上办理</div>
			     <span class="line"></span>
			    
			     <div class="data">
			        <a class="cunliang c14">
			            <h6 class="bt-1">总用户数</h6>
			            <div class="list"><p class="p1">用户数</p><p class="p2">37977</p></div>
			            <div class="chart s1" id="">1414</div>
			        </a>
			        <a class="cunliang c15">
			          <h6 class="bt-1">总收入</h6>
			            <div class="list"><p class="p1">当用户数</p><p class="p2">37977</p></div>
			            <div class="chart s2" id="">1515</div>
			        </a>
			     </div> 
		      </div>
	      </div> -->
<!--            </div>
  	   </div>
  	     --> 
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
  	   
   <script>
  $(document).ready(function(){
	     // 分类菜单控制
	    $(".nav-button").click(function(){
	        $('.left-nav').toggleClass('open-box');
	        $('.header-new').toggleClass('open-header-new');
	        $('.close-submenu-2').toggleClass('open-submenu-2');
	        $('.user-box').toggleClass('open-user-box');
	        $('.nav-button-open').toggleClass('nav-button-close');
	    });  
	     //自然人
	    getAllThreeNatural();
	   // getLineCount();
	   //自动化运营
	   getTotalReport();
	   getCelueData();
	   //自动化运营获取时间
	   getTotalReportTime();
	   //固网-总缴费
	   getTopUpNum();
	   //固网-总用户数（bss+cbss）
	   getCustomerNum();
	   getTopNum1();
	   //移网发展质量
	   getMobileNetworkChart();
	  });
  function getAllThreeNatural(){
		var flag = "1";
		var params = {
			"flag" : flag};	
		$.ajax({
					type : "post",
					data : params,
					async : true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
					url : "./naturalperson/toAllCountryThree.do",
					dataType : "json", //返回数据形式为json
					success : function(data) {
						//请求成功时执行该函数内容，result即为服务器返回的json对象
						if (data.flag) {
							//存量不限量产品办理量
							var CountT = data.result.ThreeCount;
							
							var all=0;
							for(var i=0;i<CountT.length;i++){
								if(CountT[i].parent_class_name=="24"){
									document.getElementById("mobile").innerHTML+=(CountT[i].countrysum/100000000).toFixed(2)+'<span>亿</span>';
									all = all+CountT[i].countrysum;
								} else if(CountT[i].parent_class_name=="25"){
									document.getElementById("broadband").innerHTML +=(CountT[i].countrysum/10000).toFixed(2)+'<span>万</span>';
									all = all+CountT[i].countrysum;
								}else if(CountT[i].parent_class_name=="26"){
									document.getElementById("mixed").innerHTML +=(CountT[i].countrysum/10000).toFixed(2)+'<span>万</span>';
									all = all+CountT[i].countrysum;
								}
							}
							document.getElementById("allnature").innerHTML = (all/100000000).toFixed(2)+'<span>亿</span>';
							$("#time4").html(""+data.msg);
						}
					},
					error : function(errorMsg) {
						//请求失败时执行该函数
						alert("图表请求数据失败!");
						//myFileChart2.hideLoading();
					}
				});
	}
  
  function getTotalReportTime() {
		$.ajax({
			type : "post",
			async : true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
			url : "./report/getReportTime.do",
			data: {},
			dataType : "json", //返回数据形式为json
			success : function(data) {
				var time5= (data.year)+"年" +(data.month)+"月";
				$("#time5").html(""+time5);
			},
			error : function(errorMsg) {
				alert("图表请求数据失败!");
			}
		})
	}
  
	function getTotalReport() {
		$.ajax({
			type : "post",
			async : true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
			url : "./report/toHomeTotal.do",
			data: {"main":"main"},
			dataType : "json", //返回数据形式为json
			success : function(data) {
				//请求成功时执行该函数内容，result即为服务器返回的json对象
				//当月产品订购数
				var addNumber = data.result.totalOrder;
				document.getElementById("totalOrder").innerHTML = Number(addNumber[0].totalNumber).toFixed(0)+"<span>万次</span>";
				document.getElementById("totalIncome").innerHTML = Number(addNumber[0].totalIncome).toFixed(0)+"<span>万元</span>";
				//N个月的产品订购数和流量包总收入柱状图
				var total = data.result.total;
				
			},
			error : function(errorMsg) {
				//请求失败时执行该函数
				alert("图表请求数据失败!");
			}
		})
	}
	
	function getCelueData() {
		$.ajax({
			type : "post",
			async : true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
			url : "./policy/toHomeTotal.do",
			data: {},
			dataType : "json", //返回数据形式为json
			success : function(data) {
				//请求成功时执行该函数内容，result即为服务器返回的json对象
				//当月产品订购数
				document.getElementById("celue1Day").innerHTML = Number(data.result.c1/100000000).toFixed(2)+"<span>亿</span>";
				document.getElementById("celue1Month").innerHTML = Number(data.result.c3/100000000).toFixed(2)+"<span>亿</span>";
				document.getElementById("celue2Day").innerHTML = Number(data.result.c2/100000000).toFixed(2)+"<span>亿</span>";
				document.getElementById("celue2Month").innerHTML = Number(data.result.c4/100000000).toFixed(2)+"<span>亿</span>";
				//N个月的产品订购数和流量包总收入柱状图
				var time6= (data.result.year)+"年" +(data.result.month)+"月"+(data.result.day)+"日";
				$("#time6").html(""+time6);
				
			},
			error : function(errorMsg) {
				//请求失败时执行该函数
				alert("图表请求数据失败!");
			}
		})
	}
	
	function getTopUpNum(){
		$.ajax({
	        type : 'POST',
	        url : 'busiAnay/getLast7TelAndBroad.do',
			datatype : 'json',
	        success : function(data) {
	        	if (data.flag){
	        		var totalList = data.result.result;
	        		
	        		var date = [];
					var tel = [];
					var broad = [];
					
					for (var i = 0; i < totalList.length; i++) {
						var temp = totalList[i];
						
						date[i] = temp.dataDate;
						tel.push((parseFloat(temp.tel)/10000).toFixed(2));
						broad.push((parseFloat(temp.broad)/10000).toFixed(2));
						
					}
	        		
					//drawTopUp(date, tel, broad);
	        	}
	        }
		});
	}
	
	function getCustomerNum(){
		$.ajax({
	        type : 'POST',
	        url : 'busiAnalysisMonth/toCustomerNum.do',
			datatype : 'json',
	        success : function(data) {
	        	if (data.flag){
	        		var num = data.result.result;
	        		var customer1 = (parseInt(num.bssNum)+ parseInt(num.cbssNum))/100000000;
	        		document.getElementById("customerNum1").innerHTML = customer1.toFixed(2) + "<span>亿</span>";
	        		$("#time3").html(""+(num.dataDate).substring(0,4)+"年" +(num.dataDate).substring(4,6)+"月");
	        		//drawCustomerPie(num.bssNum,num.cbssNum);
	        	}
	        }
		});
	}

	function getMobileNetworkChart(){
		$.ajax({
	        type : 'POST',
	        url : 'busiAnalysisMonth/toMobileNetworkChart.do',
			datatype : 'json',
	        success : function(result,msg) {
	        	$("#time2").html(""+(result.result[0].month).substring(0,4)+"年" +(result.result[0].month).substring(4,6)+"月");
	        	//month child value
	        	document.getElementById("userReal").innerHTML = result.result[0].value+"<span>万</span>";
	        	document.getElementById("userOther").innerHTML = result.result[2].value+"<span>万</span>";
	        	document.getElementById("userReturn").innerHTML = result.result[1].value+"<span>万</span>";
	        
	        }
		});
	}
	
	function getTopNum1(){
		var params = {};
		
		$.ajax({
			type : "post",
			data: params,
			url: "./busiAnay/toTelAndBroad.do",
			async : true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
			dataType : "json",
			success : function(data){
				if(data.flag){
					var date = [];
					var tel = [];
					var broad = [];
					var rate= [];
					var totalNum = 0;
					var totalList = data.result.result;
					for (var i = 0; i < totalList.length; i++) {
						var temp = totalList[i];
						
						tel.push((parseFloat(temp.tel)/10000).toFixed(2));
						broad.push((parseFloat(temp.broad)/10000).toFixed(2));
						
						totalNum += parseFloat(temp.tel)+parseFloat(temp.broad);

						//console.log(totalNum + "~~");
					}
					totalNum = (totalNum /10000).toFixed(2);
					document.getElementById("topUpNum1").innerHTML = totalNum +"<span>万元</span>";
				}
			},
			error : function(errorMsg){
				alert("图表请求数据失败!");
			}
		})
	}



	function drawCustomerPie(bssNum, cbssNum) {
		var dom = document.getElementById("customerNum");
		var myChart = echarts.init(dom);
		var app = {};
		option = null;
		option = {
			color:['#ff9c00','#6cdb91','#4c93d5'],
		    title : {
		        text: '总用户数',
		        x:'left',
		        	textStyle: {
			              fontWeight: "normal",
			              color: "#666"
			            },
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    grid: {
		        left: 5,
		        right: 5,
		        top: 70,
		        bottom: 20,
		    },
		    legend: {
		         x:'right',
		         itemWidth: 10,
		            itemHeight: 10,
		            itemGap: 20,
		            data: ['BSS用户数','CBSS用户数'],
		            textStyle: {
		             fontSize:12,
		             color:'#666',
		             padding: [2, 0]
		         }
		        },
		    series : [
		        {
		            name: '访问来源',
		            type: 'pie',
		            radius : '55%',
		            center: ['50%', '60%'],
		            data:[
		                {value:bssNum, name:'BSS用户数'},
		                {value:cbssNum, name:'CBSS用户数'}
		            ],
		            itemStyle: {
		                emphasis: {
		                    shadowBlur: 10,
		                    shadowOffsetX: 0,
		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
		                }
		            }
		        }
		    ]
		};
		;
		if (option && typeof option === "object") {
		    myChart.setOption(option, true);
		}
	}

   
  </script>
  
<script type="text/javascript">



$(function(){
	var childClassName = "39";
	var params = {"childClassName":childClassName};
	$.ajax({
		type : "post",
		data : params,
		async : true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
		url : "busiAnalysis/changyue.do",
		dataType : "json", //返回数据形式为json
		success : function(data) {
			//请求成功时执行该函数内容，result即为服务器返回的json对象
			if (data.flag) {
				var dayList = data.result.day;
				var monthList = data.result.month;
				chartSceneChangyue1(dayList,monthList);
			}
		},
		error : function(errorMsg) {
			//请求失败时执行该函数
			alert("图表请求数据失败!");
			myFileChart.hideLoading();
		}
	})
});

$(function(){
	var childClassName = "40";
	var params = {"childClassName":childClassName};
	$.ajax({
		type : "post",
		data : params,
		async : true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
		url : "busiAnalysis/changyue.do",
		dataType : "json", //返回数据形式为json
		success : function(data) {
			//请求成功时执行该函数内容，result即为服务器返回的json对象
			if (data.flag) {
				var dayList = data.result.day;
				var monthList = data.result.month;
				chartSceneChangyue2(dayList,monthList);
			}
		},
		error : function(errorMsg) {
			//请求失败时执行该函数
			alert("图表请求数据失败!");
			myFileChart.hideLoading();
		}
	})
});

function chartSceneChangyue1(result1,result2){
	var myFileChart = echarts.init(document.getElementById('changyue1Chart'));
	myFileChart.clear();
	myFileChart.setOption({
		color:['#cf4a61','#4282ce'],
		title : {
			text : '存量不限量',
			x : 'left',
			textStyle: {
	              fontWeight: "normal",
	              color: "#768297"
	            },
		},
		 grid: {
		        left: 5,
		        right: 5,
		        top: 40,
		        bottom: 20,
		    },
		    legend: {
		         x:'right',
		         itemWidth: 10,
		            itemHeight: 10,
		            itemGap: 20,
		            data : [ '当日', '当月累计' ],
		            textStyle: {
		             fontSize:12,
		             color:'#666',
		             padding: [2, 0]
		         }
		        },
		tooltip : {
			show : true,
			trigger : 'axis',
			axisPointer : { // 坐标轴指示器，坐标轴触发有效
				type : 'cross',
				crossStyle : {
					color : '#999',
					type : 'shadow'
				}
			},
			extraCssText : 'height:80px;'
		},
	
		toolbox: {
	           feature: {
	           }
	       },
		xAxis : {
			//       	 name: '日期',
			type : 'category',
			data : [],
			axisLabel : {
				interval : 0
			},
			axisPointer : {
				type : 'shadow'
			},
			
			
			splitLine: {
			    // 坐标刻度颜色
				lineStyle: {
				        color: ['#768297']
				    }
				},
				// 坐标单位文字
				nameTextStyle: {
					color: ['#768297']
					},
			    // 坐标轴颜色
				axisLine:{
                    lineStyle:{
                        color:'#768297',
                        width:1,
                    }
                }
		},
		
		
		yAxis : {
			type : 'value',
			name: '',
			show:false,
			axisLabel : {
            	formatter: function(){
                    return "";
              }
            },
	        splitLine:{show: false}//去除网格线
		},
		series : [
		          //柱一
		          {
	                name:'数量',
	                type:'bar', 
	                barWidth: 20,
	                label: {
		                normal: {
		                    show: true,
		                    position: 'top',
		                    color:'fff', 
		                }
		            },
	                itemStyle: {
	                  normal: {
	                    color: new echarts.graphic.LinearGradient(
	                      0, 0, 0, 1,
	                    [
{offset: 0, color: '#6cdb91'},   
{offset: 1, color: '#6cdb91'}
	                    ]
	                 )
	            },
	            emphasis: {
	              color: new echarts.graphic.LinearGradient(
	                    0, 0, 0, 1,
	                   [
	                    {offset: 0, color: '#6cdb91'},
	                    {offset: 1, color: '#6cdb91'}
	                   ]
	              )
	             }
	         }
	     },//柱二
		            {
		                name:'数量',
		                type:'bar', 
		                barWidth: 20,
		                color:'#fff',
		                label: {
			                normal: {
			                    show: true,
			                    position: 'top',
			                    color:'fff',  
			                }
			            },
		                itemStyle: {
		                  normal: {
		                    color: new echarts.graphic.LinearGradient(
		                      0, 0, 0, 1,
		                    [
{offset: 0, color: '#ff9c00'},
{offset: 1, color: '#ff9c00'}, 
		                     
		                    ]
		                 )
		            },
		            emphasis: {
		              color: new echarts.graphic.LinearGradient(
		                    0, 0, 0, 1,
		                   [
{offset: 0, color: '#ff9c00'},
{offset: 1, color: '#ff9c00'}, 
		                   ]
		              )
		             }
		         }
		     },
		     
		    
	],
	});
	myFileChart.showLoading(); //数据加载完之前先显示一段简单的loading动画
	var time = [];
	var dayValue = [];
	var monthValue = [];
	//alert(result1[result1.length-1].day);
	var  a = (result1[result1.length-1].day).substring(0,4)+"年" 
	        + (result1[result1.length-1].day).substring(4,6)+"月"
			+ (result1[result1.length-1].day).substring(6,8)+"日";
	$("#time1").html(""+a);
	for(var i = 0; i < result1.length; i++){
		if(i==result1.length-1){
			$("#changyue1Day").html(result1[i].value+"<span>万</span>");
		}
		time.push(result1[i].day);
		dayValue.push(result1[i].value);
	}
	for(var i = 0; i < result2.length; i++){
		if(i==result2.length-1){
			$("#changyue1Month").html(result2[i].value+"<span>万</span>")
		}
		monthValue.push(result2[i].value);
	}
	myFileChart.hideLoading();
	myFileChart.setOption({ //加载数据图表
		xAxis : {
			data : time,
		},
		series : [ {
			name : '当日',
			data : dayValue
		}, {
			name : '当月累计',
			data : monthValue
		} ]
	});
}

function chartSceneChangyue2(result1,result2){
	var myFileChart = echarts.init(document.getElementById('changyue2Chart'));
	myFileChart.clear();
	myFileChart.setOption({
		color:['#cf4a61','#4282ce'],
		title : {
			text : '流量王',
			x : 'left',
			textStyle: {
	              fontWeight: "normal",
	              color: "#768297"
	            },
		},
		 grid: {
		        left: 5,
		        right: 5,
		        top: 40,
		        bottom: 20,
		    },
		    legend: {
		         x:'right',
		         itemWidth: 10,
		            itemHeight: 10,
		            itemGap: 20,
		            data : [ '当日', '当月累计' ],
		            textStyle: {
		             fontSize:12,
		             color:'#666',
		             padding: [2, 0]
		         }
		        },
		tooltip : {
			show : true,
			trigger : 'axis',
			axisPointer : { // 坐标轴指示器，坐标轴触发有效
				type : 'cross',
				crossStyle : {
					color : '#999',
					type : 'shadow'
				}
			},
			extraCssText : 'height:80px;'
		},
		
		toolbox: {
	           feature: {
	           }
	       },
		xAxis : {
			//       	 name: '日期',
			type : 'category',
			data : [],
			axisLabel : {
				interval : 0
			},
			axisPointer : {
				type : 'shadow'
			},
			
			
			splitLine: {
			    // 坐标刻度颜色
				lineStyle: {
				        color: ['#768297']
				    }
				},
				// 坐标单位文字
				nameTextStyle: {
					color: ['#768297']
					},
			    // 坐标轴颜色
				axisLine:{
                    lineStyle:{
                        color:'#768297',
                        width:1,
                    }
                }
		},
		
		
		yAxis : {
			type : 'value',
			name: '',
			show:false,
			axisLabel : {
            	formatter: function(){
                    return "";
              }
            },
	        splitLine:{show: false}//去除网格线
		},
		series : [
		          //柱一
		          {
	                name:'数量',
	                type:'bar', 
	                barWidth: 20,
	                label: {
		                normal: {
		                    show: true,
		                    position: 'top',
		                    color:'fff', 
		                }
		            },
	                itemStyle: {
	                  normal: {
	                    color: new echarts.graphic.LinearGradient(
	                      0, 0, 0, 1,
	                    [
{offset: 0, color: '#6cdb91'},   
{offset: 1, color: '#6cdb91'}
	                    ]
	                 )
	            },
	            emphasis: {
	              color: new echarts.graphic.LinearGradient(
	                    0, 0, 0, 1,
	                   [
	                    {offset: 0, color: '#6cdb91'},
	                    {offset: 1, color: '#6cdb91'}
	                   ]
	              )
	             }
	         }
	     },//柱二
		            {
		                name:'数量',
		                type:'bar', 
		                barWidth: 20,
		                color:'#fff',
		                label: {
			                normal: {
			                    show: true,
			                    position: 'top',
			                    color:'fff',  
			                }
			            },
		                itemStyle: {
		                  normal: {
		                    color: new echarts.graphic.LinearGradient(
		                      0, 0, 0, 1,
		                    [
{offset: 0, color: '#ff9c00'},
{offset: 1, color: '#ff9c00'}, 
		                     
		                    ]
		                 )
		            },
		            emphasis: {
		              color: new echarts.graphic.LinearGradient(
		                    0, 0, 0, 1,
		                   [
{offset: 0, color: '#ff9c00'},
{offset: 1, color: '#ff9c00'}, 
		                   ]
		              )
		             }
		         }
		     },
		     
		    
	],
	});
	myFileChart.showLoading(); //数据加载完之前先显示一段简单的loading动画
	var time = [];
	var dayValue = [];
	var monthValue = [];
	for(var i = 0; i < result1.length; i++){
		if(i==result1.length-1){
			$("#changyue2Day").html(result1[i].value+"<span>万</span>");
		}
		time.push(result1[i].day);
		dayValue.push(result1[i].value);
	}
	for(var i = 0; i < result2.length; i++){
		if(i==result2.length-1){
			$("#changyue2Month").html(result2[i].value+"<span>万</span>")
		}
		monthValue.push(result2[i].value);
	}
	myFileChart.hideLoading();
	myFileChart.setOption({ //加载数据图表
		xAxis : {
			data : time,
		},
		series : [ {
			name : '当日',
			data : dayValue
		}, {
			name : '当月累计',
			data : monthValue
		} ]
	});
}
</script>






</body>
</html>
