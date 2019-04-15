<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/11/01
  Time: 11:38
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <meta charset="utf-8"/>
    <meta name="format-detection" content="telephone=no,email=no,address=no">
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <link rel="stylesheet" href="${ctx }/static/js/layui/css/layui.css"/>
    <link rel="stylesheet" href="${ctx }/static/css/base.css"/>
    <link rel="stylesheet" href="${ctx }/static/css/my-stlye.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/login-1.css">
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/tanchuan_hubei.css">
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/assets/examples.css"/>
    <link rel="stylesheet" href="${ctx }/static/js/plugins/layer/skin/layer.css"/>
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/bootstrap-table.css" />
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/my97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/plugins/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/layui/layui.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/hubeiCon.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/common.js"></script>
    <title></title>
    <style>
        body {
            overflow-y: auto;
        }

        .table th {
            font-weight: inherit;
            background: #F3F3F3;
            /*border:none!important;*/
            text-align: center !important;
        }

        .bootstrap-table .table:not(.table-condensed) > tbody > tr > td:first-child {
            padding-right: 12px;
        }

        .bootstrap-table .table:not(.table-condensed) > tbody > tr > td {
            padding-right: 12px;
            text-align: center;
        }

        .fixed-table-container {
            border: none;
        }

        .pagination {
            margin-right: 4px;
        }

        .pull-right {
            margin-top: 6px !important;
            margin-bottom: 0px !important;
        }
    </style>
</head>
<body>
<div id="loading" class="loader">
    <img class="Rotation" src="${ctx}/static/img/load.png" width="32" height="32"/>
</div>
<div id="menu" hidden style="position:fixed;top: 10px;right: 20px;z-index:20000;font-size:12px;">
</div>
<%--<div class="top-demand" hidden id="top-demand" style="top: 0;">
    <ul>
        <li>
            <label>日期：</label>
            <select id="rqkj" disabled style="width: 60px;height: 24px;border-radius:2px;border: 1px solid #ddd">
                <option value="m">月</option>
                <option value="j">季</option>
                <option value="y">年</option>
            </select>
            &lt;%&ndash;<input type="text" />&ndash;%&gt;
            <input type="text" class="Wdate " id="rq"
                   style="width: 80px;height: 24px;vertical-align: middle;margin-bottom: 3px;border-radius:2px;border: 1px solid #ddd"
                   onfocus="WdatePicker({el:'rq',startDate:'%y',dateFmt:'yyyy-MM',alwaysUseStartDate:true,maxDate:'%y'})">


        </li>
        <li>
            <div class="center-back-cs">
                <input hidden style="width: 150px; height: 24px;border-radius:2px;cursor: pointer" class="sj-pt"
                       id="sj-pt" readonly="readonly" value="" type="text" placeholder="平台机构选择"/>
                <input hidden style="width: 150px; height: 24px;border-radius:2px;cursor: pointer" class="sj-jb"
                       id="sj-jb" readonly="readonly" value="" type="text" placeholder="平台机构选择"/>
            </div>
        </li>

    </ul>
    <div class="top-btn">查询</div>
</div>--%>
<div class="main">
    <div id="item1" class="man-c-2" style="padding-top: 0px;">
        <div class="bg-f" style="overflow: hidden;">
            <div class="zhibiao-top back-zb">
                <b class="back-b zbmca">排除病案分析</b>
            </div>
            <div class="zhibiao2" id="data1" >
                <div  class="biaoge-yqst table-responsive" style="margin:15px;">
                    <table class="table" id="table1" style="font-size: 12px;">
                        <thead id="thead1">
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div id="item2" class="man-c-2" >
        <div class="bg-f" style="overflow: hidden;min-height: 400px;">
            <div class="zhibiao-top back-zb">
                <b class="back-b zbmca">病案明细</b>
            </div>
            <div class="zhibiao2" id="data2" >
                <div  class="biaoge-yqst table-responsive" style="margin:15px;">
                    <table class="table" id="table2" style="font-size: 12px;">
                        <thead id="thead2">
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/bootstrap.min.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/bootstrap-table.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/extensions/toolbar/bootstrap-table-toolbar.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/ga.js" ></script>

<script type="text/javascript" src="${ctx}/static/js/echarts.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/macarons.js"></script>
<script type="text/javascript" src="${ctx}/static/js/dlchart.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jsonpData.js"></script>
<script type="text/javascript" src="${ctx }/static/js/dlcommon.js"></script>

<script>
    $(function () {
        hubeiCon.initCon('sj-pt');
    })
    $('body').delegate('.page-list button', 'click', function () {
        $(this).next().find("li").each(function () {
            if ($(this).hasClass("active")) {
                $(this).removeClass("active");
            } else {
                $(this).addClass("active");
                $(this).children().trigger("click");
            }
        })
    });
    $("body").delegate("tbody a", "click", function () {
        var height = findDimensions_height();
        var width = findDimensions_width();
        var param = $(this).attr("data-index");
        if(param=='bah'){
            var bah = $(this).text();
            layeropen(width*0.95,height*0.9,"","/hubei/V_basyIndex/toBasyIndex?bah="+escape(bah));
        }else{
            getData(param);
        }
    })

    //菜单滑动
    $(document).ready(function () {
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
                scrollTop: $($.attr(this, 'href')).offset().top - 100
            }, 500);
            return false;
        });
    });

    //获取屏幕的高
    var H = 0;
    var loads = 0;
    var biIds = ['a605cf00-d485-4683-a3f0-9085c7c14606','9d8fec1f-cf2a-4631-b597-2febe450a506'];//报表id
    var biKeys = [];//报表返回softkey
    var rq="${dateTime}";
    $(document).ready(function () {
        /*var date = new Date;
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        if(month<10){
            month = "0"+month;
        }
        if("${bivar}"){
            $("#rq").val("${dateTime}");

        }else {
            $("#rq").val(year+"-"+month);
            $("#top-demand").show();
            $("#menu").show();
            H=$('#top-demand').height();
            $('#item1').css('padding-top',H+'px');
        }*/
        $("#top-demand").show();
        $("#menu").show();
        H=$('#top-demand').height();
        $('#item1').css('padding-top',H+'px');

        $.ajax({
            type: "POST",
            url: "/HBI/loadBiKsy?biIds=" + biIds,
            dataType: "json",
            success: function (data) {
                biKeys = data;
                search()
            }
        });


    })
    var flag = true;
    $('.top-btn').click(function () {
        flag = false;
        search();
    })

    var yydm="${yydm}";
    function search() {
        $("#loading").show();
        //var rq = $("#rq").val();
        var year = rq.substring(0,4);
        var month = rq.substring(5,7);
        var new_month = month++;
        if(month>12) {
            new_month -=12;
            year++;
        }
        var new_date  = new Date(year,new_month,1);                //取当年当月中的第一天
        var sTime = rq+"-01";
        var eTime = rq+"-"+(new Date(new_date .getTime()-1000*60*60*24)).getDate();
        var bivar = "";
        if("${bivar}"){
            bivar = "${bivar}";
        }else{
            $(".center-back-cs").find("input").each(function () {
                if ($(this).css("display") != 'none') {
                    bivar = $(this).val();
                    return false;
                }
            })

        }
        bivar = $('#sj-pt').val();
        if(bivar == "全国"){
            bivar = "@novalue|@novalue|@novalue|";
        }else {

            bivar +="|@novalue|@novalue|";

        }
        if("${userType}"=='省级'||"${userType}"=='全国'){
            yydm=$("#dept option:checked").text();
            if(!yydm||yydm=='全部'){
                yydm = '@novalue';
                hubeiCon.loadyydate();
            }
        }else{
            $('#dept').hide();
            yydm=parent.hosName;
        }
        //报表1
        var cxtj =  sTime + ";" + eTime + "|"+yydm+ "|";
        loads++;
        var url = '${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar=' + escape(escape(bivar)) +
            '&biyccs=&id=' + biKeys[0].id + '&softkey=' + biKeys[0].softkey +
            '&cxtj=' + escape(cxtj) + '&topdata=&timew=&weiplan=';
        $.ajax({
            type: "GET",
            url: url,
            dataType: "jsonp",
            success: function (data) {
                loads--;
                test(loads);
                data = jsonpDataInit(data);
                setData0(data);
                getData();
            }
        });
    }

    function getData(param) {debugger
        if(param){
            $("#loading").show();
        }
        param = param?param:''
        var yy;
        switch(param){
            case '1':
                yy='1|@novalue|@novalue|@novalue|@novalue|@novalue|';
                break;
            case '2':
                yy='@novalue|1|@novalue|@novalue|@novalue|@novalue|';
                break;
            case '3':
                yy='@novalue|@novalue|1|@novalue|@novalue|@novalue|';
                break;
            case '4':
                yy='@novalue|@novalue|@novalue|1|@novalue|@novalue|';
                break;
            case '6':
                yy='@novalue|@novalue|@novalue|@novalue|1|@novalue|';
                break;
            case '7':
                yy='@novalue|@novalue|@novalue|@novalue|@novalue|1|';
                break;
            default:
                yy='@novalue|@novalue|@novalue|@novalue|@novalue|@novalue|';
                break;
        }
        var year = rq.substring(0,4);
        var month = rq.substring(5,7);
        var new_month = month++;
        if(month>12) {
            new_month -=12;
            year++;
        }
        var new_date  = new Date(year,new_month,1);                //取当年当月中的第一天
        var sTime = rq+"-01";
        var eTime = rq+"-"+(new Date(new_date .getTime()-1000*60*60*24)).getDate();
        var bivar = "";
        if("${bivar}"){
            bivar = "${bivar}";
        }else{
            /*$(".center-back-cs").find("input").each(function () {
             if ($(this).css("display") != 'none') {
             bivar = $(this).val();
             return false;
             }
             })*/
            bivar="@novalue|@novalue|@novalue|";
        }
        if(bivar == "全国"){
            bivar = "@novalue|@novalue|@novalue|";
        }else {

            bivar +="|@novalue|@novalue|";

        }
        var cxtj =  sTime + ";" + eTime + "|"+yydm+ "|"+yy;
        loads++;
        var url = '${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar=' + escape(escape(bivar+"|")) +
            '&biyccs=&id=' + biKeys[1].id + '&softkey=' + biKeys[1].softkey +
            '&cxtj=' + escape(cxtj) + '&topdata=&timew=&weiplan=';
        $.ajax({
            type: "GET",
            url: url,
            dataType: "jsonp",
            success: function (data) {
                loads--;
                test(loads);
                data = jsonpDataInit(data);
                setData1(data);
            }
        });
    }

    function setData0(data) {
        var dataIndex = [0,1,2,3,4,5,6];
        var tableData = initBootstrapTableData(data, dataIndex);//jsop数据格式化为layuiTable数据格式
        var $table = $('#table1');
        for (var i = 0; i < tableData.data.length; i++) {
            tableData.data[i].td0 = "<a data-index = '1'>" + tableData.data[i].td0 + "</a>";
            tableData.data[i].td1 = "<a data-index = '2'>" + tableData.data[i].td1 + "</a>";
            tableData.data[i].td2 = "<a data-index = '3'>" + tableData.data[i].td2 + "</a>";
            tableData.data[i].td3 = "<a data-index = '4'>" + tableData.data[i].td3 + "</a>";
            tableData.data[i].td4 = tableData.data[i].td4;
            tableData.data[i].td5 = "<a data-index = '6'>" + tableData.data[i].td5 + "</a>";
            tableData.data[i].td6 = "<a data-index = '7'>" + tableData.data[i].td6 + "</a>";
        }
        if (flag == true) {
            $("#thead1").empty();
            $("#thead1").append(tableData.tr);
            $table.attr('data-pagination', 'true');
            $table.attr('data-toggle', 'table');
            $table.attr('data-page-size', '15');
//            $table.attr('data-height', "316");
            $table.attr('data-page-list', [10, 'all']);
            $table.bootstrapTable({data: tableData.data});
        } else {
            $table.attr('data-toggle', 'table');
            $table.bootstrapTable('load', tableData.data);
        }
        if (dataIndex.length > 5) {
            $('#table1 th:first ').css({'width': '20%'});
        }
        tableData.data.length <= 10 && $('.fixed-table-pagination').css('border-top', 'none');
    }

    function setData1(data) {

        var dataIndex = [];
        var tableData = initBootstrapTableData(data,dataIndex);//jsop数据格式化为layuiTable数据格式
        var $table = $('#table2');
        for (var i = 0; i < tableData.data.length; i++) {
            tableData.data[i].td3 = "<a data-index = 'bah'>" + tableData.data[i].td3 + "</a>";
        }
        if(flag==true) {
            $("#thead2").empty();
            $("#thead2").append(tableData.tr);
            $table.attr('data-pagination', 'true');
            $table.attr('data-toggle', 'table');
            $table.attr('data-page-size', '15');
            $table.attr('data-height', "440");
            $table.attr('data-page-list', [15, 'all']);
            $table.bootstrapTable({data: tableData.data});
            flag = false;
        }else {
            $table.attr('data-toggle','table');
            $table.bootstrapTable('load', tableData.data);
        }
        if(dataIndex.length>5){
            $('#table1 th:first ').css({'width':'20%'});
        }
        tableData.data.length<=15&&$('.fixed-table-pagination').css('border-top','none');
    }
</script>
</body>
</html>