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
<body>
<div style="position: absolute;background: #000;width: 100%;height: 100%;z-index: 10000;opacity: 0.5;">
    <p style="color: #fff;margin-top: 200px;text-align: center;font-size: 26px;">该用户无权使用</p>
</div>
<%--<div id="loading" class="loader">--%>
    <%--<img class="Rotation" src="${ctx}/static/img/load.png" width="32" height="32"/>--%>
<%--</div>--%>
<%--<div id="menu"  style="position:fixed;top: 10px;right: 20px;z-index:20000;font-size:12px;">--%>
    <%--<div class="xian" style="height: 25px;"></div>--%>
    <%--<ul>--%>
        <%--<li><a href="#item1" class="current"><span></span>- -每权重盈亏额</a></li>--%>
        <%--<li><a href="#item2"><span></span>- -各机构付费整体盈亏情况</a></li>--%>
    <%--</ul>--%>
<%--</div>--%>
<%--<div class="top-demand" id="top-demand" style="top: 0;">--%>
    <%--<ul>--%>
        <%--<li>--%>
            <%--<label>日期：</label>--%>
            <%--<select id="rqkj" disabled style="width: 60px;height: 24px;border-radius:2px;border: 1px solid #ddd">--%>
                <%--<option value="n">年</option>--%>
                <%--<option value="j">季</option>--%>
                <%--<option value="y">月</option>--%>
            <%--</select>--%>
            <%--&lt;%&ndash;<input type="text" />&ndash;%&gt;--%>
            <%--<input type="text" class="Wdate " id="rq" style="width: 80px;height: 24px;vertical-align: middle;margin-bottom: 3px;border-radius:2px;border: 1px solid #ddd"--%>
                   <%--onfocus="WdatePicker({el:'rq',startDate:'%y',dateFmt:'yyyy',alwaysUseStartDate:true,maxDate:'%y'})">--%>

        <%--</li>--%>
        <%--<li>--%>
            <%--<div class="center-back-cs">--%>
                <%--<input hidden style="width: 150px; height: 24px;border-radius:2px;cursor: pointer" class="sj-pt"--%>
                       <%--id="sj-pt" readonly="readonly" value="" type="text" placeholder="平台机构选择"/>--%>
                <%--<input hidden style="width: 150px; height: 24px;border-radius:2px;cursor: pointer" class="sj-jb"--%>
                       <%--id="sj-jb" readonly="readonly" value="" type="text" placeholder="平台机构选择"/>--%>
            <%--</div>--%>
        <%--</li>--%>

    <%--</ul>--%>
    <%--<div class="top-btn">查询</div>--%>
<%--</div>--%>

<%--<div class="main">--%>
    <%--<div id="item1" class="man-c-2" style="padding-top: 46px;">--%>
        <%--<div class="bg-f" style="overflow: hidden;height:auto">--%>
            <%--<div class="zhibiao-top back-zb">--%>
                <%--<b class="back-b zbmca">每权重盈亏额</b>--%>
            <%--</div>--%>
            <%--<div class="zhibiao2" id="data0" style="height:350px;"></div>--%>
        <%--</div>--%>
    <%--</div>--%>
    <%--<div id="item2" class="man-c-2">--%>
        <%--<div class="bg-f" style="overflow: hidden;height:auto">--%>
            <%--<div class="zhibiao-top back-zb">--%>
                <%--<b class="back-b">各机构付费整体盈亏情况</b>--%>
            <%--</div>--%>
            <%--<div class="col-xs-6 zhibiao2" style="width: 100%;"  id="tabx5">--%>
                <%--<div  class="biaoge-yqst table-responsive" style="margin-top: 15px;">--%>
                    <%--<table class="table" id="table1" style="font-size: 12px;">--%>
                        <%--<thead id="thead1">--%>
                        <%--</thead>--%>
                    <%--</table>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>
<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/bootstrap.min.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/bootstrap-table.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/extensions/toolbar/bootstrap-table-toolbar.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/ga.js" ></script>


<script type="text/javascript" src="${ctx}/static/js/echarts.min.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/macarons.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/dlchart.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/jsonpData.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/layuiData.js" ></script>

<script>
    $(function () {
        hubeiCon.initCon('sj-pt','sj-jb');
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
        var year = $("#rq").val();
        var height = parent.findDimensions_height();
        var width = parent.findDimensions_width();
        parent.layeropen(width*0.95,height*0.9,"","/hubei/V_Drgs1104/toList?hospital="+hospital+"&year="+year);
    })
    //获取屏幕的高
    var H= 0;
    var loads=0;
    var biIds =['2a8c3a3c-cd5a-4de5-8cc9-778d9cf720a4'];//报表id
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
                //search()
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

    function search(stats) {
        $("#loading").show();
        var bivar = "";
        $(".center-back-cs").find("input").each(function(){
            if($(this).css("display")!='none'){
                bivar=$(this).val();
                return false;
            }
        })
        if(bivar == "全省"){
            bivar = "@novalue|@novalue|@novalue|";
        }else {
            bivar = bivar.replace("全省","@novalue");
            if(bivar.indexOf("二级")>-1||bivar.indexOf("三级")>-1){
                bivar = bivar.replace("二级","|二级|");
                bivar = bivar.replace("三级","|三级|");
                if(bivar.indexOf("全部")>-1){
                    bivar = bivar.replace("全部","@novalue")
                }
                bivar += "|";
            }else{
                bivar = bivar.replace("全部","|@novalue|@novalue|");
            }
        }
        var srq = $("#rq").val()+"-01-01";
        var erq = $("#rq").val()+"-12-31";
        var cxtj0 = srq+";"+erq+"|";
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
                data = jsonpDataInit(data);
                setData0(data);
                setData1(data);
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
        var option=dlchart.CreateCatterChart("",{x:"权重数",y:"每权重盈亏额"},[{name:"医疗机构",data:attr}],
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
            }},1);

        myChart.setOption(option);
    }

    function setData1(data) {
        var dataIndex = [0,1,2,3,4,5];
        var tableData = initBootstrapTableData(data,dataIndex);//jsop数据格式化为layuiTable数据格式
        for(var i=0;i<tableData.data.length;i++){
            tableData.data[i].td0 = "<a>"+tableData.data[i].td0+"</a>";
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

</script>
</body>
</html>
