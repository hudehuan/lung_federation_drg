<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/10/28
  Time: 10:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>雕龙数据</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <%@ include file="/common/meta.jsp" %>

    <script>
        $(function() {
            formValiPost("systemDefine", "${ctx}/SystemDefine/save", function (json) {

                if (json.success == true) {
                    layerSuccess(json.msg);
                }
                else {
                    $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                }

            });
        })
    </script>
    <style>
        thead,tbody{font-size:12px;}
    </style>
</head>
<body>
<div class="container">
    <table class="table ">
        <thead>
        <tr>
            <th style="width:80px;">系统代码</th>
            <th>系统名称</th>
            <th>LoginURL</th>
            <th>序号</th>
            <th>RedirectURL</th>
            <th>IP</th>
            <th>端口号</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${systemDefine}" var="define">
            <form id="systemDefine">
                <tr>
                    <input type="hidden" name="id" value="${define.id}"/>
                    <input type="hidden" name="sysCode" value="${define.sysCode}"/>
                    <input type="hidden" name="sysName" value="${define.sysName}"/>
                    <input type="hidden" name="loginUrl" value="${define.loginUrl}"/>
                    <td>${define.sysCode}</td>
                    <td>${define.sysName}</td>
                    <td>${define.loginUrl}</td>
                    <td><input id="xh" name="xh" class="form-control" style="width:35px;" value="${define.xh}"/></td>
                    <td><input id="redirectUrl" class="form-control"  style="width:90px;" name="redirectUrl" value="${define.redirectUrl}"/></td>
                    <td><input id="redirectIp" class="form-control" style="width:130px;" name="redirectIp" value="${define.redirectIp}"/></td>
                    <td><input id="redirectPort" class="form-control" style="width:50px;" name="redirectPort" value="${define.redirectPort}"/></td>
                    <td>
                        <button type="submit" class='btn btn-info bi-glyphicon'>
                            <span class='glyphicon glyphicon glyphicon-ok'></span>
                        </button>
                    </td>
                </tr>
            </form>

        </c:forEach>
        </tbody>
    </table>

</div>
</body>
</html>

