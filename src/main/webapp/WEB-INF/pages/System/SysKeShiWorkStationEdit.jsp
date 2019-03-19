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
    <title>科室工作站编辑</title>
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
            formValiPost("huli","${ctx}/SysKsWorkStation/save",function(json){
                if(json.success==false)
                {
                    $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                }
                else
                {
                    parent.refresh();
                    layerSuccess("成功",function(){
                        //关闭窗体
                        closeIndexWindwos();
                    });

                }

            });
        });

    </script>

</head>
<body>

<form id="huli" action="${ctx}/SysKsWorkStation/save" method="post" >
    <input type="hidden" name="id" value="${ksWsEntity.id}"/>
    <div class="container from-content">
        <div class="div_border">
            <label for="code">代码&nbsp;&nbsp;</label>
            <input id="code" name="code" type="text" onchange="checkCodeUnique()" onkeydown="DigitInput()"
                   class="bi-width357 form-control validate[required]" value="${ksWsEntity.code}"/>
            <b class="redColor">*</b>
        </div>
        <div class=" div_border">
            <label for="name">名称&nbsp;&nbsp;</label>
            <input type="text" placeholder=" " id="name" name="name" value="${ksWsEntity.name}"
                   class="bi-width357 validate[required] form-control"/>
            <b class="redColor">*</b>
        </div>

        <button type="button" onclick="clearall()" class="btn btn-default bi-btn bi-btn-default   bi-btn-width90">取消
        </button>
        <button type="submit" class="btn btn-primary bi-btn bi-btn-width90" >保存</button>

    </div>
</form>
</body>
</html>
