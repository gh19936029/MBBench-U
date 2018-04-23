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
                <li id="nav">
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
                    <a class="navbar-brand" href="#">复杂查询负载结果</a>
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
                        <h4 class="title">排序查询结果信息</h4> 
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
                                    <td><b>数值型排序</b></br>所有设备类型为“BLADE”的文件中，按“TOWERHEIGHT”字段倒序查询。</td>
                                    <td id="sort1_count"></td>
                                    <td id="sort1_speed"></td>
                                    <td id="sort1_time"></td> 
                                    
                                </tr> 
                                <tr>
                                    <td>2</td>
                                    <td><b>字符串型排序</b></br>所有设备类型为“BLADE”的文件中，按“AREANAME”字段正序查询。</td>
                                    <td id="sort2_count"></td>
                                    <td id="sort2_speed"></td>
                                    <td id="sort2_time"></td> 
                                    
                                </tr> 
                                <tr>
                                    <td>3</td>
                                    <td><b>时间型排序</b></br>所有设备类型为“BLADE”的文件中，按“SIMULATIONTIME”字段正序查询。</td>
                                    <td id="sort3_count"></td>
                                    <td id="sort3_speed"></td>
                                    <td id="sort3_time"></td>
                                </tr>                                      
                             </tbody>
                        </table>
                    </div>
                    <div class="content">
                        <input id="refleshqueryd" type="button" style="font-size: 18px;background: transparent;border: hidden;color: red;text-decoration: underline; float: right" value="刷新信息" onclick="querydreflesh()"/>
                        </dr/>
                        <br/>
                    </div>
                </div>             
            </div>

            <div class="container-fluid">
                <div class="card">
                    <div class="header">
                        <h4 class="title">最值及平均值查询结果信息</h4>
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
                                <td><b>平均值查询</b></br>查询每个文件“WINDSPEED”数组中所有数值的平均值。</td>
                                <td id="query1_count"></td>
                                <td id="query1_speed"></td>
                                <td id="query1_time"></td>

                            </tr>
                            <tr>
                                <td>2</td>
                                <td><b>最大值查询</b></br>查询每个文件“WINDSPEED”数组中所有数值的最大值。</td>
                                <td id="query2_count"></td>
                                <td id="query2_speed"></td>
                                <td id="query2_time"></td>

                            </tr>
                            <tr>
                                <td>3</td>
                                <td><b>最小值查询</b></br>查询每个文件“WINDSPEED”数组中所有数值的最小值。</td>
                                <td id="query3_count"></td>
                                <td id="query3_speed"></td>
                                <td id="query3_time"></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="container-fluid">
                <div class="card">
                    <div class="header">
                        <h4 class="title">异常文件检测结果信息</h4>
                    </div>
                    <div class="content table-responsive table-full-width">
                        <table class="table table-striped">
                            <thead>
                            <th>查询类型</th>
                            <th>待检测文件总数[条]</th>
                            <th>查询速度[条/毫秒]</th>
                            <th>查询用时[毫秒]</th>
                            <th>准确率</th>
                            <th>召回率</th>

                            </thead>
                            <tbody>
                            <tr>
                                <td><b>异常文件检测</b></br>检测生成的风速数据，以正常风速方差的最大值的2倍为基准检测异常文件。</td>
                                <td id="query4_count"></td>
                                <td id="query4_speed"></td>
                                <td id="query4_time"></td>
                                <td id="query4_acc"></td>
                                <td id="query4_recall"></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="content">
                        <input id="refleshquerye" type="button" style="font-size: 18px;background: transparent;border: hidden;color: red;text-decoration: underline; float: right" value="刷新信息" onclick="queryereflesh()"/>
                        </dr/>
                        <br/>
                    </div>
                </div>
            </div>

            <div class="container-fluid">

                <div id="hotfileresult" style="font-size:14px"class="container-fluid">
                    <div class="header">
                        <h4 class="title">热点文件查询用时折线图</h4>
                    </div>
                    <hr/>
                    <div class="col-md-12">
                        <div clas="row">
                            <div class="col-md-10">
                                <div class="nav-tabs-navigation">
                                    <div id="query1div" class="nav-tabs-wrapper">
                                        <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
                                            <li value="1"><a href="#1sdownmeta" data-toggle="tab">1点</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <hr/>
                        <div class="card">
                            <div class="g_12">
                                <div class="widget_contents">
                                    <div class="realtime_charts" id="query1"></div>
                                </div>
                            </div>
                            <hr/>
                            <div class="content">
                                <div id="query1chart" class="ct-chart"></div>
                                <div class="footer">
                                    <div class="chart-legend">
                                        <i class="fa fa-circle text-info"></i><span id="maxquery1chart"></span>
                                        <i class="fa fa-circle text-danger"></i><span id="minquery1chart"></span>
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
        //各表的间隔因子
        var query1s = 0;
        $(function(){
            var query1active = 0;
            $.ajax(
                {
                    type:"post",
                    url:"/MBBench-U/multiqueryresult",
                    async:true,
                    data:{
                        "connect": 100,
                        "copynum": $("#copynum").text()
                    },
                    success:function(data){

                        $("#sort1_count").text(data.sort1_count);
                        $("#sort1_speed").text(data.sort1_speed);
                        $("#sort1_time").text(data.sort1_time);
                        $("#sort2_count").text(data.sort2_count);
                        $("#sort2_speed").text(data.sort2_speed);
                        $("#sort2_time").text(data.sort2_time);
                        $("#sort3_count").text(data.sort3_count);
                        $("#sort3_speed").text(data.sort3_speed);
                        $("#sort3_time").text(data.sort3_time);

                        $("#query1_count").text(data.query1_count);
                        $("#query1_speed").text(data.query1_speed);
                        $("#query1_time").text(data.query1_time);
                        $("#query2_count").text(data.query2_count);
                        $("#query2_speed").text(data.query2_speed);
                        $("#query2_time").text(data.query2_time);
                        $("#query3_count").text(data.query3_count);
                        $("#query3_speed").text(data.query3_speed);
                        $("#query3_time").text(data.query3_time);

                        $("#query4_count").text(data.query4_count);
                        $("#query4_speed").text(data.query4_speed);
                        $("#query4_time").text(data.query4_time);
                        $("#query4_acc").text(data.query4_acc);
                        $("#query4_recall").text(data.query4_recall);

                    },
                    dataType:"json",
                    error:function(){
                    }
                });
            var choosecopy = 0;
            $("#copychoose ul li").bind('click', function(){
                choosecopy = parseInt($(this).val());
                var i = 1;
                $("#copychoose ul li").each(function(){
                    if(parseInt($(this).val()) == choosecopy){
                        $(this).find('a').text("第" + i + "版" + " √");
                    }
                    else{
                        $(this).find('a').text("第" + i + "版");
                    }
                    i++;
                });
                $("#copynum").text(choosecopy);
                $.ajax(
                    {
                        type:"post",
                        url:"/MBBench-U/multiqueryresult",
                        async:true,
                        data:{
                            "connect": 100,
                            "copynum": choosecopy
                        },
                        success:function(data){
                            $("#sort1_count").text(data.sort1_count);
                            $("#sort1_speed").text(data.sort1_speed);
                            $("#sort1_time").text(data.sort1_time);
                            $("#sort2_count").text(data.sort2_count);
                            $("#sort2_speed").text(data.sort2_speed);
                            $("#sort2_time").text(data.sort2_time);
                            $("#sort3_count").text(data.sort3_count);
                            $("#sort3_speed").text(data.sort3_speed);
                            $("#sort3_time").text(data.sort3_time);

                            $("#query1_count").text(data.query1_count);
                            $("#query1_speed").text(data.query1_speed);
                            $("#query1_time").text(data.query1_time);
                            $("#query2_count").text(data.query2_count);
                            $("#query2_speed").text(data.query2_speed);
                            $("#query2_time").text(data.query2_time);
                            $("#query3_count").text(data.query3_count);
                            $("#query3_speed").text(data.query3_speed);
                            $("#query3_time").text(data.query3_time);

                            $("#query4_count").text(data.query4_count);
                            $("#query4_speed").text(data.query4_speed);
                            $("#query4_time").text(data.query4_time);
                            $("#query4_acc").text(data.query4_acc);
                            $("#query4_recall").text(data.query4_recall);
                        },
                        dataType:"json",
                        error:function(){
                        }
                    });
            });

            $("#query1div ul li").bind('click',function(){

                query1s = parseInt($(this).val());
                var copynum = $("#copynum").text();
                if(work != null){
                    clearInterval(work);
                    work == null;
                }
                draw(query1s, 0, copynum, "query7", 0);
            });

        });

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
                url:"/MBBench-U/multiqueryresult",
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

        function querydreflesh(){
            var choosecopy = $("#copynum").text();

            $.ajax({
                type:"get",
                url:"/MBBench-U/multiqueryresult",
                async:true,
                data:{
                    "type":"queryd",
                    "copynum":choosecopy
                },
                success:function(data){
                    $("#sort1_count").text(data.sort1_count);
                    $("#sort1_speed").text(data.sort1_speed);
                    $("#sort1_time").text(data.sort1_time);
                    $("#sort2_count").text(data.sort2_count);
                    $("#sort2_speed").text(data.sort2_speed);
                    $("#sort2_time").text(data.sort2_time);
                    $("#sort3_count").text(data.sort3_count);
                    $("#sort3_speed").text(data.sort3_speed);
                    $("#sort3_time").text(data.sort3_time);
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

        function queryereflesh(){
            var choosecopy = $("#copynum").text();

            $.ajax({
                type:"get",
                url:"/MBBench-U/multiqueryresult",
                async:true,
                data:{
                    "type":"querye",
                    "copynum":choosecopy
                },
                success:function(data){
                    $("#query1_count").text(data.query1_count);
                    $("#query1_speed").text(data.query1_speed);
                    $("#query1_time").text(data.query1_time);
                    $("#query2_count").text(data.query2_count);
                    $("#query2_speed").text(data.query2_speed);
                    $("#query2_time").text(data.query2_time);
                    $("#query3_count").text(data.query3_count);
                    $("#query3_speed").text(data.query3_speed);
                    $("#query3_time").text(data.query3_time);
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

        function queryfreflesh(){
            var choosecopy = $("#copynum").text();

            $.ajax({
                type:"get",
                url:"/MBBench-U/multiqueryresult",
                async:true,
                data:{
                    "type":"queryf",
                    "copynum":choosecopy
                },
                success:function(data){
                    $("#query4_count").text(data.query4_count);
                    $("#query4_speed").text(data.query4_speed);
                    $("#query4_time").text(data.query4_time);
                    $("#query4_acc").text(data.query4_acc);
                    $("#query4_recall").text(data.query4_recall);
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
