<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/12/15
  Time: 13:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>密码修改</title>
    <script>

        $(function(){
            formValiPost2("formid", "/userlogin/saveupdatePwd",validateForm, function (json) {
                if (json.success == false) {
                    debugger;
                    if(json.id!=null&&json.id!=""){
                        $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                    }else{
                        layerError(json.msg);
                    }
                } else {
                    layerSuccess("密码修改成功,请重新登录！", function () {
                        parent.click_logout();
                        //关闭窗体
                        closeIndexWindwos();
                    });
                }
            });

        })
        var empty="";//看是否为空
        function validateForm(){

            return true;

        }
        function clearall(){
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
            parent.layer.close(index); //执行关闭
        }

    </script>
</head>
<body>



<form id="formid"  class="bi_form">

    <div class="div_border">
        <label for="loginPwd" style="margin-right:33px;margin-left: 100px;">旧密码：</label>
        <input type="password" class="bi-width140 form-control validate[required]"
               id="loginPwd" name="loginPwd"/>
        <b class="redColor">*</b>
    </div>
    <div class="div_border">
        <label for="newPwd1" style="margin-right:33px;margin-left: 100px;">新密码：</label>
        <input type="password" class="form-control bi-width140 validate[required]"
               id="newPwd1" name="newPwd1"/>
        <b class="redColor">*</b>
    </div>
    <div class="div_border">
        <label for="newPwd2" style="margin-right:33px;margin-left: 76px;">确定新密码：</label>
        <input type="password" class="form-control bi-width140 validate[required]"
               id="newPwd2" name="newPwd2"/>
        <b class="redColor">*</b>
    </div>
    <div class="div_border">
        <button type="button" onclick="clearall()" class="btn btn-default bi-btn-default bi-btn bi-btn-width90 " name="closed">取消</button>
        <button type="submit"  class="btn btn-primary bi-btn bi-btn-width90 ">保存</button>

    </div>



</form>
</body>
</html>
