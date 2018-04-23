<%@page import="java.io.*"%>
<%@page import="java.text.DecimalFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="utf-8" />
	<link rel="apple-touch-icon" sizes="76x76" href="img/apple-icon.png">
	<link rel="icon" type="image/png" sizes="96x96" href="img/favicon.png">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title>数据上传负载测试</title>

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
                <li class="active">
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
                    <a class="navbar-brand" href="#">数据上传负载测试-<label id="databasetype"><%=session.getAttribute("databasetype")%></label></a>
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
                                <h4 class="title">数据上传测试</h4>
                            </div>
                            <div class="content">
                                <div>
                                	<div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="alert alert-info">                                    
                                    				<span>在执行操作前，请确认右侧的信息内容是否正确，如有不正确的请更正</span>
                                				</div>
                                            </div>
                                        </div>                           
                                    </div>
                                	
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="alert alert-warning">                                    
                                    				<span>请确认数据库已连接成功，如果未连接或者连接失败，请返回<b>数据库连接</b>重新操作</span>
                                				</div>
                                            </div>
                                        </div>                           
                                    </div>
									
									<div class="text-center">
                                    	<input id="fileupload" type="button" class="btn btn-info btn-fill btn-wd" value="数据上传" onclick="loadtest()"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    	<input id="filemetaupload" type="button" class="btn btn-info btn-fill btn-wd" value="元数据上传" onclick="loadmetatest()"/>
                                   </div>
                                   
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                        
                        <div id="loadstatus" style="display: none;">   		
                        	<div class="card">
                        	    <div class="header">
                           	    	<h4 class="title">实时文件上传信息</h4>
                            	</div>
                            	<div class="content">
                                	<div>
                                    	<div class="row">
                                        	<div class="col-md-12">
                                            	<div class="form-group">
                                                	<label>实时进度条</label>
                                                	<div class="progress" id="progressBarload">
														<div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="0%" aria-valuemin="0" aria-valuemax="100" style="width: 0%;" id="progressBarItemload">
															<p id="processload">0%</p>
														</div>
													</div>
                                           		</div>
                                        	</div>                           
                                    	</div>

                                   		<div class="row">
                                       		<div class="content">
												<label>已上传文件数量：</label><span id="loadfile_had"></span><br />
                    							<label>待上传文件数量：</label><span id="loadfile_need"></span><br />
                    							<label>传输文件的速度：</label><span id="loadfile_speed"></span><br />
                    							<label>当前已用的时间：</label><span id="loadfile_time"></span>
											</div>
                                   		</div>
                               		</div>
                           		</div>
                       		</div>               		
                		</div>

						<div id="loadchart" style="display: none;">
							<div class="card">
								<div class="header">
									<h4 class="title">实时文件上传折线图</h4>
								</div>
								<div class="content">
                                    <div id="filecanvasDiv"></div>
								</div>
							</div>
						</div>

                		<div id="loadmetastatus" style="display: none;">   		
                        	<div class="card">
                        	    <div class="header">
                           	    	<h4 class="title">实时文档上传信息</h4>
                            	</div>
                            	<div class="content">
                                	<div>
                                    	<div class="row">
                                        	<div class="col-md-12">
                                            	<div class="form-group">
                                                	<label>实时进度条</label>
                                                	<div class="progress" id="progressBarloadmeta">
														<div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="0%" aria-valuemin="0" aria-valuemax="100" style="width: 0%;" id="progressBarItemloadmeta">
															<p id="processloadmeta">0%</p>
														</div>
													</div>
                                           		</div>
                                        	</div>                           
                                    	</div>

                                   		<div class="row">
                                       		<div class="content">
												<label>已上传文档数量：</label><span id="loadfile_hadmeta"></span><br />
                    							<label>待上传文档数量：</label><span id="loadfile_needmeta"></span><br />
                    							<label>传输文档的速度：</label><span id="loadfile_speedmeta"></span><br />
                    							<label>当前已用的时间：</label><span id="loadfile_timemeta"></span>
											</div>
                                   		</div>
                               		</div>
                           		</div>
                       		</div>               		
                		</div>

                        <div id="metachart" style="display: none;">
                            <div class="card">
                                <div class="header">
                                    <h4 class="title">实时文档上传折线图</h4>
                                </div>
                                <div class="content">
                                    <div id="metacanvasDiv"></div>
                                </div>
                            </div>
                        </div>

                	</div>
                    
                    <div class="col-lg-4 col-md-5">
						<div class="card">
							<div class="header">
								<h4 class="title">创建新传输结果文件夹</h4>
							</div>
							<div class="content">
								<div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<div class="alert alert-info">
													<span>当执行新的传输结果记录时，请在执行前点击创建新传输结果文件夹</span>
												</div>
											</div>
										</div>
									</div>

									<div class="text-center">
										<input id="create_dir" type="button" class="btn btn-info btn-fill btn-wd" value="创建文件夹" onclick="createdir()"/>
									</div>

									<div class="clearfix"></div>
								</div>
							</div>
						</div>

                    	<div class="card">
                            <div class="header">
                                <h4 class="title">确认信息</h4>
                            </div>
                            <div class="content">
                            	<div class="row">
                            		<div class="col-md-12">
                                    	<div class="form-group">
                                        	<label>上传文件路径</label>
                                        	<input id="filepath_show" type="text" disabled="true"  class="form-control border-input" value="<%=session.getAttribute("filepath") %>"/>
                                    	</div>
                                	</div>
                          		</div>
                          		<div class="row">
                            		<div class="col-md-12">
                                    	<div class="form-group">
                                        	<label>上传数据库名称</label>
                                        	<input id="dbname_show" type="text" disabled="true" class="form-control border-input" value="<%=session.getAttribute("dbname") %>"/>
                                    	</div>
                                	</div>
                          		</div>
                          		<div class="row">
                            		<div class="col-md-12">
                                	    <div class="form-group">
                                    	    <label>上传集合名称</label>
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
	<script src="js/ichart.1.2.1.min.js"></script>

    <!--  Notifications Plugin    -->
    <script src="js/bootstrap-notify.js"></script>

    <!-- Paper Dashboard Core javascript and methods for Demo purpose -->
	<script src="js/paper-dashboard.js"></script>

	<!-- Paper Dashboard DEMO methods, don't include it in your project! -->
	<script src="js/demo.js"></script>
	<script src="js/progressbar.js" ></script>
	<script type="text/javascript" src="js/common.js" ></script>
	<script type="text/javascript" src="js/flavr.min.js" ></script>
	<script type="text/javascript" src="js/jquerySession.js"></script>
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
			}
			else{ %>
			var dbport = <%=session.getAttribute("dbport") %>
			<%}
			String check = (String) session.getAttribute("filepath");
			if(check == null || check.equals("")){%>
			var path;
			new $.flavr({
				content:'未检测到上传文件的总路径',
				dialog:'prompt',
				prompt:{ placeholder: '请输入上传文件的总路径', addClass:'pathcotent'},
				onConfirm:function($container, $prompt ){
					path = $prompt.val();
					$.ajax({
						type:"post",
						url:"/MBBench-U/mongodb",
						async:true,
						data:{"filepath":path, "functiontype":"setfilepathsession"},
						success:function(){
							window.location.reload();
						},
						dataType:"json",
						error:function(){						
						}
					});
					return false;
				}
			}); 
			<%
			}
		%>
		});

		function createdir(){
            $.ajax({
                type:"post",
                url:"/MBBench-U/makedir",
                async:true,
                data:{"dirtype":"transdir"},
                success:function(data)
                {
                    if(data.result == "success"){
                        $.notify({
                            icon: 'ti-gift',
                            message: "新传输结果文件夹<b>创建成功</b>"

                        },{
                            type: 'success',
                            timer: 4000
                        });
                    }
                    else
                        $.notify({
                            icon: 'ti-gift',
                            message: "新传输结果文件夹<b>创建失败</b>，请确定已输入结果日志存储路径"

                        },{
                            type: 'danger',
                            timer: 4000
                        });
                },
                dataType:"json",
                error:function()
                {

                }
            });
        }

		function upgrade()
		{
			$("#filepath_show").removeAttr("disabled"); 
			$("#dbname_show").removeAttr("disabled"); 
			$("#clname_show").removeAttr("disabled"); 
		}
		
		function recheck()
		{
			$("#filepath_show").attr("disabled", "disabled");
			$("#dbname_show").attr("disabled", "disabled");
			$("#clname_show").attr("disabled", "disabled");
		}
		
		function loadtest()
		{
            Array.prototype.max = function(){
                return Math.max.apply({},this);
            };
			var loadpath = $("#filepath_show").val();
			$("#loadstatus").show();
			$("#loadchart").show();
			$("#fileupload").attr("disabled","true");
			$("#loadmetastatus").hide();
			$("#metachart").hide();
			
			$.ajax({
				type:"post",
                url:"/MBBench-U/dbservlet",
				async:true,
				data:{"uploadpath":loadpath, "functiontype":"loadfile", "statetype":"init"},
				success:function(data)
				{
				},
				dataType:"json",
				error:function()
				{
				
				}
			});
			
			var loadtime = 0;
			var loadsettimer = null;
			var loadfile = 0;
			var zongfile = 1;
            var labels = [];
            var loadmax = 0;
			loadsettimer = setInterval(function(){
				$.ajax({
					type:"post",
                    url:"/MBBench-U/dbservlet",
					async:true,
					data:{"loadpath":loadpath, "functiontype":"loadfile", "statetype":"running"},
					success:function(data)
					{
						loadtime++;

						loadfile = parseInt(data.loadfile);
						zongfile = parseInt(data.zongfile);
						var pro = (loadfile / zongfile)*100;
						$("#progressBarItemload").attr('aria-valuenow', pro.toFixed(2) + "%").css('width', pro.toFixed(2) + "%");
						$("#processload").text(pro.toFixed(2) + "%");
						$("#loadfile_had").text(loadfile+"个");
						$("#loadfile_need").text((zongfile - loadfile) + "个");
						$("#loadfile_speed").text((parseInt(data.loadfilespread) / (1024 * 1024)).toFixed(2) + "MB/秒");		
						$("#loadfile_time").text(timeformat(loadtime));

						var flow = [];

                        var dataObj = data.arrays;
                        $.each(dataObj, function(index, item)
                        {
                            flow.push(parseFloat(item.speed));
                        });

                        loadmax = flow.max();
                        var data = [
                            {
                                name : 'speed:',
                                value:flow,
                                color:'#0d8ecf',
                                line_width:2
                            }
                        ];
                        if(loadtime % 10 == 1){
                            var date = new Date();
                            if(labels.length >= 6)
                                labels.shift(); //用于删除数组内的第一个元素
                            labels.push(date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds());
                        }

                        var chart = new iChart.LineBasic2D({
                            render : 'filecanvasDiv',
                            data: data,
                            align:'center',
                            title : {
                                text:'数据文件上传实时折线图',
                                fontsize:24,
                                color:'#f7f7f7'
                            },
                            subtitle : {
                                text:'数据的单位是 MB/S',
                                color:'#f1f1f1'
                            },
                            footnote : {
                                text:'数据点以秒为单位',
                                color:'#f1f1f1'
                            },
                            width : 800,
                            height : 400,
                            shadow:true,
                            shadow_color : '#20262f',
                            shadow_blur : 4,
                            shadow_offsetx : 0,
                            shadow_offsety : 2,
                            background_color:'#383e46',
                            tip:{
                                enable:true,
                                shadow:true
                            },
                            crosshair:{
                                enable:true,
                                line_color:'#62bce9'
                            },
                            sub_option : {
                                label:false,
                                hollow_inside:false,
                                point_size:8
                            },
                            coordinate:{
                                width:640,
                                height:260,
                                grid_color:'#cccccc',
                                axis:{
                                    color:'#cccccc',
                                    width:[0,0,2,2]
                                },
                                grids:{
                                    vertical:{
                                        way:'share_alike',
                                        value:5
                                    }
                                },
                                scale:[{
                                    position:'left',
                                    start_scale:0,
                                    end_scale:loadmax,
                                    scale_space:10,
                                    scale_size:2,
                                    label : {color:'#ffffff',fontsize:11},
                                    scale_color:'#9f9f9f'
                                },{
                                    position:'bottom',
                                    label : {color:'#ffffff',fontsize:11},
                                    labels:labels
                                }]
                            }
                        });
                        //开始画图
                        chart.draw();
					},
					dataType:"json",
					error:function()
					{
						//clearInterval(loadsettimer);
					}
				});
				if(loadfile == zongfile || $("#progressBarItemload").attr('aria-valuenow') == "100%")   
				{
					$("#progressBarItemload").attr('aria-valuenow', "100%").css('width', "100%");
					$("#processload").text("100%");
					clearInterval(loadsettimer);
				}
			},1000);
		}
		
		function loadmetatest()
		{
            Array.prototype.max = function(){
                return Math.max.apply({},this);
            };
			var loadpath = $("#filepath_show").val();

            $("#loadstatus").hide();
            $("#loadchart").hide();
			$("#filemetaupload").attr("disabled","true");
            $("#loadmetastatus").show();
            $("#metachart").show();
			
			$.ajax({
				type:"post",
                url:"/MBBench-U/dbservlet",
				async:true,
				data:{"uploadpath":loadpath, "functiontype":"loadmeta", "statetype":"init"},
				success:function(data)
				{			
				},
				error:function()
				{
				}
			});		
			
			var loadmeta = 0;
			var zongmeta = 1;
			var loadmetatime = 0;
			var loadmetasettimer = null;
            var labels = [];
            var metamax = 0;
            loadmetasettimer = setInterval(function(){
				$.ajax({
					type:"post",
                    url:"/MBBench-U/dbservlet",
					async:true,
					data:{"loadpath":loadpath, "functiontype":"loadmeta", "statetype":"running"},
					success:function(data)
					{

                        loadmetatime++;
						loadmeta = parseInt(data.loadmeta);
						zongmeta = parseInt(data.zongmeta);
						var pro = (loadmeta / zongmeta)*100;
						$("#progressBarItemloadmeta").attr('aria-valuenow', pro.toFixed(2) + "%").css('width', pro.toFixed(2) + "%");
						$("#processloadmeta").text(pro.toFixed(2) + "%");
						$("#loadfile_hadmeta").text(loadmeta + "个");
						$("#loadfile_needmeta").text((zongmeta - loadmeta) + "个");
						$("#loadfile_speedmeta").text(data.loadmetaspread + "个/秒");		
						$("#loadfile_timemeta").text(timeformat(loadmetatime));

                        var flow = [];
                        var dataObj = data.arrays;
                        $.each(dataObj, function(index, item)
                        {
                            flow.push(parseFloat(item.speed));
                        });

                        metamax = flow.max();

                        var data = [
                            {
                                name : 'speed:',
                                value:flow,
                                color:'#0d8ecf',
                                line_width:2
                            }
                        ];
                        if(loadmetatime % 10 == 1){
                            var date = new Date();
                            if(labels.length >= 6)
                                labels.shift(); //用于删除数组内的第一个元素
                            labels.push(date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds());
                        }

                        var chart = new iChart.LineBasic2D({
                            render : 'metacanvasDiv',
                            data: data,
                            align:'center',
                            title : {
                                text:'数据文档上传实时折线图',
                                fontsize:24,
                                color:'#f7f7f7'
                            },
                            subtitle : {
                                text:'数据的单位是 Per/S',
                                color:'#f1f1f1'
                            },
                            footnote : {
                                text:'数据点以秒为单位',
                                color:'#f1f1f1'
                            },
                            width : 800,
                            height : 400,
                            shadow:true,
                            shadow_color : '#20262f',
                            shadow_blur : 4,
                            shadow_offsetx : 0,
                            shadow_offsety : 2,
                            background_color:'#383e46',
                            tip:{
                                enable:true,
                                shadow:true
                            },
                            crosshair:{
                                enable:true,
                                line_color:'#62bce9'
                            },
                            sub_option : {
                                label:false,
                                hollow_inside:false,
                                point_size:8
                            },
                            coordinate:{
                                width:640,
                                height:260,
                                grid_color:'#cccccc',
                                axis:{
                                    color:'#cccccc',
                                    width:[0,0,2,2]
                                },
                                grids:{
                                    vertical:{
                                        way:'share_alike',
                                        value:5
                                    }
                                },
                                scale:[{
                                    position:'left',
                                    start_scale:0,
                                    end_scale:metamax,
                                    scale_space:10,
                                    scale_size:2,
                                    label : {color:'#ffffff',fontsize:11},
                                    scale_color:'#9f9f9f'
                                },{
                                    position:'bottom',
                                    label : {color:'#ffffff',fontsize:11},
                                    labels:labels
                                }]
                            }
                        });
                        //开始画图
                        chart.draw();
					},
					dataType:"json",
					error:function()
					{
						//clearInterval(loadmetasettimer);
					}
				});
				if(loadmeta == zongmeta || $("#progressBarItemloadmeta").attr('aria-valuenow') == "100%")   
				{
					$("#progressBarItemloadmeta").attr('aria-valuenow', "100%").css('width', "100%");
					$("#processloadmeta").text("100%");
					clearInterval(loadmetasettimer);
				}
			},1000);		
		}

	</script>
</html>