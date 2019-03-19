<%--
  Created by IntelliJ IDEA.
  User: DL
  Date: 2017-06-17
  Time: 14:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>疑难重症与关键技术</title>
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
    <div id="main8" style="width:49%;height: 99%;margin: 5px 0 0 10px;border-style:solid; border-width:5px; border-color:#c6daeb"></div>
    <div id="main2" style="width: 49%;height:99%;position: absolute;top: 10px;right: 10px;border-style:solid; border-width:5px; border-color:#c6daeb"></div>
</div>
<script type="text/javascript" src="${ctx}/static/js/echarts-2.2.7/build/dist/echarts-all.js"></script>
<script>
    // 标准气泡图  三个值
    var myChart8 = echarts.init(document.getElementById('main8'));
    option8 = {
        title : {
            text: '疑难重症'
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
            data:['5%+','2%+','2%-']
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
                name:'CMI',
                splitNumber: 4,
                /*min: 0,
                 max: 40,*/
                scale: true
            }
        ],
        yAxis : [
            {
                type : 'value',
                name:'占比（%）',
                splitNumber: 4,
                /*min: 0,
                 max: 60,*/
                formatter: function (value) {
                    // Function formatter
                    return value + ' %'
                }
            }
        ],
        series : [
            {
                name:'5%+',
                type:'scatter',
                symbolSize: function (value){
                    return Math.round(value[2]*6);
                },
                data: /*randomDataArray()*/[[	1.12 	,	16.61 	,	5.23 	],
                    [	1.29 	,	4.04 	,	1.40 	],
                    [	1.07 	,	5.59 	,	1.67 	],
                    [	1.07 	,	21.43 	,	7.64 	],
                    [	1.08 	,	14.98 	,	2.65 	],
                    [	1.29 	,	1.75 	,	0.21 	]]
            },
            {
                name:'2%+',
                type:'scatter',
                symbolSize: function (value){
                    return Math.round(value[2]*6);
                },
                data: /*randomDataArray()*/[[	1.01 	,	2.55 	,	0.81 	],
                    [	1.27 	,	4.72 	,	1.22 	],
                    [	1.27 	,	19.23 	,	6.16 	],
                    [	1.38 	,	6.56 	,	2.42 	],
                    [	1.41 	,	10.16 	,	3.09 	],
                    [	1.13 	,	7.73 	,	0.62 	],
                    [	1.14 	,	16.44 	,	3.08 	],
                    [	1.31 	,	10.91 	,	2.61 	],
                    [	1.08 	,	20.10 	,	2.18 	],
                    [	1.23 	,	3.57 	,	0.50 	],
                    [	1.18 	,	4.41 	,	1.61 	],
                    [	1.23 	,	6.70 	,	0.69 	],
                    [	1.34 	,	13.65 	,	3.01 	],
                    [	1.10 	,	3.35 	,	0.55 	]]
            },
            {
                name:'2%-',
                type:'scatter',
                symbolSize: function (value){
                    return Math.round(value[2]*6);
                },
                data: /*randomDataArray()*/[[	1.37 	,	7.56 	,	2.08 	],
                    [	1.04 	,	14.88 	,	2.38 	],
                    [	1.21 	,	18.16 	,	3.54 	],
                    [	1.14 	,	18.94 	,	4.19 	],
                    [	1.09 	,	22.27 	,	4.47 	],
                    [	1.44 	,	2.59 	,	0.50 	],
                    [	1.30 	,	4.92 	,	1.14 	],
                    [	1.16 	,	8.26 	,	1.58 	],
                    [	1.03 	,	3.58 	,	0.37 	],
                    [	1.02 	,	20.38 	,	7.34 	],
                    [	1.30 	,	1.71 	,	0.30 	],
                    [	1.17 	,	18.93 	,	2.44 	],
                    [	0.81 	,	24.64 	,	9.01 	],
                    [	1.03 	,	26.91 	,	1.50 	],
                    [	1.58 	,	13.86 	,	7.61 	],
                    [	1.31 	,	15.49 	,	2.88 	],
                    [	0.66 	,	5.59 	,	0.08 	],
                    [	1.05 	,	0.56 	,	0.04 	],
                    [	0.21 	,	0.15 	,	0.00 	],
                    [	0.00 	,	0.00 	,	0.00 	],
                    [	1.39 	,	3.16 	,	1.02 	],
                    [	0.00 	,	0.00 	,	0.00 	]]
            }
        ]
    };

    myChart8.setOption(option8);
    var myChart2 = echarts.init(document.getElementById('main2'));
    option2 = {
        title : {
            text: '关键技术'
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
                name:'CMI',
                splitNumber: 4,
                /*min: 0,
                 max: 40,*/
                scale: true
            }
        ],
        yAxis : [
            {
                type : 'value',
                name:'占比（%）',
                splitNumber: 4,
                /*min: 0,
                 max: 60,*/
                formatter: function (value) {
                    // Function formatter
                    return value + ' %'
                }
            }
        ],
        series : [
            {
                name:'5%+',
                type:'scatter',
                symbolSize: function (value){
                    return Math.round(value[2]*4);
                },
                data: /*randomDataArray()*/[[	1.53 	,	28.19 	,	8.17 	],
                    [	1.35 	,	26.76 	,	6.20 	]]
            },
            {
                name:'4%+',
                type:'scatter',
                symbolSize: function (value){
                    return Math.round(value[2]*4);
                },
                data: /*randomDataArray()*/[[	1.35 	,	22.70 	,	4.94 	],
                    [	1.97 	,	16.56 	,	4.91 	],
                    [	1.53 	,	23.27 	,	4.90 	],
                    [	1.22 	,	25.75 	,	4.78 	],
                    [	1.12 	,	26.47 	,	4.52 	],
                    [	1.91 	,	35.50 	,	4.42 	]]
            },
            {
                name:'3%+',
                type:'scatter',
                symbolSize: function (value){
                    return Math.round(value[2]*4);
                },
                data: /*randomDataArray()*/[[	1.47 	,	30.84 	,	3.90 	],
                    [	1.14 	,	21.83 	,	3.65 	],
                    [	1.84 	,	18.03 	,	3.54 	],
                    [	1.27 	,	29.59 	,	3.49 	],
                    [	1.20 	,	15.27 	,	3.46 	],
                    [	1.20 	,	29.10 	,	3.41 	],
                    [	1.71 	,	22.79 	,	3.31 	]]
            },
            {
                name:'2%+',
                type:'scatter',
                symbolSize: function (value){
                    return Math.round(value[2]*4);
                },
                data: /*randomDataArray()*/[[	1.95 	,	25.48 	,	2.84 	],
                    [	1.24 	,	23.32 	,	2.75 	],
                    [	1.10 	,	38.73 	,	2.52 	],
                    [	1.06 	,	24.68 	,	2.45 	],
                    [	1.31 	,	25.54 	,	2.42 	],
                    [	1.67 	,	11.97 	,	2.23 	],
                    [	1.39 	,	25.42 	,	2.09 	],
                    [	1.53 	,	15.58 	,	2.00 	]]
            },
            {
                name:'2%-',
                type:'scatter',
                symbolSize: function (value){
                    return Math.round(value[2]*4);
                },
                data: /*randomDataArray()*/[[	1.14 	,	22.83 	,	1.89 	],
                    [	1.21 	,	29.40 	,	1.71 	],
                    [	1.31 	,	35.12 	,	1.70 	],
                    [	1.27 	,	15.39 	,	1.35 	],
                    [	1.42 	,	20.79 	,	1.29 	],
                    [	1.04 	,	14.47 	,	1.25 	],
                    [	1.12 	,	25.53 	,	1.19 	],
                    [	1.13 	,	21.20 	,	0.70 	],
                    [	1.15 	,	21.60 	,	0.65 	],
                    [	1.19 	,	11.37 	,	0.50 	],
                    [	0.91 	,	10.52 	,	0.36 	],
                    [	1.23 	,	44.64 	,	0.36 	],
                    [	0.92 	,	16.56 	,	0.14 	]]
            }
        ]
    };

    myChart2.setOption(option2);
</script>
</body>
</html>

