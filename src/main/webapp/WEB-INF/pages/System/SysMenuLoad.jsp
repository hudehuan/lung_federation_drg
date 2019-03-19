<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/4/7
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>模板文件导入</title>
    <script>
        function clearall() {
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
            parent.layer.close(index); //执行关闭
        }
        $(function () {

            // 自定义参数调用

            formValiPost("caidan", "/sysMenu/doLoadMenu", function (json) {
                if (json.success == false) {
//                    $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                    layerInfo(json.msg);
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
<div style="width:100%;float:right;display:inline-block; padding:10px 20px 10px 60px;border-left:1px solid #ddd;">

    <div style="padding:0 10px 10px 20px;margin-left:20px;">
        <form id="caidan" action="/sysMenu/doLoadMenu" method="post">
        <div>
            <textarea id="json" name="json" rows="10" cols="100" class="validate[required]"></textarea>
        </div>
            <div>
            <b>说明：请导入json格式数据。例: {"id":"id","name":"name"}</b>
        </div>


            <button type="button" class="btn btn-default bi-btn-default bi-btn bi-btn-width90"
                    style="margin-left:110px;marrgin-top:25px;" name="closed" onclick="clearall()">取消
            </button>
            <button type="submit" class="btn btn-primary bi-btn bi-btn-width90" style="margin-top:25px;">保存</button>

        </form>

    </div>
</div>

</form>
</body>
</html>
