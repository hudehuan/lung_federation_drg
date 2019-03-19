<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/8/17
  Time: 8:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>雕龙数据</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <script type="text/javascript">
        //		点取消关闭窗口
        function btnclose() {
            closeIndexWindwos();
        }
        function selectvalue(name,id) {
            parent.setValue("ksId",id);
            parent.setValue("ksName", name);
            closeIndexWindwos();
        }
        function search() {
            var condition = $('#serach').val();
            var url = '${ctx }/SysKeShi/findByCondition?condition='+encodeURI(condition)+ "&rdm="+ parseInt(Math.random()*100000);
            $('#gridtable').datagrid({url:url});
        }
        $(function () {
            $('#gridtable').datagrid(
                    {
                        url: '/SysKeShi/getAllKeShi?rdm=' + parseInt(Math.random()*100000),
                        method: 'get',
                        rownumbers: true,
                        singleSelect: true,
                        autoRowHeight: false,
                        clientPaging: true,
                        remoteSort:false,
                        pageSize: 15,
                        pageList: [10, 15, 20, 25, 30, 40, 50],
                        columns: [
                            [
                                {field: 'id', title: '科室ID', width: '100px', hidden: true},
                                {field: 'code', title: '代码', width: '50px', align: 'left', halign: 'center'},
                                {field: 'name', title: '名称', width: '70px', align: 'left', halign: 'center'},
                                {field: 'ksType', title: '类型', width: '90px', align: 'left', halign: 'center'},
                                {
                                    field: 'operate', title: '操作', width: '40px', align: 'left', halign: 'center',
                                    formatter: function (value, row, index) {
                                        var str = '<button type=\'button\'class=\'btn btn-info bi-glyphicon\' onclick=\'selectvalue("' + row.name + '","' + row.id + '")\'><span class=\'glyphicon glyphicon glyphicon-ok\'></span></button>';
                                        return str;
                                    }
                                }

                            ]
                        ]
                    });

        });

    </script>

<body>
<div class="navheader form-inline">
    <div class=" form-group">
        <label for="serach" style="padding:5px 10px 0px 20px;">查询</label>
        <input type="text" id="serach" class="bi-input-serach" placeholder=""/>
        <button type="button" class="btn btn-success bi-btn-search" onclick="search()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>
</div>

<table id="gridtable" class="gridtable" style="height:220px;">

</table>

</body>
</html>
