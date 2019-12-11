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
	var categoryName = "";
	var orgCode="${orgCode}";
	$(document).ready(function() {
		document.getElementById("product").value = "1";
		document.getElementById("category").value = "1";
		if(orgCode=="001"){
			document.getElementById("province").value = orgCode;
		}else{
			document.getElementById("province").value = orgCode;
			$("#province").attr("disabled","disabled");
		}
		getMonthReport();
	});
	function getMonthReport() {
		var province = $("#province").val();
		var product = $("#product").val();
		var year = $("#year").val();
		var month = $("#month").val();
		var category=$("#category").val();
		var params = {"year":year,"month":month,"category":category,"orgCode":province};
		$.ajax({
			type : "post",
			async : true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
			url : "./report/toMonthReport.do",
			data: params,
			dataType : "json", //返回数据形式为json
			success : function(data) {
				//请求成功时执行该函数内容，result即为服务器返回的json对象
				if (data.flag) {
					titles = data.msg.split('#');
					categoryName = titles[0]
					$(".panel-header h4").html(categoryName + titles[2] + "业务运营情况");
					if(product=="1"){
						//当月XXX订购量（万次）
						var monthOrderNumberRank = data.result.monthOrderNumberRank;
						chartScene1(monthOrderNumberRank);
					}else if(product=="2"){
						//全国各月XXX订购量（万次）
						var monthOrderNumberList= data.result.monthOrder;
						lineOderNumber(monthOrderNumberList,'全国各月' + categoryName + '订购量(万次)','monthOrderNumber')
					}else if(product=="3"){
						//全国各月XXX订购收入（万）
						var monthOrderIncomeList= data.result.monthIncome;
						if(!(monthOrderIncomeList === null) && monthOrderIncomeList.length > 0){//如果有收入
							lineOderNumber(monthOrderIncomeList,'全国各月' + categoryName + '订购收入(万)','monthOrderIncome')
						}
					}else if(product=="4"){
						//全国XXX累计订购量（万次）
						var totalOrderNumberList= data.result.totalOrder;
						barTotalOrderNumber(totalOrderNumberList,'全国' + categoryName + titles[1] + '-' + titles[2] + '累计订购量(万次)','totalOrderNumber','累计订购量(万次))')
						
					}else if(product=="5"){
						//全国XXX累计订购收入（万）
						var totalOrderIncomeList= data.result.totalIncome;
						if(!(totalOrderIncomeList === null) && totalOrderIncomeList.length > 0){//如果有收入
							barTotalOrderNumber(totalOrderIncomeList,'全国' + categoryName + titles[1] + '-' + titles[2] + '累计订购收入(万)','totalOrderIncome','累计订购收入(万))')
						}
					}else if(product=="6"){
						//全国三个月订购量变化情况
						var threeOrderNumberList = data.result.threeOrder;
						lineThreeOderNumber(threeOrderNumberList,titles[3],titles[4],titles[2])
						
					}else if(product=="7"){
						//该分类触达用户数增长量
						var list1 = data.result.list1;
						chartList(list1,1);
					}else if(product=="8"){
						//该分类成功订购量增长量
						var list2 = data.result.list2;
						chartList(list2,2);
					}else if(product=="9"){
						//该分类收入增长量
						var list3 = data.result.list3;
						chartList(list3,3);
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

	function chartScene1(result) {
		var myFileChart1 = echarts.init(document.getElementById('chart'));
		myFileChart1.clear();
		// 显示标题，图例和空的坐标轴
		myFileChart1.setOption({
			title : {
				text : '当月' + categoryName + '订购量(万次)'
			},
			tooltip : {
				trigger : 'axis',//触发类型：坐标轴触发，隐藏属性为：none
				backgroundColor:'rgba(86,105,161,0.9)',//通过设置rgba调节背景颜色与透明度
				axisPointer : { 
				},
				extraCssText : ''
		    },
			grid: {
		        left: 40,
		        right: 10,
		        top: 65,
		        bottom: 50,
		    },
			legend: {
		         x:'right',
		         itemWidth: 10,
		            itemHeight: 10,
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
					     //柱二
					     {
					    	    name : '成功订购数（万次）',
								type : 'bar',
								barMaxWidth:10,//最大宽度
					            barMinWidth:2,//最小宽度
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
		
		//echart图表自适应
        window.addEventListener("resize", function () {
        	myFileChart1.resize();
        });
		
		myFileChart1.showLoading(); //数据加载完之前先显示一段简单的loading动画
		var province = [];
		var orderNumber = [];

		for (var i = 0; i < result.length; i++) {
			province.push(result[i].province_name);
			orderNumber.push(result[i].sumnumber);//挨个取出类别并填入类别数组
		}
		myFileChart1.hideLoading(); //隐藏加载动画
		myFileChart1.setOption({ //加载数据图表
			xAxis : {
				data : province
			},
			series : [ {
				name : '成功订购数(万次)',
				data : orderNumber
			} ]
		});

	}

	function lineOderNumber(result,title,divid){
		var myFileChart = echarts.init(document.getElementById('chart'));
		myFileChart.clear();
		// 显示标题，图例和空的坐标轴
	    myFileChart.setOption({
	        title: {
	            text: title
	        },
	        color:['#90ff37','#ff3737','#0066ff'],
	        tooltip : {
				trigger : 'axis',//触发类型：坐标轴触发，隐藏属性为：none
				backgroundColor:'rgba(86,105,161,0.9)',//通过设置rgba调节背景颜色与透明度
				axisPointer : { 
				},
				extraCssText : ''
		    },
	       toolbox: {
	           feature: {
	               saveAsImage: {}
	           }
	       },
	       grid: {
		        left: 40,
		        right: 10,
		        top: 65,
		        bottom: 50,
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
	    	  
	    	   label: {
	                normal: {
	                    show: true,
	                    position: 'top'
	                }
	            },
	           type: 'line',
	           showAllSymbol: true,
	           data: []
	       }]
	   });
	  //echart图表自适应
        window.addEventListener("resize", function () {
        	myFileChart.resize();
        });
	    myFileChart.showLoading();    //数据加载完之前先显示一段简单的loading动画
	    var xname=[];    
	    var ydata=[];    
	    
	                   for(var i=0;i<result.length;i++){       
	                	   xname.push(result[i].month+"月"); 
	                	   ydata.push(result[i].sumNumber);//挨个取出类别并填入类别数组
	                   }
	                   myFileChart.hideLoading();    //隐藏加载动画
	                   myFileChart.setOption({        //加载数据图表
	                       xAxis: {
	                           data: xname,
	                       },
	                       series: [{
	                           data: ydata
	                       }]
	                   });
	                   
	        
	}
	function barTotalOrderNumber(result,title,divid,seriesName) {
		var myFileChart2 = echarts.init(document.getElementById('chart'));
		myFileChart2.clear();
		// 显示标题，图例和空的坐标轴
		myFileChart2.setOption({
			title : {
				text : title
			},
			tooltip : {
				trigger : 'axis',//触发类型：坐标轴触发，隐藏属性为：none
				backgroundColor:'rgba(86,105,161,0.9)',//通过设置rgba调节背景颜色与透明度
				axisPointer : { 
				},
				extraCssText : ''
		    },
			toolbox: {
		           feature: {
		               saveAsImage: {}
		           }
		       },
		       grid: {
			        left: 40,
			        right: 10,
			        top: 65,
			        bottom: 50,
			    },
		       legend: {
			         x:'right',
			         itemWidth: 10,
			            itemHeight: 10,
			            itemGap: 20,
			            textStyle: {
			             fontSize:12,
			             color:'#768297',
			             padding: [5,40,5,0],
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
					     //柱二
					     {
								type : 'bar',
								barMaxWidth:10,//最大宽度
					            barMinWidth:2,//最小宽度
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
		//echart图表自适应
        window.addEventListener("resize", function () {
        	myFileChart2.resize();
        });
		
		myFileChart2.showLoading(); //数据加载完之前先显示一段简单的loading动画
		var province = [];
		var orderNumber = [];

		for (var i = 0; i < result.length; i++) {
			province.push(result[i].province_name);
			orderNumber.push(result[i].order_number);//挨个取出类别并填入类别数组
		}
		myFileChart2.hideLoading(); //隐藏加载动画
		myFileChart2.setOption({ //加载数据图表
			xAxis : {
				data : province
			},
			series : [ {
				name : seriesName,
				data : orderNumber
			} ]
		});

	}
	function lineThreeOderNumber(result,time1,time2,time3){
		var myFileChart = echarts.init(document.getElementById("chart"));
		myFileChart.clear();
		// 显示标题，图例和空的坐标轴
	    myFileChart.setOption({
	        title: {
	            text: '各省最近三个月' + categoryName + '订购量变化情况'
	        },
	        tooltip : {
				trigger : 'axis',//触发类型：坐标轴触发，隐藏属性为：none
				backgroundColor:'rgba(86,105,161,0.9)',//通过设置rgba调节背景颜色与透明度
				axisPointer : { 
				},
				extraCssText : ''
		    },
	       legend: {
	           data:[time1,time2,time3]
	       },
	       grid: {
		        left: 40,
		        right: 10,
		        top: 65,
		        bottom: 50,
		    },
	       toolbox: {
	           feature: {
	               saveAsImage: {}
	           }
	       },
	        xAxis: {
	      	 type : 'category',
	         data: [],
	         boundaryGap: false ,
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
	       yAxis: {
	      	 	type : 'value',
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
	   });
	  //echart图表自适应
        window.addEventListener("resize", function () {
        	myFileChart.resize();
        });
	    myFileChart.showLoading();    //数据加载完之前先显示一段简单的loading动画
	    var xname=[];    
	    var data1=[]; 
	    var data2=[]; 
	    var data3=[]; 
	    
	                   for(var i=0;i<result.length;i++){       
	                	   xname.push(result[i].province_name); 
	                	   data1.push(result[i].c1);//挨个取出类别并填入类别数组
	                	   data2.push(result[i].c2)
	                	   data3.push(result[i].c3)
	                   }
	                   myFileChart.hideLoading();    //隐藏加载动画
	                   myFileChart.setOption({        //加载数据图表
	                       xAxis: {
	                           data: xname,
	                       },
	                       color:['#90ff37','#ff3737','#0066ff'],
	                       legend: {
	          		         x:'right',
	          		         itemWidth: 10,
	          		            itemHeight: 10,
	          		            itemGap: 20,
	          		            textStyle: {
	          		             fontSize:12,
	          		             color:'#768297',
	          		             padding: [5,40,5,0],
	          		         }
	          		        },
	          		      grid: {
	          		        left: 40,
	          		        right: 10,
	          		        top: 65,
	          		        bottom: 50,
	          		    },
	                       series: [
	                    	   {
	                    		   name: time1,
	                    		   type:'line',
	                    		   data: data1
	                    	   },
	                    	   {
	                    		   name: time2,
	                    		   type:'line',
	                    		   data: data2
	                    	   },
	                    	   {
	                    		   name: time3,
	                    		   type:'line',
	                    		   data: data3
	                    	   },
	                       ]
	                   });
	                   
	        
	}
	function chartList(list,caseNumber){
		var myFileChart=null;
		var title=null;
		switch(caseNumber){
			case 1:
				title = '触达用户数环比增幅(万)'
				myFileChart = echarts.init(document.getElementById('chart'));
				break;
			case 2:
				title = '成功订购量环比增幅(万)'
				myFileChart = echarts.init(document.getElementById('chart'));
				break;
			case 3:
				title = '流量包收入环比增幅(万)'
				myFileChart = echarts.init(document.getElementById('chart'));
				break;
		}
		myFileChart.clear();
		myFileChart.setOption({
	        title: {
	            text: title
	        },
	        tooltip : {
				trigger : 'axis',//触发类型：坐标轴触发，隐藏属性为：none
				backgroundColor:'rgba(86,105,161,0.9)',//通过设置rgba调节背景颜色与透明度
				axisPointer : { 
				},
				extraCssText : ''
		    },
		    
			legend: {
 		         x:'right',
 		         itemWidth: 10,
 		            itemHeight: 10,
 		            itemGap: 20,
 		            textStyle: {
 		             fontSize:12,
 		             color:'#768297',
 		             padding: [5,40,5,0],
 		         }
 		        },
 		       grid: {
 			        left: 40,
 			        right: 10,
 			        top: 65,
 			        bottom: 50,
 			    },
		       toolbox: {
		           feature: {
		               saveAsImage: {}
		           }
		       },
	        xAxis: {
	      	 type : 'category',
	           data: [],
	           axisLabel:{
	        	   interval:0,
					rotate : -30
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
				    	    name :title,
							type : 'bar',
							barMaxWidth:10,//最大宽度
				            barMinWidth:2,//最小宽度
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
		var province=[]; 
		var numberList=[];
		if(list){
			for(var i=0;i<list.length;i++){
				switch(caseNumber){
				case 1:
					province.push(list[i].provinceName);
					numberList.push(list[i].reachNumberAdd);
					break;
				case 2:
					province.push(list[i].provinceName);
					numberList.push(list[i].orderNumberAdd);
					break;
				case 3:
					province.push(list[i].provinceName);
					numberList.push(list[i].dataplantIncomeAdd);
					break;
				}
			}
		}
		myFileChart.hideLoading();    //隐藏加载动画
        myFileChart.setOption({        //加载数据图表
            xAxis: {
                data: province
            },
            series: [{
                name: title,
                data: numberList
            }]
        });
	}
	var rootPath = '<%=basePath1%>';
	function exportExcel(){
		var year = $("#year").val();
		var month = $("#month").val();
		var categoryId = $("#category").val();
		window.location.href=rootPath +"report/exportChart.do?category="+categoryId+"&year="+year+"&month="+month;
	}
	function changeProduct(){
		var obj=document.getElementById('product');
		obj.options.length=0;
		var categoryId = $("#category").val();
		if(categoryId=="1"){
			obj.options.add(new Option("请选择","0")); 
			obj.options.add(new Option("当月流量包营销(日包、多日包、定向包)订购量(万次)","1")); 
			obj.options.add(new Option("全国各月流量包营销(日包、多日包、定向包)订购量(万次)","2")); 
			obj.options.add(new Option("全国各月流量包营销(日包、多日包、定向包)订购收入(万)","3")); 
			obj.options.add(new Option("全国流量包营销(日包、多日包、定向包)一年内累计订购量(万次)","4")); 
			obj.options.add(new Option("全国流量包营销(日包、多日包、定向包)一年内累计订购收入(万)","5")); 
			obj.options.add(new Option("各省最近三个月流量包营销(日包、多日包、定向包)订购量变化情况","6")); 
			obj.options.add(new Option("触达用户数环比增幅","7")); 
			obj.options.add(new Option("成功订购数环比增幅","8")); 
			obj.options.add(new Option("流量包收入环比增幅","9")); 
			document.getElementById("product").value = "1";
		}else if(categoryId=="2"){
			obj.options.add(new Option("请选择","0")); 
			obj.options.add(new Option("当月畅越计划订购量(万次)","1")); 
			obj.options.add(new Option("全国各月畅越计划订购量(万次)","2")); 
			obj.options.add(new Option("全国畅越计划一年内累计订购量(万次)","4")); 
			obj.options.add(new Option("各省最近三个月畅越计划订购量变化情况","6")); 
			obj.options.add(new Option("触达用户数环比增幅","7")); 
			obj.options.add(new Option("成功订购数环比增幅","8")); 
			document.getElementById("product").value = "1";
		}else if(categoryId=="3"){
			obj.options.add(new Option("请选择","0")); 
			obj.options.add(new Option("当月畅视订购量(万次)","1")); 
			obj.options.add(new Option("全国各月畅视订购量(万次)","2")); 
			obj.options.add(new Option("全国畅视一年内累计订购量(万次)","4")); 
			obj.options.add(new Option("各省最近三个月畅视订购量变化情况","6")); 
			document.getElementById("product").value = "1";
		}else if(categoryId=="4"){
			obj.options.add(new Option("请选择","0")); 
			obj.options.add(new Option("当月合约续约订购量(万次)","1")); 
			obj.options.add(new Option("全国各月合约续约订购量(万次)","2")); 
			obj.options.add(new Option("全国合约续约一年内累计订购量(万次)","4")); 
			obj.options.add(new Option("各省最近三个月合约续约订购量变化情况","6")); 
			obj.options.add(new Option("触达用户数环比增幅","7")); 
			obj.options.add(new Option("成功订购数环比增幅","8")); 
			document.getElementById("product").value = "1";
		}else if(categoryId=="5"){
			obj.options.add(new Option("请选择","0")); 
			obj.options.add(new Option("当月终端更换订购量(万次)","1")); 
			obj.options.add(new Option("全国各月终端更换订购量(万次)","2")); 
			obj.options.add(new Option("全国终端更换一年内累计订购量(万次)","4")); 
			obj.options.add(new Option("各省最近三个月终端更换订购量变化情况","6")); 
			obj.options.add(new Option("触达用户数环比增幅","7")); 
			obj.options.add(new Option("成功订购数环比增幅","8")); 
			document.getElementById("product").value = "1";
		}
	}
</script>

</head>
<body style="width:100%;height:100%;overflow:auto">

<div class="u-body">
	<div class="u-title">
		<span>业务运营情况</span>
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
				<label class="name" for="">分类：</label>
				<select class="u-input-text search-box" name="category" id="category" onChange="changeProduct();">
					<option value="1">流量包营销（日包、多日包、定向包）</option>
					<option value="2">畅越计划</option>
					<option value="3">畅视</option>
					<option value="4">合约续约</option>
					<option value="5">终端更换</option>
				</select>
		    </div>
			<div class="search">
				<label class="name" for="">产品：</label>
				<select class="u-input-text search-box" name="product" id="product">
					<option value="0">请选择</option>
					<option value="1">当月${categoryName}订购量(万次)</option>
					<option value="2">全国各月${categoryName}订购量(万次)</option>
					<option value="3">全国各月${categoryName}订购收入(万)</option>
					<option value="4">全国${categoryName}一年内累计订购量(万次)</option>
					<option value="5">全国${categoryName}一年内累计订购收入(万)</option>
					<option value="6">各省最近三个月${categoryName}订购量变化情况</option>
					<option value="7">触达用户数环比增幅</option>
					<option value="8">成功订购数环比增幅</option>
					<option value="9">流量包收入环比增幅</option>
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
			      <a  class="button chaxun" onclick="getMonthReport();">查询</a>
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