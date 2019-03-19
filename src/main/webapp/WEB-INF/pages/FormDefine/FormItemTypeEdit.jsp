<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/8/12
  Time: 10:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>雕龙数据</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <script type="text/javascript">
        //		点取消关闭窗口
        function clearall() {
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
            parent.layer.close(index); //执行关闭
        }
        function refreshParent() {
            GetIndexActiveIframe().refresh();
        }
        function btnclose() {
            closeIndexWindwos();
        }

        $(function () {
            // 自定义参数调用
            formValiPost("edit", "${ctx}/formItemType/save", function (json) {
                if (json.success == false) {
                    if(json.id){
                        $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                    }else{
                        layerError(json.msg);
                    }
                }
                else {
                    parent.loadMenu();
                    $('#edit')[0].reset();
                    layerSuccess("成功", function () {
                        //关闭窗体
                        closeIndexWindwos();
                    });
                }
            });
        });
    </script>
</head>
<body>
<form action="${ctx}/formItemType/update" method="post" id="edit">

    <div class="container from-content">
        <input type="hidden" name="typeId" id="typeId" value="${formItemType.typeId}">
        <input type="hidden" name="level" id="level" value="${formItemType.level}"/>
        <input type="hidden" name="status" id="status" value="${formItemType.status}">
        <input type="hidden" name="sysCode" id="sysCode" value="${formItemType.sysCode}"/>
        <input type="hidden" name="pLevel" id="pLevel" value="${pLevel}">

        <div class=" div_border">
            <div class="div_h">
                <label for="xh">序号&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <input id="xh" type="number" placeholder=" " name="xh" class="bi-width140 form-control"
                       value="${formItemType.xh}"/>
            </div>
        </div>
        <div class="div_border">
            <label for="typeName">名称&nbsp;&nbsp;&nbsp;&nbsp;</label>
            <input type="text" placeholder=" " id="typeName" name="typeName" value="${formItemType.typeName}"
                   class="bi-width357 validate[required] form-control"/>
            <b class="redColor">*</b>
        </div>
        <button type="button" onclick="clearall()" class="btn btn-default bi-btn bi-btn-default  bi-btn-width90">取消
        </button>
        <button type="submit" class="btn btn-primary bi-btn bi-btn-width90">保存</button>

    </div>

</form>
</body>
</html>
