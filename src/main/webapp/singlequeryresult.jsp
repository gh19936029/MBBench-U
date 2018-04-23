<%@page import="java.io.File"%>
<%@ page import="cn.ruc.edu.basecore.QueryFileName" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="utf-8" />
	<link rel="apple-touch-icon" sizes="76x76" href="img/apple-icon.png">
	<link rel="icon" type="image/png" sizes="96x96" href="img/favicon.png">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title>查询信息</title>

	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />


    <!-- Bootstrap core CSS     -->
    <link href="css/bootstrap.min.css" rel="stylesheet" />

    <!-- Animation library for notifications   -->
    <link href="css/animate.min.css" rel="stylesheet"/>

    <!--  Paper Dashboard core CSS    -->
    <link href="css/paper-dashboard.css" rel="stylesheet"/>


    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="css/demo.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/flavr.css" />
    <link rel="stylesheet" href="css/style.css" />


    <!--  Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>
    <link href="css/themify-icons.css" rel="stylesheet">

</head>
<body>

<div class="wrapper">
    <div class="sidebar" data-background-color="white" data-active-color="danger">

    <!--
		Tip 1: you can change the color of the sidebar's background using: data-background-color="white | black"
		Tip 2: you can change the color of the active button using the data-active-color="primary | info | success | warning | danger"
	-->

    	<div class="sidebar-wrapper">
            <div class="logo">
                <a href="#" class="simple-text">
                    	MBBench-U
                </a>
            </div>

            <ul class="nav">
                <li>
                    <a href="sysinfo.html">
                        <i class="ti-panel"></i>
                        <p>系统说明</p>
                    </a>
                </li>
                <li>
                	<a href="mbnewdatagen.jsp">
                		<i class="ti-files"></i>
                  		<p>海量文件生成</p>
              		</a>
              	</li>
                <li>
                    <a href="dbconnect.jsp">
                        <i class="ti-view-list-alt"></i>
                        <p>数据库连接</p>
                    </a>
                </li>
                <li>
                    <a href="translationworkload.jsp">
                        <i class="ti-text"></i>
                        <p>数据上传负载测试</p>
                    </a>
                </li>
                <li>
                    <a href="transdownworkload.jsp">
                        <i class="ti-text"></i>
                        <p>数据下载负载测试</p>
                    </a>
                </li>
                <li>
                    <a href="queryworkloada.jsp">
                        <i class="ti-zoom-out"></i>
                        <p>简单查询负载测试</p>
                    </a>
                </li>
                <li>
                    <a href="queryworkloadb.jsp">
                        <i class="ti-zoom-in"></i>
                        <p>复杂查询负载测试</p>
                    </a>
                </li>
                <li class="active">
                    <a href="resultshow.jsp">
                        <i class="ti-map"></i>
                        <p>结果查看</p>
                    </a>
                </li>
                <li>
                    <a href="help.html">
                        <i class="ti-help"></i>
                        <p>帮助文档</p>
                    </a>
                </li>
				<li class="active-pro">
                    <a href="linkme.html">
                        <i class="ti-export"></i>
                        <p>联系我们</p>
                    </a>
                </li>
            </ul>
    	</div>
    </div>
    <div class="copyrights">版权属于 <a href="http://info.ruc.edu.cn/"  title="中国人民大学">中国人民大学信息学院</a></div>

	<div class="main-panel">
		<nav class="navbar navbar-default">
			<div class="container-fluid">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar bar1"></span>
						<span class="icon-bar bar2"></span>
						<span class="icon-bar bar3"></span>
					</button>
					<a class="navbar-brand" href="#">简单查询负载结果</a>
				</div>
				<div class="collapse navbar-collapse">
					<ul class="nav navbar-nav navbar-right">
						<li>
							<a href="pcinfo.jsp" class="dropdown-toggle">
								<i class="ti-panel"></i>
								<p>基本信息</p>
							</a>
						</li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">
								<i class="ti-bell"></i>
								<p>负载结果</p>
								<b class="caret"></b>
							</a>
							<ul class="dropdown-menu">
								<li><a href="transresult.jsp">数据传输负载结果</a></li>
								<li><a href="singlequeryresult.jsp">简单查询负载结果</a></li>
								<li><a href="multiqueryresult.jsp">复杂查询负载结果</a></li>
							</ul>
						</li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">
								<i class="fa fa-list"></i>
								<p>查询测试版本</p>
								<b class="caret"></b>
							</a>

								<ul class="dropdown-menu" id="copychoose">
									<%
										int transcopy = 0;
										//
										String logpath = (String) session.getAttribute("logpath");
										String dbname = (String) session.getAttribute("databasetype");
										logpath = logpath + "/" + dbname;
										File ss = new File(logpath);
										if(!ss.exists() || ss.listFiles().length == 0){
									%>
									<script type="text/javascript">
                                        new $.flavr({
                                            content     : '没有检测到测试结果文件，请运行传输负载',
                                            buttons     : {
                                                primary : { text: '传输负载测试', style: 'primary',
                                                    action: function(){
                                                        $(location).attr('href', 'translationworkload.jsp');
                                                    }
                                                },
                                                close   : { text:'取消',style: 'default' }
                                            }
                                        });
									</script>
									<%}else{
										    File[] dbInfoFile = new File(logpath).listFiles();
										    int filecount = dbInfoFile.length;
										    String dbInfoName = "";
										    String fileName = "";
										    for(int i = 1; i <= filecount; i++){
                                                dbInfoName = dbInfoFile[i-1].getName();
									%>
									<li><a href="#"><%=dbInfoName %>数据库传输</a></li>
									<ul>
										<%

											File[] files = new File(logpath + "/" + dbInfoName).listFiles();
											for(File file : files){
												if(!file.isDirectory())
													continue;
												fileName = file.getName();
										%>
										<li value="<%=dbInfoName + ":" + fileName %>"><a href="javascript:void(0)" onclick="copychoose()" ><%=fileName %>查询</a></li>
										<%
											}
										%>
									</ul>
									<p id="copynum" style="display:none"><%=dbInfoName + ":" + fileName %></p>
									<%

											}
										}
									%>
								</ul>

						</li>
					</ul>
				</div>
			</div>
		</nav>

        <div class="content">
            <div class="container-fluid">
                <div class="card">
                            <div class="header">
                                <h4 class="title">单属性查询结果信息</h4> 
                            </div>
                            <div class="content table-responsive table-full-width">
                                <table class="table table-striped">                              	
                                    <thead>
                                        <th>编号</th>
                                    	<th>查询类型</th>
                                    	<th>查询条数[条]</th>
                                    	<th>查询速度[条/毫秒]</th>
                                    	<th>查询用时[毫秒]</th>                           
                                    </thead>
                                    <tbody>
                                        <tr>
                                        	<td>1</td>
                                        	<td><b>单一属性单个数值查询</b></br>查询属性：文件类型；查询值：Blade</td>
                                        	<td id="devicetype_count"></td>
                                        	<td id="devicetype_speed"></td>
                                        	<td id="devicetype_time"></td> 
                                        </tr>
                                        <tr>
                                        	<td>2</td>
                                        	<td><b>单一属性有限元数值查询</b></br>查询属性：塔架高度；查询值：数值为奇数</td>
                                        	<td id="towerhight_count"></td> 
                                        	<td id="towerhight_speed"></td> 
                                        	<td id="towerhight_time"></td> 
                                        </tr>
                                        <tr>
                                        	<td>3</td>
                                        	<td><b>单一属性范围数值查询</b></br>查询属性：仿真时间；查询值：<p id="sett"></p></td>
                                        	<td id="simulation_count"></td>
                                        	<td id="simulation_speed"></td>
                                        	<td id="simulation_time"></td>                             	
                                        </tr>                                        
                                    </tbody>
                                </table>
                            </div>
                             <div class="content">
                             	<input id="downloadresult" type="button" style="font-size: 18px;background: transparent;border: hidden;color: red;text-decoration: underline; float: left" value="数据下载结果查看" onclick="downloadresultf()"/>
                                 </dr/>
								 <input id="refleshquerya" type="button" style="font-size: 18px;background: transparent;border: hidden;color: red;text-decoration: underline; float: right" value="刷新信息" onclick="queryareflesh()"/>
								 </dr/>
                            	<br/>
                             </div>
                        </div>
                	<div id="dlresult" style="display: none;" class="row">
                	<div class="header">
                    	<h4 class="title">下载结果折线图</h4>
                    	<hr/>
                    	<h4 class="title"style="font-size:18px">查询1：单一属性单个数值查询</h4>
                    </div>
                    <div class="col-md-12">
						<div clas="row">
	                    	<div class="col-md-10">
	                    		<div class="nav-tabs-navigation">
			    					<div id="query1div" class="nav-tabs-wrapper">
			        					<ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
											<li value="100"><a  data-toggle="tab">100点</a></li>
			        						<li value="50"><a  data-toggle="tab">50点</a></li>
			            					<li value="20"><a href="#20sdownmeta" data-toggle="tab">20点</a></li>
			            					<li value="10"><a href="#10sdownmeta" data-toggle="tab">10点</a></li>
			            					<li value="5"><a href="#5sdownmeta" data-toggle="tab">5点</a></li>
			            					<li value="1"><a href="#1sdownmeta" data-toggle="tab">1点</a></li>
			        					</ul>
			    					</div>   						
								</div>
	                		</div>
	                		<div class="col-md-1">
	                   			<input type="button" value="显示动态折线图" class="text-right" id="query1active"/>
	                		</div>
						</div>
	    				<hr/>
	                	<div class="card">
	                    	<div class="g_12">
								<div class="widget_contents">
									<div class="realtime_charts" id="query1"></div>
								</div>
							</div>
							<hr />
							<div class="content">
	       						<div id="query1chart" class="ct-chart"></div>
	       						<div class="footer">
	       							<div class="chart-legend">
	       								<input type="button" value="暂停" id="query1play" style="display: none;"/>
	       								<input type="button" value="减速" id="query1slow" style="display: none;"/>
	       								<i class="fa fa-circle text-info"></i><span id="maxquery1chart"></span>
	       								<i class="fa fa-circle text-danger"></i><span id="minquery1chart"></span>
	       								<input type="button" value="加速" id="query1fast" style="display: none;"/>
	       								<input type="button" value="初始速度" id="query1reset" style="display: none;"/>
	       							</div>
	       						</div>
	       					</div>
	                	</div>
	            	</div>
                   <div class="header">
                    	<h4 class="title"style="font-size:18px">&nbsp;</h4>
                    	<hr/>
                    	<h4 class="title"style="font-size:18px">查询2：单一属性有限元数值查询</h4>
                    </div>
                    <div class="col-md-12">
						<div clas="row">
	                    	<div class="col-md-10">
	                    		<div class="nav-tabs-navigation">
			    					<div id="query2div" class="nav-tabs-wrapper">
			        					<ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
											<li value="100"><a  data-toggle="tab">100点</a></li>
			        						<li value="50"><a  data-toggle="tab">50点</a></li>
			            					<li value="20"><a href="#20sdownmeta" data-toggle="tab">20点</a></li>
			            					<li value="10"><a href="#10sdownmeta" data-toggle="tab">10点</a></li>
			            					<li value="5"><a href="#5sdownmeta" data-toggle="tab">5点</a></li>
			            					<li value="1"><a href="#1sdownmeta" data-toggle="tab">1点</a></li>
			        					</ul>
			    					</div>   						
								</div>
	                		</div>
	                		<div class="col-md-1">
	                   			<input type="button" value="显示动态折线图" class="text-right" id="query2active"/>
	                		</div>
						</div>
	    				<hr/>
	                	<div class="card">
	                    	<div class="g_12">
								<div class="widget_contents">
									<div class="realtime_charts" id="query2"></div>
								</div>
							</div>
							<hr />
							<div class="content">
	       						<div id="query2chart" class="ct-chart"></div>
	       						<div class="footer">
	       							<div class="chart-legend">
	       								<input type="button" value="暂停" id="query2play" style="display: none;"/>
	       								<input type="button" value="减速" id="query2slow" style="display: none;"/>
	       								<i class="fa fa-circle text-info"></i><span id="maxquery2chart"></span>
	       								<i class="fa fa-circle text-danger"></i><span id="minquery2chart"></span>
	       								<input type="button" value="加速" id="query2fast" style="display: none;"/>
	       								<input type="button" value="初始速度" id="query2reset" style="display: none;"/>
	       							</div>
	       						</div>
	       					</div>
	                	</div>
	            	</div>
                    <div class="header">   
                    	<h4 class="title"style="font-size:18px">&nbsp;</h4>
                    	<hr/>
                    	<h4 class="title"style="font-size:18px">查询3：单一属性范围数值查询</h4>
                    </div>                   
                    <div class="col-md-12">
						<div clas="row">
	                    	<div class="col-md-10">
	                    		<div class="nav-tabs-navigation">
			    					<div id="query3div" class="nav-tabs-wrapper">
			        					<ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
											<li value="100"><a  data-toggle="tab">100点</a></li>
			        						<li value="50"><a  data-toggle="tab">50点</a></li>
			            					<li value="20"><a href="#20sdownmeta" data-toggle="tab">20点</a></li>
			            					<li value="10"><a href="#10sdownmeta" data-toggle="tab">10点</a></li>
			            					<li value="5"><a href="#5sdownmeta" data-toggle="tab">5点</a></li>
			            					<li value="1"><a href="#1sdownmeta" data-toggle="tab">1点</a></li>
			        					</ul>
			    					</div>   						
								</div>
	                		</div>
	                		<div class="col-md-1">
	                   			<input type="button" value="显示动态折线图" class="text-right" id="query3active"/>
	                		</div>
						</div>
	    				<hr/>
	                	<div class="card">
	                    	<div class="g_12">
								<div class="widget_contents">
									<div class="realtime_charts" id="query3"></div>
								</div>
							</div>
							<hr />
							<div class="content">
	       						<div id="query3chart" class="ct-chart"></div>
	       						<div class="footer">
	       							<div class="chart-legend">
	       								<input type="button" value="暂停" id="query3play" style="display: none;"/>
	       								<input type="button" value="减速" id="query3slow" style="display: none;"/>
	       								<i class="fa fa-circle text-info"></i><span id="maxquery3chart"></span>
	       								<i class="fa fa-circle text-danger"></i><span id="minquery3chart"></span>
	       								<input type="button" value="加速" id="query3fast" style="display: none;"/>
	       								<input type="button" value="初始速度" id="query3reset" style="display: none;"/>
	       							</div>
	       						</div>
	       					</div>
	                	</div>
	            	</div>
                </div>                               
            </div>
            
            <div class="container-fluid">
                <div class="card">
                            <div class="header">
                                <h4 class="title">多属性查询结果信息</h4> 
                            </div>
                            <div class="content table-responsive table-full-width">
                                <table class="table table-striped">                              	
                                    <thead>
                                        <th>编号</th>
                                    	<th>查询类型</th>
                                    	<th>查询条数[条]</th>
                                    	<th>查询速度[条/毫秒]</th>
                                    	<th>查询用时[毫秒]</th>                           
                                    </thead>
                                    <tbody>
                                        <tr>
                                        	<td>1</td>
                                        	<td><b>多属性单个数值查询</b></br>查询属性：区域及文件类型；</br>查询值：查询地区为“DongBei”，文件类型为“Blade”</td>
                                        	<td id="query4_count"></td>
                                        	<td id="query4_speed"></td>
                                        	<td id="query4_time"></td> 
                                        </tr>
                                        <tr>
                                        	<td>2</td>
                                        	<td><b>多属性有限元数值查询</b></br>查询属性：区域及文件类型；</br>查询值：查询地区为"DongBei"及"HuaDong"，文件类型为"Blade"</td>
                                        	<td id="query5_count"></td> 
                                        	<td id="query5_speed"></td> 
                                        	<td id="query5_time"></td> 
                                        </tr>
                                        <tr>
                                        	<td>3</td>
                                        	<td><b>多属性的范围数值查询</b></br>查询属性：塔架高度和扇叶长度；</br>查询值：塔架高度和扇叶长度在合理范围内</td>
                                        	<td id="query6_count"></td>
                                        	<td id="query6_speed"></td>
                                        	<td id="query6_time"></td>                             	
                                        </tr>
                                        <tr>
                                        	<td>4</td>
                                        	<td><b>多属性的多类型数值查询</b></br>查询属性：塔架高度、区域和文件类型；</br>查询值：塔架高度在合理范围内且查询地区为"DongBei"及"HuaDong"，文件类型为"Blade"</td>
                                        	<td id="query7_count"></td>
                                        	<td id="query7_speed"></td>
                                        	<td id="query7_time"></td>                             	
                                        </tr>                                         
                                    </tbody>
                                </table>
                            </div>
                            <div class="content">
                                <input id="downloadresult2" type="button" style="font-size: 18px;background: transparent;border: hidden;color: red;text-decoration: underline; float: left" value="数据下载结果查看" onclick="downloadresultf2()"/>
                                </dr/>
                                <input id="refleshqueryb" type="button" style="font-size: 18px;background: transparent;border: hidden;color: red;text-decoration: underline; float: right" value="刷新信息" onclick="querybreflesh()"/>
                                </dr/>
                                <br/>
                            </div>
                        </div>
                <div id="dlresult2" style="display: none;" class="row">
                	<div class="header">
                    	<h4 class="title">下载结果折线图</h4>
                    	<hr/>
                    	<h4 class="title"style="font-size:18px">查询4：多属性单个数值查询</h4>
                    </div>
                    <div class="col-md-12">
						<div clas="row">
	                    	<div class="col-md-10">
	                    		<div class="nav-tabs-navigation">
			    					<div id="query4div" class="nav-tabs-wrapper">
			        					<ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
											<li value="100"><a  data-toggle="tab">100点</a></li>
			        						<li value="50"><a  data-toggle="tab">50点</a></li>
			            					<li value="20"><a href="#20sdownmeta" data-toggle="tab">20点</a></li>
			            					<li value="10"><a href="#10sdownmeta" data-toggle="tab">10点</a></li>
			            					<li value="5"><a href="#5sdownmeta" data-toggle="tab">5点</a></li>
			            					<li value="1"><a href="#1sdownmeta" data-toggle="tab">1点</a></li>
			        					</ul>
			    					</div>   						
								</div>
	                		</div>
	                		<div class="col-md-1">
	                   			<input type="button" value="显示动态折线图" class="text-right" id="query4active"/>
	                		</div>
						</div>
	    				<hr/>
	                	<div class="card">
	                    	<div class="g_12">
								<div class="widget_contents">
									<div class="realtime_charts" id="query4"></div>
								</div>
							</div>
							<hr />
							<div class="content">
	       						<div id="query4chart" class="ct-chart"></div>
	       						<div class="footer">
	       							<div class="chart-legend">
	       								<input type="button" value="暂停" id="query4play" style="display: none;"/>
	       								<input type="button" value="减速" id="query4slow" style="display: none;"/>
	       								<i class="fa fa-circle text-info"></i><span id="maxquery4chart"></span>
	       								<i class="fa fa-circle text-danger"></i><span id="minquery4chart"></span>
	       								<input type="button" value="加速" id="query4fast" style="display: none;"/>
	       								<input type="button" value="初始速度" id="query4reset" style="display: none;"/>
	       							</div>
	       						</div>
	       					</div>
	                	</div>
	            	</div>
                   <div class="header">
                    	<h4 class="title"style="font-size:18px">&nbsp;</h4>
                    	<hr/>
                    	<h4 class="title"style="font-size:18px">查询5：多属性有限元数值查询</h4>
                    </div>
                   <div class="col-md-12">
						<div clas="row">
	                    	<div class="col-md-10">
	                    		<div class="nav-tabs-navigation">
			    					<div id="query5div" class="nav-tabs-wrapper">
			        					<ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
											<li value="100"><a  data-toggle="tab">100点</a></li>
			        						<li value="50"><a  data-toggle="tab">50点</a></li>
			            					<li value="20"><a href="#20sdownmeta" data-toggle="tab">20点</a></li>
			            					<li value="10"><a href="#10sdownmeta" data-toggle="tab">10点</a></li>
			            					<li value="5"><a href="#5sdownmeta" data-toggle="tab">5点</a></li>
			            					<li value="1"><a href="#1sdownmeta" data-toggle="tab">1点</a></li>
			        					</ul>
			    					</div>   						
								</div>
	                		</div>
	                		<div class="col-md-1">
	                   			<input type="button" value="显示动态折线图" class="text-right" id="query5active"/>
	                		</div>
						</div>
	    				<hr/>
	                	<div class="card">
	                    	<div class="g_12">
								<div class="widget_contents">
									<div class="realtime_charts" id="query5"></div>
								</div>
							</div>
							<hr />
							<div class="content">
	       						<div id="query5chart" class="ct-chart"></div>
	       						<div class="footer">
	       							<div class="chart-legend">
	       								<input type="button" value="暂停" id="query5play" style="display: none;"/>
	       								<input type="button" value="减速" id="query5slow" style="display: none;"/>
	       								<i class="fa fa-circle text-info"></i><span id="maxquery5chart"></span>
	       								<i class="fa fa-circle text-danger"></i><span id="minquery5chart"></span>
	       								<input type="button" value="加速" id="query5fast" style="display: none;"/>
	       								<input type="button" value="初始速度" id="query5reset" style="display: none;"/>
	       							</div>
	       						</div>
	       					</div>
	                	</div>
	            	</div>
                    <div class="header">   
                    	<h4 class="title"style="font-size:18px">&nbsp;</h4>
                    	<hr/>
                    	<h4 class="title"style="font-size:18px">查询6：多属性的范围数值查询</h4>
                    </div>                   
                    <div class="col-md-12">
						<div clas="row">
	                    	<div class="col-md-10">
	                    		<div class="nav-tabs-navigation">
			    					<div id="query6div" class="nav-tabs-wrapper">
			        					<ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
											<li value="100"><a  data-toggle="tab">100点</a></li>
			        						<li value="50"><a  data-toggle="tab">50点</a></li>
			            					<li value="20"><a href="#20sdownmeta" data-toggle="tab">20点</a></li>
			            					<li value="10"><a href="#10sdownmeta" data-toggle="tab">10点</a></li>
			            					<li value="5"><a href="#5sdownmeta" data-toggle="tab">5点</a></li>
			            					<li value="1"><a href="#1sdownmeta" data-toggle="tab">1点</a></li>
			        					</ul>
			    					</div>   						
								</div>
	                		</div>
	                		<div class="col-md-1">
	                   			<input type="button" value="显示动态折线图" class="text-right" id="query6active"/>
	                		</div>
						</div>
	    				<hr/>
	                	<div class="card">
	                    	<div class="g_12">
								<div class="widget_contents">
									<div class="realtime_charts" id="query6"></div>
								</div>
							</div>
							<hr />
							<div class="content">
	       						<div id="query6chart" class="ct-chart"></div>
	       						<div class="footer">
	       							<div class="chart-legend">
	       								<input type="button" value="暂停" id="query6play" style="display: none;"/>
	       								<input type="button" value="减速" id="query6slow" style="display: none;"/>
	       								<i class="fa fa-circle text-info"></i><span id="maxquery6chart"></span>
	       								<i class="fa fa-circle text-danger"></i><span id="minquery6chart"></span>
	       								<input type="button" value="加速" id="query6fast" style="display: none;"/>
	       								<input type="button" value="初始速度" id="query6reset" style="display: none;"/>
	       							</div>
	       						</div>
	       					</div>
	                	</div>
	            	</div>
                    
                    <div class="header">   
                    	<h4 class="title"style="font-size:18px">&nbsp;</h4>
                    	<hr/>
                    	<h4 class="title"style="font-size:18px">查询7：多属性的多类型数值查询</h4>
                    </div>                   
                    <div class="col-md-12">
						<div clas="row">
	                    	<div class="col-md-10">
	                    		<div class="nav-tabs-navigation">
			    					<div id="query7div" class="nav-tabs-wrapper">
			        					<ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
											<li value="100"><a  data-toggle="tab">100点</a></li>
			        						<li value="50"><a  data-toggle="tab">50点</a></li>
			            					<li value="20"><a href="#20sdownmeta" data-toggle="tab">20点</a></li>
			            					<li value="10"><a href="#10sdownmeta" data-toggle="tab">10点</a></li>
			            					<li value="5"><a href="#5sdownmeta" data-toggle="tab">5点</a></li>
			            					<li value="1"><a href="#1sdownmeta" data-toggle="tab">1点</a></li>
			        					</ul>
			    					</div>   						
								</div>
	                		</div>
	                		<div class="col-md-1">
	                   			<input type="button" value="显示动态折线图" class="text-right" id="query7active"/>
	                		</div>
						</div>
	    				<hr/>
	                	<div class="card">
	                    	<div class="g_12">
								<div class="widget_contents">
									<div class="realtime_charts" id="query7"></div>
								</div>
							</div>
							<hr />
							<div class="content">
	       						<div id="query7chart" class="ct-chart"></div>
	       						<div class="footer">
	       							<div class="chart-legend">
	       								<input type="button" value="暂停" id="query7play" style="display: none;"/>
	       								<input type="button" value="减速" id="query7slow" style="display: none;"/>
	       								<i class="fa fa-circle text-info"></i><span id="maxquery7chart"></span>
	       								<i class="fa fa-circle text-danger"></i><span id="minquery7chart"></span>
	       								<input type="button" value="加速" id="query7fast" style="display: none;"/>
	       								<input type="button" value="初始速度" id="query7reset" style="display: none;"/>
	       							</div>
	       						</div>
	       					</div>
	                	</div>
	            	</div>
                </div>                               
            </div>
            
             <div class="container-fluid">
                <div class="card">
                    <div class="header">
                        <h4 class="title">多属性查询结果信息</h4> 
                    </div>
                    <div class="content table-responsive table-full-width">
                        <table class="table table-striped">                              	
                            <thead>
                                <th>编号</th>
                                <th>查询类型</th>
                                <th>查询条数[条]</th>
                                <th>查询速度[条/毫秒]</th>
                                <th>查询用时[毫秒]</th>     
                                <th>查询正确率</th>                      
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1</td>
                                    <td><b>版本管理查询查询</b></br>所有文件的版本数量；</br>查询值：遍历整个版本</td>
                                    <td id="query8_count"></td>
                                    <td id="query8_speed"></td>
                                    <td id="query8_time"></td> 
                                    <td id="query8_rate"></td>
                                </tr>                                      
                             </tbody>
                        </table>
                    </div>
                    <div class="content">
                        <input id="refleshqueryc" type="button" style="font-size: 18px;background: transparent;border: hidden;color: red;text-decoration: underline; float: right" value="刷新信息" onclick="querycreflesh()"/>
                        </dr/>
                        <br/>
                    </div>
                </div>             
            </div>
            
        </div>


        <footer class="footer">
            <div class="container-fluid">
                <nav class="pull-left">
                </nav>
                <div class="copyright pull-right">
                    &copy; <script>document.write(new Date().getFullYear())</script>, 制作者<i class="fa fa-heart heart"></i> by <a href="http://deke.ruc.edu.cn/ ">数据工程与知识工程实验室</a>. 版权属于 <a href="http://info.ruc.edu.cn" target="_blank" title="模板之家">中国人民大学信息学院</a>
                </div>
            </div>
        </footer>

    </div>
</div>


</body>

    <!--   Core JS Files   -->
    <script src="js/jquery-1.10.2.js" type="text/javascript"></script>
	<script src="js/bootstrap.min.js" type="text/javascript"></script>

	<!--  Checkbox, Radio & Switch Plugins -->
	<script src="js/bootstrap-checkbox-radio.js"></script>

	<!--  Charts Plugin -->
	<script src="js/chartist.min.js"></script>

    <!--  Notifications Plugin    -->
    <script src="js/bootstrap-notify.js"></script>

    <!-- Paper Dashboard Core javascript and methods for Demo purpose -->
	<script src="js/paper-dashboard.js"></script>

	<!-- Paper Dashboard DEMO methods, don't include it in your project! -->
	<script src="js/demo.js"></script>
	<script type="text/javascript" src="js/common.js" ></script>
	<script type="text/javascript" src="js/flavr.min.js" ></script>
	<script src="js/plot/excanvas.js"></script>
	<script src="js/plot/jquery.flot.js"></script>
	<script src="js/plot/jquery.flot.resize.js"></script>
	<script src="js/plot/jquery.flot.pie.js"></script>
	<script type="text/javascript">
	//全局定义动态变量
	var work = null;
	//与暂停、继续相关的全局变量
	var global_data = [];
	var global_count = 0;
	//速度因子，用于控制快慢
	var speed_factor = 1;
	//各表的间隔因子
	var query1s = 0;
	var query2s = 0;
	var query3s = 0;
	var query4s = 0;
	var query5s = 0;
	var query6s = 0;
	var query7s = 0;
	$(function(){	
		var query1active = 0;
		var query2active = 0;
		var query3active = 0;
		var query4active = 0;
		var query5active = 0;
		var query6active = 0;
		var query7active = 0;
		$.ajax(
		{
			type:"post",
			url:"/MBBench-U/simplequeryresult",
			async:true,
			data:{
                "type": "info",
				"copynum": $("#copynum").text()
			},
			success:function(data){
				$("#devicetype_count").text(data.devicetype_count);
				$("#devicetype_speed").text(data.devicetype_speed);
				$("#devicetype_time").text(data.devicetype_time);
				$("#towerhight_count").text(data.towerhight_count);
				$("#towerhight_speed").text(data.towerhight_speed);
				$("#towerhight_time").text(data.towerhight_time);
				$("#simulation_count").text(data.simulation_count);
				$("#simulation_speed").text(data.simulation_speed);
				$("#simulation_time").text(data.simulation_time);
				$("#sett").text(data.sett);	
				$("#query4_count").text(data.query4_count);
				$("#query4_speed").text(data.query4_speed);
				$("#query4_time").text(data.query4_time);
				$("#query5_count").text(data.query5_count);
				$("#query5_speed").text(data.query5_speed);
				$("#query5_time").text(data.query5_time);
				$("#query6_count").text(data.query6_count);
				$("#query6_speed").text(data.query6_speed);
				$("#query6_time").text(data.query6_time);
				$("#query7_count").text(data.query7_count);
				$("#query7_speed").text(data.query7_speed);
				$("#query7_time").text(data.query7_time);
				$("#query8_count").text(data.query8_count);
				$("#query8_speed").text(data.query8_speed);
				$("#query8_time").text(data.query8_time);
				$("#query8_rate").text(data.query8_rate + "%");
			},
			dataType:"json",
			error:function(){						
			}
		});	
		var choosecopy = 0;
		$("#copychoose ul li").bind('click', function(){
			choosecopy = $(this).val();
			$("#copynum").text(choosecopy);
			$.ajax(
					{
						type:"post",
						url:"/MBBench-U/simplequeryresult",
						async:true,
						data:{
							"type": "info",
							"copynum": choosecopy
						},
						success:function(data){
							$("#devicetype_count").text(data.devicetype_count);
							$("#devicetype_speed").text(data.devicetype_speed);
							$("#devicetype_time").text(data.devicetype_time);
							$("#towerhight_count").text(data.towerhight_count);
							$("#towerhight_speed").text(data.towerhight_speed);
							$("#towerhight_time").text(data.towerhight_time);
							$("#simulation_count").text(data.simulation_count);
							$("#simulation_speed").text(data.simulation_speed);
							$("#simulation_time").text(data.simulation_time);
							$("#sett").text(data.sett);		
							$("#query4_count").text(data.query4_count);
							$("#query4_speed").text(data.query4_speed);
							$("#query4_time").text(data.query4_time);
							$("#query5_count").text(data.query5_count);
							$("#query5_speed").text(data.query5_speed);
							$("#query5_time").text(data.query5_time);
							$("#query6_count").text(data.query6_count);
							$("#query6_speed").text(data.query6_speed);
							$("#query6_time").text(data.query6_time);
							$("#query7_count").text(data.query7_count);
							$("#query7_speed").text(data.query7_speed);
							$("#query7_time").text(data.query7_time);
							$("#query8_count").text(data.query8_count);
							$("#query8_speed").text(data.query8_speed);
							$("#query8_time").text(data.query8_time);
							$("#query8_rate").text(data.query8_rate + "%");
						},
						dataType:"json",
						error:function(){						
						}
					});	
		});

        $("#query1div ul li").bind('click', function(){
            query1active = 0;
            $("#query1active").attr('value','显示动态折线图');
            $("#query1play").attr('value','暂停');
            $("#query1play").hide();
            $("#query1fast").hide();
            $("#query1slow").hide();
            $("#query1reset").hide();
            query1s = parseInt($(this).val());
            var copynum = $("#copynum").text();
            if(work != null){
                clearInterval(work);
                work == null;
            }
            draw(query1s, query1active, copynum, "query1", 0);
        });

        $("#query1active").bind('click', function(){
            var type = $(this).val();
            var copynum = $("#copynum").text();
            if(type == "显示动态折线图"){
                query1active = 1;
                $(this).attr('value','显示静态折线图');
                $("#query1play").show();
                $("#query1fast").show();
                $("#query1slow").show();
                $("#query1reset").show();

            }
            else{
                query1active = 0;
                $(this).attr('value','显示动态折线图');
                $("#query1play").attr('value','暂停');
                $("#query1play").hide();
                $("#query1fast").hide();
                $("#query1slow").hide();
                $("#query1reset").hide();
            }
            if(work != null){
                clearInterval(work);
                work == null;
            }
            draw(query1s, query1active, copynum, "query1", 0);
        });

        $("#query1play").bind('click', function(){
            if($(this).val() == "暂停")
            {
                clearInterval(work);
                work = null;
                query1active = 0;
                $(this).val("继续");
            }
            else
            {
                var copynum = $("#copynum").text();
                query1active = 1;
                draw(query1s, query1active, copynum, "query1", 1);
                $(this).val("暂停");
            }
        });

        $("#query1slow").bind('click', function(){
            var copynum = $("#copynum").text();
            clearInterval(work);
            work = null;
            query1active = 1;
            speed_factor = speed_factor * 1.5;
            draw(query1s, query1active, copynum, "query1", 1);
            $("#query1play").val("暂停");
        });

        $("#query1fast").bind('click', function(){
            var copynum = $("#copynum").text();
            clearInterval(work);
            work = null;
            query1active = 1;
            speed_factor = speed_factor * 0.5;
            draw(query1s, query1active, copynum, "query1", 1);
            $("#query1play").val("暂停");
        });

        $("#query1reset").bind('click', function(){
            var copynum = $("#copynum").text();
            clearInterval(work);
            work = null;
            query1active = 1;
            speed_factor = 1;
            draw(query1s, query1active, copynum, "query1", 1);
            $("#query1play").val("暂停");
        });

        $("#query2div ul li").bind('click', function(){
            query2active = 0;
            $("#query2active").attr('value','显示动态折线图');
            $("#query2play").attr('value','暂停');
            $("#query2play").hide();
            $("#query2fast").hide();
            $("#query2slow").hide();
            $("#query2reset").hide();
            query2s = parseInt($(this).val());
            var copynum = $("#copynum").text();
            if(work != null){
                clearInterval(work);
                work == null;
            }
            draw(query2s, query2active, copynum, "query2", 0);
        });

        $("#query2active").bind('click', function(){
            var type = $(this).val();
            var copynum = $("#copynum").text();
            if(type == "显示动态折线图"){
                query2active = 1;
                $(this).attr('value','显示静态折线图');
                $("#query2play").show();
                $("#query2fast").show();
                $("#query2slow").show();
                $("#query2reset").show();

            }
            else{
                query2active = 0;
                $(this).attr('value','显示动态折线图');
                $("#query2play").attr('value','暂停');
                $("#query2play").hide();
                $("#query2fast").hide();
                $("#query2slow").hide();
                $("#query2reset").hide();
            }
            if(work != null){
                clearInterval(work);
                work == null;
            }
            draw(query2s, query2active, copynum, "query2", 0);
        });

        $("#query2play").bind('click', function(){
            if($(this).val() == "暂停")
            {
                clearInterval(work);
                work = null;
                query2active = 0;
                $(this).val("继续");
            }
            else
            {
                var copynum = $("#copynum").text();
                query2active = 1;
                draw(query2s, query2active, copynum, "query2", 1);
                $(this).val("暂停");
            }
        });

        $("#query2slow").bind('click', function(){
            var copynum = $("#copynum").text();
            clearInterval(work);
            work = null;
            query2active = 1;
            speed_factor = speed_factor * 1.5;
            draw(query2s, query2active, copynum, "query2", 1);
            $("#query2play").val("暂停");
        });

        $("#query2fast").bind('click', function(){
            var copynum = $("#copynum").text();
            clearInterval(work);
            work = null;
            query2active = 1;
            speed_factor = speed_factor * 0.5;
            draw(query2s, query2active, copynum, "query2", 1);
            $("#query2play").val("暂停");
        });

        $("#query2reset").bind('click', function(){
            var copynum = $("#copynum").text();
            clearInterval(work);
            work = null;
            query2active = 1;
            speed_factor = 1;
            draw(query2s, query2active, copynum, "query2", 1);
            $("#query2play").val("暂停");
        });

        $("#query3div ul li").bind('click', function(){
            query3active = 0;
            $("#query3active").attr('value','显示动态折线图');
            $("#query3play").attr('value','暂停');
            $("#query3play").hide();
            $("#query3fast").hide();
            $("#query3slow").hide();
            $("#query3reset").hide();
            query3s = parseInt($(this).val());
            var copynum = $("#copynum").text();
            if(work != null){
                clearInterval(work);
                work == null;
            }
            draw(query3s, query3active, copynum, "query3", 0);
        });

        $("#query3active").bind('click', function(){
            var type = $(this).val();
            var copynum = $("#copynum").text();
            if(type == "显示动态折线图"){
                query3active = 1;
                $(this).attr('value','显示静态折线图');
                $("#query3play").show();
                $("#query3fast").show();
                $("#query3slow").show();
                $("#query3reset").show();

            }
            else{
                query3active = 0;
                $(this).attr('value','显示动态折线图');
                $("#query3play").attr('value','暂停');
                $("#query3play").hide();
                $("#query3fast").hide();
                $("#query3slow").hide();
                $("#query3reset").hide();
            }
            if(work != null){
                clearInterval(work);
                work == null;
            }
            draw(query3s, query3active, copynum, "query3", 0);
        });

        $("#query3play").bind('click', function(){
            if($(this).val() == "暂停")
            {
                clearInterval(work);
                work = null;
                query3active = 0;
                $(this).val("继续");
            }
            else
            {
                var copynum = $("#copynum").text();
                query3active = 1;
                draw(s, query3active, copynum, "query3", 1);
                $(this).val("暂停");
            }
        });

        $("#query3slow").bind('click', function(){
            var copynum = $("#copynum").text();
            clearInterval(work);
            work = null;
            query3active = 1;
            speed_factor = speed_factor * 1.5;
            draw(query3s, query3active, copynum, "query3", 1);
            $("#query3play").val("暂停");
        });

        $("#query3fast").bind('click', function(){
            var copynum = $("#copynum").text();
            clearInterval(work);
            work = null;
            query3active = 1;
            speed_factor = speed_factor * 0.5;
            draw(query3s, query3active, copynum, "query3", 1);
            $("#query3play").val("暂停");
        });

        $("#query3reset").bind('click', function(){
            var copynum = $("#copynum").text();
            clearInterval(work);
            work = null;
            query3active = 1;
            speed_factor = 1;
            draw(query3s, query3active, copynum, "query3", 1);
            $("#query3play").val("暂停");
        });

        $("#query4div ul li").bind('click', function(){
            query4active = 0;
            $("#query4active").attr('value','显示动态折线图');
            $("#query4play").attr('value','暂停');
            $("#query4play").hide();
            $("#query4fast").hide();
            $("#query4slow").hide();
            $("#query4reset").hide();
            query4s = parseInt($(this).val());
            var copynum = $("#copynum").text();
            if(work != null){
                clearInterval(work);
                work == null;
            }
            draw(query4s, query4active, copynum, "query4", 0);
        });

        $("#query4active").bind('click', function(){
            var type = $(this).val();
            var copynum = $("#copynum").text();
            if(type == "显示动态折线图"){
                query4active = 1;
                $(this).attr('value','显示静态折线图');
                $("#query4play").show();
                $("#query4fast").show();
                $("#query4slow").show();
                $("#query4reset").show();

            }
            else{
                query4active = 0;
                $(this).attr('value','显示动态折线图');
                $("#query4play").attr('value','暂停');
                $("#query4play").hide();
                $("#query4fast").hide();
                $("#query4slow").hide();
                $("#query4reset").hide();
            }
            if(work != null){
                clearInterval(work);
                work == null;
            }
            draw(query4s, query4active, copynum, "query4", 0);
        });

        $("#query4play").bind('click', function(){
            if($(this).val() == "暂停")
            {
                clearInterval(work);
                work = null;
                query4active = 0;
                $(this).val("继续");
            }
            else
            {
                var copynum = $("#copynum").text();
                query4active = 1;
                draw(s, query4active, copynum, "query4", 1);
                $(this).val("暂停");
            }
        });

        $("#query4slow").bind('click', function(){
            var copynum = $("#copynum").text();
            clearInterval(work);
            work = null;
            query4active = 1;
            speed_factor = speed_factor * 1.5;
            draw(query4s, query4active, copynum, "query4", 1);
            $("#query4play").val("暂停");
        });

        $("#query4fast").bind('click', function(){
            var copynum = $("#copynum").text();
            clearInterval(work);
            work = null;
            query4active = 1;
            speed_factor = speed_factor * 0.5;
            draw(query4s, query4active, copynum, "query4", 1);
            $("#query4play").val("暂停");
        });

        $("#query4reset").bind('click', function(){
            var copynum = $("#copynum").text();
            clearInterval(work);
            work = null;
            query4active = 1;
            speed_factor = 1;
            draw(query4s, query4active, copynum, "query4", 1);
            $("#query4play").val("暂停");
        });

        $("#query5div ul li").bind('click', function(){
            query5active = 0;
            $("#query5active").attr('value','显示动态折线图');
            $("#query5play").attr('value','暂停');
            $("#query5play").hide();
            $("#query5fast").hide();
            $("#query5slow").hide();
            $("#query5reset").hide();
            query5s = parseInt($(this).val());
            var copynum = $("#copynum").text();
            if(work != null){
                clearInterval(work);
                work == null;
            }
            draw(query5s, query5active, copynum, "query5", 0);
        });

        $("#query5active").bind('click', function(){
            var type = $(this).val();
            var copynum = $("#copynum").text();
            if(type == "显示动态折线图"){
                query5active = 1;
                $(this).attr('value','显示静态折线图');
                $("#query5play").show();
                $("#query5fast").show();
                $("#query5slow").show();
                $("#query5reset").show();

            }
            else{
                query5active = 0;
                $(this).attr('value','显示动态折线图');
                $("#query5play").attr('value','暂停');
                $("#query5play").hide();
                $("#query5fast").hide();
                $("#query5slow").hide();
                $("#query5reset").hide();
            }
            if(work != null){
                clearInterval(work);
                work == null;
            }
            draw(query5s, query5active, copynum, "query5", 0);
        });

        $("#query5play").bind('click', function(){
            if($(this).val() == "暂停")
            {
                clearInterval(work);
                work = null;
                query5active = 0;
                $(this).val("继续");
            }
            else
            {
                var copynum = $("#copynum").text();
                query5active = 1;
                draw(s, query5active, copynum, "query5", 1);
                $(this).val("暂停");
            }
        });

        $("#query5slow").bind('click', function(){
            var copynum = $("#copynum").text();
            clearInterval(work);
            work = null;
            query5active = 1;
            speed_factor = speed_factor * 1.5;
            draw(query5s, query5active, copynum, "query5", 1);
            $("#query5play").val("暂停");
        });

        $("#query5fast").bind('click', function(){
            var copynum = $("#copynum").text();
            clearInterval(work);
            work = null;
            query5active = 1;
            speed_factor = speed_factor * 0.5;
            draw(query5s, query5active, copynum, "query5", 1);
            $("#query5play").val("暂停");
        });

        $("#query5reset").bind('click', function(){
            var copynum = $("#copynum").text();
            clearInterval(work);
            work = null;
            query5active = 1;
            speed_factor = 1;
            draw(query5s, query5active, copynum, "query5", 1);
            $("#query5play").val("暂停");
        });

        $("#query6div ul li").bind('click', function(){
            query6active = 0;
            $("#query6active").attr('value','显示动态折线图');
            $("#query6play").attr('value','暂停');
            $("#query6play").hide();
            $("#query6fast").hide();
            $("#query6slow").hide();
            $("#query6reset").hide();
            query6s = parseInt($(this).val());
            var copynum = $("#copynum").text();
            if(work != null){
                clearInterval(work);
                work == null;
            }
            draw(query6s, query6active, copynum, "query6", 0);
        });

        $("#query6active").bind('click', function(){
            var type = $(this).val();
            var copynum = $("#copynum").text();
            if(type == "显示动态折线图"){
                query6active = 1;
                $(this).attr('value','显示静态折线图');
                $("#query6play").show();
                $("#query6fast").show();
                $("#query6slow").show();
                $("#query6reset").show();

            }
            else{
                query6active = 0;
                $(this).attr('value','显示动态折线图');
                $("#query6play").attr('value','暂停');
                $("#query6play").hide();
                $("#query6fast").hide();
                $("#query6slow").hide();
                $("#query6reset").hide();
            }
            if(work != null){
                clearInterval(work);
                work == null;
            }
            draw(query6s, query6active, copynum, "query6", 0);
        });

        $("#query6play").bind('click', function(){
            if($(this).val() == "暂停")
            {
                clearInterval(work);
                work = null;
                query6active = 0;
                $(this).val("继续");
            }
            else
            {
                var copynum = $("#copynum").text();
                query6active = 1;
                draw(s, query6active, copynum, "query6", 1);
                $(this).val("暂停");
            }
        });

        $("#query6slow").bind('click', function(){
            var copynum = $("#copynum").text();
            clearInterval(work);
            work = null;
            query6active = 1;
            speed_factor = speed_factor * 1.5;
            draw(query6s, query6active, copynum, "query6", 1);
            $("#query6play").val("暂停");
        });

        $("#query6fast").bind('click', function(){
            var copynum = $("#copynum").text();
            clearInterval(work);
            work = null;
            query6active = 1;
            speed_factor = speed_factor * 0.5;
            draw(query6s, query6active, copynum, "query6", 1);
            $("#query6play").val("暂停");
        });

        $("#query6reset").bind('click', function(){
            var copynum = $("#copynum").text();
            clearInterval(work);
            work = null;
            query6active = 1;
            speed_factor = 1;
            draw(query6s, query6active, copynum, "query6", 1);
            $("#query6play").val("暂停");
        });

        $("#query7div ul li").bind('click', function(){
            query7active = 0;
            $("#query7active").attr('value','显示动态折线图');
            $("#query7play").attr('value','暂停');
            $("#query7play").hide();
            $("#query7fast").hide();
            $("#query7slow").hide();
            $("#query7reset").hide();
            query7s = parseInt($(this).val());
            var copynum = $("#copynum").text();
            if(work != null){
                clearInterval(work);
                work == null;
            }
            draw(query7s, query7active, copynum, "query7", 0);
        });

        $("#query7active").bind('click', function(){
            var type = $(this).val();
            var copynum = $("#copynum").text();
            if(type == "显示动态折线图"){
                query7active = 1;
                $(this).attr('value','显示静态折线图');
                $("#query7play").show();
                $("#query7fast").show();
                $("#query7slow").show();
                $("#query7reset").show();

            }
            else{
                query7active = 0;
                $(this).attr('value','显示动态折线图');
                $("#query7play").attr('value','暂停');
                $("#query7play").hide();
                $("#query7fast").hide();
                $("#query7slow").hide();
                $("#query7reset").hide();
            }
            if(work != null){
                clearInterval(work);
                work == null;
            }
            draw(query7s, query7active, copynum, "query7", 0);
        });

        $("#query7play").bind('click', function(){
            if($(this).val() == "暂停")
            {
                clearInterval(work);
                work = null;
                query7active = 0;
                $(this).val("继续");
            }
            else
            {
                var copynum = $("#copynum").text();
                query7active = 1;
                draw(s, query7active, copynum, "query7", 1);
                $(this).val("暂停");
            }
        });

        $("#query7slow").bind('click', function(){
            var copynum = $("#copynum").text();
            clearInterval(work);
            work = null;
            query7active = 1;
            speed_factor = speed_factor * 1.5;
            draw(query7s, query7active, copynum, "query7", 1);
            $("#query7play").val("暂停");
        });

        $("#query7fast").bind('click', function(){
            var copynum = $("#copynum").text();
            clearInterval(work);
            work = null;
            query7active = 1;
            speed_factor = speed_factor * 0.5;
            draw(query7s, query7active, copynum, "query7", 1);
            $("#query7play").val("暂停");
        });

        $("#query7reset").bind('click', function(){
            var copynum = $("#copynum").text();
            clearInterval(work);
            work = null;
            query7active = 1;
            speed_factor = 1;
            draw(query7s, query7active, copynum, "query7", 1);
            $("#query7play").val("暂停");
        });
    });
	
	function downloadresultf() 
	{
		var content = $("#downloadresult").val();
		if(content == "数据下载结果查看"){
			$("#downloadresult").val("隐藏数据下载结果");
			$("#dlresult").show();
		}
		else{
			$("#downloadresult").val("数据下载结果查看"); 
			$("#dlresult").hide();
		}
	}
	
	function downloadresultf2() 
	{
		var content = $("#downloadresult2").val();
		if(content == "数据下载结果查看"){
			$("#downloadresult2").val("隐藏数据下载结果");
			$("#dlresult2").show();
		}
		else{
			$("#downloadresult2").val("数据下载结果查看"); 
			$("#dlresult2").hide();
		}
	
	}
	
	function draw(s, active, copynum, chartname, processtype)
	{
		Array.prototype.max = function(){ 
			return Math.max.apply({},this); 
		}; 
		Array.prototype.min = function(){ 
			return Math.min.apply({},this); 
		}; 
		var flow = [];
		var loadmax = 0;
		var loadmin = 0;
		global_interval = s;

		$.ajax({
			type:"get",
			url:"/MBBench-U/simplequeryresult",
			async:true,
			data:{"interval":s, "type":"draw", "copynum":copynum, "chartname":chartname},
			success:function(data)
			{
				var dataObj = data;
				$.each(dataObj, function(index, item)
				{
					flow.push(parseFloat(item.speed));
				});
				interval = parseInt(flow.pop());
				loadmax = flow.max();
				$("#max" + chartname + "chart").text("最大值："+loadmax.toFixed(2));
				loadmin = flow.min();
				$("#min" + chartname + "chart").text("最小值："+loadmin.toFixed(2));
				//alert(flow);
				var count = 0;
				var data = [], totalPoints = 100;
				function getshuzu(){
					//processtype 用于判断此时是否为加速，减速，暂停，继续
					if(processtype == 1){
						data = global_data;
						count = global_count;
					}
					else{
						global_data = [];
						global_count = 0;
					}
					if(data.length > 0)
						data = data.slice(1);
					while(data.length < totalPoints && count < flow.length){
						data.push(flow[count]);
						count++;
					}
					global_data = data;
					global_count = count;
					var res = [];
					for(var i = 0; i < data.length; ++i)
						res.push([i,data[i]]);
					return res;		
				}
				
				function getallshuzu(){
					var res = [];
					for(var i = 0; i < flow.length; ++i)
						res.push([i, flow[i]]);
					return res;
				}
				
				if(active == 1){
					var realtime = $.plot($("#" + chartname), [{label: "speed", data: getshuzu()}],
						{
							colors: ["#00AADD"],
							series: {
								lines: {
									show: true,
									lineWidth: 2,
							   		},
								points: {show: true},
								shadowSize: 2,
								},
								
							grid: {
								hoverable: true,
								show: true,
								borderWidth: 0,
								tickColor: "#d2d2d2",
								labelMargin: 12,
							},
				
							legend: {
								show: true,
								margin: [0,-24],
								noColumns: 0,
								labelBoxBorderColor: null,
							},
				
							yaxis: { min: parseInt(loadmin), max: parseInt(loadmax)},
							xaxis: { min: 0, max: totalPoints},
						}	
					);
			
					function realtime_function() {
						realtime.setData([ getshuzu() ]);
						realtime.draw();
					}
						
					realtime_function();
					work = setInterval(realtime_function, parseInt(500 * speed_factor));
				}
				else{
					var realtime = $.plot($("#" + chartname), [{label: "speed", data: getallshuzu()}],
						{
							colors: ["#00AADD"],
							series: {
								lines: {
									show: true,
									lineWidth: 2,
							   		},
								points: {show: true},
								shadowSize: 2,
								},
								
							grid: {
								hoverable: true,
								show: true,
								borderWidth: 0,
								tickColor: "#d2d2d2",
								labelMargin: 12,
							},
				
							legend: {
								show: true,
								margin: [0,-24],
								noColumns: 0,
								labelBoxBorderColor: null,
							},
				
							yaxis: { min: parseInt(loadmin), max: parseInt(loadmax) + 1 },
							xaxis: { min: 0, max: getallshuzu().length},
						}	
					);
				}
			},
			error:function(){
				$.notify({
    				icon: 'ti-bell',
    				message: "获取信息失败，请查验是否进行过此负载测试"
    			},{
        			type: 'danger',
        			timer: 4000
    			});
			},
			dataType:"json"
		});
	}

	function queryareflesh(){
        var choosecopy = $("#copynum").text();

        $.ajax({
            type:"get",
            url:"/MBBench-U/simplequeryresult",
            async:true,
            data:{
                "type":"querya",
                "copynum":choosecopy
            },
            success:function(data){
                $("#devicetype_count").text(data.devicetype_count);
                $("#devicetype_speed").text(data.devicetype_speed);
                $("#devicetype_time").text(data.devicetype_time);
                $("#towerhight_count").text(data.towerhight_count);
                $("#towerhight_speed").text(data.towerhight_speed);
                $("#towerhight_time").text(data.towerhight_time);
                $("#simulation_count").text(data.simulation_count);
                $("#simulation_speed").text(data.simulation_speed);
                $("#simulation_time").text(data.simulation_time);
                $("#sett").text(data.sett);
            },
            error:function() {
                $.notify({
                    icon: 'ti-bell',
                    message: "获取信息失败，请查验是否进行过此负载测试"
                },{
                    type: 'danger',
                    timer: 4000
                });
            },
            dataType:"json"
        });
    }

    function querybreflesh(){
        var choosecopy = $("#copynum").text();

        $.ajax({
            type:"get",
            url:"/MBBench-U/simplequeryresult",
            async:true,
            data:{
                "type":"queryb",
                "copynum":choosecopy
            },
            success:function(data){
                $("#query4_count").text(data.query4_count);
                $("#query4_speed").text(data.query4_speed);
                $("#query4_time").text(data.query4_time);
                $("#query5_count").text(data.query5_count);
                $("#query5_speed").text(data.query5_speed);
                $("#query5_time").text(data.query5_time);
                $("#query6_count").text(data.query6_count);
                $("#query6_speed").text(data.query6_speed);
                $("#query6_time").text(data.query6_time);
                $("#query7_count").text(data.query7_count);
                $("#query7_speed").text(data.query7_speed);
                $("#query7_time").text(data.query7_time);
            },
            error:function() {
                $.notify({
                    icon: 'ti-bell',
                    message: "获取信息失败，请查验是否进行过此负载测试"
                },{
                    type: 'danger',
                    timer: 4000
                });
            },
            dataType:"json"
        });
    }

    function querycreflesh(){
        var choosecopy = $("#copynum").text();

        $.ajax({
            type:"get",
            url:"/MBBench-U/simplequeryresult",
            async:true,
            data:{
                "type":"queryc",
                "copynum":choosecopy
            },
            success:function(data){
                $("#query8_count").text(data.query8_count);
                $("#query8_speed").text(data.query8_speed);
                $("#query8_time").text(data.query8_time);
                $("#query8_rate").text(data.query8_rate + "%");
            },
            error:function() {
                $.notify({
                    icon: 'ti-bell',
                    message: "获取信息失败，请查验是否进行过此负载测试"
                },{
                    type: 'danger',
                    timer: 4000
                });
            },
            dataType:"json"
        });
    }
	</script>
</html>
