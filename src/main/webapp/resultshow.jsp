<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.lang.management.ManagementFactory"%>
<%@page import="com.sun.management.OperatingSystemMXBean"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.*"%>
<%@page import="org.hyperic.sigar.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>基本信息</title>

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
<!--
	使用前提：要将lib文件下的所有非jar包文件放到jdk的bin目录下，不然不能读到系统信息
 -->
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
                    <a class="navbar-brand" href="#">系统信息</a>
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
                    </ul>
                </div>
            </div>
        </nav>
        <%
        	Properties prop = System.getProperties();
        	OperatingSystemMXBean osMxBean = (OperatingSystemMXBean) ManagementFactory.getOperatingSystemMXBean();
        	Sigar sigar = new Sigar();   	
        	OperatingSystem os = OperatingSystem.getInstance();
        	DecimalFormat decimalFormat=new DecimalFormat(".00");
        %>
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                    	<div class="card">
                            <div class="header">
                                <h4 class="title">JDK信息</h4>
                                <p class="category">内容仅供参考，如有错误请自行修正</p>
                            </div>
                            <div class="content table-responsive table-full-width">
                                <table class="table table-striped">
                                    <thead>
                                        <th>编号</th>
                                    	<th>类型</th>
                                    	<th>名称/大小</th>
                                    </thead>
                                    <tbody>
                                        <tr>
                                        	<td>1</td>
                                        	<td>JAVA版本</td>
                                        	<td id=""><%=System.getProperty("java.version") %></td>              	
                                        </tr>
                                        <tr>
                                        	<td>2</td>
                                        	<td>JAVA安装路径</td>
                                        	<td><%=System.getProperty("java.home") %></td>                                	
                                        </tr>
                                        <tr>
                                        	<td>3</td>
                                        	<td>当前虚拟机内存总量</td>
                                        	<td><%=(float)(Runtime.getRuntime().totalMemory() / (1024 * 1024)) %>MB</td>
                                        	
                                        </tr>
                                        <tr>
                                        	<td>4</td>
                                        	<td>当前虚拟机空闲内存</td>
                                        	<td><%=(float)(Runtime.getRuntime().freeMemory() / (1024 * 1024)) %>MB</td>
                                        	
                                        </tr>
                                        <tr>
                                        	<td>5</td>
                                        	<td>最大虚拟机内存容量</td>
                                        	<td><%=(float)(Runtime.getRuntime().maxMemory() / (1024 * 1024)) %>MB</td>	
                                        </tr>
                                        <tr>
                                        	<td>6</td>
                                        	<td>当前运行线程数量</td>
                                        	<%
                                        		ThreadGroup parentThread;
                                            	for (parentThread = Thread.currentThread().getThreadGroup(); parentThread
                                                    	.getParent() != null; parentThread = parentThread.getParent());
                                            int totalThread = parentThread.activeCount();

                                        	%>
                                        	<td><%=totalThread %>个</td>	
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                        <div class="card">
                            <div class="header">
                                <h4 class="title">系统基本信息</h4>
                                <p class="category">内容仅供参考，如有错误请自行修正</p>
                            </div>
                            <div class="content table-responsive table-full-width">
                                <table class="table table-striped">
                                    <thead>
                                        <th>编号</th>
                                    	<th>类型</th>
                                    	<th>名称/大小</th>
                                    </thead>
                                    <tbody>
                                        <tr>
                                        	<td>1</td>
                                        	<td>系统版本</td>
                                        	<td><%=os.getDescription() + " " + os.getVersion()%></td>              	
                                        </tr>
                                        <tr>
                                        	<td>2</td>
                                        	<td>CPU个数</td>
                                        	<td><%=Runtime.getRuntime().availableProcessors() %>个</td>                                	
                                        </tr>
                                        <tr>
                                        	<td>3</td>
                                        	<td>当前系统内存总量</td>
                                        	<td><%=(float)(osMxBean.getTotalPhysicalMemorySize() / (1024 * 1024)) %>MB</td>         	
                                        </tr>
                                        <tr>
                                        	<td>4</td>
                                        	<td>当前系统已用内存</td>
                                        	<td><%=(float)((osMxBean.getTotalPhysicalMemorySize()
                                        			- osMxBean.getFreePhysicalMemorySize()) / (1024 * 1024)) %>MB</td>       	
                                        </tr>
                                        <tr>
                                        	<td>5</td>
                                        	<td>当前系统空闲内存</td>
                                        	<td><%=(float)(osMxBean.getFreePhysicalMemorySize() / (1024 * 1024)) %>MB</td>      	
                                        </tr>                                      	                           	
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                        <div class="card">
                            <div class="header">
                                <h4 class="title">CPU信息</h4>
                                <p class="category">内容仅供参考，如有错误请自行修正</p>
                            </div>
                            <div class="content table-responsive table-full-width">
                                <table class="table table-striped">
                                    <thead>
                                        <th>编号</th>
                                    	<th>CPU总量MHz</th>
                                    	<th>CPU生产商</th>
                                    	<th>CPU类别</th>
                                    	<th>CPU缓存数量</th>
                                    </thead>
                                    <tbody>
                                        <%
                                        	CpuInfo infos[] = sigar.getCpuInfoList(); 
                                        	for(int j = 1; j <= infos.length; j++){
                                        		CpuInfo info = infos[j-1];
                                        	%>
                                        		<tr>
                                        			<td><%=j %></td>
                                        			<td><%=info.getMhz() %></td>
                                        			<td><%=info.getVendor() %></td>
                                        			<td><%=info.getModel() %></td>
                                        			<td><%=info.getCacheSize() %></td>
                                        		</tr>
                                        		<%
                                        	}
                                        %>                                  	
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                        <div class="card">
                            <div class="header">
                                <h4 class="title">磁盘信息</h4>
                                <p class="category">内容仅供参考，如有错误请自行修正</p>
                            </div>
                            <div class="content table-responsive table-full-width">
                                <table class="table table-striped">
                                    <thead>
                                        <th>编号</th>
                                    	<th>磁盘符号</th>
                                    	<th>总共容量(GB)</th>
                                    	<th>剩余容量(GB)</th>
                                    	<th>已用占比</th>
                                    	<th>读速度(MB/s)</th>
                                    	<th>写速度(MB/s)</th>
                                    </thead>
                                    <tbody> 
                                        <%
                                        	FileSystem fslist[] = sigar.getFileSystemList();                                      	
                                        	for(int i = 1; i <= fslist.length;i++){
                                        		FileSystem fs = fslist[i-1];
                                        		FileSystemUsage usage = null;
                                        		//解决光驱磁盘问题
                                        		try {  
                                                    usage = sigar.getFileSystemUsage(fs.getDirName());  
                                                } catch (SigarException e) { 
                                                    continue;  
                                                }
                                        		if(fs.getType() == 2){
                                        		%>
                                        		<tr>
                                        			<td><%=i %></td>
                                        			<td><%=fs.getDevName().split(":")[0] + " 盘" %></td>
                                        			<td><%=decimalFormat.format((float)(usage.getTotal() / (1024 * 1024))) %></td>
                                        			<td><%=decimalFormat.format((float)(usage.getFree() / (1024 * 1024))) %></td>
                                        			<td><%=usage.getUsePercent() * 100D %></td>
                                        			<td><%=((float)usage.getDiskReads() / 1024) %></td>
                                        			<td><%=((float)usage.getDiskWrites() / 1024) %></td>		
                                        		</tr>
                                        		<% 
                                        		}
                                        		else{
                                            		i--;
                                           		}
                                        	}
                        
                                       	%>                                  	
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                    </div>
                </div>
                
			</div>
		</div>
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
</html>