<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/11/25
  Time: 17:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/blsj.css?v=1">
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/danbingzhong.css?v=1">
    <script type="text/javascript" src="${ctx }/static/js/stickUp.min.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/sjsbcommon.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/FormValidation.js"></script>
    <title>流程选择</title>
    <script>
        <%--$(function(){--%>
            <%--formValiPost("flow", "${ctx}/sjsbFormFlow/saveCheckList", function (json) {--%>
                <%--if (json.success == false) {--%>
                    <%--$(json.id).validationEngine('showPrompt', json.msg, 'error', true);--%>
                <%--}--%>
                <%--else {--%>
                   <%--// layer.msg("流程保存成功");--%>
                   <%--parent.layerSuccess("成功", function () {--%>
                        <%--//关闭窗体--%>
                        <%--parent.loadCheckList();--%>
                        <%--closeIndexWindwos();--%>
                   <%--});--%>
                <%--}--%>
            <%--});--%>

        <%--})--%>
        function add(){

           // alert($("input:radio[name='shlc']:checked").val());
         //   return;

            if ($("input:radio[name='shlc']:checked").val()==undefined){
                alert("请选择一个相应的审核流程!");
                return;
            }
//
          parent.addShlc($("input:radio[name='shlc']:checked").val());
           closeIndexWindwos();
        }


        function clearall() {
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
            parent.layer.close(index); //执行关闭
        }

    </script>

</head>
<body style="padding: 5px;">

    <form >
        <input type="hidden" id="dataId" name="dataId" value="${dataId}"/>

        <div style=" margin-left: 50px;  margin-top: 20px;vertical-align:middle;" >

                <%--<select name="shlc" id="shlc" class="form-control" style="width:140px;display:inline-block;">--%>
                    <c:forEach items="${flows}" var="flow" varStatus="status">
                     <span style="width: 45%; display: inline-block ;line-height: 28px">
                       <input type="radio" name="shlc" id="${flow.id}" value="${flow.id}"/> <label for="${flow.id}">${flow.name}</label>
                     </span>
                        <%--<option value="${flow.id}">${flow.name}</option>--%>
                    </c:forEach>
                <%--</select>--%>

        </div>


        <br/>
            <div style="border-top: double 1px #f0ad4e" >
                <button type="button" onclick="clearall()" class="btn btn-default bi-btn bi-btn-width90 "
                        style="margin-left:130px;margin-right:70px;" name="closed">取消</button>
                <button type="button" onclick="add()" class="btn btn-primary bi-btn bi-btn-width90 ">保存</button>
            </div>

    </form>

</body>
</html>
