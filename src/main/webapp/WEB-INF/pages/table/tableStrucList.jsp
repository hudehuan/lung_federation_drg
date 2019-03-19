<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/8/3
  Time: 13:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp"%>
    <title>元数据表结构定义</title>


    <script>

        $(function(){

            $('#tbl_struclist').datagrid({
                url:'${ctx }/tabstruc/list?tableid=${tableid}',
                title: '元数据表结构定义',
                iconCls: 'icon-add',
                width: 'auto',
                height: 'auto',
                fit: true,
                nowrap: false,
                striped: true,
                border: true,
                collapsible: false,
                idField: 'id',
                singleSelect: true,
                pagination: true,
                rownumbers: true,
                columns:[[
                    {field:'id',title:'ID',width:'200px',hidden:true},
                    {field:'name',title:'字段名',width:'200px'},
                    {field:'zhName',title:'字段中文名',width:'260px'},
                    {field:'type',title:'字段类型',width:'100px'},
                    {field:'colLength',title:'字段长度',width:'100px'},
                    {field:'isKey',title:'关键字',width:'100px'},
                    {field:'pym',title:'拼音码',width:'100px'},
                    {field:'xh',title:'序号',width:'100px'},
                    {field:'status',title:'状态',width:'100px'},
                    {field:'bz',title:'备注',width:'300px'},
                    {field: 'opt', title: '操作', width: '100px', align: 'center',
                        formatter: function (value, rec, index) {
                            var c = '<a href="#" mce_href="#" onclick="toUpdate(\'' + rec.id + '\')">编辑</a> ';
                            var d = '<a href="#" mce_href="#" onclick="toDel(\'' + rec.id + '\')">删除</a> ';
                            return c + "　" + d;
                        }
                    }
                ]] ,
                toolbar: '#dlgToolbar'

            });
        });

        function toAdd(){
            var url = '${ctx}/tabstruc/toadd?tableid=${tableid}';
            window.location.href=url;
        }

        function toUpdate(id){
            var url = '${ctx}/tabstruc/toedit?tableid=${tableid}&id='+id;
            window.location.href=url;
        }

        function toDel(id){

        }




    </script>

</head>
<body>


<table id="tbl_struclist">
</table>

<div id="dlgToolbar" style="height: 28px;">

    <div style="float: left">
        <a href="#" id="A1" data-options="iconCls: 'icon-search',plain:true" onclick=""
           class="easyui-linkbutton">查询</a>
    </div>
    <div id="separator1" class="datagrid-btn-separator">
    </div>
    <div style="float: left">
        <a href="#" id="btnAdd" data-options="iconCls: 'icon-add',plain:true" onclick="toAdd();"
           class="easyui-linkbutton">添加</a>
    </div>


</div>
</body>
</html>
