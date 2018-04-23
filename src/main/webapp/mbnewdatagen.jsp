<%@page import="java.io.*"%>
<%@ page import="java.net.URL" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<link rel="apple-touch-icon" sizes="76x76" href="img/apple-icon.png">
	<link rel="icon" type="image/png" sizes="96x96" href="img/favicon.png">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title>海量文件生成</title>

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
	
	<style type="text/css">
		.dlk-radio input[type="radio"],
		.dlk-radio input[type="checkbox"] 
		{
			margin-left:-99999px;
			display:none;
		}
		.dlk-radio input[type="radio"] + .fa ,
		.dlk-radio input[type="checkbox"] + .fa {
     		opacity:0.15
		}
		.dlk-radio input[type="radio"]:checked + .fa,
		.dlk-radio input[type="checkbox"]:checked + .fa{
    		opacity:1
		}
	</style>
</head>
<body>

<div class="wrapper">
	<div class="sidebar" data-background-color="white" data-active-color="danger">
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
                <li class="active">
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
                <li>
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
                    <a class="navbar-brand" href="#">海量文件生成</a>
                </div>
                <div class="collapse navbar-collapse">
                </div>
            </div>
        </nav>


        <div class="content">
            <div class="container-fluid">
                <div class="row">
                	<div class="col-lg-8 col-md-7">
                        <div class="card">
                        	<div class="col-md-12">
                            	<div class="form-group">
                                	<label>&nbsp</label>
                                    <div class="alert alert-info">                                    
                                    	<span>带<b>*</b>的地方为必填的内容；带<b>#</b>的地方为初次设置必填的内容；其余位置为使用过去设置信息所需填写内容</span>
                                	</div> 
                                </div>
                            </div>
                            <div class="header">
                                <h4 class="title">基本参数设置</h4>
                            </div>
                            <div class="content">
                                <div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>*输入文件存储总路径</label>
                                                <input id="filepath" type="text" class="form-control border-input" placeholder="请输入路径" />
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>*选择元数据的生成类型</label>                                              
                                                <div class="container">
                                                	<div  class="dlk-radio btn-group">
                                    					<label class="btn btn-default">
	       	`												<input name="metatype" class="form-control" type="checkbox" value="txt" defaultchecked="checked">
	       													<i class="fa fa-check glyphicon glyphicon-ok"></i>
	       													txt
       													</label>
        												<label class="btn btn-info">
	       													<input name="metatype" class="form-control" type="checkbox" value="json">
	       													<i class="fa fa-check glyphicon glyphicon-ok"></i>
	       													json
       													</label>
	   													<label class="btn btn-warning">
	       													<input name="metatype" class="form-control" type="checkbox" value="xml">
	       													<i class="fa fa-check glyphicon glyphicon-ok"></i>
	       													xml
       													</label>
                                   					</div>
                                   				</div> 
                                            </div>
                                        </div>                          
                                    </div>

                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>#设置设备数量</label>
                                                <input id="devicenum" type="number" class="form-control border-input" placeholder="数量建议不要过小" />
                                            </div>
                                        </div> 
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>#设置文件数量</label>
                                                <input id="eachfiles" type="number" class="form-control border-input" placeholder="单个设备生成数量" />
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>#设置更新文件数量</label>
                                                <input id="changenum" type="number" class="form-control border-input" placeholder="数量要小于文件数量"/>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>#设置异常文件占比</label>
                                                <input id="unnormal" type="number" class="form-control border-input" placeholder="例如：10" />
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>#设置塔架高度区间</label>
                                                <input id="towerheigh" type="text" class="form-control border-input" placeholder="如40-45" value=""/>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>#设置扇叶长度区间</label>
                                                <input id="bladelength" type="text" class="form-control border-input" placeholder="如60-80" value=""/>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>#设置扇叶宽度区间</label>
                                                <input id="bladewidth" type="text" class="form-control border-input" placeholder="如20-25" value=""/>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                            	<label>使用已有的配置</label>
                                            	<input type="button" class="btn btn-info btn-wd" onclick="checkhide()" id="usedcheck" value="使用" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="header">
                            	<h4 class="title">仿真文件大小设置</h4>
                            </div>
                            <div class="content">
                            	<div class="row">
									<div class="col-md-3">
                                        <div class="form-group">
                                            <label>#设置文件分配数量</label>
                                            <input id="filesizenum" type="number" class="form-control border-input" placeholder="请输入最大容量" />
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label>生成设置文件控件</label>
                                            <input id="confirmsize" type="button" class="btn btn-info btn-wd" onclick="filesizeconfirm()" value="生成设置控件" />
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>&nbsp</label>
                                            <div class="alert alert-info" style="text-align:center;">                                    
                                				<span>如需重新设置，请刷新页面</span>
                                			</div> 
                                        </div>
                                    </div>
                                </div>
                                <div id="filesizeget">       	
                                </div>                                
                           	</div>
                            <div class="header">
                            	<h4 id="usetitle"  class="title">仿真时间设置</h4>
                            </div>
                            <div class="content">
                            	<div id="notused">
									<div class="row">
										<div class="col-md-3">
                                            <div class="form-group">
                                                <label>#仿真开始时间（日期）</label>
                                                <input id="simustartdate" type="date" class="form-control border-input" value="2015-09-24"/>
                                            </div>
                                        </div>
										<div class="col-md-3">
                                            <div class="form-group">
                                                <label>#仿真开始时间（时）</label>
                                                <input id="simustarthour" type="number" class="form-control border-input" placeholder="请输入小时" value="0"/>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>#仿真开始时间（分）</label>
                                                <input id="simustartmins" type="number" class="form-control border-input" placeholder="请输入分钟" value="0"/>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>#仿真开始时间（秒）</label>
                                                <input id="simustartsecs" type="number" class="form-control border-input" placeholder="请输入秒钟" value="0"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                    	<div class="col-md-3">
                                            <div class="form-group">
                                                <label>#仿真结束时间（日期）</label>
                                                <input id="simuenddate" type="date" class="form-control border-input" value="2015-09-24"/>
                                            </div>
                                        </div>
										<div class="col-md-3">
                                            <div class="form-group">
                                                <label>#仿真结束时间（时）</label>
                                                <input id="simuendhour" type="number" class="form-control border-input" placeholder="请输入小时" value="0"/>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>#仿真结束时间（分）</label>
                                                <input id="simuendmins" type="number" class="form-control border-input" placeholder="请输入分钟" value="0"/>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>#仿真结束时间（秒）</label>
                                                <input id="simuendsecs" type="number" class="form-control border-input" placeholder="请输入秒钟" value="0"/>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label>&nbsp</label>
                                                <div class="alert alert-info">                                    
                                    				<span>具体文件参数设置，请到Settings目录下的peizhi.xml内设置</span>
                                				</div> 
                                            </div>
                                        </div>
                                    </div>
                                    <div class="text-center">
                                    	<input type="button" class="btn btn-info btn-fill btn-wd" value="刷新信息" onclick="refresh()" />&nbsp&nbsp&nbsp&nbsp
                                        <input id="btnSubmit" type="button" class="btn btn-info btn-fill btn-wd" value="生成文件" onclick="datagen()" />
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div id="isused" style="display: none;">
									<div class="row">
										<div class="col-md-12">
                                            <div class="form-group">
                                                <label>当前已有的仿真配置文件</label>
                                                <div class="nav-tabs-navigation">
    												<div class="nav-tabs-wrapper">
    												<%
    													//File ss = new File("../webapps/GHBigBench/HistorySettings")
                                                        String jspPath = application.getRealPath("/");
                                                        File ss = new File(jspPath + "\\WEB-INF\\classes\\HistorySettings");
    													//File ss = new File("/HistorySettings");
    													if(!ss.exists())
    														ss.mkdirs();
    													File filelistFile[] = ss.listFiles();
    													if(filelistFile.length > 0)
    													{							
    												%>
    													<ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
    												<% 
    														File files = null;
    														for(int i = 0; i < 5 && filelistFile.length - 1 - i >= 0; i++)
    														{
    															files = filelistFile[filelistFile.length - 1 - i];
    															if(i == 0)
    															{
    												%>
            												<li class="active"><a href="#<%=i %>" data-toggle="tab"><%=files.getName().split(".txt")[0] %></a></li>
        											<%			}
    															else
    															{
    															%>
    															<li><a href="#<%=i %>" data-toggle="tab"><%=files.getName().split(".txt")[0] %></a></li>
    														<%
    															}
    														}
        											%>
        												</ul>
    												</div>
												</div>
												<div id="my-tab-content" class="tab-content text-center">
													<%
															for(int i = 0; i < 5 && filelistFile.length - 1 - i >= 0; i++)
															{
																files = filelistFile[filelistFile.length - 1 - i];
																BufferedReader bfR = new BufferedReader(new InputStreamReader(new FileInputStream(files), "GB2312"));
																String str = null;
																String allstr = "\r";
																while((str = bfR.readLine()) != null)
																	allstr += str + "\n";
																if(i == 0)
																{
													%>
														<textarea class="tab-pane active" id="<%=i %>" style="scrollbar-3dlight-color: grey; scrollbar-base-color: #00BBFF; width: 90%; height: 200px;">
															<%=allstr %>
														</textarea>
    												<%
    															}
																else
																{
    												%>
    												<textarea class="tab-pane" id="<%=i %>" style="scrollbar-3dlight-color: grey; scrollbar-base-color: #00BBFF; width: 90%; height: 200px;">
														<%=allstr %>
													</textarea>
    												<%		
    															}
    														} 
    													}
    													else
    													{
    												%>
    												</div>
    													<div class="col-md-12">
                                            				<div class="form-group">
                                                				<label>&nbsp</label>
                                            					<div class="alert alert-info" style="text-align:center;">                                    
                                                                    <span><%="未检测到/HistorySettings文件夹下有仿真生成设置文件，请查证后再点击" %></span><hr/>
                                								</div>
                                            				</div>
                                        				</div>
    												<%	
    													}
    												%>
												</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                    	<div class="col-md-12">
                                            <div class="form-group">
                                    			<label>选择数据生成内容</label>
                                    			<div>
                                    				<label class="radio-inline">
        												<input type="radio" name="usedselect" id="usedusual" value="usual">按照原设置文件数量继续生成
    												</label>
                                    				<label class="radio-inline">
        												<input type="radio" name="usedselect" id="usedupdate" value="update">按照新设置的文件数量生成
    												</label>
                                   				</div> 
                                    		</div>
                                    	</div>
                                    </div>
                                    <div class="row">
                                    	<div id="update" style="display: none;">
                                    		<div class="col-md-4">
                                            	<div class="form-group">
                                                	<label>生成文件数量</label>
                                                	<input id="usedupdatenum" type="number" class="form-control border-input"/>
                                            	</div>
                                        	</div>
                                        	<div class="col-md-4">
                                        	    <div class="form-group">
                                        	        <label>&nbsp</label>
                                        	       	<div class="alert alert-info">                                    
                                    					<span>文件路径为前面已设置的内容</span>
                                					</div>
                                        	    </div>
                                       	 	</div>
											<div class="col-md-4">
                                        	    <div class="form-group">
                                        	        <label>&nbsp</label>
                                        	       	<div class="alert alert-warning">                                    
                                    					<span>不可超过文件内的文件生成设置数</span>
                                					</div>
                                        	    </div>
                                       	 	</div>
                                    	</div>
                                   	</div>
                                    <div class="clearfix"></div>
                                    <div class="text-center">                               
                                    	<input type="button" class="btn btn-info btn-fill btn-wd" value="确认信息" onclick="usedrefresh()" />&nbsp&nbsp&nbsp&nbsp
                                        <input id="usedbtn" type="button" class="btn btn-info btn-fill btn-wd" value="生成文件" onclick="useddatagen()" />
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            </div>                          
                        </div>
                    </div>             
                    
                    <div class="col-lg-4 col-md-5">
                    	<div class="card">
                            <div class="header">
                                <h4 class="title">海量文件生成工具介绍</h4>
                            </div>
                            <div class="content">
                            	<p class="description text-center">
                                	海量文件生成工具是一款贴合大数据的特点，
					专门生成海量小文件的数据生成器，可用作非结构化数据库及文件管理系统的评测导入数据。
					通过使用此文件生成系统，用户可以在较短的时间内，生成一定规模的小型不可读文件及该文
					件的元数据文件，减少用户收集数据的时间。其中元数据文件的格式包含当今主流的非结构化
					数据库的元数据格式，用户无需更正便可将相应格式的元数据文件导入到数据库内。
                               </p>
                          	</div>
                       </div>
                        <div class="card card-user">
                            <div class="content">
                                <div class="author">
                                  <div class="avatar"></div>
                                  <h4 class="title">生成文件信息<br />
                                  </h4>
                                </div>
                                <br />
                                <p class="description text-center">
                                	当数据均设置完毕，请点击刷新信息<br />
                                	会根据所设置内容，显示数据生成信息
                                </p>
                            </div>
                            <hr>
                            <div class="text-center">
                                <div class="row">
                                    <div class="col-md-5 col-md-offset-1">
                                        <h5 id="filesshow">&nbsp<br /><small>文件数量</small></h5>
                                        
                                    </div>
                                    <div class="col-md-5">
                                        <h5 id="sizesshow">&nbsp<br /><small>存储容量</small></h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div id="status" style="display: none;">
                    	<div class="col-lg-8 col-md-7">
                        	<div class="card">
                        	    <div class="header">
                           	    	<h4 class="title">实时生成信息</h4>
                            	</div>
                            	<div class="content">
                                	<div>
                                    	<div class="row">
                                        	<div class="col-md-12">
                                            	<div class="form-group">
                                                	<label>实时进度条</label>
                                                	<div class="progress" id="progressBar">
														<div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="0%" aria-valuemin="0" aria-valuemax="100" style="width: 0%;" id="progressBarItem">
															<p id="process">0%</p>
														</div>
													</div>
                                            	</div>
                                        	</div>                           
                                    	</div>

                                    	<div class="row">
                                        	<div id="statusInfo" class="content">
												<label>存储总文件的总路径为：</label><span id="filepathshow"></span><br />
        										<label>总共二进制文件数量为：</label><span id="fileallnum"></span><br />
        										<label>生成二进制文件数量为：</label><span id="filenum"></span><br />
         										<label>当前剩余的文件数量为：</label><span id="fileneednum"></span><br />
         										<label>当前生成文件的速度为：</label><span id="filegenspeednum"></span><br />
         										<label>当前生成文件的速度为：</label><span id="filegenspeedsize"></span><br />
         										<label>当前已经消耗的时间为： </label><span id="hadtime"></span><br />
         										<label>当前预计结束的时间为： </label><span id="needtime"></span><br />
											</div>
                                    	</div>
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
	<!--  Notifications Plugin    -->
    <script src="js/bootstrap-notify.js"></script>
    <!-- Paper Dashboard Core javascript and methods for Demo purpose -->
    <script src="js/paper-dashboard.js"></script>
	<script type="text/javascript" src="js/newprogressbar.js" ></script>
	<script type="text/javascript" src="js/common.js" ></script>
	<script type="text/javascript" src="js/flavr.min.js" ></script>
	<script type="text/javascript">
		$(function(){		
			var dd = new Date(), date= '';
			date += dd.getFullYear() + '-';
			if((dd.getMonth() + 1) < 10)
				date += '0' + (dd.getMonth() + 1) + '-';
			else
				date += (dd.getMonth() + 1) + '-'; 
			if(dd.getDate() < 10)
				date += '0' + dd.getDate();
			else				
				date += dd.getDate();
			$("#simustartdate").val(date);
			$("#simuenddate").val(date);
			
			$("#usedcheck").css("background-color", "pink");
			
			$("input[name=usedselect]").each(function(){
				$(this).click(function(){
					var ss = $(this).val();
					if(ss == "update")
					{
						$("#update").show();
						$("#usual").hide();
					}
					else
					{
						$("#update").hide();
						$("#usual").show();
					}
				});
			});
		});		
	</script>
</html>
