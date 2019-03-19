<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/11/4
  Time: 16:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <%@ include file="/common/meta.jsp" %>
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/new.css">
    <script type="text/javascript" src="${ctx }/static/js/FormValidation.js"></script>

    <title></title>

    <script>
        $(function(){
            formValiPost2("liucheng", "${ctx}/CustomFormFlow/save",validateForm, function (json) {
                if (json.success == false) {
                    $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                }
                else {

                    layerSuccess("成功", function () {
                        //关闭窗体
                        parent.loadFlowByFormID("${formId}");
                        closeIndexWindwos();
                    });
                }
            });

            if('${sjsbFormFlowEntity.xh}'!=null&&'${sjsbFormFlowEntity.xh}'!=''){
                $("#xh").attr("readonly","readonly");
            }

        });

        var empty="";//看是否为空
        function validateForm(){
            empty="";//看是否为空
            required("xh");   //序号
            required("name");   //名称
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
<form  id="liucheng" >

    <input type="hidden" value="${sjsbFormFlowEntity.id}" id="id" name="id"/>
    <input type="hidden" value="${formId}" id="formid" name="formid"/>

    <div class="container from-content">

        <div class="div_border">
            <div class="div_h ">
                <label for="xh" style="margin-right:10px;">序 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号</label>
                <input id="xh" class="bi-width357  form-control" type="text" placeholder=" " name="xh"  value="${sjsbFormFlowEntity.xh}"/>
                <b class="redColor">*</b>
            </div>
        </div>

        <div class="div_border">
            <div class="div_h ">
                <label for="name" style="margin-right:10px;">流程名称</label>
                <input id="name" class="bi-width357  form-control" type="text" placeholder=" "  name="name" value="${sjsbFormFlowEntity.name}" />
                <b class="redColor">*</b>
            </div>
        </div>
        <div class="div_border">

            <div class="div_h ">
                <label for="sm" style="margin-right:10px;">流程说明</label>
                <input id="sm" class="bi-width357 form-control" type="text" placeholder=" " name="sm" value="${sjsbFormFlowEntity.sm}"/>

            </div>

        </div>
        <div class="div_border">

            <div class="div_h ">
                <label for="moren" style="margin:0 10px 0 60px;">是否默认</label>
                <c:if test="${sjsbFormFlowEntity.moren=='true'}"><input id="moren"  type="checkbox"  name="moren" checked="checked"/></c:if>
                <c:if test="${sjsbFormFlowEntity.moren!='true'}"><input id="moren"  type="checkbox"  name="moren" /></c:if>

            </div>
            <div class="div_h ">
                <label for="qy" style="margin:0 10px 0 60px;">是否启用</label>
                <c:if test="${sjsbFormFlowEntity.qy=='true'}"><input id="qy"  type="checkbox"  name="qy" checked="checked"/></c:if>
                <c:if test="${sjsbFormFlowEntity.qy!='true'}"><input id="qy"  type="checkbox"  name="qy" /></c:if>



            </div>

        </div>

        <button type="button" onclick="clearall()" class="btn btn-default bi-btn-default bi-btn bi-btn-width90 " name="closed">取消</button>
        <button type="submit"  class="btn btn-primary bi-btn bi-btn-width90 ">保存</button>


    </div>
</form>
</body>
</html>
