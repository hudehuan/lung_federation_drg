<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/9/7
  Time: 13:56
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
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/bootstrap-3.3.5/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/style.css">
    <link rel="stylesheet" href="${ctx}/static/js/plugins/layer/skin/layer.css" />
    <link rel="stylesheet" href="${ctx}/static/js/plugins/validationEngine/css/validationEngine.jquery.css" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js"></script>
    <script src="${ctx}/static/js/plugins/validationEngine/languages/jquery.validationEngine-zh_CN.js" type="text/javascript" charset="utf-8">
    </script>
    <script type="text/javascript" src="${ctx}/static/js/My97DatePicker/WdatePicker.js">  </script>
    <script type="text/javascript" src="${ctx}/static/js/stickUp.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/common.js"></script>
    <script src="${ctx}/static/js/plugins/validationEngine/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/layer/layer.js"></script>

    <script type="text/javascript">
        //		点取消关闭窗口
        function clearall(){
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
            parent.layer.close(index); //执行关闭
        }
        function refreshParent(){
            GetIndexActiveIframe().refresh();
        }
        function btnclose(){
            closeIndexWindwos();
        }

        $(function(){
            // 自定义参数调用
            formValiPost("riqi", "${ctx}/FormDefineValue/saveDefineValue", function (json) {

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
<form  id="riqi" action="${ctx}/FormDefineValue/saveDefineValue">
    <input type="hidden"   name="tdId" id="tdId" value="${tdId}">
    <div class="container from-content">
        <div class=" div_border" style = "padding:10px 25px;">
            <label for="date">上报日期&nbsp;&nbsp;</label>
            <input  type="text" placeholder=" "   style="width:160px;" class="bi-width140 validate[required] form-control Wdate" id="date" name="date"
                    onclick="WdatePicker({dateFmt:'${dateFmt}'
                    <c:out value="${dateFmt=='yyyy-MM季'?
                     ',isQuarter:true, isShowOK:false, disabledDates:[\"....-0[5-9]-..\",\"....-1[0-2]-..\"], startDate:\"%y-01-01\"':
                     ''
                     }"/>})"
            <%--<input  type="text" placeholder=" "   style="width:160px;" class="bi-width140 validate[required] form-control Wdate" id="date" name="date" onclick="WdatePicker({dateFmt:'${dateFmt}'})" />--%>

        </div>
        <button type="button" onclick="clearall()" class="btn btn-default bi-btn bi-btn-width90" style="margin-right:105px;">取消</button>
        <button type="submit"  class="btn btn-primary bi-btn bi-btn-width90">保存</button>

    </div>
</form>


</body>
</html>
