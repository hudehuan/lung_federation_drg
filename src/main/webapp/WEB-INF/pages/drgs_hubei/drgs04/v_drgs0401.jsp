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
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/my97DatePicker/WdatePicker.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/plugins/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/layui/layui.js"></script>
    <title></title>
    <style>
        body{overflow-y:auto;}

    </style>
</head>
<body>
<div id="loading" class="loader"></div>
<div id="menu"  style="position:fixed;top: 10px;right: 20px;z-index:20000;font-size:12px;">
    <div class="xian" style="height: 25px;"></div>
    <ul>
        <li><a href="#item1" class="current"><span></span>- -费用趋势</a></li>
        <li><a href="#item2"><span></span>- -费用一览</a></li>
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
            <input type="text" class="Wdate " id="rq" style="width: 80px;height: 24px;vertical-align: middle;margin-bottom: 3px;border-radius:2px;border: 1px solid #ddd"
                   onfocus="WdatePicker({el:'rq',startDate:'%y',dateFmt:'yyyy',alwaysUseStartDate:true,maxDate:'%y'})">

        </li>
        <li>
            <label>医院级别：</label>
            <select id="yyjb"  style="width: 100px;height: 24px;border-radius:2px;border: 1px solid #ddd">
                <option value="@novalue">全部</option>
                <option value="三级">三级</option>
                <option value="二级">二级</option>
            </select>
        </li>

    </ul>
    <div class="top-btn">查询</div>
</div>

<div class="main">
    <div id="item1" class="man-c-2" style="padding-top: 46px;">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b zbmca">费用趋势</b>
            </div>
            <div class="zhibiao2" id="data0" style="height:350px;"></div>
        </div>
    </div>
    <div id="item2" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;min-height:160px;">
            <div class="zhibiao-top back-zb">
                <b class="back-b">费用一览</b>
            </div>
            <div style="float: left;width: 40%;margin-top: 15px;min-height:350px;" id="zhibiao1">
            </div>
            <div class="col-xs-6 zhibiao2" style="width: 60%;"  id="tabx5">
                <div  class="table-responsive" style="margin-top: 15px;">
                    <table id="table1" style="width: 100%;"></table>
                </div>
            </div>
        </div>
    </div>
</div>



<script type="text/javascript" src="${ctx}/static/js/echarts.min.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/macarons.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/dlchart.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/jsonpData.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/layuiData.js" ></script>

<script>
    //获取屏幕的高
    var H= 0;
    var biIds =[];//报表id
    var biKeys =[];//报表返回softkey

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
        $("#loading").fadeOut("slow");
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
    })

    function search(stats) {
        if(stats){
            flag = true;
        }else {
            flag = false;
        }
//        data = jsonpDataInit(data);  //jsonp数据格式化
        setData0(jsonpTestData);
        setData1(jsonpTitlesData);
        setData2(jsonpTitlesData);
        /*var day = date.getDate();
         var srq = $("#srq").val()+"-01";
         var erq = $("#erq").val()+"-"+day;
         var yyjb = $("#yyjb").val();
         //费用增幅与机构动因 （费用动因分析）
         var cxtj0 = srq+";"+erq+"|"+yyjb+"|@novalue|";
         var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
         '&biyccs=&id=' +biKeys[0].id+'&softkey='+biKeys[0].softkey +
         '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=';
         $.ajax({
         type:"GET",
         url:url0,
         dataType: "jsonp",
         success:function(data){
         data1 = data;
         setData0_1(data);
         //                setData0(data);
         setData3(data);
         }
         });*/
    }

    function setData0(data) {
        var attr =[];
        var datay=data.rows.row;
        for(var i =0;i<datay.length;i++){
            var str=[];
            str.push(datay[i].cell[6]);
            str.push(datay[i].cell[5]);
            str.push(datay[i].cell[0]);
            str.push(30);
            attr.push(str);
        }
        var myChart = echarts.init(document.getElementById('data0'));
        var option=dlchart.CreateLineChart('',['一','二','三','四'],[{name:"总费用",data:[1,2,3,5]},{name:"门诊费用",data:[2,3,4,5]},{name:"住院费用",data:[2,2,5,8]}])
        myChart.setOption(option);
    }
    function setData2(data) {
        var attr =[];
        var datay=data.rows.row;
        for(var i =0;i<datay.length;i++){
            var str=[];
            str.push(datay[i].cell[6]);
            str.push(datay[i].cell[5]);
            str.push(datay[i].cell[0]);
            str.push(30);
            attr.push(str);
        }
        var myChart = echarts.init(document.getElementById('zhibiao1'));
        var option=dlchart.CreatePieChart('三级机构住院费用',['武汉','黄石','十堰'],[{name:"住院费用",data:[{name:"武汉",value:1},{name:"黄石",value:1},{name:"十堰",value:1}]}])
        myChart.setOption(option);
    }
    function setData1(data) {
        var width = $("#table1").width();
        var col1 = [ //标题栏
            {field: 'td0', title: '医院名称',width: 124, rowspan: 2} //rowspan即纵向跨越的单元格数
            ,{align: 'center', title: '费用',  colspan: 4}
            ,{align: 'center', title: '住院', colspan: 4} //colspan即横跨的单元格数，这种情况下不用设置field和width
        ];


        var dataIndex = [0,1,2,3,4,5,6,7,8];
        var tableData = initLayuiTableData(data,dataIndex,width);//jsop数据格式化为layuiTable数据格式

        layui.use('table', function() {
            var table = layui.table;

            //方法级渲染
            window.demoTable = table.render({
                elem: '#table1',
                data: tableData.data,
                height:365,
                cols: [col1,tableData.cols],
                skin: 'row', //表格风格
                even: true,
                page: true, //是否显示分页
                limits: [10, tableData.data.length],
                limit: 10, //每页默认显示的数量
            });
        });
    }

</script>
</body>
</html>
