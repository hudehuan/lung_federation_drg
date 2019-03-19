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
            $("input:checkbox[value='true']").attr('checked', 'true');
            // 自定义参数调用
            formValiPost("caozuo", "${ctx}/formDefineField/update", function (json) {
                if (json.success == false) {
                    $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                }
                else {
                    window.parent.showDiv();
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
<form id="caozuo" action="${ctx}/formDefineField/update" method="post">

    <div class="container from-content">
        <input type="hidden" name="fdId" id="fdId" value="${formDefineField.fdId}">
        <input type="hidden" name="tdId" id="tdId" value="${formDefineField.tdId}">
        <input type="hidden" name="itemId" id="itemId" value="${formDefineField.itemId}">
        <p style="color:blue;margin:10px 20px;">${formDefineField.fdName}</p>
        <div class="div_border">
            <div class="div_h">
                <label for="xh" style="margin-right:24px;">序号</label>
                <input type="number" class=" form-control bi-width140" id="xh" name="xh" onkeydown="DigitInput()"
                       value="${formDefineField.xh}"/>
            </div>
            <div class="div_h">
                <label for="level" style="margin-right:11px;">层次码</label>
                <input type="text" class=" form-control validate[required] bi-width140" id="level"
                       name="level" value="${formDefineField.level}"/>
                <b class="redColor">*</b>
            </div>
            <%--<div class="div_h">--%>
                <%--<label for="isEdit" style="margin:0 5px 0 15px;">修改</label>--%>
                <%--<input type="checkbox" placeholder=" " id="isEdit" name="isEdit" value="${formDefineField.isEdit}"/>--%>
            <%--</div>--%>
        </div>
        <div class="div_border">
            <div class="div_h">
                <label for="fdName">显示名称</label>
                <input type="text" class=" form-control  validate[required] bi-width140" id="fdName" name="fdName"
                       value="${formDefineField.fdName}"/>
                <b class="redColor">*</b>
            </div>
            <div class="div_h">
                <label for="unit" style="margin:0 8px 0 7px;">单位</label>
                <input type="text" class=" form-control bi-width140" id="unit" name="unit" value="${formDefineField.unit}"/>
            </div>
        </div>
        <button type="button" onclick="clearall()" class="btn btn-default bi-btn bi-btn-default  bi-btn-width90">取消
        </button>
        <button type="submit" class="btn btn-primary bi-btn bi-btn-width90">保存</button>

    </div>
</form>

</body>
</html>

