<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2017/4/20
  Time: 17:55
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>

    <title></title>
    <script>
        $(function(){


            formValiPost("sysform", "${ctx}/CustomForm/save", function (json) {
                if (json.success == false) {
                    $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                }
                else {

                    layerSuccess("成功", function () {
                        //关闭窗体
                        parent.loadForm();
                        closeIndexWindwos();
                        $('#sysform')[0].reset()
                        //刷新父窗口数据

                    });
                }
            });

        });

        function clearall() {
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
            parent.layer.close(index); //执行关闭
        }
    </script>
</head>
<body>

<form  id="sysform" >
    <input type="hidden" name="id" id="id" value="${data.id}"/>
    <input type="hidden" name="tableName" id="tableName" value="${data.tableName}"/>
    <input type="hidden" name="listName" id="listName" value="${data.listName}"/>
    <div class="container from-content">

        <div class="div_border">
            <label for="name" style="margin-right:34px;">表单名称</label>
            <input id="name" class="bi-width357  form-control" type="text" placeholder=" " name="name" value="${data.name}" />
        </div>

        <div class="div_border">
            <label for="code" style="margin-right:22px;">表单代码</label>
            <input id="code" class="bi-width357  form-control" type="text" placeholder=" " name="code" value="${data.code}" />
        </div>


        <div class="div_border">
            <label for="bz" style="margin-right:34px;">表单说明</label>
            <input id="bz" class="bi-width357  form-control" type="text" placeholder=" " name="bz" value="${data.bz}" />
        </div>






        <button type="button" onclick="clearall()" class="btn btn-default bi-btn-default bi-btn bi-btn-width90 " name="closed">取消</button>
        <button type="submit"  class="btn btn-primary bi-btn bi-btn-width90 ">保存</button>


    </div>
</form>

</body>
</html>
