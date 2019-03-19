<!doctype html>
<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/6/2
  Time: 9:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/blsj.css?v=3">
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/danbingzhong.css?v=3">
    <script type="text/javascript" src="${ctx }/static/js/echarts-2.2.7/build/source/echarts-all.js"></script>
    <title>事件上报</title>

    <script>

        $(function(){
            var height = findDimensions_height();
            var width = findDimensions_width();


            $("#form_style").width(width/2);
            $("#month").width(width/2);

            var date = new Date;
            var year=date.getFullYear();


            var   startTime = year + '-01-01';
            var  day = new Date(year,month,0);
            var endTime = year + '-12-31';
            $("#startTime").val(startTime);
            $("#year").val(year);
            $("#endTime").val(endTime);
            getPie(startTime,endTime);
            getBar(year);
        })
        var SelectPageindex=0;
        function openSbPage(formname,formid){
            var height = findDimensions_height();
            var width = findDimensions_width();
            SelectPageindex = layeropen(0.85*width,height-50,formname,"/v_customformdata/toEdit?tableId="+formid);
        }


        function createchart(data, type) {
            var option = {};
            if(type == "pie") {
                var pd = [];
                for(var i = 0; i < data.xdata.length; i++) {
                    pd.push({
                        value: data.ydata[0][i],
                        name: data.xdata[i]
                    })
                }

                var option = {
                    title: {
                        text: '事件上报数',
                        x: 'center'
                    },
                    tooltip: {
                        trigger: 'item'

                    },
                    /* legend: {
                     orient: 'vertical',
                     x: 'left',
                     data: data.xdata

                     },*/
                    series: [{
                        name: '类型',
                        type: 'pie',
                        radius: '55%',
                        center: ['50%', '60%'],
                        data: pd,
                        itemStyle: {
                            normal: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'

                            }
                        },
                        textstyle:{
                            fontFamily:'Arial, Verdana, sans-serif'
                        }
                    }]
                };
            } else {
                var pd = [];
                for(var j = 0; j < data.legend.length; j++) {
                    pd.push({
                        data: data.ydata[j],
                        name: data.legend[j],
                        type: type
                    })
                }

                option = {
                    title: {
                        text: '月上报数',
                        x:'center'
                    },
                    tooltip: {},
                    legend: {
                        data: data.legend,
                        x:'left'
                    },
                    xAxis: {
                        data: data.xdata
                    },
                    yAxis: {},
                    series: pd

                };
            }
            return option;
        }

        function getPie(startTime,endTime){
            var xdata = "\"xdata\":[";
            var ydata = "\"ydata\":[[";
            $.ajax({
                method: "POST",
                url:"/CustomFormIndex/getPie?startTime="+startTime+"&endTime="+endTime+"&rdm="+ parseInt(Math.random()*100000),
                dataType: "JSON",
                success: function(data){
                    for(var i=0;i<data.length;i++){
                        xdata+= "\""+data[i].name+"\"";
                        ydata+=data[i].num;
                        if(i<data.length-1){
                            xdata+=",";
                            ydata+=",";
                        }
                    }
                    xdata+="]";
                    ydata+="]]";
                    var dataPie = "{"+xdata+","+ydata +",\"legend\":[\"上报表单\"]}";
                    var dataP = JSON.parse(dataPie);
                    var myChart2 = echarts.init(document.getElementById('form_style'));
                    var option1 =createchart(dataP,"pie");
                    myChart2.setOption(option1);
                    myChart2.setTheme('macarons');
                }
            });

        }

        function getBar(year){
            var xdata = "\"xdata\":[\"一\",\"二\",\"三\",\"四\",\"五\",\"六\",\"七\",\"八\",\"九\",\"十\",\"十一\",\"十二\"]";
            var ydata = "\"ydata\":[[";
            $.ajax({
                method: "POST",
                url:"/CustomFormIndex/getBar?year="+year+"&rdm="+ parseInt(Math.random()*100000),
                dataType: "JSON",
                success: function(data){
                    for(var i =0 ;i<data.length;i++){
                        ydata+=data[i].num;
                        if(i<data.length-1){
                            ydata+=",";
                        }
                    }
                    ydata+="]]";
                    var dataPie = "{"+xdata+","+ydata +",\"legend\":[\"上报表单\"]}";
                    console.log(dataPie);
                    var dataP = JSON.parse(dataPie);
                    var myChart1 = echarts.init(document.getElementById('month'));
                    var option =createchart(dataP,"bar");
                    myChart1.setOption(option);
                    myChart1.setTheme('macarons');
                }
            });
        }

        function searchPie(){
            var startTime = $("#startTime").val();
            var endTime = $("#endTime").val();
            getPie(startTime,endTime);
        }

        function searchBar(){
            var year = $("#year").val();
            getBar(year);
        }


    </script>
<style>
    body{overflow-y: auto;}
</style>


</head>
<body>
<div id="tabContent" class="tab-content" <%--style="margin-top:0px;"--%>>
    <!--上报数据开始-->
    <div class="tab-pane fade in active" id="sbsju">
        <div style="padding: 5px;border:none;/*margin-top:25px;*/">
            <c:set var="num" value="0"></c:set>
            <c:forEach items="${FormTypes}" var="type">
                <%--<tr><td>${type.id}</td><td>${type.name}</td><td></td></tr>--%>
                <div  class="blsj_header">
                    <div ></div>
                    <h4 >${type.name}</h4>
                </div>
                <div  id="blsj_warp" >
                    <div class="blsj_item">
                        <c:forEach items="${Forms}" var="form">

                            <c:if test="${form.typeId == type.id}">
                                <c:set var="num" value="${num+1}"/>
                                <%--<c:if test="${num>=20}">--%>
                                <c:choose>
                                    <c:when test="${num<=10}">
                                        <div><button class="color${num}" onclick="openSbPage('${form.name}','${form.id}')"><i>${num}</i><span>${form.name}</span></button></div>
                                    </c:when>
                                    <c:when test="${num>10&&num<=20}">
                                        <div><button class="color${num-10}" onclick="openSbPage('${form.name}','${form.id}')"><i>${num}</i><span>${form.name}</span></button></div>
                                    </c:when>
                                    <c:when test="${num>20&&num<=30}">
                                        <div><button class="color${num-20}" onclick="openSbPage('${form.name}','${form.id}')"><i>${num}</i><span>${form.name}</span></button></div>
                                    </c:when>

                                </c:choose>

                            </c:if>

                        </c:forEach>
                    </div>
                </div>

            </c:forEach>

        </div>
        <!--面板结束-->

    <%--</div>--%>
    <!--上报数据结束-->

    <!--已报数据开始-->
    <%--<div class="tab-pane fade"    id="sjsb" >--%>
   <%--     <div style="margin-top:38px;width:99%;">
            <div class="navheader form-inline" style="padding:0 5px;height:40px;">
                <div class=" form-group">
                    <span>上报时间：</span>
                    <span>
                            <input type="text" class="form-control Wdate" style="width:90px;" name="sTime" id="sTime" value=""
                                   onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd' })">
                            <span>至</span>
                            <input type="text" class="form-control Wdate" style="width:90px;" name="eTime" id="eTime" value=""
                                   onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd' })">
                            <button type="button" class="btn btn-success bi-btn-search" onclick="loadCheckList()">
                                <span class="glyphicon glyphicon glyphicon-search"></span>
                            </button>
                        </span>
                </div>
            </div>

            <table id="gridtable"  style="width:100%;height: 430px; " >

            </table>
        </div>--%>


        <!--底下的三个panel开始-->
        <div style="padding-top:10px; width:99%;display: block;margin:0 5px;">
            <div style="width:49.5%; float:left;margin-right:0.5rem;border:1px solid #ddd;">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <span>已报上报事件统计&nbsp;&nbsp;&nbsp;</span>
                        <span>
                            <input type="text" class="form-control Wdate" style="width:90px;" name="startTime" id="startTime" value=""
                                   onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd' })">
                            <span>至</span>
                            <input type="text" class="form-control Wdate" style="width:90px;" name="endTime" id="endTime" value=""
                                   onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd' })">
                            <button type="button" class="btn btn-success bi-btn-search" onclick="searchPie()">
                                <span class="glyphicon glyphicon glyphicon-search"></span>
                            </button>
                        </span>
                    </div>
                    <div class="panel-body" style="padding:5px;border:none;height:450px;overflow: hidden;" id="form_style">
                    </div>

                </div>
            </div>

            <div style="width:49.5%; float:right;border:1px solid #ddd;">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <span>上报事件月上报数&nbsp;&nbsp;&nbsp;</span>
                        <span>
                            <input type="text" class="form-control Wdate" style="width:60px;" name="year" id="year" value=""
                                   onclick="WdatePicker({ dateFmt: 'yyyy' })">
                            <button type="button" class="btn btn-success bi-btn-search" onclick="searchBar()">
                                <span class="glyphicon glyphicon glyphicon-search"></span>
                            </button>
                        </span>
                    </div>
                    <div class="panel-body" style="padding:5px;border:none;width:450px;height:450px;overflow: hidden;" id="month">
                    </div>
                </div>
            </div>

        </div>


    </div>
    <!--已报数据开始-->

    <!--明细数据开始-->
  <%--  <div class="tab-pane fade" id="zyptlb" >
        <div style="width:20%;border:1px solid #ddd;border-top:none;float:left;margin:38px 5px 0 0;height:100%;" >
            <ul id="typeTree" class="easyui-tree" style="padding:5px;"></ul>
        </div>
        <div style="width:79%;float:left;height:100%;padding:5px;margin-top:40px;">
            <div class="J_mainContent mainContent" id="" style="height:100%;">
                <iframe id="framelist" class="J_iframe" scrolling="auto" src="" style="border:none" name="iframe0" width="100%" height="100%"  frameborder="0" data-id="login.html"></iframe>
            </div>
        </div>
    </div>--%>
    <!--明细数据结束-->

</div>
</body>
</html>
