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
    <link rel="stylesheet" type="text/css" href="${ctx }/static/js/jquery-easyui-1.5/themes/default/easyui.css">

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

        .tab-a {
            width: 100%;
        }

        .tab-a td {
            text-align: left;
        }

        .chartitle {
            margin: 1em 2em;
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
<div id="menu" style="position:fixed;top: 10px;right: 20px;z-index:20000;font-size:12px;">
    <%--<div class="xian" style="height: 25px;"></div>--%>
    <%--<ul>--%>
    <%--<li><a href="#item1" class="current"><span></span>- -医疗机构专科能力排名</a></li>--%>
    <%--<li><a href="#item2"><span></span>- -医疗机构科目质量效率排名</a></li>--%>
    <%--</ul>--%>
</div>
<div class="top-demand" id="top-demand" style="top: 0;">
    <ul>
        <li>
            <label>日期：</label>
            <select id="rqkj" onchange="hubeiCon.changeRqkj()" style="width: 60px;height: 24px;border-radius:2px;border: 1px solid #ddd">
                <option value="n">年</option>
                <option value="j">季</option>
                <%--<option value="y">月</option>--%>
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
    <div id="item1" class="man-c-2" style="padding-top: 46px;">
        <div class="bg-f" style="overflow: hidden;min-height: 400px;">
            <div class="zhibiao-top back-zb">
                <b class="back-b zbmca">区域医疗质量与安全比较</b>
                <a href="###" id="daochu"  class="daochu">导出</a>
                <a href="###" id="daochuimg1" style="display: none;">导出</a>
            </div>
            <div class="zhibiao2">
                <p class="chartitle" id="dt"style="font-size: 20px;color:blue"></p>
            </div>
            <div class="zhibiao2" id="data0" style="min-height:360px;"></div>
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
</div>
<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/bootstrap.min.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/bootstrap-table.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/extensions/toolbar/bootstrap-table-toolbar.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/ga.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/echarts.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/macarons.js"></script>
<script type="text/javascript" src="${ctx}/static/js/dlchart.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jsonpData.js"></script>
<script type="text/javascript" src="${ctx}/static/js/layuiData.js"></script>
<script type="text/javascript" src="${ctx }/static/js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctx }/static/js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${ctx }/static/js/export.js"></script>
<script>
    $(function () {
        hubeiCon.initCon('sj-pt','sj-jb');
        hubeiCon.hospitalCon('sj-ks','sj-bz');
    });
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
    //获取屏幕的高
    var H = 0;
    var loads =0;
    var biIds = ['bbb47e18-12bd-4802-a57d-bb1722686214'];//报表id
    var biKeys = [];//报表返回softkey
    var flag = true;
    var date = new Date;
    var year = date.getFullYear();
    $("#srq").val(year + "-01");
    var month = date.getMonth();
    if (month < 9) {
        month = "0" + (month + 1);
    } else {
        month = (month + 1);
    }
    $("#erq").val(year + "-" + month);
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
                scrollTop: $($.attr(this, 'href')).offset().top - 100
            }, 500);
            return false;
        });
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
        $('.top-btn').click(function () {
            flag=false;
            search();
        })
    })

    function search() {
        $("#loading").show();
        var bivar = "";
        $(".center-back-cs").find("input").each(function(){
            if($(this).css("display")!='none'){
                bivar=$(this).val();
                return false;
            }
        });
        if(bivar == "全省"){
            bivar = "@novalue|@novalue|@novalue|";
        }else {
            bivar = bivar.replace("全省","@novalue");
            if(bivar.indexOf("二级")>-1||bivar.indexOf("三级")>-1|| bivar.indexOf("所有") > -1){
                bivar = bivar.replace("二级","|二级|");
                bivar = bivar.replace("三级","|三级|");
                bivar = bivar.replace("所有","|@novalue|");
                if(bivar.indexOf("全部")>-1){
                    bivar = bivar.replace("全部","@novalue")
                }
                bivar += "|";
            }else{
                bivar = bivar.replace("全部","|@novalue|@novalue|");
            }
        }
        var kstj = '@novalue|';
        var mdctj = '@novalue|';
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
        var rq = $("#rq").val();
        var rqkj = $("#rqkj").val();
        $("#dt").text(rq+(rqkj=="n"?"年度":""));
        var cxsj = hubeiCon.getTimeStr();
        var cxtj0 = cxsj+ "|"+kstj+mdctj;
        loads++;
        var url0 = '${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar=' +escape(escape(bivar))+
            '&biyccs=&id=' + biKeys[0].id + '&softkey=' + biKeys[0].softkey +
            '&cxtj=' + escape(cxtj0) + '&topdata=&timew=&weiplan=';
        //获取权限
        $.ajax({
            type: "GET",
            url: url0,
            dataType: "jsonp",
            success: function (data) {
                loads--;
                test(loads);
                data = jsonpDataInit(data);
                setData1(data);
                setData2(data);
            }
        });
    }
    function setData1(data) {
        var attr = [];
        var datay = data.rows.row;
        for (var i = 1; i < datay.length; i++) {
            var str = [];
            str.push(datay[i].cell[2]);
            str.push(datay[i].cell[7]);
            str.push(datay[i].cell[0]);
            str.push(69.5);
            attr.push(str);
        }
        var markLineOpt = {
            animation: false,
            lineStyle: {
                normal: {
                    type: 'dashed',
                    color: 'red'
                }
            },
            data: [[{
                coord: [0, 0],
                symbol: 'none'
            }, {
                coord: [0.8, 0.8],
                symbol: 'none'
            }]]
        };
        var myChart = echarts.init(document.getElementById('data0'));
        var option = dlchart.CreateCatterChart("", {x: "地区粗死亡率(/千患者)", y: "地区标准化死亡率(/千患者)"},
            [{name: "区域医疗质量与安全示意图(患者死亡率)", data: attr}], {
                grid: {
                    left: '3%',
                    right: '10%',
                    bottom: '3%',
                    containLabel: true
                }, xAxis: {
                    nameLocation:'middle',
                    nameGap:16,
                },yAxis:{
                    nameLocation:'middle',
                    nameGap:25,
                }
            }, {
                index: 0, option: {
                    markPoint: {
                        lable: "sds"
                    },
                    markLine: markLineOpt,
                    label: {
                        emphasis: {
                            show: true,
                            formatter: function (param) {
                                return param.data[2];
                            },
                            position: 'top'
                        }
                    },
                }
            },2);
        myChart.setOption(option);
    }
    function setData2(data) {
        var dataIndex = [0, 1, 2, 3, 4, 5, 6,7,8,9];
        var tableData = initBootstrapTableData(data,dataIndex);//jsop数据格式化为layuiTable数据格式
        tableData.data[0].td8='-';
        tableData.data[0].td9='-';
        for(var i=0; i<tableData.data.length; i++){
            for(var j=i; j<tableData.data.length; j++){
                if(Number(tableData.data[i].td9)>Number(tableData.data[j].td9)){
                    var jsonStr = tableData.data[i];
                    tableData.data[i] = tableData.data[j];
                    tableData.data[j] = jsonStr;
                }
            }
        }
        var $table = $('#table1');
        if(flag==true) {
            $("#thead1").empty();
            $("#thead1").append(tableData.tr);
            $table.attr('data-pagination', 'true');
            $table.attr('data-toggle', 'table');
            $table.attr('data-page-size', '6');
            $table.attr('data-height', "218");
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

    var n=0;
    $('#daochu').click(function () {
        var a = getBase64Image('data0');
        var options = $("#table1").bootstrapTable('getOptions');
        var excleJson = {excel:JSON.stringify(
            [
                {
                    name:"区域医疗质量与安全比较",
                    img:JSON.stringify([a]),
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
//        $('.page-list button').click();
//        n++;
//        getFullCanvasDataURL('data0','daochuimg1',n+'区域医疗质量与安全比较.png');
//        var tablehtml1='<tr><td colspan="8" style="width: 1139px;height: 360px;"><img src="'+n+'区域医疗质量与安全比较.png"></td></tr>'
//        var tablehtml=tablehtml1+$('#table1 thead').html()+$('#table1 tbody').html();
//        tableToExcel('table',tablehtml,'区域医疗质量与安全比较');
    });
</script>
</body>
</html>
