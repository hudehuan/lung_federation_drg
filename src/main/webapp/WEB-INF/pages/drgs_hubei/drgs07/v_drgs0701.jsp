<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/08/25
  Time: 10:19
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="format-detection" content="telephone=no,email=no,address=no">
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <link rel="stylesheet" href="${ctx }/static/js/layui/css/layui.css" />
    <link rel="stylesheet" href="${ctx }/static/css/base.css" />
    <link rel="stylesheet" href="${ctx }/static/css/my-stlye.css" />
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/assets/examples.css" />
    <link rel="stylesheet" href="${ctx }/static/js/plugins/layer/skin/layer.css" />


    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/my97DatePicker/WdatePicker.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/plugins/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/layui/layui.js"></script>
    <title></title>
    <style>
        body{overflow-y:auto;}

    </style>
</head>
<body>
<div id="loading" class="loader"></div>
<%--<div id="menu"  style="position:fixed;top: 10px;right: 20px;z-index:20000;font-size:12px;">--%>
    <%--<div class="xian" style="height: 45px;"></div>--%>
    <%--<ul>--%>
        <%--<li><a href="#item1" class="current"><span></span>- -CMI占比</a></li>--%>
        <%--<li><a href="#item2"><span></span>- -一级学科绩效</a></li>--%>
        <%--<li><a href="#item3"><span></span>- -一二级学科绩效</a></li>--%>
    <%--</ul>--%>
<%--</div>--%>
<div class="top-demand" id="top-demand" style="top: 0;">
    <ul>
        <li>
            <label>日期：</label>
            <select id="rqkj" disabled style="width: 60px;height: 24px;border-radius:2px;border: 1px solid #ddd">
                <option value="n">年</option>
                <option value="j">季</option>
                <option value="y">月</option>
            </select>
            <%--<input type="text" />--%>
            <input type="text" class="Wdate " id="rq" style="width: 80px;height: 24px;vertical-align: middle;margin-bottom: 3px;border-radius:2px;border: 1px solid #ddd"
                   onfocus="WdatePicker({el:'rq',startDate:'%y',dateFmt:'yyyy',alwaysUseStartDate:true,maxDate:'%y'})">

        </li>
        <li>
            <label>医院级别：</label>
            <select id="yyjb"  style="width: 100px;height: 24px;border-radius:2px;border: 1px solid #ddd">
                <option value="@novalue">全部</option>
                <option value="三级">三级</option>
                <option value="二级">二级</option>
            </select>
        </li>

    </ul>
    <div class="top-btn">查询</div>
</div>

<div class="main">

    <div id="item1" class="man-c-2  col-xs-6" style="padding-top: 46px;">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb" >
                <b class="back-b">CMI占比</b>
            </div>
            <div class="zhibiao2" id="data0" style="height:350px;">

            </div>
        </div>
    </div>

    <div class="man-c-2 col-xs-6" style="padding-top: 46px;">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">CMI、DRGs组数</b>
            </div>
            <div class="zhibiao2" id="data1" style="height:350px;">

            </div>
        </div>
    </div>


    <div id="item2" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">一级学科绩效</b>
            </div>
            <div class="col-xs-6 zhibiao2" style="width: 100%;" >
                <div  class="biaoge-yqst table-responsive" style="margin-top: 15px;">
                    <table id="table0" style="width: 100%"></table>
                </div>
            </div>
        </div>
    </div>

    <div id="item3" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">一二级学科绩效</b>
            </div>
            <div class="col-xs-6 zhibiao2" style="width: 100%;" >
                <div  class="biaoge-yqst table-responsive" style="margin-top: 15px;">
                    <table id="table1" style="width: 100%"></table>
                </div>
            </div>
        </div>
    </div>
</div>



<script type="text/javascript" src="${ctx}/static/js/echarts.min.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/macarons.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/dlchart.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/jsonpData.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/layuiData.js" ></script>

<script>
    var jsonpData =
        {
            "title":{
                "column":"一级学科,CMI,DRGs组数,患者数,权重数,费用,住院日,死亡人数",
            },
            "rows":{
                "row":[
                    {
                        "cell":[
                            "儿科",
                            "14.86",
                            "11.66",
                            "23.42",
                            "9.52",
                            "468785578.80",
                            "31484",
                            "14889.64",
                            "28.38",
                            "11.77",
                            "14.86",
                            "1.75",
                            "22.91",
                            "177547089.46",
                            "663295.00",
                            "267.67",
                            "365154757.40",
                            "27410.00",
                            "13321.95",
                            "41581963.55",
                            "-16909516.91",
                            "-3960315.37",
                            "42970382.90",
                            "54273624.30",
                            "6386769.06",
                            "20709358.37",
                            "103630821.40"
                        ]
                    },
                    {
                        "cell":[
                            "皮肤科",
                            "13.74",
                            "17.04",
                            "9.70",
                            "6.68",
                            "438478524.50",
                            "38064",
                            "11519.51",
                            "23.69",
                            "13.74",
                            "8.75",
                            "1.20",
                            "21.53",
                            "170608489.45",
                            "766888.00",
                            "222.47",
                            "354484898.52",
                            "35000.00",
                            "10128.14",
                            "16557111.92",
                            "11404479.61",
                            "1106768.17",
                            "48697950.00",
                            "31032620.96",
                            "4263157.68",
                            "29070236.85",
                            "83993625.98"
                        ]
                    },
                    {
                        "cell":[
                            "神经内科",
                            "22.98",
                            "5.74",
                            "4.10",
                            "10.26",
                            "317664720.26",
                            "27130",
                            "11708.98",
                            "24.54",
                            "1.26",
                            "22.98",
                            "0.29",
                            "19.90",
                            "83613922.49",
                            "304136.00",
                            "274.92",
                            "255079062.00",
                            "22060.00",
                            "11562.97",
                            "-3424571.36",
                            "8576129.40",
                            "-351255.70",
                            "3220980.60",
                            "58624257.90",
                            "740270.70",
                            "4800306.19",
                            "62585658.26"
                        ]
                    },
                    {
                        "cell":[
                            "普通外科",
                            "19.70",
                            "6.81",
                            "1.59",
                            "5.14",
                            "1185205076.98",
                            "58552",
                            "20241.92",
                            "19.70",
                            "5.88",
                            "13.05",
                            "0.77",
                            "16.20",
                            "368078358.72",
                            "1309341.00",
                            "281.12",
                            "990186256.92",
                            "51794.00",
                            "19117.78",
                            "5839660.86",
                            "18904757.76",
                            "299926.08",
                            "58223707.16",
                            "129197957.24",
                            "7596938.12",
                            "25053154.83",
                            "195018820.06"
                        ]
                    },
                    {
                        "cell":[
                            "妇科",
                            "17.87",
                            "10.79",
                            "12.86",
                            "1.83",
                            "391588095.20",
                            "30166",
                            "12981.11",
                            "17.87",
                            "10.65",
                            "6.52",
                            "0.69",
                            "15.42",
                            "175676942.24",
                            "859972.00",
                            "204.28",
                            "332229766.04",
                            "28320.00",
                            "11731.28",
                            "22600064.16",
                            "-3221087.04",
                            "-414383.04",
                            "35395185.60",
                            "21655942.88",
                            "2307186.18",
                            "18963326.27",
                            "59358329.16"
                        ]
                    },
                    {
                        "cell":[
                            "耳鼻喉科",
                            "11.44",
                            "9.57",
                            "1.66",
                            "11.43",
                            "454410947.22",
                            "42088",
                            "10796.69",
                            "16.36",
                            "4.41",
                            "11.44",
                            "0.50",
                            "14.92",
                            "105637094.40",
                            "667414.00",
                            "158.28",
                            "390520834.96",
                            "37766.00",
                            "10340.54",
                            "-1755298.82",
                            "12069799.68",
                            "-200553.28",
                            "17226960.90",
                            "44691813.88",
                            "1971480.30",
                            "10113788.45",
                            "63890112.26"
                        ]
                    },
                    {
                        "cell":[
                            "内分泌科",
                            "13.34",
                            "11.75",
                            "0.99",
                            "10.65",
                            "437593905.00",
                            "33292",
                            "13144.12",
                            "13.34",
                            "3.65",
                            "9.35",
                            "0.34",
                            "13.01",
                            "100797504.84",
                            "458426.00",
                            "219.88",
                            "386078504.46",
                            "30446.00",
                            "12680.76",
                            "994784.42",
                            "10736300.64",
                            "105956.76",
                            "14107458.56",
                            "36089442.96",
                            "1318722.56",
                            "11839238.32",
                            "51515400.54"
                        ]
                    },
                    {
                        "cell":[
                            "骨科",
                            "10.60",
                            "15.24",
                            "5.20",
                            "9.54",
                            "1029661689.58",
                            "55610",
                            "18515.76",
                            "10.60",
                            "5.60",
                            "4.73",
                            "0.27",
                            "11.89",
                            "355805816.65",
                            "889327.00",
                            "400.08",
                            "930945215.28",
                            "53096.00",
                            "17533.25",
                            "18515788.14",
                            "33959590.56",
                            "1767243.24",
                            "52167350.96",
                            "44078590.50",
                            "2470030.14",
                            "54239553.35",
                            "98716474.30"
                        ]
                    },
                    {
                        "cell":[
                            "外科",
                            "11.67",
                            "10.94",
                            "8.84",
                            "1.93",
                            "857491109.10",
                            "63080",
                            "13593.71",
                            "11.67",
                            "6.33",
                            "5.03",
                            "0.32",
                            "11.53",
                            "191169303.14",
                            "687586.00",
                            "278.03",
                            "767845747.82",
                            "60060.00",
                            "12784.64",
                            "16893988.02",
                            "3692794.46",
                            "326338.74",
                            "48592744.20",
                            "38609612.80",
                            "2443391.40",
                            "20911901.36",
                            "89645361.28"
                        ]
                    },
                    {
                        "cell":[
                            "内科",
                            "9.60",
                            "13.99",
                            "4.00",
                            "9.60",
                            "379267541.98",
                            "31528",
                            "12029.55",
                            "6.97",
                            "-4.49",
                            "12.01",
                            "-0.54",
                            "8.90",
                            "133835225.20",
                            "483310.00",
                            "276.91",
                            "354544186.72",
                            "28148.00",
                            "12595.72",
                            "5359907.90",
                            "12854439.11",
                            "514808.89",
                            "-15936553.16",
                            "42573533.60",
                            "-1913654.60",
                            "18727135.16",
                            "24723355.26"
                        ]
                    }
                ]
            }
        }
    //获取屏幕的高
    var H= 0;
    var biIds =[];//报表id
    var biKeys =[];//报表返回softkey
    var flag = true;
    $(function () {
        $(window).scroll(function () {
            var items = $(".main").find(".man-c-2");
            var menu = $("#menu");
            var top = $(document).scrollTop();
            var currentId = ""; //滚动条现在所在位置的item id
            items.each(function () {
                var m = $(this);
                //注意：m.offset().top代表每一个item的顶部位置
                if (top > m.offset().top - 300) {
                    currentId = "#" + m.attr("id");
                } else {
                    return false;
                }
            });
            var currentLink = menu.find(".current");
            if (currentId && currentLink.attr("href") != currentId) {
                currentLink.removeClass("current");
                menu.find("[href=" + currentId + "]").addClass("current");
            }
        });
        $('#menu li a').click(function () {
            $('html, body').animate({
                scrollTop: $($.attr(this, 'href')).offset().top-100
            }, 500);
            return false;
        });
        H=$('#top-demand').height();
        $('.main-center').css('padding-top',H+'px');
        $("#loading").fadeOut("slow");
        $.ajax({
            type:"POST",
            url:"/HBI/loadBiKsy?biIds="+biIds,
            dataType: "json",
            success:function(data){
                biKeys =data;
                search()
            }
        });

        var date = new Date;
        var year=date.getFullYear();
        $("#rq").val(year);
        $('.top-btn').click(function () {
            flag=false;
            search();
        })
    })

    function search(stats) {
//        data = jsonpDataInit(data);  //jsonp数据格式化
        setData0(jsonpData);
        setData1(jsonpData);
        setData2(jsonpData);
        setData3(jsonpData);
        /*var day = date.getDate();
         var srq = $("#srq").val()+"-01";
         var erq = $("#erq").val()+"-"+day;
         var yyjb = $("#yyjb").val();
         //费用增幅与机构动因 （费用动因分析）
         var cxtj0 = srq+";"+erq+"|"+yyjb+"|@novalue|";
         var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
         '&biyccs=&id=' +biKeys[0].id+'&softkey='+biKeys[0].softkey +
         '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=';
         $.ajax({
         type:"GET",
         url:url0,
         dataType: "jsonp",
         success:function(data){
         data1 = data;
         setData0_1(data);
         //                setData0(data);
         setData3(data);
         }
         });*/
    }



    function setData0(data) {
        var datay=data.rows.row;
        var x1=[],y1=[];
        for(var i=0;i<datay.length;i++){
            x1.push(datay[i].cell[0]);
            var j = '{"value":"'+datay[i].cell[2]+'","name":"'+datay[i].cell[0]+'"}';
            y1.push(JSON.parse(j));

        }

        var myChart = echarts.init(document.getElementById('data0'));
        var colors = ['#83be66','#22c3aa','#259f8e','#4ea397','#64cbbc','#23c4ae','#2ad5bd'];
        var   option = dlchart.CreatePieChart("",x1,{name:"科室",data:y1},{ },{
            index:0,option:{
            radius: ['0%', '55%'],
            center: ['50%', '45%']}
        });

        myChart.setOption(option);
    }

    function setData1(data) {
        var datax = [];
        var datay = [[],[]];
        for(var i=0;i<data.rows.row.length;i++){
            datax.push(data.rows.row[i].cell[0]);
            datay[0].push(data.rows.row[i].cell[1]);
            datay[1].push(data.rows.row[i].cell[2]);
        }
        var tit = data.title.column.split(",");
        var myChart = echarts.init(document.getElementById('data1'));
        var option = dlchart.CreateBarChart("",datax,[{name:tit[1],data:datay[0]},{name:tit[2],data:datay[1]}],{
            yAxis : [
                {
                    type : 'value'
                },{
                    type : 'value'
                }
            ],
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            }
        },{index:1,option:{
            yAxisIndex: 1,
            smooth:true,
            label: {
                normal: {
                    show: false,
                    position: 'inside'
                }
            },
            type:'line',
        }
        },null);
        myChart.setOption(option);
    }

    function setData2(data) {
        var width = $("#table0").width();
        var dataIndex = [0,1,2,3,4,5,6,7];
        var tableData = initLayuiTableData(data,dataIndex,width);//jsop数据格式化为layuiTable数据格式

        layui.use('table', function() {
            var table = layui.table;

            //方法级渲染
            window.demoTable = table.render({
                elem: '#table0',
                height:212,
                data: tableData.data,
                cols: [tableData.cols],
                skin: 'row', //表格风格
                even: true,
                page: true, //是否显示分页
                limits: [6, tableData.data.length],
                limit: 6, //每页默认显示的数量
            });
        });
    }

    function setData3(data) {
        data.title.column = "一二级学科,CMI,DRGs组数,患者数,权重数,费用,住院日,死亡人数";
        var width = $("#table1").width();
        var dataIndex = [0,1,2,3,4,5,6,7];
        var tableData = initLayuiTableData(data,dataIndex,width);//jsop数据格式化为layuiTable数据格式

        layui.use('table', function() {
            var table = layui.table;

            //方法级渲染
            window.demoTable = table.render({
                elem: '#table1',
                height:212,
                data: tableData.data,
                cols: [tableData.cols],
                skin: 'row', //表格风格
                even: true,
                page: true, //是否显示分页
                limits: [6, tableData.data.length],
                limit: 6, //每页默认显示的数量
            });
        });
    }

</script>
</body>
</html>
