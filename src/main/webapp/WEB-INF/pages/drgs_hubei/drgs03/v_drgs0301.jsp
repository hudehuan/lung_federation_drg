<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/08/10
  Time: 17:54
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
<div id="menu"  style="position:fixed;top: 10px;right: 20px;z-index:20000;font-size:12px;">
    <div class="xian" style="height:85px"></div>
    <ul>
        <li><a href="#item1" class="current"><span></span>- -机构服务能力情况</a></li>
        <li><a href="#item2"><span></span>- -机构完成区域与总权重占比</a></li>
        <li><a href="#item3"><span></span>- -手术占比</a></li>
        <li><a href="#item4"><span></span>- -疑难病例例数和比例</a></li>
        <li><a href="#item5"><span></span>- -一般病例例数和比例</a></li>
        <%--<li><a href="#item6"><span></span>- -医院总权重排名</a></li>--%>
    </ul>
</div>
<div class="top-demand" id="top-demand" >
    <ul>
        <li>
            <label>日期：</label>
            <select id="rqkj" disabled style="width: 60px;height: 24px;border-radius:2px;border: 1px solid #ddd">
                <option value="n">年</option>
                <option value="j">季</option>
                <option value="y">月</option>
            </select>
            <input type="text" class="Wdate " id="rq" style="width: 80px;height: 24px;vertical-align: middle;margin-bottom: 3px;border-radius:2px;border: 1px solid #ddd"
                   onfocus="WdatePicker({el:'rq',startDate:'%y',dateFmt:'yyyy',alwaysUseStartDate:true,maxDate:'%y'})">
        </li>
        <li>
            <div class="center-back-cs">
                <input hidden style="width: 150px; height: 24px;border-radius:2px;cursor: pointer" class="sj-pt" id="sj-pt" readonly="readonly" value="" type="text" placeholder="平台机构选择" />
                <input hidden style="width: 150px; height: 24px;border-radius:2px;cursor: pointer" class="sj-jb" id="sj-jb"  readonly="readonly" value="" type="text" placeholder="平台机构选择" />
            </div>
        </li>


    </ul>
    <div class="top-btn" style="cursor:pointer" onclick="search()">查询</div>
</div>
<div class="main-center">
    <div id="item1" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">机构服务能力情况</b>
            </div>
            <div class="zhibiao2 table-div" id="data3_1" style="text-align: left;height:350px; " >

            </div>
        </div>
    </div>
    <div  id="item2" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">机构完成区域与总权重占比</b>
            </div>
            <div class="zhibiao2 table-div" id="data0" style="height:350px;" >

            </div>
        </div>
    </div>
    <div  id="item3" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">手术占比</b>
            </div>
            <div class="zhibiao2 table-div" id="data1" style="height:350px;" >

            </div>
        </div>
    </div>
    <div id="item4" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">疑难病例例数和比例</b>
            </div>
            <div class="zhibiao2 table-div" id="data4" style="height:225px;" >
                <div class="zhibiao2">
                    <div  class="biaoge-yqst table-responsive" style="margin:15px;">
                        <table class="table" id="table1" style="font-size: 12px;">
                            <thead id="thead1">
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="item5" class="man-c-2">
        <div class="bg-f" style="overflow: hidden;height:auto">
            <div class="zhibiao-top back-zb">
                <b class="back-b">一般病例例数和比例</b>
            </div>
            <div class="zhibiao2 table-div" id="data5" style="height:250px;" >
                <div class="zhibiao2">
                    <div  class="biaoge-yqst table-responsive" style="margin:15px;">
                        <table class="table" id="table2" style="font-size: 12px; ">
                            <thead>
                            <tr>
                                <th rowspan="2" data-field="td0" style="width: 23%;vertical-align: middle">医院名称</th>
                                <th rowspan="2" data-field="td15" style="width: 11%;vertical-align: middle">出院人次</th>
                                <th rowspan="2" data-field="td7"  style="width: 11%;vertical-align: middle">0&#60;RW&#60;2总例数</th>
                                <th colspan="2"   style="width: 11%;">0&#60;RW&#60;1</th>
                                <th colspan="2"   style="width: 11%;">1<=RW<2</th>
                            </tr>
                            <tr>

                                <th data-field="td8" data-sortable="true" style="width: 11%;">例数</th>
                                <th data-field="td9" data-sortable="true" style="width: 11%;">占比</th>
                                <th data-field="td10" data-sortable="true" style="width: 11%;">例数</th>
                                <th data-field="td11" data-sortable="true" style="width: 11%;">占比</th>
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
<script type="text/javascript" src="${ctx}/static/js/dlchart.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/jsonpData.js" ></script>
<script>
    $(function(){
        hubeiCon.initCon('sj-pt','sj-jb');
    })
    $('body').delegate('.page-list button', 'click', function () {
        $(this).next().find("li").each(function(){
            if($(this).hasClass("active")){
                $(this).removeClass("active");
            }else {
                $(this).addClass("active");
                $(this).children().trigger("click");
            }
        })
    });
    //菜单滑动
    $(document).ready(function () {
        $(window).scroll(function () {
            var items = $(".main-center").find(".man-c-2");
            var menu = $("#menu");
            var top = $(document).scrollTop();
            var currentId = ""; //滚动条现在所在位置的item id
            items.each(function () {
                var m = $(this);
                //注意：m.offset().top代表每一个item的顶部位置
                if (top > m.offset().top - 400) {
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
    //获取屏幕的高
    var H= 0;
    var flag = false;
    $(document).ready(function () {
        H=$('#top-demand').height();
        $('.main-center').css('padding-top',H+'px');
    })
    var biIds =['7efef8f1-b53f-4119-98df-ee86c1497fd8','c3cfaab8-9351-4649-af6d-491967e35c3b'];//报表id
    var biKeys =[];//报表返回softkey
    $(function () {
        $.ajax({
            type:"POST",
            url:"/HBI/loadBiKsy?biIds="+biIds,
            dataType: "json",
            success:function(data){
                biKeys =data;
                search("new");
            }
        });
        var date = new Date;
        var year=date.getFullYear();
        $("#rq").val(year);
    })

    function search(stats) {
        $("#loading").show();
        var loads=2;
        if(stats){
            flag = true;
        }else {
            flag = false;
        }
        var srq = $("#rq").val()+"-01-01";
        var erq = $("#rq").val()+"-12-31";
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
        //医院与服务能力对比图 、手术占比
        var cxtj0 = srq+";"+erq+"|";
        var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+escape(escape(bivar))+
            '&biyccs=&id=' +biKeys[0].id+'&softkey='+biKeys[0].softkey +
            '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=1';
        $.ajax({
            type:"GET",
            url:url0,
            dataType: "jsonp",
            success:function(data){
                loads=loads-1;
                test(loads);
                data = jsonpDataInit(data);
                setData0(data);
                setData1(data);
                setData4(data);
                setData5(data);
            }
        });
        var url1 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+escape(escape(bivar))+
            '&biyccs=&id=' +biKeys[1].id+'&softkey='+biKeys[1].softkey +
            '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=';
        $.ajax({
            type:"GET",
            url:url1,
            dataType: "jsonp",
            success:function(data){
                loads=loads-1;
                test(loads);
                data = jsonpDataInit(data);
                //setData3(data);
                setData3_3(data);
            }
        });
    }
    //机构完成区域与总权重占比
    function setData0(data){
        var attr =[];
        var datay=data.rows.row;
        var num =0;
        for(var i =0;i<datay.length;i++){
            var str=[];
            num += Number(datay[i].cell[12]);
            str.push(datay[i].cell[2]);//x轴
            str.push(datay[i].cell[1]);//y轴
            str.push(datay[i].cell[0]);//医院
            str.push(datay[i].cell[12]);//权重

            attr.push(str);
        }

        var myChart = echarts.init(document.getElementById('data0'));
        var colors = ['#4ea397'];
        var   option = dlchart.CreateCatterChart("",{x:"DRGs组数",y:"CMI"},[{name:"权重",data:attr}],{
            grid: {
                left: '3%',
                right: '8%',
                bottom: '3%',
                containLabel: true
            }
        },{
            index:0,option:{
                label: {
                emphasis: {
                    show: true,
                    formatter: function (param) {
                        return param.data[2];
                    },
                    position: 'top'
                }
            },
                itemStyle: {
                    normal: {
                        shadowBlur: 10,
                        shadowColor: 'rgba(113, 149, 194, 0.6)',
                        shadowOffsetY: 5,
                        color: new echarts.graphic.RadialGradient(0.4, 0.3, 1, [{
                            offset: 0,
                            color: 'rgb(147, 183, 228)'
                        }, {
                            offset: 1,
                            color: 'rgb(147, 183, 228)'
                        }])
                    }
                },
                markLine : {
                itemStyle:{
                    normal:{
                        lineStyle:{
                            type: 'dashed'
                        }
                    }
                }
            }
            }},(num/300));
        myChart.setOption(option);
    }
    //手术占比
    function setData1(data){
        var datay = data.rows.row;
        for(var i=0;i<datay.length;i++){
            for(var j =i;j<datay.length;j++){
                if(Number(datay[i].cell[3])<Number(datay[j].cell[3])){
                    var str = datay[j];
                    datay[j] = datay[i];
                    datay[i] = str;
                }
            }
        }
        datay= datay.slice(0,20);
        var data1 = {title:{},rows:{row:{}}};
        data1.title = data.title;
        data1.rows.row = datay;
        var myChart = echarts.init(document.getElementById('data1'));
        var chartdata=dlchart.getReportData(data1);
        var colors = ['#2ec7c9', '#5ab1ef'];
        var   option = dlchart.CreateLineChart("",chartdata[0].data,[chartdata[3],chartdata[4]],{
           color:colors,
            grid: {
                left: '5%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            }
        },{index:0,option:{
            smooth:true,
        }});

        myChart.setOption(option);
    }
    function setData4(data)
    {

        var dataIndex  =[0,15,5,6];
        var tableData = initBootstrapTableData(data,dataIndex);//jsop数据格式化为layuiTable数据格式
        var $table = $('#table1');
        if(flag){
            $("#thead1").empty();
            $("#thead1").append(tableData.tr);
            $table.attr('data-pagination','true');
            $table.attr('data-toggle','table');
            $table.attr('data-page-size','6');
            $table.attr('data-page-list',[6, 'all']);
            $table.attr('data-height','219');
            $table.bootstrapTable({data: tableData.data});
        }else {
            $table.attr('data-toggle','table');
            $table.bootstrapTable('load', tableData.data);
        }
        $('#table1 thead th:first').css({"vertical-align":"middle","width":"30%"});
        $table.on("click-row.bs.table", function (e, row, element) {
            $('.success').removeClass('success');//去除之前选中的行的，选中样式
            $(element).addClass('success');//添加当前选中的 success样式用于区别
            var index = $('#table1').find('tr.success').data('index');//获得选中的行的id
        });
        tableData.data.length<=6&&$('.fixed-table-pagination').css('border-top','none');
    }
    function setData5(data)
    {
        var dataIndex = [0,15,7,8,9,10,11];
        var $table = $('#table2');

        var tableData = initBootstrapTableData(data,dataIndex);//jsop数据格式化为layuiTable数据格式
        if(flag){
        $table.attr('data-pagination','true');
        $table.attr('data-toggle','table');
        $table.attr('data-page-size','6');
        $table.attr('data-page-list',[6, 'all']);
        $table.attr('data-height','248');
        $table.bootstrapTable({data: tableData.data});
        }else {
            $table.attr('data-toggle','table');
            $table.bootstrapTable('load', tableData.data);
        }
        $('#table2 thead th').eq(0).css({"vertical-align":"middle","width":"23%"});
        $('#table2 thead th').eq(1).css({"vertical-align":"middle"});
        $('#table2 thead th').eq(2).css({"vertical-align":"middle"});
        $table.on("click-row.bs.table", function (e, row, element) {
            $('.success').removeClass('success');//去除之前选中的行的，选中样式
            $(element).addClass('success');//添加当前选中的 success样式用于区别
            var index = $('#table1').find('tr.success').data('index');//获得选中的行的id
        });
        tableData.data.length<=6&&$('.fixed-table-pagination').css('border-top','none');
    }
    function setData3_3(data){
        var colors = ['#4ea397','#7bd9a5'];//, '#22c3aa','#7bd9a5'
        var text=data.title.reportmc;
        var datax=data.title.column[0].split(',');

        var rows=data.rows.row;
        var data2=[],datay=[];
        datax=datax.slice(1);
        var dataArray =[], radix;
        $(rows).each(function(index,obj){
            datay.push(obj.cell[0]);//医院名
            $(datax).each(function(i,o){
                var d=[index,i,obj.cell[i+1],obj.cell[0],o];
                data2.push(d);
                dataArray.push(obj.cell[i+1]);
            })
        });
        for(var i=0;i<dataArray.length-1;i++){
            for(var j=i+1;j<dataArray.length;j++){
                if(Number(dataArray[i])<Number(dataArray[j])){
                    var num = dataArray[i];
                    dataArray[i] = dataArray[j];
                    dataArray[j] = num;
                }
            }
        }
        var len = parseInt(dataArray.length*0.10);
        if(len%2==0){
            radix = Number((Number(dataArray[len/2])+Number(dataArray[len/2-1]))/2.0);
        }else{
            radix = Number(dataArray[(len-1)/2]);
        }
        var myChart = echarts.init(document.getElementById('data3_1'));

        data2 = data2.map(function (item) {
            return [item[1], item[0], item[2], item[3], item[4], item[2] || '-'];
        });

        var option =dlchart.CreateHeatMapChart("",{x:datax,y:datay,data:data2},{ tooltip: {
            formatter: function (params, ticket, callback) {
                return params.value[4] + "-" + params.value[3] + ":" + params.value[5];
            }
        },visualMap:{max:radix}});
        myChart.setOption(option);
    }
    function setData3(data){
        var text=data.title.reportmc;
        var zb=data.title.column[0].split(',');
        var rows=data.rows.row;
        var html='',tr='',td='',max=9,min=0,xx=(max-min)/6;
        for(a=0;a<zb.length;a++){
            td+='<td>'+zb[a]+'</td>';
        }
        tr='<tr>'+td+'</tr>';
        for(var i=0;i<rows.length;i++){
            td='';
            for(var f=0;f<zb.length;f++){
                if(f==0)
                {
                    td+='<td style="text-align: left;padding-left: 5px">'+rows[i].cell[f]+'</td>';
                }else
                {
                    td+='<td style="text-align: right">'+rows[i].cell[f]+'</td>';
                }
            }
            tr+='<tr>'+td+'</tr>'
        }
        $('#data3').html(tr);
        $('#data3').css({'width':'99%','text-align':'center','min-width':'720px','border-collapse':'collapse','font-size':'12px','margin':'0 auto'})

        $('#data3 tr td:first').css({'width':'120px'});
        // $('#data3 tr:first td:first').css({'color':'#333'})
        $('#data3 tr td').css({'color':'#333','border':'1px solid #ddd','height':'34px',"vertical-align":"middle"});
        $('#data3 tr:first').css({'background-color':'#f3f3f3', 'color':'#333','height':'40px',"vertical-align":"middle"});
        var val='';
        for(var h=1;h<=rows.length;h++){
            for(var w=1;w<=zb.length;w++){
                var thistd=$('#data3').find('tr').eq(h).find('td').eq(w);
                val=thistd.text().replace(/%/,'');
                if(val>min&&val<=min+xx){
                    thistd.css({'background-color':'#fde7e8','color':'#6f6f6f'});
                }else if(val>min+xx&&val<=min+2*xx){
                    thistd.css({'background-color':'#feced1','color':'#a2a2a2'});
                }else if(val>min+2*xx&&val<=min+3*xx){
                    thistd.css({'background-color':'#f9a3a7','color':'#a0a0a0'});
                }else if(val>min+3*xx&&val<=min+4*xx){
                    thistd.css({'background-color':'#f97a80','color':'#c4c4c4'});
                }else if(val>min+4*xx&&val<=min+5*xx){
                    thistd.css({'background-color':'#fb4d55','color':'#dcdcdc'});
                }else if(val>min+5*xx&&val<=max){
                    thistd.css({'background-color':'#fe0c18','color':'#f5f5f5'});
                }
            }
        }
    }
</script>
</body>
</html>
