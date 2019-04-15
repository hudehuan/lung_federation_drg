<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/10/18
  Time: 14:06
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <meta charset="utf-8"/>
    <meta name="format-detection" content="telephone=no,email=no,address=no">
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <link rel="stylesheet" href="${ctx }/static/js/layui/css/layui.css"/>
    <link rel="stylesheet" href="${ctx }/static/css/base.css"/>
    <link rel="stylesheet" href="${ctx }/static/css/my-stlye.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/login-1.css">
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/tanchuan_hubei.css">
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/assets/examples.css"/>
    <link rel="stylesheet" href="${ctx }/static/js/plugins/layer/skin/layer.css"/>
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/bootstrap-table.css" />
    <link rel="stylesheet" type="text/css" href="${ctx }/static/js/jquery-easyui-1.5/themes/default/easyui.css">
    <link rel="stylesheet" href="${ctx }/static/css/chosen.css">
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/my97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/plugins/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/layui/layui.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/hubeiCon.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/common.js"></script>
    <title></title>
    <style>
        body {
            overflow-y: auto;
        }

        .table th {
            font-weight: inherit;
            background: #F3F3F3;
            /*border:none!important;*/
            text-align: center !important;
        }

        .bootstrap-table .table:not(.table-condensed) > tbody > tr > td:first-child {
            padding-right: 12px;
            text-align: left;
        }

        .bootstrap-table .table:not(.table-condensed) > tbody > tr > td {
            padding-right: 12px;
            text-align: right;
        }

        .fixed-table-container {
            border: none;
        }

        .pagination {
            margin-right: 4px;
        }

        .pull-right {
            margin-top: 6px !important;
            margin-bottom: 0px !important;
        }
    </style>
</head>
<body>
<div id="loading" class="loader">
    <img class="Rotation" src="${ctx}/static/img/load.png" width="32" height="32"/>
</div>
<div id="menu" style="position:fixed;top: 10px;right: 20px;z-index:20000;font-size:12px;">
    <%--<div class="xian" style="height: 65px;"></div>--%>
    <%--<ul>--%>
    <%--<li><a href="#item1" class="current"><span></span>- -医疗机构</a></li>--%>
    <%--<li><a href="#item2"><span></span>- -三、四级手术占比</a></li>--%>
    <%--<li><a href="#item3"><span></span>- -26组MDC</a></li>--%>
    <%--<li><a href="#item4"><span></span>- -三、四级手术占比</a></li>--%>
    <%--</ul>--%>
</div>
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
            <input type="text" class="Wdate " id="rq"
                   style="width: 80px;height: 24px;vertical-align: middle;margin-bottom: 3px;border-radius:2px;border: 1px solid #ddd"
                   onfocus="WdatePicker({el:'rq',startDate:'%y',dateFmt:'yyyy',alwaysUseStartDate:true,maxDate:'%y'})">

        </li>
        <li>
            <div class="center-back-cs">
                <input hidden style="width: 150px; height: 24px;border-radius:2px;cursor: pointer" class="sj-pt"
                       id="sj-pt"  readonly="readonly" value="" type="text" placeholder="平台机构选择"/>
                <select name="dept"  data-placeholder="医疗机构选择" style="width:210px;font-size: 12px;    height: 24px;border: 1px solid #ddd;border-radius: 2px;" id="dept" class="dept_select">
                   <%-- <option value="-1"></option>
                    <option value="全部"  class="qbyy" id="@novalue">全部</option>--%>
                </select>
            </div>
        </li>

    </ul>
    <div class="top-btn">查询</div>
    <a href="###" id="wrzdc" class="daochu" style="width: 90px;display: none;">未入组数据导出</a>
    <c:if test="${userType==机构}">
    <a href="###" id="daochu" class="daochu">导出</a></c:if>
    <a href="###" id="daochuimg1"  style="display: none;">导出</a>
    <a href="###" style="" class="tishi" title="此入组率计算公式为：&#10;(入组病例数/出院人数)*100">说明</a>
</div>
<div class="main" style="margin-top:50px;height: 780px" id="main">
    <div class="group-rate col-md-3">
        <div class="mokuai">
            <div class="title">
                <span>总入组率</span>
            </div>
            <div class="zhibiao2 tubiao1" id="table0" style="" ></div>
        </div>
        <div class="mokuai">
            <div class="title">
                <span>入组率</span>
            </div>
            <div class="zhibiao2 tubiao1" id="data1" ></div>
        </div>
        <div class="mokuai">
            <div class="title">
                <span>出院人数</span>
            </div>
            <div class="zhibiao2 tubiao1" id="data2" ></div>
        </div>
    </div>
    <div class="group-data col-md-9">
        <div class="group-data1">
            <div class="col-md-3 data-month">
                <div class="data-month1">1月</div>
                <div class="data-month1-chart" id="pie1"></div>
                <div class="data-month1-wenzi" id="table1">
                </div>
            </div>
            <div class="col-md-3 data-month">
                <div class="data-month1">2月</div>
                <div class="data-month1-chart" id="pie2"></div>
                <div class="data-month1-wenzi" id="table2">
                </div>
            </div>
            <div class="col-md-3 data-month">
                <div class="data-month1">3月</div>
                <div class="data-month1-chart" id="pie3"></div>
                <div class="data-month1-wenzi" id="table3">
                </div>
            </div>
            <div class="col-md-3 data-month">
                <div class="data-month1">4月</div>
                <div class="data-month1-chart" id="pie4"></div>
                <div class="data-month1-wenzi" id="table4">
                </div>
            </div>
        </div>
    </div>

    <div class="group-data col-md-9">
        <div class="group-data1">
            <div class="col-md-3 data-month">
                <div class="data-month1">5月</div>
                <div class="data-month1-chart" id="pie5"></div>
                <div class="data-month1-wenzi" id="table5">
                </div>
            </div>
            <div class="col-md-3 data-month">
                <div class="data-month1">6月</div>
                <div class="data-month1-chart" id="pie6"></div>
                <div class="data-month1-wenzi" id="table6">
                </div>
            </div>
            <div class="col-md-3 data-month">
                <div class="data-month1">7月</div>
                <div class="data-month1-chart" id="pie7"></div>
                <div class="data-month1-wenzi" id="table7">
                </div>
            </div>
            <div class="col-md-3 data-month">
                <div class="data-month1">8月</div>
                <div class="data-month1-chart" id="pie8"></div>
                <div class="data-month1-wenzi" id="table8">
                </div>
            </div>
        </div>
    </div>


    <div class="group-data col-md-9">
        <div class="group-data1">
            <div class="col-md-3 data-month">
                <div class="data-month1">9月</div>
                <div class="data-month1-chart" id="pie9"></div>
                <div class="data-month1-wenzi" id="table9">
                </div>
            </div>
            <div class="col-md-3 data-month">
                <div class="data-month1">10月</div>
                <div class="data-month1-chart" id="pie10"></div>
                <div class="data-month1-wenzi" id="table10">
                </div>
            </div>
            <div class="col-md-3 data-month">
                <div class="data-month1">11月</div>
                <div class="data-month1-chart" id="pie11"></div>
                <div class="data-month1-wenzi" id="table11">
                </div>
            </div>
            <div class="col-md-3 data-month">
                <div class="data-month1">12月</div>
                <div class="data-month1-chart" id="pie12"></div>
                <div class="data-month1-wenzi" id="table12">
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/bootstrap.min.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/bootstrap-table.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/extensions/toolbar/bootstrap-table-toolbar.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/ga.js" ></script>

<script type="text/javascript" src="${ctx}/static/js/echarts.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/macarons.js"></script>
<script type="text/javascript" src="${ctx}/static/js/dlchart.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jsonpData.js"></script>
<script type="text/javascript" src="${ctx}/static/js/layuiData.js"></script>
<script type="text/javascript" src="${ctx }/static/js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctx }/static/js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${ctx }/static/js/chosen.jquery.js"></script>
<script type="text/javascript" src="${ctx }/static/js/export.js"></script>
<script type="text/javascript" src="${ctx }/static/js/html2canvas.min.js"></script>
<script type="text/javascript" src="${ctx }/static/js/dlcommon.js"></script>
<script>
    $(function () {
        hubeiCon.initCon('sj-pt');
        hubeiCon.hospitalCon('sj-bz');
    })
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
    $("body").delegate("tbody a", "click", function () {
        var hospital = $(this).text();
        var year = $("#rq").val();
        //loadHospitalDat(hospital, year);
    })
    $("body").delegate(".data-month a", "click", function () {
        if("${userType}"=="机构") return;
        var height = parent.findDimensions_height();
        var width = parent.findDimensions_width();
        var month = $(this).parent().parent().children(":first").html().replace("月","");
        if(month<10){
            month = "0" + month;
        }
        var year = $("#rq").val();
        var dateTime = year +"-"+ month;
        var bivar = "";
        $(".center-back-cs").find("input").each(function () {
            if ($(this).css("display") != 'none') {
                bivar = $(this).val();
                return false;
            }
        })
        parent.layeropen(width*0.95,height*0.9,"","/hubei/V_Drgs0106/toList?dateTime="+dateTime+"&bivar="+bivar+"&yydm="+yydm);
    })
    //菜单滑动
    $(document).ready(function () {
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
                scrollTop: $($.attr(this, 'href')).offset().top - 100
            }, 500);
            return false;
        });
    });

    //获取屏幕的高
    var H = 0;
    var biIds = ['fae35d56-875e-41b1-b98b-8308aa6334f1','f7977f53-4ff3-4603-bb20-979de9145dbc','c9e48243-31b3-4b18-8a42-087c8a63883b'];//报表id
    var biKeys = [];//报表返回softkey
    var userType = "${userType}";
    $(document).ready(function () {
        $('.dept_select').chosen();
        if(userType=="机构"){
            $("#wrzdc").show();
        }
        btpage('${ctx}')
        H = $('#top-demand').height();
        $('.main-center').css('padding-top', H + 'px');
        $.ajax({
            type: "POST",
            url: "/HBI/loadBiKsy?biIds=" + biIds,
            dataType: "json",
            success: function (data) {
                biKeys = data;
                search()
            }
        });

        var date = new Date;
        var year = date.getFullYear();
        $("#rq").val(year);
    })
    var flag = true;
    $('.top-btn').click(function () {
        flag = false;
        search();
    })
    var yydm = '@novalue';
    var bivar = "";
    function search() {
        $("#loading").show();
        var loads = 1;
        var rq = $("#rq").val();
        var sTime = rq + "-01-01";
        var eTime = rq + "-12-31";

        //查询条件
        bivar = $('#sj-pt').val();
        if(bivar == "全国"){
            bivar = "@novalue|@novalue|@novalue|";
        }else {

            bivar +="|@novalue|@novalue|";

        }
        if("${userType}"=='省级'||"${userType}"=='全国'){
            yydm=$("#dept option:checked").text();
            if(!yydm||yydm=='全部'){
                yydm = '@novalue';
                hubeiCon.loadyydate();
            }
        }else{
            $('#dept').hide();
            yydm=parent.hosName;
        }
        //报表1
       /* if(parent.userType=='市级'||parent.userType=='省级'){
            yydm=$("#dept option:checked").text();
            if(!yydm||yydm=='全部'){
                yydm = '@novalue';
            }
        }else if(parent.userType=='机构'){
            yydm=parent.hosName;
        }*/
        //报表1
        var cxtj =  sTime + ";" + eTime + "|"+yydm+ "|";
        var url = '${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar=' + escape(escape(bivar)) +
            '&biyccs=&id=' + biKeys[0].id + '&softkey=' + biKeys[0].softkey +
            '&cxtj=' + escape(cxtj) + '&topdata=&timew=&weiplan=';
        $.ajax({
            type: "GET",
            url: url,
            dataType: "jsonp",
            success: function (data) {
                loads = loads - 1;
                test(loads);
                data = jsonpDataInit(data);
                setdata0(data);
                setdata1(data);
                setdata2(data);
            }
        });
		

		if("${userType}"=="机构") {
			loads++;
			var cxtj =  sTime + ";" + eTime + "|"+yydm+ "|";
			var url = '${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar=' + escape(escape(bivar)) +
				'&biyccs=&id=' + biKeys[2].id + '&softkey=' + biKeys[2].softkey +
				'&cxtj=' + escape(cxtj) + '&topdata=&timew=&weiplan=';
			$.ajax({
				type: "GET",
				url: url,
				dataType: "jsonp",
				success: function (data) {
					loads = loads - 1;
					test(loads);
					bahsExcel = jsonpDataInit(data);
				}
			});
		}
    }
    var bahsExcel
    function setdata0(data){
        var datay = data.rows.row[0];
        var colors = ['#6bb62e','#eee'];
        var myChart = echarts.init(document.getElementById("table0"));
        var option = dlchart.CreatePieChart('', [ ], [{
            name: "",
            data: [{name: "入组率", value: datay.cell[8], label: {
                normal: {
                    formatter: '{d} %',
                    textStyle: {
                        fontSize: 28
                    }
                }
            }},  {
                name: "",
                value: 100-Number(datay.cell[8]),
                tooltip: {
                    show: false
                },
                itemStyle: {
                    normal: {
                        color:colors[1]
                    },
                    emphasis: {
                        color: colors[1]
                    }
                },
                hoverAnimation: false
            }]
        }],{color:colors},{index:0,option:{ radius: ['60%', '70%'],
            label: {
                normal: {
                    position: 'center'
                }
            }}});
        myChart.setOption(option);
        var color = ["#3ab887", "#ef6363", "#ff9023", "#57d4b5"];
        for(var i=0;i<3;i++){
            var arr =[0,1,2,3];
            for(var k = 0;k < arr.length; k++){
                var rand = parseInt(Math.random()*arr.length);
                var t = arr[rand];
                arr[rand] =arr[k];
                arr[k] = t;
            }
            for(var j=1;j<5;j++){
                var num = parseInt(i*4+j);
                loadPie(data.rows.row[num],[color[arr[j-1]],'#eee'],"pie"+num);
                loadTable(data.rows.row[num],"table"+num);
            }

        }
    }
    function setdata1(data){
        var colors = ['#2ac8ca'];
        for(var i=1;i<data.rows.row.length;i++){
            if(Number(data.rows.row[i].cell[8])<95){
                data.rows.row[i].cell[8] = null;
            }
        }
        var data1 = {title:data.title,rows:{row:data.rows.row.slice(1)}};
        var chartdata=dlchart.getReportData(data1);
        var myChart = echarts.init(document.getElementById('data1'));
        var option = dlchart.CreateBarChart("", chartdata[0].data, chartdata[8], {
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            visualMap: {
                show: false,
                min: 0,
                max: 9,
                dimension: 0,
                inRange: {
                }
            },color:colors,
            yAxis:{
                min:95,
                max:100
            }
        }, {
            index: 0, option: {
                label: {
                    normal: {
                        show: false,
                    }
                }
            }
        }, null);
        myChart.setOption(option);
    }
    function setdata2(data){
        var colors = ['#2ac8ca'];
        var data1 = {title:data.title,rows:{row:data.rows.row.slice(1)}};
        var chartdata=dlchart.getReportData(data1);
        var myChart = echarts.init(document.getElementById('data2'));
        var option = dlchart.CreateBarChart("", chartdata[0].data, chartdata[7], {
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            visualMap: {
                show: false,
                min: 0,
                max: 9,
                dimension: 0,
                inRange: {
                }
            },color:colors
        }, {
            index: 0, option: {
                label: {
                    normal: {
                        show: false,
                    }
                }
            }
        }, null);

        myChart.setOption(option);
    }

    function loadPie(datay,colors,dataId){
        var myChart = echarts.init(document.getElementById(dataId));
        var option = {};
        if(datay){
            option = dlchart.CreatePieChart('', [ ], [{
                name: "",
                data: [{name: "入组率", value: datay.cell[8], label: {
                    normal: {
                        formatter: '{d} %',
                        textStyle: {
                            fontSize: 18
                        }
                    }
                }},  {
                    name: "",
                    value: 100-Number(datay.cell[8]),
                    tooltip: {
                        show: false
                    },
                    itemStyle: {
                        normal: {
                            color:colors[1]
                        },
                        emphasis: {
                            color: colors[1]
                        }
                    },
                    hoverAnimation: false
                }]
            }],{color:colors},{index:0,option:{ radius: ['60%', '70%'],
                label: {
                    normal: {
                        position: 'center'
                    }
                }}});
        }
        myChart.setOption(option);
        myChart.on("click", function(){
            if("${userType}"=="机构") return;
            var height = parent.findDimensions_height();
            var width = parent.findDimensions_width();
            var month = dataId.replace("pie","");
            if(month<10){
                month = "0" + month;
            }
            var year = $("#rq").val();
            var dateTime = year +"-"+ month;
            var bivar = "";
            $(".center-back-cs").find("input").each(function () {
                if ($(this).css("display") != 'none') {
                    bivar = $(this).val();
                    return false;
                }
            })
            parent.layeropen(width*0.95,height*0.9,"","/hubei/V_Drgs0106/toList?dateTime="+dateTime+"&bivar="+bivar+"&yydm="+yydm);

        });
    }

    function loadTable(data,tableId) {

        $('#'+tableId).empty();
        if(data){
            var html = "<p>出&nbsp;&nbsp;&nbsp;&nbsp;院："+data.cell[7]+"人</p>";
            if("${userType}"=="机构"){
                html +="<p>未入组："+data.cell[9]+"人</p>";
            }else{
                html +="<a>未入组："+data.cell[9]+"人</a>";
            }
            $('#'+tableId).html(html);
        }

    }
    if("${userType}"=="机构") {
        var n = 0;
        $('#daochu').click(function () {
            n++;
            html2canvas(document.querySelector("#main")).then(function (canvas) {
                //console.log(document.body.appendChild(canvas).toDataURL());
                //console.log(canvas.toDataURL());
                var triggerDownload = $("#daochuimg1").attr("href", canvas.toDataURL()).attr("download", n + '未入组分析.png');
                triggerDownload[0].click();
                var tablehtml = '<tr><td style="width: 1150px;height: 780px;"><img src="' + n + '未入组分析.png"></td></tr>'
                tableToExcel('table', tablehtml, '未入组分析');
            });
        });
        $('#wrzdc').click(function () {
            var data = [];
            data.push(bahsExcel.title.column.split(','));
            for (var i = 0; i < bahsExcel.rows.row.length; i++) {
                data.push(bahsExcel.rows.row[i].cell)
            }
            var excleJson = {
                excel: JSON.stringify(
                    [
                        {
                            table: JSON.stringify(
                                [
                                    {
                                        data: JSON.stringify(data)
                                    }
                                ]
                            )
                        }
                    ]
                )
            };
            ExcelDown(excleJson);
        });
    }
</script>
</body>
</html>