<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="utf-8" />
	<link rel="apple-touch-icon" sizes="76x76" href="img/apple-icon.png">
	<link rel="icon" type="image/png" sizes="96x96" href="img/favicon.png">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title>查询负载测试</title>

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
                <li class="active">
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
                    <a class="navbar-brand" href="#">查询负载测试-<label id="dbtype"><%=session.getAttribute("databasetype")%></label></a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-right">                   
                    </ul>
                </div>
            </div>
        </nav>


        <div class="content">
            <div class="container-fluid">
                <div class="row">
                	<div class="col-lg-8 col-md-7">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">单属性查询测试</h4>
                            </div>
                            <div class="content">
                                <div>
                                	<div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="alert alert-info">                                    
                                    				<span><b>单属性查询共分三个查询：单个数值查询，有限元数值查询，范围数值查询。</b></span>
                                				</div>
                                            </div>
                                        </div>                           
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="alert alert-info">                                    
                                    				<span><b>1.&nbsp; 针对单一属性的单个数值查询:</b>查询属性：文件类型；查询值：Blade</span>
                                				</div>
                                            </div>
                                        </div>                           
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="alert alert-info">                                    
                                    				<span><b>2.&nbsp; 针对单一属性的有限元数值查询:</b>查询属性：塔架高度；查询值：数值为奇数</span>
                                				</div>
                                            </div>
                                        </div>                           
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="alert alert-info">                                    
                                    				<span><b>3.&nbsp; 针对单一属性的范围数值查询:</b>查询属性：仿真时间；查询值：请设定</span>
                                				</div>
                                            </div>
                                        </div>                           
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="content">
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
				                                    </div>
                                            	</div>
                                        	</div>                           
                                    	</div>
                                    </div>
                                    
                                	
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="alert alert-danger">                                    
                                    				<span>请确认数据库已连接成功，如果未连接或者连接失败，请返回<b>数据库连接</b>重新操作</span>
                                				</div>
                                            </div>
                                        </div>                           
                                    </div>
									
									<div class="text-center">    
										
                                    	<input id="singlequery"type="button" class="btn btn-info btn-fill btn-wd" value="开始查询" onclick="singlequery()"/>
                                    	<br/><span id="workload_a_result" style="color: green;">当前未执行本负载</span>
                                    	
                                   </div>
                                   
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div> 
                        
                        <div class="card">
                            <div class="header">
                                <h4 class="title">多属性查询测试</h4>
                            </div>
                            <div class="content">
                                <div>
                                	<div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="alert alert-info">                                    
                                    				<span><b>多属性查询共分四个查询：单个数值查询，有限元数值查询，范围数值查询，多类型数值查询。</b></span>
                                				</div>
                                            </div>
                                        </div>                           
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="alert alert-info">                                    
                                    				<span><b>1.&nbsp; 针对多属性的单个数值查询:</b>查询属性：地区&文件类型；查询值：“QingZangGaoYuan”&“Blade”</span>
                                				</div>
                                            </div>
                                        </div>                           
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="alert alert-info">                                    
                                    				<span><b>2.&nbsp; 针对多属性的有限元数值查询:</b>查询属性：地区&塔架高度；查询值：地区为“HuaDong”或“QingZangGaoYuan”，塔架高度值为奇数</span>
                                				</div>
                                            </div>
                                        </div>                           
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="alert alert-info">                                    
                                    				<span><b>3.&nbsp; 针对多属性的范围数值查询:</b>查询属性：塔架高度&扇叶长度；查询值：塔架高度:扇叶长度：</span>
                                				</div>
                                            </div>
                                        </div>                           
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="alert alert-info">                                    
                                    				<span><b>4.&nbsp; 针对多属性的多类型数值查询:</b>查询属性：仿真时间&地区&塔架高度&风速；查询值：时间：地区为“HuaDong”或“QingZangGaoYuan”，塔架高度值为奇数，最大风速超过3.5m/s</span>
                                				</div>
                                            </div>
                                        </div>                           
                                    </div>
									
									<div class="text-center">                                   	
                                    	<input id="filemetaupload" type="button" class="btn btn-info btn-fill btn-wd" value="开始查询" onclick="singleQuery2()"/>
                                   		<br/><span id="workload_b_result" style="color: green;">当前未执行本负载</span>
                                   </div>
                                   
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="card">
                            <div class="header">
                                <h4 class="title">数据文件版本管理</h4>
                            </div>
                            <div class="content">
                                <div>	
                                	
                                	<div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="alert alert-info">                                    
                                    				<span><b>1.&nbsp; 查询每个文件的版本个数【不执行文件下载】【MongoDB做不了】</b></span>
                                				</div>
                                            </div>
                                        </div>                           
                                    </div>
                                	
                                	<div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label>请输入生成文件的存储总路径</label>
                                                <input id="datapath" type="text" class="form-control border-input" placeholder="请输入路径" />
                                            </div>
                                        </div>                           
                                    </div>
                                    
                                    <div class="text-center">
                                        <input id="filedown" type="button" class="btn btn-info btn-fill btn-wd" value="开始查询" onclick="singleQuery3()"/>
                                        <br/><span id="workload_c_result" style="color: green;">当前未执行本负载</span>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                    
                	</div>
                    
                    <div class="col-lg-4 col-md-5">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">创建新负载结果文件夹</h4>
                            </div>
                            <div class="content">
                                <div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="alert alert-info">
                                                    <span>当执行新的查询负载结果记录时，请在执行前点击创建新负载结果文件夹</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="text-center">
                                        <input id="create_querydir" type="button" class="btn btn-info btn-fill btn-wd" value="创建文件夹" onclick="createquerydir()"/>
                                    </div>

                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>

                    	<div class="card">
                            <div class="header">
                                <h4 class="title">设置并确认信息</h4>
                            </div>
                            <div class="content">
                          		<div class="row">
                            		<div class="col-md-12">
                                    	<div class="form-group">
                                        	<label>查询文件下载路径</label>
                                        	<input id="chaxunpath_show" type="text" disabled="true"  class="form-control border-input" value="<%=session.getAttribute("chaxunpath") %>"/>
                                    	</div>
                                	</div>
                          		</div>
                          		<div class="row">
                            		<div class="col-md-12">
                                    	<div class="form-group">
                                        	<label>数据库名称</label>
                                        	<input id="dbname_show" type="text" disabled="true" class="form-control border-input" value="<%=session.getAttribute("dbname") %>"/>
                                    	</div>
                                	</div>
                          		</div>
                          		<div class="row">
                            		<div class="col-md-12">
                                	    <div class="form-group">
                                    	    <label>集合名称</label>
                                        	<input id="clname_show" type="text" disabled="true" class="form-control border-input" value="<%=session.getAttribute("metadbname") %>"/>
                                    	</div>
                                	</div>
                          		</div>
                          		<div class="row">
                          			<div class="text-center">
                          				<input type="button" class="btn btn-info btn-fill btn-wd" value="修改信息" onclick="upgrade()"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          				<input type="button" class="btn btn-info btn-fill btn-wd" value="更新信息" onclick="recheck()"/>
                          			</div>
                          		</div>
                       		</div>
                       	</div>

                        <div class="card card-user">
                            <div class="content">
                                <div class="author">
                                  <div class="avatar"></div>
                                  <h4 class="title">数据生成记录<br />
                                  </h4>
                                </div>
                                <br />
                                <p class="description text-center">
                                	目前只选取按照时间排序的前七个数据生成记录<br />
                                	该信息用于负载参数设置，请查验该数据生成记录是否为当前负载所测试的数据
                                </p>
                            </div>
                            <hr>
                            <div class="form-group">
                                <div class="nav-tabs-navigation" style="width:90%;">
    							 	<div class="nav-tabs-wrapper" style="margin: 0 auto;">
    								<%
                                        String jspPath = application.getRealPath("/");
                                        File ss = new File(jspPath + "\\WEB-INF\\classes\\HistorySettings");
    									if(!ss.exists())
    										ss.mkdirs();
    									File filelistFile[] = ss.listFiles();
    									if(filelistFile.length > 0)
    									{							
    								%>
    									<ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
    								<% 
    										File files = null;
    										for(int i = 0; i < 7 && filelistFile.length - 1 - i >= 0; i++)
    										{
    											files = filelistFile[filelistFile.length - 1 - i];
    											if(i == 0)
    											{
    								%>
            								<li class="active"><a href="#<%=i %>" data-toggle="tab"><%=i+1 %></a></li>
        							<%			}
    											else
    											{
    								%>
    										<li><a href="#<%=i %>" data-toggle="tab"><%=i+1 %></a></li>
    								<%
    											}
    										}
        							%>
        								</ul>
    								</div>
								</div>
								<div id="my-tab-content" class="tab-content text-center">
									<%
											for(int i = 0; i < 7 && filelistFile.length - 1 - i >= 0; i++)
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
										<textarea class="tab-pane active" id="<%=i %>" style="scrollbar-3dlight-color: grey; scrollbar-base-color: #00BBFF; width: 100%; height: 300px;">
											<%=allstr %>
										</textarea>
    								<%
    											}
												else
												{
    								%>
    								<textarea class="tab-pane" id="<%=i %>" style="scrollbar-3dlight-color: grey; scrollbar-base-color: #00BBFF; width: 100%; height: 300px;">
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
                                					<span><%="未检测到/HistorySettings文件夹下有仿真生成设置文件，请查证后再点击" %></span>
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

    <!--  Google Maps Plugin    -->
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js"></script>

    <!-- Paper Dashboard Core javascript and methods for Demo purpose -->
	<script src="js/paper-dashboard.js"></script>

	<!-- Paper Dashboard DEMO methods, don't include it in your project! -->
	<script src="js/demo.js"></script>
	<script src="js/progressbar.js" ></script>
	<script type="text/javascript" src="js/common.js" ></script>
	<script type="text/javascript" src="js/flavr.min.js" ></script>
	<script type="text/javascript">
		$(function(){
			<%       
			   if(session.getAttribute("dbport") == null){%>
			   new $.flavr({
				    content     : '未检测到数据库连接，请返回数据库连接重新连接数据库',
				    buttons     : {
				        primary : { text: '数据库连接', style: 'primary', 
				                    action: function(){			                       
				                    	$(location).attr('href', 'dbconnect.jsp');
				                    }
				        },
				        close   : { text:'确定已连接',style: 'default' }
				    }
				}); 
			<%
			
			}else{ %>
				var dbport = <%=session.getAttribute("dbport") %>
				<%}%>
				
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
		});	

		function createquerydir(){
            $.ajax({
                type:"post",
                url:"/MBBench-U/makedir",
                async:true,
                data:{"dirtype":"querydir"},
                success:function(data)
                {
                    if(data.result == "true"){
                        $.notify({
                            icon: 'ti-gift',
                            message: "新负载结果文件夹<b>创建成功</b>"

                        },{
                            type: 'success',
                            timer: 4000
                        });
                    }
                    else{
                        $.notify({
                            icon: 'ti-gift',
                            message: "没有运行数据传输，请先建立<b>数据传输结果</b>文件夹"

                        },{
                            type: 'danger',
                            timer: 4000
                        });
                    }

                },
                dataType:"json",
                error:function()
                {
                    $.notify({
                        icon: 'ti-gift',
                        message: "新负载结果文件夹<b>创建失败</b>，请确定已输入结果日志存储路径"

                    },{
                        type: 'danger',
                        timer: 4000
                    });
                }
            });
        }

		function upgrade()
		{
			
			$("#chaxunpath_show").removeAttr("disabled"); 
			$("#dbname_show").removeAttr("disabled"); 
			$("#clname_show").removeAttr("disabled"); 
		}
		
		function recheck()
		{
			
			$("#chaxunpath_show").attr("disabled", "disabled"); 
			$("#dbname_show").attr("disabled", "disabled");
			$("#clname_show").attr("disabled", "disabled");
		}
		
		function singlequery()
		{
		    $("#singlequery").attr("disabled","true");

		    var dbtype = $("#dbtype").text();
			var dbname = $("#dbname_show").val();
			var clname = $("#clname_show").val();
			var downpath = $("#chaxunpath_show").val();
			var sdate = $("#simustartdate").val();
			var shour = $("#simustarthour").val();
			var smins = $("#simustartmins").val();
			var ssecs = $("#simustartsecs").val();
			var edate = $("#simuenddate").val();
			var ehour = $("#simuendhour").val();
			var emins = $("#simuendmins").val();
			var esecs = $("#simuendsecs").val();
			
			$.ajax({
				type:"post",
                url:"/MBBench-U/dbservlet",
				async:true,
				data:{
					"dbname":dbname, 
					"clname":clname,
					"sdate":sdate,
					"shour":shour,
					"smins":smins,
					"ssecs":ssecs,
					"edate":edate,
					"ehour":ehour,
					"emins":emins,
					"esecs":esecs,
					"functiontype":"querya",
					"statetype":"init",
					"downpath":downpath
					},
				success:function() {},
				dataType:"json",
                error:function () {}
			});

			loadsettimer = setInterval(function(){
				$.ajax({
					type:"post",
                    url:"/MBBench-U/dbservlet",
					async:true,
					data:{
                        "functiontype":"querya",
                        "statetype":"running",
						},
					success:function(data)
					{
						$("#workload_a_result").text(data.result);
						if(data.result == "Single attribute query has been finished")
							clearInterval(loadsettimer);
					},
					dataType:"json",
					error:function() {}
				});
				
			},500);
		}	
		
		function singleQuery2(){
            var dbtype = $("#dbtype").text();
			var dbname = $("#dbname_show").val();
			var clname = $("#clname_show").val();	
			var downpath = $("#chaxunpath_show").val();
			
			$.ajax({
				type:"post",
                url:"/MBBench-U/dbservlet",
				async:true,
				data:{
					"dbname":dbname, 
					"clname":clname,
					"functiontype":"queryb",
					"statetype":"init",
					"downpath":downpath
					},
				success:function() {},
				dataType:"json",
				error:function() {}
			});
		
			querybsetter = setInterval(function(){
				$.ajax({
					type:"post",
                    url:"/MBBench-U/dbservlet",
					async:true,
					data:{
                        "functiontype":"queryb",
                        "statetype":"running",
						},
					success:function(data)
					{
						$("#workload_b_result").text(data.result);
						if(data.result == "Multi attribute query has been finished")
							clearInterval(querybsetter);
					},
					dataType:"json",
					error:function() {}
				});
				
			},500);
		}
		
		function singleQuery3(){
            var dbtype = $("#dbtype").text();

			var dbname = $("#dbname_show").val();
			var clname = $("#clname_show").val();
			var datapath = $("#datapath").val();
			var downpath = $("#chaxunpath_show").val();
			
			$.ajax({
				type:"post",
                url:"/MBBench-U/dbservlet",
				async:true,
				data:{
					"dbname":dbname, 
					"clname":clname,
					"functiontype":"queryc",
					"statetype":"init",
					"downpath":downpath,
					"datapath":datapath
					},
				success:function() {},
				dataType:"json",
				error:function() {}
			});
			
			querybsetter = setInterval(function(){
				$.ajax({
					type:"post",
                    url:"/MBBench-U/dbservlet",
					async:true,
					data:{
						"functiontype":"queryc",
						"statetype":"running"
						},
					success:function(data)
					{
						$("#workload_c_result").text(data.result);
						if(data.result == "Version query has been finished")
							clearInterval(querybsetter);
					},
					dataType:"json",
					error:function() {}
				});
				
			},500);
		}
	</script>
</html>