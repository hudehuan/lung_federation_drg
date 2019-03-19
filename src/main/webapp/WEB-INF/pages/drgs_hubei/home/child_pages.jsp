<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/08/02
  Time: 12:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../../static/css/base.css" />
    <link rel="stylesheet" href="../../static/js/bootstrap-3.3.5/css/bootstrap.css" />
    <link rel="stylesheet" href="../../static/js/bootstrap-3.3.5/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../../static/css/my-stlye.css" />
    <title></title>
</head>
<body>
<div id="loading" class="loader"></div>
<div class="top-demand" id="top-demand">
    <ul>
        <li>
            <label>监测对象：</label>
            <input type="text" />
        </li>
        <li>
            <label>监测对象：</label>
            <input type="text" />
        </li>
        <li>
            <label>监测对象：</label>
            <input type="text" />
        </li>
        <li>
            <label>监测对象：</label>
            <input type="text" />
        </li>
        <li>
            <label>监测对象：</label>
            <input type="text" />
        </li>
        <li>
            <label>监测对象：</label>
            <input type="text" />
        </li>
    </ul>
    <div class="top-btn" style="margin: 5px 20px;">查询</div>
</div>
<div class="main-center">
    <div class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <!--<b class="back-b">产能</b>-->
                <ul>
                    <li><a class="active">常规指标1</a></li>
                    <li><a>rdgs</a></li>
                    <li><a>指标3</a></li>
                </ul>
                <div>

                </div>
            </div>
            <div class=" zhibiao2">
                <!--<p class="tit-zhibiao">机构数据</p>-->
                <div  class="biaoge-yqst table-responsive mar-20">
                    <table class="table">
                        <thead>
                        <tr>
                            <td></td>
                            <td>姓名</td>
                            <td>年龄</td>
                            <td>拼音</td>
                            <td>职位</td>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><label><input type="checkbox"/></label></td>
                            <td>张三</td>
                            <td>21</td>
                            <td>zhangsan</td>
                            <td>总经理</td>
                        </tr>
                        <tr>
                            <td><label><input type="checkbox"/></label></td>
                            <td>李四</td>
                            <td>30</td>
                            <td>lisi</td>
                            <td>设计师</td>
                        </tr>
                        <tr>
                            <td><label><input type="checkbox"/></label></td>
                            <td>王五</td>
                            <td>36</td>
                            <td>wangwu</td>
                            <td>工程师</td>
                        </tr>
                        <tr>
                            <td><label><input type="checkbox"/></label></td>
                            <td>赵六</td>
                            <td>26</td>
                            <td>zhaoliu</td>
                            <td>工程师</td>
                        </tr>
                        <tr>
                            <td><label><input type="checkbox"/></label></td>
                            <td>李四</td>
                            <td>28</td>
                            <td>lisi</td>
                            <td>人事经理</td>
                        </tr>
                        <tr>
                            <td><label><input type="checkbox"/></label></td>
                            <td>李四</td>
                            <td>28</td>
                            <td>lisi</td>
                            <td>工程师</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>

    </div>
    <div class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">同步机构图</b>
            </div>
            <div class="zhibiao2" id="tb-goutu" style="height:350px;">

            </div>
        </div>

    </div>
    <div class="man-c-2 col-xs-6">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb" >
                <b class="back-b">指标月份图</b>
            </div>
            <div class="zhibiao2" id="tb-yft" style="height:350px;">

            </div>
        </div>
    </div>
    <div class="man-c-2 col-xs-6">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">指标增长图</b>
            </div>
            <div class="zhibiao2" id="tb-zeng" style="height:350px;">

            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="../../static/js/bootstrap-3.3.5/bootstrap.min.js" ></script>
<script type="text/javascript" src="../../static/js/jquery-1.11.2.min.js" ></script>
<script type="text/javascript" src="../../static/js/echarts.min.js" ></script>
<script type="text/javascript" src="../../static/js/macarons.js" ></script>
<script>
    //获取屏幕的高
    var H= 0;
    $(document).ready(function () {
        H=$('#top-demand').height();
        $('.main-center').css('padding-top',H+'px');
        $("#loading").fadeOut("slow");
    })
    //tab标签的点击状态
    $('.zhibiao-top ul li a').click(function(){
        $(this).parent('li').siblings('li').children('a').removeClass('active');
        $(this).addClass('active');

    })
    $(window).load(function() {
        var myChart = echarts.init(document.getElementById('tb-goutu'));
        // 指定图表的配置项和数据
        //	        app.title = '多 X 轴示例';
        var colors = ['#4ea397', '#22c3aa'];
        var option = {
            color:colors,
//				title: {
//				        text: '未来一周气温变化',
//				        subtext: '纯属虚构'
//				    },
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data:['最高气温','最低气温']
            },
//				    toolbox: {
//				        show: true,
//				        feature: {
//				            dataZoom: {
//				                yAxisIndex: 'none'
//				            },
//				            dataView: {readOnly: false},
//				            magicType: {type: ['line', 'bar']},
//				            restore: {},
//				            saveAsImage: {}
//				        }
//				    },
            xAxis:  {
                type: 'category',
                boundaryGap: false,
                data: ['周一','周二','周三','周四','周五','周六','周日']
            },
            yAxis: {
                type: 'value',
                axisLabel: {
                    formatter: '{value} °C'
                }
            },
            series: [
                {
                    name:'最高气温',
                    type:'line',
                    data:[11, 11, 15, 13, 12, 13, 10],
                    markPoint: {
                        data: [
                            {type: 'max', name: '最大值'},
                            {type: 'min', name: '最小值'}
                        ]
                    },
                    markLine: {
                        data: [
                            {type: 'average', name: '平均值'}
                        ]
                    }
                },
                {
                    name:'最低气温',
                    type:'line',
                    data:[1, -2, 2, 5, 3, 2, 0],
                    markPoint: {
                        data: [
                            {name: '周最低', value: -2, xAxis: 1, yAxis: -1.5}
                        ]
                    },
                    markLine: {
                        data: [
                            {type: 'average', name: '平均值'},
                            [{
                                symbol: 'none',
                                x: '90%',
                                yAxis: 'max'
                            }, {
                                symbol: 'circle',
                                label: {
                                    normal: {
                                        position: 'start',
                                        formatter: '最大值'
                                    }
                                },
                                type: 'max',
                                name: '最高点'
                            }]
                        ]
                    }
                }
            ]
        };
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    });
    $(window).load(function() {
        var myChart = echarts.init(document.getElementById('tb-zeng'));
        // 指定图表的配置项和数据
        //	        app.title = '多 X 轴示例';
        var colors = ['#4ea397', '#22c3aa','#7bd9a5'];
        var option = {
//				title: {
//				        text: '对数轴示例',
//				        left: 'center'
//				    },
            color:colors,
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c}'
            },
            legend: {
                left: 'left',
                data: ['2的指数', '3的指数']
            },
            xAxis: {
                type: 'category',
                name: 'x',
                splitLine: {show: false},
                data: ['一', '二', '三', '四', '五', '六', '七', '八', '九']
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            yAxis: {
                type: 'log',
                name: 'y'
            },
            series: [
                {
                    name: '3的指数',
                    type: 'line',
                    data: [1, 3, 9, 27, 81, 247, 741, 2223, 6669]
                },
                {
                    name: '2的指数',
                    type: 'line',
                    data: [1, 2, 4, 8, 16, 32, 64, 128, 256]
                },
                {
                    name: '1/2的指数',
                    type: 'line',
                    data: [1/2, 1/4, 1/8, 1/16, 1/32, 1/64, 1/128, 1/256, 1/512]
                }
            ]
        };
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    });
    $(window).load(function() {
        var myChart = echarts.init(document.getElementById('tb-yft'));
        // 指定图表的配置项和数据
        //	        app.title = '多 X 轴示例';
        var colors = ['#4ea397', '#22c3aa','#7bd9a5'];
        var option = {
            color:colors,
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b}: {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                x: 'left',
                data:['直达','营销广告','搜索引擎','邮件营销','联盟广告','视频广告','百度','谷歌','必应','其他']
            },
            series: [
                {
                    name:'访问来源',
                    type:'pie',
                    selectedMode: 'single',
                    radius: [0, '30%'],

                    label: {
                        normal: {
                            position: 'inner'
                        }
                    },
                    labelLine: {
                        normal: {
                            show: false
                        }
                    },

                },
                {
                    name:'访问来源',
                    type:'pie',
                    radius: ['40%', '55%'],

                    data:[
                        {value:335, name:'直达'},
                        {value:310, name:'邮件营销'},
                        {value:234, name:'联盟广告'},

                    ]
                }
            ]
        };
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    });
</script>
</body>
</html>

