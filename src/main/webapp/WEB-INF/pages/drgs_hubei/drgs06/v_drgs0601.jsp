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
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/login-1.css">
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/tanchuan_hubei.css">
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/assets/examples.css" />
    <link rel="stylesheet" href="${ctx }/static/js/plugins/layer/skin/layer.css" />
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
<%--<div id="menu"  style="position:fixed;top: 10px;right: 20px;z-index:20000;font-size:12px;">--%>
    <%--<div class="xian" style="height: 45px;"></div>--%>
    <%--<ul>--%>
        <%--<li><a href="#item1" class="current"><span></span>- -医疗服务能力示意图</a></li>--%>
        <%--<li><a href="#item2"><span></span>- -医疗服务能力评分排名</a></li>--%>
        <%--<li><a href="#item3"><span></span>- -医疗服务能力情况</a></li>--%>
    <%--</ul>--%>
<%--</div>--%>
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
            <input type="text" class="Wdate " id="rq" style="width: 80px;height: 24px;vertical-align: middle;margin-bottom: 3px;border-radius:2px;border: 1px solid #ddd"
                   onfocus="WdatePicker({el:'rq',startDate:'%y',dateFmt:'yyyy',alwaysUseStartDate:true,maxDate:'%y'})">

        </li>
        <li>
            <div class="center-back-cs">
                <input hidden style="width: 150px; height: 24px;border-radius:2px;cursor: pointer" class="sj-pt"
                       id="sj-pt" readonly="readonly" value="" type="text" placeholder="平台机构选择"/>
                <input hidden style="width: 150px; height: 24px;border-radius:2px;cursor: pointer" class="sj-jb"
                       id="sj-jb" readonly="readonly" value="" type="text" placeholder="平台机构选择"/>
                <input  style="width: 150px; height: 24px;border-radius:2px;cursor: pointer"
                        class="sj-bz" id="sj-bz"  readonly="readonly" value="" type="text" placeholder="DRGs病组选择" />
            </div>
        </li>

    </ul>
    <div class="top-btn">查询</div>
</div>

<div class="main">
    <div id="item1" class="man-c-2" style="padding-top: 46px;">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b zbmca">医疗服务能力示意图</b>
                <a href="###" id="daochu"  class="daochu">导出</a>
                <a href="###" id="daochuimg1" style="display: none;">导出</a>
            </div>
            <div class="zhibiao2" id="data0" style="height:350px;"></div>
        </div>
    </div>
    <div id="item2" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">医疗服务能力评分排名</b>
                <a href="###" id="daochu1"  class="daochu">导出</a>
            </div>
            <div class="col-xs-6 zhibiao2" style="width: 100%;" >
                <div  class="biaoge-yqst table-responsive" style="margin-top: 15px;">
                    <table class="table" id="table1" style="font-size: 12px;">
                        <thead id="thead1">
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div id="item3" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">医疗服务能力情况</b>
                <a href="###" id="daochu2"  class="daochu">导出</a>
                <a href="###" id="daochuimg2" style="display: none;">导出</a>
            </div>
            <div class="zhibiao2 table-div" id="data2" style="text-align: left;height:260px; " >

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
        hubeiCon.initCon('sj-pt');
        hubeiCon.hospitalCon('sj-bz');
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
    $("body").delegate("tbody a","click",function(){
        var hospital = $(this).text();
        var  rqkj = 'n';//$("#rqkj").val();
        var year = $("#rq").val().substring(0,4);
        var height = parent.findDimensions_height();
        var width = parent.findDimensions_width();
        var yhqx=parent.userType;
        parent.layeropen(width*0.95,height*0.9,"","/hubei/V_DrgsJgData/toJgData?hospital="+hospital+"&year="+year+"&mdctj="+escape(escape(mdctj))+"&rqkj="+rqkj+"&yhqx="+yhqx);
    });
    //获取屏幕的高
    var H= 0;
    var loads =0;
    var biIds =['8e9d2a49-833a-40fb-bc08-b97e26ec4857','ee031cea-2d0a-4bef-b4aa-e4b64d7668c7'];//报表id
    var biKeys =[];//报表返回softkey
    var flag = true;
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
                scrollTop: $($.attr(this, 'href')).offset().top-100
            }, 500);
            return false;
        });
        H=$('#top-demand').height();
        $('.main-center').css('padding-top',H+'px');

        $.ajax({
            type:"POST",
            url:"/HBI/loadBiKsy?biIds="+biIds,
            dataType: "json",
            success:function(data){
                biKeys =data;
                search()
            }
        });

        var date = new Date;
        var year=date.getFullYear();
        $("#rq").val(year);
        $('.top-btn').click(function () {
            flag=false;
            search();
        })
    })

    var mdctj;
    function search(stats) {
        $("#loading").show();
        var bivar = "";
        $(".center-back-cs").find("input").each(function(){
            if($(this).css("display")!='none'){
                bivar=$(this).val();
                return false;
            }
        })
        //查询条件
        bivar = $('#sj-pt').val();
        if(bivar == "全国"){
            bivar = "@novalue|@novalue|@novalue|";
        }else {

            bivar +="|@novalue|@novalue|";

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
        var cxtj0 = cxsj+ "|"+mdctj;
        loads++;
        var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+escape(escape(bivar))+
            '&biyccs=&id=' +biKeys[0].id+'&softkey='+biKeys[0].softkey +
            '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=';
        $.ajax({
            type:"GET",
            url:url0,
            dataType: "jsonp",
            success:function(data){
                loads--;
                test(loads);
                data = jsonpDataInit(data);  //jsonp数据格式化
                setData0(data);
                setData1(data);
            }
        });
        loads++;
        var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+escape(escape(bivar))+
            '&biyccs=&id=' +biKeys[1].id+'&softkey='+biKeys[1].softkey +
            '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=';
        $.ajax({
            type:"GET",
            url:url0,
            dataType: "jsonp",
            success:function(data){
                loads--;
                test(loads);
                data = jsonpDataInit(data);  //jsonp数据格式化
                setData2(data);
            }
        });
    }

    function setData0(data) {
        var attr =[];
        var datay=data.rows.row;
        for(var i =0;i<datay.length;i++){
            var str=[];
            str.push(datay[i].cell[2]);
            str.push(datay[i].cell[4]);
            str.push(datay[i].cell[0]);
            str.push(30);
            attr.push(str);
        }
        var myChart = echarts.init(document.getElementById('data0'));
        var option=dlchart.CreateCatterChart("",{x:"DRGs组数",y:"CMI值"},[{name:"机构医疗服务能力示意图",data:attr}],
            {grid: {
                left: '3%',
                right: '8%',
                bottom: '3%',
                containLabel: true
            }},{index:0,option:{
                label: {
                    emphasis: {
                        show: true,
                        formatter: function (param) {
                            return param.data[2];
                        },
                        position: 'top'
                    }
                }
            }},2);

        myChart.setOption(option);
    }

    function setData1(data) {
        var dataIndex = [0,1,2,3,4,5,6,7];
        var tableData = initBootstrapTableData(data,dataIndex);//jsop数据格式化为layuiTable数据格式
        for(var i=0; i<tableData.data.length; i++){
            for(var j=i; j<tableData.data.length; j++){
                if(Number(tableData.data[i].td7)>Number(tableData.data[j].td7)){
                    var jsonStr = tableData.data[i];
                    tableData.data[i] = tableData.data[j];
                    tableData.data[j] = jsonStr;
                }
            }
            tableData.data[i].td0 = "<a>"+tableData.data[i].td0+"</a>"
        }
        tableData.data.sort(compare("td6"));
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

    function setData2(data){
        for(var i=0;i<data.rows.row.length-1;i++){
            for(var j=i;j<data.rows.row.length;j++){
                if(Number(data.rows.row[i].cell[27])<Number(data.rows.row[j].cell[27])){
                    var jsonStr = data.rows.row[i];
                    data.rows.row[i] = data.rows.row[j]
                    data.rows.row[j] = jsonStr;
                }
            }
        }
        var colors =  ['#FFFFFF', '#d88273', '#bf444c'];
        var text=data.title.reportmc;
        var datax=data.title.column.split(',');

        var rows=data.rows.row;
        var data2=[],datay=[];
        datax=datax.slice(1);

        $(rows).each(function(index,obj){
            datay.push(obj.cell[0]);//医院名
            $(datax).each(function(i,o){
                var d=[index,i,obj.cell[i+1],obj.cell[0],o];
                data2.push(d);
            })

        })
        var height = datay.length*20;
        $("#data2").height(height+100>260?height+100:260);
        var myChart = echarts.init(document.getElementById('data2'));

        data2 = data2.map(function (item) {
            return [item[1], item[0], item[2], item[3], item[4], item[2] || '-'];
        });

        var option =dlchart.CreateHeatMapChart("",{x:datax,y:datay,data:data2},{ tooltip: {
            formatter: function (params, ticket, callback) {
                return params.value[4] + "-" + params.value[3] + ":" + params.value[5];
            }
        }, series:[{label: {
                normal: { show: true  } }
            }],
            visualMap :{ color:colors,},
            grid: {
                height: height,
                y: 50,
                x:164
            },
            xAxis: {
                position:'top'}},40);
        myChart.setOption(option);
    }
    function compare(property) {
        return function(a, b) {
            var value1 = parseInt(a[property]);
            var value2 = parseInt(b[property]);
            return value1<value2?-1:1;
        }
    }
    var n=0;
    $('#daochu').click(function () {
        var a = getBase64Image('data0');
        var excleJson = {excel:JSON.stringify(
            [
                {
                    name:"医疗服务能力示意图",
                    img:JSON.stringify([a])
                }
            ]
        )};

        ExcelDown(excleJson);
//        getFullCanvasDataURL('data0','daochuimg1',n+'医疗服务能力示意图.png');
//        var tablehtml='<tr><td colspan="8" style="width: 1139px;height: 450px;"><img src="'+n+'医疗服务能力示意图.png"></td></tr>'
//        tableToExcel('table',tablehtml,'医疗服务能力示意图');
    });
    $('#daochu1').click(function () {
        var options = $("#table1").bootstrapTable('getOptions');
        var excleJson = {excel:JSON.stringify(
            [
                {
                    name:"医疗服务能力评分排名",
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
//        var tablehtml=$('#table1 thead').html()+$('#table1 tbody').html();
//        tableToExcel('table',tablehtml,'医疗服务能力评分排名');
    });
    $('#daochu2').click(function () {
        var a = getBase64Image('data2');
        var excleJson = {excel:JSON.stringify(
            [
                {
                    name:"医疗服务能力情况",
                    img:JSON.stringify([a])
                }
            ]
        )};
        ExcelDown(excleJson);
//        n++
//        getFullCanvasDataURL('data2','daochuimg2',n+'医疗服务能力情况.png');
//        var tablehtml='<tr><td colspan="8" style="width: 1139px;height: 1140px;"><img src="'+n+'医疗服务能力情况.png"></td></tr>'
//        tableToExcel('table',tablehtml,'医疗服务能力情况');
    });
</script>
</body>
</html>
