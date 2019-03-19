<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/11/1
  Time: 14:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>表单审核记录</title>

    <script>

        $(function () {
            var height = findDimensions_height();
            $("#gridtable").height(height);
        });

        function refresh() {
            $('#gridtable').datagrid('reload');
        }

        <%--function opencheck(id){--%>
            <%--layeropen(600, 350, "表单审核", "${ctx}/member/opencheck?checkID="+id);--%>
        <%--}--%>

        $(function () {

            $('#gridtable').datagrid(
                    {
                        url: '/CustomFormShLog/getLogListByCheckID?formID=${formID}&dataID=${dataID}',
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
                                {field: 'id', title: 'ID', width: '100px', hidden: true},
                                {field: 'stepName', title: '步骤名称', width: '80px', align: 'left',sortable:true, halign: 'center'},
                                {field: 'checkTime', title: '审核时间', width: '100px', align: 'left',sortable:true, halign: 'center'},
                                {field: 'shStatus', title: '状态', width: '80px', align: 'left',sortable:true, halign: 'center',
                                    formatter:function (value, row, index) {
                                        switch (value) {
                                            case 0:
                                                return "提交审核";
                                            case 1:
                                                return "通过审核";
                                            case 2:
                                                return "审核结束";
                                            case 3:
                                                return "驳回";
                                            case 4:
                                                return "撤销";
                                        }
                                    }},
                                {field: 'checkUser', title: '审核人', width: '120px', align: 'left',sortable:true, halign: 'center'},
                                {field: 'shsm', title: '说明', width: '500px', align: 'left',sortable:true, halign: 'center'}


                            ]
                        ]
                    }).datagrid('clientPaging');

        });
    </script>



</head>
<body>


<div  style="padding:0 5px;">
    <table id="gridtable" class="gridtable" style="width:100%;">

    </table>
</div>


</body>
</html>
