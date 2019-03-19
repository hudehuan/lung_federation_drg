<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/08/10
  Time: 17:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <meta charset="utf-8"/>
    <meta name="format-detection" content="telephone=no,email=no,address=no">
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <link rel="stylesheet" href="${ctx }/static/css/base.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/login-1.css">
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/tanchuan_hubei.css">
    <%--<link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/css/bootstrap.css" />--%>
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/bootstrap-table.css"/>
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/assets/examples.css"/>
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${ctx }/static/css/my-stlye.css"/>
    <link rel="stylesheet" href="${ctx }/static/js/plugins/layer/skin/layer.css"/>
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/my97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/plugins/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/hubeiCon.js"></script>
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
            text-align: left;
        }

        .bootstrap-table .table:not(.table-condensed) > tbody > tr > td {
            padding-right: 12px;
            text-align: right;
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
<div id="menu" style="position:fixed;top: 10px;right: 20px;z-index:20000;font-size:12px;">
    <div class="xian" style="height: 25px;"></div>
    <ul>
        <li><a href="#item1" class="current"><span></span>- -医疗机构</a></li>
        <%--<li><a href="#item2"><span></span>- -三、四级手术占比</a></li>--%>
        <li><a href="#item3"><span></span>- -26组MDC</a></li>
        <%--<li><a href="#item4"><span></span>- -三、四级手术占比</a></li>--%>
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
            <input type="text" class="Wdate " id="rq"
                   style="width: 80px;height: 24px;vertical-align: middle;margin-bottom: 3px;border-radius:2px;border: 1px solid #ddd"
                   onfocus="WdatePicker({el:'rq',startDate:'%y',dateFmt:'yyyy',alwaysUseStartDate:true,maxDate:'%y'})">

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
</div>
<div class="main">
    <div id="item1" class="man-c-2" style="padding-top: 46px;">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">医疗机构</b>
                <ul id="qbzb">
                    <li><a class="active" id="a1">常规指标</a></li>
                    <li><a id="a2">DRGS常规</a></li>
                    <li><a>DRGS监测</a></li>
                </ul>
            </div>
            <div class="col-xs-6 zhibiao2" style="width: 100%;" id="tabx1">
                <%--<p class="tit-zhibiao">州市数据</p>--%>
                <div class="biaoge-yqst table-responsive" style="margin-top: 15px;">
                    <table id="table">
                        <thead>
                        <tr>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
            <div class="col-xs-6 zhibiao2" style="width: 100%;" id="tabx2">
                <%--<p class="tit-zhibiao">州市数据</p>--%>
                <div class="biaoge-yqst table-responsive" style="margin-top: 15px;">
                    <table id="table1">
                        <thead>
                        <tr>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
            <div class="col-xs-6 zhibiao2" style="width: 100%;" id="tabx5">
                <%--<p class="tit-zhibiao">州市数据</p>--%>
                <div class="biaoge-yqst table-responsive" style="margin-top: 15px;">
                    <table id="table2">
                        <thead>
                        <tr>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div id="item2" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <%--<div class="zhibiao-top back-zb">--%>
            <%--<b class="back-b zbmca">三丶四级手术占比</b>--%>
            <%--</div>--%>
            <div class="zhibiao2" id="chart-aqyqst" style="height:350px;"></div>
        </div>
    </div>

    <div id="item3" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">26组MDC</b>
                <ul id="qbzb2">
                    <li><a class="active" id="a4">常规指标</a></li>
                    <li><a id="a5">DRGS常规</a></li>
                    <li><a>DRGS监测</a></li>
                </ul>
            </div>
            <div class="col-xs-6 zhibiao2" style="width: 100%;" id="tabx3">
                <%--<p class="tit-zhibiao">州市数据</p>--%>
                <div class="biaoge-yqst table-responsive" style="margin-top: 15px;">
                    <table id="table3">
                        <thead>
                        <tr>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
            <div class="col-xs-6 zhibiao2" style="width: 100%;" id="tabx4">
                <%--<p class="tit-zhibiao">州市数据</p>--%>
                <div class="biaoge-yqst table-responsive" style="margin-top: 15px;">
                    <table id="table4">
                        <thead>
                        <tr>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
            <div class="col-xs-6 zhibiao2" style="width: 100%;" id="tabx6">
                <%--<p class="tit-zhibiao">州市数据</p>--%>
                <div class="biaoge-yqst table-responsive" style="margin-top: 15px;">
                    <table id="table5">
                        <thead>
                        <tr>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div id="item4" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <%--<div class="zhibiao-top back-zb">--%>
            <%--<b class="back-b zbmcb">三丶四级手术占比</b>--%>
            <%--</div>--%>
            <div class="zhibiao2" id="chart-aqyqst2" style="height:350px;"></div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/bootstrap.min.js"></script>
<%--<script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js" ></script>--%>
<script type="text/javascript" src="${ctx}/static/js/echarts.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/macarons.js"></script>
<script type="text/javascript"
        src="${ctx}/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/bootstrap-table.js"></script>
<script type="text/javascript"
        src="${ctx}/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/extensions/toolbar/bootstrap-table-toolbar.js"></script>
<script type="text/javascript" src="${ctx}/static/js/ga.js"></script>
<script type="text/javascript" src="${ctx}/static/js/dlchart.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jsonpData.js"></script>
<script>
    $(function () {
        hubeiCon.initCon('sj-pt','sj-jb');
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
        var hospital = $(this).text();
        var year = $("#rq").val();
        loadHospitalDat(hospital, year);
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
    //tab标签的点击状态
    $('#qbzb li a').click(function () {
        $(this).parent('li').siblings('li').children('a').removeClass('active');
        $(this).addClass('active');
        if ($(this).attr('id') == 'a1') {
            $('#tabx1').show();
            $('#tabx2').hide();
            $('#tabx5').hide();
        } else if ($(this).attr('id') == 'a2') {
            $('#tabx2').show();
            $('#tabx1').hide();
            $('#tabx5').hide();
        } else {
            $('#tabx2').hide();
            $('#tabx1').hide();
            $('#tabx5').show();
        }
    })
    $('#qbzb2 li a').click(function () {
        $(this).parent('li').siblings('li').children('a').removeClass('active');
        $(this).addClass('active');
        if ($(this).attr('id') == 'a4') {
            $('#tabx3').show();
            $('#tabx4').hide();
            $('#tabx6').hide();
        } else if ($(this).attr('id') == 'a5') {
            $('#tabx4').show();
            $('#tabx3').hide();
            $('#tabx6').hide();
        } else {
            $('#tabx6').show();
            $('#tabx3').hide();
            $('#tabx4').hide();
        }
    })
    //获取屏幕的高
    var H = 0;
    var biIds = ['711b54fe-ae05-41e9-a847-aec3d8afa816', '362809b4-4f16-407f-8b3c-9020c2654089'];//报表id
    var biKeys = [];//报表返回softkey
    $(document).ready(function () {
        btpage('${ctx}')
        H = $('#top-demand').height();
        $('.main-center').css('padding-top', H + 'px');
        $.ajax({
            type: "POST",
            url: "/HBI/loadBiKsy?biIds=" + biIds,
            dataType: "json",
            success: function (data) {
                biKeys = data;
                search()
            }
        });

        var date = new Date;
        var year = date.getFullYear();
        $("#rq").val(year);
    })
    var flag = true;
    $('.top-btn').click(function () {
        flag = false;
        search();
    })
    function search() {
        $("#loading").show();
        var loads = 2;
        var rq = $("#rq").val();
        var rqkj = $("#rqkj").val();
        var yyjb = $("#yyjb").val();
        var sTime = "", eTime = "", ssTime = "", seTime = "";
        var srq = rq - 1;
        ssTime = srq + "-01-01";
        seTime = srq + "-12-31";
        sTime = rq + "-01-01";
        eTime = rq + "-12-31";
        var bivar = "";
        $(".center-back-cs").find("input").each(function () {
            if ($(this).css("display") != 'none') {
                bivar = $(this).val();
                return false;
            }
        })
        if (bivar == "全省") {
            bivar = "@novalue|@novalue|@novalue|";
        } else {
            bivar = bivar.replace("全省", "@novalue");
            if (bivar.indexOf("二级") > -1 || bivar.indexOf("三级") > -1) {
                bivar = bivar.replace("二级", "|二级|");
                bivar = bivar.replace("三级", "|三级|");
                if (bivar.indexOf("全部") > -1) {
                    bivar = bivar.replace("全部", "@novalue")
                }
                bivar += "|";
            } else {
                if (bivar == "全部") {
                    bivar = bivar.replace("全部", "|@novalue|@novalue|");
                }else{
                    bivar = bivar.replace("@novalue", "@novalue|@novalue|");
                    bivar += "|";
                }

            }
        }
        //报表1
        var data1x = [], data1y = [];
        var cxtj = ssTime + ";" + seTime + ";" + sTime + ";" + eTime + "|";
        var url = '${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar=' + escape(escape(bivar)) +
            '&biyccs=&id=' + biKeys[0].id + '&softkey=' + biKeys[0].softkey +
            '&cxtj=' + escape(cxtj) + '&topdata=&timew=&weiplan=';
        $.ajax({
            type: "GET",
            url: url,
            dataType: "jsonp",
            success: function (data) {
                loads = loads - 1;
                test(loads);
                data = jsonpDataInit(data);
                var th = [], cgth = [[0, 6, 7, 10, 11, 12, 13, 14, 19, 20], [0, 1, 2, 3, 4, 5], [0, 8, 9, 15, 16, 17, 18]];
                var tit = data.title.column[0].split(",");
                for (var i = 0; i < tit.length; i++) {
                    if (tit[i] !== '#cspan' && tit[i] !== '#rspan') {
                        th.push(tit[i]);
                    }
                }
                qb(0);
                qb(1);
                qb(2);
                function qb(x) {
                    var dataIndex = [];
                    var thhtml = '';
                    for (var a = 0; a < cgth[x].length; a++) {
                        var b = cgth[x][a];
                        if(b==0){
                            dataIndex.push(0);
                        }else{
                            dataIndex.push((b-1)*4+2);
                        }
                        thhtml += '<th data-field="td' + dataIndex[a] + '"  data-sortable="true">' + th[b] + '</th>'
                    }
                    var tableData = initBootstrapTableData(data,dataIndex);
                    tableData.data.splice(0,1);
                    for(var i=0; i<tableData.data.length; i++){
                        tableData.data[i].td0 = "<a>"+tableData.data[i].td0+"</a>"
                    }
                    if (x == 0) {
                        var $table = $('#table');
                        if (flag == true) {
                            $('#table tr').html(thhtml);
                            $table.attr('data-pagination', 'true');
                            $table.attr('data-toggle', 'table');
                            $table.attr('data-page-size', '6');
                            $table.attr('data-page-list', [6, 'all']);
                            $table.attr('data-height', '218');
                            $table.bootstrapTable({data: tableData.data});
                        } else {
                            if ($('#tabx1').css('display') == 'none') {
                                $('#tabx1').show();
                                $table.attr('data-toggle', 'table');
                                $table.bootstrapTable('load', tableData.data);
                                $('#tabx1').hide();
                            } else {
                                $table.attr('data-toggle', 'table');
                                $table.bootstrapTable('load', tableData.data);
                            }
                        }
                        $('#table th div').css({'font-size': '12px'});
                        $('#table th:first div').css({'width': '150px'});
                    } else if (x == 1) {
                        var $table = $('#table1');
                        if (flag == true) {
                            $('#table1 tr').html(thhtml);
                            $table.attr('data-pagination', 'true');
                            $table.attr('data-toggle', 'table');
                            $table.attr('data-page-size', '6');
                            $table.attr('data-page-list', [6, 'all']);
                            $table.attr('data-height', '218');
                            $table.bootstrapTable({data: tableData.data});
                            $("#tabx2").hide();
                        } else {
                            if ($('#tabx2').css('display') == 'none') {
                                $('#tabx2').show();
                                $table.attr('data-toggle', 'table');
                                $table.bootstrapTable('load', tableData.data);
                                $('#tabx2').hide();
                            } else {
                                $table.attr('data-toggle', 'table');
                                $table.bootstrapTable('load', tableData.data);
                            }
                        }
                        $('#table1 th div').css({'font-size': '12px'});
                        $('#table1 th:first div').css({'width': '200px'});
                    } else {
                        var $table = $('#table2');
                        if (flag == true) {
                            $('#table2 tr').html(thhtml);
                            $table.attr('data-pagination', 'true');
                            $table.attr('data-toggle', 'table');
                            $table.attr('data-page-size', '6');
                            $table.attr('data-page-list', [6, 'all']);
                            $table.attr('data-height', '218');
                            $table.bootstrapTable({data: tableData.data});
                            $("#tabx5").hide();
                        } else {
                            if ($('#tabx5').css('display') == 'none') {
                                $('#tabx5').show();
                                $table.attr('data-toggle', 'table');
                                $table.bootstrapTable('load', tableData.data);
                                $('#tabx5').hide();
                            } else {
                                $table.attr('data-toggle', 'table');
                                $table.bootstrapTable('load', tableData.data);
                            }
                        }
                        $('#table2 th div').css({'font-size': '12px'});
                        $('#table2 th:first div').css({'width': '200px'});
                    }
                }

                djsj(data);
                var thindex, num, datas = [], dataz = [[], []], tit = "三丶四级手术占比";
                for (var i = 1; i < data.rows.row.length; i++) {
                    datas.push({
                        "name": data.rows.row[i].cell[0],
                        "value": data.rows.row[i].cell[22]
                    })
                }
                dataz = compare(datas);
                option1(dataz, tit);
            }
        });
        //26病组分组
        var url1 = '${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar=' + escape(escape(bivar)) +
            '&biyccs=&id=' + biKeys[1].id + '&softkey=' + biKeys[1].softkey +
            '&cxtj=' + escape(cxtj) + '&topdata=&timew=&weiplan=';
        $.ajax({
            type: "GET",
            url: url1,
            dataType: "jsonp",
            success: function (data) {
                loads = loads - 1;
                test(loads);
                data = jsonpDataInit(data);
                var th=[],cgth=[[0,5,6,9,10,13],[0,1,2,3,4],[0,7,8,14,15,16,17]];
                var tit = data.title.column[0].split(",");
                for (var i = 0; i < tit.length; i++) {
                    if (tit[i] !== '#cspan' && tit[i] !== '#rspan') {
                        th.push(tit[i]);
                    }
                }
                qb(0);
                qb(1);
                qb(2);
                function qb(x) {
                    var dataIndex = [];
                    var thhtml = '';
                    for (var a = 0; a < cgth[x].length; a++) {
                        var b = cgth[x][a];
                        if(b==0){
                            dataIndex.push(0);
                        }else{
                            dataIndex.push((b-1)*4+2);
                        }
                        thhtml += '<th data-field="td' + dataIndex[a] + '"  data-sortable="true">' + th[b] + '</th>'
                    }
                    var tableData = initBootstrapTableData(data,dataIndex);
                    tableData.data.splice(0,1);
                    if (x == 0) {
                        var $table = $('#table3');
                        if (flag == true) {
                            $('#table3 tr').html(thhtml);
                            $table.attr('data-pagination', 'true');
                            $table.attr('data-toggle', 'table');
                            $table.attr('data-page-size', '6');
                            $table.attr('data-page-list', [6, 'all']);
                            $table.attr('data-height', '218');
                            $table.bootstrapTable({data: tableData.data});
                        } else {
                            if ($('#tabx3').css('display') == 'none') {
                                $('#tabx3').show();
                                $table.attr('data-toggle', 'table');
                                $table.bootstrapTable('load', tableData.data);
                                $('#tabx3').hide();
                            } else {
                                $table.attr('data-toggle', 'table');
                                $table.bootstrapTable('load', tableData.data);
                            }
                        }
                        $('#table3 th div').css({'font-size': '12px'});
                        $('#table3 th:first div').css({'width': '150px'});
                    } else if (x == 1) {
                        var $table = $('#table4');
                        if (flag == true) {
                            $('#table4 tr').html(thhtml);
                            $table.attr('data-pagination', 'true');
                            $table.attr('data-toggle', 'table');
                            $table.attr('data-page-size', '6');
                            $table.attr('data-page-list', [6, 'all']);
                            $table.attr('data-height', '218');
                            $table.bootstrapTable({data: tableData.data});
                            $('#tabx4').hide();
                        } else {
                            if ($('#tabx4').css('display') == 'none') {
                                $('#tabx4').show();
                                $table.attr('data-toggle', 'table');
                                $table.bootstrapTable('load', tableData.data);
                                $('#tabx4').hide();
                            } else {
                                $table.attr('data-toggle', 'table');
                                $table.bootstrapTable('load', tableData.data);
                            }
                        }
                        $('#table4 th div').css({'font-size': '12px'});
                        $('#table4 th:first div').css({'width': '200px'});
                    } else {
                        var $table = $('#table5');
                        if (flag == true) {
                            $('#table5 tr').html(thhtml);
                            $table.attr('data-pagination', 'true');
                            $table.attr('data-toggle', 'table');
                            $table.attr('data-page-size', '6');
                            $table.attr('data-page-list', [6, 'all']);
                            $table.attr('data-height', '218');
                            $table.bootstrapTable({data: tableData.data});
                            $('#tabx6').hide();
                        } else {
                            if ($('#tabx6').css('display') == 'none') {
                                $('#tabx6').show();
                                $table.attr('data-toggle', 'table');
                                $table.bootstrapTable('load', tableData.data);
                                $('#tabx6').hide();
                            } else {
                                $table.attr('data-toggle', 'table');
                                $table.bootstrapTable('load', tableData.data);
                            }
                        }
                        $('#table5 th div').css({'font-size': '12px'});
                        $('#table5 th:first div').css({'width': '200px'});
                    }
                }

                djsj2(data);
                var thindex, num, datas = [], dataz = [[], []], tit = "三丶四级手术占比";
                for (var i = 1; i < data.rows.row.length; i++) {
                    datas.push({
                        "name": data.rows.row[i].cell[0],
                        "value": data.rows.row[i].cell[22]
                    })
                }
                dataz = compare(datas);
                option2(dataz, tit);
            }
        });
    }
    function option1(data, tit) {
        var myChart = echarts.init(document.getElementById('chart-aqyqst'));
        var colors = ['#4ea397'];
        var option = dlchart.CreateBarChart("", data[0], {name: tit, data: data[1]}, {
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            visualMap: {
                show: false,
                min: 0,
                max: 9,
                dimension: 0,
                inRange: {
                    color: ['#229583', '#7abfb5']
                }
            },
        }, {
            index: 0, option: {
//            markPoint : {
//                data : [
//                    {type : 'max', name: '最大值'},
//                    {type : 'min', name: '最小值'}
//                ]
//            },

                markLine: {
                    data: [
                        {type: 'average', name: '平均值'}
                    ]
                }
            }
        }, null);


        myChart.setOption(option);
        myChart.on('dblclick', function (param) {
            var hospital = param.name;
            var year = $("#rq").val();
            loadHospitalDat(hospital, year);
        });
    }

    function option2(data, tit) {
        var myChart = echarts.init(document.getElementById('chart-aqyqst2'));
        var colors = ['#4ea397'];
        var option = dlchart.CreateBarChart("", data[0], {name: tit, data: data[1]}, {
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            visualMap: {
                show: false,
                min: 0,
                max: 9,
                dimension: 0,
                inRange: {
                    color: ['#229583', '#7abfb5']
                }
            },
        }, {
            index: 0, option: {
//            markPoint : {
//                data : [
//                    {type : 'max', name: '最大值'},
//                    {type : 'min', name: '最小值'}
//                ]
//            },
                markLine: {
                    data: [
                        {type: 'average', name: '平均值'}
                    ]
                }
            }
        }, null);

        myChart.setOption(option);
    }
    //obj排序
    function compare(datas) {
        var dataz = [[], []];
        if (datas.length > 10) {
            for (var i = 0; i < 10; i++) {
                for (var j = i + 1; j < datas.length; j++) {
                    if (Number(datas[i].value) < Number(datas[j].value)) {
                        var cmi = datas[j].value;
                        datas[j].value = datas[i].value;
                        datas[i].value = cmi;
                        var hos = datas[j].name;
                        datas[j].name = datas[i].name;
                        datas[i].name = hos;
                    }
                }
                dataz[0].push(datas[i].name);
                dataz[1].push(datas[i].value);
            }

        } else {
            for (var i = 0; i < datas.length; i++) {
                for (var j = i + 1; j < datas.length; j++) {
                    if (Number(datas[i].value) < Number(datas[j].value)) {
                        var cmi = datas[j].value;
                        datas[j].value = datas[i].value;
                        datas[i].value = cmi;
                        var hos = datas[j].name;
                        datas[j].name = datas[i].name;
                        datas[i].name = hos;
                    }
                }
                dataz[0].push(datas[i].name);
                dataz[1].push(datas[i].value);
            }
        }
        return dataz;
    }
    function djsj(data) {
        $("body").delegate('#table td', 'click', function () {
            if ($(this).index() == 0) {
                return;
            }
            var adom = $('#table tr');
            clic(data, this, adom);
        });
        $("body").delegate('#table1 td', 'click', function () {
            if ($(this).index() == 0) {
                return;
            }
            var adom = $('#table1 tr');
            clic(data, this, adom);
        });
        $("body").delegate('#table2 td', 'click', function () {
            if ($(this).index() == 0) {
                return;
            }
            var adom = $('#table2 tr');
            clic(data, this, adom);
        });
    }
    function clic(data, a, b) {
        var thindex, num, datas = [], dataz = [[], []], tit;
        var index = $(a).index();
        if (index != 0) {
            thindex = b.find('th').eq(index).attr('data-field');
            tit = b.find('th').eq(index).text();
            $('.zbmca').text(tit);
        }
        num = Number(thindex.substring(2,thindex.length));
        for (var i = 1; i < data.rows.row.length; i++) {
            datas.push({
                "name": data.rows.row[i].cell[0],
                "value": data.rows.row[i].cell[num]
            })
        }
        dataz = compare(datas);
        option1(dataz, tit);
    }
    //26病组
    function djsj2(data) {
        $("body").delegate('#table3 td', 'click', function () {
            if ($(this).index() == 0) {
                return;
            }
            var adom = $('#table3 tr');
            clic2(data, this, adom);
        });
        $("body").delegate('#table4 td', 'click', function () {
            if ($(this).index() == 0) {
                return;
            }
            var adom = $('#table4 tr');
            clic2(data, this, adom);
        });
        $("body").delegate('#table5 td', 'click', function () {
            if ($(this).index() == 0) {
                return;
            }
            var adom = $('#table5 tr');
            clic2(data, this, adom);
        });
    }
    $("body").delegate('table td', 'mouseover', function () {
        $(this).attr('title', '单击显示此列数据!');
    });
    function clic2(data, a, b) {
        var thindex, num, datas = [], dataz = [[], []], tit;
        var index = $(a).index();
        if (index != 0) {
            thindex = b.find('th').eq(index).attr('data-field');
            tit = b.find('th').eq(index).text();
            $('.zbmcb').text(tit);
        }
        num = Number(thindex.substring(2,thindex.length));
        for (var i = 1; i < data.rows.row.length; i++) {
            datas.push({
                "name": data.rows.row[i].cell[0],
                "value": data.rows.row[i].cell[num]
            })
        }
        dataz = compare(datas);
        option2(dataz, tit);
    }
</script>
</body>
</html>
