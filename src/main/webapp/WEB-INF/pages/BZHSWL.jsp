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
    <title>核心质量指标：医院标准化死亡率</title>
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
            text: '核心质量指标：医院标准化死亡率'
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
            data:['医疗机构']
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
                name:'医院粗死亡率（每千人）',
                splitNumber: 4,
                /*min: 0,
                 max: 40,*/
                scale: true
            }
        ],
        yAxis : [
            {
                type : 'value',
                name:'医院标化死亡率（每千人）',
                splitNumber: 4,
                /*min: 0,
                 max: 60,*/
                scale: true
            }
        ],
        series : [
            {
                name:'医疗机构',
                type:'scatter',
                symbolSize: function (value){
                    return Math.round(value[2]);
                },
                data: /*randomDataArray()*/[[	1.95 	,	3.68 	,	17	],
                    [	3.82 	,	3.67 	,	37	],
                    [	2.66 	,	3.47 	,	23	],
                    [	3.10 	,	3.28 	,	32	],
                    [	3.11 	,	3.27 	,	26	],
                    [	5.93 	,	2.88 	,	30	],
                    [	2.91 	,	1.69 	,	24	],
                    [	1.80 	,	1.60 	,	12	],
                    [	8.17 	,	1.29 	,	39	],
                    [	3.20 	,	1.24 	,	35	],
                    [	3.81 	,	1.08 	,	21	],
                    [	5.76 	,	1.03 	,	18	],
                    [	1.75 	,	1.01 	,	5	],
                    [	2.05 	,	0.98 	,	22	],
                    [	1.58 	,	0.97 	,	8	],
                    [	2.49 	,	0.93 	,	15	],
                    [	1.77 	,	0.78 	,	9	],
                    [	3.83 	,	0.73 	,	13	],
                    [	1.73 	,	0.73 	,	8	],
                    [	1.07 	,	0.73 	,	15	],
                    [	1.92 	,	0.69 	,	11	],
                    [	3.43 	,	0.69 	,	17	],
                    [	3.88 	,	0.55 	,	16	],
                    [	2.14 	,	0.53 	,	9	],
                    [	0.52 	,	0.48 	,	5	],
                    [	1.12 	,	0.42 	,	4	],
                    [	0.98 	,	0.34 	,	5	],
                    [	0.35 	,	0.29 	,	2	],
                    [	1.13 	,	0.28 	,	5	],
                    [	0.77 	,	0.23 	,	2	],
                    [	0.13 	,	0.22 	,	1	],
                    [	0.45 	,	0.17 	,	1	],
                    [	0.32 	,	0.13 	,	1	],
                    [	1.40 	,	0.05 	,	1	],
                    [	0.46 	,	0.05 	,	1	],
                    [	1.53 	,	0.05 	,	1	]] ,markLine : {
                data : [
                    [
                        {name: '标线1起点',  xAxis: 0,yAxis: 0},
                        {name: '标线1终点', xAxis: 4, yAxis: 4}
                    ]
                ]
            },
            }
        ]
    };
    myChart8.setOption(option8);
</script>
</body>
</html>

