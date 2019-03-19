<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/08/25
  Time: 10:19
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <%@ include file="/common/meta.jsp" %>
    <title>${titlename}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <script>
        $(function () {
            if('${entity.status}'){
                $("input:radio[name='status'][value='${entity.status}']").attr('checked', 'true');
            }else{
                $("input:radio[name='status'][value='false']").attr('checked', 'true');
            }

            formValiPost("formid", "${ctx}/hubei/Drgs1105/gsSave", function (json) {
                if (json.success == false) {
                    if(json.id){
                        $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                    }else {
                        layerInfo(json.msg);
                    }

                }
                else {
                    parent.refresh();
                    layerSuccess("保存成功", function () {
                        //关闭窗体
                        closeIndexWindwos();
                    });

                }

            });

        })


        function clearall() {
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
            parent.layer.close(index); //执行关闭
        }
    </script>

    <style>
        .lab{
            width:80px;
        }

    </style>


</head>
<body style="height: 98%">
<div class="navheader form-inline" style="padding:0 5px;height:40px;">
    <div style="margin:0 5px; overflow: hidden; border:1px solid #ddd;" id="menu1_warp">

        <!--表单 -->
        <div style="display:inline-block; padding:10px 20px 10px 0px;border-left:1px solid #ddd;">


            <div style="padding:0 10px 10px 20px;margin-left:20px;">
                <form id="formid"  method="post">

                    <input type="hidden" name="id" id="id" value="${entity.id}">
                    <input type="hidden" name="ykid" id="ykid" value="${ykid}">

                    <div class="div_border">
                        <div class="div_h ">
                            <label for="stauts1" class="lab">状态</label>
                            <input id="stauts1" type="radio" placeholder=" " value="true"
                                   name="status"  /><label for="stauts1">启用</label>
                            <input id="stauts2" type="radio" placeholder=" " value="false"
                                   name="status"  /><label for="stauts2">停用</label>
                        </div>
                    </div>
                    <div class="div_border">
                        <div class="div_h">
                            <label for="gs" class="lab">公式</label>
                            <%--<input type="text" class=" form-control bi-width140" id="gs" name="gs" value="${entity.gs}"/>--%>
                            <textarea id="gs" class="bi-width357  form-control"
                                      placeholder=" " name="gs" style="width:254px;height:60px;">${entity.gs}</textarea>
                        </div>

                    </div>


                    <button type="button" class="btn btn-default bi-btn-default bi-btn bi-btn-width90"
                            style="margin-left:110px;margin-top:25px;margin-right:20px;" name="closed" onclick="clearall()">取消
                    </button>
                    <button type="submit" class="btn btn-primary bi-btn bi-btn-width90" style="margin-top:25px;">保存</button>

                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
