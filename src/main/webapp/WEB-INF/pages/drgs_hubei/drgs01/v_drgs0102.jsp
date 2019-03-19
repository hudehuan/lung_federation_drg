<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/08/10
  Time: 17:51
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
<div id="loading" class="loader">
    <img class="Rotation" src="${ctx}/static/img/load.png" width="32" height="32"/>
</div>
<div id="menu"  style="position:fixed;top: 10px;right: 20px;z-index:20000;font-size:12px;">
    <div class="xian" style="height: 60px;"></div>
    <ul>
        <li><a href="#item1" class="current"><span></span>- -机构费用增幅情况</a></li>
        <li><a href="#item2"><span></span>- -费用占比</a></li>
        <li><a href="#item3"><span></span>- -机构动因分析</a></li>
        <li><a href="#item4"><span></span>- -费用占比</a></li>
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
                <%--<input type="text" />--%>
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
    <div class="top-btn" onclick="search()">查询</div>
</div>
<div class="main-center">
    <div id="item1" class="man-c-2 hd-dian">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">机构费用增幅情况</b>
            </div>
            <div class="zhibiao2 table-div" id="data0" style="height:350px; width: 100%" ></div>
        </div>
    </div>

        <div id="item2" class="man-c-2 hd-dian col-xs-6">
            <div class="bg-f" style="overflow: hidden;height:auto">
                <div class="zhibiao-top back-zb" >
                    <b class="back-b">费用占比</b>
                </div>
                <div class="zhibiao2" id="data1" style="height:350px;">

                </div>
            </div>
        </div>

        <div class="man-c-2 col-xs-6">
            <div class="bg-f" style="overflow: hidden;height:auto">
                <div class="zhibiao-top back-zb">
                    <b class="back-b">收费方式占比</b>
                </div>
                <div class="zhibiao2" id="data2" style="height:350px;">

                </div>
            </div>
        </div>

    <div id="item3" class="man-c-2 hd-dian" style="padding-top:10px;">
        <div class="bg-f" style="overflow: hidden;min-height:385px;">
            <div class="zhibiao-top back-zb">
                <b class="back-b">机构动因分析</b>
            </div>
            <div class="zhibiao2">
                <div  class="biaoge-yqst table-responsive" style="margin:15px;">
                    <table class="table" id="table1" style="font-size: 12px;">
                        <thead id="thead1">
                        </thead>
                    </table>
                </div>
            </div>

            <div class="zhibiao2" id="tb-yft" >
                <div class="zhibiao2" style="width: 100%;text-align: center;font-weight: 600;">
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
                            <tr id="zy_jhdy">
                                <td>交互动因</td>

                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="item4" class="man-c-2 col-xs-6 hd-dian">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb" >
                <b class="back-b">费用占比</b>
            </div>
            <div class="zhibiao2" id="data5" style="height:350px;">

            </div>
        </div>
    </div>
    <div  class="man-c-2 col-xs-6">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">收费方式占比</b>
            </div>
            <div class="zhibiao2" id="data6" style="height:350px;">

            </div>
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
<script type="text/javascript" src="${ctx}/static/js/d3.3.5.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/d3.tips.js?v=1" ></script>
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
            var items = $(".main-center").find(".hd-dian");
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
    $("body").delegate('table td', 'mouseover', function (){
        $(this).attr('title','单击显示相关数据');
    });
    var biIds =['15c00a0f-f6a0-4d1a-b0d0-2d69c2f36561','6b3f06e6-8809-4bdc-8a56-447a47585e9d',
        '7f61be0f-6a5f-47eb-94b3-eb37ba9a5ca3'];//报表id
    var biKeys =[];//报表返回softkey
    $(function () {
        $.ajax({
            type:"POST",
            url:"/HBI/loadBiKsy?biIds="+biIds,
            dataType: "json",
            success:function(data){
                biKeys =data;
                search("now");
            }
        });
        var date = new Date;
        var year=date.getFullYear();
        $("#rq").val(year);
    })
    var data1,data2,data3 ;
    var fypjData = [];//费用监控平均值
    function search(stats) {
        $("#loading").show();
        var loads=3;
        if(stats){
            flag = true;
        }else {
            flag = false;
        }
//        var day = date.getDate();
        var srq = $("#rq").val()+"-01-01";
        var erq = $("#rq").val()+"-12-31";
        var yyjb = $("#yyjb").val();
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
        //费用增幅与机构动因 （费用动因分析）
        var cxtj0 = srq+";"+erq+"|";
        var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+escape(escape(bivar))+
            '&biyccs=&id=' +biKeys[0].id+'&softkey='+biKeys[0].softkey +
            '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=';
        $.ajax({
            type:"GET",
            url:url0,
            dataType: "jsonp",
            success:function(data){
                data = jsonpDataInit(data);
                loads=loads-1;
                test(loads);
                data1 = data;
                setData0_1(data);
//                setData0(data);
                setData3(data);
            }
        });
        //首页费用（三费表报数据）
        var cxtj1 = srq+";"+erq+"|";
        var url1 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+escape(escape(bivar))+
            '&biyccs=&id=' +biKeys[1].id+'&softkey='+biKeys[1].softkey +
            '&cxtj='+escape(cxtj1)+'&topdata=&timew=&weiplan=';
        $.ajax({
            type:"GET",
            url:url1,
            dataType: "jsonp",
            success:function(data){
                data = jsonpDataInit(data);
                data2 = data;
                loads=loads-1;
                test(loads);
                setData1(data);
            }
        });
        //收费方式占比（付款方式表报数据）
        var cxtj2 = srq+";"+erq+"|";
        var url2 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+escape(escape(bivar))+
            '&biyccs=&id=' +biKeys[2].id+'&softkey='+biKeys[2].softkey +
            '&cxtj='+escape(cxtj2)+'&topdata=&timew=&weiplan=';
        $.ajax({
            type:"GET",
            url:url2,
            dataType: "jsonp",
            success:function(data){
                data = jsonpDataInit(data);
                data3 = data;
                setData2(data);
                loads=loads-1;
                test(loads);
            }
        });
    }
    //费用增幅与机构动因
    function setData0_1(data){
        var chartdata=dlchart.getReportData(data);
        var  option={titlewidth:110,
            left:40,top:15,
        legend:[chartdata[11].name,chartdata[15].name,chartdata[4].name],
            tooltips:{formatter:function(data){ return data.d3+"<br/>"+"住院费用增长率:"+data.d0+"<br/>总费用增长率:"+data.d1+"<br/>门诊费用增长率:"+data.d2}},
            colors:["#b6a2de","#25d6bb","#5ab1ef"],
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

    function setData0(data){
        $(".lia").removeClass("active");
        $("#zff").addClass("active");

        loadData0("zff");
        function loadData0(lx){
            switch (lx){
                case "zff":
                    zff(data);
                    return;
                case "mz":
                    mz(data);
                    return;
                case "zy":
                    zy(data);
                    return;
            }
        }
        $('.lia').click(function(){
            if(!$(this).hasClass("active")) {
                var t = $(this).data("id");
                loadData0(t);
                $(".lia").removeClass("active");
                $(this).addClass("active");
            }
        })
    }
        function zff() {
            var myChart = echarts.init(document.getElementById('data0'));
            var chartdata=dlchart.getReportData(data1);
            var option = dlchart.CreateLineChart("",chartdata[0].data,chartdata[15],{ series : [
                {
                    markPoint : {
                        data : [
                            {type : 'max', name: '最大值'},
                            {type : 'min', name: '最小值'}
                        ]
                    },
                    smooth:true,
                    markLine : {
                        data : [
                            {name: '标线1起点', value: "标准",yAxis: 10,itemStyle:{ normal:{lineStyle:{type:'solid'},color:'red'} } },
                            {type : 'average', name: '平均值'}
                        ]
                    }
                }
            ]})
            myChart.setOption(option);
        }

        function mz(){
            var myChart7 = echarts.init(document.getElementById('data0'));
            var chartdata=dlchart.getReportData(data1);
            var option7 = dlchart.CreateLineChart("",chartdata[0].data,chartdata[11],{ series : [
                {
                    markPoint : {
                        data : [
                            {type : 'max', name: '最大值'},
                            {type : 'min', name: '最小值'}
                        ]
                    },
                    smooth:true,
                    markLine : {
                        data : [
                            {type : 'average', name: '平均值'}
                        ]
                    }
                }
            ]});
            myChart7.setOption(option7);
        }

        function zy() {
            var text=data1.title.reportmc;
            var myChart8 = echarts.init(document.getElementById('data0'));
            var chartdata=dlchart.getReportData(data1);
            var option8 = dlchart.CreateLineChart("",chartdata[0].data,chartdata[4],{ series : [
                {
                    markPoint : {
                        data : [
                            {type : 'max', name: '最大值'},
                            {type : 'min', name: '最小值'}
                        ]
                    },
                    smooth:true,
                    markLine : {
                        data : [
                            {type : 'average', name: '平均值'}
                        ]
                    }
                }
            ]});
            myChart8.setOption(option8);
        }




    //首页费用
    function setData1(data) {
        var text=data.title.reportmc;
        var datax=data.title.column[0];
        if(!data.rows.row.length){
            return;
        }
        var datay=data.rows.row[0].cell;
        var dataId=[2,3,8,11,12,13,14];
        var x1=[],y1=[];
        var  tit=datax.split(',');
        for(var i=0;i<dataId.length;i++){
            x1.push(tit[dataId[i]]);
            var j = '{"value":"'+datay[dataId[i]]+'","name":"'+tit[dataId[i]]+'"}';
            y1.push(JSON.parse(j));
            fypjData.push(datay[dataId[i]]);
        }

        var myChart = echarts.init(document.getElementById('data1'));
        var colors = ['#0d8c7a','#68d3d4','#7bd9a5','#0cd6e8','#87c4ef','#23c4ae','#2ad5bd'];

        var   option = dlchart.CreatePieChart("",x1,{name:"费用方式",data:y1},{color:colors},{index:0,option:{ center: ['50%', '45%']}});

        myChart.setOption(option);
    }
    //收费方式占比
    function setData2(data) {
        var text=data.title.reportmc;
        var datax=data.title.column[0];
        if(!data.rows.row.length){
            return;
        }
        var datay=data.rows.row[0].cell;
        var dataId=[2,4,6,8,10,12,14];
        var x1=[],y1=[];
        var  tit=datax.split(',');
        for(var i=0;i<dataId.length;i++){
            x1.push(tit[dataId[i]]);
            var j = '{"value":"'+datay[dataId[i]+1]+'","name":"'+tit[dataId[i]]+'"}';
            y1.push(JSON.parse(j));

        }

        var myChart = echarts.init(document.getElementById('data2'));
        var colors = ['#68d3d4','#8cc9f4','#0cd6e8','#0d8c7a','#64cbbc','#7bd9a5','#2ad5bd'];

        var   option = dlchart.CreatePieChart("",x1,{name:"费用方式",data:y1},{color:colors},{index:0,option:{ center: ['50%', '45%']}});

        myChart.setOption(option);
    }
    //机构费用信息
    function setData3(data) {
        var dataIndex = [0,1,2,3,8,9,10,15];
        var $table = $('#table1');
        var tableData = initBootstrapTableData(data,dataIndex);//jsop数据格式化为layuiTable数据格式
        var yljg = tableData.data[0].td0;
        for(var i=0; i<tableData.data.length; i++){
            tableData.data[i].td0 = "<a>"+tableData.data[i].td0+"</a>"
        }
        if(flag){
            $("#thead1").empty();
            $("#thead1").append(tableData.tr);
            $table.attr('data-pagination','true');
            $table.attr('data-toggle','table');
            $table.attr('data-page-size','6');
            $table.attr('data-height','218');
            $table.attr('data-page-list',[6, 'all']);
            $table.bootstrapTable({data: tableData.data});
        }else {
            $table.attr('data-toggle','table');
            $table.bootstrapTable('load', tableData.data);
        }

        loadData(yljg);
        $table.on("click-row.bs.table", function (e, row, element) {
                $('.success').removeClass('success');//去除之前选中的行的，选中样式
                $(element).addClass('success');//添加当前选中的 success样式用于区别
                var index = $('#table1').find('tr.success').data('index');//获得选中的行的id
            loadData(row.td0.replace(/<\/?[^>]*>/g,''));
        });
        $('#table1').bootstrapTable('hideColumn', 'yymcyc');
        $('#table1 th:first ').css({'width':'20%'});
        tableData.data.length<=6&&$('.fixed-table-pagination').css('border-top','none');
    }
    //机构费用信息点击事件
    function loadData(hospital) {
        var int=self.setInterval(function(){
            if(data1&&data2&&data3){
                window.clearInterval(int);
                $("#yljg").text(hospital);
                var cells = [];
                setData5(data2.title.column[0],cells);
                setData6(data3.title.column[0],cells);
                for(var i=0;i<data1.rows.row.length;i++){
                    if(data1.rows.row[i].cell[0]==hospital){
                        setData4(data1.rows.row[i].cell);
                        break;
                    }
                }
                for(var i=0;i<data2.rows.row.length;i++){
                    if(data2.rows.row[i].cell[1]==hospital){
                        setData5(data2.title.column[0],data2.rows.row[i].cell);
                        break;
                    }

                }
                for(var i=0;i<data3.rows.row.length;i++){
                    if(data3.rows.row[i].cell[0]==hospital){
                        setData6(data3.title.column[0],data3.rows.row[i].cell);
                        break;
                    }
                }
            }
        },100);


    }
    //机构费用增长动因分析
    function setData4(datay) {
        var eYear = parseInt($("#rq").val());
        var sYear = eYear-1;
//        var datay = data.rows.row[0].cell;
        //门诊情况
        $("#mz_title").empty();
        $("#mz_title").append("<td >门诊费用动因分析</td><td>"+sYear+"</td><td>"+eYear+"</td><td>费用增长</td><td>率增长构成</td>");
        $("#mz_mzzfy").empty();
        $("#mz_mzzfy").append("<td>门诊总费用</td><td class='hui-se-6'>"+datay[16]+ "</td><td class='hui-se-6'>"+datay[1]
            +"</td><td class='hui-se-6'>"+datay[28]+"</td>");
        if(datay[4].indexOf("-")>-1){
            $("#mz_mzzfy").append("$<td class='red'>"+datay[4]+"%</td>");
        }else {
            $("#mz_mzzfy").append("<td class='chen-se'>"+datay[4]+"%</td>");
        }
        $("#mz_mzjf").empty();
        $("#mz_mzjf").append(" <td>门诊均费</td><td class='hui-se-6'>"+datay[18]+"</td><td class='hui-se-6'>"+datay[3]
            +"</td><td class='hui-se-6'></td><td class='hui-se-6'></td>");
        $("#mz_mzl").empty();
        $("#mz_mzl").append("<td>门诊量</td><td class='hui-se-6'>"+datay[17]+"</td><td class='hui-se-6'>"+datay[2]
            +"</td><td class='hui-se-6'></td><td class='hui-se-6'></td>");
        $("#mz_jgdy").empty();
        $("#mz_jgdy").append(" <td>价格动因</td><td class='hui-se-6'></td><td class='hui-se-6'></td>" +
            "<td class='hui-se-6'>"+datay[22]+"</td>");
        if(datay[5].indexOf("-")>-1){
            $("#mz_jgdy").append("<td class='red'>"+datay[5]+"%</td>");
        }else{
            $("#mz_jgdy").append("<td class='chen-se'>"+datay[5]+"%</td>");
        }
        $("#mz_mzldy").empty();
        $("#mz_mzldy").append("<td>门诊量动因</td><td class='hui-se-6'></td><td class='hui-se-6'></td>" +
            "<td class='hui-se-6'>"+datay[23]+"</td>");
        if(datay[6].indexOf("-")>-1){
            $("#mz_mzldy").append("<td class='red'>"+datay[6]+"%</td>");
        }else {
            $("#mz_mzldy").append("<td class='chen-se'>"+datay[6]+"%</td>");
        }
        $("#mz_jhdy").empty();
        $("#mz_jhdy").append( "<td>交互动因</td><td class='hui-se-6'></td><td class='hui-se-6'></td>" +
            "<td class='hui-se-6'>"+datay[24]+"</td>");
        if(datay[7].indexOf("-")>-1){
            $("#mz_jhdy").append( "<td class='red'>"+datay[7]+"%</td>");
        }else {
            $("#mz_jhdy").append( "<td class='chen-se'>"+datay[7]+"%</td>");
        }
        //住院情况
        $("#zy_title").empty();
        $("#zy_title").append("  <td>住院费用动因分析</td ><td>"+sYear+"</td><td>"+eYear+"</td><td>费用增长</td><td>率增长构成</td>");
        $("#zy_zyzfy").empty();
        $("#zy_zyzfy").append(" <td>住院总费用</td><td class='hui-se-6'>"+datay[19]+"</td><td class='hui-se-6'>"+datay[8]+"</td>" +
            "<td class='hui-se-6'>"+datay[29]+"</td>");
        if(datay[11].indexOf("-")>-1){
            $("#zy_zyzfy").append("<td class='red'>"+datay[11]+"%</td>");
        }else {
            $("#zy_zyzfy").append("<td class='chen-se'>"+datay[11]+"%</td>");
        }
        $("#zy_zyjf").empty();
        $("#zy_zyjf").append(" <td>住院均费</td><td class='hui-se-6'>"+datay[21]+"</td><td class='hui-se-6'>"+datay[10]+"</td>" +
            "<td class='hui-se-6'></td><td class='hui-se-6'></td>");
        $("#zy_cyrc").empty();
        $("#zy_cyrc").append("   <td>出院人次</td> <td class='hui-se-6'>"+datay[20]+"</td><td class='hui-se-6'>"+datay[9]+"</td>" +
            "<td class='hui-se-6'></td><td class='hui-se-6'></td>");
        $("#zy_jgdy").empty();
        $("#zy_jgdy").append("  <td>价格动因</td><td class='hui-se-6'></td><td class='hui-se-6'></td>" +
            "<td class='hui-se-6'>"+datay[25]+"</td>");
        if(datay[12].indexOf("-")>-1){
            $("#zy_jgdy").append("<td class='red'>"+datay[12]+"%</td>");
        }else {
            $("#zy_jgdy").append("<td class='chen-se'>"+datay[12]+"%</td>");
        }
        $("#zy_cyrcdy").empty();
        $("#zy_cyrcdy").append("<td>出院人次动因</td> <td class='hui-se-6'></td><td class='hui-se-6'></td>" +
            "<td class='hui-se-6'>"+datay[26]+"</td>");
        if(datay[13].indexOf("-")>-1){
            $("#zy_cyrcdy").append("<td class='red'>"+datay[13]+"%</td>");
        }else {
            $("#zy_cyrcdy").append("<td class='chen-se'>"+datay[13]+"%</td>");
        }
        $("#zy_jhdy").empty();
        $("#zy_jhdy").append( "<td>交互动因</td><td class='hui-se-6'></td><td class='hui-se-6'></td>" +
            "<td class='hui-se-6'>"+datay[27]+"</td>");
        if(datay[14].indexOf("-")>-1){
            $("#zy_jhdy").append( "<td class='red'>"+datay[14]+"%</td>");
        }else {
            $("#zy_jhdy").append( "<td class='chen-se'>"+datay[14]+"%</td>");
        }
    }
    //机构首页费用
    function setData5(datax,datay) {
//        var datax=data.title.column[0];
//        var datay=data.rows.row[1].cell;
        var dataId=[2,3,8,11,12,13,14];
        var x1=[],y1=[],y2=[];
        var  tit=datax.split(',');
        for(var i=0;i<dataId.length;i++){
            var j = '{"name":"'+tit[dataId[i]]+'","max":"40"}';
            x1.push(JSON.parse(j));
            y1.push(datay[dataId[i]]);
        }
        var colors = ['#b7a3de','#5ab1ef'];
        var myChart = echarts.init(document.getElementById('data5'));
//        option = dlchart.CreateBarChart("",x1,{name:"费用占比",data:y1},{},{},{name:"总费用",value:100.00});
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
//                itemStyle : { normal: {label : {show: true}}},
                data : [
                    {
                        value : fypjData,
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
    //机构收费方式占比
    function setData6(datax,datay) {
//        var datax=data.title.column[0];
//        var datay=data.rows.row[1].cell;
        var dataId=[2,4,6,8,10,12,14];
        var x1=[],y1=[];
        var  tit=datax.split(',');
        for(var i=0;i<dataId.length;i++){
            x1.push(tit[dataId[i]]);
            var j = '{"value":"'+datay[dataId[i]+1]+'","name":"'+tit[dataId[i]]+'"}';
            y1.push(JSON.parse(j));

        }

        var myChart = echarts.init(document.getElementById('data6'));
        var colors = ['#68d3d4','#0d8c7a','#7bd9a5','#0cd6e8','#23c4ae','#87c4ef','#2ad5bd'];
        var   option = dlchart.CreatePieChart("",x1,{name:"收费方式",data:y1},{color:colors},{index:0,option:{ center: ['50%', '45%']}});

        myChart.setOption(option);
    }
</script>
</body>
</html>
