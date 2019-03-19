<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/8/29
  Time: 11:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title></title>
    <script>
        $(function () {
            var height = findDimensions_height();
            var width = findDimensions_width();
            $("#rptFrame").height(height);
        })
    </script>
</head>
<body>

<iframe id="rptFrame" runat="server" scrolling="no" frameborder="0" src=${rptSRC} width="100%" height="100%"></iframe>

</body>
</html>
