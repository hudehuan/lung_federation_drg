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
    <title>负担情况</title>
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
            text: '负担情况'
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
                data:['医疗机构医师负担']
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
                name:'医生每月负担权重',
                splitNumber: 4,
                /*min: 0,
                 max: 40,*/
                scale: true
            }
        ],
        yAxis : [
            {
                type : 'value',
                name:'医生每日负担住院床日',
                splitNumber: 4,
                /*min: 0,
                 max: 60,*/
                scale: true
            }
        ],
        series : [
            {
                name:'医疗机构医师负担',
                type:'scatter',
                symbolSize: function (value){
                    return Math.round(value[2]/25);
                },
                data: /*randomDataArray()*/[[	5.04 	,	2.06 	,	551	],
                    [	3.99 	,	1.48 	,	663	],
                    [	3.87 	,	1.35 	,	706	],
                    [	4.52 	,	1.56 	,	732	],
                    [	3.26 	,	1.19 	,	502	],
                    [	2.24 	,	1.12 	,	419	],
                    [	4.86 	,	1.75 	,	616	],
                    [	3.95 	,	1.43 	,	522	],
                    [	4.06 	,	1.56 	,	609	],
                    [	5.62 	,	2.11 	,	494	],
                    [	5.76 	,	2.10 	,	376	],
                    [	4.11 	,	1.66 	,	170	],
                    [	4.21 	,	1.69 	,	388	],
                    [	4.03 	,	1.38 	,	470	],
                    [	2.94 	,	1.52 	,	328	],
                    [	3.94 	,	1.44 	,	285	],
                    [	5.65 	,	2.10 	,	538	],
                    [	2.55 	,	1.11 	,	331	],
                    [	3.23 	,	1.21 	,	501	],
                    [	4.35 	,	1.62 	,	339	],
                    [	5.82 	,	1.49 	,	343	],
                    [	3.59 	,	1.11 	,	410	],
                    [	4.66 	,	1.48 	,	333	],
                    [	6.04 	,	1.80 	,	319	],
                    [	5.14 	,	1.95 	,	365	],
                    [	6.97 	,	2.35 	,	184	],
                    [	2.62 	,	0.93 	,	666	],
                    [	4.25 	,	1.48 	,	380	],
                    [	3.42 	,	1.18 	,	288	],
                    [	6.21 	,	2.21 	,	568	],
                    [	6.51 	,	2.22 	,	197	],
                    [	7.02 	,	3.35 	,	608	],
                    [	4.01 	,	0.82 	,	137	],
                    [	6.25 	,	1.40 	,	584	],
                    [	5.80 	,	1.89 	,	240	],
                    [	1.66 	,	0.70 	,	143	],
                    [	4.34 	,	3.43 	,	166	],
                    [	1.12 	,	1.09 	,	195	],
                    [	1.01 	,	0.98 	,	84	],
                    [	14.52 	,	3.13 	,	159	],
                    [	1.32 	,	1.30 	,	57	],
                    [	3.37 	,	0.79 	,	52	]],
                markLine : {
                    data : [
                        [
                            {name: '标线1起点',  xAxis: 1,yAxis: 0.9},
                            {name: '标线1终点', xAxis: 17.5, yAxis: 4}
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

