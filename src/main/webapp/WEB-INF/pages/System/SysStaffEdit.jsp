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
        <div class="div_border ">
            <div class="div_h">
                <label >所属辖区&nbsp;&nbsp;&nbsp;</label>
                <select id="xqName" name="xqName">
                    <option value="${xqName}">${xqName}</option><option value="北京市">北京市</option><option value="上海市">上海市</option>
                    <option value="天津市">天津市</option><option value="重庆市">重庆市</option><option value="河北省">河北省</option>
                    <option value="山西省">山西省</option><option value="辽宁省">辽宁省</option><option value="吉林省">吉林省</option>
                    <option value="黑龙江省">黑龙江省</option><option value="江苏省">江苏省</option><option value="浙江省">浙江省</option>
                    <option value="安徽省">安徽省</option><option value="福建省">福建省</option><option value="江西省">江西省</option>
                    <option value="山东省">山东省</option><option value="河南省">河南省</option><option value="湖北省">湖北省</option>
                    <option value="湖南省">湖南省</option><option value="广东省">广东省</option><option value="海南省">海南省</option>
                    <option value="四川省">四川省</option><option value="贵州省">贵州省</option><option value="云南省">云南省</option>
                    <option value="陕西省">陕西省</option><option value="甘肃省">甘肃省</option><option value="青海省">青海省</option>
                    <option value="台湾省">台湾省</option><option value="内蒙古自治区">内蒙古自治区</option><option value="广西壮族自治区">广西壮族自治区</option>
                    <option value="西藏自治区">西藏自治区</option><option value="宁夏回族自治区">宁夏回族自治区</option>
                    <option value="新疆维吾尔自治区">新疆维吾尔自治区</option><option value="香港特别行政区">香港特别行政区</option>
                    <option value="澳门特别行政区">澳门特别行政区</option>
                </select>
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
