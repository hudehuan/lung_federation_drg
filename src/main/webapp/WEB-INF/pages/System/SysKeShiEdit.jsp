<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/8/3
  Time: 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="en">
<head>
    <%@ include file="/common/meta.jsp" %>
    <meta charset="UTF-8">
    <title>科室管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <script type="text/javascript">
        //		点取消关闭窗口
        var MenuTreeData;
        var dm = "";

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

        $(function () {
            var height = findDimensions_height();
            $("#menu1_warp").height(height-22);
            $("#ksType option[value='${ksEntity.ksType}']").attr("selected", "selected");
            loadMenu();
            $("input:checkbox[value='true']").attr('checked', 'true');
            <%--$("#ksType").find("option").eq("${ksEntity.ksType}").attr("selected", "selected");--%>
            // 自定义参数调用
            formValiPost("keshi", "${ctx}/SysKeShi/save", function (json) {
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

        function loadMenu() {
            $.ajaxSettings.async = false;
            $.getJSON("/SysMKm/getAllKsMKm", function (data) {
                MenuTreeData = data;
            });

            $.ajaxSettings.async = true;

            $("#menu1").tree({
                method: "get",
                animate: true,
                data: MenuTreeData,

                onClick: function (node) {
                    mc = node.text;
                    $('#wbCode').val(mc);
                }
//                onLoadSuccess: function (node, data) {
//                    if ((data.length || 0) > 0 && data[0].id != "") {
//                        var node = $('#menu1').tree('find', data[0].id);
//                        $('#menu1').tree('select', node.target);
//                    }
//                }
            });
        }



    </script>

<body>

<div style="width:30%;float:left;display:inline-block;padding:5px;border:1px solid #ccc;overflow-y:auto;" id="menu1_warp">
    <ul id="menu1" class="easyui-tree"></ul>
</div>
<div style="width:70%;float:right;display:inline-block;padding-left:5px;">
    <div class="container from-content" style="padding:20px 30px 20px;">
        <form action="/SysKeShi/save" method="post" id="keshi">
            <input type="hidden" name="id" id="id" value="${ksEntity.id}"/>

            <div class="div_border">
                <div class="div_h ">
                    <label for="xh">序号</label>
                    <input id="xh" class="bi-width80 form-control" onkeydown="DigitInput()"
                           type="number" placeholder=" " name="xh" value="${ksEntity.xh}"/>
                </div>
                <div class="div_h">
                    <label for="code">&nbsp;&nbsp;&nbsp;科室代码</label>
                    <input type="text" placeholder=" " onkeydown="DigitInput()" style="width: 95px;"
                           id="code" name="code" class="validate[required] bi-width80 form-control"
                           value="${ksEntity.code}"/>
                    <b class="redColor">*</b>
                </div>

            </div>
            <div class="div_border">
                <div class="div_h ">
                    <label for="name">名称</label>
                    <input type="text" class="bi-width80 validate[required] form-control" placeholder=" " name="name"
                            id="name" value="${ksEntity.name}" />
                    <b class="redColor">*</b>
                </div>
                <div class="div_h">
                    <label for="shortName">&nbsp;&nbsp;&nbsp;简称&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="text" class="bi-width80 form-control" id="shortName" name="shortName"
                          value="${ksEntity.shortName}" style="width: 95px"/>
                </div>
            </div>
            <div class="div_border">
                <div class="div_h">
                    <label for="ksType">类型</label>
                    <select name="ksType" id="ksType" style="padding:2px 0px;width: 80px" class="bi-width80 form-control">
                        <c:forEach items="${typeEnums}" var="type" varStatus="status">
                            <option value="${type.itemCode}">${type.dicName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="div_h">
                    <label for="wbCode">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;科目&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="text" class="bi-width80 form-control" style="width: 95px"
                           id="wbCode" name="wbCode" value="${ksEntity.wbCode}" readonly="readonly">

                </div>
            </div>
            <div class="div_border">
                <div class="div_h ">
                    <label for="bedNums">床位数</label>
                    <input type="text" class="bi-width80  form-control" placeholder=" " name="bedNums"
                           id="bedNums" value="${ksEntity.bedNums}" style="width: 40px" onkeydown="DigitInput(this)"/>

                </div>

                <div class="div_h">
                    <label for="extrabedNums">加床数</label>
                    <input type="text" class="bi-width80 form-control" id="extrabedNums" name="extrabedNums"
                           value="${ksEntity.extrabedNums}" style="width: 40px" onkeydown="DigitInput(this)"/>
                </div>
                <div class="div_h">
                    <label for="fixedbedNums">编制床位</label>
                    <input type="text" class="bi-width80 form-control" id="fixedbedNums" name="fixedbedNums"
                           value="${ksEntity.fixedbedNums}" style="width: 40px" onkeydown="DigitInput(this)"/>
                </div>
            </div>
            <div class="radios div_border">
                <input type="checkbox" id = "zy" name="zy" style="margin-left:50px;" value="${ksEntity.zy}" />&nbsp;住院
                <input type="checkbox" id = "mz" name="mz" style="margin-left:20px;" value="${ksEntity.mz}"  />&nbsp;门诊
                <input type="checkbox" id = "jz" name="jz" style="margin-left:20px;" value="${ksEntity.jz}"  />&nbsp;急诊
            </div>
            <button type="button" onclick="clearall()" class="btn btn-default  bi-btn bi-btn-width90"
                    name="closed" style="margin-left:35px;margin-right:95px;">取消
            </button>
            <button type="submit" class="btn btn-primary bi-btn bi-btn-width90" id="submit">保存</button>

        </form>

    </div>
</div>

</body>
</html>