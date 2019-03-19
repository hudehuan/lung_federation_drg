<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/8/31
  Time: 17:24
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
    <title>雕龙数据</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" type="text/css" href="/static/js/bootstrap-3.3.5/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/static/css/style.css">
    <link rel="stylesheet" type="text/css" href="/static/js/plugins/layer/skin/layer.css">
    <link rel="stylesheet" type="text/css" href="/static/js/jquery-easyui-1.5/themes/default/easyui.css">
    <link rel="stylesheet" href="/static/js/plugins/validationEngine/css/validationEngine.jquery.css" type="text/css"/>
    <script type="text/javascript" src="/static/js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="/static/js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
    <script src="/static/js/plugins/validationEngine/languages/jquery.validationEngine-zh_CN.js" type="text/javascript" charset="utf-8">
    </script>
    <script src="/static/js/plugins/validationEngine/jquery.validationEngine.js" type="text/javascript" charset="utf-8">
    </script>
    <script type="text/javascript" src="/static/js/My97DatePicker/WdatePicker.js">  </script>
    <script type="text/javascript" src="/static/js/common.js"></script>
    <script type="text/javascript" src="/static/js/plugins/layer/layer.js"></script>

    <script type="text/javascript">
        //		点取消关闭窗口
        function clearall(){
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
            parent.layer.close(index); //执行关闭
        }

        $(function(){
            // 自定义参数调用
            formValiPost("riqi", "${ctx}/ExcelImport/addImportDate", function (json) {

                if (json.success == false) {
                    $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                }
                else {

                    parent.refresh();
                    layerSuccess("成功", function () {
                        //关闭窗体
                        closeIndexWindwos();
                    });
                }

            });


        });

    </script>
    <style>
        /*去掉滚动条*/
        body{overflow-y:hidden;}
    </style>


</head>
<body>

<form action="${ctx}/ExcelImport/addImportDate" id="riqi">
    <input type="hidden" name="tableId" id="tableId" value=${tableId}>
    <div class="container from-content">
        <div  class=" div_border" style = "padding:10px 25px;">
            <label for="inputDate">数据日期</label>
            <input  type="text" placeholder=" "id="inputDate" name="inputDate" class="bi-width140 validate[required] form-control Wdate" style="width:160px;"
                    onclick="WdatePicker()"/>
            <b class="redColor">*</b>
        </div>

        <button type="button" onclick="clearall()" class="btn btn-default bi-btn bi-btn-default  bi-btn-width90"
                style="margin-right:80px;">取消</button>
        <button type="submit"   class="btn btn-primary bi-btn bi-btn-width90">保存</button>

    </div>
</form>



</body>
</html>
