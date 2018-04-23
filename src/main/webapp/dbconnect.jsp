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

	<title>数据库连接</title>

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
                <li class="active">
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
                        <a class="navbar-brand" href="#">数据库连接-<label id="databasetype"><%=session.getAttribute("databasetype")%></label></a>
                </div>
                <div class="collapse navbar-collapse">
                </div>
            </div>
        </nav>


        <div class="content">
            <div class="container-fluid">
                <div class="row">
                	<div class="col-md-9">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">输入参数</h4>
                            </div>
                            <div class="content">
                                <div>
                                    <div class="row">
                                        <div class="col-md-9">
                                            <div class="form-group">
                                                <label>请输入数据库的连接网址，如"localhost"</label>
                                                <input id="database_ip" type="text" class="form-control border-input" placeholder="请输入网址" />
                                            </div>
                                        </div>                           
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>请输入数据库的连接端口号</label>
                                                <input id="database_port" type="text" class="form-control border-input" placeholder="请输入端口号" />
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>&nbsp</label>
                                                <div class="alert alert-info">                                    
                                    				<span>请根据您在安装MongDB的实际配置填写</span>
                                				</div> 
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>请输入存储文件的数据库名称，如"FileDB"</label>
                                                <input id="database_dbname" type="text" class="form-control border-input" placeholder="请输入数据库名称" />
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>&nbsp</label>
                                                <div class="alert alert-warning">                                    
                                    				<span>请不要使用中文填写</span>
                                				</div> 
                                            </div>
                                        </div>
                                    </div>

									<div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>请输入存储元数据文件的集合名称，如"FileMeta"</label>
                                                <input id="database_collectionname" type="text" class="form-control border-input" placeholder="请输入集合名称" />
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>&nbsp</label>
                                                <div class="alert alert-warning">                                    
                                    				<span>请不要使用中文填写</span>
                                				</div> 
                                            </div>
                                        </div>
                                    </div>
                                    <hr />
                                    <div class="text-center">
                                        <input id="dbconnect" type="button" class="btn btn-info btn-fill btn-wd" value="连接数据库" onclick="dbconnect()"/>&nbsp&nbsp&nbsp&nbsp
                                        <input id="disdbconnect" type="button" class="btn btn-info btn-fill btn-wd" value="断开连接" onclick="dbdisconnect()"/>
                                    </div>
                                    <div class="clearfix"></div>
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
	<script type="text/javascript">
		function dbconnect(){
        		var ip = $("#database_ip").val();
        		var port = $("#database_port").val();
        		var dbname = $("#database_dbname").val();
        		var clname = $("#database_collectionname").val();
        		var dbtype = $("#databasetype").text();

        		$.ajax({
        			type:"POST",
        			url:"/MBBench-U/dbservlet",
        			async:true,
        			data:{"dbip":ip, "dbport":port, "dbname":dbname, "functiontype":"dbconnect", "metadbname": clname},
        			success:function(data){
        				if(data.result == "true")
        				{
        					$.notify({
            					icon: 'ti-star',
            					message: "数据库连接成功"
            				},{
                				type: 'success',
                				timer: 4000
            				});
        				}
        				else
        				{
        					$.notify({
            					icon: 'ti-bell',
            					message: "数据库连接失败，可能数据库没有开启"
            				},{
                				type: 'danger',
                				timer: 4000
            				});
        				}
        			},
        			error:function(){
        				$.notify({
            				icon: 'ti-bell',
            				message: "数据库类型未选择或者是当前系统的<b>" + <%=session.getAttribute("databasetype")%>
                            + "</b>数据库初始化连接有错误"

            			},{
                			type: 'danger',
                			timer: 4000
            			});
        			},
        			dataType:"json"
        		});
        	}
		
		function dbdisconnect(){
			$.ajax({
    			type:"POST",
                url:"/MBBench-U/dbservlet",
                async:true,
    			data:{"functiontype":"dbdisconnect"},
    			success:function(data){
    				if(data.result == "true")
    				{
    					$.notify({
        					icon: 'ti-star',
        					message: "数据库连接已断开"
        				},{
            				type: 'success',
            				timer: 4000
        				});
    				}
    				else
    				{
    					$.notify({
        					icon: 'ti-bell',
        					message: "当前没有连接数据库"
        				},{
            				type: 'danger',
            				timer: 4000
        				});
    				}
    			},
    			error:function(){
    				$.notify({
        				icon: 'ti-bell',
        				message: "当前没有连接数据库"

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
