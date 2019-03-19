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
    <title>时间-费用效率</title>
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
            text: '时间-费用效率'
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
                name:'每权重住院日',
                splitNumber: 4,
                /*min: 0,
                 max: 40,*/
                scale: true
            }
        ],
        yAxis : [
            {
                type : 'value',
                name:'每权重费用',
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
                    return Math.round(value[2]/100);
                },
                data: /*randomDataArray()*/[[	9.91 	,	21876.57 	,	2207.68 	],
                    [	10.51 	,	18251.14 	,	1737.27 	],
                    [	11.26 	,	17957.68 	,	1594.56 	],
                    [	12.42 	,	17826.36 	,	1435.73 	],
                    [	14.49 	,	19327.97 	,	1334.25 	],
                    [	10.63 	,	14408.90 	,	1355.31 	],
                    [	12.75 	,	15611.78 	,	1224.90 	],
                    [	10.74 	,	12356.62 	,	1150.02 	],
                    [	9.40 	,	10274.04 	,	1092.94 	],
                    [	11.29 	,	12645.73 	,	1120.28 	],
                    [	6.79 	,	7706.00 	,	1135.09 	],
                    [	11.10 	,	11897.02 	,	1072.21 	],
                    [	10.83 	,	11324.53 	,	1046.03 	],
                    [	9.09 	,	9385.64 	,	1032.02 	],
                    [	11.29 	,	11344.47 	,	1004.92 	],
                    [	9.64 	,	9446.45 	,	979.75 	],
                    [	12.21 	,	12233.82 	,	1002.24 	],
                    [	11.39 	,	11261.51 	,	988.39 	],
                    [	13.23 	,	13060.35 	,	987.45 	],
                    [	10.93 	,	10132.90 	,	926.76 	],
                    [	11.13 	,	10258.56 	,	921.65 	],
                    [	11.53 	,	10987.37 	,	953.15 	],
                    [	11.08 	,	9988.67 	,	901.45 	],
                    [	6.26 	,	5675.96 	,	906.33 	],
                    [	10.59 	,	9157.34 	,	864.37 	],
                    [	10.42 	,	9329.15 	,	895.13 	],
                    [	11.04 	,	9611.04 	,	870.54 	],
                    [	10.37 	,	8644.79 	,	833.82 	],
                    [	11.68 	,	9208.26 	,	788.16 	],
                    [	6.55 	,	5069.99 	,	774.31 	],
                    [	10.27 	,	7302.89 	,	710.99 	],
                    [	15.26 	,	10391.54 	,	680.91 	],
                    [	10.48 	,	6758.90 	,	645.10 	],
                    [	11.40 	,	7675.35 	,	673.55 	],
                    [	10.38 	,	6276.22 	,	604.74 	],
                    [	12.28 	,	6816.21 	,	555.00 	],
                    [	7.77 	,	4170.80 	,	536.51 	],
                    [	24.07 	,	12079.95 	,	501.83 	],
                    [	15.70 	,	7288.28 	,	464.11 	],
                    [	7.10 	,	3318.27 	,	467.20 	],
                    [	29.79 	,	14214.79 	,	477.15 	],
                    [	29.57 	,	7665.81 	,	259.26 	],
                    [	29.82 	,	6500.26 	,	218.00 	]],
                markLine : {
                    data : [
                        [
                            {name: '标线1起点', value: 11, xAxis: 11,yAxis: 0},
                            {name: '标线1终点', xAxis: 11, yAxis: 40000}
                        ],
                        [
                            {name: '标线2起点', value: 11420,xAxis: 0, yAxis: 11420},
                            {name: '标线2终点', xAxis: 40, yAxis: 11420}
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

