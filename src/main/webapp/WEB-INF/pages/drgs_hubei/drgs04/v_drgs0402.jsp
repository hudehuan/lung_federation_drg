<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/08/25
  Time: 10:19
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="format-detection" content="telephone=no,email=no,address=no">
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <link rel="stylesheet" href="${ctx }/static/js/layui/css/layui.css" />
    <link rel="stylesheet" href="${ctx }/static/css/base.css" />
    <link rel="stylesheet" href="${ctx }/static/css/my-stlye.css" />
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/assets/examples.css" />
    <link rel="stylesheet" href="${ctx }/static/js/plugins/layer/skin/layer.css" />


    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/my97DatePicker/WdatePicker.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/plugins/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/layui/layui.js"></script>
    <title></title>
    <style>
        body{overflow-y:auto;}

        /*d3.js样式*/
        .axis path,
        .axis line{
            fill: none;
            stroke: black;
            shape-rendering: crispEdges;

        }
        .tick{
            font-size: 12px;
        }
        .inner_line path, .inner_line line { fill: none; stroke:#E7E7E7; shape-rendering: crispEdges; }
        .d3-tip {
            line-height: 1.5;
            font-weight: bold;
            padding: 12px;
            background: rgba(0, 0, 0, 0.8);
            color: #fff;
            border-radius: 4px;
            font-size: 12px;
        }
    </style>
</head>
<body>
<div id="loading" class="loader"></div>
<div id="menu"  style="position:fixed;top: 10px;right: 20px;z-index:20000;font-size:12px;">
    <div class="xian" style="height: 25px;"></div>
    <ul>
        <li><a href="#item1" class="current"><span></span>- -近12月费用趋势</a></li>
        <li><a href="#item2" ><span></span>- -费用动因分析</a></li>
    </ul>
</div>
<div class="top-demand" id="top-demand" style="top: 0;">
    <ul>
        <li>
            <label>日期：</label>
            <select id="rqkj" disabled style="width: 60px;height: 24px;border-radius:2px;border: 1px solid #ddd">
                <option value="n">年</option>
                <option value="j">季</option>
                <option value="y">月</option>
            </select>
            <%--<input type="text" />--%>
            <input type="text" class="Wdate " id="rq" style="width: 80px;height: 24px;vertical-align: middle;margin-bottom: 3px;border-radius:2px;border: 1px solid #ddd"
                   onfocus="WdatePicker({el:'rq',startDate:'%y',dateFmt:'yyyy',alwaysUseStartDate:true,maxDate:'%y'})">

        </li>

    </ul>
    <div class="top-btn">查询</div>
</div>

<div class="main">
    <div id="item1" class="man-c-2" style="padding-top: 46px;">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b zbmca">近12月费用趋势</b>
            </div>
            <div class="zhibiao2 col-xs-8" id="data0" style="height:350px;">

            </div>
            <div class="zhibiao2 col-xs-4" id="data1" style="height:350px;">

            </div>
            <div class="zhibiao2"  >
                <table id="table0" style=" font-size: 12px; width: 100%" >
                </table>
            </div>
        </div>
    </div>

    <div id="item2" class="man-c-2 hd-dian" style="padding-top:10px;">
        <div class="bg-f" style="overflow: hidden;min-height:290px;">
            <div class="zhibiao-top back-zb">
                <b class="back-b">费用动因分析</b>
            </div>
            <div class="zhibiao2" id="tb-yft" >
                <div class="zhibiao2" style="width: 100%;text-align: center;font-weight: 600; padding-top:10px;">
                    <span style="color: #00a0e9;" id="yljg"></span><span style="color: #00a0e9;">费用增长动因分析</span>
                </div>
                <div class="col-xs-6 zhibiao1">
                    <div  class=" table-responsive">
                        <table class="table table-bordered back-jodh" style="font-size: 12px;">
                            <thead>
                            <tr id="mz_title" style="font-weight: 900">
                                <td >门诊费用动因分析</td>

                            </tr>
                            </thead>
                            <tbody>
                            <tr id="mz_mzzfy">
                                <td>门诊总费用</td>

                            </tr>
                            <tr id="mz_mzjf">
                                <td>门诊均费</td>

                            </tr>
                            <tr id="mz_mzl">
                                <td>门诊量</td>

                            </tr>
                            <tr id="mz_jgdy">
                                <td>价格动因</td>

                            </tr>
                            <tr id="mz_mzldy">
                                <td>门诊量动因</td>

                            </tr>
                            <tr id="mz_jhdy">
                                <td>交互动因</td>

                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-xs-6 zhibiao2">
                    <div  class=" table-responsive">
                        <table class="table table-bordered back-jodh" style="font-size: 12px;">
                            <thead>
                            <tr id="zy_title" style="font-weight: 900">
                                <td>住院费用动因分析</td >
                            </tr>
                            </thead>
                            <tbody>
                            <tr id="zy_zyzfy">
                                <td>住院总费用</td>
                            </tr>
                            <tr id="zy_zyjf">
                                <td>住院均费</td>
                            </tr>
                            <tr id="zy_cyrc">
                                <td>出院人次</td>
                            </tr>
                            <tr id="zy_jgdy">
                                <td>价格动因</td>
                            </tr>
                            <tr id="zy_cyrcdy">
                                <td>出院人次动因</td>
                            </tr>
                            <tr id="zy_jhdy"  >
                                <td  >交互动因</td>

                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- <div id="item3" class="man-c-2">
         <div class="bg-f" style="overflow: hidden;height:auto">
             <div class="zhibiao-top back-zb">
                 <b class="back-b">综合绩效排名</b>
             </div>
             <div class="w-h">
                 <div class="col-xs-4 zhibiao1">

                     <div class="zhibiao1" >
                         <div style="text-align: center; color: #00a0e9">
                         <span style="font-size: 20px;">
                              医院
                         </span>
                         </div>
                         <div style="text-align: center;color: #00a0e9">
                         <span style="font-size: 20px;">
                             2017年 第一季度
                         </span>
                         </div>
                         <div style="text-align: center">
                         <span style="font-size: 20px;">
                             同类机构医疗服务综合绩效排名
                         </span>
                         </div>
                     </div>

                     <div class="zhibiao1" style="width: 300px; border-radius:50%; line-height:300px;
                    text-align:center; background-color: #ffc72d;font-size: 180px; color: #ffffff;margin:0 auto;">
                         12
                     </div>
                 </div>
                 <div class="col-xs-8 zhibiao2" >
                     <div  class="biaoge-yqst table-responsive" style="margin-top: 15px;">
                         <table id="table1"></table>
                     </div>
                     <div  class="biaoge-yqst table-responsive" style="margin-top: 15px;">
                         <table id="table2"></table>
                     </div>
                     <div  class="biaoge-yqst table-responsive" style="margin-top: 15px;">
                         <table id="table3"></table>
                     </div>
                 </div>
             </div>
         </div>
     </div>--%>

</div>



<script type="text/javascript" src="${ctx}/static/js/echarts.min.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/macarons.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/dlchart.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/jsonpData.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/layuiData.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/d3.3.5.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/d3.tips.js?v=1" ></script>

<script>
    //获取屏幕的高
    var H= 0;
    var biIds =['2b6a1851-b530-4b00-bbef-feaaf2b70d2b','c83dca8b-cad4-4ffd-9be2-370351ec460a','c241f3a8-2a58-4817-a892-95bc37d12924'];//报表id
    var biKeys =[];//报表返回softkey
    var flag = true;
    $(function () {
        $(window).scroll(function () {
            var items = $(".main").find(".man-c-2");
            var menu = $("#menu");
            var top = $(document).scrollTop();
            var currentId = ""; //滚动条现在所在位置的item id
            items.each(function () {
                var m = $(this);
                //注意：m.offset().top代表每一个item的顶部位置
                if (top > m.offset().top - 300) {
                    currentId = "#" + m.attr("id");
                } else {
                    return false;
                }
            });
            var currentLink = menu.find(".current");
            if (currentId && currentLink.attr("href") != currentId) {
                currentLink.removeClass("current");
                menu.find("[href=" + currentId + "]").addClass("current");
            }
        });
        $('#menu li a').click(function () {
            $('html, body').animate({
                scrollTop: $($.attr(this, 'href')).offset().top-100
            }, 500);
            return false;
        });
        H=$('#top-demand').height();
        $('.main-center').css('padding-top',H+'px');
        $("#loading").fadeOut("slow");
        $.ajax({
            type:"POST",
            url:"/HBI/loadBiKsy?biIds="+biIds,
            dataType: "json",
            success:function(data){
                biKeys =data;
                search()
            }
        });

        var date = new Date;
        var year=date.getFullYear();
        $("#rq").val(year);
        $('.top-btn').click(function () {
            flag=false;
            search();
        })
    })

    function search() {
        var rq = $("#rq").val();
        var rqkj = $("#rqkj").val();
        var sTime = "",eTime = "",ssTime="",seTime="";
        sTime = rq + "-01-01";
        eTime = rq + "-12-31";
        var yyjb='三级'
        var cxtj0 = "";
        var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
            '&biyccs=&id=' +biKeys[0].id+'&softkey='+biKeys[0].softkey +
            '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=0';
        //获取权限
        $.ajax({
            type:"GET",
            url:url0,
            dataType: "jsonp",
            success:function(data){
                data = jsonpDataInit(data);

                var cxtj0 = sTime+";"+eTime+"|"+yyjb+"|@novalue|";
                var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
                    '&biyccs=&id=' +biKeys[2].id+'&softkey='+biKeys[2].softkey +
                    '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=0';
                $.ajax({
                    type:"GET",
                    url:url0,
                    dataType: "jsonp",
                    success:function(data0){
                       data0 = jsonpDataInit(data0);
                        setData0_1(data0)
                    }
                });

                //获取均值
                var cxtj0 = sTime+";"+eTime+"|@novalue|";
                var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
                    '&biyccs=&id=' +biKeys[1].id+'&softkey='+biKeys[1].softkey +
                    '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=1';
                $.ajax({
                    type:"GET",
                    url:url0,
                    dataType: "jsonp",
                    success:function(data0){
                        data0 = jsonpDataInit(data0);
                        //获取权限机构值
                        var cxtj0 = sTime+";"+eTime+"|"+data.rows.row[0].cell[0]+"|";
                        var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
                            '&biyccs=&id=' +biKeys[1].id+'&softkey='+biKeys[1].softkey +
                            '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=1';
                        $.ajax({
                            type:"GET",
                            url:url0,
                            dataType: "jsonp",
                            success:function(data1){
                                data1 = jsonpDataInit(data1);
                                setData1(data1,data0);
                                setData3(data1);
                            }
                        });

                    }
                });

            }
        });
    }

    function setData0_1(data){
        //data = jsonpDataInit(data);
        var chartdata=dlchart.getReportData(data);
        var  option={titlewidth:110,
            left:40,top:15,
            legend:[chartdata[11].name,chartdata[15].name,chartdata[4].name],
            tooltips:{formatter:function(data){ return data.d3+"<br/>"+"住院费用增长率:"+data.d0+"<br/>总费用增长率:"+data.d1+"<br/>门诊费用增长率:"+data.d2}},
            colors:["#0000FF","#FFFFFF","#FF0000"],
            fordata:chartdata[0].data,
            xAxis:chartdata[0].data,
            xshow:false,
            yAxis:{data:chartdata[15].data,formatter:function(d){return d+"%";},
                line:{color:"#ccc",width: "1px"},warnline:{color:"#ff0000",value:10}},
            linestyle:{show:true,startindex:0,endindex:2,color:"#cec9c9",width:"0.5px"},
            series:[
                {name:"",width:2,stroke:"0000FF",data:chartdata[11].data,mouse:true},
                {name:"",width:2,stroke:"steelblue",data:chartdata[15].data,mouse:true,click:function(data){/*alert("住院费用增长率:"+data.d0+"总费用增长率:"+data.d1+"门诊费用增长率:"+data.d2)*/}},
                {name:"",width:2,stroke:"FF0000",data:chartdata[4].data,mouse:true}
            ],
        };

        d3charts("data0",option)


    }

    function setData1(data,data0) {
        var text=data.title.reportmc;
        var datax=data.title.column;
        var datay=data.rows.row[1].cell;
        var datay2 = data0.rows.row[0].cell;
        var dataId=[32,33,34,35,36,37,38];
        var x1=[],y1=[],y2=[];
        var  tit=datax.split(',');
        for(var i=0;i<dataId.length;i++){
            var j = '{"name":"'+tit[dataId[i]]+'","max":"40"}';
            x1.push(JSON.parse(j));
            y1.push(datay[dataId[i]]);
            y2.push(datay2[dataId[i]]);
        }
        var colors = ['red','#22c3aa'];
        var myChart = echarts.init(document.getElementById('data1'));
        var  option = {

            tooltip: {},
            legend: {
                data: ['全省均值', '机构占比']
            },
            color:colors,
            radar: {
                center : ['50%','55%'],
                indicator: x1,
                axisLabel: {
                    // 坐标轴文本标签，详见axis.axisLabel
                    show: true,
                    textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
                        color: '#ccc'
                    },
                    formatter: function (value, index) {
                        // 格式化成月/日，只在第一个刻度显示年份
                        var texts = value;
                        if (index === 5||index === 1 ||index === 3) {
                            return texts;
                        }

                    }

                },
            },
            series: [{
                name: '全省均值 vs 机构占比',
                type: 'radar',
                data : [
                    {
                        value : y2,
                        name : '全省均值'
                    },
                    {
                        value : y1,
                        name : '机构占比'
                    }
                ]
            }]
        };
        myChart.setOption(option);

    }
    function setData3(data) {
        var eYear = parseInt($("#rq").val().substring(0,4));
        var sYear = eYear-1;
        var datay = data.rows.row[1].cell;
        //门诊情况
        $("#mz_title").empty();
        $("#mz_title").append("<td>门诊费用动因分析</td><td>"+sYear+"</td><td>"+eYear+"</td><td>费用增长</td><td>率增长构成</td>");
        $("#mz_mzzfy").empty();
        $("#mz_mzzfy").append("<td>门诊总费用</td><td class='hui-se-6'>"+datay[17]+ "</td><td class='hui-se-6'>"+datay[1]
            +"</td><td class='hui-se-6'>"+datay[30]+"</td>");
        if(datay[4].indexOf("-")>-1){
            $("#mz_mzzfy").append("$<td class='red'>"+datay[4]+"%</td>");
        }else {
            $("#mz_mzzfy").append("<td class='chen-se'>"+datay[4]+"%</td>");
        }
        $("#mz_mzjf").empty();
        $("#mz_mzjf").append(" <td>门诊均费</td><td class='hui-se-6'>"+datay[19]+"</td><td class='hui-se-6'>"+datay[3]
            +"</td><td class='hui-se-6'></td><td class='hui-se-6'></td>");
        $("#mz_mzl").empty();
        $("#mz_mzl").append("<td>门诊量</td><td class='hui-se-6'>"+datay[18]+"</td><td class='hui-se-6'>"+datay[2]
            +"</td><td class='hui-se-6'></td><td class='hui-se-6'></td>");
        $("#mz_jgdy").empty();
        $("#mz_jgdy").append(" <td>价格动因</td><td class='hui-se-6'></td><td class='hui-se-6'></td>" +
            "<td class='hui-se-6'>"+datay[23]+"</td>");
        if(datay[5].indexOf("-")>-1){
            $("#mz_jgdy").append("<td class='red'>"+datay[5]+"%</td>");
        }else{
            $("#mz_jgdy").append("<td class='chen-se'>"+datay[5]+"%</td>");
        }
        $("#mz_mzldy").empty();
        $("#mz_mzldy").append("<td>门诊量动因</td><td class='hui-se-6'></td><td class='hui-se-6'></td>" +
            "<td class='hui-se-6'>"+datay[24]+"</td>");
        if(datay[6].indexOf("-")>-1){
            $("#mz_mzldy").append("<td class='red'>"+datay[6]+"%</td>");
        }else {
            $("#mz_mzldy").append("<td class='chen-se'>"+datay[6]+"%</td>");
        }
        $("#mz_jhdy").empty();
        $("#mz_jhdy").append( "<td>交互动因</td><td class='hui-se-6'></td><td class='hui-se-6'></td>" +
            "<td class='hui-se-6'>"+datay[25]+"</td>");
        if(datay[7].indexOf("-")>-1){
            $("#mz_jhdy").append( "<td class='red'>"+datay[7]+"%</td>");
        }else {
            $("#mz_jhdy").append( "<td class='chen-se'>"+datay[7]+"%</td>");
        }
        //住院情况
        $("#zy_title").empty();
        $("#zy_title").append("  <td>住院费用动因分析</td ><td>"+sYear+"</td><td>"+eYear+"</td><td>费用增长</td><td>率增长构成</td>");
        $("#zy_zyzfy").empty();
        $("#zy_zyzfy").append(" <td>住院总费用</td><td class='hui-se-6'>"+datay[20]+"</td><td class='hui-se-6'>"+datay[8]+"</td>" +
            "<td class='hui-se-6'>"+datay[29]+"</td>");
        if(datay[11].indexOf("-")>-1){
            $("#zy_zyzfy").append("<td class='red'>"+datay[11]+"%</td>");
        }else {
            $("#zy_zyzfy").append("<td class='chen-se'>"+datay[11]+"%</td>");
        }
        $("#zy_zyjf").empty();
        $("#zy_zyjf").append(" <td>住院均费</td><td class='hui-se-6'>"+datay[22]+"</td><td class='hui-se-6'>"+datay[10]+"</td>" +
            "<td class='hui-se-6'></td><td class='hui-se-6'></td>");
        $("#zy_cyrc").empty();
        $("#zy_cyrc").append("   <td>出院人次</td> <td class='hui-se-6'>"+datay[21]+"</td><td class='hui-se-6'>"+datay[9]+"</td>" +
            "<td class='hui-se-6'></td><td class='hui-se-6'></td>");
        $("#zy_jgdy").empty();
        $("#zy_jgdy").append("  <td>价格动因</td><td class='hui-se-6'></td><td class='hui-se-6'></td>" +
            "<td class='hui-se-6'>"+datay[26]+"</td>");
        if(datay[12].indexOf("-")>-1){
            $("#zy_jgdy").append("<td class='red'>"+datay[12]+"%</td>");
        }else {
            $("#zy_jgdy").append("<td class='chen-se'>"+datay[12]+"%</td>");
        }
        $("#zy_cyrcdy").empty();
        $("#zy_cyrcdy").append("<td>出院人次动因</td> <td class='hui-se-6'></td><td class='hui-se-6'></td>" +
            "<td class='hui-se-6'>"+datay[27]+"</td>");
        if(datay[13].indexOf("-")>-1){
            $("#zy_cyrcdy").append("<td class='red'>"+datay[13]+"%</td>");
        }else {
            $("#zy_cyrcdy").append("<td class='chen-se'>"+datay[13]+"%</td>");
        }
        $("#zy_jhdy").empty();
        $("#zy_jhdy").append( "<td>交互动因</td><td class='hui-se-6'></td><td class='hui-se-6'></td>" +
            "<td class='hui-se-6'>"+datay[28]+"</td>");
        if(datay[14].indexOf("-")>-1){
            $("#zy_jhdy").append( "<td class='red'>"+datay[14]+"%</td>");
        }else {
            $("#zy_jhdy").append( "<td class='chen-se'>"+datay[14]+"%</td>");
        }
    }

</script>
</body>
</html>
