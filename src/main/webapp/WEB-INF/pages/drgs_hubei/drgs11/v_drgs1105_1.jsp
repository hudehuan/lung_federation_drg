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
            formValiPost("formid", "${ctx}/hubei/Drgs1105/ykssSave", function (json) {
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
    <div style="display:inline-block; padding:10px 20px 10px 60px;border-left:1px solid #ddd;">
        <h4 style="display:block;padding:0; position:relative;">
            <span style="display: inline-block;float:left;margin-right:8px;height: 18px;width: 8px;background: #0066cc;"></span>
            盈亏参数配置
        </h4>

        <div style="padding:0 10px 10px 20px;margin-left:20px;">
            <form id="formid"  method="post">

                <input type="hidden" name="id" id="id" value="${entity.id}">

                <div class="div_border">
                    <div class="div_h ">
                        <label for="name" class="lab">方案名</label>
                        <input id="name" class="bi-width140 form-control" type="text" placeholder=" "value="${entity.name}"
                               name="name"  style="width:137px;" />
                    </div>
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
                        <label for="year" class="lab">年度</label>
                        <input type="text" class=" form-control bi-width140" id="year" name="year" value="${entity.year}"/>
                    </div>

                </div>
                <div class="div_border">
                    <div class="div_h">
                        <label for="address" class="lab">地区</label>
                        <input type="text" class="bi-width140  form-control" placeholder=" " id="address"value="${entity.address}"
                               name="address" />
                        <%--<b class="redColor">*</b>--%>
                    </div>

                </div>


                <div class="div_border">
                    <div class="div_h">
                        <label for="ckqz" class="lab">参考权重</label>
                        <input type="text" class="bi-width140 form-control " id="ckqz" name="ckqz" value="${entity.ckqz}">

                    </div>
                </div>
                <div class="div_border">
                    <div class="div_h">
                        <label for="yjqz" class="lab">预计权重</label>
                        <input type="text" class="bi-width140 form-control " id="yjqz" name="yjqz" value="${entity.yjqz}">
                    </div>

                </div>

                <div class="div_border">
                    <div class="div_h ">
                        <label for="fffl" class="lab">费率</label>
                        <input id="fffl" class="bi-width140 form-control" type="text" placeholder=" " name="fffl"value="${entity.fffl}"
                               style="width:140px;"/>
                    </div>

                </div>

                <button type="button" class="btn btn-default bi-btn-default bi-btn bi-btn-width90"
                        style="margin-left:110px;marrgin-top:25px;" name="closed" onclick="clearall()">取消
                </button>
                <button type="submit" class="btn btn-primary bi-btn bi-btn-width90" style="margin-top:25px;">保存</button>

            </form>
        </div>
    </div>
</div>
</div>
</body>
</html>
