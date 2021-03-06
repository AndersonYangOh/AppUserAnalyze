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
<title>端到端自动化营销情况统计表</title>
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
	var orgCode="${orgCode}";
	$(document).ready(function() {
		document.getElementById("product").value = "1";
		if(orgCode=="001"){
			document.getElementById("province").value = orgCode;
		}else{
			document.getElementById("province").value = orgCode;
			$("#province").attr("disabled","disabled");
		}
		getTotalReport();
	});
	function getTotalReport() {
		var province = $("#province").val();
		var product = $("#product").val();
		var year = $("#year").val();
		var month = $("#month").val();
		var params = {"year":year,"month":month,"orgCode":province};
		$.ajax({
			type : "post",
			async : true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
			url : "./report/toChartTotal.do",
			data: params,
			dataType : "json", //返回数据形式为json
			success : function(data) {
				//请求成功时执行该函数内容，result即为服务器返回的json对象
				if (data.flag) {
					if(product=="1"){
						//N个月的产品订购数和流量包总收入柱状图
						var total = data.result.total;
						totalChart(total);
					}else if(product=="2"){
						//当月产品订购数
						var orderNumber = data.result.orderNumber;
						chartScene1(orderNumber);
					}else if(product=="3"){
						//当月流量包订购收入
						var dataplantIncome = data.result.dataplantIncome;
						chartScene2(dataplantIncome);
					}else if(product=="4"){
						//占移动业务出账收入比
						var income = data.result.income;
						chartIncomeRate(income);
					}else if(product=="5"){
						//业务场景
						var scene = data.result.scene;
						chartType(scene);
					}else if(product=="6"){
						//饼图
						var pie = data.result.pie;
						chartPie(pie);
					}else if(product=="7"){
						//饼图
						var pie = data.result.pie;
						chartPie2(pie);
					}
				}

			},
			error : function(errorMsg) {
				//请求失败时执行该函数
				alert("图表请求数据失败!");
				myFileChart.hideLoading();
			}
		})
	}

	function totalChart(result) {
		var myFileChart = echarts.init(document.getElementById('chart'));
		myFileChart.clear();
		// 显示标题，图例和空的坐标轴
		myFileChart.setOption({
			title : {
				text : '业务订购总量和流量包总收入'
			},
			tooltip : {
				trigger : 'axis',//触发类型：坐标轴触发，隐藏属性为：none
				backgroundColor:'rgba(86,105,161,0.9)',//通过设置rgba调节背景颜色与透明度
				axisPointer : { 
				},
				extraCssText : ''
		    },
			grid: {
		        left:60,
		        right: 60,
		    },
			legend: {
		         x:'center',
		         itemWidth: 20,
		            itemHeight: 10,
		            data : [ '成功订购数（万）', '流量包总收入（万）' ],
		            itemGap: 0,
		            textStyle: {
		             fontSize:12,
		             color:'#768297',
		             padding: [5,40,5,0],
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
		            name: '成功订购数(万)',
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
		            name: '流量包总收入(万)',
		            position: 'right',
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
			          //柱一
			            {
			            	name : '成功订购数（万）',
							type : 'line',
							barMaxWidth: '10',
			                color:'#fff',
			                label: {
				                normal: {
				                    show: true,
				                    position: 'top',
				                    color:'fff',  
				                }
				            },
				            areaStyle: {
				                normal: {//渐变效果
				                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
				                        offset: 0,
				                        color: '#f5b54c'
				                    }, {
				                        offset: 1,
				                        color: 'rgba(245,181,76,0)',
				                    }])
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
			              )
			             }
			         }
			     },
			     //柱二
			     {
			    	    name : '流量包总收入（万）',
						type : 'line',
						barMaxWidth: '10',
		                label: {
			                normal: {
			                    show: true,
			                    position: 'top',
			                    color:'fff', 
			                }
			            },
			            areaStyle: {//渐变效果
			                normal: {
			                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
			                        offset: 0,
			                        color: '#6bd9a6'
			                    }, {
			                        offset: 1,
			                        color: 'rgba(107,217,166,0)',
			                    }])
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
		                    	{offset: 1, color: '#2fdea6'},   
		                        {offset: 0, color: '#24d27e'}
		                    ]
		                 )
		            },
		            emphasis: {
		              color: new echarts.graphic.LinearGradient(
		                    0, 0, 0, 1,
		                   [
		                	   {offset: 1, color: '#2fdea6'},   
		                        {offset: 0, color: '#24d27e'}
		                   ]
		              )
		             }
		         }
		     }
		],
		});
		
		//echart图表自适应
        window.addEventListener("resize", function () {
        	myFileChart.resize();
        });
		
		myFileChart.showLoading(); //数据加载完之前先显示一段简单的loading动画
		var month = [];
		var orderNumber = [];
		var dataplantIncome = [];
		for (var i = 0; i < result.length; i++) {
			month.push(result[i].month + '月');
			orderNumber.push(result[i].totalNumber);//挨个取出类别并填入类别数组
			dataplantIncome.push(result[i].totalIncome);
		}
		myFileChart.hideLoading(); //隐藏加载动画
		myFileChart.setOption({ //加载数据图表
			xAxis : {
				data : month,
			},
			series : [ {
				name : '成功订购数（万）',
				data : orderNumber
			}, {
				name : '流量包总收入（万）',
				data : dataplantIncome
			} ]
		});

	}

	function chartScene1(result) {
		var myFileChart1 = echarts.init(document.getElementById('chart'));
		myFileChart1.clear();
		// 显示标题，图例和空的坐标轴
		myFileChart1.setOption({
			title : {
				text : '当月产品订购量'
			},
			tooltip : {
				trigger : 'axis',//触发类型：坐标轴触发，隐藏属性为：none
				backgroundColor:'rgba(86,105,161,0.9)',//通过设置rgba调节背景颜色与透明度
				axisPointer : { 
				},
				extraCssText : ''
		    },
		    grid: {
		        left:60,
		        right: 60,
		    },
			legend: {
		         x:'right',
		         itemWidth: 10,
		            itemHeight: 10,
		            data : [ '成功订购数（万）'],
		            itemGap: 20,
		            textStyle: {
		             fontSize:12,
		             color:'#768297',
		             padding: [5,40,5,0],
		         }
		        },
			toolbox: {
		           feature: {
		               saveAsImage: {}
		           }
		       },
			xAxis : {
				//	       	 name: '日期',
				type : 'category',
				data : [],
				axisPointer : {
					type : 'shadow'
				},
				axisLabel : {
					interval : 0,
					rotate : -30
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
			yAxis : {
				type : 'value',
				axisLabel : {
					formatter : '{value}'
				},
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
			series : [
			          //柱一
			            {
			            	name : '成功订购数（万）',
							type : 'bar',
							barMaxWidth: '10',
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
			                    	{offset: 1, color: '#2fdea6'},   
			                        {offset: 0, color: '#24d27e'}  
			                     
			                    ]
			                 )
			            },
			            emphasis: {
			              color: new echarts.graphic.LinearGradient(
			                    0, 0, 0, 1,
			                   [
			                	   {offset: 1, color: '#2fdea6'},   
			                        {offset: 0, color: '#24d27e'}
			                   ]
			              )
			             }
			         }
			     },
			 
		],
		});
		myFileChart1.showLoading(); //数据加载完之前先显示一段简单的loading动画
		var province = [];
		var orderNumber = [];

		for (var i = 0; i < result.length; i++) {
			province.push(result[i].orgName);
			orderNumber.push(result[i].orderNumber);//挨个取出类别并填入类别数组
		}
		myFileChart1.hideLoading(); //隐藏加载动画
		myFileChart1.setOption({ //加载数据图表
			xAxis : {
				data : province
			},
			series : [ {
				name : '成功订购数(万)',
				data : orderNumber
			} ],
			
		});

	}
	function chartScene2(result){
		var myFileChart2 = echarts.init(document.getElementById('chart'));
		myFileChart2.clear();
		// 显示标题，图例和空的坐标轴
	    myFileChart2.setOption({
	        title: {
	            text: '当月流量包订购收入'
	        },
	        tooltip : {
				trigger : 'axis',//触发类型：坐标轴触发，隐藏属性为：none
				backgroundColor:'rgba(86,105,161,0.9)',//通过设置rgba调节背景颜色与透明度
				axisPointer : { 
				},
				extraCssText : ''
		    },
		    grid: {
		        left:60,
		        right: 60,
		    },
	        legend: {
		         x:'right',
		         itemWidth: 10,
		            itemHeight: 10,
		            data : [ '流量包总收入（万）' ],
		            itemGap: 20,
		            textStyle: {
		             fontSize:12,
		             color:'#768297',
		             padding: [5,40,5,0],
		         }
		        },
	        toolbox: {
		           feature: {
		               saveAsImage: {}
		           }
		       },
	        xAxis: {
//	       	 name: '日期',
	      	 type : 'category',
	           data: [],
	           axisLabel:{
	        	   interval:0,
	              rotate:-30
	           },
	           axisPointer: {
	               type: 'shadow'
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
	       yAxis: {
	      	 	type : 'value',
	      	 	axisLabel: {
	            formatter: '{value}'
	        	},
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
	       series : [
			     //柱二
			     {
			    	    name : '流量包总收入（万）',
						type : 'bar',
						barMaxWidth: '10',
		                label: {
			                normal: {
			                    show: true,
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
		                    	{offset: 1, color: '#2fdea6'},   
		                        {offset: 0, color: '#24d27e'}
		                    ]
		                 )
		            },
		            emphasis: {
		              color: new echarts.graphic.LinearGradient(
		                    0, 0, 0, 1,
		                   [
		                	   {offset: 1, color: '#2fdea6'},   
		                        {offset: 0, color: '#24d27e'}
		                   ]
		              )
		             }
		         }
		     }
		],
	   });
	    myFileChart2.showLoading();
	    var province=[];      
	    var dataplantIncome=[];  
	   
	                   for(var i=0;i<result.length;i++){       
	                	   province.push(result[i].orgName); 
	                	   dataplantIncome.push(result[i].dataplantIncome);
	                   }
	                   myFileChart2.hideLoading();
	                   myFileChart2.setOption({        //加载数据图表
	                       xAxis: {
	                           data: province,
	                       },
	                       series: [{
	                           name: '流量包总收入(万)',
	                           data: dataplantIncome
	                       }]
	                   });
	                   
	         
	}
	function chartIncomeRate(result){
		var myFileChart = echarts.init(document.getElementById('chart'));
		myFileChart.clear();
		// 显示标题，图例和空的坐标轴
	    myFileChart.setOption({
	        title: {
	            text: '占移动业务出账收入比'
	        },
	        tooltip : {
				trigger : 'axis',//触发类型：坐标轴触发，隐藏属性为：none
				backgroundColor:'rgba(86,105,161,0.9)',//通过设置rgba调节背景颜色与透明度
				axisPointer : { 
				},
				extraCssText : ''
		    },
		    grid: {
		        left:60,
		        right: 60,
		    },
	        legend: {
		         x:'right',
		         itemWidth: 10,
		            itemHeight: 10,
		            data : [ '收入比(%)' ],
		            itemGap: 20,
		            textStyle: {
		             fontSize:12,
		             color:'#768297',
		             padding: [5,40,5,0],
		         }
		        },
	        toolbox: {
		           feature: {
		               saveAsImage: {}
		           }
		       },
	        xAxis: {
//	       	 name: '日期',
	      	 type : 'category',
	           data: [],
	           axisLabel:{
	        	   interval:0,
	              rotate:-30
	           },
	           axisPointer: {
	               type: 'shadow'
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
	       yAxis: {
	      	 	type : 'value',
	      	 	axisLabel: {
	            formatter: '{value}'
	        	},
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
	       series: [{
	           name: '收入比(%)',
	           type: 'line',
	           data: []
	       }]
	   });
	    myFileChart.showLoading();    //数据加载完之前先显示一段简单的loading动画
	    var province=[];    
	    var rate=[];    
	    
	                   for(var i=0;i<result.length;i++){       
	                	   province.push(result[i].provinceName); 
	                	   rate.push(result[i].rate);//挨个取出类别并填入类别数组
	                   }
	                   myFileChart.hideLoading();    //隐藏加载动画
	                   myFileChart.setOption({        //加载数据图表
	                       xAxis: {
	                           data: province,
	                       },
	                       series: [{
	                           name: '收入比(%)',
	                           data: rate
	                       }]
	                   });
	                   
	        
	}
	function chartType(result){
		var myFileChart = echarts.init(document.getElementById('chart'));
		myFileChart.clear();
		// 显示标题，图例和空的坐标轴
	    myFileChart.setOption({
	        title: {
	            text: '场景应用情况'
	        },
	        tooltip : {
				trigger : 'axis',//触发类型：坐标轴触发，隐藏属性为：none
				backgroundColor:'rgba(86,105,161,0.9)',//通过设置rgba调节背景颜色与透明度
				axisPointer : { 
				},
				extraCssText : ''
		    },
		    grid: {
		        left:60,
		        right: 60,
		    },
	        legend: {
		         x:'right',
		         itemWidth: 10,
		            itemHeight: 10,
		            data:['总部场景','省分场景'],
		            itemGap: 20,
		            textStyle: {
		             fontSize:12,
		             color:'#768297',
		             padding: [5,40,5,0],
		         }
		        },
	        toolbox: {
		           feature: {
		               saveAsImage: {}
		           }
		       },
	        xAxis: {
//	       	 name: '日期',
	      	 type : 'category',
	           data: [],
	           axisLabel:{
	        	   interval:0,
	              rotate:-30
	           },
	           axisPointer: {
	               type: 'shadow'
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
	       yAxis: {
	      	 	type : 'value',
	      	 	axisLabel: {
	            formatter: '{value}'
	        	},
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
	       series : [
			          //柱一
			            {
			            	name: '总部场景',
			 	           type: 'bar',
							barMaxWidth: '10',
			                color:'#fff',
			                label: {
				                normal: {
				                    show: true,
				                    position: 'top',
				                    color:'fff',  
				                }
				            },
			                itemStyle: {
			                	emphasis: {
		                            barBorderRadius:[0, 0, 0, 0],
		                        },
			                  normal: {
			                	  barBorderRadius:[0, 0, 0, 0],
			                    color: new echarts.graphic.LinearGradient(
			                      0, 0, 0, 1,
			                    [
			                    	{offset: 1, color: '#2fdea6'},   
			                        {offset: 0, color: '#24d27e'}
			                     
			                    ]
			                 )
			            },
			            emphasis: {
			              color: new echarts.graphic.LinearGradient(
			                    0, 0, 0, 1,
			                   [
                                {offset: 0, color: '#00f2fe'},
                                {offset: 1, color: '#4facfe'}, 
			                   ]
			              )
			             }
			         }
			     },
			     //柱二
			     {
			    	 name: '省分场景',
			           type: 'bar',
						barMaxWidth: '10',
		                label: {
			                normal: {
			                    show: true,
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
		         }
		     }
		],
	   });
	    myFileChart.showLoading();    //数据加载完之前先显示一段简单的loading动画
	    var province=[];    
	    var hq=[];    
	    var branch=[];  
	   
	                   for(var i=0;i<result.length;i++){       
	                	   province.push(result[i].provinceName); 
	                	   hq.push(result[i].hq);//挨个取出类别并填入类别数组
	                	   branch.push(result[i].branch);
	                   }
	                   myFileChart.hideLoading();    //隐藏加载动画
	                   myFileChart.setOption({        //加载数据图表
	                       xAxis: {
	                           data: province,
	                       },
	                       series: [{
	                           name: '总部场景',
	                           stack: '场景',
	                           data: hq
	                       },
	                       {
	                           name: '省分场景',
	                           stack: '场景',
	                           data: branch
	                       }]
	                   });
	                   
	            
	}
	function chartPie(result){
		var myFileChart1 = echarts.init(document.getElementById('chart'));
		myFileChart1.clear();
		myFileChart1.setOption({
	        title: {
	            text: '用户触达数(万)'
	        },
	        tooltip : {
				trigger : 'axis',//触发类型：坐标轴触发，隐藏属性为：none
				backgroundColor:'rgba(86,105,161,0.9)',//通过设置rgba调节背景颜色与透明度
				axisPointer : { 
				},
				extraCssText : ''
		    },
		    grid: {
		        left:60,
		        right: 60,
		    },
	        legend: {
	        	orient: 'vertical',
		         x:'right',
		         itemWidth: 10,
		            itemHeight: 10,
		            data:['总部场景','省分场景'],
		            itemGap: 20,
		            textStyle: {
		             fontSize:12,
		             color:'#768297',
		             padding: [5,20,5,0],
		         }
		        },
	       series: [{
	           name: '触达用户数(万)',
	           type: 'pie',
	           radius : '55%',
	           center: ['50%', '65%'],
	           data:[],
	           itemStyle: {
	               emphasis: {
	                   shadowBlur: 10,
	                   shadowOffsetX: 0,
	                   shadowColor: 'rgba(0, 0, 0, 0.5)'
	               }
	           },
	           label: {
	        	      normal: {
	           	          show: true,
	           	          formatter: '{b}: \n {c}({d}%)'
	           	      }
	           }
	       }],
	       color:['#a7dbda','#c6e8d5','#dfd3ad','#dfa665','#f8bf6c']
	   });
	    myFileChart1.showLoading();    //数据加载完之前先显示一段简单的loading动画
	    var categoryName=[];
	    var pie1=[]; 
	    for(var i=0;i<result.length;i++){
	    	if(result[i].categoryName=="流量包营销（日包、多日包、定向包）"){
				var category="流量包营销";
			}else{
				category=result[i].categoryName;
			}
	    	categoryName.push(category);
	    	pie1.push({"value":result[i].reachNumber,"name":category});
	    }
	    myFileChart1.hideLoading();    //隐藏加载动画
        myFileChart1.setOption({        //加载数据图表
        	legend: {
                data: categoryName
            },
            series: [{
                name: '触达用户数(万)',
                data: pie1
            }]
        });
	}
	
	function chartPie2(result){
		var myFileChart2 = echarts.init(document.getElementById('chart'));
		myFileChart2.clear();
		
	    myFileChart2.setOption({
	        title: {
	            text: '成功订购数(万)'
	        },
	        tooltip : {
				trigger : 'axis',//触发类型：坐标轴触发，隐藏属性为：none
				backgroundColor:'rgba(86,105,161,0.9)',//通过设置rgba调节背景颜色与透明度
				axisPointer : { 
				},
				extraCssText : ''
		    },
	       legend: {
	        	orient: 'vertical',
		         x:'right',
		         itemWidth: 10,
		            itemHeight: 10,
		            data:['总部场景','省分场景'],
		            itemGap: 20,
		            textStyle: {
		             fontSize:12,
		             color:'#768297',
		             padding: [5,20,5,0],
		         }
		        },
	       series: [{
	           name: '成功订购数(万)',
	           type: 'pie',
	           radius : '55%',
	           center: ['50%', '65%'],
	           data:[],
	           itemStyle: {
	               emphasis: {
	                   shadowBlur: 10,
	                   shadowOffsetX: 0,
	                   shadowColor: 'rgba(0, 0, 0, 0.5)'
	               }
	           },
	           label: {
	        	      normal: {
	           	          show: true,
	           	          formatter: '{b}: \n {c}({d}%)'
	           	      }
	           }
	       }],
	       color:['#a7dbda','#c6e8d5','#dfd3ad','#dfa665','#f8bf6c']
	   });
	    myFileChart2.showLoading();
	    var categoryName=[]; 
	    var pie2=[]; 
	    for(var i=0;i<result.length;i++){
	    	if(result[i].categoryName=="流量包营销（日包、多日包、定向包）"){
				var category="流量包营销";
			}else{
				category=result[i].categoryName;
			}
	    	categoryName.push(category);
			pie2.push({"value":result[i].orderNumber,"name":category});
	    }
        myFileChart2.hideLoading();    //隐藏加载动画
        myFileChart2.setOption({        //加载数据图表
        	legend: {
                data: categoryName
            },
            series: [{
                name: '成功订购数(万)',
                data: pie2
            }]
        });
	}
	
	var rootPath = '<%=basePath1%>';
	function exportExcel(){
		var year = $("#year").val();
		var month = $("#month").val();
		window.location.href=rootPath +"report/exportChart.do?category=0&year="+year+"&month="+month;
	}
</script>

</head>
<body style="width:100%;height:100%;overflow:auto">

<div class="u-body">
	<div class="u-title">
		<span>本期业务总体运营情况</span>
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
			<div class="search">
			     <label class="name" for="">年份：</label>
			     <input type="text" class="u-input-text search-box box-input" name="year" id="year" value="${Year}">
			</div>
			<div class="search">
			     <label class="name" for="">月份：</label>
			     <input type="text" class="u-input-text search-box box-input" name="month" id="month" value="${Month}">
			</div>
		</div>
		<div class="z-search z-top">
			<div class="search">
				<label class="name" for="">产品：</label>
				<select class="u-input-text search-box" name="product" id="product">
					<option value="0">请选择</option>
					<option value="1">业务订购总量和流量包总收入</option>
					<option value="2">当月产品订购量</option>
					<option value="3">当月流量包订购收入</option>
					<option value="4">占移动业务出账收入比</option>
					<option value="5">场景应用情况</option>
					<option value="6">用户触达数</option>
					<option value="7">成功订购数</option>
				</select>
			</div>
			<div class="search">
				<label class="name" for="">省分：</label>
				<select class="u-input-text search-box" name="province" id="province">
					<option value="001">全部</option>
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
		</div>
		<form id="searchForm">
			<div class="button-box-h">
			      <a  class="button chaxun" onclick="getTotalReport();">查询</a>
			      <c:if test="${orgCode == '001'}">
			      <a  class="button daochu" onclick="exportExcel()">导出</a>
			      </c:if>
			</div>
		</form>
	</div>
	<div class="data" id="chart"></div>
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