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
        body{overflow-y:auto;}
        .tab-a {
            width: 100%;
        }
        .tab-a td {
            text-align: left;
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
<%--<div id="menu" style="position:fixed;top: 10px;right: 20px;z-index:20000;font-size:12px;">
    <div class="xian" style="height: 45px;"></div>
    <ul>
        <li><a href="#item1" class="current"><span></span>- -全省医疗服务质量指标的概览</a></li>
        <li><a href="#item2"><span></span>- -病种权重分析</a></li>
        <li><a href="#item3"><span></span>- -DRGs组患者分布</a></li>
    </ul>
</div>--%>
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
                <input  style="width: 150px; height: 24px;border-radius:2px;cursor: pointer"
                        class="sj-ks" id="sj-ks" readonly="readonly" value="" type="text" placeholder="科室选择" />
                <input  style="width: 150px; height: 24px;border-radius:2px;cursor: pointer"
                        class="sj-bz" id="sj-bz"  readonly="readonly" value="" type="text" placeholder="DRGs病组选择" />
            </div>
        </li>
    </ul>
    <div class="top-btn">查询</div>
</div>

<div class="main" id="main">
    <div id="item1" class="man-c-2" style="padding-top: 46px;">
        <div class="bg-f" style="overflow: hidden;min-height:128px;">
            <div class="zhibiao-top back-zb">
                <b class="back-b">医疗服务指标概览</b>
                <a href="###" id="daochu" class="daochu">导出</a>
            </div>
            <div class="col-xs-6 zhibiao2" style="width: 100%;" id="tabx1">
                <div class="table-responsive" style="margin-top: 15px;">
                    <table id="tableJg" class="tab-a table table-bordered back-jodh" style="margin-bottom: 0px;display: none">
                        <tr>
                            <td>入组医疗机构总数：<span id="jg_td10" style="font-weight: 700 ;color: #f58839"></span> 家</td>
                            <td>三级医院：<span id="jg_td0" style="font-weight: 700 ;color: #f58839"></span> 家</td>
                            <td>其中：三级综合医院 <span id="jg_td1" style="font-weight: 700 ;color: #f58839"></span> 家</td>
                            <td>三级专科医院 <span id="jg_td11" style="font-weight: 700 ;color: #f58839"></span> 家</td>
                            <td>三级中医院 <span id="jg_td12" style="font-weight: 700 ;color: #f58839"></span> 家</td>
                            <td>三级妇幼医院 <span id="jg_td13" style="font-weight: 700 ;color: #f58839"></span> 家</td>
                            <td>甲等 <span id="jg_td2" style="font-weight: 700 ;color: #f58839"></span> 家</td>
                            <td>乙等 <span id="jg_td3" style="font-weight: 700 ;color: #f58839"></span> 家</td>
                            <td>未定等 <span id="jg_td4" style="font-weight: 700 ;color: #f58839"></span> 家</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>二级医院：<span id="jg_td5" style="font-weight: 700 ;color: #f58839"></span> 家</td>
                            <td>其中：二级综合医院 <span id="jg_td6" style="font-weight: 700 ;color: #f58839"></span> 家</td>
                            <td>二级专科医院 <span id="jg_td14" style="font-weight: 700 ;color: #f58839"></span> 家</td>
                            <td>二级中医院 <span id="jg_td15" style="font-weight: 700 ;color: #f58839"></span> 家</td>
                            <td>二级妇幼医院 <span id="jg_td16" style="font-weight: 700 ;color: #f58839"></span> 家</td>
                            <td>甲等 <span id="jg_td7" style="font-weight: 700 ;color: #f58839"></span> 家</td>
                            <td>乙等 <span id="jg_td8" style="font-weight: 700 ;color: #f58839"></span> 家</td>
                            <td>未定等 <span id="jg_td9" style="font-weight: 700 ;color: #f58839"></span> 家</td>
                        </tr>
                    </table>
                    <table id="tablePt" class="tab-a table table-bordered back-jodh" style="margin-bottom: 0px;">
                        <tr>
                            <td><span id="dt" style="font-size:18px;color: blue "></span></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>入组患者总人次：<span id="td0" style="font-weight: 700 ;color: #f58839"></span>人次</td>
                            <td>总医疗费用：<span id="td1" style="font-weight: 700 ;color: #f58839"></span>元</td>
                            <td>总住院日：<span id="td2" style="font-weight: 700 ;color: #f58839"></span>天</td>
                            <td>总权重数：<span id="td3" style="font-weight: 700 ;color: #f58839"></span></td>
                            <td>DRGs组数：<span id="td4" style="font-weight: 700 ;color: #f58839"></span>组</td>
                            <td>总死亡人数：<span id="td5" style="font-weight: 700 ;color: #f58839"></span>人</td>
                        </tr>
                        <tr>
                            <td>总入组率：<span id="td16" style="font-weight: 700 ;color: #f58839"></span>%</td>
                            <td>人均住院费用：<span id="td6" style="font-weight: 700 ;color: #f58839"></span>元</td>
                            <td>平均住院日：<span id="td7" style="font-weight: 700 ;color: #f58839"></span>天</td>
                            <td>病例组合指数（CMI）：<span id="td8" style="font-weight: 700 ;color: #f58839"></span></td>
                            <td>手术率：<span id="td11" style="font-weight: 700 ;color: #f58839"></span></td>
                            <td>手术死亡率：<span id="td12" style="font-weight: 700 ;color: #f58839"></span></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>每权重费率：<span id="td9" style="font-weight: 700 ;color: #f58839"></span>元</td>
                            <td>住院患者死亡率：<span id="td13" style="font-weight: 700 ;color: #f58839"></span></td>
                            <td>药占比：<span id="td14" style="font-weight: 700 ;color: #f58839"></span>%</td>
                            <td>耗材比：<span id="td15" style="font-weight: 700 ;color: #f58839"></span>%</td>
                            <td></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div id="item2" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;min-height:160px;">
            <div class="zhibiao-top back-zb">
                <b class="back-b">病种权重分析</b>
                <a href="###" id="daochu1"  class="daochu">导出</a>
                <%--<a href="###" id="daochuimg1" style="display: none;">导出</a>--%>
                <%--<a href="###" id="daochuimg2" style="display: none;">导出</a>--%>
                <%--<a href="###" id="daochuimg3" style="display: none;">导出</a>--%>
            </div>
            <div class="w-h">
                <%--<div class="col-xs-2 zhibiao2">--%>
                    <%--<div  class="table-responsive" style="margin:15px;">--%>

                    <%--</div>--%>
                <%--</div>--%>
                    <div class="col-xs-4 zhibiao1" style="display: inline-block; ">
                        <div style="margin-top: -30px;min-height:200px;"  id="data6">
                        </div>
                        <table  id="table6" class="table" style="font-size: 12px;margin:auto;width: 60%">
                        </table>
                    </div>
                <div class="col-xs-4 zhibiao1" style="display: inline-block;">
                    <div style="margin-top: -30px;min-height:200px; "  id="data1">
                    </div>
                    <table  id="table1" class="table" style="font-size: 12px; margin:auto;width: 60%">
                    </table>
                </div>
                <div class="col-xs-4 zhibiao1" style="display: inline-block;">
                    <div style="margin-top: -30px;min-height:200px; "  id="data2">
                    </div>
                    <table  id="table2" class="table" style="font-size: 12px;margin:auto;width: 60%">
                    </table>
                </div>


            </div>
            <div class="w-h">
                <div class="col-xs-4 zhibiao1" style="display: inline-block; ">
                    <div style="margin-top: -30px;min-height:200px;"  id="data3">
                    </div>
                    <table  id="table3" class="table" style="font-size: 12px;margin:auto;width: 60%">
                    </table>
                </div>
                <div class="col-xs-4 zhibiao1" style="display: inline-block;">
                    <div style="margin-top: -30px;min-height:200px; "  id="data4">
                    </div>
                    <table  id="table4" class="table" style="font-size: 12px; margin:auto;width: 60%">
                    </table>
                </div>
                <div class="col-xs-4 zhibiao1" style="display: inline-block;">
                    <div style="margin-top: -30px;min-height:200px; "  id="data5">
                    </div>
                    <table  id="table5" class="table" style="font-size: 12px;margin:auto;width: 60%">
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div id="item3" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b zbmca"> DRGs组患者分布</b>
                <ul id="tabList" >
                    <li><a class="active" id="a1">RW(TOP10)</a></li>
                    <li><a id="a2">总费用(TOP10)</a></li>
                    <li><a id="a3">均费(TOP10)</a></li>
                    <li><a id="a4">每权重患者数(TOP10)</a></li>
                </ul>
                <a href="###" id="daochu2"  class="daochu">导出</a>
                <%--<a href="###" id="daochuimg4"  style="display: none;">导出</a>--%>
            </div>
            <div class="w-h">
                <div class="col-xs-7 zhibiao2">
                    <div  id="data0" style="height:298px;margin-top: -30px;"></div>
                </div>
                <div class="col-xs-5 zhibiao2">
                    <div  class="biaoge-yqst table-responsive" style="margin:0 0 15px -75px;">
                        <table class="table" id="table0" style="font-size: 12px;">
                            <thead id="thead0">
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
    var loads = 0;
    var biIds = '38e9a7ad-74a9-47e8-8405-4ad673a9144e$8f23c96f-0210-4589-88e6-a8794e148198$1527a9f1-27d4-4eef-996b-7beb98d4defd$ec134a28-85f0-483f-bd66-712e380bdc6a';//报表id
    var biKeys = [];//报表返回softkey
    var flag = true,datas;
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
        $('.top-btn').click(function () {
            flag=false;
            search();
        })
        if("${userType}"!='机构'){
            $("#tableJg").show();
        }
        var date = new Date;
        var year = date.getFullYear();
        $("#rq").val(year);
    })

    function search() {
        $("#loading").show();
        var bivar = '';
        var hosName='@novalue';
        var bivars = "${bivar}".split("|");
        if(bivars[0]=='全省'){
            bivars[0]='@novalue|'
        }
        if("${userType}"=='机构'){
            hosName="${hosName}";
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
        var cxsj = hubeiCon.getTimeStr();
        var cxtj0 = cxsj+"|"+hosName+"|";
        var cxtj1 = cxsj+"|"+kstj+mdctj+hosName+"|";
        loads++;
        var url0 = '${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+ escape(escape(bivars[0]))+
            '&biyccs=&id=' + biKeys[0].id + '&softkey=' + biKeys[0].softkey +
            '&cxtj=' + escape(cxtj0+"$"+cxtj1+"$"+cxtj1+"$"+cxtj1) + '&topdata=&timew=&weiplan=';
        $.ajax({
            type: "GET",
            url: url0,
            dataType: "jsonp",
            success: function (data) {
                loads--;
                test(loads);
                data0 = jsonpDataInit(data[0]);
                setData0(data0);
                //2
                $("#dt").text(rq+(rqkj=="n"?"年度":""));
                data1 = jsonpDataInit(data[1]);
                setData1(data1);
                //3
                data2 = jsonpDataInit(data[2]);
                setData2(data2)
                //4
//                if(kstj='@novalue|'&&data[3].rows.row){
//                    data[3].rows.row.length=10
//                 }
                data3 = jsonpDataInit(data[3]);
                datas=data3;
                $("#a1").parent('li').siblings('li').children('a').removeClass('active');
                $("#a1").addClass('active');
                var dataIndex = [0,1,3,2];
                setData4(data[3],dataIndex[2]);
                loadTableData(datas,dataIndex);
                $('#tabList li a').click(function () {
                    if($(this).hasClass("active")){return }
                    $(this).parent('li').siblings('li').children('a').removeClass('active');
                    $(this).addClass('active');
                    var dataIndex = [];
                    if ($(this).attr('id') == 'a1') {
                        dataIndex = [0,1,3,2];
                    } else if ($(this).attr('id') == 'a2') {
                        dataIndex = [0,1,4,2];
                    } else if ($(this).attr('id') == 'a3') {
                        dataIndex = [0,1,5,2];
                    }else if ($(this).attr('id') == 'a4') {
                        dataIndex = [0,1,6,2];
                    }
                    setData4(datas,dataIndex[2]);
                    loadTableData(datas,dataIndex);
                })
           }
        });
    }

    function setData0(data){
        var tableData = data.rows.row[0];
        for(var i=0;i<tableData.cell.length;i++){
            $("#jg_td"+i).text(tableData.cell[i]);
        }
    }
    function setData1(data){
        var tableData = data.rows.row[0];
        for(var i=0;i<tableData.cell.length;i++){
            $("#td"+i).text(tableData.cell[i]);
        }
    }
    function setData2(data) {
        var title =  data.title.column.split(",");
        var datay = data.rows.row[0];
        $('#table1').empty();
        $('#table2').empty();
        $('#table3').empty();
        $('#table4').empty();
        $('#table5').empty();
        $('#table6').empty();
        var tr1 = "<tr><td>DRGs组数</td><td id='ttd0' style='font-weight: 700 ;color: #f58839'>"+datay.cell[0]+"</td></tr>"
            +"<tr><td>患者数</td><td id='ttd1' style='font-weight: 700 ;color: #f58839'>"+datay.cell[1]+"</td></tr>"
            +"<tr><td>权重数</td><td  id='ttd2' style='font-weight: 700 ;color: #f58839'>"+datay.cell[2]+"</td></tr>";

        var tr2 = "<tr><td>DRGs组数</td><td  id='ttd3' style='font-weight: 700 ;color: #f58839'>"+datay.cell[3]+"</td></tr>"
            +"<tr><td>患者数</td><td  id='ttd4' style='font-weight: 700 ;color: #f58839'>"+datay.cell[4]+"</td></tr>"
            +"<tr><td>权重数</td><td  id='ttd5' style='font-weight: 700 ;color: #f58839'>"+datay.cell[5]+"</td></tr>";

        var tr3 = "<tr><td>DRGs组数</td><td  id='ttd6' style='font-weight: 700 ;color: #f58839'>"+datay.cell[6]+"</td></tr>"
            +"<tr><td>患者数</td><td  id='ttd7' style='font-weight: 700 ;color: #f58839'>"+datay.cell[7]+"</td></tr>"
            +"<tr><td>权重数</td><td  id='ttd8' style='font-weight: 700 ;color: #f58839'>"+datay.cell[8]+"</td></tr>";

        var tr4 = "<tr><td>DRGs组数</td><td  id='ttd12' style='font-weight: 700 ;color: #f58839'>"+datay.cell[12]+"</td></tr>"
            +"<tr><td>患者数</td><td  id='ttd13' style='font-weight: 700 ;color: #f58839'>"+datay.cell[13]+"</td></tr>"
            +"<tr><td>权重数</td><td  id='ttd14' style='font-weight: 700 ;color: #f58839'>"+datay.cell[14]+"</td></tr>";

        var tr5 = "<tr><td>DRGs组数</td><td  id='ttd16' style='font-weight: 700 ;color: #f58839'>"+datay.cell[16]+"</td></tr>"
            +"<tr><td>患者数</td><td  id='ttd17' style='font-weight: 700 ;color: #f58839'>"+datay.cell[17]+"</td></tr>"
            +"<tr><td>权重数</td><td  id='ttd18' style='font-weight: 700 ;color: #f58839'>"+datay.cell[18]+"</td></tr>";

        var tr6 = "<tr><td>DRGs组数</td><td  id='ttd20' style='font-weight: 700 ;color: #f58839'>"+datay.cell[20]+"</td></tr>"
            +"<tr><td>患者数</td><td  id='ttd21' style='font-weight: 700 ;color: #f58839'>"+datay.cell[21]+"</td></tr>"
            +"<tr><td>权重数</td><td  id='ttd22' style='font-weight: 700 ;color: #f58839'>"+datay.cell[22]+"</td></tr>";

        $('#table1').append(tr1);
        $('#table2').append(tr2);
        $('#table3').append(tr3);
        $('#table4').append(tr4);
        $('#table5').append(tr5);
        $('#table6').append(tr6);

        var colors  =['#1177ae','#6fd99e'];
        var myChart1 = echarts.init(document.getElementById('data1'));
        var option1 = dlchart.CreatePieChart('权重占比', ['10＞病种权重≥5' ], [{
            name: "权重占比",
            data: [{name: "10＞病种权重≥5", value:datay.cell[9]},  {
                name: "  ",
                value: 100-Number(datay.cell[9])
            }]
        }],{
            legend: {
                x:'center',
            },color:colors},{index:0,option:{   radius: ['0', '55%'], label: {
            normal: {
                show: false
            }
        }}});
        var myChart2 = echarts.init(document.getElementById('data2'));
        var option2 = dlchart.CreatePieChart('权重占比', [ '5＞病种权重≥2'], [{
            name: "权重占比",
            data: [ {name: "5＞病种权重≥2", value: datay.cell[10]}, {
                name: "  ",
                value: 100-Number(datay.cell[10])
            }]
        }],{
            legend: {
            x:'center',
        },color:colors},{index:0,option:{  radius: ['0', '55%'], label: {
            normal: {
                show: false
            }
        }}});
        var myChart3 = echarts.init(document.getElementById('data3'));
        var option3 = dlchart.CreatePieChart('权重占比', [ '2＞病种权重≥1'], [{
            name: "权重占比",

            data: [{name: "2＞病种权重≥1", value: datay.cell[11]},  {
                name: "  ",
                value: 100-Number(datay.cell[11])
            }]
        }],{
            legend: {
                x:'center',
            },color:colors},{index:0,option:{ radius: ['0', '55%'],  label: {
            normal: {
                show: false
            }
        }}});
        var myChart4 = echarts.init(document.getElementById('data4'));
        var option4 = dlchart.CreatePieChart('权重占比', [ '1＞病种权重≥0.5'], [{
            name: "权重占比",

            data: [{name: "1＞病种权重≥0.5", value: datay.cell[15]},  {
                name: "  ",
                value: 100-Number(datay.cell[15])
            }]
        }],{
            legend: {
                x:'center',
            },color:colors},{index:0,option:{ radius: ['0', '55%'],  label: {
            normal: {
                show: false
            }
        }}});
        var myChart5 = echarts.init(document.getElementById('data5'));
        var option5 = dlchart.CreatePieChart('权重占比', [ '病种权重＜0.5'], [{
            name: "权重占比",

            data: [{name: "病种权重＜0.5", value: datay.cell[19]},  {
                name: "  ",
                value: 100-Number(datay.cell[19])
            }]
        }],{
            legend: {
                x:'center',
            },color:colors},{index:0,option:{ radius: ['0', '55%'],  label: {
            normal: {
                show: false
            }
        }}});
        var myChart6 = echarts.init(document.getElementById('data6'));
        var option6 = dlchart.CreatePieChart('权重占比', [ '病种权重≥10'], [{
            name: "权重占比",

            data: [{name: "病种权重≥10", value: datay.cell[23]},  {
                name: "  ",
                value: 100-Number(datay.cell[23])
            }]
        }],{
            legend: {
                x:'center',
            },color:colors},{index:0,option:{ radius: ['0', '55%'],  label: {
            normal: {
                show: false
            }
        }}});
        myChart1.setOption(option1);
        myChart2.setOption(option2);
        myChart3.setOption(option3);
        myChart4.setOption(option4);
        myChart5.setOption(option5);
        myChart6.setOption(option6);
    }
//    function setData3(data) {
//        $("#a1").parent('li').siblings('li').children('a').removeClass('active');
//        $("#a1").addClass('active');
//        clickTable(data);
//
//        var dataIndex = [0,1,3,2];
//        setData4(data,dataIndex[2]);
//        loadTableData(data,dataIndex);
//    }

    function loadTableData(data,dataIndex){

        for(var i=0;i<data.rows.row.length;i++){
            for(var j=i;j<data.rows.row.length;j++){
                if(Number(data.rows.row[i].cell[dataIndex[2]])<Number(data.rows.row[j].cell[dataIndex[2]])){
                    var cell = data.rows.row[i];
                    data.rows.row[i] = data.rows.row[j];
                    data.rows.row[j] = cell;
                }
            }
        }
        var data1 = {title:{},rows:{row:{}}};
        data1.title = data.title;
        data1.rows.row = data.rows.row.slice(0,10);
        var tableData = initBootstrapTableData(data1,dataIndex);//jsop数据格式化为layuiTable数据格式
        var $table = $('#table0');
        $table.bootstrapTable('destroy');
        $("#thead0").empty();
        $("#thead0").append(tableData.tr);
        $table.attr('data-pagination', 'true');
        $table.attr('data-toggle', 'table');
        $table.attr('data-page-size', '10');
        $table.attr('data-page-list', [10, 'all']);
        $table.bootstrapTable({data: tableData.data});
        if(dataIndex.length>5){
            $('#table0 th:first ').css({'width':'20%'});
        }
        tableData.data.length<=10&&$('.fixed-table-pagination').css('border-top','none');
    }

    function setData4(data,titIndex) {
        for(var i=0;i<data.rows.row.length;i++){
            for(var j=i;j<data.rows.row.length;j++){
                if(Number(data.rows.row[i].cell[titIndex])<Number(data.rows.row[j].cell[titIndex])){
                    var cell = data.rows.row[i];
                    data.rows.row[i] = data.rows.row[j];
                    data.rows.row[j] = cell;
                }
            }
        }
        var attr = [];
        var tit = data.title.column.split(",");
        var datay = data.rows.row.slice(0,10);
        for (var i = 0; i < datay.length; i++) {
            var str = [];
            str.push(datay[i].cell[titIndex]);
            str.push(datay[i].cell[2]);
            str.push(datay[i].cell[0]);
            str.push(30);
            attr.push(str);
        }
        var myChart = echarts.init(document.getElementById('data0'));
        var option = dlchart.CreateCatterChart("", {x: tit[titIndex], y: "DRGs组患者数"},
            [{name: "", data: attr}], {
                grid: {
                    left: '3%',
                    right: '10%',
                    bottom: '3%',
                    containLabel: true
                },xAxis: {
                    nameLocation:'middle',
                    nameGap:17,
                }
            }, {
                index: 0, option: {
                    markLine: {
                        itemStyle: {
                            normal: {
                                lineStyle: {
                                    type: 'dashed'
                                }
                            }
                        },
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
                }
            }, 3);
        myChart.setOption(option);
    }


    $('#daochu').click(function () {
            //var tablehtml=$('#table tbody').html();
            //tableToExcel('table',tablehtml,'全省医疗服务质量指标的概览')
        var tableData = [];
        if("${userType}"!='机构'){
            tableData.push(["入组医疗机构总数："+$('#jg_td10').text()+"家","三级医院："+$('#jg_td0').text()+"家","其中：三级综合医院"+$('#jg_td1').text()+"家","三级专科医院"+$('#jg_td11').text()+"家","三级中医院"+$('#jg_td12').text()+"家","三级妇幼医院"+$('#jg_td13').text()+"家","甲等"+$('#jg_td2').text()+"家","乙等"+$('#jg_td3').text()+"家","未定等"+$('#jg_td4').text()+"家"]);
            tableData.push(["","二级医院："+$('#jg_td5').text()+"家","其中：二级综合医院"+$('#jg_td6').text()+"家","二级专科医院"+$('#jg_td14').text()+"家","二级中医院"+$('#jg_td15').text()+"家","二级妇幼医院"+$('#jg_td16').text()+"家","甲等"+$('#jg_td7').text()+"家","乙等"+$('#jg_td8').text()+"家","未定等"+$('#jg_td9').text()+"家"]);
        }
        tableData.push([$('#dt').text()]);
        tableData.push(["入组患者总人次："+$('#td0').text()+"人次","总医疗费用："+$('#td1').text()+"元","总住院日："+$('#td2').text()+"天","总权重数："+$('#td3').text(),"DRGs组数："+$('#td4').text()+"组","总死亡人数："+$('#td5').text()+"人"]);
        tableData.push(["总入组率："+$('#td16').text()+"%","人均住院费用："+$('#td6').text()+"元","平均住院日："+$('#td7').text()+"天","病例组合指数（CMI）："+$('#td8').text(),"手术率："+$('#td11').text(),"手术死亡率："+$('#td12').text()]);
        tableData.push(["","每权重费率："+$('#td9').text()+"元","住院患者死亡率："+$('#td13').text(),"药占比："+$('#td14').text()+"%","耗材比："+$('#td15').text()+"%"]);
        var excleJson = {excel:JSON.stringify(
            [
                {
                    name:'全省医疗服务质量指标的概览',
                    table:JSON.stringify(
                        [
                            {
                                data:JSON.stringify(tableData)
                            }
                        ]
                    )
                }
            ]
        )};

        ExcelDown(excleJson);
    });
    $('#daochu1').click(function () {
        var a = getBase64Image('data1');
        var b = getBase64Image('data2');
        var c = getBase64Image('data3');
        var d = getBase64Image('data4');
        var e = getBase64Image('data5');
        var excleJson = {excel:JSON.stringify(
            [
                {
                    img: JSON.stringify([a,b,c,d,e]),
                    table:JSON.stringify(
                        [
                            {
                                data:JSON.stringify([["DRGs组数",$('#ttd0').text()],["患者数",$('#ttd1').text()],["权重数",$('#ttd2').text()]])
                            },
                            {
                                data:JSON.stringify([["DRGs组数",$('#ttd3').text()],["患者数",$('#ttd4').text()],["权重数",$('#ttd5').text()]])
                            },
                            {
                                data:JSON.stringify([["DRGs组数",$('#ttd6').text()],["患者数",$('#ttd7').text()],["权重数",$('#ttd8').text()]])
                            },
                            {
                                data:JSON.stringify([["DRGs组数",$('#ttd12').text()],["患者数",$('#ttd13').text()],["权重数",$('#ttd14').text()]])
                            },
                            {
                                data:JSON.stringify([["DRGs组数",$('#ttd16').text()],["患者数",$('#ttd17').text()],["权重数",$('#ttd18').text()]])
                            }
                        ]
                    )
                }
            ]
        )};

        ExcelDown(excleJson);
    });
    $('#daochu2').click(function () {
       var canvasUrl = getBase64Image('data0');
        var options = $("#table0").bootstrapTable('getOptions');
        var excleJson = {excel:JSON.stringify(
            [
                {
                    img: JSON.stringify([canvasUrl]),
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
</script>
</body>
</html>
