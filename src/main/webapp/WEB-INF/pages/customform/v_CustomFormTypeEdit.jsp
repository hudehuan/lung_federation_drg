<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/5/26
  Time: 14:45
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
            if('${entity.xh}'){
                $("#xh").attr("readonly","readonly");
                $("#butt").hide();
            }

            formValiPost2("form_id", "/CustomFormType/save",validateForm, function (json) {

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
                        parent.reLoadCustomFormType('${typeId}');
                        closeIndexWindwos();
                    });
                }
            });

        });

        var empty="";//看是否为空
        function validateForm(){
            empty="";//看是否为空
            required("xh");   //说明
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

        function selectForm(){
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(0.85*width,height-50, "数据编辑", "${ctx}/v_customform/toSelectForm");
        }
        function addFormType(formId,formName){
            $("#formId").val(formId);
            $("#formName").val(formName);
        }
    </script>


</head>
<body>
<form  id="form_id" >
    <input type="hidden" name="id" id="id" value="${entity.id}"/>
    <input type="hidden" name="formId" id="formId" value="${entity.formId}"/>
    <input type="hidden" name="typeId" id="typeId" value="${typeId}"/>

    <div class="container from-content">
        <div class="div_border">
            <div class="div_h ">
                <label for="xh" style="margin-right:33px;">序号</label>
                <input id="xh" class="bi-width357  form-control" type="text"  placeholder=" " name="xh" value="${entity.xh}"/>
                <b class="redColor">*</b>
            </div>
        </div>

        <div class="div_border">
            <div class="div_h ">
                <label for="formName" style="margin-right:10px;">表单名称</label>
                <input id="formName" class="bi-width357 form-control" type="text" placeholder=" "
                       name="formName" value="${formName}" readonly/>
                <button type="button" id="butt" class="btn btn-success glyphicon btn-sm glyphicon-list-alt" onclick="selectForm()"
                        style="padding:2px 5px;top:-2px;"></button>
                <b class="redColor">*</b>
            </div>
        </div>

        <div class="div_border">
            <div class="div_h ">
                <label for="urlType" style="margin-right:10px;">地址类型</label>
                <input id="urlType" class="bi-width357 form-control" type="text" placeholder=" " name="urlType" value="${entity.urlType}" />
            </div>
        </div>

        <div class="div_border">
            <div class="div_h ">
                <label for="sm" style="margin-right:10px;">表单说明</label>
                <input id="sm" class="bi-width357  form-control" type="text"  placeholder=" " name="sm" value="${entity.sm}"/>
            </div>
        </div>




        <button type="button" onclick="clearall()" class="btn btn-default bi-btn-default bi-btn bi-btn-width90 " name="closed">取消</button>
        <button type="submit"  class="btn btn-primary bi-btn bi-btn-width90 ">保存</button>


    </div>
</form>
</body>
</html>