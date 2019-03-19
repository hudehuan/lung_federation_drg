<%--
  Created by IntelliJ IDEA.
  User: DL
  Date: 2017-06-17
  Time: 12:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>39种病种工作量分布和机构内占比</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/bootstrap-3.3.5/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/index.css">
    <link rel="stylesheet" href="${ctx}/static/js/plugins/metisMenu/metisMenu.css" />
    <link rel="stylesheet" href="${ctx}/static/js/plugins/layer/skin/layer.css" />

    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/bootstrap.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/my97DatePicker/WdatePicker.js" ></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/metisMenu/jquery.metisMenu.min.js" ></script>
    <script type="text/javascript" src="${ctx}/static/js/common.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/index.js"></script>
    <style>
        .tsxx-class{
            box-shadow:1px 7px 28px rgba(0,0,0,.2)!important;
        }
        .tsxx-class .layui-layer-title{
            background: #55a6f7;
            color: #fff;
        }
        .tsxx-class .layui-layer-content p{
            font-size: 15px;
            margin-left: 30px;
            margin-top: 30px;
        }
    </style>
</head>
<body onload="startTime()" style="background-color:#f1f1f1 ;">
<%--<div id="div1" style="float: right;margin:10px 10px 0 0;"></div>--%>
<div style="min-width: 1200px;margin-top: 10px;">
     <div id="main8" style="width: 99%;height: 99%;margin: 5px 0 0 10px;border-style:solid; border-width:5px; border-color:#c6daeb"></div>
</div>
<script type="text/javascript" src="${ctx}/static/js/echarts-2.2.7/build/dist/echarts-all.js"></script>
<script>
      // 标准气泡图  三个值
    var myChart8 = echarts.init(document.getElementById('main8'));
    option8 = {
        title : {
            text: '9种病种工作量分布和机构内占比'
        },
        tooltip : {
            trigger: 'axis',
            showDelay : 0,
            axisPointer:{
                show: true,
                type : 'cross',
                lineStyle: {
                    type : 'dashed',
                    width : 1
                }
            }
        },
        legend: {
            data:['5%+','4%+','3%+','2%+','2%-']
        },
        toolbox: {
            show : true,
            feature : {
                mark : {show: true},
                dataZoom : {show: true},
                dataView : {show: true, readOnly: false},
                restore : {show: true},
                saveAsImage : {show: true}
            }
        },
        xAxis : [
            {
                type : 'value',
                name:'患者占比%',
                splitNumber: 4,
                /*min: 0,
                max: 40,*/
                scale: true,
                axisLabel : {
                    formatter: '{value} %'
                }
            }
        ],
        yAxis : [
            {
                type : 'value',
                name:'费用占比%',
                splitNumber: 4,
                /*min: 0,
                max: 60,*/
                scale: true,
                axisLabel : {
                    formatter: '{value} %'
                }
            }
        ],
        series : [
            {
                name:'5%+',
                type:'scatter',
                symbolSize: function (data){
                    return [6.33*4,5.42*4,5.23*4]/*[10,8,1]Math.round(value)*/;
                },
                data: /*randomDataArray()*/[['23.98','23.95'],['20.23','27.54'],['21.12','21.92']]
            },
            {
                name:'4%+',
                type:'scatter',
                symbolSize: function (data){
                    return [4.88*4,4.60*4]/*[10,8,1]Math.round(value)*/;
                },
                data: /*randomDataArray()*/[[14.38,19.78],[15.00,21.28]]
            },
            {
                name:'3%+',
                type:'scatter',
                symbolSize: function (data){
                    return [3.96*4,3.75*4,3.55*4,3.53*4,3.31*4,3.12*4,3.11*4]/*[10,8,1]Math.round(value)*/;
                },
                data: /*randomDataArray()*/[[5.13,13.32],[14.43,18.57],[19.73,27.23],[13.61,17.12],[12.85,15.99],[19.86,20.87],[18.84,19.26]]
            },
            {
                name:'2%+',
                type:'scatter',
                symbolSize: function (data){
                    return [2.90*4,2.85*4,2.76*4,2.63*4,
                        2.48*4,2.45*4,2.45*4,2.31*4,
                        2.30*4,2.28*4,2.20*4,2.10*4,
                        2.03*4,2.00*4]/*[10,8,1]Math.round(value)*/;
                },
                data: /*randomDataArray()*/[[9.35,11.96],[18.71,25.12],[18.64,20.74],
                    [14.89,15.37],[11.86,16.04],[20.81,19.64],[15.51,13.17],
                    [13.15,16.14],[15.40,19.57],[12.66,22.92],[12.30,17.18],
                    [21.38,24.83],[20.81,20.97],[16.57,15.71]]
            },
            {
                name:'2%-',
                type:'scatter',
                symbolSize: function (data){
                    return [1.92*4,1.85*4,1.85*4,1.73*4,
                        1.53*4,1.41*4,1.25*4,1.01*4,
                        0.94*4,0.73*4,0.72*4,0.21*4,
                        0.19*4,0.07*4,0.03*4]/*[10,8,1]Math.round(value)*/;
                },
                data: /*randomDataArray()*/[[17.50,20.13],[12.04,16.53],
                    [10.69,12.63],[34.83,51.85],[20.47,19.64],[15.75,17.70],
                    [9.22,11.31],[14.25,12.47],[15.36,16.65],[9.41,10.74],
                    [9.92,11.72],[9.86,10.16],[10.87,16.95],[4.05,3.84],
                    [0.46,1.42]]
            }
        ]
    };
    myChart8.setOption(option8);
</script>
</body>
</html>

