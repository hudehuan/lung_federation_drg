<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/08/02
  Time: 10:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <meta charset="utf-8" />
    <meta name="format-detection" content="telephone=no,email=no,address=no">
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <link rel="stylesheet" href="${ctx }/static/css/base.css" />
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/login-1.css">
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/tanchuan_hubei.css">
    <link rel="stylesheet" href="${ctx }/static/js/layui/css/layui.css" />
    <%--<link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/css/bootstrap.css" />--%>
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/bootstrap-table.css" />
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/assets/examples.css" />
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${ctx }/static/css/my-stlye.css" />
    <link rel="stylesheet" href="${ctx }/static/js/plugins/layer/skin/layer.css" />
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/my97DatePicker/WdatePicker.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/plugins/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/hubeiCon.js" ></script>
    <title>首页</title>
    <style>
        body{overflow-y:auto;}
        .table th{
            font-weight:inherit;
            background: #F3F3F3;
            /*border:none!important;*/
        }
        .table th,#table td{
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
        /*菜单*/
        #menu a{
            color: #22c3aa;
            text-decoration:none;
        }
        .current{
            color: #f58839!important;
        }
        .current span{
            border:1px solid #f58839!important;
            background:  #f58839!important;
        }
        #menu li{
            height: 20px;
        }
        #menu li>a>span{
            display: inline-block;
            width: 10px;
            height: 10px;
            border:1px solid #22c3aa;
            border-radius:50%;
            padding-right: 10px;
            background:  #fff;
        }
        .index-div-tab{
            width:100%;
            height: 20px;
            margin-top: 6px;
            text-align: right;
            position:absolute;
            top:0;
            right:10px;
            z-index:10;
        }
        .index-div-tab ul{
            display: inline-block;
            margin-top: 0;
            padding-top: 0;
            height: 20px;
        }
        .index-div-tab li{
            display: inline-block;
        }
        .index-div-tab li:last-child a{
            background: none;
        }
        .index-div-tab .active>span{
            background: #F58839;
            border-radius: 2px;
            /*color: #F58839;*/
            /*font-weight:bold;*/
        }
        .index-div-tab li a{
            display: inline-block;
            padding: 0 5px 0 2px;
            background: url(${ctx}/static/img/border.png) no-repeat right;
            background-size: 1px 18px;
        }
        .index-div-tab li a>span{
            color: #fff;
            display: inline-block;
            width:100%;
            /*border-radius:4px;*/
            padding: 0px 4px;
        }
    </style>
    <script>
        $(function(){
            hubeiCon.initCon('sj-pt','sj-jb');
        })
        $(document).ready(function () {
            $(window).scroll(function () {
                var items = $(".main-center").find(".man-c-2");
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
        });
    </script>
</head>
<body>
<div id="loading" class="loader">
    <img class="Rotation" src="${ctx}/static/img/load.png" width="32" height="32"/>
</div>
<div id="menu"  style="position:fixed;top: 10px;right: 20px;z-index:20000;font-size:12px;">
    <div class="xian" style="height:65px;"></div>
    <ul class="ul">
        <li><a href="#item1" class="current"><span></span>- -汇总</a></li>
        <li><a href="#item2"><span></span>- -服务能力</a></li>
        <li><a href="#item3"><span></span>- -工作效率</a></li>
        <li><a href="#item4"><span></span>- -质量安全</a></li>
    </ul>
</div>
<div class="top-demand" id="top-demand">
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
                <input hidden style="width: 150px; height: 24px;border-radius:2px;cursor: pointer" class="sj-pt" id="sj-pt" readonly="readonly" value="" type="text" placeholder="平台机构选择" />
                <input hidden style="width: 150px; height: 24px;border-radius:2px;cursor: pointer" class="sj-jb" id="sj-jb"  readonly="readonly" value="" type="text" placeholder="平台机构选择" />
            </div>

        </li>

        <%--<li>--%>
            <%--<label>医院级别：</label>--%>
            <%--<select id="yyjb"  style="width: 120px;height: 24px;border-radius:2px;border: 1px solid #ddd">--%>
                <%--<option value="@novalue">全部</option>--%>
                <%--<option value="三级">三级</option>--%>
                <%--<option value="二级">二级</option>--%>
            <%--</select>--%>
            <%--&lt;%&ndash;<input type="text" />&ndash;%&gt;--%>
        <%--</li>--%>
        <%--<li>--%>
        <%--<lable>监测对象：</lable>--%>
        <%--<input type="text" />--%>
        <%--</li>--%>

    </ul>
    <div class="top-btn" onclick="search()">查询</div>
</div>
<div class="main-center">
    <div class="man-c-1 bg-f item">
        <%--<div class="zhibiao-top back-zb">
            <ul id="cnengzb0">
                <li><a class="active">CMI</a></li>
                <li><a>入组率</a></li>
                <li><a>诊断相关组数</a></li>
                <li><a>低分险死亡率</a></li>
                <li><a>中低分险死亡率</a></li>
            </ul>
        </div>--%>
        <div class="col-xs-9" style="position: relative">
            <div class="index-div-tab">
                <ul id="cnengzb0">
                    <li><a class="active"><span>CMI</span></a></li>
                    <li><a><span>入组率</span></a></li>
                    <li><a><span>诊断相关组数</span></a></li>
                    <li><a><span>低分险死亡率</span></a></li>
                    <li><a><span>中低分险死亡率</span></a></li>
                </ul>
            </div>
            <div class="m-biao" id="m-biao" style="padding-top: 0"></div>
        </div>
        <div class="col-xs-3" style="padding: 0">
            <div class="m-biao-right">
                <div id="b2jq"><i style="font-size: 16px;font-style: normal;color: #fff;margin-right: 20px;line-height: 84px">总权重</i><br><span></span></div>
                <p id="b2zzl">增长量：<i style="font-style: normal"></i><span class="" style="float:right;padding-right:30%;padding-top: 3px"></span></p>
                <p id="b2zzv">增长率：<i style="font-style: normal"></i><span class="" style="float:right;padding-right:30%;padding-top: 3px"></span></p>
                <%--<p id="quanzhong">权重：<i style="font-style: normal">999</i><span class=""></span></p>--%>
            </div>
        </div>
    </div>
    <div id="item1" class="man-c-2">
        <div class="bg-f zhibiao-tree" style="overflow: hidden;height:auto">
            <div class="col-xs-4 zhibiao1">
                <table style="height: 26px;border-bottom: 1px solid #ddd">
                    <tr>
                        <th style="width: 30%">服务能力</th>
                        <td style="width: 20%;color: #3183ca;">本期</td>
                        <td style="width: 25%;color: #3183ca;">同比</td>
                        <td style="width: 25%;color: #3183ca;">环比</td>
                    </tr>
                </table>
                <table id="channeng">
                    <tbody>
                    <%--<tr>
                        <td>CMI值</td>
                        <td class="chen-se">0.94</td>
                        <td class="red"><span class="glyphicon glyphicon-arrow-up"></span>2.2%</td>
                    </tr>
                    <tr>
                        <td>DGRs数组</td>
                        <td>1.2</td>
                        <td class="green"><span class="glyphicon glyphicon-arrow-down"></span>1.2%</td>
                    </tr>
                    <tr>
                        <td>总权重</td>
                        <td class="chen-se">39192</td>
                        <td class="red"><span class="glyphicon glyphicon-arrow-up"></span>0.2%</td>
                    </tr>
                    <tr>
                        <td>入职病例数</td>
                        <td>0.90</td>
                        <td class="green"><span class="glyphicon glyphicon-arrow-down"></span>1.2%</td>
                    </tr>
                    <tr>
                        <td>指标项</td>
                        <td>0.34</td>
                        <td class="green"><span class="glyphicon glyphicon-arrow-down"></span>1.2%</td>
                    </tr>
                    <tr>
                        <td>指标项</td>
                        <td class="chen-se">1.94</td>
                        <td class="red"><span class="glyphicon glyphicon-arrow-up"></span>2.2%</td>
                    </tr>--%>
                    </tbody>
                </table>
            </div>
            <div class="col-xs-4 zhibiao2">
                <%--<div class="zhibiao-top">
                    <b>工作效率</b>
                    <span class="r-right">增长率</span>
                    <span class="r-right" style="margin-right: 20%;">本期</span>
                </div>--%>
                <table style="height: 26px;border-bottom: 1px solid #ddd">
                    <tr>
                        <th style="width: 30%">工作效率</th>
                        <td style="width: 20%;color: #3183ca;">本期</td>
                        <td style="width: 25%;color: #3183ca;">同比</td>
                        <td style="width: 25%;color: #3183ca;">环比</td>
                    </tr>
                </table>
                <div class="mar-left">
                    <table id="aqzb">
                        <tbody>
                        <%--<tr>
                            <td>低风险率死亡率</td>
                            <td class="green">0</td>
                            <td class="hui-se"><span class="glyphicon glyphicon-minus"></span></td>
                        </tr>
                        <tr>
                            <td>中风险死亡率(%)</td>
                            <td>1.2</td>
                            <td class="green"><span class="glyphicon glyphicon-arrow-down"></span>1.2%</td>
                        </tr>
                        <tr>
                            <td>低风险死亡人数</td>
                            <td class="chen-se">39192</td>
                            <td class="red"><span class="glyphicon glyphicon-arrow-up"></span>0.2%</td>
                        </tr>
                        <tr>
                            <td>中低风险死亡人数</td>
                            <td>0.90</td>
                            <td class="green"><span class="glyphicon glyphicon-arrow-down"></span>1.2%</td>
                        </tr>
                        <tr>
                            <td>低风险率死亡率</td>
                            <td>0.34</td>
                            <td class="green"><span class="glyphicon glyphicon-arrow-down"></span>1.2%</td>
                        </tr>
                        <tr>
                            <td>中低风险率死亡率</td>
                            <td class="chen-se">1.94</td>
                            <td class="red"><span class="glyphicon glyphicon-arrow-up"></span>2.2%</td>
                        </tr>--%>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col-xs-4 zhibiao3">
                <%--<div class="zhibiao-top">
                    <b>质量安全</b>
                    <span class="r-right">增长率</span>
                    <span class="r-right" style="margin-right: 20%;">本期</span>
                </div>--%>
                <table style="height: 26px;border-bottom: 1px solid #ddd">
                    <tr>
                        <th style="width: 30%">质量安全</th>
                        <td style="width: 20%;color: #3183ca;">本期</td>
                        <td style="width: 25%;color: #3183ca;">同比</td>
                        <td style="width: 25%;color: #3183ca;">环比</td>
                    </tr>
                </table>
                <div class="mar-left">
                    <table id="xlzb">
                        <tbody>
                        <%--<tr>
                            <td>死亡人数</td>
                            <td class="chen-se">0.94</td>
                            <td class="red"><span class="glyphicon glyphicon-arrow-up"></span>2.2%</td>
                        </tr>
                        <tr>
                            <td>死亡率(%)</td>
                            <td>1.2</td>
                            <td class="green"><span class="glyphicon glyphicon-arrow-down"></span>1.2%</td>
                        </tr>
                        <tr>
                            <td>死亡人数</td>
                            <td class="chen-se">39192</td>
                            <td class="red"><span class="glyphicon glyphicon-arrow-up"></span>0.2%</td>
                        </tr>
                        <tr>
                            <td>死亡人数</td>
                            <td>0.90</td>
                            <td class="green"><span class="glyphicon glyphicon-arrow-down"></span>1.2%</td>
                        </tr>
                        <tr>
                            <td>死亡率(%)</td>
                            <td>0.34</td>
                            <td class="green"><span class="glyphicon glyphicon-arrow-down"></span>1.2%</td>
                        </tr>
                        <tr>
                            <td>死亡率(%)</td>
                            <td class="chen-se">1.94</td>
                            <td class="red"><span class="glyphicon glyphicon-arrow-up"></span>2.2%</td>
                        </tr>--%>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>

    </div>
    <div id="item2" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">服务能力</b>
                <ul id="cnengzb">
                    <li><a class="active">CMI值</a></li>
                    <li><a>总权重</a></li>
                    <li><a>DRGs组数</a></li>
                    <li><a>入组病例数</a></li>
                    <li><a>入组率</a></li>
                    <li><a>三丶四级手术占比</a></li>
                    <li><a>疑难重症占比</a></li>
                </ul>
            </div>
            <div class="w-h">
                <div class="col-xs-6 zhibiao1">
                    <%--<p class="tit-zhibiao">州市趋势图</p>--%>
                    <div id="chart-yqst" class="chart-yqst" style="margin-top: 15px"></div>
                </div>
                <div class="col-xs-6 zhibiao2">
                    <%--<p class="tit-zhibiao">州市数据</p>--%>
                    <div  class="biaoge-yqst table-responsive" style="margin-top: 15px">
                        <table id="table1" class="table">
                            <thead>
                            <tr>
                                <th data-field="zs" data-sortable="true">州市</th>
                                <th data-field="bq" data-sortable="true">本期</th>
                                <th data-field="tq" data-sortable="true">同期</th>
                                <th data-field="zzl" data-sortable="true">增长率</th>
                            </tr>
                            </thead>
                            <%--<tbody id="channengzb">
                            <tr>
                                <td>机构</td>
                                <td>本期</td>
                                <td>同期</td>
                                <td><a>查看</a></td>
                            </tr>
                            <tr>
                                <td>机构</td>
                                <td>本期</td>
                                <td>同期</td>
                                <td><a>查看</a></td>
                            </tr>
                            </tbody>--%>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="item3" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">工作效率</b>
                <ul id="aquanzb">
                    <li><a class="active">费用消耗指数</a></li>
                    <li><a>时间消耗指数</a></li>
                    <li><a>平均住院日</a></li>
                    <li><a>次均费用（元）</a></li>
                    <li><a>价格动因</a></li>
                    <li><a>住院量动因</a></li>
                    <li><a>药占比（%）</a></li>
                </ul>
            </div>
            <div class="w-h">
                <div class="col-xs-6 zhibiao1">
                    <%--<p class="tit-zhibiao">州市趋势图</p>--%>
                    <div id="chart-aqyqst" class="chart-anquan" style="height: 270px;margin-top: 15px">

                    </div>
                </div>
                <div class="col-xs-6 zhibiao2">
                    <%--<p class="tit-zhibiao">州市数据</p>--%>
                    <div  class="biaoge-yqst table-responsive" style="margin-top: 15px">
                        <table class="table" id="table2">
                            <thead>
                            <tr>
                                <th data-field="zs" data-sortable="true">州市</th>
                                <th data-field="bq" data-sortable="true">本期</th>
                                <th data-field="tq" data-sortable="true">同期</th>
                                <th data-field="zzl" data-sortable="true">增长率</th>
                            </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <div id="item4" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">质量安全</b>
                <ul id="xlv">
                    <li><a class="active">低风险死亡数</a></li>
                    <li><a>中低风险死亡数</a></li>
                    <li><a>低风险死亡率</a></li>
                    <li><a>中低风险死亡率</a></li>
                    <li><a>死亡数</a></li>
                    <li><a>死亡率</a></li>
                </ul>
            </div>
            <div class="w-h">
                <div class="col-xs-6 zhibiao1">
                    <%--<p class="tit-zhibiao">州市数据</p>--%>
                    <div id="chart-xlyqst" class="chart-xiaolv" style="height: 270px;margin-top: 15px">

                    </div>
                </div>
                <div class="col-xs-6 zhibiao2">
                    <%--<p class="tit-zhibiao">机构数据</p>--%>
                    <div  class="biaoge-yqst table-responsive"  style="margin-top: 15px">
                        <table class="table" id="table3">
                            <thead>
                            <tr>
                                <th data-field="zs" data-sortable="true">州市</th>
                                <th data-field="bq" data-sortable="true">本期</th>
                                <th data-field="tq" data-sortable="true">同期</th>
                                <th data-field="zzl" data-sortable="true">增长率</th>
                            </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/bootstrap.min.js" ></script>
<%--<script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js" ></script>--%>
<script type="text/javascript" src="${ctx}/static/js/echarts.min.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/macarons.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/bootstrap-table.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/assets/bootstrap-table/src/extensions/toolbar/bootstrap-table-toolbar.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/ga.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/jsonpData.js" ></script>
<script>
    $('body').delegate('button', 'click', function () {
        $(this).next().find("li").each(function(){
            if($(this).hasClass("active")){
                $(this).removeClass("active");
            }else {
                $(this).addClass("active");
                $(this).children().trigger("click");
            }
        })
    });
    $('.li-t-a').click(function(){
        $(this).siblings('.ul-c').toggle();
        $(this).toggleClass('on');
    })
    $('.li-f-a').click(function(){
        $(this).siblings('.ul-t').toggle();
        $(this).siblings('.ul-c').toggle();
    })
    //侧栏的点击状态
    $('a').click(function(){
        $('.candan-list a').removeClass('active');
        $(this).addClass('active');

    });
    //tab标签的点击状态
    $('.zhibiao-top ul li a').click(function(){
        $(this).parent('li').siblings('li').children('a').removeClass('active');
        $(this).addClass('active');

    });
    $('.index-div-tab ul li a').click(function(){
        $(this).parent('li').siblings('li').children('a').removeClass('active');
        $(this).addClass('active');

    });
    //获取屏幕的高
    var H= 0;
    var biIds =['4995fb93-31fc-4c40-88c9-b56b06b022a6','4db067e1-e698-452e-abd4-1c09b7c787c7',
        '711b54fe-ae05-41e9-a847-aec3d8afa816','f866f4e7-ca77-4ee0-8b16-2f0bcfe7e593'];//报表id
    var biKeys =[];//报表返回softkey
    var hjCell;
    var cnengflag=true,anquan=true,xiaolv=true;
    $(document).ready(function () {
        btpage('${ctx}')
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
    })
    function search() {
        var  loads=4;
        $("#loading").show();
        var rq = $("#rq").val();
        var rqkj = $("#rqkj").val();
        var sTime = "",eTime = "",ssTime="",seTime="";
        var srq=rq-1;
        ssTime = srq + "-01-01";
        seTime = srq + "-12-31";
        sTime = rq + "-01-01";
        eTime = rq + "-12-31";
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
        //报表1
        var data1x=[],data1y=[];
        var cxtj = sTime+";"+eTime+"|";
        var url ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+escape(escape(bivar))+
            '&biyccs=&id=' +biKeys[0].id+'&softkey='+biKeys[0].softkey +
            '&cxtj='+escape(cxtj)+'&topdata=&timew=&weiplan=';
        $.ajax({
            type:"GET",
            url:url,
            dataType: "jsonp",
            success:function(data){
                loads=loads-1;
                test(loads);
                data = jsonpDataInit(data);
                var index=$('#cnengzb0 .active').parent().index()+1;
                var text=$('#cnengzb0 .active').text();
                for(var i=0;i<data.rows.row.length;i++){
                    data1x.push(data.rows.row[i].cell[0]);
                    data1y.push(data.rows.row[i].cell[index]);
                }
                var min=[0.5,0,500,0,0]
                option(data1x,data1y,text,min[index-1]);
                $('#cnengzb0 li').click(function(){
                    data1y=[];
                    index=$(this).index()+1;
                    text=$(this).find('a').text();
                    for(var i=0;i<data.rows.row.length;i++){
                        data1y.push(data.rows.row[i].cell[index]);
                    }
                    option(data1x,data1y,text,min[index-1]);
                });
            }
        });
        //报表二
        var cxtj1 = ssTime+";"+seTime+";"+sTime+";"+eTime+"|";
        var url1 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+escape(escape(bivar))+
            '&biyccs=&id=' +biKeys[1].id+'&softkey='+biKeys[1].softkey +
            '&cxtj='+escape(cxtj1)+'&topdata=&timew=&weiplan=';
        $.ajax({
            type:"GET",
            url:url1,
            dataType: "jsonp",
            success:function(data){
                data = jsonpDataInit(data);
                if(data.rows.row[1].cell[1]>10000){
                    var nums=(data.rows.row[1].cell[1]/10000).toFixed(2);
                    $('#b2jq span').html(nums+'<i style="font-size: 38px;font-style: initial;">&nbsp;万</i>');
                }else{
                    var nums=data.rows.row[1].cell[1];
                    $('#b2jq span').text(nums);
                }
                if(data.rows.row[2].cell[1]>10000||data.rows.row[2].cell[1]<-10000){
                    var nums=(data.rows.row[2].cell[1]/10000).toFixed(3);
                    $('#b2zzl i').text(nums+'万');
                }else{
                    var nums=data.rows.row[2].cell[1];
                    $('#b2zzl i').text(nums);
                }
                $('#b2zzv i').text(data.rows.row[3].cell[1]+'%');
                data.rows.row[2].cell[1]>0?$('#b2zzl span').addClass('glyphicon glyphicon-arrow-up c-hc'):$('#b2zzl span').addClass('glyphicon glyphicon-arrow-down c-lc');
                data.rows.row[3].cell[1]>0?$('#b2zzv span').addClass('glyphicon glyphicon-arrow-up c-hc'):$('#b2zzv span').addClass('glyphicon glyphicon-arrow-down c-lc')
                loads=loads-1;
                test(loads);
            }
        });
        //报表三
        var url2 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+escape(escape(bivar))+
            '&biyccs=&id=' +biKeys[2].id+'&softkey='+biKeys[2].softkey +
            '&cxtj='+escape(cxtj1)+'&topdata=&timew=&weiplan=';
        $.ajax({
            type:"GET",
            url:url2,
            dataType: "jsonp",
            success:function(data){
//                loads=loads-1;
//                test(loads);
                data = jsonpDataInit(data);
                var tr1='',tr2='',tr3='',th=[];
                var tit=data.title.column[0].split(",");
                for(var i=0;i<tit.length;i++){
                    if(tit[i]!=='#cspan'&&tit[i]!=='#rspan'){
                        th.push(tit[i]);
                    }
                }
                var celldata ;
                if(data.rows.row.length){
                   celldata = data.rows.row[0];
                }else {
                    celldata = data.rows.row;
                }
                hjCell = (celldata);
                //环比
                var huanb=[];
                var  xcts=DateDiff(sTime,eTime);
                var timeks=fun_date(xcts+1,sTime);
                var timejs=fun_date(1,sTime);
                var cxtj2 = timeks+";"+timejs+";"+sTime+";"+eTime+"|";
                var url2 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+escape(escape(bivar))+
                    '&biyccs=&id=' +biKeys[2].id+'&softkey='+biKeys[2].softkey +
                    '&cxtj='+escape(cxtj2)+'&topdata=&timew=&weiplan=';
                $.ajax({
                    type:"GET",
                    url:url2,
                    dataType: "jsonp",
                    success:function(data){
                        loads=loads-1;
                        test(loads);
                        data = jsonpDataInit(data);
                        huanb=data.rows.row[0].cell;
                        /*for(var a=0;a<data.rows.row[0].cell.length;a++){

                        }*/
                        function  sstr(x){
                            var str
                            if(x>0){
                                str='<td class="red">'+x+'%<span class="glyphicon glyphicon-arrow-up"></span></td>';
                            }else if(td4<0){
                                str='<td class="green">'+x+'%<span class="glyphicon glyphicon-arrow-down"></span></td>';
                            }else{
                                str='<td class="hui-se"><span class="glyphicon glyphicon-minus"></span></td>';
                            }
                            return str;
                        }
                        for(var i=1;i<=7;i++){
                            var td1=th[i];
                            var td2=celldata.cell[2+(i-1)*4];
                            var td3=celldata.cell[i*4];
                            var td4=huanb[i*4];
                            var str1=sstr(td3);
                            var str2=sstr(td4);
                            tr1+='<tr><td>'+td1+'</td><td>'+td2+'</td>'+str1+str2+'</tr>';
                            /*if(td3>0&&td2){
                                tr1+='<tr><td>'+td1+'</td><td>'+td2+'</td><td class="red">'+td3+'%<span class="glyphicon glyphicon-arrow-up"></span></td></tr>'
                            }else if(td3<0&&td2){
                                tr1+='<tr><td>'+td1+'</td><td>'+td2+'</td><td class="green">'+td3+'%<span class="glyphicon glyphicon-arrow-down"></span></td></tr>'
                            }else{
                                tr1+='<tr><td>'+td1+'</td><td>'+td2+'</td><td class="hui-se"><span class="glyphicon glyphicon-minus"></span></td></tr>'
                            }*/
                        }
                        $('#channeng').html(tr1);
                        for(var i=8;i<=14;i++){
                            var td1=th[i];
                            var td2=celldata.cell[2+(i-1)*4];
                            var td3=celldata.cell[i*4];
                            var td4=huanb[i*4];
                            var str1=sstr(td3);
                            var str2=sstr(td4);
                            tr2+='<tr><td>'+td1+'</td><td>'+td2+'</td>'+str1+str2+'</tr>';
                            /*if(td3>0&&td2){
                                tr2+='<tr><td>'+td1+'</td><td class="">'+td2+'</td><td class="red">'+td3+'%<span class="glyphicon glyphicon-arrow-up"></span></td></tr>'
                            }else if(td3<0&&td2){
                                tr2+='<tr><td>'+td1+'</td><td>'+td2+'</td><td class="green">'+td3+'%<span class="glyphicon glyphicon-arrow-down"></span></td></tr>'
                            }else{
                                tr2+='<tr><td>'+td1+'</td><td>'+td2+'</td><td class="hui-se"><span class="glyphicon glyphicon-minus"></span></td></tr>'
                            }*/
                        }
                        $('#aqzb').html(tr2);
                        for(var i=15;i<=20;i++){
                            var td1=th[i];
                            var td2=celldata.cell[2+(i-1)*4];
                            var td3=celldata.cell[i*4];
                            var td4=huanb[i*4];
                            var str1=sstr(td3);
                            var str2=sstr(td4);
                            tr3+='<tr><td>'+td1+'</td><td>'+td2+'</td>'+str1+str2+'</tr>';
                            /*if(td3>0&&td2){
                                tr3+='<tr><td>'+td1+'</td><td class="">'+td2+'</td><td class="red">'+td3+'%<span class="glyphicon glyphicon-arrow-up"></span></td></tr>'
                            }else if(td3<0&&td2){
                                tr3+='<tr><td>'+td1+'</td><td>'+td2+'</td><td class="green">'+td3+'%<span class="glyphicon glyphicon-arrow-down"></span></td></tr>'
                            }else{
                                tr3+='<tr><td>'+td1+'</td><td>'+td2+'</td><td class="hui-se"><span class="glyphicon glyphicon-minus"></span></td></tr>'
                            }*/
                        }
                        $('#xlzb').html(tr3);
                    }
                })
            }
        });
        //报表四
        var url3 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+escape(escape(bivar))+
            '&biyccs=&id=' +biKeys[3].id+'&softkey='+biKeys[3].softkey +
            '&cxtj='+escape(cxtj1)+'&topdata=&timew=&weiplan=';
        $.ajax({
            type:"GET",
            url:url3,
            dataType: "jsonp",
            success:function(data){
                loads=loads-1;
                test(loads);
                data = jsonpDataInit(data);
                var shi=[],zb=[];
                var th=data.title.column[0].split(",");
                for(var a=0;a<th.length;a++){
                    if(th[a]!='#cspan'){
                        zb.push(th[a]);
                    }
                }
                if(data.rows==""){
                    return;
                }
//                shi.push("合计")
                for(var i=0;i<data.rows.row.length;i++){
                    shi.push(data.rows.row[i].cell[0]);
                }

                var int1 = self.setInterval(function () {
                    if(hjCell){
                        window.clearInterval(int1);
                        cnzb($('#cnengzb .active').parent().index());
                    }
                },100)
                function  cnzb(c) {
                    var zb1=[[],[],[]],bzb1=[];
                    bzb1.push({"zs": "合计",
                        "bq":  hjCell.cell[2+4*c],
                        "tq": hjCell.cell[1+4*c],
                        "zzl":hjCell.cell[4+4*c],})
//                    zb1[0].push(hjCell.cell[2+4*c]);
//                    zb1[1].push(hjCell.cell[1+4*c]);
//                    zb1[2].push(hjCell.cell[4+4*c]);
                    for(var i=0;i<data.rows.row.length;i++){
                        //指标1
                        bzb1.push({
                            "zs": data.rows.row[i].cell[0],
                            "bq":  data.rows.row[i].cell[2+4*c],
                            "tq": data.rows.row[i].cell[1+4*c],
                            "zzl":data.rows.row[i].cell[4+4*c],
                        })
                        zb1[0].push(data.rows.row[i].cell[2+4*c]);
                        zb1[1].push(data.rows.row[i].cell[1+4*c]);
                        zb1[2].push(data.rows.row[i].cell[4+4*c]);
                        //tr+='<tr><td>'+data.rows.row[i].cell[0]+'</td><td>'+data.rows.row[i].cell[1]+'</td><td>'+data.rows.row[i].cell[2]+'</td><td>'+data.rows.row[i].cell[4]+'</td></tr>'
                    }
                    var $table = $('#table1');
                    if(cnengflag==true){
                        $table.attr('data-pagination','true');
                        $table.attr('data-toggle','table');
                        $table.attr('data-page-size','6');
                        $table.attr('data-page-list',[6, 'all']);
                        $table.attr('data-height','219');
                        $table.bootstrapTable({data: bzb1});
                        cnengflag =false;
                    }else{
                        //$table.bootstrapTable({'load':randomData()});
                        $table.attr('data-toggle','table');
                        $table.bootstrapTable('load', bzb1);
                    }
                    option1(shi,zb1);
                    bzb1.length<=6&&$('.fixed-table-pagination').css('border-top','none');
                }
                $('#cnengzb li').click(function(){
                    var index=$(this).index();
                    cnengflag=false;
                    cnzb(index);
                });

                //报表五
                var int2 = self.setInterval(function () {
                    if(hjCell){
                        window.clearInterval(int2);
                        aqzb($('#aquanzb .active').parent().index()+7);
                    }
                },100)
                function  aqzb(c) {
                    var zb1=[[],[],[]],bzb1=[];
                    bzb1.push({"zs": "合计",
                        "bq":  hjCell.cell[2+4*c],
                        "tq": hjCell.cell[1+4*c],
                        "zzl":hjCell.cell[4+4*c],});
//                    zb1[0].push(hjCell.cell[2+4*c]);
//                    zb1[1].push(hjCell.cell[1+4*c]);
//                    zb1[2].push(hjCell.cell[4+4*c]);
                    for(var i=0;i<data.rows.row.length;i++){
                        //指标2
                        bzb1.push({
                            "zs": data.rows.row[i].cell[0],
                            "bq":  data.rows.row[i].cell[2+4*c],
                            "tq": data.rows.row[i].cell[1+4*c],
                            "zzl":data.rows.row[i].cell[4+4*c],
                        })
                        zb1[0].push(data.rows.row[i].cell[2+4*c]);
                        zb1[1].push(data.rows.row[i].cell[1+4*c]);
                        zb1[2].push(data.rows.row[i].cell[4+4*c]);
                    }
                    var $table = $('#table2');
                    if(anquan==true){
                        $table.attr('data-pagination','true');
                        $table.attr('data-toggle','table');
                        $table.attr('data-page-size','6');
                        $table.attr('data-page-list',[6, 'all']);
                        $table.attr('data-height','219');
                        $table.bootstrapTable({data: bzb1});
                        anquan =false;
                    }else{
                        //$table.bootstrapTable({'load':randomData()});
                        $table.attr('data-toggle','table');
                        $table.bootstrapTable('load', bzb1);
                    }
                    option2(shi,zb1);
                    bzb1.length<=6&&$('.fixed-table-pagination').css('border-top','none');
                }
                $('#aquanzb li').click(function(){
                    var index=$(this).index()+7;
                    anquan=false;
                    aqzb(index);
                });

                //表六
                var int3 = self.setInterval(function () {
                    if(hjCell){
                        window.clearInterval(int3);
                        xlzb($('#xlv .active').parent().index()+14);
                    }
                },100);
                function  xlzb(c) {
                    var zb1=[],bzb1=[];
                    bzb1.push({"zs": "合计",
                        "bq":  hjCell.cell[2+4*c],
                        "tq": hjCell.cell[1+4*c],
                        "zzl":hjCell.cell[4+4*c],});
//                    zb1.push({
//                        value:hjCell.cell[2+4*c],
//                        name:"合计"
//                    });
                    for(var i=0;i<data.rows.row.length;i++){
                        bzb1.push({
                            "zs": data.rows.row[i].cell[0],
                            "bq":  data.rows.row[i].cell[2+4*c],
                            "tq": data.rows.row[i].cell[1+4*c],
                            "zzl":data.rows.row[i].cell[4+4*c],
                        })
                        zb1.push({
                            value:data.rows.row[i].cell[2+4*c],
                            name:data.rows.row[i].cell[0]
                        });
                    }
                    var $table = $('#table3');
                    if(xiaolv==true){
                        $table.attr('data-pagination','true');
                        $table.attr('data-toggle','table');
                        $table.attr('data-page-size','6');
                        $table.attr('data-page-list',[6, 'all']);
                        $table.attr('data-height','219');
                        $table.bootstrapTable({data: bzb1});
                        xiaolv = false;
                    }else{
                        $table.attr('data-toggle','table');
                        $table.bootstrapTable('load', bzb1);
                    }
                    option3(shi,zb1);
                    bzb1.length<=6&&$('.fixed-table-pagination').css('border-top','none');
                }
                $('#xlv li').click(function(){
                    var index=$(this).index()+14;
                    xiaolv=false;
                    xlzb(index);
                });
            }
        });
    }
    function option(data1x,data1y,text,min) {
        var myChart = echarts.init(document.getElementById('m-biao'));
        // 指定图表的配置项和数据
        //	        app.title = '多 X 轴示例';
        var colors = ['#5793f3', '#1ab394', '#675bba'];
        var option = {
            title: {
                text: '',
                textStyle: {
                    fontWeight: 'normal',
                    fontSize: 16,
                    color: '#ffffff'
                },
                left: '6%'
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    lineStyle: {
                        color: '#ffffff'
                    }
                }
            },
            legend: {
                icon: 'rect',
                itemWidth: 14,
                itemHeight: 5,
                itemGap: 13,
                right: '4%',
                textStyle: {
                    fontSize: 12,
                    color: '#F1F1F3'
                }
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: [{
                type: 'category',
                boundaryGap: false,
                axisLine: {
                    lineStyle: {
                        color: '#ffffff'
                    }
                },
                data: data1x
            }],
            yAxis: [{
                type: 'value',
                name: '',
                axisTick: {
                    show: false
                },
                axisLine: {
                    lineStyle: {
                        color: '#ffffff'
                    }
                },
                axisLabel: {
                    margin: 10,
                    textStyle: {
                        fontSize: 14
                    }
                },
                splitLine: {
                    lineStyle: {
                        color: 'rgba(255, 255, 255, 0.3)'
                    }
                },
                min:min
            }],
            series: [ {
                name:text,
                type: 'line',
                smooth: true,
                symbol: 'circle',
                symbolSize: 5,
                showSymbol: false,
                lineStyle: {
                    normal: {
                        width: 1
                    }
                },
                areaStyle: {
                    normal: {
                        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                            offset: 0,
                            color: 'rgba(82, 179, 242, 1)'
                        }, {
                            offset: 0.8,
                            color: 'rgba(104, 136, 192, 0.3)'
                        }], false),
                        shadowColor: 'rgba(100, 114, 158, 0.2)',
                        shadowBlur: 10
                    }
                },
                itemStyle: {
                    normal: {
                        color: 'rgb(61,204,255)',
                        borderColor: 'rgba(0,136,212,0.2)',
                        borderWidth: 12

                    }
                },
                data: data1y
            }, ]
        };
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    }
    function  option1(shi,zbsj) {
        var myChart = echarts.init(document.getElementById('chart-yqst'));
        // 指定图表的配置项和数据
        //	        app.title = '多 X 轴示例';
        var colors = ['#b6a2de', '#5ab1ef','#2ec7c9'];
        var option = {
            color:colors,
//				title: {
//				        text: '未来一周气温变化',
//				        subtext: '纯属虚构'
//				    },
            tooltip: {
                trigger: 'axis'
            },
                grid: {
                    left: '3%',
                    right: '8%',
                    bottom: '3%',
                    containLabel: true
                },
            legend: {
                data:['本期','同期','增长率']
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
                data: shi
            },
            yAxis: [{
                type : 'value',
                splitNumber: 10,
                axisLabel : {
                    formatter: function (value) {
                        return value
                    }
                },
                splitLine : {
                    show: false
                }
            },{
                type: 'value',
                axisLabel: {
                    formatter: '{value} %'
                }
            }
            ],
            series: [
                {
                    name:'本期',
                    type:'line',
                    smooth:true,
                    data:zbsj[0],

                    markLine : {
                        data : [
                            {type : 'average', name: '平均值'}
                        ]
                    }
                },
                {
                    name:'同期',
                    type:'line',
                    smooth:true,
                    data:zbsj[1]
                },
                {
                    name:'增长率',
                        type:'line',
                    data:zbsj[2],
                    yAxisIndex: 1,
                    smooth:true
                }
            ]
        };
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    }
    function option2(shi,zb){
        var myChart = echarts.init(document.getElementById('chart-aqyqst'));
        // 指定图表的配置项和数据
        //	        app.title = '多 X 轴示例';
        var colors = ['#7bd9a5', '#5ab1ef','#2ec7c9'];
        var option = {
            color:colors,
//				 title: {
//				        text: '堆叠区域图'
//				    },
            tooltip : {
                trigger: 'axis'
            },
            legend: {
                data:['本期','同期','增长率']
            },
//				    toolbox: {
//				        feature: {
//				            saveAsImage: {}
//				        }
//				    },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis : [
                {
                    type : 'category',
                    boundaryGap : false,
                    data : shi
                }
            ],
            yAxis : [{
                type : 'value',
                splitNumber: 10,
                axisLabel : {
                    formatter: function (value) {
                        return value
                    }
                },
                splitLine : {
                    show: false
                }
            },{
                type: 'value',
                axisLabel: {
                    formatter: '{value} %'
                }
            }
            ],
            series : [
                {
                    name:'本期',
                    type:'line',
                    smooth:true,
                    stack: '总量',
                    areaStyle: {normal: {}},
                    data:zb[0]
                },
                {
                    name:'同期',
                    type:'line',
                    smooth:true,
                    stack: '总量',
                    areaStyle: {normal: {}},
                    data:zb[1]
                },
                {
                    name:'增长率',
                    type:'line',
                    smooth:true,
                    yAxisIndex: 1,
                    stack: '总量',
                    areaStyle: {normal: {}},
                    data:zb[2]
                },

            ]
        };
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    }
    function option3(shi,zb) {
        var myChart = echarts.init(document.getElementById('chart-xlyqst'));
        // 指定图表的配置项和数据
        //	        app.title = '多 X 轴示例';
        var colors = ['#0d8c7a','#23baa5','#36cdb8','#57dbc8','#7bd9a5','#64cbbc','#5ab1ef','#25d6bb','#2ec7c9','#21e192','#2ad5bd','#a3e4c0'];
        var option = {
            color:colors,
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b}: {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                x:'left',
                y: 'top',
                data:shi,
            },
            series: [
                {
                    name:'本期',
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
                    name:'本期',
                    type:'pie',
                    center: ['65%', '50%'],
                    radius: ['40%', '55%'],
                    data:zb
                }
            ]
        };
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    }
    function  DateDiff(sDate1,  sDate2){    //sDate1和sDate2是2006-12-18格式
        var  aDate,  oDate1,  oDate2,  iDays
        aDate  =  sDate1.split("-")
        oDate1  =  new  Date(aDate[1]  +  '-'  +  aDate[2]  +  '-'  +  aDate[0])    //转换为12-18-2006格式
        aDate  =  sDate2.split("-")
        oDate2  =  new  Date(aDate[1]  +  '-'  +  aDate[2]  +  '-'  +  aDate[0])
        iDays  =  parseInt(Math.abs(oDate1  -  oDate2)  /  1000  /  60  /  60  /24)    //把相差的毫秒数转换为天数
        return  iDays
    }
    function fun_date(a,thistime){
        arr=thistime.split('-');
        var date1 = new Date(arr[0]+'/'+arr[1]+'/'+arr[2]);
        var date2 = new Date(date1);
        date2.setDate(date1.getDate()-a);
        var time = date2.getFullYear()+"-"+(date2.getMonth()+1)+"-"+date2.getDate();
        return time;
    }
</script>
</body>
</html>