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
        function refreshParent(){
            GetIndexActiveIframe().refresh();
        }
        function btnclose(){
            closeIndexWindwos();
        }

        function toSave(){
            <%--$.getJSON("/ExcelImportRecord/checkDataIsExist?tableId=${tableId}&inputDate="+$('#inputDate').val(),function(data){--%>
                <%--if(data.isExist == true){--%>
                    <%--//layerInfo("当月数据已导入，请先删除后重新导入！");--%>
                    <%--//删除成功后，会继续提交--%>
                    <%--if(data.isSH==true){--%>
                        <%--layerInfo("数据已导入，并审核通过，请先取消审核！");--%>
                    <%--}else{--%>
                        <%--layerConfirm("当月数据已导入,是否确定删除后重新导入?",record_delete);--%>
                    <%--}--%>

                <%--}else{--%>
                    <%--submit();--%>
                <%--}--%>
            <%--});--%>
            submit();
        }


        <%--function record_delete(){--%>

            <%--$.ajax({--%>
                <%--type : 'post',--%>
                <%--url : "/ExcelImportRecord/deleteByInputDateTableId?tableId=${tableId}&inputDate="+$('#inputDate').val(),--%>
                <%--dataType: "json",--%>
                <%--success:function(data){--%>
                    <%--if(data.success == true){--%>
                        <%--submit();--%>
                    <%--}else{--%>
                        <%--//alert(data.msg);--%>
                    <%--}--%>
                <%--}--%>

            <%--});--%>
        <%--}--%>

        function submit() {
            var formData = new FormData($('#muban')[0]);
            $.ajax({
                url: '${ctx}/ExcelImport/import',
                type: 'POST',
                data: formData,
                dataType: 'json',
                async: false,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
//                    alert('test');
                    if (data.success == false) {
                        //return false;

                        layerInfo(data.msg)
                    }
                    else {
                        parent.refresh();
                        //debugger;
                        layerSuccess("成功", function () {
                            //关闭窗体
                            closeIndexWindwos();
                        });

                    }
                    return false;
                }
            });
        }

    </script>
    <style>
        /*去掉滚动条*/
        body{overflow-y:hidden;}
    </style>


</head>
<body>

<form action="${ctx}/ExcelImport/import" id="muban" name="muban" enctype="multipart/form-data" method="post">
    <input type="hidden" name="tableId" id="tableId" value=${tableId}>
    <input type="hidden"   name="recordId" id="recordId" value="${recordId}">
    <div class="container from-content">

    <c:if test="${wdmList!=null && fn:length(wdmList)>0}">
        <div  class=" div_border" id = "div_wdm">
                <label for="wdm" style="margin-right:23px;">名称</label>

                    <select name="wdm" id="wdm" style="padding:2px 0px;" class="bi-width140 form-control">
                        <c:forEach items="${wdmList}" var="wdm">
                            <option value="${wdm.dm}" >${wdm.name}</option>
                        </c:forEach>
                    </select>
        </div>
        </c:if>
        <div class=" div_border">
            <label for="file" style="margin-right: 23px;">选择导入文件</label>
            <input id="file" type="text" placeholder=" " name="file" class="bi-width357 easyui-filebox form-control validate[required]"  data-options="prompt:'选择文件'">
        </div>
        <button type="button" onclick="clearall()" class="btn btn-default bi-btn bi-btn-default  bi-btn-width90">取消</button>
        <button type="button" onclick="toSave();"  class="btn btn-primary bi-btn bi-btn-width90">保存</button>

    </div>
</form>



</body>
</html>
