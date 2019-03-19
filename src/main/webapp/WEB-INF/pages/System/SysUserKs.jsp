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
    <title>朔州博爱医院</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <script type="text/javascript">
        //		点取消关闭窗口
        var id;
        function btnclose() {
            closeIndexWindwos();
        }
        function save(values) {
            <%--var url = '${ctx }/SysUserKs/save?userid='+ userid + "&ksid=" + values;--%>
            //parent.location.href = url;
            var postData = {
                "userid":$('#userid').val(),
                "ksid":values
            }
            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: "${ctx }/SysUserKs/save",
                data:postData,
                success: function (data) { //如果执行成功，那么执行此方法
                    if (data.success == false) {
//                        $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                        layerError("科室已存在！");
                        id = null;
                    }
                    else {
                        parent.loadUserKs($('#userid').val());
                        layerSuccess("成功", function () {
                            //关闭窗体
                            closeIndexWindwos();
                        });

                    }
                }
//                error: function (err) { //如果执行不成功，那么执行此方法
//                    alert("err:" + err);
//                }

            });
        }
        function search() {
            var condition = $('#serach').val();
            var url = '${ctx }/SysKeShi/findByCondition?condition='+encodeURI(condition)+ "&rdm="+ parseInt(Math.random()*100000);
            $('#gridtable').datagrid({url:url});
        }
        $(function () {
            $('#gridtable').datagrid(
                    {
                        url: '/SysKeShi/getAllKeShi?rdm='+parseInt(Math.random()*100000),
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
                                {field: 'name', title: '名称', width: '150px', align: 'left', halign: 'center'},
                                {field: 'ksType', title: '类型', width: '90px', align: 'left', halign: 'center',
                                    formatter: function (value, row, index) {
                                        switch (value) {
                                            case 1:
                                                return "手术科室";
                                            case 2:
                                                return "非手术科室";
                                            case 3:
                                                return "医技科室";
                                        }
                                    }
                                },
                                {
                                    field: 'operate', title: '操作', width: '60px', align: 'left', halign: 'center',
                                    formatter: function (value, row, index) {
                                        id = row.id;
                                        var str = '<button type=\'button\'class=\'btn btn-info bi-glyphicon\' onclick="save(\'' + row.id + '\')"><span class=\'glyphicon glyphicon glyphicon-ok\'></span></button>';
                                        return str;
                                    }
                                }

                            ]
                        ]
                    }).datagrid('clientPaging');

        });

    </script>

<body>
<input type="hidden" id="userid" name="userid" value="${userid}"/>
<div class="navheader form-inline">
    <div class=" form-group">
        <label for="serach" style="padding:5px 10px 0px 20px;">查询</label>
        <input type="text" id="serach" class="bi-input-serach" placeholder="名称、代码、拼音查询"/>
        <button type="button" class="btn btn-success bi-btn-search" onclick="search()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>
</div>

<table id="gridtable" class="gridtable" style="height:220px;">

</table>

</body>
</html>
