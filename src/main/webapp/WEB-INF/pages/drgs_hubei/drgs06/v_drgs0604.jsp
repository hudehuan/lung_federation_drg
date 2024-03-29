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
<body style="height: 98%">
<div id="loading" class="loader">
    <img class="Rotation" src="${ctx}/static/img/load.png" width="32" height="32"/>
</div>
<div id="menu"  style="position:fixed;top: 10px;right: 20px;z-index:20000;font-size:12px;">
    <%--<div class="xian" style="height: 25px;"></div>--%>
    <%--<ul>--%>
    <%--<li><a href="#item1" class="current"><span></span>- -每权重盈亏额</a></li>--%>
    <%--<li><a href="#item2"><span></span>- -医院各学科费用占比</a></li>--%>
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
                <b class="back-b">医疗绩效综合排名表</b>
                <a href="###" id="daochu"  class="daochu">导出</a>
            </div>
            <div class=" zhibiao2" style="width: 100%;" >
                <div  class="biaoge-yqst table-responsive" style="margin-top: 15px;">
                    <table id="table0" style="width: 100%"></table>
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
    var  sj;
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
    var loads=0;
    var biIds =['33f19ab2-0843-42dc-bcee-61bb4ebbf49c'];//报表id
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

    var  mdctj;
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
                loads--
                data = jsonpDataInit(data);
                setData0(data);
                test(loads);

            }
        });
    }

    function setData0(data) {
        sj=data;
        var height = $("body").height()-130;
        var width = $("#table0").width();
        var dataIndex = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22];
        //var tableData = initBootstrapTableData(data,dataIndex);
        var tableData = initLayuiTableData(data,dataIndex,width);//jsop数据格式化为layuiTable数据格式
        for(var i=0; i<tableData.data.length; i++){
            for(var j=i; j<tableData.data.length; j++){
                if(Number(tableData.data[i].td22)>Number(tableData.data[j].td22)){
                    var jsonStr = tableData.data[i];
                    tableData.data[i] = tableData.data[j];
                    tableData.data[j] = jsonStr;
                }
            }
            tableData.data[i].td0 = "<a>"+tableData.data[i].td0+"</a>";
            if(tableData.data[i].td6=='0.00')
            {
                tableData.data[i].td6='--'
            }
            if(tableData.data[i].td7=='0.0000'||tableData.data[i].td7=='0.00')
            {
                tableData.data[i].td7='--'
            }
            if(tableData.data[i].td8=='0.0000'||tableData.data[i].td8=='0.00')
            {
                tableData.data[i].td8='--'
            }
            if(tableData.data[i].td9=='0.0000'||tableData.data[i].td9=='0.00')
            {
                tableData.data[i].td9='--'
            }
            if(tableData.data[i].td10=='0.0000'||tableData.data[i].td9=='0.00')
            {
                tableData.data[i].td10='--'
            }
            if(tableData.data[i].td11=='0.0000')
            {
                tableData.data[i].td11='--'
            }
        }
        //tableData.data.sort(compare("td22"));
        layui.use('table', function() {
            var table = layui.table;
            //方法级渲染
            window.demoTable = table.render({
                elem: '#table0',
                data: tableData.data,
                height: height,
                cols: [[{field: "td0", title: "医院名称", width: 140,sort: true, fixed: 'left'},
                    {field: "td1", title: "入组患者人数", width: 90,sort: true, align: "center"},
                    {field: "td2", title: "DRG组数", width: 90,sort: true, align: "center"},
                    {field: "td3", title: "权重", width: 90,sort: true, align: "center"},
                    {field: "td4", title: "标化CMI", width: 90,sort: true, align: "center"},
                    {field: "td5", title: "死亡人数", width: 90,sort: true, align: "center"},
                    {field: "td6", title: "粗死亡率", width: 90,sort: true, align: "center"},
                    {field: "td7", title: "低风险死亡率", width: 90,sort: true, align: "center"},
                    {field: "td8", title: "中低风险死亡率", width: 90,sort: true, align: "center"},
                    {field: "td9", title: "中高风险死亡率", width: 90,sort: true, align: "center"},
                    {field: "td10", title: "高风险死亡率", width: 90,sort: true, align: "center"},
                    {field: "td11", title: "标化死亡率", width: 90,sort: true, align: "center"},
                    {field: "td12", title: "时间消耗指数", width: 90,sort: true, align: "center"},
                    {field: "td13", title: "费用消耗指数", width: 90,sort: true, align: "center"},
                    {field: "td14", title: "CMI床日费用", width: 90,sort: true, align: "center"},
                    {field: "td15", title: "每权重消耗时间", width: 90,sort: true, align: "center"},
                    {field: "td16", title: "能力综合得分", width: 90,sort: true, align: "center"},
                    {field: "td17", title: "质量综合得分", width: 90,sort: true, align: "center"},
                    {field: "td18", title: "效率综合得分", width: 90,sort: true, align: "center"},
                    {field: "td19", title: "能力秩次", width: 90,sort: true, align: "center"},
                    {field: "td20", title: "质量秩次", width: 90,sort: true, align: "center"},
                    {field: "td21", title: "效率秩次", width: 90,sort: true, align: "center"},
                    {field: "td22", title: "排名", width: 90,sort: true, align: "center"}]],
                skin: 'row', //表格风格
                even: true,
//                page: true, //是否显示分页
//                limits: [6, tableData.data.length],
                limit: tableData.data.length, //每页默认显示的数量
            });
        });
    }
    function compare(property) {
        return function(a, b) {
            var value1 = parseInt(a[property]);
            var value2 = parseInt(b[property]);
            return value1<value2?-1:1;
        }
    }
    $('#daochu').click(function () {
        /*var tablehtml=$('.layui-table thead').html()+$('.layui-table-main tbody').html();
        tableToExcel('table',tablehtml,'区域医疗服务绩效综合评价');*/
        //laytable-cell-2-td0
        var data=[];
        data.push(sj.title.column.split(','));
        for(var i=0;i<sj.rows.row.length;i++){
            data.push(sj.rows.row[i].cell)
        }
        var excleJson = {excel:JSON.stringify(
            [
                {
                    name:'医疗服务绩效综合评价',
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
