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
<title>出账收入统计表</title>
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


<!--[if IE 6]>
<script type="text/javascript" src="Lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('.pngfix,.icon');</script>
<![endif]-->
<script type="text/javascript">
    Number.prototype.toFixed = function(s)  
    {  
        return (parseInt(this * Math.pow( 10, s ) + 0.5)/ Math.pow( 10, s )).toString();  
    } 
    var provinceCode="${orgCode}";
	$(document).ready(function() {
		if(provinceCode=="001"){
			document.getElementById("dimension").value = "001";
		}else{
			document.getElementById("dimension").value = "002";
			document.getElementById("province").value = provinceCode;
			$("#dimension").attr("disabled","disabled");
			$("#province").attr("disabled","disabled");
		}
		if($("#dimension").val()=="001"){
			$("#provinceDiv").hide();
			//$("#periodDiv").hide();
		}
		$("#dimension").bind("change",function(){
			var dataname = $(this).val();
			if(dataname=="001"){
				$("#provinceDiv").hide();
				//$("#periodDiv").hide();
			}else{
				$("#provinceDiv").show();
				//$("#periodDiv").show();
			}
		});
		getBSSTotalReport();
	});
	function getBSSTotalReport() {
		var orgCode = $("#province").val();
		var dimension = $("#dimension").val();
		var year = $("#year").val();
		var month = $("#month").val();
		$.ajax({
			type : "post",
			async : true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
			url : "./report/toBSSTotal.do",
			data: {
				"year":year,
				"month":month,
				"orgCode":orgCode,
				"type":dimension
				},
			dataType : "json", //返回数据形式为json
			success : function(data) {
				//请求成功时执行该函数内容，result即为服务器返回的json对象
				var bss = data.result.BSS;
				if(dimension=="001"){
					bssChartByProvince(bss);
				}else{
					bssChartByMonth(bss);
				}
			},
			error : function(errorMsg) {
				//请求失败时执行该函数
				alert("图表请求数据失败!");
			}
		})
	}

	function bssChartByProvince(result) {
		var myFileChart = echarts.init(document.getElementById('statisBSS'));
		myFileChart.clear();
		// 显示标题，图例和空的坐标轴
		myFileChart.setOption({
			title : {
				text : ''
			},
			tooltip : {
				trigger : 'axis',//触发类型：坐标轴触发，隐藏属性为：none
				backgroundColor:'rgba(86,105,161,0.9)',//通过设置rgba调节背景颜色与透明度
				axisPointer : { 
				},
				extraCssText : ''
		    },
			grid:{
				left:60,
				right:53,
			},
			legend: {
		         left : 'center',
		         itemWidth: 10,
		            itemHeight: 10,
		            itemGap: 20,
		            data : [ '本月账号数(万)','波动率(%)' ],
		            textStyle: {
		             fontSize:12,
		             color:'#768297'
		         }
		        },
			toolbox: {
		           feature: {
		               saveAsImage: {}
		           }
		       },
			xAxis : {
				//       	 name: '日期',
				type : 'category',
				data : [],
				axisLabel : {
					interval : 0,
					rotate : -30
				},
				axisPointer : {
					type : 'shadow'
				},
				splitLine: {
				    // 坐标刻度颜色
					lineStyle: {
				        color: ['#626e94']
				    }
				},
				// 坐标单位文字
				nameTextStyle: {
					color: ['#626e94']
					},
			    // 坐标轴颜色
				axisLine:{
	                lineStyle:{
	                    color:'#626e94',
	                    width:1,
	                }
	            }
			},
			yAxis : [
				{
		            type: 'value',
		            name: '本月账号数(万)',
		            min: 0,
		            max: 1000,
		            interval: 200,
		            position: 'left',
		            splitLine: {
					    // 坐标刻度颜色
						lineStyle: {
							type:'dashed',//虚线
						    color: ['#555f7d']
						}
					},
					// 坐标单位文字
					nameTextStyle: {
						color: ['#626e94']
						},
				    // 坐标轴颜色
					axisLine:{
		                lineStyle:{
		                    color:'#626e94',
		                    width:1,
		                }
		            }
		        },
		        {
		            type: 'value',
		            name: '波动率(%)',
		            position: 'right',
		            min: 50,
		            max: -50,
		            interval: 20,
		            splitLine:{show: false},//去除网格线
		            splitLine: {
					    // 坐标刻度颜色
						lineStyle: {
							type:'dashed',//虚线
						    color: ['#555f7d']
						}
					},
					// 坐标单位文字
					nameTextStyle: {
						color: ['#626e94']
						},
				    // 坐标轴颜色
					axisLine:{
		                lineStyle:{
		                    color:'#626e94',
		                    width:1,
		                }
		            }
		        }
			],
			series : [ 
			{
				name : '本月账号数(万)',
	            type:'bar', 
	            barWidth: 10,
	            yAxisIndex:0,
	            color:'#fff',
	            data : [],
	            label: {
	                normal: {
	                    show: false,
	                    position: 'top',
	                    color:'fff',  
	                }
	            },
	            itemStyle: {
	            	emphasis: {
	                    barBorderRadius:[5, 5, 0, 0],
	                },
	              normal: {
	            	  barBorderRadius:[5, 5, 0, 0],
	                color: new echarts.graphic.LinearGradient(
	                  0, 0, 0, 1,
	                [
	                	{offset: 1, color: '#ffd66c'}, 
                    	{offset: 0, color: '#feb127'},
	                 
	                ]
	             )
	        },
	        emphasis: {
	          color: new echarts.graphic.LinearGradient(
	                0, 0, 0, 1,
	               [
	            	   {offset: 1, color: '#ffd66c'}, 
                   	{offset: 0, color: '#feb127'},
	               ]
	                )}
	        }
	            },
			{
				name : '波动率(%)',
				type : 'line',
				data : [],
	            yAxisIndex:1
			}]
		});
		//echart图表自适应
        window.addEventListener("resize", function () {
        	myFileChart.resize();
        });
		
		myFileChart.showLoading(); //数据加载完之前先显示一段简单的loading动画
		var province = [];
		var list1 = [];
		var list2 = [];
		var list3 = [];
		var data1=0;
		var data2=0;
		for (var i = 0; i < result.length; i++) {
			if(String(result[i].TCN)=="133"){
				province.push(result[i].provinceName);
				list1.push(Number(Number(Number(result[i].sumValue)/10000).toFixed(2)));
				data1=Number(result[i].sumValue);
			}else if(String(result[i].TCN)=="134"){
				list2.push(Number(result[i].sumValue)/10000);
				data2=Number(result[i].sumValue);
				if(data1==data2){
					list3.push(0);
				}else{
					list3.push(Number(Number(data2/(data1-data2)*100).toFixed(2)));
				}
			}
		}
		myFileChart.hideLoading(); //隐藏加载动画
		myFileChart.setOption({ //加载数据图表
			xAxis : {
				data : province,
			},
			series : [ {
				name : '本月账号数(万)',
				data : list1
			}, {
				name : '波动率(%)',
				data : list3
			} ]
		});
	}
	
	function bssChartByMonth(result) {
		var province = $("#province").val();
		var maxNumber=2000;
		if(province=="001"){
			maxNumber=10000;
		}
		var myFileChart = echarts.init(document.getElementById('statisBSS'));
		myFileChart.clear();
		// 显示标题，图例和空的坐标轴
		myFileChart.setOption({
			title : {
				text : ''
			},
			tooltip : {
				trigger : 'axis',//触发类型：坐标轴触发，隐藏属性为：none
				backgroundColor:'rgba(86,105,161,0.9)',//通过设置rgba调节背景颜色与透明度
				axisPointer : { 
				},
				extraCssText : ''
		    },
		    grid:{
				left:60,
				right:53,
			},
			legend: {
		         left : 'center',
		         itemWidth: 10,
		            itemHeight: 10,
		            itemGap: 20,
		            data : [ '本月账号数(万)','波动率(%)' ],
		            textStyle: {
		             fontSize:12,
		             color:'#768297'
		         }
		        },
			toolbox: {
		           feature: {
		               saveAsImage: {}
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
				        color: ['#626e94']
				    }
				},
				// 坐标单位文字
				nameTextStyle: {
					color: ['#626e94']
					},
			    // 坐标轴颜色
				axisLine:{
	                lineStyle:{
	                    color:'#626e94',
	                    width:1,
	                }
	            }
			},
			yAxis : [
				{
		            type: 'value',
		            name: '本月账号数(万)',
		            max:maxNumber,
		            position: 'left',
		            min: 10000,
		            max: -0,
		            interval: 2000,
		            splitLine: {
					    // 坐标刻度颜色
						lineStyle: {
							type:'dashed',//虚线
						    color: ['#555f7d']
						}
					},
					// 坐标单位文字
					nameTextStyle: {
						color: ['#626e94']
						},
				    // 坐标轴颜色
					axisLine:{
		                lineStyle:{
		                    color:'#626e94',
		                    width:1,
		                }
		            }
		        },
		        {
		            type: 'value',
		            name: '波动率(%)',
		            position: 'right',
		            min: 50,
		            max: -50,
		            interval: 20,
		            splitLine:{show: false},//去除网格线
		            splitLine: {
					    // 坐标刻度颜色
						lineStyle: {
							type:'dashed',//虚线
						    color: ['#555f7d']
						}
					},
					// 坐标单位文字
					nameTextStyle: {
						color: ['#626e94']
						},
				    // 坐标轴颜色
					axisLine:{
		                lineStyle:{
		                    color:'#626e94',
		                    width:1,
		                }
		            }
		        }
			],
			series : [ 
				{
					name : '本月账号数(万)',
		            type:'bar', 
		            barWidth: 10,
		            yAxisIndex:0,
		            color:'#fff',
		            data : [],
		            label: {
		                normal: {
		                    show: false,
		                    position: 'top',
		                    color:'fff',  
		                }
		            },
		            itemStyle: {
		            	emphasis: {
		                    barBorderRadius:[5, 5, 0, 0],
		                },
		              normal: {
		            	  barBorderRadius:[5, 5, 0, 0],
		                color: new echarts.graphic.LinearGradient(
		                  0, 0, 0, 1,
		                [
		                	{offset: 1, color: '#ffd66c'}, 
	                    	{offset: 0, color: '#feb127'},
		                 
		                ]
		             )
		        },
		        emphasis: {
		          color: new echarts.graphic.LinearGradient(
		                0, 0, 0, 1,
		               [
		            	   {offset: 1, color: '#ffd66c'}, 
	                   	{offset: 0, color: '#feb127'},
		               ]
		                )}
		        }
		            },
			{
				name : '波动率(%)',
				type : 'line',
				data : [],
	            yAxisIndex:1
			}]
		});
		myFileChart.showLoading(); //数据加载完之前先显示一段简单的loading动画
		var month = [];
		var list1 = [];
		var list2 = [];
		var list3 = [];
		var data1=0;
		var data2=0;
		for (var i = 0; i < result.length; i++) {
			if(String(result[i].TCN)=="133"){
				month.push(result[i].month);
				list1.push(Number(Number(Number(result[i].sumValue)/10000).toFixed(2)));
				data1=Number(result[i].sumValue);
			}else if(String(result[i].TCN)=="134"){
				list2.push(Number(result[i].sumValue)/10000);
				data2=Number(result[i].sumValue);
				if(data1==data2){
					list3.push(0);
				}else{
					list3.push(Number(Number(data2/(data1-data2)*100).toFixed(2)));
				}
			}
		}
		myFileChart.hideLoading(); //隐藏加载动画
		myFileChart.setOption({ //加载数据图表
			xAxis : {
				data : month,
			},
			series : [ {
				name : '本月账号数(万)',
				data : list1
			}, {
				name : '波动率(%)',
				data : list3
			} ]
		});
	}
</script>

</head>
<body style="width:100%;height:100%;overflow:auto">
	<div class="u-body">
		<div class="u-title">
			<span>BSS用户数</span>
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
				<div class="search" id="dimensionDiv">
					<label class="name" for="">维度：</label>
					<select class="u-input-text search-box" name="dimension" id="dimension">
						<option value="001">全国</option>
						<option value="002">时间</option>
					</select>
				</div>
				<div class="search" id="provinceDiv">
					<label class="name" for="">省分：</label>
					<select class="u-input-text search-box" name="province" id="province">
						<option value="001">全国</option>
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
			<div class="z-search z-top">
				<div class="search" id="yearDiv">
					<label class="name" for="">年份：</label>
						<input type="text" class="u-input-text search-box box-input" name="year" id="year" value="${Year}">
				</div>
				<div class="search" id="monthDiv">
					<label class="name" for="">月份：</label>
					<input type="text" class="u-input-text search-box box-input" name="month" id="month" value="${Month}">
				</div>
			</div>
			</div>
			<div class="button-box-h">
				<a class="button chaxun" onclick="getBSSTotalReport()">查询</a>
				<!-- <a class="button daochu" onclick="exportExcel()">导出</a> -->
			</div>
	</div>
	<div class="data" id="statisBSS"></div>
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