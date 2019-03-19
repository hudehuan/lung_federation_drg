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

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title></title>
    <meta name="format-detection" content="telephone=no,email=no,address=no">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/bootstrap-3.3.5/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/index.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/indexdlargs.css">
    <link rel="stylesheet" href="${ctx}/static/js/plugins/metisMenu/metisMenu.css" />
    <link rel="stylesheet" href="${ctx}/static/js/plugins/layer/skin/layer.css" />

    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/bootstrap.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/metisMenu/jquery.metisMenu.min.js" ></script>
    <script type="text/javascript" src="${ctx}/static/js/common.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/indexargs.js"></script>

    <script>
        var ctx="${ctx}";

        $(function(){
            setInterval(function(){
                updateUserOnline();
            },1000*60*1);

            //$.ajaxSettings.async = false;
            $.getJSON("/sysMenu/getMenuByUserId?userId=${userId}&r="+Math.random(),function (data) {
                //createMenu(data)
                createMenu(data,"topmenu","childmenu","");
            });

        });


        function updateUserOnline(){
            $.ajax({
                type:"POST",
                url:"/useronline/update",
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

    </script>
</head>
<body>
<!-- nav-top -->
<div class="navbar-static-top"  style="background-color:#f1f1f1 ;">
    <div class="container-fluid"   style="background-color:#f1f1f1 ;">
        <div class="group-left navbar-left"   style="background-color:#f1f1f1 ;">
					<span class="logo">
                        ${systemName}
                    </span>
            <%--<span class="systitle"> ${hospitalName}</span>--%>
            <%--<span class="logo" style="color:#21c1b4;font-weight:normal;width:140px;" >--%>
            <%--${hospitalName}--%>
            <%--</span>--%>
            <%--<span class="systitle">${systemName}</span>--%>
        </div>

        <div class="group-right navbar-right"   style="background-color:#f1f1f1 ;">
            <div class="avator-wrap">
                <input type="hidden" name="userId" id="userId" value="${userId}"/>
                <input type="hidden" name="staffname" id="staffname" value="${staffname}"/>
                <span><a onclick="updatePwd()">你好：${staffname}[修改密码]</a></span>
            </div>
            <div class="icon-wrap">

                <span style="margin-top:12px;"><a  title="退出" class="glyphicon glyphicon-off" onclick="click_logout()"></a></span>
            </div>
        </div>
    </div>
    <div class="content-tabs"   style="background-color:#f1f1f1 ;">
        <button class="roll-nav roll-left J_tabLeft"   style="background-color:#f1f1f1 ;"><i class="glyphicon glyphicon-backward"></i>
        </button>
        <nav class="page-tabs J_menuTabs">
            <div class="page-tabs-content">
                <a href="javascript:;" class=" active J_menuTab" data-id="login.html" style="font-weight: bold">领导驾驶舱</a>
                <!--<a href="javascript:;" class="active J_menuTab" data-id="login.html">主页示例三 <i class="fa fa-times-circle"></i></a>-->
            </div>
        </nav>
        <button class="roll-nav roll-right J_tabRight" style="background-color:#f1f1f1;"><i class="glyphicon glyphicon-forward"></i>
        </button>
        <div class="btn-group roll-nav roll-right"   style="background-color:#f1f1f1 ;">
            <button class="dropdown J_tabClose" data-toggle="dropdown"   style="background-color:#f1f1f1 ;">操作<span class="caret"></span>
            </button>
            <ul role="menu" class="dropdown-menu dropdown-menu-right"   style="background-color:#f1f1f1;">
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
    <iframe class="J_iframe" scrolling="auto" style="border:none;min-width: 1250px" name="iframe0" width="100%" height="100%" src=${userHome} frameborder="0" data-id="login.html"></iframe>
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

<div class="ce-nan">
    <div class="login">
        <p>Ddata</p>
        <p>雕龙数据</p>
    </div>
    <ul class="candan-list"  id="topmenu">
    </ul>
</div>

<script>
    $('.li-t-a').click(function(){
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
    });

</script>
</body>
</html>
