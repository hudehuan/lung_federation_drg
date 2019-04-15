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
    <link rel="stylesheet" type="text/css" href="${ctx }/static/js/jquery-easyui-1.5/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/tanchuan_hubei.css">
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/my97DatePicker/WdatePicker.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/plugins/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/layui/layui.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/hubeiCon.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/common.js"></script>
    <title></title>
    <style>
        body{overflow-y:auto;}
        .yinying-data{
            overflow: hidden;
            text-shadow: 1px 1px rgb(217, 169, 36), 2px 2px rgb(217, 169, 36), 3px 3px rgb(217, 169, 36), 4px 4px rgb(217, 169, 36), 5px 5px rgb(217, 169, 36), 6px 6px rgb(217, 169, 36), 7px 7px rgb(217, 169, 36), 8px 8px rgb(217, 169, 36), 9px 9px rgb(217, 169, 36), 10px 10px rgb(218, 170, 39),
            11px 11px rgb(217, 169, 36), 12px 12px rgb(217, 169, 36), 13px 13px rgb(217, 169, 36), 14px 14px rgb(217, 169, 36), 15px 15px rgb(220, 173, 41), 16px 16px rgb(217, 169, 36), 17px 17px rgb(217, 169, 36), 18px 18px rgb(217, 169, 36), 19px 19px rgb(217, 169, 36), 20px 20px rgb(217, 169, 36),
            21px 21px rgb(217, 169, 36), 22px 22px rgb(217, 169, 36), 23px 23px rgb(217, 169, 36), 24px 24px rgb(217, 169, 36),
            25px 25px rgb(217, 169, 36), 26px 26px rgb(217, 169, 36), 27px 27px rgb(217, 169, 36), 28px 28px rgb(217, 169, 36),
            29px 29px rgb(217, 169, 36), 30px 30px rgb(217, 169, 36), 31px 31px rgb(217, 169, 36), 32px 32px rgb(217, 169, 36),
            33px 33px rgb(217, 169, 36), 34px 34px rgb(217, 169, 36), 35px 35px rgb(217, 169, 36), 36px 36px rgb(217, 169, 36),
            37px 37px rgb(217, 169, 36), 38px 38px rgb(217, 169, 36), 39px 39px rgb(217, 169, 36), 40px 40px rgb(217, 169, 36),
            41px 41px rgb(217, 169, 36), 42px 42px rgb(217, 169, 36), 43px 43px rgb(217, 169, 36), 44px 44px rgb(217, 169, 36),
            45px 45px rgb(217, 169, 36), 46px 46px rgb(217, 169, 36), 47px 47px rgb(217, 169, 36), 48px 48px rgb(217, 169, 36),
            49px 49px rgb(217, 169, 36), 50px 50px rgb(217, 169, 36), 51px 51px rgb(217, 169, 36), 52px 52px rgb(217, 169, 36),
            53px 53px rgb(217, 169, 36), 54px 54px rgb(217, 169, 36), 55px 55px rgb(217, 169, 36), 56px 56px rgb(217, 169, 36),
            57px 57px rgb(217, 169, 36), 58px 58px rgb(217, 169, 36), 59px 59px rgb(217, 169, 36), 60px 60px rgb(217, 169, 36),
            61px 61px rgb(217, 169, 36), 62px 62px rgb(217, 169, 36), 63px 63px rgb(217, 169, 36), 64px 64px rgb(217, 169, 36),
            65px 65px rgb(217, 169, 36), 66px 66px rgb(217, 169, 36), 67px 67px rgb(217, 169, 36), 68px 68px rgb(217, 169, 36),
            69px 69px rgb(217, 169, 36), 70px 70px rgb(217, 169, 36), 71px 71px rgb(217, 169, 36), 72px 72px rgb(217, 169, 36),
            73px 73px rgb(217, 169, 36), 74px 74px rgb(217, 169, 36), 75px 75px rgb(217, 169, 36), 76px 76px rgb(217, 169, 36),
            77px 77px rgb(217, 169, 36), 78px 78px rgb(217, 169, 36), 79px 79px rgb(217, 169, 36), 80px 80px rgb(217, 169, 36),
            81px 81px rgb(217, 169, 36), 82px 82px rgb(217, 169, 36), 83px 83px rgb(217, 169, 36), 84px 84px rgb(217, 169, 36),
            85px 85px rgb(217, 169, 36), 86px 86px rgb(217, 169, 36), 87px 87px rgb(217, 169, 36), 88px 88px rgb(217, 169, 36),
            89px 89px rgb(217, 169, 36), 90px 90px rgb(217, 169, 36), 91px 91px rgb(217, 169, 36), 92px 92px rgb(217, 169, 36),
            93px 93px rgb(217, 169, 36), 94px 94px rgb(217, 169, 36), 95px 95px rgb(217, 169, 36), 96px 96px rgb(217, 169, 36),
            97px 97px rgb(217, 169, 36), 98px 98px rgb(217, 169, 36), 99px 99px rgb(217, 169, 36), 100px 100px rgb(217, 169, 36),
            101px 101px rgb(217, 169, 36), 102px 102px rgb(217, 169, 36), 103px 103px rgb(217, 169, 36), 104px 104px rgb(217, 169, 36),
            105px 105px rgb(217, 169, 36), 106px 106px rgb(217, 169, 36), 107px 107px rgb(217, 169, 36), 108px 108px rgb(217, 169, 36),
            109px 109px rgb(217, 169, 36), 110px 110px rgb(217, 169, 36), 111px 111px rgb(217, 169, 36), 112px 112px rgb(217, 169, 36),
            113px 113px rgb(217, 169, 36), 114px 114px rgb(217, 169, 36), 115px 115px rgb(217, 169, 36), 116px 116px rgb(217, 169, 36),
            117px 117px rgb(217, 169, 36), 118px 118px rgb(217, 169, 36), 119px 119px rgb(217, 169, 36), 120px 120px rgb(217, 169, 36),
            121px 121px rgb(217, 169, 36), 122px 122px rgb(217, 169, 36), 123px 123px rgb(217, 169, 36), 124px 124px rgb(217, 169, 36);
        }
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
    <%--<div class="xian" style="height: 5px;"></div>--%>
    <%--<ul>--%>
    <%--<li><a href="#item1" class="current" ><span></span>- -综合绩效排名</a></li>--%>
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

        <%--<input type="text" />--%>
            <input type="text" class="Wdate " id="rq" style="width: 80px;height: 24px;vertical-align: middle;margin-bottom: 3px;border-radius:2px;border: 1px solid #ddd"
                   onfocus="WdatePicker({el:'rq',startDate:'%y',dateFmt:'yyyy',alwaysUseStartDate:true,maxDate:'%y'})">

        </li>
        <%--<li>--%>
            <%--<div class="center-back-cs">--%>
                <%--<input  style="width: 150px; height: 24px;border-radius:2px;cursor: pointer"--%>
                        <%--class="sj-ks" id="sj-ks" readonly="readonly" value="" type="text" placeholder="科室选择" />--%>
                <%--<input  style="width: 150px; height: 24px;border-radius:2px;cursor: pointer"--%>
                        <%--class="sj-bz" id="sj-bz"  readonly="readonly" value="" type="text" placeholder="DRGs病组选择" />--%>
            <%--</div>--%>
        <%--</li>--%>

    </ul>
    <div class="top-btn">查询</div>
</div>

<div class="main">

    <div id="item1" class="man-c-2" style="padding-top: 0px; height:590px;">
        <div class="bg-f" style="overflow: hidden;height:auto">
        <div class="zhibiao-top back-zb">
            <b class="back-b">综合绩效排名</b>
            <a href="###" id="daochu"  class="daochu">导出</a>
        </div>
        <div class="w-h">
            <div style="width:100%;">
                <div class="col-xs-4 " style="padding:12px 0px 0px 20px;">
                    <div style="padding-left: 10px; color: #00a0e9">
                        <span style="font-size: 20px;" id="hospital">
                        </span><span>&nbsp;&nbsp;&nbsp;</span>
                    <%--</div>--%>
                    <%--<div style="padding-left: 10px;color: #00a0e9">--%>
                        <span style="font-size: 20px;" id="dateVal">
                        </span>
                    </div>
                </div>
                <div class="col-xs-12 zhibiao2" >
                    <div  class="biaoge-yqst table-responsive" style="margin: 5px 0 0 0px;height: 70px;">
                        <table class="table" id="table4" style="font-size: 12px;">
                            <thead id="thead4">
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
            <%--<div class="col-xs-4 zhibiao1">--%>

                <%--<div class="zhibiao1" >--%>
                    <%--<div style="padding-left: 10px;">--%>
                        <%--<span style="font-size: 20px;">--%>
                            <%--全省医疗机构服务综合绩效排名--%>
                        <%--</span>--%>
                    <%--</div>--%>
                <%--</div>--%>

                <%--<div class="zhibiao1 yinying-data" style="width: 300px; border-radius:50%; line-height:300px;--%>
                   <%--text-align:center; background-color: #ffc72d;font-size: 180px; color: #ffffff;margin:0 auto;height: 300px" id="paim">--%>
                <%--</div>--%>
            <%--</div>--%>
            <div class="col-xs-12 zhibiao2" >
                <div  class="biaoge-yqst table-responsive" style="margin: 5px 0 0 0px;height: 115px;">
                    <%--<table id="table1" style="width: 100%"></table>--%>
                    <table class="table" id="table1" style="font-size: 12px;">
                        <thead id="thead1">
                        </thead>
                    </table>
                </div>
                <div  class="biaoge-yqst table-responsive" style="margin: 15px 0 0 0px;height: 115px;">
                    <%--<table id="table2" style="width: 100%"></table>--%>
                    <table class="table" id="table2" style="font-size: 12px;">
                        <thead id="thead2">
                        </thead>
                    </table>
                </div>
                <div  class="biaoge-yqst table-responsive" style="margin: 15px 0 0 0px;height: 115px;">
                    <%--<table id="table3" style="width: 100%"></table>--%>
                    <table class="table" id="table3" style="font-size: 12px;">
                        <thead id="thead3">
                        </thead>
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
<script type="text/javascript" src="${ctx }/static/js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctx }/static/js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${ctx }/static/js/export.js"></script>
<script>
    $(function () {
        hubeiCon.hospitalCon('sj-bz');
    });
    //获取屏幕的高
    var H= 0;
    var biIds =['2578f351-4e31-4968-8665-e00c7c9e19ea','fe36543d-2236-432a-896b-30b16fdd8f7c','5bc92017-9ece-4693-87f0-a7d494a5d7f0'];//报表id
    var biKeys =[];//报表返回softkey
    var flag = true;
    var kstj = '@novalue|';
    var mdctj = '@novalue|';
    $(function () {
        var date = new Date;
        var year=date.getFullYear();
        $("#rq").val(year);
        if("${kstj}"){
            kstj="${kstj}";
        }
        if("${userType}"!='机构'){
            $('#daochu').show();
        }
        if("${mdctj}"){
            mdctj="${mdctj}";
        }
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
        if("${userType}"!='机构'){
            $("#paim").text(0);
        }else{
            $("#paim").css("font-size","80px")
            $("#paim").text("待定");
        }

        $('.top-btn').click(function () {
            flag=false;
            search();
        })
    })

    function search() {
        $("#loading").show();
        var loads=1;
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
            '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=';
        $.ajax({
            type:"GET",
            url:url0,
            dataType: "jsonp",
            success:function(data){
                data = jsonpDataInit(data);
                loads++;
                var cxtj = cxsj+"|"+data.rows.row[0].cell[0]+"|@novalue|";
                var url ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
                    '&biyccs=&id=' +biKeys[2].id+'&softkey='+biKeys[2].softkey +
                    '&cxtj='+escape(cxtj)+'&topdata=&timew=&weiplan=';
                $.ajax({
                    type:"GET",
                    url:url,
                    dataType: "jsonp",
                    success:function(data3){
                        loads=loads-1;
                        test(loads);
                        data3 = jsonpDataInit(data3);  //jsonp数据格式化
                        setData4(data3);
                    }
                });



                var cxtj0 = cxsj+"|@novalue|"+data.rows.row[0].cell[6]+"|@novalue|";
                var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
                    '&biyccs=&id=' +biKeys[1].id+'&softkey='+biKeys[1].softkey +
                    '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=';
                $.ajax({
                    type:"GET",
                    url:url0,
                    dataType: "jsonp",
                    success:function(data0){
                        data0 = jsonpDataInit(data0);  //jsonp数据格式化
                        var cxtj0 = cxsj+"|"+data.rows.row[0].cell[2]+"|@novalue|@novalue|";
                        var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
                            '&biyccs=&id=' +biKeys[1].id+'&softkey='+biKeys[1].softkey +
                            '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=';
                        $.ajax({
                            type:"GET",
                            url:url0,
                            dataType: "jsonp",
                            success:function(data1){
                                data1 = jsonpDataInit(data1);  //jsonp数据格式化
                                var cxtj0 = cxsj+"|@novalue|@novalue|"+data.rows.row[0].cell[0];
                                var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
                                    '&biyccs=&id=' +biKeys[1].id+'&softkey='+biKeys[1].softkey +
                                    '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=';
                                $.ajax({
                                    type:"GET",
                                    url:url0,
                                    dataType: "jsonp",
                                    success:function(data2){
                                        loads=loads-1;
                                        test(loads);
                                        setData0(data,data2);
                                        data2 = jsonpDataInit(data2);  //jsonp数据格式化
                                        setData1(data0,data1,data2,data.rows.row[0].cell[6]);
                                        setData2(data0,data1,data2,data.rows.row[0].cell[6]);
                                        setData3(data0,data1,data2,data.rows.row[0].cell[6]);

                                    }
                                });
                            }
                        });
                    }
                });
            }
        });
    }

    function setData0(data,data0){
        $("#hospital").text(data.rows.row[0].cell[1]);
        var val = $("#rqkj").val();
        switch (val){
            case "y":
                $("#dateVal").text($("#rq").val()+"年");
                break;
            case "m":
                $("#dateVal").text($("#rq").val().replace("-","年")+"月");
                break;
        }
        if("${userType}"!='机构'){
            if(data0.rows.row){
                $("#paim").text(data0.rows.row.cell[9]);
            }
        }
        /*for(var i=1;i<data0.rows.row.length;i++){
         if(data0.rows.row[i].cell[0] == data.rows.row[0].cell[1]){
         $("#paim").text(data0.rows.row[i].cell[10]);
         return;
         }
         }*/

    }
var sj1 = [];
    function setData1(data,data0,data1,yyjb) {
        data1.title.column = data.title.column.replace("医院名称","指标");
        if(data.rows.row[0]){
            data.rows.row[0].cell[1] = "全省"+yyjb+"机构水平";
        }
        if(data0.rows.row[0]){
            data0.rows.row[0].cell[1] = "所在城市"+yyjb+"机构";
        }
        var dataIndex0 = [1,2,3,4,5];
        var dataIndex = [1,2,3,4,5,10,11];
        var tableData1 = initLayuiTableData(data,dataIndex0,140,110);//jsop数据格式化为layuiTable数据格式
        var tableData2 = initLayuiTableData(data0,dataIndex0,140,110);//jsop数据格式化为layuiTable数据格式
        var tableData3 = initLayuiTableData(data1,dataIndex,140,110);//jsop数据格式化为layuiTable数据格式
        if(tableData3.data.length<2){
            tableData3.data[1] = "";
        }
        var tableData =[tableData1.data[0]?tableData1.data[0]:"",
            tableData2.data[0]?tableData2.data[0]:"",
            tableData3.data[0]?tableData3.data[0]:""];
        var sjtitle = [];
        var sjdata1 = [];
        var sjdata2 = [];
        var sjdata3 = [];
        for(var i=0;i<dataIndex.length;i++){
            sjtitle.push(tableData3.cols[i]["title"]);
            sjdata3.push(tableData3.data[0]?tableData3.data[0]["td"+dataIndex[i]]:"");
        }
        for(var i=0;i<dataIndex0.length;i++){
            sjdata1.push(tableData1.data[0]?tableData1.data[0]["td"+dataIndex0[i]]:"");
            sjdata2.push(tableData2.data[0]?tableData2.data[0]["td"+dataIndex0[i]]:"");
        }
        sj1 = [sjtitle,sjdata1,sjdata2,sjdata3];
        layui.use('table', function() {
            var table = layui.table;
            //方法级渲染
            window.demoTable = table.render({
                elem: '#table1',
                data: tableData,
                height: 110,
                cols: [tableData3.cols],
                skin: 'row', //表格风格
                even: true,
                limit: 200, //每页默认显示的数量
            });
        });
    }
var sj2 =[];
    function setData2(data,data0,data1,yyjb) {

        data1.title.column = data.title.column.replace("医院名称","指标");
        if(data.rows.row[0]){
            data.rows.row[0].cell[1] = "全省"+yyjb+"机构水平";
        }
        if(data0.rows.row[0]){
            data0.rows.row[0].cell[1] = "所在城市"+yyjb+"机构";
        }
        var dataIndex0 = [1,16,21,17,22,19,23,20,24,18];
        var dataIndex = [1,16,21,17,22,19,23,20,24,18,12,13];
        var tableData1 = initLayuiTableData(data,dataIndex0,140);//jsop数据格式化为layuiTable数据格式
        var tableData2 = initLayuiTableData(data0,dataIndex0,140);//jsop数据格式化为layuiTable数据格式
        var tableData3 = initLayuiTableData(data1,dataIndex,140);//jsop数据格式化为layuiTable数据格式
        if(tableData3.data.length<2){
            tableData3.data[1] = "";
        }
        var tableData =[tableData1.data[0]?tableData1.data[0]:"",
            tableData2.data[0]?tableData2.data[0]:"",
            tableData3.data[0]?tableData3.data[0]:""];
        var sjtitle = [];
        var sjdata1 = [];
        var sjdata2 = [];
        var sjdata3 = [];
        for(var i=0;i<dataIndex.length;i++){
            sjtitle.push(tableData3.cols[i]["title"]);
            sjdata3.push(tableData3.data[0]?tableData3.data[0]["td"+dataIndex[i]]:"");
        }
        for(var i=0;i<dataIndex0.length;i++){
            sjdata1.push(tableData1.data[0]?tableData1.data[0]["td"+dataIndex0[i]]:"");
            sjdata2.push(tableData2.data[0]?tableData2.data[0]["td"+dataIndex0[i]]:"");
        }
        sj2 = [sjtitle,sjdata1,sjdata2,sjdata3];
        layui.use('table', function() {
            var table = layui.table;
            //方法级渲染
            window.demoTable = table.render({
                elem: '#table2',
                data: tableData,
                height: 110,
                cols: [tableData3.cols],
                skin: 'row', //表格风格
                even: true,
                limit: 200, //每页默认显示的数量
            });
        });
    }
var sj3 = [];
    function setData3(data,data0,data1,yyjb) {
        data1.title.column = data.title.column.replace("医院名称","指标");
        if(data.rows.row[0]){
            data.rows.row[0].cell[1] = "全省"+yyjb+"机构水平";
        }
        if(data0.rows.row[0]){
            data0.rows.row[0].cell[1] = "所在城市"+yyjb+"机构";
        }
        var dataIndex0 = [1,6,7,8,25,26];
        var dataIndex = [1,6,7,8,25,26,14,15];
        var tableData1 = initLayuiTableData(data,dataIndex0,140,120);//jsop数据格式化为layuiTable数据格式
        var tableData2 = initLayuiTableData(data0,dataIndex0,140,120);//jsop数据格式化为layuiTable数据格式
        var tableData3 = initLayuiTableData(data1,dataIndex,140,120);//jsop数据格式化为layuiTable数据格式
        if(tableData3.data.length<2){
            tableData3.data[1] = "";
        }
        var tableData =[tableData1.data[0]?tableData1.data[0]:"",
            tableData2.data[0]?tableData2.data[0]:"",
            tableData3.data[0]?tableData3.data[0]:""];
        var sjtitle = [];
        var sjdata1 = [];
        var sjdata2 = [];
        var sjdata3 = [];
        for(var i=0;i<dataIndex.length;i++){
            sjtitle.push(tableData3.cols[i]["title"]);
            sjdata3.push(tableData3.data[0]?tableData3.data[0]["td"+dataIndex[i]]:"");
        }
        for(var i=0;i<dataIndex0.length;i++){
            sjdata1.push(tableData1.data[0]?tableData1.data[0]["td"+dataIndex0[i]]:"");
            sjdata2.push(tableData2.data[0]?tableData2.data[0]["td"+dataIndex0[i]]:"");
        }
        sj3 = [sjtitle,sjdata1,sjdata2,sjdata3];
        layui.use('table', function() {
            var table = layui.table;
            //方法级渲染
            window.demoTable = table.render({
                elem: '#table3',
                data: tableData,
                height: 110,
                cols: [tableData3.cols],
                skin: 'row', //表格风格
                even: true,
                limit: 200, //每页默认显示的数量
            });
        });
    }
var sj4 = [];
    function setData4(data) {
        sj4 = [];
        var height = $("body").height();
        var dataIndex = [];
        var tableData = initLayuiTableData(data,dataIndex,140,120);//jsop数据格式化为layuiTable数据格式
        sj4.push(data.title.column.split(','));
        for(var i=0;i<data.rows.row.length;i++){
            sj4.push(data.rows.row[i].cell)
        }
        layui.use('table', function() {
            var table = layui.table;
            //方法级渲染
            window.demoTable = table.render({
                elem: '#table4',
                data: tableData.data,
                height: 66,
                cols: [tableData.cols],
                skin: 'row', //表格风格
                even: true,
//                page: true, //是否显示分页
//                limits: [6, tableData.data.length],
                limit: 200, //每页默认显示的数量
            });
        });
    }

    $('#daochu').click(function () {
        var hos=$('#hospital').text()+$('#dateVal').text();
        var mc=$('#paim').text();
        var excleJson = {excel:JSON.stringify(
            [
                {
                    name: hos+'全省医疗机构服务综合绩效排名'+mc,
                    table:JSON.stringify(
                        [
                            {
                                data:JSON.stringify(sj4)
                            },
                            {
                                data:JSON.stringify(sj1)
                            },
                            {
                               data:JSON.stringify(sj2)
                            },
                            {
                                data:JSON.stringify(sj3)
                            }
                        ]
                    )
                }
            ]
        )};
        ExcelDown(excleJson);


//        var tablehtml=$('#table1 thead').html()+$('#table1 tbody').html()+$('#table2 thead').html()+$('#table2 tbody').html()+$('#table3 thead').html()+$('#table3 tbody').html();
//        tableToExcel('table',tablehtml,hos+'全省医疗机构服务综合绩效排名'+mc);
    });
</script>
</body>
</html>
