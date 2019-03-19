<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/08/10
  Time: 17:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="format-detection" content="telephone=no,email=no,address=no">
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <link rel="stylesheet" href="${ctx }/static/css/base.css" />
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/login-1.css">
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/tanchuan_hubei.css">
    <%--<link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/css/bootstrap.css" />--%>
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/bootstrap-table.css" />
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/assets/examples.css" />
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${ctx }/static/css/my-stlye.css" />
    <link rel="stylesheet" href="${ctx }/static/js/plugins/layer/skin/layer.css" />
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/my97DatePicker/WdatePicker.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/plugins/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/hubeiCon.js" ></script>
    <title>首页</title>
    <style>
        body{overflow-y:auto;}
        .table th{
            font-weight:inherit;
            background: #F3F3F3;
            /*border:none!important;*/
            text-align: center !important;
        }
        .bootstrap-table .table:not(.table-condensed) > tbody > tr > td:first-child{
            padding-right:12px;
            text-align: left;
        }
        .bootstrap-table .table:not(.table-condensed) > tbody > tr > td{
            padding-right:12px;
            text-align: right;
        }
        .fixed-table-container{
            border:none;
        }
        .pagination{
            margin-right: 4px;
        }
        .pull-right{
            margin-top: 6px!important;
            margin-bottom: 0px!important;
        }
    </style>

</head>
<body>
<div id="loading" class="loader">
    <img class="Rotation" src="${ctx}/static/img/load.png" width="32" height="32"/>
</div>
<div id="menu"  style="position:fixed;top: 10px;right: 20px;z-index:20000;font-size:12px;">
    <div class="xian" style="height:110px"></div>
    <ul>
        <li><a href="#item1" class="current"><span></span>- -特定病组费用控制</a></li>
        <li><a href="#item2"><span></span>- -病种平均住院费用增长率排名</a></li>
        <li><a href="#item3"><span></span>- -病种平均住院日增长率排名</a></li>
        <li><a href="#item4"><span></span>- -病种药占比增长率排名</a></li>
        <li><a href="#item5"><span></span>- -病种诊断费占比增长率排名</a></li>
        <li><a href="#item6"><span></span>- -病种耗材费占比增长率排名</a></li>
        <%--<li><a href="#item7"><span></span>- -中低风险死亡</a></li>--%>
    </ul>
</div>
<div class="top-demand" id="top-demand" >
    <ul>
        <li>
            <label>日期：</label>
            <select id="rqkj" disabled style="width: 60px;height: 24px;border-radius:2px;border: 1px solid #ddd">
                <option value="n">年</option>
                <option value="j">季</option>
                <option value="y">月</option>
            </select>
            <input type="text" class="Wdate " id="rq" style="width: 80px;height: 24px;vertical-align: middle;margin-bottom: 3px;border-radius:2px;border: 1px solid #ddd"
                   onfocus="WdatePicker({el:'rq',startDate:'%y',dateFmt:'yyyy',alwaysUseStartDate:true,maxDate:'%y'})">
        </li>
        <li>
            <div class="center-back-cs">
                <input hidden style="width: 150px; height: 24px;border-radius:2px;cursor: pointer" class="sj-pt" id="sj-pt" readonly="readonly" value="" type="text" placeholder="平台机构选择" />
                <input hidden style="width: 150px; height: 24px;border-radius:2px;cursor: pointer" class="sj-jb" id="sj-jb"  readonly="readonly" value="" type="text" placeholder="平台机构选择" />
            </div>
        </li>


    </ul>
    <div class="top-btn" style="cursor: pointer;" onclick="search()">查询</div>
</div>

<div class="main-center">

    <div id="item1" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;min-height:300px;">
            <div class="zhibiao-top back-zb">
                <b class="back-b">特定病组费用控制</b>
            </div>
            <div class=" zhibiao2">
                <div  class="biaoge-yqst table-responsive" style="margin:15px;">
                    <table class="table" id="table1" style="font-size: 12px;">
                        <thead id="thead1">
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div id="item2" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">病种平均住院费用增长率排名</b>
            </div>
            <div class="zhibiao2" id="data1" style="height:350px;"></div>
        </div>
    </div>
    <div id="item3" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">病种平均住院日增长率排名</b>
            </div>
            <div class="zhibiao2" id="data2" style="height:350px;"></div>
        </div>
    </div>
    <div id="item4" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">病种药占比增长率排名</b>
            </div>
            <div class="zhibiao2" id="data3" style="height:350px;"></div>
        </div>
    </div>
    <div id="item5" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">病种诊断费占比增长率排名</b>
            </div>
            <div class="zhibiao2" id="data4" style="height:350px;"></div>
        </div>
    </div>
    <div id="item6" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">病种耗材费占比增长率排名</b>
            </div>
            <div class="zhibiao2" id="data5" style="height:350px;"></div>
        </div>
    </div>


</div>

<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/bootstrap.min.js" ></script>
<%--<script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js" ></script>--%>
<script type="text/javascript" src="${ctx}/static/js/echarts.min.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/macarons.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/bootstrap-table.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/extensions/toolbar/bootstrap-table-toolbar.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/ga.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/dlchart.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/jsonpData.js" ></script>
<script>
    $(function(){
        hubeiCon.initCon('sj-pt','sj-jb');
    })
    $('body').delegate('.page-list button', 'click', function () {
        $(this).next().find("li").each(function(){
            if($(this).hasClass("active")){
                $(this).removeClass("active");
            }else {
                $(this).addClass("active");
                $(this).children().trigger("click");
            }
        })
    });
    $("body").delegate("tbody a","click",function(){
        var hospital = $(this).text();
        var year = $("#rq").val();
        loadHospitalDat(hospital,year);
    })
    //菜单滑动
    $(document).ready(function () {
        $(window).scroll(function () {
            var items = $(".main-center").find(".man-c-2");
            var menu = $("#menu");
            var top = $(document).scrollTop();
            var currentId = ""; //滚动条现在所在位置的item id
            items.each(function () {
                var m = $(this);
                //注意：m.offset().top代表每一个item的顶部位置
                if (top > m.offset().top - 400) {
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
    });
    //获取屏幕的高
    var H= 0;
    var flag = false;
    $(document).ready(function () {
        H=$('#top-demand').height();
        $('.main-center').css('padding-top',H+'px');
    })
//    var biIds =['5b0e9b69-fea7-4247-9144-bbaa82510a00'];//报表id
    var biIds =['1565af94-c309-4233-b8dd-57d8b0bd1fdf'];//报表id
    var biKeys =[];//报表返回softkey
    $(function () {
        $.ajax({
            type:"POST",
            url:"/HBI/loadBiKsy?biIds="+biIds,
            dataType: "json",
            success:function(data){
                biKeys =data;
                search("new");
            }
        });
        var date = new Date;
        var year=date.getFullYear();
        $("#rq").val(year);
    })

    function search(stats) {
        $("#loading").show();
        var loads=1;
        if(stats){
            flag = true;
        }else {
            flag = false;
        }
//        var day = date.getDate();
        var srq = $("#rq").val()+"-01-01";
        var erq = $("#rq").val()+"-12-31";
        //基数时间
        var srq1 = srq.replace(srq.substring(0,4),Number(srq.substring(0,4))-1);
        var erq1 = erq.replace(erq.substring(0,4),Number(erq.substring(0,4))-1);

        /*var shi = $("#shi").val();
        var yyjb = $("#yyjb").val();*/
        var bivar = "";
        $(".center-back-cs").find("input").each(function(){
            if($(this).css("display")!='none'){
                bivar=$(this).val();
                return false;
            }
        })
        if(bivar == "全省"){
            bivar = "@novalue|@novalue|@novalue|";
        }else {
            bivar = bivar.replace("全省","@novalue");
            if(bivar.indexOf("二级")>-1||bivar.indexOf("三级")>-1){
                bivar = bivar.replace("二级","|二级|");
                bivar = bivar.replace("三级","|三级|");
                if(bivar.indexOf("全部")>-1){
                    bivar = bivar.replace("全部","@novalue")
                }
                bivar += "|";
            }else{
                bivar = bivar.replace("全部","|@novalue|@novalue|");
            }
        }
        //特定病组费用控制
        var cxtj0 =  srq1+";"+erq1+";"+srq+";"+erq+"|";
        var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+escape(escape(bivar))+
            '&biyccs=&id=' +biKeys[0].id+'&softkey='+biKeys[0].softkey +
            '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=1';
        console.log(url0);
        $.ajax({
            type:"GET",
            url:url0,
            dataType: "jsonp",
            success:function(data){
                loads=loads-1;
                test(loads);
                data = jsonpDataInit(data);
                setData0(data);
                setData1(data);
                setData2(data);
                setData3(data);
                setData4(data);
                setData5(data);
            }
        });
    }

    //特定病组费用控制
    function setData0(data){
        var dataIndex = [0,2,4,6,8,10,12,14,16,18,20];
        //一级表头
        var th1 = "<tr><th rowspan='2' data-field='td0'>医院名称</th>";
        var tit =  data.title.column;
        var tit0 = tit[0].split(",");
        for(var i=1;i<dataIndex.length;i++) {
            th1 += "<th colspan='2'>" + tit0[dataIndex[i] - 1] + "</th>";
            i++;
        }
        th1+= "</tr>";
        var tableData = initBootstrapTableData(data,dataIndex);//jsop数据格式化为layuiTable数据格式
        var $table = $('#table1');
        if(flag){
            $("#thead1").empty();
            $("#thead1").append(th1+tableData.tr);
            $table.attr('data-pagination','true');
            $table.attr('data-toggle','table');
            $table.attr('data-page-size','6');
            $table.attr('data-page-list',[6, 'all']);
            $table.attr('data-height','249');
            $table.bootstrapTable({data: tableData.data});
        }else {
            $table.attr('data-toggle','table');
            $table.bootstrapTable('load', tableData.data);
        }
        $('#table1 th:first ').css({'width':'20%',"vertical-align": "middle"});
        tableData.data.length<=6&&$('.fixed-table-pagination').css('border-top','none');
    }
    //病种平均住院费用增长率排名
    function setData1(data) {
        var attr =[];
        for(var i =0;i<data.rows.row.length;i++){
            var str=[];
            str.push(data.rows.row[i].cell[4]);
            str.push(data.rows.row[i].cell[0]);
            attr.push(str);
        }
        var datax = [];
        var datay = [];
        for(var i=0;i<attr.length;i++){
            for(var j=i+1;j<attr.length;j++){
                if(Number(attr[i][0])<Number(attr[j][0])){
                    var cmi = attr[j][0];
                    attr[j][0] = attr[i][0];
                    attr[i][0] = cmi;
                    var hos = attr[j][1];
                    attr[j][1] = attr[i][1];
                    attr[i][1] = hos;
                }
            }
            datax.push(attr[i][1]);
            datay.push(attr[i][0]);
        }
        datax = datax.slice(0,20);
        datay = datay.slice(0,20);
        var myChart = echarts.init(document.getElementById('data1'));

        option = {
            tooltip : {
                trigger: 'axis'
            },
            legend: {
                data:['平均住院费用增长率排名']
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            visualMap: {
                show: false,
                min: 0,
                max: 14,
                dimension: 0,
                inRange: {
                    color: ['#229583', '#7abfb5']
                }
            },
            xAxis: {
                data: datax,
                axisLabel: {
                    inside: false,
                    textStyle: {
                        color: '#4ea397'
                    }
                },
                axisTick: {
                    show: true
                },
                axisLine: {
                    show: true
                },
                z: 10
            },
            yAxis: {
                axisLine: {
                    show: true
                },
                axisTick: {
                    show: true
                },
                axisLabel: {
                    textStyle: {
                        color: '#22c3aa'
                    }
                }
            },
//            dataZoom: [
//                {
//                    type: 'inside'
//                }
//            ],
            series: [
                {
                    type: 'bar',
                    itemStyle: {
                        normal: {color: 'rgba(0,0,0,0.05)'}
                    },
                    barGap:'-100%',
                    barCategoryGap:'40%',
                    animation: false
                },
                {
                    name:'平均住院费用增长率排名',
                    type: 'bar',
                    itemStyle: {
                        normal: {
                            color: new echarts.graphic.LinearGradient(
                                0, 0, 0, 1,
                                [
                                    {offset: 0, color: '#64cbbc'},
                                    {offset: 0.5, color: '#22c3aa'},
                                    {offset: 1, color: '#4ea397'}
                                ]
                            )
                        }
                    },
                    markLine : {
                        data : [
                            {type : 'average', name: '平均值',value:'平均值',itemStyle:{
                                normal:{/*lineStyle:{type:'solid'},*/color:'#4ea397'}}}
                        ]
                    },
                    data: datay
                }
            ]
        };
        myChart.setOption(option);
    }
    //病种平均住院日增长率排名
    function setData2(data) {
        var attr =[];
        for(var i =0;i<data.rows.row.length;i++){
            var str=[];
            str.push(data.rows.row[i].cell[8]);
            str.push(data.rows.row[i].cell[0]);
            attr.push(str);
        }
        var datax = [];
        var datay = [];
        for(var i=0;i<attr.length;i++){
            for(var j=i+1;j<attr.length;j++){
                if(Number(attr[i][0])<Number(attr[j][0])){
                    var cmi = attr[j][0];
                    attr[j][0] = attr[i][0];
                    attr[i][0] = cmi;
                    var hos = attr[j][1];
                    attr[j][1] = attr[i][1];
                    attr[i][1] = hos;
                }
            }
            datax.push(attr[i][1]);
            datay.push(attr[i][0]);
        }
        datax = datax.slice(0,20);
        datay = datay.slice(0,20);
        var myChart = echarts.init(document.getElementById('data2'));

        option = {
            tooltip : {
                trigger: 'axis'
            },
            legend: {
                data:['平均住院日增长率排名']
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            visualMap: {
                show: false,
                min: 0,
                max: 14,
                dimension: 0,
                inRange: {
                    color: ['#229583', '#7abfb5']
                }
            },
            xAxis: {
                data: datax,
                axisLabel: {
                    inside: false,
                    textStyle: {
                        color: '#4ea397'
                    }
                },
                axisTick: {
                    show: true
                },
                axisLine: {
                    show: true
                },
                z: 10
            },
            yAxis: {
                axisLine: {
                    show: true
                },
                axisTick: {
                    show: true
                },
                axisLabel: {
                    textStyle: {
                        color: '#22c3aa'
                    }
                }
            },
//            dataZoom: [
//                {
//                    type: 'inside'
//                }
//            ],
            series: [
                {
                    type: 'bar',
                    itemStyle: {
                        normal: {color: 'rgba(0,0,0,0.05)'}
                    },
                    barGap:'-100%',
                    barCategoryGap:'40%',
                    animation: false
                },
                {
                    name:'平均住院日增长率排名',
                    type: 'bar',
                    itemStyle: {
                        normal: {
                            color: new echarts.graphic.LinearGradient(
                                0, 0, 0, 1,
                                [
                                    {offset: 0, color: '#64cbbc'},
                                    {offset: 0.5, color: '#22c3aa'},
                                    {offset: 1, color: '#4ea397'}
                                ]
                            )
                        }
                    },
                    markLine : {
                        data : [
                            {type : 'average', name: '平均值',value:'平均值',itemStyle:{
                                normal:{/*lineStyle:{type:'solid'},*/color:'#4ea397'}}}
                        ]
                    },
                    data: datay
                }
            ]
        };
        myChart.setOption(option);
    }
    //病种药占比增长率排名
    function setData3(data) {
        var attr =[];
        for(var i =0;i<data.rows.row.length;i++){
            var str=[];
            str.push(data.rows.row[i].cell[12]);
            str.push(data.rows.row[i].cell[0]);
            attr.push(str);
        }
        var datax = [];
        var datay = [];
        for(var i=0;i<attr.length;i++){
            for(var j=i+1;j<attr.length;j++){
                if(Number(attr[i][0])<Number(attr[j][0])){
                    var cmi = attr[j][0];
                    attr[j][0] = attr[i][0];
                    attr[i][0] = cmi;
                    var hos = attr[j][1];
                    attr[j][1] = attr[i][1];
                    attr[i][1] = hos;
                }
            }
            datax.push(attr[i][1]);
            datay.push(attr[i][0]);
        }
        datax = datax.slice(0,20);
        datay = datay.slice(0,20);
        var myChart = echarts.init(document.getElementById('data3'));

        option = {
            tooltip : {
                trigger: 'axis'
            },
            legend: {
                data:['药占比增长率排名']
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            visualMap: {
                show: false,
                min: 0,
                max: 14,
                dimension: 0,
                inRange: {
                    color: ['#229583', '#7abfb5']
                }
            },
            xAxis: {
                data: datax,
                axisLabel: {
                    inside: false,
                    textStyle: {
                        color: '#4ea397'
                    }
                },
                axisTick: {
                    show: true
                },
                axisLine: {
                    show: true
                },
                z: 10
            },
            yAxis: {
                axisLine: {
                    show: true
                },
                axisTick: {
                    show: true
                },
                axisLabel: {
                    textStyle: {
                        color: '#22c3aa'
                    }
                }
            },
//            dataZoom: [
//                {
//                    type: 'inside'
//                }
//            ],
            series: [
                {
                    type: 'bar',
                    itemStyle: {
                        normal: {color: 'rgba(0,0,0,0.05)'}
                    },
                    barGap:'-100%',
                    barCategoryGap:'40%',
                    animation: false
                },
                {
                    name:'药占比增长率排名',
                    type: 'bar',
                    itemStyle: {
                        normal: {
                            color: new echarts.graphic.LinearGradient(
                                0, 0, 0, 1,
                                [
                                    {offset: 0, color: '#64cbbc'},
                                    {offset: 0.5, color: '#22c3aa'},
                                    {offset: 1, color: '#4ea397'}
                                ]
                            )
                        }
                    },
                    markLine : {
                        data : [
                            {type : 'average', name: '平均值',value:'平均值',itemStyle:{
                                normal:{/*lineStyle:{type:'solid'},*/color:'#4ea397'}}}
                        ]
                    },
                    data: datay
                }
            ]
        };
        myChart.setOption(option);
    }
    //病种诊断费占比增长率排名
    function setData4(data) {
        var attr =[];
        for(var i =0;i<data.rows.row.length;i++){
            var str=[];
            str.push(data.rows.row[i].cell[16]);
            str.push(data.rows.row[i].cell[0]);
            attr.push(str);
        }
        var datax = [];
        var datay = [];
        for(var i=0;i<attr.length;i++){
            for(var j=i+1;j<attr.length;j++){
                if(Number(attr[i][0])<Number(attr[j][0])){
                    var cmi = attr[j][0];
                    attr[j][0] = attr[i][0];
                    attr[i][0] = cmi;
                    var hos = attr[j][1];
                    attr[j][1] = attr[i][1];
                    attr[i][1] = hos;
                }
            }
            datax.push(attr[i][1]);
            datay.push(attr[i][0]);
        }
        datax = datax.slice(0,20);
        datay = datay.slice(0,20);
        var myChart = echarts.init(document.getElementById('data4'));

        option = {
            tooltip : {
                trigger: 'axis'
            },
            legend: {
                data:['诊断费占比增长率排名']
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            visualMap: {
                show: false,
                min: 0,
                max: 14,
                dimension: 0,
                inRange: {
                    color: ['#229583', '#7abfb5']
                }
            },
            xAxis: {
                data: datax,
                axisLabel: {
                    inside: false,
                    textStyle: {
                        color: '#4ea397'
                    }
                },
                axisTick: {
                    show: true
                },
                axisLine: {
                    show: true
                },
                z: 10
            },
            yAxis: {
                axisLine: {
                    show: true
                },
                axisTick: {
                    show: true
                },
                axisLabel: {
                    textStyle: {
                        color: '#22c3aa'
                    }
                }
            },
//            dataZoom: [
//                {
//                    type: 'inside'
//                }
//            ],
            series: [
                {
                    type: 'bar',
                    itemStyle: {
                        normal: {color: 'rgba(0,0,0,0.05)'}
                    },
                    barGap:'-100%',
                    barCategoryGap:'40%',
                    animation: false
                },
                {
                    name:'诊断费占比增长率排名',
                    type: 'bar',
                    itemStyle: {
                        normal: {
                            color: new echarts.graphic.LinearGradient(
                                0, 0, 0, 1,
                                [
                                    {offset: 0, color: '#64cbbc'},
                                    {offset: 0.5, color: '#22c3aa'},
                                    {offset: 1, color: '#4ea397'}
                                ]
                            )
                        }
                    },
                    markLine : {
                        data : [
                            {type : 'average', name: '平均值',value:'平均值',itemStyle:{
                                normal:{/*lineStyle:{type:'solid'},*/color:'#4ea397'}}}
                        ]
                    },
                    data: datay
                }
            ]
        };
        myChart.setOption(option);
    }
    //病种耗材费占比增长率排名
    function setData5(data) {
        var attr =[];
        for(var i =0;i<data.rows.row.length;i++){
            var str=[];
            str.push(data.rows.row[i].cell[20]);
            str.push(data.rows.row[i].cell[0]);
            attr.push(str);
        }
        var datax = [];
        var datay = [];
        for(var i=0;i<attr.length;i++){
            for(var j=i+1;j<attr.length;j++){
                if(Number(attr[i][0])<Number(attr[j][0])){
                    var cmi = attr[j][0];
                    attr[j][0] = attr[i][0];
                    attr[i][0] = cmi;
                    var hos = attr[j][1];
                    attr[j][1] = attr[i][1];
                    attr[i][1] = hos;
                }
            }
            datax.push(attr[i][1]);
            datay.push(attr[i][0]);
        }
        datax = datax.slice(0,20);
        datay = datay.slice(0,20);
        var myChart = echarts.init(document.getElementById('data5'));

        option = {
            tooltip : {
                trigger: 'axis'
            },
            legend: {
                data:['耗材费占比增长率排名']
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            visualMap: {
                show: false,
                min: 0,
                max: 14,
                dimension: 0,
                inRange: {
                    color: ['#229583', '#7abfb5']
                }
            },
            xAxis: {
                data: datax,
                axisLabel: {
                    inside: false,
                    textStyle: {
                        color: '#4ea397'
                    }
                },
                axisTick: {
                    show: true
                },
                axisLine: {
                    show: true
                },
                z: 10
            },
            yAxis: {
                axisLine: {
                    show: true
                },
                axisTick: {
                    show: true
                },
                axisLabel: {
                    textStyle: {
                        color: '#22c3aa'
                    }
                }
            },
//            dataZoom: [
//                {
//                    type: 'inside'
//                }
//            ],
            series: [
                {
                    type: 'bar',
                    itemStyle: {
                        normal: {color: 'rgba(0,0,0,0.05)'}
                    },
                    barGap:'-100%',
                    barCategoryGap:'40%',
                    animation: false
                },
                {
                    name:'耗材费占比增长率排名',
                    type: 'bar',
                    itemStyle: {
                        normal: {
                            color: new echarts.graphic.LinearGradient(
                                0, 0, 0, 1,
                                [
                                    {offset: 0, color: '#64cbbc'},
                                    {offset: 0.5, color: '#22c3aa'},
                                    {offset: 1, color: '#4ea397'}
                                ]
                            )
                        }
                    },
                    markLine : {
                        data : [
                            {type : 'average', name: '平均值',value:'平均值',itemStyle:{
                                normal:{/*lineStyle:{type:'solid'},*/color:'#4ea397'}}}
                        ]
                    },
                    data: datay
                }
            ]
        };
        myChart.setOption(option);
    }
</script>
</body>
</html>
