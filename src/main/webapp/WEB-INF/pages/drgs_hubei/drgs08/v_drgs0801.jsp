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
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/bootstrap-table.css" />

    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/my97DatePicker/WdatePicker.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/plugins/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/layui/layui.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/hubeiCon.js"></script>
    <title></title>
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
<body style="height: 98%">
<div id="loading" class="loader">
    <img class="Rotation" src="${ctx}/static/img/load.png" width="32" height="32"/>
</div>
<%--<div id="menu" hidden style="position:fixed;top: 10px;right: 20px;z-index:20000;font-size:12px;">
    <div class="xian" style="height: 25px;"></div>
    <ul>
        <li><a href="#item1" class="current"><span></span>- -近12月费用趋势</a></li>
        <li><a href="#item2" ><span></span>- -费用动因分析</a></li>
    </ul>
</div>--%>
<div class="top-demand" hidden id="top-demand" style="top: 0;">
    <ul>
        <li>
            <label>日期：</label>
            <select id="rqkj" onchange="hubeiCon.changeRqkj()" style="width: 60px;height: 24px;border-radius:2px;border: 1px solid #ddd">
                <option value="n">年</option>
                <option value="j">季</option>
                <%--<option value="y">月</option>--%>
            </select>
            <%--<input type="text" />--%>
            <input type="text" class="Wdate " id="rq" style="width: 80px;height: 24px;vertical-align: middle;margin-bottom: 3px;border-radius:2px;border: 1px solid #ddd"
                   onfocus="WdatePicker({el:'rq',startDate:'%y',dateFmt:'yyyy',alwaysUseStartDate:true,maxDate:'%y'})">

        </li>

    </ul>
    <div class="top-btn">查询</div>
</div>

<div class="main">
    <div id="item1" class="man-c-2" style="padding-top: 0px;">
        <div class="bg-f" style="overflow: hidden;height:500px;">
            <div class="zhibiao-top back-zb">
                <b class="back-b zbmca">近12月费用趋势</b>
                <a href="###" id="daochu"  class="daochu">导出</a>
                <a href="###" id="daochuimg1" style="display: none;">导出</a>
                <a href="###" id="daochuimg2" style="display: none;">导出</a>
            </div>
            <div class="zhibiao2 col-xs-8" id="data0" style="height:350px;">

            </div>
            <div class="zhibiao2 col-xs-4" id="data1" style="height:350px;">

            </div>
            <div class="zhibiao2"  >
                <%--<table id="table0" style=" font-size: 12px; width: 100%" >--%>
                <%--</table>--%>
                <div  class="biaoge-yqst table-responsive" style="margin:15px;">
                    <table class="table" id="table0" style="font-size: 12px;">
                        <thead>
                        <tr>
                            <th data-field="td0" data-sortable="true" >费用类型</th>
                            <th data-field="td1" data-sortable="true" >费用</th>
                            <th data-field="td2" data-sortable="true" >增长率</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div id="item2" class="man-c-2 hd-dian" style="padding-top:10px;">
        <div class="bg-f" style="overflow: hidden;min-height:290px;">
            <div class="zhibiao-top back-zb">
                <b class="back-b">费用动因分析</b>
                <a href="###" id="daochu1"  class="daochu">导出</a>
            </div>
            <div class="zhibiao2" id="tb-yft" >
                <div class="zhibiao2" style="width: 100%;text-align: center;font-weight: 600; padding-top:10px;">
                    <span style="color: #00a0e9;" id="yljg"></span><span style="color: #00a0e9;">费用增长动因分析</span>
                </div>
                <div class="col-xs-6 zhibiao1">
                    <div  class=" table-responsive"  id="mzfydyfx">
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
                <div class="col-xs-6 zhibiao2" id="zyfydyfx">
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
</div>

<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/bootstrap.min.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/bootstrap-table.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/extensions/toolbar/bootstrap-table-toolbar.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/ga.js" ></script>

<script type="text/javascript" src="${ctx}/static/js/echarts.min.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/macarons.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/dlchart.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/jsonpData.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/layuiData.js" ></script>
<script type="text/javascript" src="${ctx }/static/js/export.js"></script>
<script>
    //获取屏幕的高
    var H= 0;
    var biIds =['2578f351-4e31-4968-8665-e00c7c9e19ea','c83dca8b-cad4-4ffd-9be2-370351ec460a'];//报表id
    var biKeys =[];//报表返回softkey
    var flag = true;
    $(function () {
        var date = new Date;
        var year=date.getFullYear();
        $("#rq").val(year);
        if("${hospital}"){
            $("#rq").val("${year}");
            $("#rqkj").val("${rqkj}");
            biIds[0] = "1b359425-ee43-43c1-b5c3-779e9b26af76";

        }else{
            $("#top-demand").show();
            $("#menu").show();
            H=$('#top-demand').height();
            $('#item1').css('padding-top',H+'px');
        }
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
        $.ajax({
            type:"POST",
            url:"/HBI/loadBiKsy?biIds="+biIds,
            dataType: "json",
            success:function(data){
                biKeys =data;
                search()
            }
        });

        $('.top-btn').click(function () {
            flag=false;
            search();
        })
    })
    function search() {
        $("#loading").show();
        var loads=0;
        var cxsj = hubeiCon.getTimeStr();
        var cxtj0 = cxsj+ "|";
        if("${hospital}"){
            cxtj0 = "${hospital}|"+cxtj0;
        }
        if("${userType}"!='机构'){
            $('#daochu').show();
            $('#daochu1').show();
        }
        var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
            '&biyccs=&id=' +biKeys[0].id+'&softkey='+biKeys[0].softkey +
            '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=';
        //获取权限
        $.ajax({
            type:"GET",
            url:url0,
            dataType: "jsonp",
            success:function(data){
                data = jsonpDataInit(data);

                var cxtj0 = cxsj+"|"+data.rows.row[0].cell[0]+"|";
                var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
                    '&biyccs=&id=' +biKeys[1].id+'&softkey='+biKeys[1].softkey +
                    '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=0';
                loads=loads+1;
                $.ajax({
                    type:"GET",
                    url:url0,
                    dataType: "jsonp",
                    success:function(data0){
                        loads=loads-1;
                        test(loads);
                        data0 = jsonpDataInit(data0);
                        setData0(data0);
                    }
                });

                //获取均值
                var cxtj0 = cxsj+"|@novalue|";
                var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
                    '&biyccs=&id=' +biKeys[1].id+'&softkey='+biKeys[1].softkey +
                    '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=1';
                loads=loads+1;
                $.ajax({
                    type:"GET",
                    url:url0,
                    dataType: "jsonp",
                    success:function(data0){
                        data0 = jsonpDataInit(data0);
                        //获取权限机构值
                        var cxtj0 = cxsj+"|"+data.rows.row[0].cell[0]+"|";
                        var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
                            '&biyccs=&id=' +biKeys[1].id+'&softkey='+biKeys[1].softkey +
                            '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=1';
                        $.ajax({
                            type:"GET",
                            url:url0,
                            dataType: "jsonp",
                            success:function(data1){
                                loads=loads-1;
                                test(loads);
                                data1 = jsonpDataInit(data1);
                                setData1(data1,data0);
                                setData2(data1);
                                setData3(data1);
                            }
                        });

                    }
                });

            }
        });
    }

    function setData0(data) {
        var datax = [];
        var datay = [[],[],[]];
        for(var i=1;i<data.rows.row.length;i++){
            datax.push(data.rows.row[i].cell[0]);
            datay[0].push(data.rows.row[i].cell[15]);
            datay[1].push(data.rows.row[i].cell[1]);
            datay[2].push(data.rows.row[i].cell[8]);
        }
        var tit = data.title.column.split(",");
        var myChart = echarts.init(document.getElementById('data0'));
        var colors=['#57D4B5','#B7A3DE','#F58839']
        var option = dlchart.CreateLineChart("",datax,[{name:tit[15],data:datay[0]},{name:tit[1],data:datay[1]},{name:tit[8],data:datay[2]}],{color:colors,
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            }
        },{},null);
        myChart.setOption(option);
    }

    function setData1(data,data0) {
        var text=data.title.reportmc;
        var datax=data.title.column;
        var datay = [];
        if(data.rows.row.length<2) {
            var i = data.rows.row[0].cell.length;
            while (i--) {
                datay[i] = '';
            }
        }else{
            datay=data.rows.row[1].cell;
        }
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
        var colors = ['#b7a3de','#5ab1ef'];
        var myChart = echarts.init(document.getElementById('data1'));
        var option = dlchart.CreateRadarChart("",x1,[{name:"全省均值 VS 机构占比",data:[{value:y2,name:"全省均值"},{value:y1,name:"机构占比"}]}],
            {legend: {
                data: ['全省均值', '机构占比']
            },color:colors,
        },{});
        myChart.setOption(option);

    }

    function setData2(data) {

        var tableData =[];
        var datay = [];
        if(data.rows.row.length<2) {
            var i = data.rows.row[0].cell.length;
            while (i--) {
                datay[i] = '';
            }
        }else{
            datay=data.rows.row[1].cell;
        }
        var $table = $('#table0');
        var fylx = ['总费用','门诊费用','住院费用'];
        tableData.push({
            "td0":fylx[0],
            "td1":datay[15]+"元",
            "td2":datay[16]+"%"
        })
        tableData.push({
            "td0":fylx[1],
            "td1":datay[1]+"元",
            "td2":datay[4]+"%",
        })
        tableData.push({
            "td0":fylx[2],
            "td1":datay[8]+"元",
            "td2":datay[11]+"%",
        })
        $table.bootstrapTable('destroy');
        $table.attr('data-pagination','true');
        $table.attr('data-toggle','table');
        $table.attr('data-page-size','6');
        $table.attr('data-height','218');
        $table.attr('data-page-list',[6, 'all']);
        $table.bootstrapTable({data: tableData});

        $('#table0 th:first ').css({'width':'20%'});
        tableData.length<=6&&$('.fixed-table-pagination').css('border-top','none');


       /* var datay = data.rows.row[1].cell;
        var width = $("#table0").width();
        var cols = [{"field":"td0","title":"费用类型","width":parseInt(width/3-1),"align":"center"},
            {"field":"td1","title":"费用","width":parseInt(width/3-1),"align":"center"},
            {"field":"td2","title":"增长率","width":parseInt(width/3-1),"align":"center"}];
        var tableData =[{"td0":"总费用", "td1":datay[15]+"元", "td2":datay[16]+"%"},
            {"td0":"门诊费用", "td1":datay[1]+"元", "td2":datay[4]+"%"},
            {"td0":"住院费用", "td1":datay[8]+"元", "td2":datay[11]+"%"}];
        layui.use('table', function() {
            var table = layui.table;
            window.demoTable = table.render({
                elem: '#table0',
                data: tableData,
                cols: [cols],
                skin: 'row', //表格风格
                even: true,
            });
        });*/
    }

    function setData3(data) {
        var eYear = parseInt($("#rq").val().substring(0,4));
        var sYear = eYear-1;
        var datay = [];
        if(data.rows.row.length<2) {
            var i = data.rows.row[0].cell.length;
            while (i--) {
                datay[i] = '';
            }
        }else{
            datay=data.rows.row[1].cell;
        }
        //门诊情况
        $("#mz_title").empty();
        $("#mz_title").append("<td>门诊费用动因分析</td><td>"+sYear+"</td><td>"+eYear+"</td><td>费用增长</td><td>率增长构成</td>");
        $("#mz_mzzfy").empty();
        $("#mz_mzzfy").append("<td>门诊总费用</td><td class='hui-se-6'>"+datay[17]+ "</td><td class='hui-se-6'>"+datay[1]
            +"</td><td class='hui-se-6'>"+datay[29]+"</td>");
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
            "<td class='hui-se-6'>"+datay[30]+"</td>");
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
    var n=0;
    $('#daochu').click(function () {
        n++;
        getFullCanvasDataURL('data0','daochuimg1',n+'费用分析.png');
        getFullCanvasDataURL('data1','daochuimg2',n+'费用占比.png');
        var tablehtml1='<tr><td colspan="2" style="width: 720px;height: 350px;"><img src="'+n+'费用分析.png"></td><td style="width: 340px;height: 350px;"><img src="'+n+'费用占比.png"></td></tr>'
        var tablehtml=tablehtml1+$('#table0 thead').html()+$('#table0 tbody').html();
        tableToExcel('table',tablehtml,'近12月费用趋势');
    });
    $('#daochu1').click(function () {
        $('.page-list button').click();
        var tablehtml=$('#mzfydyfx thead').html()+$('#mzfydyfx tbody').html()+$('#zyfydyfx table').html();
        tableToExcel('table',tablehtml,'费用动因分析');
    });

</script>
</body>
</html>
