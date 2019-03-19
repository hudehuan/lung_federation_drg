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
            text: '技术水平'
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
            data:['5%+','4%+','3%+','2%+','1%+','0%+']
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
                name:'DRGS组数',
                splitNumber: 4,
                /*min: 0,
                 max: 40,*/
                scale: true
            }
        ],
        yAxis : [
            {
                type : 'value',
                name:'CMI',
                splitNumber: 4,
                /*min: 0,
                 max: 60,*/
                scale: true
            }
        ],
        series : [
            {
                name:'5%+',
                type:'scatter',
                symbolSize: function (value){
                    return Math.round(value[2]*6);
                },
                data: /*randomDataArray()*/[[281,0.91,5.77],]
            },
            {
                name:'4%+',
                type:'scatter',
                symbolSize: function (value){
                    return Math.round(value[2]*6);
                },
                data: /*randomDataArray()*/[[	513	,	0.96	,	4.47	],
                    [	400	,	0.93	,	4.05	],
                    [	507	,	0.95	,	4.11	],
                    [	560	,	0.97	,	4.76	],
                    [	347	,	1.02	,	4.93	]]
            },
            {
                name:'3%+',
                type:'scatter',
                symbolSize: function (value){
                    return Math.round(value[2]*6);
                },
                data: /*randomDataArray()*/[[	554	,	0.96	,	3.75	],
                    [	513	,	0.95	,	3.57	],
                    [	503	,	0.95	,	3.69	],
                    [	414	,	0.95	,	3.34	],
                    [	451	,	1.01	,	3.75	],
                    [	215	,	0.96	,	3.12	]]
            },
            {
                name:'2%+',
                type:'scatter',
                symbolSize: function (value){
                    return Math.round(value[2]*6);
                },
                data: /*randomDataArray()*/[[	383	,	0.97	,	2.21	],
                    [	418	,	0.98	,	2.79	],
                    [	336	,	0.98	,	2.93	],
                    [	424	,	0.97	,	2.21	],
                    [	361	,	1.01	,	2.56	],
                    [	439	,	0.96	,	2.19	],
                    [	313	,	0.96	,	2.70	],
                    [	382	,	0.94	,	2.09	],
                    [	435	,	0.96	,	2.60	],
                    [	419	,	0.99	,	2.54	],
                    [	429	,	0.95	,	2.36	],
                    [	443	,	0.95	,	2.18	]]
            },
            {
                name:'1%+',
                type:'scatter',
                symbolSize: function (value){
                    return Math.round(value[2]*6);
                },
                data: /*randomDataArray()*/[[	268	,	0.98	,	1.27	],
                    [	330	,	0.93	,	1.30	],
                    [	372	,	0.95	,	1.52	],
                    [	299	,	0.98	,	1.14	],
                    [	450	,	0.96	,	1.99	],
                    [	386	,	0.93	,	1.99	],
                    [	376	,	0.93	,	1.73	],
                    [	331	,	0.94	,	1.33	],
                    [	340	,	0.91	,	1.73	],
                    [	330	,	0.96	,	1.46	],
                    [	150	,	0.95	,	1.88	]]
            },
            {
                name:'0%+',
                type:'scatter',
                symbolSize: function (value){
                    return Math.round(value[2]*6);
                },
                data: /*randomDataArray()*/[[	245	,	0.95	,	0.94	],
                    [	24	,	0.99	,	0.74	],
                    [	124	,	0.99	,	0.32	],
                    [	62	,	1.00	,	0.97	],
                    [	47	,	1.00	,	0.29	],
                    [	12	,	1.00	,	0.11	],
                    [	13	,	1.00	,	0.10	],
                    [	21	,	0.95	,	0.24	],
                    [	105	,	0.93	,	0.28	]]
            }

        ]
    };

    myChart8.setOption(option8);
</script>
</body>
</html>

