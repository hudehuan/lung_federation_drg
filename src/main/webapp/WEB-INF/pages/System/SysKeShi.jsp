<%@ page import="java.net.URLEncoder" %>
<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/7/21
  Time: 13:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<html lang="en">
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>${titlename}</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <script>

        $(function () {
            var height = findDimensions_height();
            $("#gridtable").height(height - 50);
//            loadList();
            $('#gridtable').datagrid(
                    {
                        url: '/SysKeShi/getAllKeShi?rdm=' + parseInt(Math.random()*100000),
                        method: 'get',
                        rownumbers: true,
                        singleSelect: true,
                        autoRowHeight: false,
                        pagination: true,
                        clientPaging: true,
                        idField: 'id',
                        pageSize: 15,
                        pageList: [10, 15, 20, 25, 30, 40, 50],
                        remoteSort:false,
                        columns: [
                            [
                                {field: 'id', title: '科室ID', width: '100px', hidden: true},
                                {field: 'xh', title: '序号', width: '40px', align: 'left',sortable:true, halign: 'center'},
                                {field: 'code', title: '科室代码', width: '80px', align: 'left',sortable:true, halign: 'center'

                                },
                                {field: 'name', title: '名称', width: '150px', align: 'left',sortable:true, halign: 'center'},
                                {field: 'shortName', title: '简称', width: '120px', align: 'left',sortable:true, halign: 'center'},
                                {field: 'wbCode', title: '科目', width: '150px', align: 'left',sortable:true, halign: 'center'},

                                {field: 'ksType', title: '科室类型', width: '120px', align: 'left',sortable:true, halign: 'center'
//                                    ,
//                                    formatter:function (value, row, index) {
//                                        switch (value) {
//                                            case 1:
//                                                return "手术科室";
//                                            case 2:
//                                                return "非手术科室";
//                                            case 3:
//                                                return "医技科室"
//                                        }
//                                    }
                                },
                                {field: 'bedNums', title: '床位数', width: '80px', align: 'left', halign: 'center'},
                                {field: 'fixedbedNums', title: '编制床位', width: '80px', align: 'left', halign: 'center'},
                                {field: 'extrabedNums', title: '加床数', width: '80px', align: 'left', halign: 'center'},
                                {
                                    field: 'mz', title: '门诊', width: '40px', align: 'left', halign: 'center',
                                    formatter:function (value, row, index) {
                                        switch (value) {
                                            case "true":
                                                return "√";
                                        }

                                    }
                                },
                                {field: 'zy', title: '住院', width: '40px', align: 'left', halign: 'center',
                                    formatter:function (value, row, index) {
                                        switch (value) {
                                            case "true":
                                                return "√";
                                        }

                                    }
                                },
                                {field: 'jz', title: '急诊', width: '40px', align: 'left', halign: 'center',
                                    formatter:function (value, row, index) {
                                        switch (value) {
                                            case "true":
                                                return "√";
                                        }

                                    }
                                },
                                {
                                    field: 'operate', title: '操作', width: '75px', align: 'left', halign: 'center',
                                    formatter: function (value, row, index) {
                                        var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\' onclick="edit(\'' + row.id + '\')"><span class=\'glyphicon  glyphicon glyphicon-pencil\'></span></button>';
                                        str+= '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="del(\'' + row.id + '\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></button>';
                                        return str;
                                    }
                                }

                            ]
                        ]
                    }).datagrid('clientPaging');
        });
        function openwin() {
            if(${roleMenu.isAdd}){
                layeropen(600, 400, "数据编辑", "${ctx}/V_SysKeShi/toEdit");
            }
            else{
                layerInfo("没有权限!请找系统管理员申请权限!");
            }

        }
        function refresh() {
            loadList();
//            $('#gridtable').datagrid('reload');
        }

        function edit(id) {
            if(${roleMenu.isEdit}){
                layeropen(600, 400, "数据编辑", "${ctx}/V_SysKeShi/toEdit?id="+id);
            }
            else{
                layerInfo("没有权限!请找系统管理员申请权限!");
            }

        }
        function searchBtn() {
            var condition = $('#serach').val();
            var url = '${ctx }/SysKeShi/findByCondition?condition='+encodeURI(condition)+ "&rdm="+ parseInt(Math.random()*100000);
            $('#gridtable').datagrid({url:url});
        }
        function del(id) {
            if(${roleMenu.isDel}){
                layerConfirm("是否确定删除?", function () {
                    var url = '${ctx}/SysKeShi/delete?id=' + id;
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
                        url: '/SysKeShi/getAllKeShi?rdm=' + parseInt(Math.random()*100000)
                    });

        };
    </script>
</head>
<body>
<div class="navheader form-inline" style="height: 40px">
    <div class=" form-group">
        <label for="serach" style="padding:5px 10px 0 20px;">查询</label>
        <input type="text" id="serach" class="form-control" placeholder="名称、拼音码、代码查询"/>
        <button type="button" class="btn btn-success bi-btn-search" onclick="searchBtn()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>
    <div class="btn-group-right">
        <div class="btn-group " role="group">
            <button type="button" class="btn btn-default bi-btn-width90" onclick="refresh()">刷新</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="openwin()">新增</button>
        </div>
    </div>
</div>
<div  style="padding:0 5px;">
    <table id="gridtable" class="gridtable" style="width:100%;">

    </table>
</div>

</body>
</html>
