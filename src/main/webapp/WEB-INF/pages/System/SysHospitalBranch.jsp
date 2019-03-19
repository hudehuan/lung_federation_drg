<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/7/21
  Time: 13:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>${titlename}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <script>

        $(function () {
            var height = findDimensions_height();
            $(".gridtable").height(height - 50);
//            loadList();
            $('#gridtable').datagrid(
                    {
                        url: '/SysHospitalBranch/getAllHospitalBranch?rdm=' + parseInt(Math.random()*100000),
                        method: 'get',
                        rownumbers: true,
                        singleSelect: true,
                        autoRowHeight: false,
                        pagination: true,
                        idField: 'id',
                        pageSize: 15,
                        pageList: [15, 20, 25, 30, 40, 50],
                        clientPaging: true,
                        remoteSort:false,
                        columns: [
                            [
                                {field: 'id', title: '分院ID', width: '100px', hidden: true},
                                {field: 'xh', title: '序号', width: '40px', align: 'left', halign: 'center'},
                                {field: 'code', title: '院区代码', width: '80px', align: 'left', halign: 'center'},
                                {field: 'name', title: '名称', width: '180px', align: 'left', halign: 'center'},
                                {field: 'address', title: '地址', width: '220px', align: 'left', halign: 'center'},
                                {
                                    field: 'operate', title: '操作', width: '75px', align: 'left', halign: 'center',
                                    formatter: function (value, row, index) {

                                        var str = '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\' onclick="edit(\'' + row.id + '\')"><span class=\'glyphicon  glyphicon glyphicon-pencil\'></span></button>';
                                        str += '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="del(\'' + row.id + '\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></button>';
                                        return str;
                                    }
                                }

                            ]
                        ]
                    }).datagrid('clientPaging');
        });
        function openwin() {
            if(${roleMenu.isAdd}){
                layeropen(600, 300, "数据编辑", "${ctx}/V_SysHospitalBranch/toEdit");
            }
            else{
                layerInfo("没有权限!请找系统管理员申请权限!");
            }
        }

        function refresh() {
//            $('#gridtable').datagrid('reload');
            loadList();
        }
        function edit(id) {

            if(${roleMenu.isEdit}){
                layeropen(600, 300, "数据编辑", "${ctx}/V_SysHospitalBranch/toEdit?id=" + id);
            }
            else{
                layerInfo("没有权限!请找系统管理员申请权限!");
            }
        }
        function del(id) {
            if(${roleMenu.isDel}){
                layerConfirm("是否确定删除?",function () {
                    var url = '${ctx}/SysHospitalBranch/delete?id=' + id;
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
            else{
                layerInfo("没有权限!请找系统管理员申请权限!");
            }
        }
        function loadList() {
            $('#gridtable').datagrid(
                    {
                        url: '/SysHospitalBranch/getAllHospitalBranch?rdm=' + parseInt(Math.random()*100000)
                    });
        }
    </script>

</head>
<body>
<div class="navheader" style="height:40px;">
    <input type="hidden" id="msg" value="${msg}"/>

    <div class="btn-group-right">
        <div class="btn-group " role="group">
            <button type="button" class="btn btn-default bi-btn-width90" onclick="refresh()">刷新</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="openwin()">新增</button>

        </div>
    </div>
</div>
<div style="padding:0 5px;">
    <table id="gridtable" class="gridtable" style="width:100%;">
    </table>
</div>

</body>
</html>

