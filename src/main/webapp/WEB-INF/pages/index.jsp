<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/8/22
  Time: 16:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <%--<title>雕龙通用后台系统</title>--%>
    <meta charset="UTF-8">
    <title>雕龙数据</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/bootstrap-3.3.5/css/bootstrap.css">
    <!-- <link rel="stylesheet" type="text/css" href="./css/common.css"> -->
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/integration.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/myintegration.css">

    <link rel="stylesheet" href="${ctx }/static/js/plugins/layer/skin/layer.css" />
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js"></script>
        <!--[if lte IE 9]>
        <script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/respond.min.js"></script>
        <script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/html5shiv.min.js"></script>
        <script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/excanvas.compiled.js"></script>
        <![endif]-->
    <script type="text/javascript" src="${ctx }/static/js/common.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/plugins/layer/layer.js"></script>

        <style>
            a:focus{outline:none;}
        </style>
    <script>
        $(function(){
            $("#pz").hide();
            var sys = GetUrlParam("sys")
            if(sys==1){
                $("#pz").show();
            }
        });


        function openWin() {
            layeropen(800, 500,"系统配置","/V_SysSystemDefine/gotoSystemDefine");

        }
    </script>
</head>
<body>



<div class="container-fluid container-all">
    <%--<img class="bg" src="/static/img/bg_1.jpg"/>--%>
        <img class="bg" src="/static/img/bg_2.jpg"/>
    <div class="header">
        <%--<img src="/static/img/雕龙数据新logo.png" style="width:15%;">--%>
        <%--<div class="login-title" style=" color: white;font-size: 22px; font-weight: 700;margin-top:30px;">雕龙数据--%>
            <%----%>
        <%--</div>--%>

    </div>
    <div class="main">
        <div class="main-header">
            <span class="title">欢迎进入雕龙数据平台-请选择系统</span>
            <button onclick="openWin()" class="btn btn-warning" style="margin:-3px 0 0 10px;" id="pz">系统配置</button>
            <div style="float: right">
                <%--<a href="/ExcelImport/download?fileName=傲游云浏览器.exe" style="visibility:hidden"><button  class="btn btn-warning" style="margin:-3px 0 0 10px;" ></button></a>--%>
                <%--<a href="/ExcelImport/download?fileName=傲游云浏览器.exe"><button  class="btn btn-warning" style="margin:-3px 0 0 10px;" >浏览器下载</button></a>--%>
                <a href="/ExcelImport/download?fileName=傲游云浏览器.exe"><span class="more" style="font-size:12px;color:#252525">浏览器下载</span></a>
            </div>
            <%--<a href="/ExcelImport/download?fileName=傲游云浏览器.exe"><span class="more">浏览器下载</span></a>--%>
        </div>
        <div class="main-content">
            <c:if test="${sysSystems!=null && fn:length(sysSystems)>0}">
                <c:set var="num" value="1"></c:set>
                <c:forEach items="${sysSystems}" var="system" varStatus="index">
                    <%--<div style="width: 200px;height: 200px">--%>


                    <%--<a href="/user/tologin/${system.loginUrl}?client=http://${system.redirectIp}:${system.redirectPort}/${system.redirectUrl}&syscode=${system.sysCode}"> ${system.sysName} </a>--%>
                       <%----%>

                        <div class="item">
                            <a class="item-link" onclick="openurl()" href="/user/tologin/${system.loginUrl}?sysname=${system.sysName}&client=http://${system.redirectIp}:${system.redirectPort}/${system.redirectUrl}&syscode=${system.sysCode}">
                                <img class="item-icon" src="/static/img/sys${num}.png"/>
                                <div class="item-name">${system.sysName}</div>
                            </a>
                        </div>
                    <c:set var="num" value="${num+1}"/>
                    <c:if test="${num==5}"><c:set var="num" value="1"></c:set></c:if>
                    <%--</div>--%>
                </c:forEach>
            </c:if>

        </div>
    </div>
</div>
</body>
</html>
