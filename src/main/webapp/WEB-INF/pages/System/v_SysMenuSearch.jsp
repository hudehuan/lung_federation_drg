<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/08/23
  Time: 14:04
  To change this template use File | Settings | File Templates.
--%>
<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>菜单检索</title>
    <script>
        var data;
        $(function () {
            if (navigator.appName == "Microsoft Internet Explorer" && (navigator.appVersion.match(/7./i) == "7." || navigator.appVersion.match(/8./i) == "8.")) {
                $('#search').bind('propertychange', function() {
                    search();
                });
            }
            else {
                $('#search').bind('input', function() {
                    search();
                });
            }

            var height = findDimensions_height();
            $("#gridtable").height(height - 50);
            $("#search").val('${search}');
            loadData('${search}');
            loadList();
        })

        function loadData(search) {
            $.ajax({
                type: 'post',
                url: '/sysMenu/findMenu?search='+search+'&rdm=' + parseInt(Math.random()*100000),
                dataType: "json",
                success: function (json) {
                    $('#gridtable').datagrid("loadData",json);
                    data =  $('#gridtable').datagrid("getData");
                }
            })
        }

        function loadList() {
            $('#gridtable').datagrid(
                {
                    url: '',
                    method: 'get',
                    rownumbers: true,
                    singleSelect: true,
                    autoRowHeight: false,
//                    pagination: true,
//                    clientPaging: true,
                    idField: 'id',
//                    pageSize: 6,
//                    pageList: [6,10, 15, 20, 25, 30, 40, 50],
                    remoteSort:false,
                    columns: [
                        [
                            {field: 'id', title: '菜单ID', width: '100px', hidden: true},
                            {field: 'code', title: '代码', width: '100px', hidden: true},
                            {field: 'name', title: '菜单名', width: '150px', align: 'left',sortable:true, halign: 'center'},
                            {field: 'pname', title: '父菜单', width: '120px', align: 'left',sortable:true, halign: 'center'},
                            {field: 'type', title: '类型', width: '150px', align: 'left',sortable:true, halign: 'center'},
                            {
                                field: 'operate', title: '操作', width: '75px', align: 'left', halign: 'center',
                                formatter: function (value, row, index) {
                                    var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\' onclick="openView(\'' + row.code + '\')">' +
                                        '<span class=\'glyphicon  glyphicon glyphicon-ok\'></span></button>';
                                    return str;
                                }
                            }

                        ]
                    ]
                });
        }

        function search() {
            var search = $("#search").val().toLowerCase();
            var gridData = [];
            for(var i=0;i<data.rows.length;i++){
                if(data.rows[i].name.indexOf(search)>-1
                    ||data.rows[i].pname.indexOf(search)>-1
                    ||data.rows[i].type.indexOf(search)>-1
                    ||data.rows[i].pym.indexOf(search)>-1
                    ||data.rows[i].ppym.indexOf(search)>-1){
                    gridData.push(data.rows[i]);
                }
            }
            var json = {"total":gridData.length,"rows":gridData}
            $('#gridtable').datagrid("loadData",json);
        }

        function openView(code) {
            parent.openView(code);
            closeIndexWindwos();
        }
    </script>

</head>
<body>

<div class="navheader form-inline" style="height: 40px">
    <div class=" form-group">
        <label for="search" style="padding:5px 10px 0 20px;">查询</label>
        <input type="text" id="search" class="form-control" style="display:inline; width: 400px;" placeholder="名称、拼音码查询"/>
        <button type="button" class="btn btn-success bi-btn-search" onclick="search()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>

</div>
<div  style="padding:0 5px;">
    <table id="gridtable" class="gridtable" style="width:100%;">

    </table>
</div>
</body>
</html>
