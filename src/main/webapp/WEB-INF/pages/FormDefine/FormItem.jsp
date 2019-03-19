<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/8/12
  Time: 9:58
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
        var selectindex = 0;
        var MenuTreeData;
        var typeId = "";
        var level = "";
        var firstLevel = "";
        var secondLevel = "${secondLevel}";
        $(function () {
            var height = findDimensions_height();
            $("#menu1").height(height - 50);
            loadMenu();
            $("#datagrid").height(height - 50);
//            LoadFormItems("");
            $('#datagrid').datagrid({
                url: '',
                method: 'get',
                rownumbers: true,
                singleSelect: true,
                autoRowHeight: false,
                remoteSort: false,
                columns: [
                    [
                        {field: 'typeId', title: '元素所属分类', hidden: true},
                        {field: 'itemId', title: 'ItemID', hidden: true},
                        {field: 'xh', title: '序号', width: '40px', align: 'left', halign: 'center'},
                        {field: 'itemName', title:firstLevel +'&nbsp;&nbsp;'+ secondLevel + '&nbsp;&nbsp;&nbsp;&nbsp;元素名称',
                            width: '500px', align: 'left', halign: 'center'},
                        {field: 'sfDesc', title: '算法', width: '200px', align: 'left', halign: 'center'},
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
                        {
                            field: 'operate', title: '操作', width: '80px', align: 'left', halign: 'center',
                            formatter: function (value, row, index) {
                                var str = '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\' onclick="UpdateItem(\'' + row.itemId + '\')"><span class=\'glyphicon  glyphicon glyphicon-pencil\'></span></button>';
                                str += '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="DelItem(\'' + row.itemId + '\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></button>';
                                return str;
                            }
                        }
                    ]
                ],
                onLoadSuccess: function() {
                    firstLevel = "";
                    secondLevel = "";
                }
            });
        })
        function openwinX() {
            if(!${roleMenu.isAdd}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }
            layeropen(600, 280, "新增一级", "${ctx}/formItemType/toEdit?pid=");
        }

        function openwinT() {

            if(!${roleMenu.isAdd}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }


            if (typeId == "") {
                layerInfo("请选择分类！");
                return;
            }
            if (level.length != 3) {
                layerInfo("请选择一级分类！")
                return;
            }
            layeropen(600, 280, "新增二级", "${ctx}/formItemType/toEdit?pid=" + typeId);
        }
        function openwinB() {

            if(!${roleMenu.isAdd}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }


            if (typeId == "") {
                layerInfo("请选择要编辑的分类！");
                return;
            }
            layeropen(600, 280, "编辑分类", "${ctx}/formItemType/toEdit?id=" + typeId);
        }
        function openwinC() {
            if(!${roleMenu.isAdd}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }

            if (typeId == "") {
                layerInfo("请选择分类！");
                return;
            }
            if (level.length == 3) {
                layerInfo("请选择二级分类！");
                return;
            }
            layeropen(600, 450, "新增元素", "${ctx}/formItem/toEdit?typeId=" + typeId);
        }

        function refresh() {
            $('#datagrid').datagrid({
                url: '${ctx}/formItem/getAllFormItem?id=' + typeId+ "&rdm="+ parseInt(Math.random()*100000)
            });
//            $('#datagrid').datagrid('reload');

        }
        function UpdateItem(id) {
            if(!${roleMenu.isEdit}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }

            var url = '${ctx}/formItem/toEdit?id=' + id;
            layeropen(600, 450, "修改元素", url);
        }
        //删除行
        function DelItem(id) {
            if(!${roleMenu.isDel}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }

            layerConfirm("是否确定删除?", function () {
                var url = '${ctx}/formItem/delete?id=' + id;
                $.ajax({
                    type: 'post',
                    url: url,
                    dataType: "json",
                    success: function (data) {
                        if (data.success == true) {
                            LoadFormItems(typeId);
                        } else {
                            alert(data.msg);
                        }
                    }
                });
            });

        }
        function deleteR() {

            if(!${roleMenu.isDel}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }

            if (typeId == "") {
                layerInfo("请选择分类！");
                return;
            }
            $.ajax({
                type: 'post',
                url: '${ctx}/formItemType/search?id=' + typeId+ "&rdm="+ parseInt(Math.random()*100000),
                dataType: "json",
                success: function (data) {
                    if (data.success == true) {
                        layerConfirm("是否确定删除?", function () {
                            var url = '${ctx}/formItemType/delete?id=' + typeId;
                            $.ajax({
                                type: 'post',
                                url: url,
                                dataType: "json",
                                success: function (data) {
                                    if (data.success == true) {
                                        loadMenu();
                                    } else {
                                        alert(data.msg);
                                    }
                                }
                            });
                        });
                    } else {
                        layerInfo(data.msg);
                        return;
                    }
                }
            });
        }

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
                    level = node.attribute.level;
                    secondLevel = node.text;
                    var firstNode = $('#menu1').tree('getParent',node.target);
                    if (firstNode != null) {
                        firstLevel = firstNode.text;
                    }
                    LoadFormItems(typeId);
                }
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
                url: '${ctx}/formItem/getAllFormItem?id=' + id+ "&rdm="+ parseInt(Math.random()*100000)
            });
        }
    </script>
</head>
<body>

<div class="navheader form-inline" style="padding:0 5px;height:40px;">

    <div class="btn-group-right">
        <div class="btn-group " role="group">

            <button type="button" class="btn btn-default bi-btn-width90" onclick="openwinX()">新增一级</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="openwinT()">新增二级</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="openwinB()">编辑分类</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="deleteR()">删除分类</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="openwinC()">新增元素</button>
        </div>
    </div>
</div>
</div>

<div style="margin:0 5px; overflow: hidden; " id="caidan">
    <!--树形菜单-->
    <div style="width:30%;float:left;display:inline-block;padding-right:5px;border:1px solid #ccc;">
        <ul id="menu1" class="easyui-tree"></ul>
    </div>
    <!--表格-->
    <div style="width:70%;float:right;display:inline-block;padding-left:5px;">
        <table id="datagrid" class="datagrid"></table>
    </div>
</div>
</body>
</html>
