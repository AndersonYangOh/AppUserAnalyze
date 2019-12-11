<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String path1 = request.getContextPath();
	String basePath1 = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path1 + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<title>自然人网络状态分布情况统计</title>
<base href="<%=basePath1%>" />
<!--[if lt IE 9]>
<script src="http://apps.bdimg.com/libs/html5shiv/3.7/html5shiv.min.js"></script>
<![endif]-->
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/general.css">
<link rel="stylesheet" href="css/layout.css">
<link rel="stylesheet" href="css/core.css">
<link rel="stylesheet" href="js/jbox/jbox.css">

<script type="text/javascript" src="js/jquery-2.1.4.js"></script>
<script type="text/javascript" src="js/validate/jquery.validate.min.js"></script>
<script type="text/javascript"
	src="js/validate/additional-methods.min.js"></script>
<script type="text/javascript" src="js/validate/messages_zh.js"></script>
<script type="text/javascript" src="js/modal/bootstrap-modal.js"></script>
<script type="text/javascript" src="js/modal/bootstrap-modalmanager.js"></script>
<script type="text/javascript" src="js/jbox/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="js/jbox/jquery.jbox-zh-cn.js"></script>
<script type="text/javascript" src="js/echarts.common.min.js"></script>

<script type="text/javascript">
	var orgCode="${orgCode}";
	$(function() {

		
		if(orgCode=="001"){
			document.getElementById("province").value = orgCode;
			if ($("#region").val() == "001") { // 选择全国，分省的下拉菜单隐藏,也不让选时间
				$("#provinceDiv").hide();
				$("#periodDiv").hide();
			}
			$("#region").bind("change", function() { // 选择了分省，出现
				var dataname = $(this).val();
				if (dataname == "001") {
					$("#provinceDiv").hide();
					$("#periodDiv").hide();
				} else {
					$("#provinceDiv").show();
					$("#periodDiv").show();
				}
			});
			getAllProvinceNatural("");
		}else{
			document.getElementById("province").value = orgCode;
			document.getElementById("region").value = "002";
			$("#province").attr("disabled","disabled");
			$("#region").attr("disabled","disabled");
			$("#yearDiv").hide();
			$("#monthDiv").hide();
			//getAllProvinceNatural("");
			OnQuery();
		}
		
		
	});

	function getAllProvinceNatural(monthid) {
		var flag = "1";
		var params = {
			"flag" : flag};
		
			params["monthid"]=monthid;
		
		$.ajax({
					type : "post",
					data : params,
					async : true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
					url : "./naturalperson/toAllProvinceNatural.do",
					dataType : "json", //返回数据形式为json
					success : function(data) {
						//请求成功时执行该函数内容，result即为服务器返回的json对象
						if (data.flag) {
							//存量不限量产品办理量
							var AllProvinceMobile = data.result.AllProvinceMobileNature;
							chartScene1(AllProvinceMobile, data.msg);

						}
						else
						{
							alert("所输入时间无有效数据");
						}
					},
					error : function(errorMsg) {
						//请求失败时执行该函数
						alert("图表请求数据失败!");
						//myFileChart2.hideLoading();
					}
				})
	}
	
	function getAllProvinceMixedNatural(monthid) {
		var flag = "1";
		var params = {
			"flag" : flag};
		
			params["monthid"]=monthid;
		
		$.ajax({
					type : "post",
					data : params,
					async : true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
					url : "./naturalperson/toAllProvinceNatural.do",
					dataType : "json", //返回数据形式为json
					success : function(data) {
						//请求成功时执行该函数内容，result即为服务器返回的json对象
						if (data.flag) {
							//存量不限量产品办理量
							var AllProvince = data.result.AllProvinceMixedNature;
							chartScene1(AllProvince, data.msg);

						}
						else
						{
							alert("所输入时间无有效数据");
						}
					},
					error : function(errorMsg) {
						//请求失败时执行该函数
						alert("图表请求数据失败!");
						//myFileChart2.hideLoading();
					}
				})
	}
	
	function getAllProvinceBroadNatural(monthid) {
		var flag = "1";
		var params = {
			"flag" : flag};
		
			params["monthid"]=monthid;
		
		$.ajax({
					type : "post",
					data : params,
					async : true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
					url : "./naturalperson/toAllProvinceNatural.do",
					dataType : "json", //返回数据形式为json
					success : function(data) {
						//请求成功时执行该函数内容，result即为服务器返回的json对象
						if (data.flag) {
							//存量不限量产品办理量
							var AllProvince = data.result.AllProvinceBroadNature;
							chartScene2(AllProvince, data.msg);

						}
						else
						{
							alert("所输入时间无有效数据");
						}
					},
					error : function(errorMsg) {
						//请求失败时执行该函数
						alert("图表请求数据失败!");
						//myFileChart2.hideLoading();
					}
				})
	}

	function OnQuery()
	{
		var i1= $("#year").val().trim()=="" ?  1 :0;
		var i2= $("#month").val().trim()=="" ?  1 :0;
		var i3=i1+i2;
		if($("#region").val()=="001" & $("#busi").val()=="1"){ //全国 移网
			//全国：如果不写时间，默认是最新
			if(i3==2 | i3==0){
				getAllProvinceNatural($("#year").val().trim()+$("#month").val().trim());//默认显示移网业务
			}
			else{//年份和月份 有一个为空
				alert("请同时输入年和月");
			}
		}
		else if($("#region").val()=="001" & $("#busi").val()=="2"){ //全国 固网
			//全国：如果不写时间，默认是最新
			if(i3==2 | i3==0){
				//固网业务
				getAllProvinceBroadNatural($("#year").val().trim()+$("#month").val().trim());
			}
			else{//年份和月份 有一个为空
				alert("请同时输入年和月");
			}
		}
		else if($("#region").val()=="001" & $("#busi").val()=="3"){ //全国 移固融合
			//全国：如果不写时间，默认是最新
			if(i3==2 | i3==0){
				getAllProvinceMixedNatural($("#year").val().trim()+$("#month").val().trim());
			}
			else{//年份和月份 有一个为空
				alert("请同时输入年和月");
			}
		}//////////////////////////////分省维度////////////////////////////////////////////////
		else if($("#region").val()=="002" & $("#province").val()!="001"){//分省，还选了具体某个省。
			if(i3==0 | i3==2)
			{
				getOneProvinceRecent($("#year").val().trim()+$("#month").val().trim(),$("#province").val(),$("#busi").val(),$("#period").val());
			}
			else
			{
				alert("请同时输入年月,格式为yyyyMM");
			}
		}
		else {
			alert("请选择完整菜单！");
		}
	}

	function getOneProvinceRecent(monthid,province,busitype,limit)
	{
		var flag = "1";
		var params = {"flag" : flag};
		params["monthid"]=monthid;
		params ={"flag" : flag,"monthid":monthid,"province_code":province,"busi":busitype,"limit":limit}
		
		$.ajax({
					type : "post",
					data : params,
					async : true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
					url : "./naturalperson/toProvinceRecent.do",
					dataType : "json", //返回数据形式为json
					success : function(data) {
						//请求成功时执行该函数内容，result即为服务器返回的json对象
						if (data.flag) {
							//存量不限量产品办理量
							var OneProvince = data.result.ProvinceRecent;
							provinceRecentChart(OneProvince);
						}
						else
						{
							alert("所输入时间无有效数据");
						}
					},
					error : function(errorMsg) {
						//请求失败时执行该函数
						alert("图表请求数据失败!");
						//myFileChart2.hideLoading();
					}
				});
	}
	
	function provinceRecentChart(reslut){
		var myChart = echarts.init(document.getElementById('chartScene1'));
		myChart.clear();
		var labelOption = {
				color: ['#6cda94', '#edb200', '#4b5dcf', '#bb4bcf', '#c30000', '#12a8df'],
			    normal: {
			        show: true,
			        position: 'insideBottom',
			        distance:15,
			        align: 'left',
			        verticalAlign: 'middle',
			       
			        formatter: '{c}  {name|}',
			        fontSize: 10,
			        rich: {
			            name: {
			                textBorderColor: '#fff'
			            }
			        }
			    }
			};
		var xAxisName=[];//month
		var bartype=[];//cellcount 1-6
		var showdata=[];
		var lclassname="";
		var indata=[];
		var recent=parseInt($("#period").val());
		var counter=0;
		
		if(recent > reslut.length/6){
			recent=reslut.length/6;
		}
		//recent=recent > reslut.length/6 ? reslut.length/6 :recent;
		
		//以下部分，默认每个月的1-6个分类不会缺失数据。如果缺失，下面的逻辑会有问题
		if(reslut.length==6){
			for(var i =0;i<reslut.length;++i){
			// A.`month`,B.ChildClassName ,SUM(`value`) countrysum
				if(reslut[i].ChildClassName!=lclassname){ //
					bartype.push(reslut[i].ChildClassName)
					lclassname=reslut[i].ChildClassName;
					if(bartype.length<=1){
						xAxisName.push(reslut[i].month);
					}
				}
				if(counter==recent){
					showdata.push(indata);
					indata=[];
					counter=0;
				}
				indata.push((reslut[i].countrysum/10000).toFixed(2));
				counter=counter+1;			
			}//for(var i =0;i<reslut.length
			if(counter==recent){showdata.push(indata);}
		}//if(reslut.length==6)
		else{
			for(var i =0;i<6;++i){//1-5个以上手机号，每组里6个柱状图，固定的。
				for(var k=0;k<recent;++k){//近几个月，就有几个大组
					indata.push((reslut[3*i+k].countrysum/10000).toFixed(2))
				}//for k	
				showdata.push(indata);
				bartype.push(reslut[3*i+k-1].ChildClassName)//手机号个数分组
				indata=[];
			}
			for(var k=0;k<recent;++k){//近几个月，就有几个大组
				xAxisName.push(reslut[k].month)
			}//for k	
			
		}//else
		var labelOption = {
				color: ['#6cda94', '#edb200', '#4b5dcf', '#bb4bcf', '#c30000', '#12a8df'],
		    normal: {
		        show: true,
		        position: 'top',
		        distance:15,
		        align: 'center',
		        verticalAlign: 'middle',
		        formatter: '{c}  {name|}万人',
		        fontSize: 16,
		        rich: {
		            name: {
		                textBorderColor: '#fff'
		            }
		        }
		    }
		};
		var option=null;
		if(reslut.length==6)
		{
			option = {
					color: ['#6cda94', '#edb200', '#4b5dcf', '#bb4bcf', '#c30000', '#12a8df'],
			    tooltip: {
			        trigger: 'axis',
			        axisPointer: {
			            type: 'shadow'
			        }
			    },
			    legend: {
			        data: bartype
			    },
			    toolbox: {
			        show: true,
			        orient: 'vertical',
			        left: 'right',
			        top: 'center',
			        feature: {
			            saveAsImage: {show: true}
			        }
			    },
			    calculable: true,
		
			    xAxis : {
					//	       	 name: '日期',
					type : 'category',
					axisTick: {show: false},
					data: xAxisName,
					axisPointer : {
						type : 'shadow'
					},
					axisLabel : {
						interval : 0,
						rotate : -30
					}
				},
			    yAxis: 
			        {
			            //name:'单位：（万人）'
			        	type: 'value'
			        }
			    ,
			    series: [
			        {
			            name:bartype[0],
			        	type: 'bar',
			            barGap: 10,//控制bar之间的的间距
			            barWidth: 10,
			            label: labelOption,
			            data: showdata[0]
			        },
			        {	name:bartype[1],
			            type: 'bar',
			            barWidth: 10,
			            label: labelOption,
			            data: showdata[1]
			        },
			        {	name:bartype[2],
			            type: 'bar',
			            barWidth: 10,
			            label: labelOption,
			            data: showdata[2]
			        },
			        {	name:bartype[3],
			            type: 'bar',
			            barWidth: 10,
			            label: labelOption,
			            data: showdata[3]
			        },
			        {	name:bartype[4],
			            type: 'bar',
			            barWidth: 10,
			            label: labelOption,
			            data: showdata[4]
			        },
			        {	name:bartype[5],
			            type: 'bar',
			            barWidth: 10,
			            label: labelOption,
			            data: showdata[5]
			        }
			    ]
			};//option 
		}// if length
		else{ //近3、6个月
			option = {
					color: ['#6cda94', '#edb200', '#4b5dcf', '#bb4bcf', '#c30000', '#12a8df'],
			    tooltip: {
			        trigger: 'axis',
			        axisPointer: {
			            type: 'shadow'
			        }
			    },
			    legend: {//手机号数目
			        data: bartype
			    },
			    toolbox: {
			        show: true,
			        orient: 'vertical',
			        left: 'right',
			        top: 'center',
			        feature: {
			            saveAsImage: {show: true}
			        }
			    },
			    calculable: true,
		
			    xAxis : {
					//	       	 name: '日期',
					type : 'category',
					axisTick: {show: false},
					data: xAxisName,
					axisPointer : {
						type : 'shadow'
					},
					axisLabel : {
						interval : 0,
						rotate : -30
					}
				},
			    yAxis: 
			        {
			            //name:'单位：（万人）'
			        	type: 'value'
			        }
			    ,
			    series: [
			        {
			            name:bartype[0],
			        	type: 'bar',
			            barGap: 1,//控制bar之间的的间距
			            barWidth: 10,
			            label: labelOption,
			            data: showdata[0]
			        },
			        {	name:bartype[1],
			            type: 'bar',
			            barWidth: 10,
			            label: labelOption,
			            data: showdata[1]
			        },
			        {	name:bartype[2],
			            type: 'bar',
			            barWidth: 10,
			            label: labelOption,
			            data: showdata[2]
			        }
			        ,
			        {	name:bartype[3],
			            type: 'bar',
			            barWidth: 10,
			            label: labelOption,
			            data: showdata[3]
			        },
			        {	name:bartype[4],
			            type: 'bar',
			            barWidth: 10,
			            label: labelOption,
			            data: showdata[4]
			        },
			        {	name:bartype[5],
			            type: 'bar',
			            barWidth: 10,
			            label: labelOption,
			            data: showdata[5]
			        }
			    ]
			};
			
		}//else
		 
		myChart.setOption(option);
	}
	
	function chartScene1(result, msg) {
		var myFileChart2 = null;

		myFileChart2 = echarts.init(document.getElementById('chartScene1'));

		// 显示标题，图例和空的坐标轴
		myFileChart2.clear();
		//与数据格式[[31]*6]
		myFileChart2.setOption({
			color: ['#6cda94', '#edb200', '#4b5dcf', '#bb4bcf', '#c30000', '#12a8df'],
			tooltip : {
				trigger : 'axis',
				axisPointer : { // 坐标轴指示器，坐标轴触发有效
					type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
				}
			},
			legend : {
				   left:'center',
					itemWidth: 10,
					itemHeight: 10,
					itemGap: 20,
					data : typeclass,
					textStyle: {
					 fontSize:15,
					  color:'#768297',
					}
			},
			grid: {
		        left:60,
		        right: 30,
		        bottom:60,
		    },
			yAxis : {
				name : '单元:万人',
				type : 'value'
			},
			xAxis : {
				type : 'category',
				axisLabel: {
		            show: true,
		            interval: '0',
		            rotate : -30
		            
		        },
				data : []
			//这里应该是省分的名字
			},
			series : [ {
				barWidth: 10,
				name:"总计",
				type : 'bar',
				barGap: '-100%',
				data : []
			}, {
				barWidth: 10,
				type : 'bar',
				stack : '总量',
				
				data : []
			}, {
				barWidth: 10,
				type : 'bar',
				stack : '总量',
				data : []
			}, {
				barWidth: 10,
				type : 'bar',
				stack : '总量',
				data : []
			}, {
				barWidth: 10,
				type : 'bar',
				stack : '总量',
				data : []
			}, {
				barWidth: 10,
				type : 'bar',
				stack : '总量',
				data : []
			}, {
				barWidth: 10,
				type : 'bar',
				stack : '总量',
				data : []
			},

			]
		});
		
		//echart图表自适应
        window.addEventListener("resize", function () {
        	myFileChart2.resize();
        });
		
		myFileChart2.showLoading(); //数据加载完之前先显示一段简单的loading动画

		//var classification = [];
		var xName =[];
		var yValue = [];
		var p1 = [];
		var p2 = [];
		var p3 = [];
		var p4 = [];
		var p5 = [];
		var p6 = [];
		var p7 = [];
		var typeclass = [ '1个', '2个', '3个', '4个', '5个',
				'5个以上' ]; //组成堆叠柱子的数据
		for (var i = 0; i < result.length; i++) {
			if (xName.indexOf(result[i].province_code) < 0) {
				xName.push(result[i].province_code);
			}
			if (result[i].child_class_name == typeclass[0]) {
				p1.push((result[i].countrysum / 10000).toFixed(2));
			} else if (result[i].child_class_name == typeclass[1]) {
				p2.push((result[i].countrysum / 10000).toFixed(2));
			} else if (result[i].child_class_name == typeclass[2]) {
				p3.push((result[i].countrysum / 10000).toFixed(2));
			} else if (result[i].child_class_name == typeclass[3]) {
				p4.push((result[i].countrysum / 10000).toFixed(2));
			} else if (result[i].child_class_name == typeclass[4]) {
				p5.push((result[i].countrysum / 10000).toFixed(2));
			} else if (result[i].child_class_name == typeclass[5]) {
				p6.push((result[i].countrysum / 10000).toFixed(2));
			}
		}
		yValue.push(p1);
		yValue.push(p2);
		yValue.push(p3);
		yValue.push(p4);
		yValue.push(p5);
		yValue.push(p6);
		for(var k =0;k<p1.length;++k)
		{
			p7.push((parseFloat(p1[k])+parseFloat(p2[k])+parseFloat(p3[k])+parseFloat(p4[k])+parseFloat(p5[k])+parseFloat(p6[k])).toFixed(2));
		}
		yValue.push(p7);
		myFileChart2.hideLoading(); //隐藏加

		myFileChart2.setOption({
			color: ['#6cda94', '#edb200', '#4b5dcf', '#bb4bcf', '#c30000', '#12a8df'],
			yAxis : {
				type : 'value'
			},
			xAxis : {
				type : 'category',
				data : xName
			//这里应该是省分的名字
			},
			series : [ 
			{
				name: "总计",
				type : 'bar',
				barGap: '-100%',
				label: {
                     normal: {
                         textStyle: {
                             color: '#682d19'
                         },
                         position: 'left',
                         show: false,
                         formatter: '{b}'
                     }
                 },
                 itemStyle: {
                     normal: {
                         color: '##212a47',
                         borderWidth: 0,
                         borderColor: '#1FBCD2'//#212a47

                     }
                 },
				data : yValue[6]
			}, 
			    {
				name : typeclass[0],
				type : 'bar',
				stack : '总量',
				data : yValue[0]
		
			}, {
				name : typeclass[1],
				type : 'bar',
				stack : '总量',
				//label : {
				//	normal : {
				//		show : true,
				//		position : 'insideRight'
				//	}
				//},
				data : yValue[1]
	
			}, {
				name : typeclass[2],
				type : 'bar',
				stack : '总量',
				//label : {
				//	normal : {
				//		show : true,
				//		position : 'insideRight'
				//	}
				//},
				data : yValue[2]
			//data1[2]
			}, {
				name : typeclass[3],
				type : 'bar',
				stack : '总量',
				//label : {
				//	normal : {
				//		show : true,
				//		position : 'insideRight'
				//	}
				//},
				data : yValue[3]
			//data1[3]
			}, {
				name : typeclass[4],
				type : 'bar',
				stack : '总量',
				
				data : yValue[4]
			}, {
				name : typeclass[5],
				type : 'bar',
				stack : '总量',
		
				data : yValue[5]
			},

			]
		});

	}
	
	function chartScene2(result, msg) {
		var myFileChart2 = null;

		myFileChart2 = echarts.init(document.getElementById('chartScene1'));

		// 显示标题，图例和空的坐标轴
		myFileChart2.clear();
		//与数据格式[[31]*6]
		myFileChart2.setOption({
			color: ['#6cda94', '#edb200', '#4b5dcf', '#bb4bcf', '#c30000', '#12a8df'],
			tooltip : {
				trigger : 'axis',
				axisPointer : { // 坐标轴指示器，坐标轴触发有效
					type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
				}
			},
			legend : {
				data : typeclass
			},
			grid: {
		        left:60,
		        right: 60,
		        bottom:90,
		    },
			yAxis : {
				name : '单元:万人',
				type : 'value'
			},
			xAxis : {
				type : 'category',
				axisLabel: {
		            show: true,
		            interval: '0',
		            
		        },
				data : []
			//这里应该是省分的名字
			},
			series : [ {
				name:"总计",
				type : 'bar',
				barGap: '-100%',
				data : []
			}, {
				type : 'bar',
				stack : '总量',
				
				data : []
			}, {
				type : 'bar',
				stack : '总量',
				data : []
			}, {
				type : 'bar',
				stack : '总量',
				data : []
			}, {
				type : 'bar',
				stack : '总量',
				data : []
			}, {
				type : 'bar',
				stack : '总量',
				data : []
			}, {
				type : 'bar',
				stack : '总量',
				data : []
			},

			]
		});
		myFileChart2.showLoading(); //数据加载完之前先显示一段简单的loading动画

		//var classification = [];
		var xName =[];
		var yValue = [];
		var p1 = [];
		var p2 = [];
		var p3 = [];
		var p4 = [];
		var p5 = [];
		var p6 = [];
		var p7 = [];
		var typeclass = [ '1个', '2个', '3个', '4个', '5个',
				'5个以上' ]; //组成堆叠柱子的数据
		for (var i = 0; i < result.length; i++) {
			if (xName.indexOf(result[i].province_code) < 0) {
				xName.push(result[i].province_code);
			}
			if (result[i].child_class_name == typeclass[0]) {
				p1.push((result[i].countrysum / 10000).toFixed(2));
			} else if (result[i].child_class_name == typeclass[1]) {
				p2.push((result[i].countrysum / 10000).toFixed(2));
			} else if (result[i].child_class_name == typeclass[2]) {
				p3.push((result[i].countrysum / 10000).toFixed(2));
			} else if (result[i].child_class_name == typeclass[3]) {
				p4.push((result[i].countrysum / 10000).toFixed(2));
			} else if (result[i].child_class_name == typeclass[4]) {
				p5.push((result[i].countrysum / 10000).toFixed(2));
			} else if (result[i].child_class_name == typeclass[5]) {
				p6.push((result[i].countrysum / 10000).toFixed(2));
			}
		}
		yValue.push(p1);
		yValue.push(p2);
		yValue.push(p3);
		yValue.push(p4);
		yValue.push(p5);
		yValue.push(p6);
		for(var k =0;k<p1.length;++k)
		{
			p7.push((parseFloat(p1[k])+parseFloat(p2[k])+parseFloat(p3[k])+parseFloat(p4[k])+parseFloat(p5[k])+parseFloat(p6[k])).toFixed(2));
		}
		yValue.push(p7);
		myFileChart2.hideLoading(); //隐藏加

		myFileChart2.setOption({
			color: ['#6cda94', '#edb200', '#4b5dcf', '#bb4bcf', '#c30000', '#12a8df'],
			yAxis : {
				type : 'value'
			},
			xAxis : {
				type : 'category',
				data : xName
			//这里应该是省分的名字
			},
			grid: {
		        left:60,
		        right: 60,
		        bottom:90,
		    },
			series : [ 
			{
				name: "总计",
				type : 'bar',
				barGap: '-100%',
				label: {
                     normal: {
                         textStyle: {
                             color: '#682d19'
                         },
                         position: 'left',
                         show: false,
                         formatter: '{b}'
                     }
                 },
                 itemStyle: {
                     normal: {
                         color: '##212a47',
                         borderWidth: 0,
                         borderColor: '#1FBCD2'//#212a47

                     }
                 },
				data : yValue[6]
			}, 
			    {
				name : typeclass[0],
				type : 'bar',
				stack : '总量',
				data : yValue[0]
		
			}, {
				name : typeclass[1],
				type : 'bar',
				stack : '总量',
				//label : {
				//	normal : {
				//		show : true,
				//		position : 'insideRight'
				//	}
				//},
				data : yValue[1]
	
			}, {
				name : typeclass[2],
				type : 'bar',
				stack : '总量',
				//label : {
				//	normal : {
				//		show : true,
				//		position : 'insideRight'
				//	}
				//},
				data : yValue[2]
			//data1[2]
			}, {
				name : typeclass[3],
				type : 'bar',
				stack : '总量',
				//label : {
				//	normal : {
				//		show : true,
				//		position : 'insideRight'
				//	}
				//},
				data : yValue[3]
			//data1[3]
			}, {
				name : typeclass[4],
				type : 'bar',
				stack : '总量',
				
				data : yValue[4]
			}, {
				name : typeclass[5],
				type : 'bar',
				stack : '总量',
		
				data : yValue[5]
			},

			]
		});

	}
</script>
</head>
<body style="width: 100%; height: 100%; overflow: auto">
<div class="u-body">
	<div class="u-title">
		<span>自然人名下手机号分布情况</span>
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
		<div class="z-search">
			<div class="search" id="searchDive">
				<label class="name" for="">维度：</label>
					<select class="u-input-text search-box" name="region" id="region">
						<option value="001">全国</option>
						<option value="002">分省</option>
					</select>
			</div>
			<div class="search s2">
				<label class="name" for="">业务：</label>
					<select class="u-input-text  search-box" name="busi" id="busi">
						<option value="1">单移网</option>
						<option value="2">单固网</option>
						<option value="3">移固融合</option>
					</select>
			</div>
			<div class="search" id="periodDiv">
				<label class="name" for="">跨度：</label>
				<select class="u-input-text  search-box" name="period" id="period">
					<option value="3">三个月</option>
					<option value="6">六个月</option>
				</select>
			</div>
		</div>

		<div class="z-search z-top">
			<div class="search" id="yearDiv">
				<label class="name" for="">年份：</label>
				<input type="text" class="u-input-text search-box box-input" name="year" id="year" />
			</div>
			<div class="search" id="monthDiv">
				<label class="name" for="">月份：</label>
				<input type="text" class="u-input-text search-box box-input" name="month" id="month" />
			</div>
			<div class="search" id="provinceDiv">
				<label class="name" for="">省分：</label>
				<select class="u-input-text search-box" name="province" id="province">
					<option value="001">请选择</option>
					<option value="010">内蒙古</option>
					<option value="011">北京</option>
					<option value="013">天津</option>
					<option value="017">山东</option>
					<option value="018">河北</option>
					<option value="019">山西</option>
					<option value="030">安徽</option>
					<option value="031">上海</option>
					<option value="034">江苏</option>
					<option value="036">浙江</option>
					<option value="038">福建</option>
					<option value="050">海南</option>
					<option value="051">广东</option>
					<option value="059">广西</option>
					<option value="070">青海</option>
					<option value="071">湖北</option>
					<option value="074">湖南</option>
					<option value="075">江西</option>
					<option value="076">河南</option>
					<option value="079">西藏</option>
					<option value="081">四川</option>
					<option value="083">重庆</option>
					<option value="084">陕西</option>
					<option value="085">贵州</option>
					<option value="086">云南</option>
					<option value="087">甘肃</option>
					<option value="088">宁夏</option>
					<option value="089">新疆</option>
					<option value="090">吉林</option>
					<option value="091">辽宁</option>
					<option value="097">黑龙江</option>
				</select>
			</div>
		</div>
		<div class="button-box-h">
			<a class="button chaxun" onclick="OnQuery()">查询</a> 
			<!--  <a class="button daochu" onclick="exportExcel()">导出</a>-->
		</div>
	</div>
	<div class="data" id="chartScene1"></div>
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