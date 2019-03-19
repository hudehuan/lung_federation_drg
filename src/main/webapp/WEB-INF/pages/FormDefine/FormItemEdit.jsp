<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/8/12
  Time: 10:49
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
            formValiPost("edit", "${ctx}/formItem/save", function (json) {
                if (json.success == false) {
                    if(json.id){
                        $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                    }else{
                        layerError(json.msg);
                    }
                }
                else {
                    parent.LoadFormItems($('#typeId').val());
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
<form id="edit" action="${ctx}/formItem/update" method="post">
    <div class="container from-content">
        <input type="hidden" name="itemId" id="itemId" value="${formItem.itemId}">
        <input type="hidden" name="typeId" id="typeId" value="${typeId}">
        <div class=" div_border">
            <div class="div_h">
                <label for="xh">序号&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <input id="xh" type="number" placeholder=" " name="xh" class="bi-width140 form-control"
                       value="${formItem.xh}" onkeydown="DigitInput()"/>
            </div>
            <div class="div_h" style="margin-left:20px;">

                <input  type="checkbox" placeholder=" "id="isText" name="isText"  value="${formItem.isText}"/>
                <label for="isText">&nbsp;&nbsp;文本</label>
            </div>
        </div>
        <div class="div_border">
            <label for="itemName">名称&nbsp;&nbsp;&nbsp;&nbsp;</label>
            <input type="text" placeholder=" " id="itemName" name="itemName"  value="${formItem.itemName}"
                   class="bi-width357 validate[required] form-control"/>
            <b class="redColor">*</b>
        </div>
        <div class=" div_border">
            <label for="sfDesc" style="height:30px;vertical-align: middle;margin-top:-40px;">算法&nbsp;&nbsp;&nbsp;&nbsp;</label>
            <textarea  id="sfDesc" type="text" name="sfDesc"  class="form-control bi-width357"
                       style="height:60px;">${formItem.sfDesc}</textarea>
        </div>
        <button type="button" onclick="clearall()" class="btn btn-default bi-btn bi-btn-default  bi-btn-width90">取消
        </button>
        <button type="submit" class="btn btn-primary bi-btn bi-btn-width90">保存</button>

    </div>
</form>


</body>
</html>