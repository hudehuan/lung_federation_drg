<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/10/19
  Time: 10:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>首页</title>
    <meta name="format-detection" content="telephone=no,email=no,address=no">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/bootstrap-3.3.5/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/index.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/creat-css/create.css">
    <link rel="stylesheet" href="${ctx}/static/js/plugins/metisMenu/metisMenu.css" />
    <link rel="stylesheet" href="${ctx}/static/js/plugins/layer/skin/layer.css" />

    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/bootstrap.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/my97DatePicker/WdatePicker.js" ></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/metisMenu/jquery.metisMenu.min.js" ></script>
    <script type="text/javascript" src="${ctx}/static/js/common.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/index.js"></script>
    <script language="JavaScript">
        function startTime()
        {
            var today=new Date();//定义日期对象
            var yyyy = today.getFullYear();//通过日期对象的getFullYear()方法返回年
            var MM = today.getMonth()+1;//通过日期对象的getMonth()方法返回年
            var dd = today.getDate();//通过日期对象的getDate()方法返回年
            var hh=today.getHours();//通过日期对象的getHours方法返回小时
            var mm=today.getMinutes();//通过日期对象的getMinutes方法返回分钟
            var ss=today.getSeconds();//通过日期对象的getSeconds方法返回秒
            // 如果分钟或小时的值小于10，则在其值前加0，比如如果时间是下午3点20分9秒的话，则显示15：20：09
            MM=checkTime(MM);
            dd=checkTime(dd);
            mm=checkTime(mm);
            ss=checkTime(ss);
            var day; //用于保存星期（getDay()方法得到星期编号）
            if(today.getDay()==0)   day   =   "星期日 "
            if(today.getDay()==1)   day   =   "星期一 "
            if(today.getDay()==2)   day   =   "星期二 "
            if(today.getDay()==3)   day   =   "星期三 "
            if(today.getDay()==4)   day   =   "星期四 "
            if(today.getDay()==5)   day   =   "星期五 "
            if(today.getDay()==6)   day   =   "星期六 "
            document.getElementById('nowDateTimeSpan').innerHTML=yyyy+"-"+MM +"-"+ dd +" " + hh+":"+mm+":"+ss+"   " + day;
            setTimeout('startTime()',1000);//每一秒中重新加载startTime()方法
        }

        function checkTime(i)
        {
            if (i<10){
                i="0" + i;
            }
            return i;
        }
    </script>
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
    <div style="min-width: 800px;margin-top: 10px;">
        <div id="main2" style="width: 98%;height: 400px;margin-left: 10px;border-style:solid; border-width:5px; border-color:#c6daeb"></div>
        <div id="main1" style="width: 98%;height: 400px;margin: 5px 0 0 10px;border-style:solid; border-width:5px; border-color:#c6daeb"></div>
        <!--<div id="main2" style="width: 49%;height: 300px;position: absolute;top: 10px;right: 10px;border-style:solid; border-width:5px; border-color:#c6daeb"></div>
        <div id="main3" style="width: 49%;height: 300px;margin: 5px 0 0 10px;border-style:solid; border-width:5px; border-color:#c6daeb"></div>
        <div id="main4" style="width: 49%;height: 300px;position: absolute;top: 315px;right: 10px;border-style:solid; border-width:5px; border-color:#c6daeb"></div>
        <div id="main5" style="width: 49%;height: 300px;margin: 5px 0 0 10px;border-style:solid; border-width:5px; border-color:#c6daeb"></div>
        <div id="main6" style="width: 49%;height: 300px;position: absolute;top: 620px;right: 10px;border-style:solid; border-width:5px; border-color:#c6daeb"></div>-->
        <!--<div id="main7" style="width: 49%;height: 300px;margin: 5px 0 0 10px;border-style:solid; border-width:5px; border-color:#c6daeb"></div>-->
        <div id="main8" style="width: 98%;height: 400px;margin: 5px 0 0 10px;border-style:solid; border-width:5px; border-color:#c6daeb"></div>
    </div>
    <script type="text/javascript" src="${ctx}/static/js/echarts-2.2.7/build/dist/echarts-all.js"></script>
    <script>
        /*WdatePicker({eCont:'div1',onpicked:function(dp){}});*/
        layer.open({
            title:"绩效评价平台提醒",
            type: 1,shade: 0,
            skin: 'tsxx-class',
            area: ['380px', '240px'], //宽高
            content: '<h1 style="    font-size: 18px;text-align: center; margin-top: 10px;"><a style="font: "微软雅黑", "宋体"">欢迎，</a><a style="font-weight:bold;font-size: 20px;">管理员   </a><a style="font: "微软雅黑", "宋体"">登录系统！</a></h1><p><span><a style="font-size: 16px;  font: "微软雅黑", "宋体"">当前时间：<a id="nowDateTimeSpan"></a> </a></span><span></span></p><p style="margin-top: 16px"><span><a style="font-size: 16px;  font: "微软雅黑", "宋体"">提醒消息：</a><a style="font-size: 16px;  font: "微软雅黑", "宋体"">今日更新5张报表，详见公示排名主题。</a></span><span></span></p>',
            offset: 'rb',
        });
        var myChart2 = echarts.init(document.getElementById('main2'));
        option2 = {
            title : {
                text: '费用增幅与机构动因'
            },
            tooltip : {
                trigger: 'axis'
            },
            legend: {
                data:['总费用增幅','门诊','住院']
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
                    data : ['	18	',
                        '	22	',
                        '	41	',
                        '	40	',
                        '	27	',
                        '	24	',
                        '	28	',
                        '	2	',
                        '	8	',
                        '	36	',
                        '	30	',
                        '	35	',
                        '	25	',
                        '	16	',
                        '	1	',
                        '	43	',
                        '	21	',
                        '	11	',
                        '	33	',
                        '	19	',
                        '	9	',
                        '	4	',
                        '	5	',
                        '	3	',
                        '	15	',
                        '	14	',
                        '	31	',
                        '	29	',
                        '	10	',
                        '	42	',
                        '	39	',
                        '	12	',
                        '	7	',
                        '	20	',
                        '	23	',
                        '	26	',
                        '	13	',
                        '	38	',
                        '	37	',
                        '	17	',
                        '	34	',
                        '	6	']
                }
            ],
            yAxis : [
                {
                    type : 'value',
                    name:'占比（%）',
                    axisLabel : {
                        formatter: '{value} %'
                    }
                }
            ],
            series : [
                {
                    name:'总费用增幅',
                    type:'line',
                    data:[30.31 	,
                        29.20 	,
                        26.26 	,
                        23.03 	,
                        19.00 	,
                        17.26 	,
                        16.68 	,
                        16.64 	,
                        16.40 	,
                        14.37 	,
                        13.83 	,
                        13.59 	,
                        12.58 	,
                        12.30 	,
                        12.14 	,
                        11.66 	,
                        11.46 	,
                        9.92 	,
                        9.42 	,
                        8.98 	,
                        7.70 	,
                        7.60 	,
                        7.57 	,
                        7.30 	,
                        7.03 	,
                        6.89 	,
                        6.24 	,
                        5.58 	,
                        5.05 	,
                        4.29 	,
                        3.94 	,
                        3.53 	,
                        3.31 	,
                        3.11 	,
                        2.60 	,
                        2.33 	,
                        1.94 	,
                        1.42 	,
                        0.92 	,
                        0.43 	,
                        -5.68 	,
                        -6.39 	],
                    markPoint : {
                        data : [
                            {type : 'max', name: '最大值'},
                            {type : 'min', name: '最小值'}
                        ]
                    }/*,
                 markLine : {
                 data : [
                 {type : 'average', name: '平均值'}
                 ]
                 }*/
                },
                {
                    name:'门诊',
                    type:'line',
                    data:[21.35 	,
                        15.36 	,
                        20.04 	,
                        16.99 	,
                        14.68 	,
                        10.58 	,
                        12.56 	,
                        13.35 	,
                        15.37 	,
                        18.50 	,
                        15.33 	,
                        15.50 	,
                        0.37 	,
                        24.85 	,
                        18.23 	,
                        14.04 	,
                        13.82 	,
                        9.69 	,
                        11.57 	,
                        15.84 	,
                        5.51 	,
                        4.17 	,
                        4.90 	,
                        8.39 	,
                        -1.85 	,
                        9.50 	,
                        -1.71 	,
                        4.67 	,
                        10.51 	,
                        0.06 	,
                        4.35 	,
                        8.41 	,
                        -6.80 	,
                        4.62 	,
                        4.38 	,
                        -4.66 	,
                        16.25 	,
                        -4.57 	,
                        -3.17 	,
                        2.44 	,
                        -4.43 	,
                        -3.25 	],
                    markPoint : {
                        data : [
                            {type : 'max', name: '最大值'},
                            {type : 'min', name: '最小值'}
                        ]
                    }/*,
                 markLine : {
                 data : [
                 {type : 'average', name : '平均值'}
                 ]
                 }*/
                },
                {
                    name:'住院',
                    type:'line',
                    data:[34.50 	,
                        33.46 	,
                        29.93 	,
                        25.61 	,
                        20.41 	,
                        19.99 	,
                        18.53 	,
                        17.76 	,
                        16.82 	,
                        13.78 	,
                        13.46 	,
                        11.91 	,
                        16.00 	,
                        7.96 	,
                        10.13 	,
                        7.81 	,
                        10.20 	,
                        10.04 	,
                        9.17 	,
                        6.94 	,
                        8.24 	,
                        8.69 	,
                        8.81 	,
                        6.78 	,
                        10.51 	,
                        5.79 	,
                        8.86 	,
                        6.03 	,
                        1.70 	,
                        6.11 	,
                        3.80 	,
                        1.90 	,
                        6.17 	,
                        2.40 	,
                        1.70 	,
                        3.90 	,
                        -3.57 	,
                        3.44 	,
                        4.32 	,
                        -0.34 	,
                        -6.80 	,
                        -7.45 	],
                    markPoint : {
                        data : [
                            {type : 'max', name: '最大值'},
                            {type : 'min', name: '最小值'}
                        ]
                    }/*,
                 markLine : {
                 data : [
                 {type : 'average', name : '平均值'}
                 ]
                 }*/
                }
            ]
        };

        myChart2.setOption(option2);

        var myChart1 = echarts.init(document.getElementById('main1'));
        option1 = {
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

        myChart1.setOption(option1);


        // 标准气泡图  三个值
        var myChart8 = echarts.init(document.getElementById('main8'));
        function random(){
            var r = Math.round(Math.random() * 100);
            return (r * (r % 2 == 0 ? 1 : -1));
        }

        function randomDataArray() {
            var d = [];
            var len = 100;
            while (len--) {
                d.push([
                    random(),
                    random(),
                    Math.abs(random()),
                ]);
            }
            return d;
        }

        option8 = {
            title : {
                text: '39种病种工作量分布和机构内占比'
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
                    scale: true
                }
            ],
            yAxis : [
                {
                    type : 'value',
                    name:'费用占比%',
                    splitNumber: 4,
                    scale: true
                }
            ],
            series : [
                {
                    name:'5%+',
                    type:'scatter',
                    symbolSize: function (data){
                        return [6.33*2,5.42*2,5.23*2]/*[10,8,1]Math.round(value)*/;
                    },
                    data: /*randomDataArray()*/[['23.98','23.95'],['20.23','27.54'],['21.12','21.92']]
                },
                {
                    name:'4%+',
                    type:'scatter',
                    symbolSize: function (data){
                        return [4.88*2,4.60*2]/*[10,8,1]Math.round(value)*/;
                    },
                    data: /*randomDataArray()*/[[14.38,19.78],[15.00,21.28]]
                },
                {
                    name:'3%+',
                    type:'scatter',
                    symbolSize: function (data){
                        return [3.96*2,3.75*2,3.55*2,3.53*2,3.31*2,3.12*2,3.11*2]/*[10,8,1]Math.round(value)*/;
                    },
                    data: /*randomDataArray()*/[[5.13,13.32],[14.43,18.57],[19.73,27.23],[13.61,17.12],[12.85,15.99],[19.86,20.87],[18.84,19.26]]
                },
                {
                    name:'2%+',
                    type:'scatter',
                    symbolSize: function (data){
                        return [2.90*2,2.85*2,2.76*2,2.63*2,
                            2.48*2,2.45*2,2.45*2,2.31*2,
                            2.30*2,2.28*2,2.20*2,2.10*2,
                            2.03*2,2.00*2]/*[10,8,1]Math.round(value)*/;
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
                        return [1.92*2,1.85*2,1.85*2,1.73*2,
                            1.53*2,1.41*2,1.25*2,1.01*2,
                            0.94*2,0.73*2,0.72*2,0.21*2,
                            0.19*2,0.07*2,0.03*2]/*[10,8,1]Math.round(value)*/;
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
