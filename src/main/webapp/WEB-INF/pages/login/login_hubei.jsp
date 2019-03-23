<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/09/27
  Time: 10:33
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
    <title>DRGs医疗绩效评价系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/bootstrap-3.3.5/css/bootstrap.css">
    <%--<link rel="stylesheet" type="text/css" href="${ctx}/static/css/login.css">--%>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/login-4.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/base.css">
    <link rel="stylesheet" href="${ctx }/static/js/plugins/layer/skin/layer.css" />
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/common.js" ></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/layer/layer.js"></script>

    <script>
        $(function() {
            if ('${username}' != '') {
                $('#rememberMe').attr('checked','checked');
            }
            if("${paramsError}"){
                layerInfo("${paramsError}");
            }
        })
        function down(){
            if(event.keyCode==13){
                login();
            }
        }
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
                        window.location.href = '/index/index';
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
<body onkeydown="down()">


<div class="box">

    <div class="center">
        <div class="header" style="text-align: center;width: 800px;">湖北省省级住院医疗服务绩效评价平台</div>
        <div class="b-login">
            <form method="post" id="loginForm">
                <input type="hidden" name="client" value=${client}/>
                <input type="hidden" name="syscode" value=${syscode} />
                <input type="hidden" name="dlAdmin" value=${dlAdmin} />
                <input type="hidden" name="ukeynum" id="ukeynum"  />
                <input type="hidden" name="ukey" id="ukey"  />
            <div class="login-y">

                <ul>
                    <li style="">
                        <input type="text" placeholder="请输入用户名" class="yonghuming" id="username" name="username" value="${username}">
                        <label style="position:absolute;top:10px;left:6px;"><img src="${ctx}/static/img/yonghuming.png"></label>
                    </li>
                    <li style="">
                        <input type="password" name="password" placeholder="请输入密码"
                               class="mima" id="txtpwd" autocomplete="off">
                        <label style="position:absolute;top:10px;left:6px;"><img src="${ctx}/static/img/mima.png"></label>
                    </li>
                </ul>
                <div class="forget">
							<span class="jizhumima">
								<input class="checkbox" type="checkbox" id="rememberMe" name="rememberMe" style="position:absolute;top:0px;left: 5px;">
								 <span>记住账号</span>
							</span>
                    <%--<span class="wangjimima">--%>
								<%--<a>忘记密码？</a>--%>
							<%--</span>--%>
                </div>
                <a class="denglu" readOnly="true"  onclick="login();"> 登录</a>
                <p class="footer">
                    <a class="foot-logo" onclick="window.open('http://www.dldata.cn')">
                        <span><i style="color:#b81d23">D</i><i style="color:#2c2d2c">d</i><i style="color:#edad27">a</i><i style="color:#2c2d2c">t</i><i style="color:#3d98d3">a</i></span>
                        <span>雕龙数据</span>
                    </a>
                    <span class="foot-name">TEL： 027 - 87659229</span>
                </p>
            </div>
            </form>
        </div>


    </div>
</div>

</body>
</html>


