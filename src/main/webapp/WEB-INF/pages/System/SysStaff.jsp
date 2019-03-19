<%@ page import="java.util.UUID" %>
<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/7/21
  Time: 13:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>

    <%@ include file="/common/meta.jsp"%>
    <title>${titlename}</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <script>

        $(function(){
            var height = findDimensions_height();
            $("#gridtable").height(height-50);
//            loadList();
           // refresh();
            $('#gridtable').datagrid(
                    {
                        url:' /SysStaff/getAllStaff?rdm='+ parseInt(Math.random()*100000),
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        autoRowHeight:false,
                        pagination:true,
                        clientPaging:true,
                        idField: 'id',
                        remoteSort:false,
                        pageSize:15,
                        pageList:[10,15,20,25,30,40,50],
                        columns: [
                            [
                                { field:'id',title:'用户ID',width:'100px',hidden:true},
                                { field: 'code', title: '人员代码', width: '80px', align: 'left',sortable:true,  halign: 'center'},
                                { field: 'name', title: '名称', width: '100px', align: 'left',sortable:true, halign: 'center'},
                                { field: 'userClass', title: '类型', width: '60px', align: 'left',sortable:true,  halign: 'center'},
                                { field: 'weiyiCode', title: '唯一码', width:'100px', align: 'left',sortable:true, halign: 'center'},
                                { field: 'zhiCheng', title: '职称', width: '100px', align: 'left',sortable:true,  halign: 'center'},
                                { field: 'zhiWei', title: '职位', width: '120px', align: 'left',sortable:true,  halign: 'center'},
                                { field: 'yqName', title: '院区', width: '100px', align: 'left',sortable:true,  halign: 'center'},
                                { field: 'ksName', title: '科室', width: '100px', align: 'left',sortable:true,  halign: 'center'},
                                { field: 'kswName', title: '护理工作站', width: '120px', align: 'left',sortable:true,  halign: 'center'},
                                { field: 'operate', title: '操作', width: '75px', align: 'left', halign: 'center',
                                    formatter:function(value,row,index){
                                        var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\' onclick="edit(\'' + row.id + '\')"><span class=\'glyphicon  glyphicon glyphicon-pencil\'></span></button>';
                                        str+= '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="del(\'' + row.id + '\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></button>';
                                        return str;
                                    }
                                }
                            ]
                        ]
                    }).datagrid('clientPaging');
        });
        function openwin(){
            if(!${roleMenu.isAdd}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }
            layeropen(630,402,"数据编辑","${ctx}/V_SysStaff/toEdit");
        }
        function refresh(){
            $('#gridtable').datagrid(
                {
                    url:' /SysStaff/getAllStaff?rdm='+ parseInt(Math.random()*100000)
                });

          //  loadList();
        }

        function edit(id) {
            if(!${roleMenu.isEdit}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }
            layeropen(630, 402, "数据编辑", "${ctx}/V_SysStaff/toEdit?id="+id);
        }

        function search() {
            var condition = $('#serach').val();
            var url = '${ctx }/SysStaff/findByCondition?condition='+encodeURI(condition)+ "&rdm="+ parseInt(Math.random()*100000);
            //win=url;dow.location.href
            $('#gridtable').datagrid({url:url});
        }

        function del(id) {
            if(!${roleMenu.isDel}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }
            layerConfirm("是否确定删除?", function () {
                var url = '${ctx}/SysStaff/delete?id=' + id;
                $.ajax({
                    type: 'post',
                    url: url,
                    dataType: "json",
                    success: function (data) {
                        if (data.success == true) {
                            refresh();
                        } else {
                            alert(data.msg);
                        }
                    }
                });
            });
        }
        function loadList(){
            $('#gridtable').datagrid(
                    {
                        url:' /SysStaff/getAllStaff?rdm='+ parseInt(Math.random()*100000)
                    });
        }

    </script>
</head>
<body>
<div class="navheader form-inline" style="padding:0 5px; height:40px;">
    <div class=" form-group">
        <label for="serach"style="padding:5px 10px 0px 20px;">查询</label>
        <input type="text" id="serach" class="form-control"placeholder="名称、拼音码、代码查询" />
        <button type="button" class="btn btn-success bi-btn-search" onclick="search()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>
    <div class="btn-group-right">
        <div class="btn-group "  role="group">
            <button type="button" class="btn btn-default bi-btn-width90" onclick="refresh()">刷新</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="openwin()">新增</button>
        </div>
    </div>
</div>


<div style="padding:0  5px;">
    <table id="gridtable"  style="width:100%;" >
    </table>
</div>


</body>
</html>