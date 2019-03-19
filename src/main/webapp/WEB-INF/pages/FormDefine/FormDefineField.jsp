<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/8/12
  Time: 10:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp"%>
    <title></title>
    <script type="application/javascript">
        $(function(){
            $('#tbl_list').datagrid({
                url:'/formDefineField/getAllFormDefineField?tdId=${tdId}',
                title: '键值表单字段配置表',
                iconCls: 'icon-add',
                width: 'auto',
                height: 'auto',
                fit: true,
                nowrap: false,
                striped: true,
                border: true,
                collapsible: false,
                idField: 'fdId',
                singleSelect: true,
                //ctrlSelect:true,
                pagination: true,
                rownumbers: true,
                remoteSort:false,
                columns:[[
                    {field:'fdId',title:'ID',width:'100px',hidden:true},
                    {field:'tdId',title:'表单ID',width:'100px'},
                    {field:'fdName',title:'字段名称',width:'100px'},
                    {field:'xh',title:'序号',width:'100px'},
                    {field:'isEdit',title:'修改状态不可修改',width:'150px'},
                    {field:'defaultValue',title:'默认值',width:'100px'},
                    {field:'xsmb',title:'显示模板',width:'100px'},
                    {field:'itemId',title:'元素ID',width:'300px'},
                    {field:'status',title:'状态',width:'100px'},
                    {field: 'opt', title: '操作', width: '220px', align: 'center',
                        formatter: function (value, rec, index) {
                            var c = '<a href="#" mce_href="#" onclick="toUpdate(\'' + rec.fdId + '\')">编辑</a> ';
                            var d = '<a href="#" mce_href="#" onclick="toDel(\'' + rec.fdId + '\')">删除</a> ';
                            return c + "　" + d;
                        }
                    }
                ]] ,
                toolbar: '#dlgToolbar'
            });
        });
        function toUpdate(id){
            var url = '${ctx}/formDefineField/toUpdate?id='+id;
            window.location.href=url;
        }
        function Add() {
            var url = '${ctx}/formDefineField/toSave?tdId=${tdId}';
            window.location.href=url;
        }
        function toDel(id){
            $.messager.confirm('确认','您确认想要删除记录吗？',function(r){
                if (!r){
                    return;
                }
                var url = '${ctx}/formDefineField/delete?id='+id;
                $.ajax({
                    type : 'post',
                    url : url,
                    dataType: "json",
                    success:function(data){
                        if(data.success == true){
                            doSearch();
                        }else{
                            alert(data.msg);
                        }
                    }
                });
            });
        }
        function doSearch(){
            $('#tbl_list').datagrid('reload'); // 重新载入当前页面数据
        }
    </script>
</head>
<body>

<table class="easyui-datagrid" id="tbl_list"  data-options=" toolbar: '#dlgToolbar'">
</table>



<div id="dlgToolbar" style="height: 28px;">

    <div style="float: left">
        <a href="#" id="btnaddType" data-options="iconCls: 'icon-search',plain:true" onclick="Add();"
           class="easyui-linkbutton">添加</a>
    </div>
</div>
</body>
</html>
