<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/7/21
  Time: 13:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>${titlename}</title>

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
            formValiPost("juese", "${ctx}/SysRole/save", function (json) {
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

</head>
<body>
<form id="juese" action="${ctx}/SysRole/save" method="post">
    <input type="hidden" name="id" id="id" value="${role.id}">
    <input type="hidden" name="sysCode" id="sysCode" value="${sessionScope.syscode}">

    <div class="container from-content">
        <div class="div_border">
            <div class="div_h">
                <label for="xh">序号</label>
                <input id="xh" type="number" class="bi-width140 form-control" name="xh" value="${role.xh}"
                       style="margin-right:45px;" onkeydown="DigitInput(this)"/>
            </div>

            <div class="div_h">
                <%--<label for="type">分类</label>--%>
                <%--<input type="text" placeholder=" " id="type" name="type" onkeydown="DigitInput(this)"--%>
                <%--class="bi-width140 validate[required] form-control" value="${role.type}"/>--%>
                <%--<b class="redColor">*</b>--%>
                <%--</div>--%>
                <%--</div>--%>
                <%--<div class="div_border">--%>
                <label for="name">名称</label>
                <input id="name" type="text" placeholder=" " name="name" value="${role.name}"
                       class="bi-width140 validate[required] form-control"/>
                <b class="redColor">*</b>
            </div>
        </div>
        <button type="button" onclick="clearall()" class="btn btn-default bi-btn bi-btn-default  bi-btn-width90">取消
        </button>
        <button type="submit" class="btn btn-primary bi-btn bi-btn-width90">保存</button>

    </div>
</form>
</body>
</html>
