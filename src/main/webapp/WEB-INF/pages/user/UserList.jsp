<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/common/meta.jsp"%>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>用户列表</title>

    <script type="text/javascript">

        $( function() {
            $('#tbl_User').datagrid({
                url:'/users/getall',
                title: '用户列表',
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
                    {field:'id',title:'用户ID',width:100},
                    {field:'name',title:'姓名',width:100},
                    {field:'age',title:'年龄',width:100,align:'right'},
                    {field:'addree',title:'住址',width:200},
                    {field: 'opt', title: '操作', width: 80, align: 'center',
                        formatter: function (value, rec, index) {
                            var c = '<a href="#" mce_href="#" onclick="gotoUpdate(\'' + rec.id + '\')">编辑</a> ';
                            var d = '<a href="#" mce_href="#" onclick="gotoDel(\'' + rec.id + '\')">删除</a> ';
                            return c + "　" + d;
                        }
                    }
                ]] ,
                toolbar: '#dlgToolbar'
            });
        });

        function gotoAdd(){
            var url = '${ctx }/users/gotoAdd';
            window.location.href=url;
        }

        function gotoDel(id){
            $.messager.confirm('确认','您确认想要删除记录吗？',function(r){
                if (!r){
                    return;
                }
            });
            var url = '${ctx}/users/delete?id='+id;
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

        }

        function gotoUpdate(id){
            var url = '{ctx}/users/update?id='+id;
            window.location.href=url;
        }


        function doSearch(){
            $('#tbl_User').datagrid('reload'); // 重新载入当前页面数据
        }



    </script>


</head>
<body>

<table id="tbl_User">
</table>

<div id="dlgToolbar" style="height: 28px;">

    <div style="float: left">
        <a href="#" id="A1" data-options="iconCls: 'icon-search',plain:true" onclick=""
           class="easyui-linkbutton">查询</a>
    </div>
    <div id="separator1" class="datagrid-btn-separator">
    </div>
    <div style="float: left">
        <a href="#" id="btnAdd" data-options="iconCls: 'icon-add',plain:true" onclick="gotoAdd();"
           class="easyui-linkbutton">添加</a>
    </div>


</div>

</body>
</html>
