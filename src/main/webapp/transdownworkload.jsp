<%@page import="java.io.*"%>
<%@page import="java.text.DecimalFormat" %>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="utf-8" />
	<link rel="apple-touch-icon" sizes="76x76" href="img/apple-icon.png">
	<link rel="icon" type="image/png" sizes="96x96" href="img/favicon.png">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title>数据下载负载测试</title>

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
				<li class="active">
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
                    <a class="navbar-brand" href="#">数据下载负载测试-<label id="databasetype"><%=session.getAttribute("databasetype")%></label></a>
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
                                <h4 class="title">数据下载测试</h4>
                            </div>
                            <div class="content">
                                <div>	
                                	<div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="alert alert-warning">                                    
                                    				<span>请确认数据库内已有相应的数据库、集合名称及数据文件，若果没有请执行数据上传测试</span>
                                				</div>
                                				<div class="alert alert-warning">                                    
                                    				<span>执行下载测试前，请确定确认信息内的信息完整，如果没有请修改信息并更新</span>
                                				</div>
                                            </div>
                                        </div>                           
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>请输入文件下载路径</label>
                                                <input id="downpath" type="text" class="form-control border-input" placeholder="请输入下载路径" />
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <div class="form-group">
                                                <label>&nbsp</label>
                                                <div class="alert alert-info">                                    
                                    				<span>在设置路径前，请确认所写路径有足够大的空间，参考值请见右侧</span>
                                				</div> 
                                            </div>
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <input id="filedown" type="button" class="btn btn-info btn-fill btn-wd" value="数据下载" onclick="downtest()"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <input id="filedownmeta" type="button" class="btn btn-info btn-fill btn-wd" value="元数据下载" onclick="downmetatest()"/>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                    
                    	<div id="downstatus" style="display: none;">   		
                        	<div class="card">
                        	    <div class="header">
                           	    	<h4 class="title">实时文件下载信息</h4>
                            	</div>
                            	<div class="content">
                                	<div>
                                    	<div class="row">
                                        	<div class="col-md-12">
                                            	<div class="form-group">
                                                	<label>实时进度条</label>
                                                	<div class="progress" id="progressBardown">
														<div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="0%" aria-valuemin="0" aria-valuemax="100" style="width: 0%;" id="progressBarItemdown">
															<p id="processdown">0%</p>
														</div>
													</div>
                                           		</div>
                                        	</div>                           
                                    	</div>

                                   		<div class="row">
                                       		<div class="content">
												<label>已下载文件数量：</label><span id="downfile_had"></span><br />
                    							<label>待下载文件数量：</label><span id="downfile_need"></span><br />
                    							<label>传输文件的速度：</label><span id="downfile_speed"></span><br />
                    							<label>当前已用的时间：</label><span id="downfile_time"></span>
											</div>
                                   		</div>
                               		</div>
                           		</div>
                       		</div>               		
                		</div>

                        <div id="downchart" style="display: none;">
                            <div class="card">
                                <div class="header">
                                    <h4 class="title">实时文件下载折线图</h4>
                                </div>
                                <div class="content">
                                    <div id="downfilecanvasDiv"></div>
                                </div>
                            </div>
                        </div>
                		
                		<div id="downstatusmeta" style="display: none;">   		
                        	<div class="card">
                        	    <div class="header">
                           	    	<h4 class="title">实时文档下载信息</h4>
                            	</div>
                            	<div class="content">
                                	<div>
                                    	<div class="row">
                                        	<div class="col-md-12">
                                            	<div class="form-group">
                                                	<label>实时进度条</label>
                                                	<div class="progress" id="progressBardownmeta">
														<div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="0%" aria-valuemin="0" aria-valuemax="100" style="width: 0%;" id="progressBarItemdownmeta">
															<p id="processdownmeta">0%</p>
														</div>
													</div>
                                           		</div>
                                        	</div>                           
                                    	</div>

                                   		<div class="row">
                                       		<div class="content">
												<label>已下载文件数量：</label><span id="downfile_hadmeta"></span><br />
                    							<label>待下载文件数量：</label><span id="downfile_needmeta"></span><br />
                    							<label>传输文件的速度：</label><span id="downfile_speedmeta"></span><br />
                    							<label>当前已用的时间：</label><span id="downfile_timemeta"></span>
											</div>
                                   		</div>
                               		</div>
                           		</div>
                       		</div>               		
                		</div>

                        <div id="metachart" style="display: none;">
                            <div class="card">
                                <div class="header">
                                    <h4 class="title">实时文档下载折线图</h4>
                                </div>
                                <div class="content">
                                    <div id="downmetacanvasDiv"></div>
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

									<div class="clearfix"></div>
								</div>
							</div>
						</div>
                        <div class="card card-user">
                            <div class="content">
                                <div class="author">
                                  <div class="avatar"></div>
                                  <h4 class="title">下载文件信息<br />
                                  </h4>
                                </div>
                                <br />
                                <p class="description text-center">
                                	本信息所显示的内容仅供参考<br />
                                	请保证所选路径的空间大于所给出的参考值
                                </p>
                            </div>
                            <hr>
                            <div class="text-center">
                                <div class="row">
                                    <div class="col-md-5 col-md-offset-1">
                                    <%
                                    	DecimalFormat decimalFormat=new DecimalFormat(".00");
                                    	int filenum = 0;
                                    	float sizeall = 0;
                                    	if(!(session.getAttribute("filepath") == null)){
	 										File[] files = new File((String) session.getAttribute("filepath")).listFiles();
	                                    	for(File file : files){
	                                    		if(file.isDirectory()){
	                                    			File[] subfiles = file.listFiles();
	                                    			long size = 0;
	                                    			for(File subfile : subfiles){
	                                    				filenum ++;
	                                    				size += subfile.length();
	                                    			}
	                                    			sizeall += ((float)size / (1024 * 1024 * 1024 * 1024));
	                                    		}
	                                    	}
                                    	}
                                    	
                                    
                                    %>
                                        <h5 id="filesshow"><br /><small>文件数量</small></h5>                                       
                                    </div>
                                    <div class="col-md-5">
                                        <h5 id="sizesshow"><br /><small>存储空间</small></h5>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div class="text-center">
                            	<input type="button" class="btn btn-info btn-fill btn-wd" value="刷新信息" onclick="downfileinfo()"/>
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

    <!--  Google Maps Plugin    -->
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js"></script>

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
			%>
			var path;
			$.ajax({
				type:"post",
                 url:"/MBBench-U/dbservlet",
				async:true,
				data:{"functiontype":"getdbfileinfo"},
				success:function(data)
				{
					$("#filesshow").text(data.filenum + "个");
					$("#sizesshow").text(data.datasize + "GB");
				},
				dataType:"json",
				error:function()
				{
				
				}
			});
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

		function downfileinfo(){
			$.ajax({
				type:"post",
                 url:"/MBBench-U/dbservlet",
				async:true,
				data:{"functiontype":"getdbfileinfo"},
				success:function(data)
				{
					$("#filesshow").text(data.filenum + "个");
					$("#sizesshow").text(data.datasize + "GB");
				},
				dataType:"json",
				error:function()
				{
				
				}
			});
		}

		function downtest()
		{
            Array.prototype.max = function(){
                return Math.max.apply({},this);
            };
			var downpath = $("#downpath").val();

            $("#downstatus").show();
            $("#downchart").show();
            $("#filedown").attr("disabled","true");
            $("#downstatusmeta").hide();
            $("#metachart").hide();
			
			$.ajax({
				type:"post",
                 url:"/MBBench-U/dbservlet",
				async:true,
				data:{"downpath":downpath, "functiontype":"downfile", "statetype":"init"},
				success:function(data)
				{
					
				},
				dataType:"json",
				error:function()
				{
					
				}
			});	
			
			var downfile = 0;
			var zongdown = 1;
			var downtime = 0;
			var downsettimer = null;
            var labels = [];
            var downmax = 0;
			downsettimer = setInterval(function(){
				$.ajax({
					type:"post",
                    url:"/MBBench-U/dbservlet",
					async:true,
					data:{"downpath":downpath, "functiontype":"downfile", "statetype":"running"},
					success:function(data)
					{
						downtime = downtime + 1;
						downfile = parseInt(data.downfile);
						zongdown = parseInt(data.downfileall);
						var pro = (downfile / zongdown) * 100;
						$("#progressBarItemdown").attr('aria-valuenow', pro.toFixed(2) + "%").css('width', pro.toFixed(2) + "%");
						$("#processdown").text(pro.toFixed(2) + "%");
						$("#downfile_had").text(downfile + "个");
						$("#downfile_need").text(zongdown - downfile + "个");
						$("#downfile_speed").text((parseInt(data.downfilespread) / (1024 * 1024)).toFixed(2) + "MB/秒");		
						$("#downfile_time").text(timeformat(downtime));

                        var flow = [];

                        var dataObj = data.arrays;
                        $.each(dataObj, function(index, item)
                        {
                            flow.push(parseFloat(item.speed));
                        });

                        downmax = flow.max();
                        var data = [
                            {
                                name : 'speed:',
                                value:flow,
                                color:'#0d8ecf',
                                line_width:2
                            }
                        ];
                        if(downtime % 10 == 1){
                            var date = new Date();
                            if(labels.length >= 6)
                                labels.shift(); //用于删除数组内的第一个元素
                            labels.push(date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds());
                        }

                        var chart = new iChart.LineBasic2D({
                            render : 'downfilecanvasDiv',
                            data: data,
                            align:'center',
                            title : {
                                text:'数据文件下载实时折线图',
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
                                    end_scale:downmax,
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
						//clearInterval(downsettimer);
					}
				});
				if(downfile == zongdown || $("#progressBarItemdown").attr('aria-valuenow') == "100%")   
				{
					$("#progressBarItemdown").attr('aria-valuenow', "100%").css('width', "100%");
					$("#processdown").text("100%");
					clearInterval(downsettimer);
				}
			},1000);
		}
		
		function downmetatest()
		{
            Array.prototype.max = function(){
                return Math.max.apply({},this);
            };
			var downpath = $("#downpath").val();
            $("#downstatus").hide();
            $("#downchart").hide();
            $("#filedownmeta").attr("disabled","true");
            $("#downstatusmeta").show();
            $("#metachart").show();
			
			$.ajax({
				type:"post",
                 url:"/MBBench-U/dbservlet",
				async:true,
				data:{"downpath":downpath, "functiontype":"downmeta", "statetype":"init"},
				success:function(data)
				{
					
				},
				dataType:"json",
				error:function()
				{
					
				}
			});		
			var downmeta = 0;
			var downzong = 1;
			var downtimemeta = 0;
			var downmetasettimer = null;
			var metamax = 0;
			var labels = [];
			downmetasettimer = setInterval(function(){
				$.ajax({
					type:"post",
                    url:"/MBBench-U/dbservlet",
					async:true,
					data:{"downpath":downpath, "functiontype":"downmeta", "statetype":"running"},
					success:function(data)
					{
						downtimemeta = downtimemeta + 1;
						downmeta = parseInt(data.downmeta);
						downzong = parseInt(data.downmetaall);
						var pro = (downmeta / downzong) * 100;
						$("#progressBarItemdownmeta").attr('aria-valuenow', pro.toFixed(2) + "%").css('width', pro.toFixed(2) + "%");
						$("#processdownmeta").text(pro.toFixed(2) + "%");
						$("#downfile_hadmeta").text(downmeta + "个");
						$("#downfile_needmeta").text((downzong - downmeta) + "个");
						$("#downfile_speedmeta").text(data.downmetaspread+"件/秒");		
						$("#downfile_timemeta").text(timeformat(downtimemeta));

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
                        if(downtimemeta % 10 == 1){
                            var date = new Date();
                            if(labels.length >= 6)
                                labels.shift(); //用于删除数组内的第一个元素
                            labels.push(date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds());
                        }

                        var chart = new iChart.LineBasic2D({
                            render : 'downmetacanvasDiv',
                            data: data,
                            align:'center',
                            title : {
                                text:'数据文档下载实时折线图',
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
						//clearInterval(downmetasettimer);
					}
				});
				if(downmeta == downzong || $("#progressBarItemdownmeta").attr('aria-valuenow') == "100%")   
				{
					$("#progressBarItemdownmeta").attr('aria-valuenow', "100%").css('width', "100%");
					$("#processdownmeta").text("100%");
					clearInterval(downmetasettimer);
				}
			},1000);
		}
	</script>
</html>