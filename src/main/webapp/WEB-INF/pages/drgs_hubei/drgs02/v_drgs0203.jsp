<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/08/10
  Time: 17:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <meta charset="utf-8" />
    <meta name="format-detection" content="telephone=no,email=no,address=no">
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <link rel="stylesheet" href="${ctx }/static/css/base.css" />
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/login-1.css">
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/tanchuan_hubei.css">
    <%--<link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/css/bootstrap.css" />--%>
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/bootstrap-table.css" />
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/assets/examples.css" />
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${ctx }/static/css/my-stlye.css" />
    <link rel="stylesheet" href="${ctx }/static/js/plugins/layer/skin/layer.css" />
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/my97DatePicker/WdatePicker.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/plugins/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/hubeiCon.js" ></script>
    <title>首页</title>
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
<div id="menu"  style="position:fixed;top: 10px;right: 20px;z-index:20000;font-size:12px;">
    <div class="xian" style="height:130px"></div>
    <ul>
        <li><a href="#item1" class="current"><span></span>- -医疗质量情况分析</a></li>
        <li><a href="#item2"><span></span>- -出院人数</a></li>
        <li><a href="#item3"><span></span>- -死亡人数</a></li>
        <li><a href="#item4"><span></span>- -低风险死亡</a></li>
        <li><a href="#item5"><span></span>- -术后死亡</a></li>
        <li><a href="#item6"><span></span>- -新生儿死亡</a></li>
        <li><a href="#item7"><span></span>- -中低风险死亡</a></li>
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
            <div class="center-back-cs">
                <input hidden style="width: 150px; height: 24px;border-radius:2px;cursor: pointer" class="sj-pt" id="sj-pt" readonly="readonly" value="" type="text" placeholder="平台机构选择" />
                <input hidden style="width: 150px; height: 24px;border-radius:2px;cursor: pointer" class="sj-jb" id="sj-jb"  readonly="readonly" value="" type="text" placeholder="平台机构选择" />
            </div>

        </li>

    </ul>
    <div class="top-btn">查询</div>
</div>
<div class="main">
    <div id="item1" class="man-c-2" style="padding-top: 46px;">
        <div class="bg-f" style="overflow: hidden;min-height:315px;">
            <div class="zhibiao-top back-zb">
                <b class="back-b">医疗质量情况分析</b>
            </div>
            <div class="col-xs-6 zhibiao2" style="min-height: 130px;width: 100%;" id="tabx1">
                <%--<p class="tit-zhibiao">州市数据</p>--%>
                <div  class="biaoge-yqst table-responsive" style="margin-top: 15px;">
                    <table id="table"  class="table">
                        <thead id="thead1">

                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div  id="item2" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">出院人数</b>
            </div>
            <div class="zhibiao2" id="chart-aqyqst1" style="height:350px;"></div>
        </div>
    </div>

    <div id="item3" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">死亡人数</b>
            </div>
            <div class="zhibiao2" id="chart-aqyqst2" style="height:350px;"></div>
        </div>
    </div>

    <div id="item4" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">低风险死亡</b>
            </div>
            <div class="zhibiao2" id="chart-aqyqst3" style="height:350px;"></div>
        </div>
    </div>

    <div id="item5" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">术后死亡</b>
            </div>
            <div class="zhibiao2" id="chart-aqyqst4" style="height:350px;"></div>
        </div>
    </div>

    <div id="item6" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">新生儿死亡</b>
            </div>
            <div class="zhibiao2" id="chart-aqyqst5" style="height:350px;"></div>
        </div>
    </div>

    <div id="item7" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">中低风险死亡</b>
            </div>
            <div class="zhibiao2" id="chart-aqyqst6" style="height:350px;"></div>
        </div>
    </div>
</div>

<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/bootstrap.min.js" ></script>
<%--<script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js" ></script>--%>
<script type="text/javascript" src="${ctx}/static/js/echarts.min.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/macarons.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/bootstrap-table.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/extensions/toolbar/bootstrap-table-toolbar.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/ga.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/dlchart.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/jsonpData.js" ></script>
<script>
    $(function(){
        hubeiCon.initCon('sj-pt','sj-jb');
    })
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
    $("body").delegate("tbody a","click",function(){
        var hospital = $(this).text();
        var year = $("#rq").val();
        loadHospitalDat(hospital,year);
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
                if (top > m.offset().top - 400) {
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
    });

    var H= 0;
    var biIds =['f040a966-b5ed-4308-9108-ee8de8e3266c'];//报表id
    var biKeys =[];//报表返回softkey
    $(document).ready(function () {
        btpage('${ctx}')
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
    });
    var flag=true;
    $('.top-btn').click(function () {
        flag=false;
        search();
    });
    function search(){
        $("#loading").show();
        var loads=1;
        var rq = $("#rq").val();
        var rqkj = $("#rqkj").val();
        /*var yyjb = $("#yyjb").val();
        var dq=$("#shi").val();*/
        var sTime = "",eTime = "";
        sTime = rq + "-01-01";
        eTime = rq + "-12-31";
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
        //报表1
        var data1x=[],data1y=[];
        var cxtj = sTime+";"+eTime+"|";
        var url ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+escape(escape(bivar))+
            '&biyccs=&id=' +biKeys[0].id+'&softkey='+biKeys[0].softkey +
            '&cxtj='+escape(cxtj)+'&topdata=&timew=&weiplan=0';
        $.ajax({
            type: "GET",
            url: url,
            dataType: "jsonp",
            success: function (data) {
                loads=loads-1;
                test(loads);
                data = jsonpDataInit(data);
                var dataIndex =[0,1,2,7,3,8,4,9,5,10,6,11];
                //加载报表表头
                var tit =  data.title.column.split(",");
                var th1 = "<th rowspan='2' data-field='td0' data-sortable='true'>"+tit[0]+"</th>"+
                        "<th rowspan='2' data-field='td1' data-sortable='true'>"+tit[1]+"</th>";
                var th2 = "";
                for(var i=2;i<dataIndex.length;i++){
                    th1 += "<th colspan='2'>"+tit[dataIndex[i]]+"</th>";
                    th2 += " <th data-field='td"+(dataIndex[i])+"' data-sortable='true'>例数</th>" ;
                            i++;
                    th2 +=  " <th data-field='td"+(dataIndex[i])+"' data-sortable='true'>占比</th>";
                }

                var tableData = initBootstrapTableData(data,dataIndex);//jsop数据格式化为layuiTable数据格式
                for(var i=0; i<tableData.data.length; i++){
                    tableData.data[i].td0 = "<a>"+tableData.data[i].td0+"</a>"
                }
                var zb=[],tit=['出院人数','死亡人数','低风险死亡','术后死亡','新生儿死亡','中低风险死亡'];
                    var datas=tableData.data.sort(compare("td1"));
                    var $table = $('#table');
                    if(flag==true){
                        $("#thead1").append("<tr>" + th1 + "</tr>");
                        $("#thead1").append("<tr>" + th2 + "</tr>");
                        $table.attr('data-toggle','table');
                        $table.attr('data-pagination','true');
                        $table.attr('data-page-size','6');
                        $table.attr('data-page-list',[6, 'all']);
                        $table.attr('data-height','248');
                        $table.bootstrapTable({data: datas});
                    }else{
                        $table.attr('data-toggle','table');
                        $table.bootstrapTable('load', datas);
                    }
                    $('#table thead:last').css({'width':'150px'});
                    $('#table th div').css({'font-size':'12px'});
                $('#table thead th').eq(0).css({"vertical-align":"middle","width":"23%"});
                $('#table thead th').eq(1).css({"vertical-align":"middle"});
//                    $('#table th:first div').css({'width':'150px'});
                    //指标1
                    for(var a=0;a<datas.length;a++){
                        var array = [];
                        array.push(datas[a].td1);
                        array.push(datas[a].td2);
                        array.push(datas[a].td3);
                        array.push(datas[a].td4);
                        array.push(datas[a].td5);
                        array.push(datas[a].td6);
                        array.push((datas[a].td0).replace(/<\/?[^>]*>/g,''));
                        zb.push(array);
                    }
                var dataId = ['chart-aqyqst1','chart-aqyqst2','chart-aqyqst3','chart-aqyqst4','chart-aqyqst5','chart-aqyqst6'];
                for(var a=0;a<dataId.length;a++){
                    for(var i=0;i<zb.length;i++){
                        for(var j=i+1;j<zb.length;j++){
                            if(Number(zb[i][a])<Number(zb[j][a])){
                                var cmi = zb[j];
                                zb[j] = zb[i];
                                zb[i] = cmi;
                            }
                        }
                    }
                    var jgmc = [];
                    var zbData = [];
                    if(zb.length>20){
                        for(var k=0;k<20;k++){
                            jgmc.push(zb[k][6]);
                            zbData.push(zb[k][a]);
                        }
                    }else{
                        for(var k=0;k<zb.length;k++){
                            jgmc.push(zb[k][6]);
                            zbData.push(zb[k][a]);
                        }
                    }
                    option1(jgmc,zbData,tit[a],dataId[a]);
                }
            }
        })
    }
    //对象排序
    function compare(property) {
        return function(a, b) {
            var value1 = parseInt(a[property]);
            var value2 = parseInt(b[property]);
            return value1>value2?-1:1;
        }
    }
    //
    function  option1(jgmc,zb,tit,id) {
        var myChart = echarts.init(document.getElementById(id));
        var colors = ['#4ea397'];
        option = {
            color:colors,
            tooltip : {
                trigger: 'axis'
            },
            legend: {
                data:[tit]
            },
            visualMap: {
                show: false,
                min: 0,
                max: 14,
                dimension: 0,
                inRange: {
                    color: ['#229583', '#7abfb5']
                }
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
//            calculable : true,
            xAxis : [
                {
                    type : 'category',
                    data : jgmc
                }
            ],
            yAxis : [
                {
                    type : 'value'
                }
            ],
            series : [
                {
                    name:tit,
                    type:'bar',
                    data:zb,
                    markPoint : {
                        data : [
                            {type : 'max', name: '最大值'},
                            {type : 'min', name: '最小值'}
                        ]
                    },
                    markLine : {
                        data : [
                            {type : 'average', name: '平均值'}
                        ]
                    }
                }
            ]
        };
        myChart.setOption(option);
        myChart.on('dblclick', function (param) {
            var hospital = param.name;
            var year = $("#rq").val();
            loadHospitalDat(hospital,year);
        });
    }
</script>
</body>
</html>
