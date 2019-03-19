<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/8/22
  Time: 14:12
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title> 雕龙-${systemName}</title>
    <meta name="format-detection" content="telephone=no,email=no,address=no">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/bootstrap-3.3.5/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/index.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/creat-css/create.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/indexdlargs.css">
    <link rel="stylesheet" href="${ctx}/static/js/plugins/metisMenu/metisMenu.css" />
    <link rel="stylesheet" href="${ctx}/static/js/plugins/layer/skin/layer.css" />
    <%--<link rel="stylesheet" type="text/css" href="${ctx}/static/css/my-stlye.css">--%>
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/bootstrap.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/metisMenu/jquery.metisMenu.min.js" ></script>
    <script type="text/javascript" src="${ctx}/static/js/common.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/indexargs.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery.nicescroll.js"></script>
    <style type="text/css">
        .highlight { background: #F58839;color:#fff; }
        .key-word{
            width: 150px;
            height: 24px;
            border-radius: 2px;
            padding: 0 30px 0 5px!important;
            font-size: 12px;
            line-height: 32px;
            border: 1px solid #ddd;
        }
        .sousuoyy{
            position: relative;
            left: -28px;
            top: 3px;
            color: #adadad;
        }
        .sousuoyy:hover{
            color: #b1b1b1;
        }
    </style>
    <script>
        var ctx="${ctx}";
        var userType = "${userType}";
        var bivar = "${bivar}";
        var hosName="${hosName}";
        $(function(){
            setInterval(function(){
                updateUserOnline();
            },5000);

            //$.ajaxSettings.async = false;
            if(userType =="省级") $("#fhzt").show();
            if("${bivar}"=="配置"){
                bivar = "@novalue|@novalue|@novalue|";
                $.getJSON("/sysMenu/getSysMenu?r="+Math.random(),function (data) {
                    //createMenu(data)
                    createMenu(data,"topmenu","childmenu","");
                });
            }else{
            $.getJSON("/sysMenu/getMenuByUserId?userId=${userId}&r="+Math.random(),function (data) {
                //createMenu(data)
                createMenu(data,"topmenu","childmenu","");
                var html ="";
                if(userType=="机构"){
                    html = '<li class="li-c">' +
                        '<a href="/static/file/操作指南（机构）.docx" data-index="000000">' +
                        '<span class="icon-tu">' +
                        '<img src="/static/img/wd-icon.png">' +
                        '</span>操作指南</a>' +
                        '</li>';
                }else if (userType=="市级"){
                    html = '<li class="li-c">' +
                        '<a href="/static/file/操作指南（地市）.docx" data-index="000000">' +
                        '<span class="icon-tu">' +
                        '<img src="/static/img/wd-icon.png">' +
                        '</span>操作指南</a>' +
                        '</li>';
                }else if (userType=="省级"){
                    html = '<li class="li-c">' +
                        '<a href="/static/file/操作指南（省级）.docx" data-index="000000">' +
                        '<span class="icon-tu">' +
                        '<img src="/static/img/wd-icon.png">' +
                        '</span>操作指南</a>' +
                        '</li>';
                }
                $("#topmenu").append(html)
            });
            }
            $('.page-tabs-content a').click(function(){
                var isc = true;
                var src = $(this).children().val();
                var data_id = $(this).attr("data-id");
                $("iframe").each(function(){
                    var a = $(this).attr("data-id");
                    if(data_id==$(this).attr("data-id")){
                        isc = false;
                        return false
                    }
                })
                if(isc){
                    $(".J_mainContent").find("iframe.J_iframe").hide().parents(".J_mainContent")
                        .append('<iframe  scrolling="auto" style="border:none" class="J_iframe sy" ' +
                        'name="' + data_id + '" width="100%" height="100%" src="' + src + '" frameborder="0" ' +
                        'data-id="' + data_id + '" ></iframe>');
                    var height = findDimensions_height();
                    $(".J_iframe").height(height - 100);
                }

            });

        });


        function updateUserOnline(){
            $.ajax({
                type:"POST",
                url:"/SysUserOnline/upUserOnLine",
                dataType: "json",
                success:function(data){
                    if(data.success == true){
                    }
                    else{
                        alert(data.msg);
                    }
                }
            });
        }

        function click_logout(){
            $.ajax({
                type:"POST",
                url:"/userlogin/logout",
                dataType: "json",
                success:function(data){
                    if(data.success == true){
                        window.location.href=data.url;
                    }
                    else{
                        alert(data.msg);
                    }
                }
            });
        }
        function updatePwd(){
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(0.35*width,height-300,"密码修改",'/userlogin/toupdatePwd')
        }
        
        function cdsearch() {
//          var search = $("#search").val();
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(0.55*width,height*0.5,'图表查询','/V_SysMenu/toSearch?search=');
        }

        function openView(code) {
            $("#topmenu").find("a").each(function () {
                 if($(this).attr("data-index")==code){
                    $(this).trigger("click");
                }
            })
        }

    </script>
</head>
<body>
<!-- nav-top -->
<div class="navbar-static-top"  style="background-color:#f1f1f1 ;">
    <div class="container-fluid"   style="background-color:#f1f1f1 ;">
        <%--<div class="xy-hide"><span class="glyphicon glyphicon-menu-hamburger"></span></div>--%>
        <div class="group-left navbar-left" style=" padding-left: 0px;" >
					<span class="t-touwen">
                        ${systemName}
                    </span>
            <%--<span class="systitle"> ${hospitalName}</span>--%>
            <%--<span class="logo" style="color:#21c1b4;font-weight:normal;width:140px;" >--%>
            <%--${hospitalName}--%>
            <%--</span>--%>
            <%--<span class="systitle">${systemName}</span>--%>
        </div>

        <div class="group-right navbar-right">
            <div class="avator-wrap">
                <input type="text" id="txtKey"  class="key-word" placeholder="请输入搜索内容" onkeypress="getKey();"/>
                <%--<button id="btnSearch">
                    <span class="glyphicon glyphicon-search"></span>
                </button>--%>
                <a  title="查询医院" class="glyphicon glyphicon-search sousuoyy" id="btnSearch"></a>
            </div>
            <div class="avator-wrap">
                <input type="hidden" name="userType" id="userType" value="${userType}"/>
                <input type="hidden" name="userId" id="userId" value="${userId}"/>
                <input type="hidden" name="staffname" id="staffname" value="${staffname}"/>
                <span><a onclick="updatePwd()">你好：${staffname}<%--[修改密码]--%></a></span>
            </div>
            <%--<c:if test="${userType == '机构'}">--%>
            <%--<div class="avator-wrap" style="width: 80px;">--%>
                <%--&lt;%&ndash;<span style="margin-top:8px;"><a  title="查询" class="glyphicon glyphicon-search" onclick="cdsearch()"></a></span>&ndash;%&gt;--%>
                <%--<span style="border-left: 1px solid #d9dadc;text-align: center;padding-left: 6px;line-height: 30px;display: inline-block">--%>
                    <%--<a onclick="window.open('/static/file/帮助文档.docx')">帮助文档</a></span>--%>
            <%--</div>--%>
            <%--</c:if>--%>
            <div class="icon-wrap" id="fhzt" hidden style="padding-right: 0px">
                <span style="margin-top:8px;"><a title="返回主题" class="glyphicon glyphicon-log-out" onclick="window.location.href = '${indexUrl}'"></a></span>
            </div>
            <div class="icon-wrap">
                <span style="margin-top:8px;"><a  title="退出" class="glyphicon glyphicon-off" onclick="click_logout()"></a></span>
            </div>
        </div>
    </div>
    <div class="content-tabs"   style="background-color:#f1f1f1 ;">
        <button class="roll-nav roll-left J_tabLeft"   style="background-color:#ffffff ;"><i class="glyphicon glyphicon-backward"></i>
        </button>
        <nav class="page-tabs J_menuTabs">
            <div class="page-tabs-content">
                <a href="javascript:;" class="active J_menuTab  sy" data-id="index.html">
                    <input type="hidden" value="${ctx}${userHome}"/>${indexName}</a>
               <%-- <a href="javascript:;" class="  J_menuTab  sy" data-id="casea_data.html" >
                    <input type="hidden" value="${ctx}/V_homePage/toHomePageCaseaData"/>病例数据</a>
                <a href="javascript:;" class="  J_menuTab  sy" data-id="child_pages.html">
                    <input type="hidden" value="${ctx}/V_homePage/toHomePageChildPages"/>二 </a>
                <a href="javascript:;" class="  J_menuTab  sy" data-id="subpage.html" >
                    <input type="hidden" value="${ctx}/V_homePage/toHomePageSubpage"/>三 </a>--%>
                <!--<a href="javascript:;" class="active J_menuTab" data-id="login.html">主页示例三 <i class="fa fa-times-circle"></i></a>-->
            </div>
        </nav>
        <button class="roll-nav roll-right J_tabRight" style="background-color:#fff;"><i class="glyphicon glyphicon-forward"></i>
        </button>
        <div class="btn-group roll-nav roll-right"   style="background-color:#fff ;">
            <button class="dropdown J_tabClose" data-toggle="dropdown"  >操作<span class="caret"></span>
            </button>
            <ul role="menu" class="dropdown-menu dropdown-menu-right"   style="background-color:#ffffff;">
                <li class="J_tabRefrsh">
                    <a>刷新当前选项卡</a>
                </li>
                <!--<li class="J_tabShowActive"><a>定位当前选项卡</a>
                </li>-->
                <li class="divider"></li>
                <li class="J_tabCloseAll">
                    <a>关闭全部选项卡</a>
                </li>
                <li class="J_tabCloseOther">
                    <a>关闭其他选项卡</a>
                </li>
            </ul>
        </div>
    </div>
</div>
<div class="J_mainContent mainContent" id="content-main">
    <iframe class="J_iframe sy"  scrolling="auto" style="border:none;min-width: 1250px"  name="index.html" width="100%" height="100%"
            src="${ctx}${userHome}" frameborder="0" data-id="index.html" id="iframe"></iframe>
    <%--<iframe class="J_iframe" hidden scrolling="auto" style="border:none;min-width: 1250px" name="iframe1" width="100%" height="100%"--%>
            <%--src="${ctx}/V_homePage/toHomePageCaseaData" frameborder="0" data-id="casea_data.html"></iframe>--%>
    <%--<iframe class="J_iframe" hidden scrolling="auto" style="border:none;min-width: 1250px" name="iframe2" width="100%" height="100%"--%>
            <%--src="${ctx}/V_homePage/toHomePageChildPages" frameborder="0" data-id="child_pages.html"></iframe>--%>
    <%--<iframe class="J_iframe" hidden scrolling="auto" style="border:none;min-width: 1250px" name="iframe3" width="100%" height="100%"--%>
            <%--src="${ctx}/V_homePage/toHomePageSubpage" frameborder="0" data-id="subpage.html"></iframe>--%>
</div>

<!-- sidebar  一级菜单-->
<%--<nav class="navbar navbar-sidebar" >--%>
<%--<div class="logo">--%>
<%--<p>Ddata</p>--%>
<%--<small>雕龙数据</small>--%>
<%--</div>--%>
<%--<ul class="nav nav-main" id="topmenu">--%>

<%--</ul>--%>
<%--</nav>--%>

<!--二级以后菜单-->
<%--<div class="nav-menu" id="nav-menu">--%>
<%--<nav class="sidebar-nav" id="childmenu">--%>


<%--</nav>--%>
<%--</div>--%>
<nav class="navbar navbar-sidebar ce-nan" id="content">
<%--<div class="ce-nan">--%>
    <div class="login">
        <p>Ddata</p>
        <p>雕龙数据</p>
    </div>
    <ul id="topmenu" class="nav nav-main candan-list">
    </ul>
<%--</div>--%>
</nav>
<script>
    //滚动条
//    $('#topmenu').niceScroll({
//        cursorcolor: "#ccc",//#CC0071 光标颜色
//        cursoropacitymax: 1, //改变不透明度非常光标处于活动状态（scrollabar“可见”状态），范围从1到0
//        touchbehavior: false, //使光标拖动滚动像在台式电脑触摸设备
//        cursorwidth: "5px", //像素光标的宽度
//        cursorborder: "0", // 	游标边框css定义
//        cursorborderradius: "5px",//以像素为光标边界半径
//        autohidemode: true //是否隐藏滚动条
//    });
    //获取屏幕的高
    $(window).load(function () {
        var H=document.body.offsetHeight;
        var T =H-90+"px";
        var F =H-96+"px";
        if("${userType}"=="机构"){
            F =H-220+"px";
            $("#content").append('<img src="/static/img/wxewm.png" style="width: 70px;display: block;margin: auto;">'+
                '<p style="text-align: center;">省级绩效平台（技术支持群）</p>' +
                '<p style="text-align: center;">技术支持QQ群：745466112</p>');
        }
        $('#content-main').css('height',T);
        $('#topmenu').css('min-height',F);
    })
    var biIds=['3ab277a3-1121-4517-8369-fd20165655ad'];
    if('${userType}'=='机构'){
        $.ajax({
            type:"POST",
            url:"/HBI/loadBiKsy?biIds="+biIds,
            dataType: "json",
            success:function(data){
                var biKeys =data;
                var cxtj0='${hosName}|@novalue|';
                var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
                    '&biyccs=&id=' +biKeys[0].id+'&softkey='+biKeys[0].softkey +
                    '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=';
                $.ajax({
                    type: "GET",
                    url: url0,
                    dataType: "jsonp",
                    success: function (data) {
                        var tscenter='',myDate = new Date();
                        if(data.rows==''){
                            tscenter='</br>暂无数据更新！'
                        }else{
                            tscenter='</br>数据最后更新时间：'+data.rows.row.cell[2]
                        }
                        layer.open({
                            type: 1,
                            title: '信息',
                            offset: 'rb',
                            shade:false,
                            area: ['260px', '160px'],
                            anim: 2,
                            content: '<div style="padding:10px;">${hosName}欢迎登陆！</br>当前时间：'+myDate.getFullYear()+'-'+(myDate.getMonth()+1)+'-'+myDate.getDate() +tscenter+'</div>' //这里content是一个普通的String
                        });
                    }
                });
            }
        });
    }else if('${userType}'=='市级'){
        var cs="${bivar}".split("|")[0];
        $.ajax({
            type:"POST",
            url:"/HBI/loadBiKsy?biIds="+biIds,
            dataType: "json",
            success:function(data){
                var biKeys =data;
                var cxtj0='@novalue|'+cs+'|';
                var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
                    '&biyccs=&id=' +biKeys[0].id+'&softkey='+biKeys[0].softkey +
                    '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=';
                $.ajax({
                    type: "GET",
                    url: url0,
                    dataType: "jsonp",
                    success: function (data) {
                        var tscenter='',myDate = new Date();
                        if(data.rows==''){
                            tscenter='</br>暂无数据更新！'
                        }else{
                            var a=0;
                            for(var i=0;i<data.rows.row.length;i++){
                                if(data.rows.row[i].cell[2]==data.rows.row[0].cell[2]){
                                    a++;
                                }
                            }
                            tscenter='</br>共更新医疗机构：'+a+'家</br>数据最后更新时间：'+data.rows.row[0].cell[2]
                        }
                        layer.open({
                            type: 1,
                            title: '信息',
                            offset: 'rb',
                            shade:false,
                            area: ['260px', '160px'],
                            anim: 2,
                            content: '<div style="padding:10px;">${staffname}欢迎登陆！</br>当前时间：'+myDate.getFullYear()+'-'+(myDate.getMonth()+1)+'-'+myDate.getDate() +tscenter+'</div>' //这里content是一个普通的String
                        });
                    }
                });
            }
        });
    }else{
        $.ajax({
            type:"POST",
            url:"/HBI/loadBiKsy?biIds="+biIds,
            dataType: "json",
            success:function(data){
                var biKeys =data;
                var cxtj0='@novalue|@novalue|';
                var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
                    '&biyccs=&id=' +biKeys[0].id+'&softkey='+biKeys[0].softkey +
                    '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=';
                $.ajax({
                    type: "GET",
                    url: url0,
                    dataType: "jsonp",
                    success: function (data) {
                        var tscenter='',myDate = new Date();
                        if(data.rows==''){
                            tscenter='</br>暂无数据更新！'
                        }else{
                            var a=0;
                            for(var i=0;i<data.rows.row.length;i++){
                                if(data.rows.row[i].cell[2]==data.rows.row[0].cell[2]){
                                    a++;
                                }
                            }
                            tscenter='</br>共更新医疗机构：'+a+'家</br>数据最后更新时间：'+data.rows.row[0].cell[2]
                        }
                        layer.open({
                            type: 1,
                            title: '信息',
                            offset: 'rb',
                            shade:false,
                            area: ['260px', '160px'],
                            anim: 2,
                            content: '<div style="padding:10px;">${staffname}欢迎登陆！</br>当前时间：'+myDate.getFullYear()+'-'+(myDate.getMonth()+1)+'-'+myDate.getDate() +tscenter+'</div>' //这里content是一个普通的String
                        });
                    }
                });
            }
        });
    }

    var indexa=0,pretime,flag;
    $('#btnSearch').click(function () {
        $('#content-main').find('iframe').eq(indexa).contents().find('span').removeClass("highlight");
        var searchText = $('#txtKey').val();
        var re = /[^\u4e00-\u9fa5]/;
        if (searchText.length == 0) {
            layer.alert('请输入搜索关键词!');
            $('#txtKey').focus();
            return;
        }else if(re.test(searchText)){
            layer.alert('输入关键词有误，请重新输入！')
            return;
        }else{
            indexa=$('.page-tabs-content .active').index();
            var thiscla=$('#content-main').find('iframe').eq(indexa);
            pretime =thiscla.contents().find('.main').html();
            var regExp = new RegExp(searchText, 'g');
            thiscla.contents().find('.main table').each(function () {
                var html = $(this).html();
                var _time = $(this).parent().find("strong").text();
                var newHtml = html.replace(regExp, '<span class="highlight">' + searchText + '</span>');
                $(this).html(newHtml);
                flag = 1;

            })
            if (flag) {
                var classflag= $('#content-main').find('iframe').eq(indexa).contents().find('.main .highlight');
                if (classflag.size() >= 1) {
                    var _top = classflag.eq(0).offset().top;
                    var _table=$('#content-main').find('iframe').eq(indexa).contents().find('.layui-table-body').scrollTop();
                    $('#content-main').find('iframe').eq(indexa).contents().find('html').animate({
                        "scrollTop": _top-100
                    }, 500)
                    $('#content-main').find('iframe').eq(indexa).contents().find('.layui-table-body').animate({
                        "scrollTop": _top+_table-150
                    }, 500)
                }else{
                    layer.alert('暂无匹配项！')
                }
            }
        }
    });
    function getKey(){
        if(event.keyCode==13){
            $('#btnSearch').click();
        }
    }
</script>
<%--
<script>
   /* $('.li-t-a').click(function(){
        $(this).siblings('.ul-c').toggle();
        $(this).toggleClass('on');
    });
    $('.li-f-a').click(function(){
        $(this).siblings('.ul-t').toggle();
        $(this).siblings('.ul-c').toggle();
    });
    //侧栏的点击状态
    $('a').click(function(){
        $('.candan-list a').removeClass('active');
        $(this).addClass('active');
    });*/
//侧栏菜单隐藏
//    $('.xy-hide').click(function(){
//        $('.ce-nan').toggle('fast');
//        $(this).toggleClass('on');
//        if($(this).hasClass('on')){
//             $('.navbar-static-top').css('margin-left','0px');
//            $('.mainContent').css('margin-left','0px');
//        }else{
//            $('.navbar-static-top').css('margin-left','200px');
//            $('.mainContent').css('margin-left','200px');
//        }
//    })
</script>--%>
</body>
</html>
