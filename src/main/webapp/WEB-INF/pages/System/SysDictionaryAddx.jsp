<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/8/3
  Time: 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>字典表</title>
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
            formValiPost("zidian", "${ctx}/SysDictionary/save", function (json) {
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

<form action="${ctx}/SysDictionary/save" method="post" id="zidian">
    <input type="hidden" name="did"/>
    <div class="container from-content">

        <div class="div_border">
            <div class="div_h">
                <label for="dicCode">编码&nbsp;&nbsp;</label>
                <input type="text" placeholder=" " onkeydown="DigitInput(this)"
                       id="dicCode" name="dicCode" class="validate[required] bi-width80 form-control"/>
                <b class="redColor">*</b>
            </div>
            <div class="div_h">
                <label for="dicName"  style="margin-left: 10px">名称&nbsp;&nbsp;</label>
                <input id="dicName" name="dicName" type="text"
                       class="bi-width140 form-control validate[required]"/>
                <b class="redColor">*</b>
            </div>
            <div class="div_h">
                <input id="sys" type="checkbox" name="sys" style="margin-left:10px;"/>&nbsp;系统字典
            </div>
        </div>
        <div class=" div_border">

            <label for="bz">说明&nbsp;&nbsp;</label>
            <input type="text" placeholder=" " id="bz" name="bz" class="bi-width357  form-control " style="width:367px;"/>

        </div>

        <button type="button" onclick="clearall()" class="btn btn-default bi-btn bi-btn-default   bi-btn-width90">取消
        </button>
        <button type="submit" class="btn btn-primary bi-btn bi-btn-width90">保存</button>
        <div style="margin-top:25px;padding-left:25px; color:orangered;">
            <p>注：默认在非系统字典代码前自动添加“${sysCode}”。</p>
            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;系统字典一旦保存则无法修改！</p>
        </div>
    </div>
</form>

</body>
</html>