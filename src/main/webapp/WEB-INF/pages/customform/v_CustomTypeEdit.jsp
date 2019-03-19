<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2017/4/22
  Time: 14:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <script type="text/javascript" src="${ctx }/static/js/FormValidation.js"></script>
    <title>${title}</title>

    <script>
        $(function(){

            formValiPost2("formid", "/CustomType/save",validateForm, function (json) {

                if (json.success == false) {
                    if(json.id!=null&&json.id!=""){
                        $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                    }else{
                        layerError(json.msg);
                    }
                }
                else {

                    layerSuccess("成功", function () {
                        //关闭窗体
                        parent.dorefresh();
                        closeIndexWindwos();
                    });
                }
            });

        });

        var empty="";//看是否为空
        function validateForm(){
            empty="";//看是否为空
//            required("sm");   //说明
            required("name");   //分类
            if(empty.indexOf("0,")>=0){
                return false;
            }
            return true;
        }


        function clearall() {
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
            parent.layer.close(index); //执行关闭
        }
    </script>


</head>
<body>
<form  id="formid" >
    <input type="hidden" name="id" id="id" value="${entity.id}"/>

    <div class="container from-content">

        <div class="div_border">
            <div class="div_h ">
                <label for="xh" style="margin-right:10px;">序&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号</label>
                <input id="xh" class="bi-width357 form-control" type="text" placeholder=" " name="xh" value="${entity.xh}" />
                <b class="redColor">*</b>
            </div>
        </div>
        <div class="div_border">
            <div class="div_h ">
                <label for="name" style="margin-right:10px;">分类名称</label>
                <input id="name" class="bi-width357 form-control" type="text" placeholder=" " name="name" value="${entity.name}" />
                <b class="redColor">*</b>
            </div>
        </div>
        <div class="div_border">
            <div class="div_h ">
                <label for="sm" style="margin-right:10px;">分类说明</label>
                <input id="sm" class="bi-width357  form-control" type="text"  placeholder=" " name="sm" value="${entity.sm}"/>
                <%--<b class="redColor">*</b>--%>
            </div>
        </div>



        <button type="button" onclick="clearall()" class="btn btn-default bi-btn-default bi-btn bi-btn-width90 " name="closed">取消</button>
        <button type="submit"  class="btn btn-primary bi-btn bi-btn-width90 ">保存</button>


    </div>
</form>
</body>
</html>
