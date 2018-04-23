<%@page import="java.io.FileReader"%>
<%@page import="java.io.Reader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="utf-8" />
	<link rel="apple-touch-icon" sizes="76x76" href="img/apple-icon.png">
	<link rel="icon" type="image/png" sizes="96x96" href="img/favicon.png">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title>传输信息</title>

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
                    <a class="navbar-brand">数据传输结果信息-<%=session.getAttribute("databasetype") %></a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a href="resultshow.jsp" class="dropdown-toggle">
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
								<p>传输测试版本</p>
								<b class="caret"></b>
	                        </a>
							<ul class="dropdown-menu" id="copychoose">
								<%
                                    String dbInfoName = "";
									String zonglogpath = (String) session.getAttribute("logpath");
									String dbname = (String) session.getAttribute("databasetype");
									String logpath = zonglogpath + "/" + dbname;
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
								<%}else
								    {
										File[] dbInfoFile = new File(logpath).listFiles();
										int filecount = dbInfoFile.length;
	                              		for(int i = 1; i <= filecount; i++){
	                              		    dbInfoName = dbInfoFile[i-1].getName();
	                              			if(i < filecount){
	                              			File file = new File(logpath + "/" + dbInfoName + "/" + "dbinfo.txt");
	                              			if(!file.exists())
	                              			{
	                              				continue;
	                              			}
	                              			else
	                              			{
								%>
								<li value="<%=dbInfoName %>"><a href="javascript:void(0)" ><%=dbInfoName %></a></li>
								<%	}
								}
								else
								    {
								%>
								<li value="<%=dbInfoName %>"><a href="javascript:void(0)" ><%=dbInfoName %></a></li>

								<%	}

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
                <div class="row">
                	<div class="header">
                    		<h4 class="title">数据库基本信息<p id="copynum"><%=dbInfoName %></p></h4>
                    </div>
                    <div class="col-lg-3 col-sm-6">  
                    	<div class="card">
                            <div class="content">
                                <div class="row">
                                    <div class="col-xs-5">
                                        <div class="icon-big icon-warning text-center">
                                            <i class="ti-server"></i>
                                        </div>
                                    </div>
                                    <div class="col-xs-7">
                                        <div class="numbers">
                                            <p>数据库名称</p>
                                            <span id="dbusename"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-3 col-sm-6">  
                        <div class="card">
                            <div class="content">
                                <div class="row">
                                    <div class="col-xs-5">
                                        <div class="icon-big icon-warning text-center">
                                            <i class="ti-layers"></i>
                                        </div>
                                    </div>
                                    <div class="col-xs-7">
                                        <div class="numbers">
                                            <p>存储总量</p>
                                            <span id="storagesize"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>    
                    <div class="col-lg-3 col-sm-6">                  	
                        <div class="card">
                            <div class="content">
                                <div class="row">
                                    <div class="col-xs-5">
                                        <div class="icon-big icon-warning text-center">
                                            <i class="ti-pulse"></i>
                                        </div>
                                    </div>
                                    <div class="col-xs-7">
                                        <div class="numbers">
                                            <p>存储效率</p>
                                            <span id="databaserates"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6">
                        <div class="card">
                            <div class="content">
                                <div class="row">
                                    <div class="col-xs-5">
                                        <div class="icon-big icon-success text-center">
                                            <i class="ti-wallet"></i>
                                        </div>
                                    </div>
                                    <div class="col-xs-7">
                                        <div class="numbers">
                                            <p>存储文件</p>
                                            <span id="filesnum"></span>
                                        </div>
                                    </div>
                                </div>                               
                            </div>
                        </div>
                    </div>
                    <div class="header">
                    	<h4 class="title">传输测试基本信息</h4>
                    </div>
                    <div class="content table-responsive table-full-width" style="width:97%;margin: 0 auto;">
                                <table class="table table-striped" style="margin: 0 auto;">
                                    <thead>
                                        <th>编号</th>
                                    	<th>传输名称</th>
                                    	<th>传输用时</th>
                                    	<th>传输速度</th>
                                    </thead>
                                    <tbody>
                                        <tr>
                                        	<td>1</td>
                                        	<td>上传数据文件</td>
                                        	<td id="loadfiletime"></td>
                                        	<td id="loadfilespeed"></td>              	
                                        </tr>
                                        <tr>
                                        	<td>2</td>
                                        	<td>上传元数据文件</td>
                                        	<td id="loadmetatime"></td>
                                        	<td id="loadmetaspeed"></td>              	
                                        </tr>
                                        <tr>
                                        	<td>3</td>
                                        	<td>下载数据文件</td>
                                        	<td id="downfiletime"></td>
                                        	<td id="downfilespeed"></td>              	
                                        </tr>
                                        <tr>
                                        	<td>4</td>
                                        	<td>下载元数据文件</td>
                                        	<td id="downmetatime"></td>
                                        	<td id="downmetaspeed"></td>              	
                                        </tr>
                                    </tbody>
                            </table>
                      </div>
                </div>
                <div class="row">
                	<div class="header">
                    	<h4 class="title">文件上传折线图</h4>
                    </div>
                    <div class="col-md-12">
	                    	<div clas="row">
	                    		<div class="col-md-10">
	                    			<div id="loaddiv" class="nav-tabs-wrapper">
		        						<ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
		        							<li value="100"><a href="#100sdown" data-toggle="tab">100秒图</a></li>
		        							<li value="50"><a href="#50sdown" data-toggle="tab">50秒图</a></li>
		            						<li value="20"><a href="#20sdown" data-toggle="tab">20秒图</a></li>
		            						<li value="10"><a href="#10sdown" data-toggle="tab">10秒图</a></li>
		            						<li value="5"><a href="#5sdown" data-toggle="tab">5秒图</a></li>
		            						<li value="1"><a href="#1sdown" data-toggle="tab">1秒图</a></li>
		            						<li value="100000"><a href="#100ddown" data-toggle="tab">100节点图</a></li>
		            						<li value="50000"><a href="#50ddown" data-toggle="tab">50节点图</a></li>
		            						<li value="20000"><a href="#20ddown" data-toggle="tab">20节点图</a></li>
		            						<li value="10000"><a href="#10ddown" data-toggle="tab">10节点图</a></li>
		            						<li value="5000"><a href="#5ddown" data-toggle="tab">5节点图</a></li>
		            						<li value="1000"><a href="#1ddown" data-toggle="tab">1节点图</a></li>
		        						</ul>
		    						</div>  
	                    		</div>
	                    		<div class="col-md-1">
	                    			<input type="button" value="显示动态折线图" class="text-right" id="loadactive"/>
	                    		</div>
							</div>
	    					<hr/>
	                    	<div class="card">
	                        	<div class="g_12">
									<div class="widget_contents">
										<div class="realtime_charts" id="load"></div>
									</div>
								</div>
								<hr />
								<div class="content">
	       							<div id="loadchart" class="ct-chart"></div>
	       							<div class="footer">
	       								<div class="chart-legend">
	       									<input type="button" value="暂停" id="loadplay" style="display: none;"/>
	       									<input type="button" value="减速" id="loadslow" style="display: none;"/>
	       									<i class="fa fa-circle text-info"></i><span id="maxloadchart"></span>
	       									<i class="fa fa-circle text-danger"></i><span id="minloadchart"></span>
	       									<input type="button" value="加速" id="loadfast" style="display: none;"/>
	       								 	<input type="button" value="初始速度" id="loadreset" style="display: none;"/>
	       								</div>
	       							</div>
	       						</div>
	                        </div>
	                    </div>
                </div>
                <div class="row">
                	<div class="header">
                    	<h4 class="title">元数据上传折线图</h4>
                    </div>
                    <div class="col-md-12">
	                    <div clas="row">
	                    	<div class="col-md-10">
	                    		<div class="nav-tabs-navigation">
			    					<div id="loadmetadiv" class="nav-tabs-wrapper">
			        					<ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
			        						<li value="50"><a  data-toggle="tab">50秒图</a></li>
			            					<li value="20"><a href="#20sdownmeta" data-toggle="tab">20秒图</a></li>
			            					<li value="10"><a href="#10sdownmeta" data-toggle="tab">10秒图</a></li>
			            					<li value="5"><a href="#5sdownmeta" data-toggle="tab">5秒图</a></li>
			            					<li value="1"><a href="#1sdownmeta" data-toggle="tab">1秒图</a></li>
			        					</ul>
			    					</div>   						
								</div>
	                    	</div>
	                    	<div class="col-md-1">
	                   			<input type="button" value="显示动态折线图" class="text-right" id="loadmetaactive"/>
	                   		</div>
						</div>
	    				<hr/>
	                   	<div class="card">
	                       	<div class="g_12">
								<div class="widget_contents">
									<div class="realtime_charts" id="loadmeta"></div>
								</div>
							</div>
							<hr />
							<div class="content">
	       						<div id="loadmetachart" class="ct-chart"></div>
	       						<div class="footer">
	       							<div class="chart-legend">
	       								<input type="button" value="暂停" id="loadmetaplay" style="display: none;"/>
	       								<input type="button" value="减速" id="loadmetaslow" style="display: none;"/>
	       								<i class="fa fa-circle text-info"></i><span id="maxloadmetachart"></span>
	       								<i class="fa fa-circle text-danger"></i><span id="minloadmetachart"></span>
	       								<input type="button" value="加速" id="loadmetafast" style="display: none;"/>
	       							 	<input type="button" value="初始速度" id="loadmetareset" style="display: none;"/>
	       							</div>
	       						</div>
	       					</div>
	                    </div>
	                </div>
                </div>
                
                <div class="row">
	                	<div class="header">
	                    	 <h4 class="title">文件下载折线图</h4>
	                    </div>
	               		
	                    <div class="col-md-12">
	                    	<div clas="row">
	                    		<div class="col-md-10">
	                    			<div id="downdiv" class="nav-tabs-wrapper">
		        						<ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
		        							<li value="100"><a href="#100sdown" data-toggle="tab">100秒图</a></li>
		        							<li value="50"><a href="#50sdown" data-toggle="tab">50秒图</a></li>
		            						<li value="20"><a href="#20sdown" data-toggle="tab">20秒图</a></li>
		            						<li value="10"><a href="#10sdown" data-toggle="tab">10秒图</a></li>
		            						<li value="5"><a href="#5sdown" data-toggle="tab">5秒图</a></li>
		            						<li value="1"><a href="#1sdown" data-toggle="tab">1秒图</a></li>
		            						<li value="100000"><a href="#100ddown" data-toggle="tab">100节点图</a></li>
		            						<li value="50000"><a href="#50ddown" data-toggle="tab">50节点图</a></li>
		            						<li value="20000"><a href="#20ddown" data-toggle="tab">20节点图</a></li>
		            						<li value="10000"><a href="#10ddown" data-toggle="tab">10节点图</a></li>
		            						<li value="5000"><a href="#5ddown" data-toggle="tab">5节点图</a></li>
		            						<li value="1000"><a href="#1ddown" data-toggle="tab">1节点图</a></li>
		        						</ul>
		    						</div>  
	                    		</div>
	                    		<div class="col-md-1">
	                    			<input type="button" value="显示动态折线图" class="text-right" id="downactive"/>
	                    		</div>
							</div>
	    					<hr/>
	                    	<div class="card">
	                        	<div class="g_12">
									<div class="widget_contents">
										<div class="realtime_charts" id="down"></div>
									</div>
								</div>
								<hr />
								<div class="content">
	       							<div id="downchart" class="ct-chart"></div>
	       							<div class="footer">
	       								<div class="chart-legend">
	       									<input type="button" value="暂停" id="downplay" style="display: none;"/>
	       									<input type="button" value="减速" id="downslow" style="display: none;"/>
	       									<i class="fa fa-circle text-info"></i><span id="maxdownchart"></span>
	       									<i class="fa fa-circle text-danger"></i><span id="mindownchart"></span>
	       									<input type="button" value="加速" id="downfast" style="display: none;"/>
	       								 	<input type="button" value="初始速度" id="downreset" style="display: none;"/>
	       								</div>
	       							</div>
	       						</div>
	                        </div>
	                    </div>
	                </div>
                
                <div class="row">
	                	<div class="header">
	                    	 <h4 class="title">元数据下载折线图</h4>
	                    </div>
	               		
	                    <div class="col-md-12">
	                    	<div clas="row">
	                    		<div class="col-md-10">
	                    			<div class="nav-tabs-navigation">
			    						<div id="downmetadiv" class="nav-tabs-wrapper">
			        						<ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
			        							<li value="50"><a href="#50sdownmeta" data-toggle="tab">50秒图</a></li>
			            						<li value="20"><a href="#20sdownmeta" data-toggle="tab">20秒图</a></li>
			            						<li value="10"><a href="#10sdownmeta" data-toggle="tab">10秒图</a></li>
			            						<li value="5"><a href="#5sdownmeta" data-toggle="tab">5秒图</a></li>
			            						<li value="1"><a href="#1sdownmeta" data-toggle="tab">1秒图</a></li>
			        						</ul>
			    						</div>   						
									</div>
	                    		</div>
	                    		<div class="col-md-1">
	                    			<input type="button" value="显示动态折线图" class="text-right" id="downmetaactive"/>
	                    		</div>
							</div>
	    					<hr/>
	                    	<div class="card">
	                        	<div class="g_12">
									<div class="widget_contents">
										<div class="realtime_charts" id="downmeta"></div>
									</div>
								</div>
								<hr />
								<div class="content">
	       							<div id="downmetachart" class="ct-chart"></div>
	       							<div class="footer">
	       								<div class="chart-legend">
	       									<input type="button" value="暂停" id="downmetaplay" style="display: none;"/>
	       									<input type="button" value="减速" id="downmetaslow" style="display: none;"/>
	       									<i class="fa fa-circle text-info"></i><span id="maxdownmetachart"></span>
	       									<i class="fa fa-circle text-danger"></i><span id="mindownmetachart"></span>
	       									<input type="button" value="加速" id="downmetafast" style="display: none;"/>
	       								 	<input type="button" value="初始速度" id="downmetareset" style="display: none;"/>
	       								</div>
	       							</div>
	       						</div>
	                        </div>
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
	var loads = 0;
	var loadmetas = 0;
	var downs = 0;
	var downmetas = 0;
	$(function(){
		var choosecopy = $("#copynum").text();
		$.ajax({
			type:"post",
			url:"/MBBench-U/result",
			async:true,
			data:{"copynum":choosecopy, "type":"dbinfo"},
			success:function(data){
				$("#dbusename").text(data.dbname);
				$("#storagesize").text(data.storagesize + "GB");
				$("#databaserates").text(data.rates + "%");
				$("#filesnum").text(data.filenum + "个");
				$("#loadfiletime").text(data.loadfiletime);
				$("#loadfilespeed").text(data.loadfilespeed);
				$("#loadmetatime").text(data.loadmetatime);
				$("#loadmetaspeed").text(data.loadmetaspeed);
				$("#downfiletime").text(data.downfiletime);
				$("#downfilespeed").text(data.downfilespeed);
				$("#downmetatime").text(data.downmetatime);
				$("#downmetaspeed").text(data.downmetaspeed);
			},
			error:function(){
                new $.flavr({
                    content     : '没有检测到测试结果文件，请确认数据上传与数据下载负载是否均执行',
                    buttons     : {
                        primary : { text: '数据上传负载测试', style: 'primary',
                            action: function(){
                                $(location).attr('href', 'translationworkload.jsp');
                            }
                        },
                        info    : { text: '数据下载负载测试', style: 'info',
                            action: function(){
                                (location).attr('href', 'transdownworkload.jsp');
                            }
                        },
                        close   : { text:'取消',style: 'default' }
                    }
                });
			},
			dataType:"json"
		});

		var loadactive = 0;
		var loadmetaactive = 0;
		var downactive = 0;
		var downmetaactive = 0;
		$("#loaddiv ul li").bind('click', function(){
			loadactive = 0;
			$("#loadactive").attr('value','显示动态折线图');
			$("#loadplay").attr('value','暂停');
			$("#loadplay").hide();
			$("#loadfast").hide();
			$("#loadslow").hide();
			$("#loadreset").hide();
			loads = parseInt($(this).val());
			var copynum = $("#copynum").text();
			if(work != null){
				clearInterval(work);
				work == null;
			}
			loadfilechart(loads, loadactive, copynum, 0);
		});
		
		$("#loadactive").bind('click', function(){
			var type = $(this).val();
			var copynum = $("#copynum").text();
			if(type == "显示动态折线图"){
				loadactive = 1;
				$(this).attr('value','显示静态折线图');
				$("#loadplay").show();
				$("#loadfast").show();
				$("#loadslow").show();
				$("#loadreset").show();
				
			}
			else{
				loadactive = 0;
				$(this).attr('value','显示动态折线图');
				$("#loadplay").attr('value','暂停');
				$("#loadplay").hide();
				$("#loadfast").hide();
				$("#loadslow").hide();
				$("#loadreset").hide();
			}
			if(work != null){
				clearInterval(work);
				work == null;
			}
			loadfilechart(loads, loadactive, copynum, 0);
		});
		
		$("#loadplay").bind('click', function(){
			if($(this).val() == "暂停")
			{
				clearInterval(work);
				work = null;
				loadactive = 0;
				$(this).val("继续");
			}
			else
			{
				var copynum = $("#copynum").text();
				loadactive = 1;
				loadfilechart(loads, loadactive, copynum, 1);
				$(this).val("暂停");
			}
		});
		
		$("#loadslow").bind('click', function(){
			var copynum = $("#copynum").text();
			clearInterval(work);
			work = null;
			loadactive = 1;
			speed_factor = speed_factor * 1.5;
			loadfilechart(loads, loadactive, copynum, 1);
			$("#loadplay").val("暂停");
		});
		
		$("#loadfast").bind('click', function(){
			var copynum = $("#copynum").text();
			clearInterval(work);
			work = null;
			loadactive = 1;
			speed_factor = speed_factor * 0.5;
			loadfilechart(loads, loadactive, copynum, 1);
			$("#loadplay").val("暂停");
		});
		
		$("#loadreset").bind('click', function(){
			var copynum = $("#copynum").text();
			clearInterval(work);
			work = null;
			loadactive = 1;
			speed_factor = 1;
			loadfilechart(loads, loadactive, copynum, 1);
			$("#loadplay").val("暂停");
		});
		
		$("#loadmetadiv ul li").bind('click', function(){
			loadmetaactive = 0;
			$("#loadmetaactive").attr('value','显示动态折线图');
			$("#loadmetaplay").attr('value','暂停');
			$("#loadmetaplay").hide();
			$("#loadmetafast").hide();
			$("#loadmetaslow").hide();
			$("#loadmetareset").hide();
			loadmetas = parseInt($(this).val());
			var copynum = $("#copynum").text();
			if(work != null){
				clearInterval(work);
				work == null;
			}
			loadmetachart(loadmetas, loadmetaactive, copynum, 0);
		});
		
		$("#loadmetaactive").bind('click', function(){
			var type = $(this).val();
			var copynum = $("#copynum").text();
			if(type == "显示动态折线图"){
				loadmetaactive = 1;
				$(this).attr('value','显示静态折线图');
				$("#loadmetaplay").show();
				$("#loadmetafast").show();
				$("#loadmetaslow").show();
				$("#loadmetareset").show();
			}
			else{
				loadmetaactive = 0;
				$(this).attr('value','显示动态折线图');
				$("#loadmetaplay").attr('value','暂停');
				$("#loadmetaplay").hide();
				$("#loadmetafast").hide();
				$("#loadmetaslow").hide();
				$("#loadmetareset").hide();
			}
			if(work != null){
				clearInterval(work);
				work == null;
			}
			loadmetachart(loadmetas, loadmetaactive, copynum, 0);
		});
		
		$("#loadmetaplay").bind('click', function(){
			if($(this).val() == "暂停")
			{
				clearInterval(work);
				work = null;
				loadmetaactive = 0;
				$(this).val("继续");
			}
			else
			{
				var copynum = $("#copynum").text();
				loadmetaactive = 1;
				loadmetachart(loadmetas, loadmetaactive, copynum, 1);
				$(this).val("暂停");
			}
		});
		
		$("#loadmetaslow").bind('click', function(){
			var copynum = $("#copynum").text();
			clearInterval(work);
			work = null;
			loadmetaactive = 1;
			speed_factor = speed_factor * 1.5;
			loadmetachart(loadmetas, loadmetaactive, copynum, 1);
			$("#loadmetaplay").val("暂停");
		});
		
		$("#loadmetafast").bind('click', function(){
			var copynum = $("#copynum").text();
			clearInterval(work);
			work = null;
			loadmetaactive = 1;
			speed_factor = speed_factor * 0.5;
			loadmetachart(loadmetas, loadmetaactive, copynum, 1);
			$("#loadmetaplay").val("暂停");
		});
		
		$("#loadmetareset").bind('click', function(){
			var copynum = $("#copynum").text();
			clearInterval(work);
			work = null;
			loadmetaactive = 1;
			speed_factor = 1;
			loadmetachart(loadmetas, loadmetaactive, copynum, 1);
			$("#loadmetaplay").val("暂停");
		});
		
		$("#downdiv ul li").bind('click', function(){
			downactive = 0;
			$("#downactive").attr('value','显示动态折线图');
			$("#downplay").attr('value','暂停');
			$("#downplay").hide();
			$("#downfast").hide();
			$("#downslow").hide();
			$("#downreset").hide();
			downs = parseInt($(this).val());
			var copynum = $("#copynum").text();
			if(work != null){
				clearInterval(work);
				work == null;
			}
			downfilechart(downs, downactive, copynum, 0);
		});
		
		$("#downactive").bind('click', function(){
			var type = $(this).val();
			var copynum = $("#copynum").text();
			if(type == "显示动态折线图"){
				downactive = 1;
				$(this).attr('value','显示静态折线图');
				$("#downplay").show();
				$("#downfast").show();
				$("#downslow").show();
				$("#downreset").show();
				
			}
			else{
				downactive = 0;
				$(this).attr('value','显示动态折线图');
				$("#downplay").attr('value','暂停');
				$("#downplay").hide();
				$("#downfast").hide();
				$("#downslow").hide();
				$("#downreset").hide();
			}
			if(work != null){
				clearInterval(work);
				work == null;
			}
			downfilechart(downs, downactive, copynum, 0);
		});
		
		$("#downplay").bind('click', function(){
			if($(this).val() == "暂停")
			{
				clearInterval(work);
				work = null;
				downactive = 0;
				$(this).val("继续");
			}
			else
			{
				var copynum = $("#copynum").text();
				downactive = 1;
				downfilechart(downs, downactive, copynum, 1);
				$(this).val("暂停");
			}
		});
		
		$("#downslow").bind('click', function(){
			var copynum = $("#copynum").text();
			clearInterval(work);
			work = null;
			downactive = 1;
			speed_factor = speed_factor * 1.5;
			downfilechart(downs, downactive, copynum, 1);
			$("#downplay").val("暂停");
		});
		
		$("#downfast").bind('click', function(){
			var copynum = $("#copynum").text();
			clearInterval(work);
			work = null;
			downactive = 1;
			speed_factor = speed_factor * 0.5;
			downfilechart(downs, downactive, copynum, 1);
			$("#downplay").val("暂停");
		});
		
		$("#downreset").bind('click', function(){
			var copynum = $("#copynum").text();
			clearInterval(work);
			work = null;
			downactive = 1;
			speed_factor = 1;
			downfilechart(downs, downactive, copynum, 1);
			$("#downplay").val("暂停");
		});
		
		$("#downmetadiv ul li").bind('click', function(){
			downmetaactive = 0;
			$("#downmetaactive").attr('value','显示动态折线图');
			$("#downmetaplay").attr('value','暂停');
			$("#downmetaplay").hide();
			$("#downmetafast").hide();
			$("#downmetaslow").hide();
			$("#downreset").hide();
			downmetas = parseInt($(this).val());
			var copynum = $("#copynum").text();
			if(work != null){
				clearInterval(work);
				work == null;
			}
			downmetachart(downmetas, downmetaactive, copynum, 0);
		});
		
		$("#downmetaactive").bind('click', function(){
			var type = $(this).val();
			var copynum = $("#copynum").text();
			if(type == "显示动态折线图"){
				downmetaactive = 1;
				$(this).attr('value','显示静态折线图');
				$("#downmetaplay").show();
				$("#downmetafast").show();
				$("#downmetaslow").show();
				$("#downmetareset").show();
			}
			else{
				downmetaactive = 0;
				$(this).attr('value','显示动态折线图');
				$("#downmetaplay").attr('value','暂停');
				$("#downmetaplay").hide();
				$("#downmetafast").hide();
				$("#downmetaslow").hide();
				$("#downmetareset").hide();
			}
			if(work != null){
				clearInterval(work);
				work == null;
			}
			downmetachart(downmetas, downmetaactive, copynum, 0);
		});
		
		$("#downmetaplay").bind('click', function(){
			if($(this).val() == "暂停")
			{
				clearInterval(work);
				work = null;
				downmetaactive = 0;
				$(this).val("继续");
			}
			else
			{
				var copynum = $("#copynum").text();
				downmetaactive = 1;
				downmetachart(downmetas, downmetaactive, copynum, 1);
				$(this).val("暂停");
			}
		});
		
		$("#downmetaslow").bind('click', function(){
			var copynum = $("#copynum").text();
			clearInterval(work);
			work = null;
			downmetaactive = 1;
			speed_factor = speed_factor * 1.5;
			downmetachart(downmetas, downmetaactive, copynum, 1);
			$("#downmetaplay").val("暂停");
		});
		
		$("#downmetafast").bind('click', function(){
			var copynum = $("#copynum").text();
			clearInterval(work);
			work = null;
			downmetaactive = 1;
			speed_factor = speed_factor * 0.5;
			downmetachart(downmetas, downmetaactive, copynum, 1);
			$("#downmetaplay").val("暂停");
		});
		
		$("#downmetareset").bind('click', function(){
			var copynum = $("#copynum").text();
			clearInterval(work);
			work = null;
			downmetaactive = 1;
			speed_factor = 1;
			downmetachart(downmetas, downmetaactive, copynum, 1);
			$("#downmetaplay").val("暂停");
		});
		
		$("#copychoose li").bind('click', function(){
			choosecopy = $(this).text();
			$("#copynum").text(choosecopy);
			$.ajax({
				type:"post",
				url:"/MBBench-U/result",
				async:true,
				data:{"copynum":choosecopy, "type":"dbinfo"},
				success:function(data){
					$("#dbusename").text(data.dbname);
					$("#storagesize").text(data.storagesize + "GB");
					$("#databaserates").text(data.rates + "%");
					$("#filesnum").text(data.filenum + "个");
					$("#loadfiletime").text(data.loadfiletime);
					$("#loadfilespeed").text(data.loadfilespeed);
					$("#loadmetatime").text(data.loadmetatime);
					$("#loadmetaspeed").text(data.loadmetaspeed);
					$("#downfiletime").text(data.downfiletime);
					$("#downfilespeed").text(data.downfilespeed);
					$("#downmetatime").text(data.downmetatime);
					$("#downmetaspeed").text(data.downmetaspeed);
				},
				error:function(){
                    new $.flavr({
                        content     : '没有检测到测试结果文件，请确认数据上传与数据下载负载是否均执行',
                        buttons     : {
                            primary : { text: '数据上传负载测试', style: 'primary',
                                action: function(){
                                    $(location).attr('href', 'translationworkload.jsp');
                                }
                            },
                            info    : { text: '数据下载负载测试', style: 'info',
                                action: function(){
                                    (location).attr('href', 'transdownworkload.jsp');
                                }
                            },
                            close   : { text:'取消',style: 'default' }
                        }
                    });
				},
				dataType:"json"
			});
		});
		
	});
	
	function loadfilechart(s, loadactive, copynum, p){
		draw(s, loadactive, "load", copynum, p);
	}
	
	function loadmetachart(s, loadmetaactive, copynum, p){
		draw(s, loadmetaactive, "loadmeta", copynum, p);
	}
	
	function downfilechart(s, downactive, copynum, p){
		draw(s, downactive, "down", copynum, p);
	}
	
	function downmetachart(s, downmetaactive, copynum, p){
		draw(s, downmetaactive, "downmeta", copynum, p);
	}
	
	function draw(s, active, charttype, copynum, processtype)
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
			url:"/MBBench-U/result",
			async:true,
			data:{"interval":s, "type":"draw", "charttype":charttype, "copynum":copynum},
			success:function(data)
			{
				var dataObj = data;
				$.each(dataObj, function(index, item)
				{
					flow.push(parseFloat(item.speed));
				});
				interval = parseInt(flow.pop());
				loadmax = flow.max();
				$("#max" + charttype + "chart").text("最大值："+loadmax.toFixed(2));
				loadmin = flow.min();
				$("#min" + charttype + "chart").text("最小值："+loadmin.toFixed(2));

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
					var realtime = $.plot($("#" + charttype), [{label: "speed", data: getshuzu()}],
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
					var realtime = $.plot($("#" + charttype), [{label: "speed", data: getallshuzu()}],
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
	</script>
</html>
