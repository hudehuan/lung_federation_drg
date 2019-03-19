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
    <title>交互效率</title>
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
            text: '交互效率'
        },
        tooltip : {
            trigger: 'axis'
        },
        legend: {
            data:['每CMI每床日费用']
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
                boundaryGap : false,
                data : ['	36	',
                    '	4	',
                    '	2	',
                    '	1	',
                    '	33	',
                    '	3	',
                    '	37	',
                    '	27	',
                    '	22	',
                    '	20	',
                    '	35	',
                    '	5	',
                    '	30	',
                    '	24	',
                    '	17	',
                    '	23	',
                    '	13	',
                    '	19	',
                    '	18	',
                    '	7	',
                    '	16	',
                    '	25	',
                    '	11	',
                    '	34	',
                    '	28	',
                    '	14	',
                    '	8	',
                    '	32	',
                    '	9	',
                    '	41	',
                    '	26	',
                    '	6	',
                    '	29	',
                    '	10	',
                    '	31	',
                    '	12	',
                    '	21	',
                    '	38	',
                    '	15	',
                    '	43	',
                    '	39	',
                    '	40	',
                    '	42	']
            }
        ],
        yAxis : [
            {
                type : 'value',
                axisLabel : {
                    formatter: '{value} '
                }
            }
        ],
        series : [
            {
                name:'每CMI每床日费用',
                type:'line',
                data:[2332.03 	,
                    1805.82 	,
                    1682.98 	,
                    1499.75 	,
                    1458.75 	,
                    1426.55 	,
                    1232.01 	,
                    1210.40 	,
                    1180.74 	,
                    1171.60 	,
                    1114.95 	,
                    1106.32 	,
                    1081.78 	,
                    1074.37 	,
                    1055.82 	,
                    1045.06 	,
                    1035.77 	,
                    1034.33 	,
                    1007.59 	,
                    999.83 	,
                    973.27 	,
                    967.36 	,
                    922.46 	,
                    916.45 	,
                    906.19 	,
                    887.61 	,
                    887.45 	,
                    870.51 	,
                    828.40 	,
                    806.36 	,
                    762.84 	,
                    692.33 	,
                    682.81 	,
                    667.65 	,
                    661.41 	,
                    582.90 	,
                    556.92 	,
                    501.41 	,
                    496.83 	,
                    490.94 	,
                    476.53 	,
                    258.15 	,
                    217.57 	],
                markLine : {
                    data : [
                        [
                            {name: '标线2起点', value: 1210,xAxis: 0, yAxis: 1210},
                            {name: '标线2终点', xAxis: 42, yAxis: 1210}
                        ],[
                            {name: '标线2起点', value: 1046,xAxis: 0, yAxis: 1046},
                            {name: '标线2终点', xAxis: 42, yAxis: 1046}
                        ],
                        [
                            {name: '标线2起点', value: 890,xAxis: 0, yAxis: 890},
                            {name: '标线2终点', xAxis: 42, yAxis: 890}
                        ]
                    ]
                }
            }
        ]
    };
    myChart8.setOption(option8);
</script>
</body>
</html>

