<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/7/21
  Time: 13:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp"%>
    <title>${titlename}</title>


    <script type="text/javascript">

        $( function() {
            $('#tbl_Discuss').datagrid({
                url:'/SysDiscuss/getAllDiscuss',
                title: '交流讨论表管理',
                iconCls: 'icon-add',
                width: 'auto',
                height: 'auto',
                fit: true,
                nowrap: false,
                striped: true,
                border: true,
                collapsible: false,
                idField: 'disId',
                singleSelect: true,
                pagination: true,
                rownumbers: true,
                columns:[[
                    {field:'disId',title:'DisId',width:'100px',hidden:true},
                    {field:'disTime',title:'发表时间',width:'100px'},
                    {field:'publisher',title:'发表者人员ID',width:'100px'},
                    {field:'title',title:'发表标题',width:'200px'},
                    {field:'discontent',title:'发表内容',width:'100px'},
                    {field:'sysCode',title:'系统代码',width:'100px'},
                    {field:'type',title:'类型',width:'200px'},
                    {field:'status',title:'状态',width:'100px'},
                    {field:'huifuTime',title:'最后回复时间',width:'100px'},
                    {field: 'opt', title: '操作', width: '100px', align: 'center',
                        formatter: function (value, rec, index) {
                            var c = '<a href="#" mce_href="#" onclick="gotoUpdate(\'' + rec.disId + '\')">编辑</a> ';
                            var d = '<a href="#" mce_href="#" onclick="gotoDel(\'' + rec.disId + '\')">删除</a> ';
                            return c + "　" + d;
                        }
                    }
                ]] ,
                toolbar: '#dlgToolbar'
            });
            $('#saveform').form({
                onSubmit: function(){
//                    var v = $(this).form('validate');
//                    if(v){
//                        $("#doSubmit").unbind('click');
//                    }
                    return true;
                },
                success:function(data){
                    data = eval('(' + data + ')');
                    if(data.success == true){
                        //document.location.href="${ctx }/user/index";
                        $('#dlg').dialog('close');
                        doSearch();
                    }else {
                        alert(data.msg);
                    }
                    $("#doSubmit").bind("click",function(){
                        $('#saveform').submit();
                    });
                }
            });

            $("#doSubmit").click(function() {
                $('#saveform').submit();
                return false;
            });
        });

        function gotoAdd(){
            var url = '${ctx}/V_SysDiscuss/toEdit';
            window.location.href=url;
        }
        <%--function gotoAdd(){--%>
            <%--$('#dlg').dialog({--%>
                <%--onOpen:function(){--%>
                    <%--$('#disId').val("");--%>
                <%--}--%>
            <%--});--%>
            <%--$('#dlg').dialog('open');--%>
            <%--//var url = '${ctx }/V_SysKeShi/toEdit';--%>
            <%--//window.location.href=url;--%>

        <%--}--%>

        function gotoDel(id){
            $.messager.confirm('确认','您确认想要删除记录吗？',function(r){
                if (!r){
                    return;
                }
                var url = '${ctx}/SysDiscuss/delete?id='+id;
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

        function gotoUpdate(id){
            //url = '{ctx}/users/update?id='+id;
            //window.location.href=url;
            url= '${ctx}/V_SysDiscuss/toEdit?id='+id;
            window.location.href=url;
//            $('#dlg').dialog({
//                onOpen:function(){
//                    $('#disId').val(id);
//                }
//            });
//            $('#dlg').dialog('open');
        }


        function doSearch(){
            $('#tbl_Discuss').datagrid('reload'); // 重新载入当前页面数据
        }

    </script>


</head>
<body>



<table id="tbl_Discuss">

</table>

<div id="dlgToolbar" style="height: 28px;">

    <div style="float: left">
        <a href="/SysDiscuss/getAllDiscuss" id="A1" data-options="iconCls: 'icon-search',plain:true" onclick=""
           class="easyui-linkbutton">查询</a>
    </div>
    <div id="separator1" class="datagrid-btn-separator">
    </div>
    <div style="float: left">
        <a href="#" id="btnAdd" data-options="iconCls: 'icon-add',plain:true" onclick="gotoAdd();"
           class="easyui-linkbutton">添加</a>
    </div>


</div>

<div id="dlg" class="easyui-dialog" title="交流讨论表" style="width:400px;height:600px;padding:10px"
     closed="true" data-options="iconCls:'icon-save', buttons:'#bb'">

    <form action="${ctx}/SysDiscuss/save" method="post" id="saveform" >

        <div style="margin-bottom:20px">
            <input type="hidden" class="easyui-textbox" style="width:100%;height:32px" name ="disId" id ="disId">
        </div>
        <%--<div style="margin-bottom:20px">--%>
            <%--<div>发表时间:</div>--%>
            <%--<input type="text" class="easyui-textbox" style="width:100%;height:32px" name ="disTime" id ="disTime">--%>
        <%--</div>--%>
        <%--<div style="margin-bottom:20px">--%>
            <%--<div>发表者人员ID:</div>--%>
            <%--&lt;%&ndash;<input type="text" class="easyui-textbox" style="width:100%;height:32px" name ="publisher" id ="publisher">&ndash;%&gt;--%>
        <%--</div>--%>

        <div style="margin-bottom:20px">
            <div>发表标题:</div>
            <input class="easyui-textbox" style="width:100%;height:32px" name ="title" id="title">
        </div>
        <%--<div style="margin-bottom:20px">--%>
            <%--<div>发表内容:</div>--%>
            <%--<input class="easyui-textbox" style="width:100%;height:32px" name ="discontent" id="discontent">--%>
        <%--</div>--%>
        <%--<div style="margin-bottom:20px">--%>
            <%--<div>系统代码:</div>--%>
            <%--<input class="easyui-textbox" style="width:100%;height:32px" name ="sysCode" id="sysCode">--%>
        <%--</div>--%>
        <%--<div style="margin-bottom:20px">--%>
            <%--<div>类型:</div>--%>
            <%--<input class="easyui-textbox" style="width:100%;height:32px" name ="type" id="type">--%>
        <%--</div>--%>
        <%--<div style="margin-bottom:20px">--%>
            <%--<div>状态:</div>--%>
            <%--<input class="easyui-numberbox" style="width:100%;height:32px" name ="status" id="status">--%>
        <%--</div>--%>
        <%--<div style="margin-bottom:20px">--%>
            <%--<div>最后回复时间:</div>--%>
            <%--<input class="easyui-textbox" style="width:100%;height:32px" name="huifuTime"  id="huifuTime">--%>
        <%--</div>--%>

    </form>

</div>

<div id="bb">
    <a href="#" class="easyui-linkbutton"  id="doSubmit">Save</a>
    <a href="#" class="easyui-linkbutton" onclick="$('#dlg').dialog('close')">Close</a>
</div>


</body>
</html>
