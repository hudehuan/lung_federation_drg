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
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/login-1.css">
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/tanchuan_hubei.css">
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/bootstrap-table.css" />
    <link rel="stylesheet" type="text/css" href="${ctx }/static/js/jquery-easyui-1.5/themes/default/easyui.css">

    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/my97DatePicker/WdatePicker.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/plugins/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/layui/layui.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/hubeiCon.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/common.js"></script>
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
<body>
<div id="loading" class="loader">
    <img class="Rotation" src="${ctx}/static/img/load.png" width="32" height="32"/>
</div>
<div id="menu"  style="position:fixed;top: 10px;right: 20px;z-index:20000;font-size:12px;">
    <%--<div class="xian" style="height: 25px;"></div>--%>
    <%--<ul>--%>
        <%--<li><a href="#item1" class="current"><span></span>- -医生医疗服务绩效总览</a></li>--%>
        <%--<li><a href="#item2"><span></span>- -每医生服务能力</a></li>--%>
    <%--</ul>--%>
</div>
<div class="top-demand" hidden id="top-demand" style="top: 0;">
    <ul>
        <li>
            <label>日期：</label>
            <select id="rqkj" onchange="hubeiCon.changeRqkj()" style="width: 60px;height: 24px;border-radius:2px;border: 1px solid #ddd">
                <option value="n">年</option>
                <option value="j">季</option>
                <option value="y">月</option>
            </select>
            <input type="text" class="Wdate " id="rq" style="width: 80px;height: 24px;vertical-align: middle;margin-bottom: 3px;border-radius:2px;border: 1px solid #ddd"
                   onfocus="WdatePicker({el:'rq',startDate:'%y',dateFmt:'yyyy',alwaysUseStartDate:true,maxDate:'%y'})">

        </li>
        <li>
            <div class="center-back-cs">
                <input  style="width: 150px; height: 24px;border-radius:2px;cursor: pointer"
                        class="sj-ks" id="sj-ks" readonly="readonly" value="" type="text" placeholder="科室选择" />
                <input  style="width: 150px; height: 24px;border-radius:2px;cursor: pointer"
                        class="sj-bz" id="sj-bz"  readonly="readonly" value="" type="text" placeholder="DRGs病组选择" />
            </div>
        </li>
    </ul>
    <div class="top-btn">查询</div>
</div>

<div class="main">
    <div id="item1" class="man-c-2" style="padding-top: 0px;">
        <div class="bg-f" style="overflow: hidden;min-height:140px;">
            <div class="bg-f" style="overflow: hidden;height:auto">
                <div class="col-xs-12 ">
                    <div style="padding-left: 40px; ">
                        <span style="font-size: 20px; color: #00a0e9" id="hospital"></span>
                        <span style="font-size: 20px; padding-left: 50px; color: #00a0e9" id="kemu"></span>
                        <span style="font-size: 20px; padding-left: 150px;" id="">医生医疗服务绩效总览</span>
                        <a href="###" id="daochu"  class="daochu" style="margin-right:0">导出</a>
                    </div>
                </div>
                <div class="col-xs-6 zhibiao2" style="width: 100%;" id="tabx4">
                    <div  class="biaoge-yqst table-responsive" style="margin-top: 15px;">
                        <table id="table1" class="table" style="font-size: 12px;">
                            <thead id="thead1">
                            <tr>
                            </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="item2" class="man-c-2">
            <div class="bg-f" style="overflow: hidden;min-height:650px;">
                <div class="zhibiao-top back-zb">
                    <b class="back-b zbmca">医生医疗服务绩效总览</b>
                    <a href="###" id="daochu1"  class="daochu">导出</a>
                    <a href="###" id="daochuimg1" style="display: none;">导出</a>
                    <a href="###" id="daochuimg2" style="display: none;">导出</a>
                    <a href="###" id="daochuimg3" style="display: none;">导出</a>
                </div>
                <div class="zhibiao2" id="data0" style="height:600px;width: 40%;float:left"></div>
                <div class="zhibiao2" id="data1" style="height:300px;width: 60%;float:left"></div>
                <div class="zhibiao2" id="data2" style="height:300px;width: 60%;float:left"></div>
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
    <script type="text/javascript" src="${ctx }/static/js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/export.js"></script>
    <script>
        $(function () {
            hubeiCon.hospitalCon('sj-bz');
        });
        //获取屏幕的高
        var H= 0;
        var biIds =['2578f351-4e31-4968-8665-e00c7c9e19ea','c7424184-3ceb-44d9-bd98-2cc5252f3c6e','3087132c-1143-4b7f-adbf-3555ab05b39c'];//报表id
        var biKeys =[];//报表返回softkey
        var flag = true;
        var kstj = '@novalue|';
        var mdctj = '@novalue|';
        $(function () {
            var date = new Date;
            var year=date.getFullYear();
            $("#rq").val(year);
            if("${hospital}"){
                $("#hospital").text("${hospital}");
                $("#kemu").text("${kemu}"=="@novalue"?"全部":"${kemu}");
                $("#rqkj").val("${rqkj}");
                $("#rq").val("${year}");
                biIds[0] = "1b359425-ee43-43c1-b5c3-779e9b26af76";

            }else{
                $("#top-demand").show();
                $("#menu").show();
                H=$('#top-demand').height();
                $('#item1').css('padding-top',H+'px');
            }
            if("${kemu}"){
                $.ajax({
                    type:"POST",
                    url:"/HBI/loadBiKsy?biIds="+biIds,
                    dataType: "json",
                    success:function(data){
                        biKeys =data;
                        var cxtj0 = "${kemu}"+"|";
                        var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
                            '&biyccs=&id=' +biKeys[2].id+'&softkey='+biKeys[2].softkey +
                            '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=';
                        $.ajax({
                            type: "GET",
                            url: url0,
                            dataType: "jsonp",
                            success: function (data) {
                                data = jsonpDataInit(data);  //jsonp数据格式化
                                kstj=data.rows.row[0].cell[0]+"|";
                                search();
                            }
                        });
                    }
                });
            }else {
                $.ajax({
                    type:"POST",
                    url:"/HBI/loadBiKsy?biIds="+biIds,
                    dataType: "json",
                    success:function(data){
                        var rq = $("#rq").val();
                        var sTime = "",eTime = "";
                        sTime = rq + "-01-01";
                        eTime = rq + "-12-31";
                        biKeys =data;
                        search();
                    }
                });
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
            $('.top-btn').click(function () {
                 kstj = '@novalue|';
                 mdctj = '@novalue|';
                flag=false;
                search();
            })
        })
        function search() {
            $("#loading").show();
            var loads=2;
            //var km = $("#km").val();
            if("${userType}"!='机构'){
                $('#daochu').show();
                $('#daochu1').show();
            }
            if(hubeiCon.ksTreeData.length>0){
                kstj = '';
                for(var i=0;i<hubeiCon.ksTreeData.length;i++){
                    kstj+=hubeiCon.ksTreeData[i].code;
                    if(i<hubeiCon.ksTreeData.length-1){
                        kstj+=",";
                    }
                }
                kstj += '|';
            }
            if(hubeiCon.mdcTreeData.length>0){
                mdctj = "";
                for(var i=0;i<hubeiCon.mdcTreeData.length;i++){
                    if(hubeiCon.mdcTreeData[i].DRGsdm){
                        mdctj+=hubeiCon.mdcTreeData[i].DRGsdm;
                    }else{
                        mdctj+=hubeiCon.mdcTreeData[i].MDCdm;
                    }
                    if(i<hubeiCon.mdcTreeData.length-1){
                        mdctj+=",";
                    }
                }
                mdctj += '|';
            }
            //费用增幅与机构动因 （费用动因分析）
            var cxsj = hubeiCon.getTimeStr();
            var cxtj0 = cxsj+ "|";
            if("${hospital}"){
                cxtj0 = "${hospital}|"+cxtj0;
            }
            var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
                '&biyccs=&id=' +biKeys[0].id+'&softkey='+biKeys[0].softkey +
                '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=0';
            $.ajax({
                type:"GET",
                url:url0,
                dataType: "jsonp",
                success:function(data){
                    data = jsonpDataInit(data);  //jsonp数据格式化
                    if(!"${hospital}"){
                        $("#hospital").text(data.rows.row[0].cell[1]);
                        $("#kemu").text($("#km option:selected").text());
                    }
                    var cxtj0 = cxsj+"|@novalue|@novalue|@novalue|"+kstj+mdctj;
                    var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
                        '&biyccs=&id=' +biKeys[1].id+'&softkey='+biKeys[1].softkey +
                        '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=0';
                    $.ajax({
                        type:"GET",
                        url:url0,
                        dataType: "jsonp",
                        success:function(data0){
                            loads=loads-1;
                            test(loads);
                            data0 = jsonpDataInit(data0);  //jsonp数据格式化
                            setData0(data0);

                        }
                    });
                    var cxtj1 = cxsj+"|@novalue|@novalue|"+data.rows.row[0].cell[0]+"|"+kstj+mdctj;
                    var url1 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
                        '&biyccs=&id=' +biKeys[1].id+'&softkey='+biKeys[1].softkey +
                        '&cxtj='+escape(cxtj1)+'&topdata=&timew=&weiplan=1';
                    $.ajax({
                        type:"GET",
                        url:url1,
                        dataType: "jsonp",
                        success:function(data0){
                            loads=loads-1;
                            test(loads);
                            data0 = jsonpDataInit(data0);  //jsonp数据格式化
                            setData1(data0);
                            setData2(data0);
                            setData3(data0);

                        }
                    });



                }
            });
        }

        function setData0(data) {
            var hos = $("#hospital").text();
            var kemu = $("#kemu").text();
            data.title.column = data.title.column.replace("医院名称","");
            if(data.rows.row[0]){
                data.rows.row[0].cell[0] = "全省"+kemu+"整体情况";
            }
            var dataIndex = [0,3,4,1,2,7,8,11,12,13];
            for(var i=1;i<data.rows.row.length;){
                if(data.rows.row[1].cell[0]!=$("#hospital").text()){
                    data.rows.row.splice(1,1);
                }else{
                    data.rows.row[1].cell[0] = hos+"   "+kemu;
                    data.rows.row.splice(2,data.rows.row.length-1);
                    break;
                }
            }
            var tableData = initBootstrapTableData(data,dataIndex);//jsop数据格式化为layuiTable数据格式
            var $table = $('#table1');
            if(flag==true) {
                $("#thead1").empty();
                $("#thead1").append(tableData.tr);
                $table.attr('data-pagination', 'true');
                $table.attr('data-toggle', 'table');
                $table.attr('data-page-size', '6');
                $table.attr('data-height', "85");
                $table.attr('data-page-list', [6, 'all']);
                $table.bootstrapTable({data: tableData.data});
            }else {
                $table.attr('data-toggle','table');
                $table.bootstrapTable('load', tableData.data);
            }
            if(dataIndex.length>5){
                $('#table1 th:first ').css({'width':'20%'});
            }
            tableData.data.length<=6&&$('.fixed-table-pagination').css('border-top','none');
        }

        function setData1(data) {
            var attr =[];
            var datay=data.rows.row;
            for(var i =1;i<datay.length;i++){
                var str=[];
                str.push(datay[i].cell[2]);
                str.push(datay[i].cell[21]);
                str.push(datay[i].cell[0]);
                str.push(30);
                attr.push(str);
            }
            var myChart = echarts.init(document.getElementById('data0'));
            var option=dlchart.CreateCatterChart("",{x:"DRGs组数",y:"CMI值"},
                [{name:"医生医疗服务能力示意图",data:attr}],{grid: {
                    left: '3%',
                    right: '10%',
                    bottom: '3%',
                    containLabel: true
                }},{index:0,option:{
                    markLine : {
                        itemStyle:{
                            normal:{
                                lineStyle:{
                                    type: 'dashed'
                                }
                            }
                        },
                    },
                    itemStyle: {
                        normal: {
                            shadowBlur: 10,
                            shadowColor: 'rgba(120, 36, 50, 0.5)',
                            shadowOffsetY: 5,
                            color: new echarts.graphic.RadialGradient(0.4, 0.3, 1, [{
                                offset: 0,
                                color: 'rgb(147, 183, 228)'
                            }, {
                                offset: 1,
                                color: 'rgb(147, 183, 228)'
                            }])
                        }
                    },
                    label: {
                        emphasis: {
                            show: true,
                            formatter: function (param) {
                                return param.data[2];
                            },
                            position: 'top'
                        }
                    }
                }},3);
            myChart.setOption(option);
        }
        function setData2(data) {
            var attr =[];
            var datay=data.rows.row;
            for(var i =1;i<datay.length;i++){
                var str=[];
                str.push(datay[i].cell[10]);
                str.push(datay[i].cell[11]);
                str.push(datay[i].cell[0]);
                str.push(30);
                attr.push(str);
            }
            var myChart = echarts.init(document.getElementById('data1'));
            var option=dlchart.CreateCatterChart("",{x:"每权重消耗费用（元）",y:"每权重消耗住院床（日）"},
                [{name:"医生医疗服务效果示意图",data:attr}],{grid: {
                    left: '3%',
                    right: '10%',
                    bottom: '3%',
                    containLabel: true
                },xAxis: {
                    nameLocation:'middle',
                    nameGap:17,
                },yAxis:{
                    nameLocation:'middle',
                    nameGap:20,
                }},{index:0,option:{
                    markLine : {
                        itemStyle:{
                            normal:{
                                lineStyle:{
                                    type: 'dashed'
                                }
                            }
                        },
                    },
                    itemStyle: {
                        normal: {
                            shadowBlur: 10,
                            shadowColor: 'rgba(120, 36, 50, 0.5)',
                            shadowOffsetY: 5,
                            color: new echarts.graphic.RadialGradient(0.4, 0.3, 1, [{
                                offset: 0,
                                color: 'rgb(147, 183, 228)'
                            }, {
                                offset: 1,
                                color: 'rgb(147, 183, 228)'
                            }])
                        }
                    },
                label: {
                    emphasis: {
                        show: true,
                            formatter: function (param) {
                            return param.data[2];
                        },
                        position: 'top'
                    }
                }
                }},3)
            myChart.setOption(option);
        }
        function setData3(data) {
            var tit = data.title.column.split(",");
            var datay=[];
            var datax =[];
            for(var i =1;i<data.rows.row.length;i++){
                datay.push(data.rows.row[i].cell[13]);
                datax.push(data.rows.row[i].cell[0]);
            }
            var myChart = echarts.init(document.getElementById('data2'));
            var option = dlchart.CreateLineChart("",datax,[{name:tit[13],data:datay}],{
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                }
            },{},null);
            myChart.setOption(option);
        }
        var n=0;
        $('#daochu').click(function () {
            var options = $("#table1").bootstrapTable('getOptions');
            var excleJson = {excel:JSON.stringify(
                [
                    {
                        table:JSON.stringify(
                            [
                                {
                                    title: JSON.stringify(options["columns"]),data:JSON.stringify(options["data"])
                                }
                            ]
                        )
                    }
                ]
            )};
            ExcelDown(excleJson);
        });
        $('#daochu1').click(function () {
            var hos=$('#hospital').text();
            var a = getBase64Image('data0');
            var b = getBase64Image('data1');
            var c = getBase64Image('data2');
            var excleJson = {excel:JSON.stringify(
                [
                    {
                        name:hos+'医生医疗服务绩效总览',
                        img: JSON.stringify([a,b,c])
                    }
                ]
            )};

            ExcelDown(excleJson);
        });
    </script>
</body>
</html>
