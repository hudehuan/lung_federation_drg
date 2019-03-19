<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/8/12
  Time: 10:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>雕龙数据</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <script>
        var MenuTreeData;
        var tdId = "";
        var typeId = "";
        $(function () {
            var height = findDimensions_height();
            $("#yuansu").height(height - 20);
            $("#datagrid").height(height - 200);
            loadMenu();
            LoadFormItems();
//  	b表单验证
            formValiPost("caidan", "${ctx}/formDefineField/save", function (json) {
                if (json.success == false) {
                    $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                }
                else {
                    window.parent.showDiv();
                    $('#caidan')[0].reset();
                    layerSuccess("成功",function(){
                        //关闭窗体
                        closeIndexWindwos();
                    });
                }
            });
        });
        function loadMenu() {
            $.ajaxSettings.async = false;
            $.getJSON("/formItemType/getAllFormItemType?rdm="+ parseInt(Math.random()*100000), function (data) {
                MenuTreeData = data;
            });
            $.ajaxSettings.async = true;

            $("#menu1").tree({
                method: "get",
                animate: true,
                data: MenuTreeData,

                onClick: function (node) {
                    typeId = node.id;
                    LoadFormItems(typeId);
                }
                //选中第一行
//                onLoadSuccess: function (node, data) {
//                    if ((data.length || 0) > 0 && data[0].id != "") {
//                        var node = $('#menu1').tree('find', data[0].id);
//                        $('#menu1').tree('select', node.target);
//                    }
//                }
            });
        }

        function LoadFormItems(id) {
            $('#datagrid').datagrid({
                url: '${ctx}/formItem/getAllFormItem?id=' + id+ "&rdm="+ parseInt(Math.random()*100000),
                method: 'get',
                rownumbers: true,
                singleSelect: true,
                autoRowHeight: false,
                remoteSort:false,
                columns: [
                    [
                        {field: 'typeId', title: '元素所属分类', hidden: true},
                        {field: 'itemId', title: 'ItemID', hidden: true},
                        {field: 'itemName', title: '名称', width: '200px', align: 'left', halign: 'center'},
                        {
                            field: 'isText', title: '文本', width: '30px', align: 'left', halign: 'center',
                            formatter: function (value) {
                                if (value) {
                                    var str = '<input type=\'checkbox\' checked=\'checked\' disabled=\'disabled\'/>';
                                } else {
                                    var str = '<input type=\'checkbox\' disabled=\'disabled\'/>';
                                }
                                return str;
                            }
                        },
                        {field: 'sfDesc', title: '算法', width: '250px', align: 'left', halign: 'center'}
                    ]
                ],
                onClickRow: function(index,row) {
                    $('#itemId').val(row.itemId);
                    $('#fdName').val(row.itemName);
                }
            });//.datagrid('clientPaging');
        }

        function clearall() {
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
            parent.layer.close(index); //执行关闭
        }
    </script>
</head>
<body>
<div style=" overflow: hidden; border:1px solid #ddd; border-top:none;" id="yuansu">
    <!--树形菜单-->
    <div style="width:30%;float:left;display:inline-block;padding:20px 0px 0 20px;overflow: auto;">
        <ul id="menu1" class="easyui-tree"></ul>
    </div>
    <!--表单 -->
    <div style="width:70%;float:right;display:inline-block;border-left:1px solid #ddd;">
        <div style="padding:10px;margin-left:10px;">
            <table id="datagrid" class="datagrid">

            </table>
            <form id="caidan" action="${ctx}/formDefineField/save" method="post">
                <input type="hidden" name="fdId" id="fdId">
                <input type="hidden" name="tdId" id="tdId" value="${tdId}">
                <input type="hidden" name="itemId" id="itemId">

                <div class="div_border"style="padding:10px 50px;">
                    <div class="div_h">
                        <label for="xh" style="margin-right:20px;">序号</label>
                        <input type="number" class=" form-control bi-width80" id="xh" name="xh"
                               style="margin-right:20px;" onkeydown="DigitInput(this)"/>
                    </div>
                    <div class="div_h">
                        <label for="fdName" style="margin-right:8px;">显示名称</label>
                        <input type="text" class=" form-control bi-width140 validate[required]" id="fdName" name="fdName"/>
                        <b class="redColor">*</b>
                        <%--<div class="div_h" style="margin-left:10px;">--%>
                            <%--<label for="isEdit">修改</label>--%>
                            <%--<input  type="checkbox" placeholder=" "id="isEdit" name="isEdit" />--%>
                        <%--</div>--%>
                    </div>
                </div>
                <div class="div_border" style="padding:10px 50px">
                    <div class="div_h">
                        <label for="unit" style="margin-right:20px;">单位</label>
                        <input type="text" class=" form-control bi-width80" id="unit" name="unit" style="margin-right: 20px;"/>
                    </div>
                    <div class="div_h">
                        <label for="level" style="margin-right:20px;">层次码</label>
                        <input type="text" class=" form-control bi-width140 validate[required]" id="level" name="level"/>
                        <b class="redColor">*</b>
                    </div>
                </div>
                <button type="button" class="btn btn-default bi-btn bi-btn-width90" onclick="clearall()"
                        style="margin-right:100px;margin-left: 100px;">取消
                </button>
                <button type="submit" class="btn btn-primary bi-btn bi-btn-width90">保存</button>

            </form>
        </div>
    </div>
</div>
</body>
</html>

