<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2017/5/2
  Time: 14:39
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>

    <title>Title</title>


    <script>
        //		点取消关闭窗口
        function clearall() {
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引

            parent.layer.close(index); //执行关闭
        }


        $(function(){

            formValiPost("formtemplet", "${ctx}/CustomFormTemplate/saveClone", function (json) {
                if (json.success == false) {
//                    $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                    layerInfo(json.msg);
                }
                else {

                    layerSuccess(json.msg, function () {
                        //刷新父窗口数据
                        parent.refloadFormTemplet();
                        //关闭窗体
                        closeIndexWindwos();
                        //$('#formtemplet')[0].reset()


                    });
                }
            });

        });





    </script>



</head>
<body>


<%--<input type="hidden" id="fieldID" value="${fieldID}"/>--%>

<form  id="formtemplet" >


    <input type="hidden" name="templateId" id="formId" value="${templateId}"/>
    <%--<input type="hidden" name="createTime" id="createTime" value="${sjsbSysFormTempletEntity.createTime}"/>--%>
    <div class="container from-content">

        <div class="div_border"  style="padding:10px 20px">

            <div class="div_h" style="margin-left:16px;">
                <label for="name" style="margin-right:10px;">模板名称</label>
                <input id="name" class="bi-width140  form-control" type="text" placeholder=" "  name="name" />
                <b class="redColor">*</b>
            </div>

        </div>





        <button type="button" onclick="clearall()" class="btn btn-default bi-btn-default bi-btn bi-btn-width90 " name="closed">取消</button>
        <button type="submit"  class="btn btn-primary bi-btn bi-btn-width90 ">保存</button>


    </div>
</form>




</body>
</html>
