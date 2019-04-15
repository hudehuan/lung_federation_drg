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
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/login-1.css">
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/tanchuan_hubei.css">
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/bootstrap-table.css" />
    <link rel="stylesheet" type="text/css" href="${ctx }/static/js/jquery-easyui-1.5/themes/default/easyui.css">
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/assets/examples.css" />
    <link rel="stylesheet" href="${ctx }/static/js/plugins/layer/skin/layer.css" />


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
<body style="height: 98%">
<div id="loading" class="loader">
    <img class="Rotation" src="${ctx}/static/img/load.png" width="32" height="32"/>
</div>
<div id="menu"  style="position:fixed;top: 10px;right: 20px;z-index:20000;font-size:12px;">
    <%--<div class="xian" style="height: 25px;"></div>--%>
    <%--<ul>--%>
        <%--<li><a href="#item1" class="current"><span></span>- -医疗机构专科能力排名</a></li>--%>
        <%--<li><a href="#item2"><span></span>- -医疗机构科目质量效率排名</a></li>--%>
    <%--</ul>--%>
</div>
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
        <li>
            <div class="center-back-cs">
                <input  style="width: 150px; height: 24px;border-radius:2px;cursor: pointer"
                        class="sj-ks" id="sj-ks" readonly="readonly" value="" type="text" placeholder="科室选择" />
                <%--<input  style="width: 150px; height: 24px;border-radius:2px;cursor: pointer"--%>
                        <%--class="sj-bz" id="sj-bz"  readonly="readonly" value="" type="text" placeholder="DRGs病组选择" />--%>
            </div>
        </li>

    </ul>
    <div class="top-btn" >查询</div>
</div>

<div class="main">

    <div style="text-align:center;" id ="divText">
        <span style="font-size: 20px;color: #00a0e9" id="hospital"></span>
        <span style="font-size: 20px;padding-left: 10px;">
            各专学科服务绩效排名汇总
        </span>
    </div>

    <div id="item1" class="man-c-2" style="padding-top: 0px;">
        <div class="bg-f" style="overflow: hidden;min-height:280px;">
            <div class="zhibiao-top back-zb">
                <b class="back-b">专学科服务绩效排名对比</b>
                <a href="###" id="daochu"  class="daochu">导出</a>
            </div>
            <div class="col-xs-6 zhibiao2" style="width: 100%;"  id="tabx4">
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
        <div class="bg-f" style="overflow: hidden;min-height:280px;">
            <div class="zhibiao-top back-zb">
                <b class="back-b">机构各专业服务绩效指标分析</b>
                <a href="###" id="daochu1"  class="daochu">导出</a>
            </div>
            <div class="col-xs-6 zhibiao2" style="width: 100%;"  id="tabx5">
                <div  class="biaoge-yqst table-responsive" style="margin-top: 15px;">
                    <table id="table2" class="table" style="font-size: 12px;">
                        <thead id="thead2">
                        <tr>
                        </tr>
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
<script type="text/javascript" src="${ctx}/static/js/echarts.min.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/macarons.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/dlchart.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/jsonpData.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/layuiData.js?v=5" ></script>
<script type="text/javascript" src="${ctx }/static/js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctx }/static/js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${ctx }/static/js/export.js"></script>
<script>
    $(function () {
        hubeiCon.hospitalCon('sj-bz');
    });
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
    var mdctj = '@novalue|';
    $("body").delegate("tbody a","click",function(){
        var kemu = $(this).text();
        var hospital = $("#hospital").text();
        var year = $("#rq").val();
        var rqkj = $("#rqkj").val();
        var height = parent.findDimensions_height();
        var width = parent.findDimensions_width();
        parent.layeropen(width*0.95,height*0.9,"","/hubei/V_DrgsDoctorData/toDoctorData?hospital="+hospital+"&rqkj="+rqkj+"&year="+year+"&kemu="+kemu+"&mdctj="+mdctj+"&yhqx=${yhqx}");
//        loadHospitalDat(hospital,year);
    })
    //获取屏幕的高
    var H= 0;
    var biIds =['2578f351-4e31-4968-8665-e00c7c9e19ea','42b8560f-2aa7-4b04-b282-11ac8c3e5e90','2df93abc-85c3-4fc4-9c7a-0afdf719dcae'];//报表id
    var biKeys =[];//报表返回softkey
    var flag = true;
    var mdctj;
    $(function () {
        var date = new Date;
        var year=date.getFullYear();
        if("${mdctj}"){
            mdctj="${mdctj}";
        }
        $("#rq").val(year);
        if("${hospital}"){
            $("#hospital").text("${hospital}");
            $("#rqkj").val("${rqkj}");
            $("#rq").val("${year}");
            biIds[0] = "1b359425-ee43-43c1-b5c3-779e9b26af76";

        }else{
            $("#top-demand").show();
            $("#menu").show();
            H=$('#top-demand').height();
            $('#divText').css('padding-top',H+'px');
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
        var loads=2;
        if("${userType}"!='机构'){
            $('#daochu').show();
            $('#daochu1').show();
        }
        mdctj = '@novalue|';
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
        var cxsj = hubeiCon.getTimeStr();
        var cxtj0 = cxsj+ "|";
        if("${hospital}"){
            cxtj0 = "${hospital}|"+cxtj0;
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
                if(!"${hospital}"){
                    $("#hospital").text(data.rows.row[0].cell[1]);
                }
                var cxtj0 = cxsj+"|"+data.rows.row[0].cell[0]+"|"+mdctj;;
                var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
                    '&biyccs=&id=' +biKeys[1].id+'&softkey='+biKeys[1].softkey +
                    '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=';
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
                var cxtj1 = cxsj+"|"+data.rows.row[0].cell[0]+"|"+mdctj;
                var url1 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
                    '&biyccs=&id=' +biKeys[2].id+'&softkey='+biKeys[2].softkey +
                    '&cxtj='+escape(cxtj1)+'&topdata=&timew=&weiplan=';
                $.ajax({
                    type:"GET",
                    url:url1,
                    dataType: "jsonp",
                    success:function(data0){
                        loads=loads-1;
                        test(loads);
                        data0 = jsonpDataInit(data0);
                        setData1(data0)
                    }
                });
         }
         });
    }
var sj1;
    function setData0(data) {
        sj1 = data;
        var height = $("body").height();
        var dataIndex = [];
        var tableData = initLayuiTableData(data,dataIndex,140,120);//jsop数据格式化为layuiTable数据格式
        layui.use('table', function() {
            var table = layui.table;
            //方法级渲染
            window.demoTable = table.render({
                elem: '#table1',
                data: tableData.data,
                height: 218,
                cols: [tableData.cols],
                skin: 'row', //表格风格
                even: true,
//                page: true, //是否显示分页
//                limits: [6, tableData.data.length],
                limit: 200, //每页默认显示的数量
            });
        });
    }
var sj2;
    function setData1(data) {
        sj2 =data;
        var height = $("body").height();
        var dataIndex = [];
        var tableData = initLayuiTableData(data,dataIndex,140,120);//jsop数据格式化为layuiTable数据格式
        if("${userType}"!='机构'){
            for(var i=0; i<tableData.data.length; i++){
                tableData.data[i].td0 = "<a>"+tableData.data[i].td0+"</a>"
            }
        }
        layui.use('table', function() {
            var table = layui.table;
            //方法级渲染
            window.demoTable = table.render({
                elem: '#table2',
                data: tableData.data,
                height: 218,
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

        var hos=$('#hospital').text();
        var data=[];
        data.push(sj1.title.column.split(','));
        for(var i=0;i<sj1.rows.row.length;i++){
            data.push(sj1.rows.row[i].cell)
        }
        var excleJson = {excel:JSON.stringify(
            [
                {
                    name:hos+'专学科服务绩效排名对比',
                    table:JSON.stringify(
                        [
                            {
                                data:JSON.stringify(data)
                            }
                        ]
                    )
                }
            ]
        )};
        ExcelDown(excleJson);
    });
    $('#daochu1').click(function () {
        var data=[];
        data.push(sj2.title.column.split(','));
        for(var i=0;i<sj2.rows.row.length;i++){
            data.push(sj2.rows.row[i].cell)
        }
        var hos=$('#hospital').text();
        var excleJson = {excel:JSON.stringify(
            [
                {
                    name:hos+'机构各专业服务绩效指标分析',
                    table:JSON.stringify(
                        [
                            {
                                data:JSON.stringify(data)
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
