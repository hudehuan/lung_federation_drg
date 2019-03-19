<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/8/16
  Time: 18:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>雕龙数据</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <script type="text/javascript">
        //		点取消关闭窗口
        var flag = false;
        function clearall() {
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
            parent.layer.close(index); //执行关闭

        }
        function refreshParent() {
            GetIndexActiveIframe().refresh();
        }
        function btnclose() {
            closeIndexWindwos();
        }
        //		打开小窗口
        function openwinK() {
            layeropen(450, 300, "科室选择", "/V_SysKeShi/toSelKs");
        }
        function openwinN() {
            layeropen(450, 300, "护理工作站选择", "/V_SysKeShiWorkStation/toKsWorkStation");
        }
        function setValue(setid, values) {
            $("#" + setid).val(values);
        }

        $(function () {
            $("#userClass").find("option").eq("${staff.userClass}").attr("selected", "selected");
            $("#zhiWei option[value='${staff.zhiWei}']").attr("selected", "selected");
            $("#zhiCheng option[value='${staff.zhiCheng}']").attr("selected", "selected");
            $("#yqId option[value='${staff.yqId}']").attr("selected", "selected");
                // 自定义参数调用
                formValiPost("renyuan", "${ctx}/SysStaff/save", function (json) {

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

<body>
<div class="container from-content">
    <form id="renyuan" action="${ctx}/SysStaff/save" method="post">
        <input type="hidden" id="id" name="id" value="${staff.id}"/>
        <input type="hidden" id="ksId" name="ksId" value="${staff.ksId}"/>
        <input type="hidden" id="kswId" name="kswId" value="${staff.kswId}"/>

        <div class="div_border">
            <div class="div_h ">
                <label for="code" style="margin-right:12px;">人员代码</label>
                <input id="code" class="bi-width140 validate[required] form-control" type="text" placeholder=" "
                       name="code"
                       value="${staff.code}" onkeydown="DigitInput()"/>
                <b class="redColor">*</b>
            </div>
            <div class="div_h">
                <label for="weiyiCode">唯一码</label>
                <input type="text" placeholder=" " id="weiyiCode" name="weiyiCode" class=" bi-width140 form-control"
                       value="${staff.weiyiCode}"/>
            </div>

        </div>
        <div class="div_border">
            <div class="div_h">
                <label for="name" style="margin-right:36px;">名称</label>
                <input type="text" class="bi-width140 validate[required] form-control" placeholder=" " id="name"
                       name="name" value="${staff.name}"/>
                <b class="redColor">*</b>
            </div>
            <div class="div_h">
                <label for="userClass">&nbsp;&nbsp;类型&nbsp;</label>
                <select name="userClass" id="userClass" style="padding:2px 0px;" class="bi-width140 form-control"
                        value="${staff.userClass}">
                    <c:forEach items="${dic}" var="item" varStatus="status">
                        <option value="${item.itemCode}">${item.dicName}</option>
                    </c:forEach>
                </select>
            </div>

        </div>
        <div class="div_border">
            <div class="div_h">
                <label for="zhiCheng" style="margin-right:36px;">职称</label>
                <select name="zhiCheng" id="zhiCheng" style="padding:2px 0px;" class="bi-width140 form-control"
                        value="${staff.zhiCheng}">
                    <c:forEach items="${zhiCheng}" var="item" varStatus="status">
                        <option value="${item.itemCode}">${item.dicName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="div_h">
                <label for="zhiWei">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;职位&nbsp;</label>
                <select name="zhiWei" id="zhiWei" style="padding:2px 0px;" class="bi-width140 form-control"
                        value="${staff.zhiWei}">
                    <c:forEach items="${zhiWei}" var="item" varStatus="status">
                        <option value="${item.itemCode}">${item.dicName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="div_border ">
            <div class="div_h">
                <label for="yqId" style="margin-right:36px;">院区</label>
                <select name="yqId" id="yqId" style="padding:2px 0px;" class="bi-width140 form-control"
                        value="${staff.yqId}">
                    <c:forEach items="${hspBranch}" var="item" varStatus="status">
                        <option value="${item.id}">${item.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="div_h ">
                <label for="ksName">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;科室&nbsp;</label>
                <input type="text" class="bi-width140   form-control " id="ksName" name="ksName"
                       value="${ksName}"/>

                <button type="button" class="btn btn-success glyphicon btn-sm glyphicon-list-alt" onclick="openwinK()"
                        style="padding:2px 5px;top:-2px;"></button>
            </div>
        </div>
        <div class=" div_border">
            <div class="div_h">
                <label for="kswName">护理工作站</label>
                <input type="text" class=" form-control" name="kswName" id="kswName" value="${ksWsName}"
                       style="width:333px;border:1px solid #aaa;display:inline-block;"/>
                <button  type="button"  class="btn btn-success glyphicon btn-sm glyphicon-list-alt" onclick="openwinN()"
                        style="padding:2px 5px;top:-2px;"></button>
            </div>
        </div>
        <button type="button" onclick="clearall()" class="btn btn-default bi-btn-default bi-btn bi-btn-width90 "
                name="closed">取消
        </button>
        <button id="btnSave" type="submit" class="btn btn-primary bi-btn bi-btn-width90 ">保存</button>

    </form>

</div>
</body>
</html>
