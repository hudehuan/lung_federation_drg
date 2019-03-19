<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/8/22
  Time: 15:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="format-detection" content="telephone=no,email=no,address=no">
    <%--<%@ include file="/common/meta.jsp" %>--%>
    <title>雕龙数据</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/bootstrap-3.3.5/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../../static/css/login.css">
    <link rel="stylesheet" type="text/css" href="../../../static/css/base.css">
    <link rel="stylesheet" href="${ctx }/static/js/plugins/layer/skin/layer.css" />
    <!--[if lte IE 9]>
    <script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/respond.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/html5shiv.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/excanvas.compiled.js"></script>
    <![endif]-->
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/common.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/plugins/layer/layer.js"></script>

    <script>
        $(function() {
            if ('${username}' != '') {
                $('#rememberMe').attr('checked','checked');
            }
        })
        function login(){
            $.ajax({
                //cache: true,
                type: "POST",
                url:'/user/login',
                data:$('#loginForm').serialize(),
                dataType: 'json',
                //async: false,
                success: function(data) {

                    if(data.success == true){
                        window.location.href = data.url;
                    }else{
                        layerInfo(data.msg);
                    }
                }
            });
        }

    </script>
    <style>
        input::-ms-clear{display:none;}
    </style>


</head>
<body>
<div class="header">DRGs 医院绩效考核管理</div>
<div class="box">
    <!--<div class="left-bg"><img src="img/left-bg.png"/></div>-->
    <div class="b-login">
        <div class="dl-dlu">欢迎登录！</div>
        <form method="post" id="loginForm">
        <div class="login-y">

            <ul>
                <li style="">
                    <input type="text" name="username" value="${username}" placeholder="请输入用户名" class="yonghuming" id="userName">
                    <label style="position:absolute;top:2px;left:0px;"><img src="../../../static/img/uesr.png"></label>
                </li>
                <li style="">
                    <input type="password" name="password" value="${password}" placeholder="请输入密码" class="mima" id="txtpwd">
                    <label style="position:absolute;top:2px;left:0px;"><img src="../../../static/img/password.png"></label>
                </li>
            </ul>
            <div class="forget">
				<span class="jizhumima">
                    <input class="checkbox" type="checkbox" id="rememberMe" name="rememberMe"
                           style="position:absolute;top:0px;left: 5px;">
                    <span>记住密码</span>
                </span>
            </div>
            <a class="denglu" readOnly="true"  onclick="login();"> 登录</a>
            <!--<a class="denglu" >登录</a>-->
        </div>
            <input type="hidden" name="client" value=${client}/>
            <input type="hidden" name="syscode" value=${syscode} />
            <input type="hidden" name="dlAdmin" value=${dlAdmin} />
        </form>

    </div>
    <!--<div class="l-daoying">
        <p>武汉雕龙医疗数据服务股份有限公司版权所有</p>
    </div>-->
</div>

</body>
</html>
