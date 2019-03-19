<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/8/23
  Time: 14:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <%@ include file="/common/meta.jsp"%>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

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

        $(function(){
            // 自定义参数调用
                formValiPost("change", "${ctx}/SysUserInfo/editPwd", function (json) {
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

<form  id="change" action="${ctx}/SysUserInfo/editPwd" method="post" target="_parent">
    <input type="hidden" id="id" name="id" value="${id}"/>
    <div class="container from-content">
        <!--  <div class="div_border">
                 <label for="c_password">初始密码&nbsp;&nbsp;</label>
                 <input  id="c_password" name="c_password" type="text" class="bi-width357 form-control validate[required]" />
         </div> -->
        <div  class=" div_border">

            <label for="x_password">修改密码&nbsp;&nbsp;</label>
            <input  type="text" placeholder=" "id="x_password" name="x_password" class="bi-width357  form-control"/>


        </div>
        <div  class=" div_border">

            <label for="loginPwd">确认密码&nbsp;&nbsp;</label>
            <input  type="text" placeholder=" "id="loginPwd" name="loginPwd" class="bi-width357 form-control validate[required,equals[x_password]] text-input" />

        </div>
        <button type="button" onclick="clearall()" class="btn btn-default bi-btn bi-btn-default   bi-btn-width90" >取消</button>
        <button type="submit"  class="btn btn-primary bi-btn bi-btn-width90">保存</button>

    </div>
</form>
</body>
</html>
