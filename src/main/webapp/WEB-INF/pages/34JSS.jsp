<%--
  Created by IntelliJ IDEA.
  User: DL
  Date: 2017-06-17
  Time: 14:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>三、四级手术服务</title>
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
            text: '三、四级手术服务'
        },
        tooltip : {
            trigger: 'axis'
        },
        legend: {
            data:['手术操作构成','3、4级数据操作占比','3、4级常规手术','3、4级微创手术占比']
        },
        toolbox: {
            show : true,
            feature : {
                mark : {show: true},
                dataView : {show: true, readOnly: false},
                magicType : {show: true, type: ['line', 'bar']},
                restore : {show: true},
                saveAsImage : {show: true}
            }
        },
        calculable : true,
        xAxis : [
            {
                type : 'category',
                name:'医疗机构',
                boundaryGap : false,
                data : ['	30	',
                    '	4	',
                    '	2	',
                    '	1	',
                    '	35	',
                    '	7	',
                    '	17	',
                    '	3	',
                    '	41	',
                    '	27	',
                    '	33	',
                    '	24	',
                    '	8	',
                    '	14	',
                    '	25	',
                    '	10	',
                    '	19	',
                    '	20	',
                    '	34	',
                    '	5	',
                    '	23	',
                    '	13	',
                    '	36	',
                    '	32	',
                    '	26	',
                    '	28	',
                    '	21	',
                    '	16	',
                    '	31	',
                    '	29	',
                    '	15	',
                    '	6	',
                    '	22	',
                    '	12	',
                    '	37	',
                    '	38	',
                    '	9	',
                    '	99	',
                    '	43	',
                    '	11	',
                    '	18	'
                ]
            }
        ],
        yAxis : [
            {
                type : 'value',
                name:'占比（%）'
            },
            {
                type : 'value',
                name:'占比',
                axisLabel : {
                formatter: function (value) {
                    // Function formatter
                    return value + ' %'
                }
            },
                splitLine : {
                    show: false
                }
            }
        ],
        series : [
            {
                name:'手术操作构成',
                type:'line',
                stack: '总量',
                data:[5.97 	,
                    5.96 	,
                    5.43 	,
                    5.11 	,
                    4.81 	,
                    4.81 	,
                    4.74 	,
                    4.63 	,
                    4.34 	,
                    3.52 	,
                    3.37 	,
                    3.10 	,
                    3.00 	,
                    2.97 	,
                    2.93 	,
                    2.71 	,
                    2.68 	,
                    2.66 	,
                    2.62 	,
                    2.29 	,
                    2.29 	,
                    2.18 	,
                    2.06 	,
                    1.88 	,
                    1.87 	,
                    1.81 	,
                    1.52 	,
                    1.38 	,
                    1.31 	,
                    1.20 	,
                    1.18 	,
                    1.16 	,
                    0.92 	,
                    0.82 	,
                    0.29 	,
                    0.21 	,
                    0.10 	,
                    0.09 	,
                    0.09 	,
                    0.01 	,
                    0.00 	]/*,
             markLine : {
             data : [
             {type : 'average', name: '平均值'}
             ]
             }*/
            },
            {
                name:'3、4级数据操作占比',
                type:'line',
                yAxisIndex:'1',
                data:[17.73 	,
                    18.01 	,
                    17.14 	,
                    12.80 	,
                    11.23 	,
                    4.57 	,
                    20.69 	,
                    19.57 	,
                    12.58 	,
                    11.87 	,
                    60.67 	,
                    12.12 	,
                    21.25 	,
                    16.59 	,
                    17.60 	,
                    10.19 	,
                    10.61 	,
                    10.54 	,
                    15.93 	,
                    6.46 	,
                    9.82 	,
                    11.35 	,
                    7.12 	,
                    7.32 	,
                    16.68 	,
                    15.77 	,
                    7.83 	,
                    19.87 	,
                    23.84 	,
                    15.24 	,
                    8.88 	,
                    5.98 	,
                    7.40 	,
                    13.14 	,
                    22.93 	,
                    0.00 	,
                    3.77 	,
                    22.92 	,
                    0.00 	,
                    75.00 	,
                    100.00 	]/*,
             markLine : {
             data : [
             {type : 'average', name : '平均值'}
             ]
             }*/
            },
            {
                name:'3、4级常规手术',
                type:'line',
                yAxisIndex:'1',
                data:[25.66 	,
                    24.88 	,
                    28.40 	,
                    25.47 	,
                    17.18 	,
                    10.68 	,
                    33.75 	,
                    29.61 	,
                    13.87 	,
                    19.19 	,
                    68.32 	,
                    15.35 	,
                    24.93 	,
                    23.89 	,
                    23.13 	,
                    12.63 	,
                    21.53 	,
                    13.84 	,
                    16.39 	,
                    11.55 	,
                    12.02 	,
                    15.17 	,
                    97.92 	,
                    9.21 	,
                    19.65 	,
                    24.56 	,
                    7.98 	,
                    26.55 	,
                    24.93 	,
                    21.46 	,
                    10.22 	,
                    10.11 	,
                    8.22 	,
                    16.20 	,
                    35.29 	,
                    0.00 	,
                    3.77 	,
                    22.92 	,
                    0.00 	,
                    100.00 	,
                    100.00 	]
            } ,/*,
             markLine : {
             data : [
             {type : 'average', name : '平均值'}
             ]
             }*/
            {
                name:'3、4级微创手术占比',
                type:'line',
                yAxisIndex:'1',
                data:[13.20 	,
                    12.98 	,
                    14.66 	,
                    9.44 	,
                    11.16 	,
                    5.66 	,
                    19.27 	,
                    18.24 	,
                    13.45 	,
                    8.83 	,
                    26.18 	,
                    11.51 	,
                    16.04 	,
                    15.75 	,
                    11.85 	,
                    8.10 	,
                    10.62 	,
                    4.46 	,
                    7.98 	,
                    8.13 	,
                    7.72 	,
                    6.41 	,
                    2.08 	,
                    6.14 	,
                    12.36 	,
                    17.29 	,
                    6.01 	,
                    10.09 	,
                    14.37 	,
                    16.31 	,
                    5.02 	,
                    5.85 	,
                    6.67 	,
                    10.06 	,
                    4.90 	,
                    0.00 	,
                    0.00 	,
                    22.92 	,
                    0.00 	,
                    0.00 	,
                    0.00 	]
            }/*,
             markLine : {
             data : [
             {type : 'average', name : '平均值'}
             ]
             }*/

        ]
    };

    myChart8.setOption(option8);
</script>
</body>
</html>

