<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/8/16
  Time: 15:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>朔州博爱医院</title>
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

            formValiPost("yuanqu", "${ctx}/SysHospitalBranch/save", function (json) {
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
<div class="container from-content">
    <form id="yuanqu" action="${ctx}/SysHospitalBranch/save" method="post">
        <input type="hidden" name="id" id="id" value="${hospitalBranch.id}"/>
        <div class="div_border">
            <div class="div_h">
                <label for="xh">序号</label>
                <input id="xh" name="xh" type="number" class="bi-width140 form-control" style="margin-right:13px;"
                       value="${hospitalBranch.xh}" onkeydown="DigitInput()"/>
            </div>
            <div class="div_h" style="margin-left:10px;">
                <label for="code">院区代码</label>
                <input type="text" placeholder=" " class="bi-width140 validate[required] form-control" id="code"
                       name="code" value="${hospitalBranch.code}" onkeydown="DigitInput()"/>
                <b class="redColor">*</b>
            </div>
        </div>
        <div class="addwidth div_border">
            <label for="name">名称</label>
            <input type="text" placeholder=" " id="name" name="name"
                   class="bi-width357 validate[required] form-control" value="${hospitalBranch.name}"/>
            <b class="redColor">*</b>
        </div>
        <div class="addwidth div_border">
            <label for="address">地址</label>
            <input id="address" name="address" type="text" placeholder=" " class="bi-width357 form-control"
                   value="${hospitalBranch.address}"/>
        </div>
        <button type="button" onclick="clearall()" class="btn btn-default bi-btn bi-btn-default  bi-btn-width90">取消
        </button>
        <button type="submit" class="btn btn-primary bi-btn bi-btn-width90">保存</button>
    </form>
</div>
</body>
</html>