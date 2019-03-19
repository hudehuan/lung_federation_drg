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
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/login-1.css">
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/tanchuan_hubei.css">
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/assets/examples.css" />
    <link rel="stylesheet" href="${ctx }/static/js/plugins/layer/skin/layer.css" />
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/bootstrap-table.css" />


    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/my97DatePicker/WdatePicker.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/plugins/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/layui/layui.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/hubeiCon.js"></script>
    <title></title>
    <style>
        body{overflow-y:auto;}
        .table th{
            font-weight:inherit;
            background: #F3F3F3;
            /*border:none!important;*/
            text-align: center !important;
        }
        .bootstrap-table .table:not(.table-condensed) > tbody > tr > td:first-child{
            padding-right:12px;
            text-align: left;
        }
        .bootstrap-table .table:not(.table-condensed) > tbody > tr > td{
            padding-right:12px;
            text-align: right;
        }
        .fixed-table-container{
            border:none;
        }
        .pagination{
            margin-right: 4px;
        }
        .pull-right{
            margin-top: 6px!important;
            margin-bottom: 0px!important;
        }
    </style>
</head>
<body>
<div id="loading" class="loader">
    <img class="Rotation" src="${ctx}/static/img/load.png" width="32" height="32"/>
</div>
<%--<div id="menu"  style="position:fixed;top: 10px;right: 20px;z-index:20000;font-size:12px;">
    <div class="xian" style="height: 45px;"></div>
    <ul>
        <li><a href="#item1" class="current"><span></span>- -费率预测值评估</a></li>
        <li><a href="#item2"><span></span>- -年度指标分析</a></li>
        <li><a href="#item3"><span></span>- -每权重费率情况</a></li>
    </ul>
</div>--%>
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
            <div class="center-back-cs">
                <input hidden style="width: 150px; height: 24px;border-radius:2px;cursor: pointer" class="sj-pt"
                       id="sj-pt" readonly="readonly" value="" type="text" placeholder="平台机构选择"/>
                <input hidden style="width: 150px; height: 24px;border-radius:2px;cursor: pointer" class="sj-jb"
                       id="sj-jb" readonly="readonly" value="" type="text" placeholder="平台机构选择"/>
            </div>
        </li>

    </ul>
    <div class="top-btn">查询</div>
</div>

<div class="main">
    <div id="item1" class="man-c-2" style="padding-top: 46px;">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b zbmca">费率预测值评估</b>
            </div>
            <div class="zhibiao2" id="data0" style="height:350px;"></div>
        </div>
    </div>
    <div id="item2" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">费率预测值评估</b>
            </div>
            <div class="col-xs-6 zhibiao2" style="width: 100%;"  id="data1">
                <div  class="biaoge-yqst table-responsive" style="margin-top: 15px;">
                    <table class="table" id="table1" style="font-size: 12px;">
                        <thead id="thead1">
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div id="item3" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">每权重费率情况</b>
            </div>
            <div class="col-xs-6 zhibiao2" style="width: 100%;"  id="data2">
                <div  class="biaoge-yqst table-responsive" style="margin-top: 15px;">
                    <table class="table" id="table2" style="font-size: 12px;">
                        <thead id="thead2">
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/bootstrap.min.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/bootstrap-table.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/extensions/toolbar/bootstrap-table-toolbar.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/ga.js" ></script>


<script type="text/javascript" src="${ctx}/static/js/echarts.min.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/macarons.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/dlchart.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/jsonpData.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/layuiData.js" ></script>

<script>
    var jsonpData =
        {
            "title":{
                "column":"年份,预算总额/总费用,上年度总权重数,每权重费率",
            },
            "rows":{
                "row":[
                    {
                        "cell":[
                            "2014",
                            "198256447.83",
                            "330.36",
                            "11.66",
                            "23.42",
                            "-9.52",
                            "-2.23",
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
                            "2015",
                            "199678726.30",
                            "244.06",
                            "17.04",
                            "9.70",
                            "6.68",
                            "0.65",
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
                            "2016",
                            "88414228.68",
                            "263.66",
                            "5.74",
                            "4.10",
                            "10.26",
                            "-0.42",
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
                            "2017",
                            "393131513.55",
                            "285.58",
                            "6.81",
                            "1.59",
                            "5.14",
                            "0.08",
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
                            "2018",
                            "194640268.51",
                            "230.56",
                            "10.79",
                            "12.86",
                            "-1.83",
                            "-0.24",
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
                    }
                ]
            }
        }

    var jsonpshiData =
        {
            "title":{
                "column":"区域,总费用,费用占比,总权重,每权重费率",
            },
            "rows":{
                "row":[
                    {
                        "cell":[
                            "A市",
                            "198256447.83",
                            "14.86",
                            "330.36",
                            "11.66",
                            "23.42",
                            "-9.52",
                            "-2.23",
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
                            "B市",
                            "199678726.30",
                            "13.74",
                            "244.06",
                            "17.04",
                            "9.70",
                            "6.68",
                            "0.65",
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
                            "C市",
                            "88414228.68",
                            "22.98",
                            "263.66",
                            "5.74",
                            "-4.10",
                            "10.26",
                            "-0.42",
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
                            "D市",
                            "393131513.55",
                            "19.70",
                            "285.58",
                            "6.81",
                            "1.59",
                            "5.14",
                            "0.08",
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
                            "E市",
                            "194640268.51",
                            "17.87",
                            "230.56",
                            "10.79",
                            "12.86",
                            "-1.83",
                            "-0.24",
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
                            "F市",
                            "115750882.85",
                            "11.44",
                            "155.65",
                            "9.57",
                            "-1.66",
                            "11.43",
                            "-0.19",
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
                            "G市",
                            "112636743.16",
                            "13.34",
                            "222.05",
                            "11.75",
                            "0.99",
                            "10.65",
                            "0.11",
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
                            "H市",
                            "410045370.00",
                            "10.60",
                            "420.90",
                            "15.24",
                            "5.20",
                            "9.54",
                            "0.50",
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
                            "I市",
                            "212081204.50",
                            "11.67",
                            "302.60",
                            "10.94",
                            "8.84",
                            "1.93",
                            "0.17",
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
                            "J市",
                            "152562360.36",
                            "9.60",
                            "288.00",
                            "13.99",
                            "4.00",
                            "9.60",
                            "0.38",
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
    $(function () {
        hubeiCon.initCon('sj-pt','sj-jb');
    });
    $('body').delegate('.page-list button', 'click', function () {
        $(this).next().find("li").each(function () {
            if ($(this).hasClass("active")) {
                $(this).removeClass("active");
            } else {
                $(this).addClass("active");
                $(this).children().trigger("click");
            }
        })
    });
    //获取屏幕的高
    var H= 0;
    var loads=0;
    var biIds =['0b53ef78-a66f-4293-a9de-c4bd7689ac15'];//报表id
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
        $("#loading").show();
        var bivar = "";
        $(".center-back-cs").find("input").each(function(){
            if($(this).css("display")!='none'){
                bivar=$(this).val();
                return false;
            }
        })
        if(bivar == "全省"){
            bivar = "@novalue|@novalue|@novalue|";
        }else {
            bivar = bivar.replace("全省","@novalue");
            if(bivar.indexOf("二级")>-1||bivar.indexOf("三级")>-1){
                bivar = bivar.replace("二级","|二级|");
                bivar = bivar.replace("三级","|三级|");
                if(bivar.indexOf("全部")>-1){
                    bivar = bivar.replace("全部","@novalue")
                }
                bivar += "|";
            }else{
                bivar = bivar.replace("全部","|@novalue|@novalue|");
            }
        }

        setData0(jsonpData);
        setData1(jsonpTestData);
        var srq = $("#rq").val()+"-01-01";
        var erq = $("#rq").val()+"-12-31";
        //费用增幅与机构动因 （费用动因分析）
        var cxtj0 = srq+";"+erq+"|";
        loads++;
        var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+escape(escape(bivar))+
            '&biyccs=&id=' +biKeys[0].id+'&softkey='+biKeys[0].softkey +
            '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=';
        $.ajax({
            type:"GET",
            url:url0,
            dataType: "jsonp",
            success:function(data){
                loads--;
                data = jsonpDataInit(data);  //jsonp数据格式化
                setData2(data);
                test(loads);
            }
        });
    }

    function setData0(data) {
        var datax = [];
        var datay = [[],[],[]];
        for(var i=0;i<data.rows.row.length;i++){
            datax.push(data.rows.row[i].cell[0]);
            datay[0].push(data.rows.row[i].cell[3]);
            datay[1].push(data.rows.row[i].cell[4]);
            datay[2].push(data.rows.row[i].cell[11]);
        }
        var tit = data.title.column.split(",");
        var myChart = echarts.init(document.getElementById('data0'));
        var option = dlchart.CreateBarChart("",datax,[{name:tit[1],data:datay[0]},{name:tit[2],data:datay[1]},{name:tit[3],data:datay[2]}],{
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
        },{index:2,option:{
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

    function setData1(data) {
        var year = $("#rq").val();
        data.title.column = data.title.column.replace("医院名称","年度");
        data.rows.row[0].cell[0] = year+"年度";
        var dataIndex = [0,1,2,3,4,5,6,7];
        var tableData = initBootstrapTableData(data,dataIndex);//jsop数据格式化为layuiTable数据格式
        var $table = $('#table1');
        if(flag==true) {
            $("#thead1").empty();
            $("#thead1").append(tableData.tr);
            $table.attr('data-pagination', 'true');
            $table.attr('data-toggle', 'table');
            $table.attr('data-page-size', '6');
//            $table.attr('data-height', "218");
            $table.attr('data-page-list', [6, 'all']);
            $table.bootstrapTable({data: [tableData.data[0]]});
        }else {
            $table.attr('data-toggle','table');
            $table.bootstrapTable('load', tableData.data);
        }
        if(dataIndex.length>5){
            $('#table1 th:first ').css({'width':'20%'});
        }
        tableData.data.length<=6&&$('.fixed-table-pagination').css('border-top','none');
    }

    function setData2(data) {
        var dataIndex = [0,1,2,3,4];
        var tableData = initBootstrapTableData(data,dataIndex);//jsop数据格式化为layuiTable数据格式
        var $table = $('#table2');
        if(flag==true) {
            $("#thead2").empty();
            $("#thead2").append(tableData.tr);
            $table.attr('data-pagination', 'true');
            $table.attr('data-toggle', 'table');
            $table.attr('data-page-size', '6');
            $table.attr('data-height', "218");
            $table.attr('data-page-list', [6, 'all']);
            $table.bootstrapTable({data: tableData.data});
        }else {
            $table.attr('data-toggle','table');
            $table.bootstrapTable('load', tableData.data);
        }
        if(dataIndex.length>5){
            $('#table1 th:first ').css({'width':'20%'});
        }
        tableData.data.length<=6&&$('.fixed-table-pagination').css('border-top','none');
    }

</script>
</body>
</html>
