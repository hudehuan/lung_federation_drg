<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/10/21
  Time: 11:34
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/7/21
  Time: 13:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
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
                        url:'/LogUserOper/getAllLogUserOper?rdm='+ parseInt(Math.random()*100000),
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        autoRowHeight:false,
                        pagination:true,
                        remoteSort:false,
                        idField: 'id',
                        pageSize:15,
                        pageList:[15,20,25,30,40,50],
                        clientPaging:true,
                        columns: [
                            [
                                {field: 'id', title: 'ID', hidden: true},
                                { field: 'loginName', title: '登录名', width: '80px', align: 'left',sortable:true, halign: 'center'},
                                { field: 'userName', title: '用户名', width: '80px', align: 'left',sortable:true, halign: 'center'},
                                { field: 'optDate', title: '操作时间', width: '150px', align: 'left',sortable:true, halign: 'center',formatter: formatDatebox},
                                { field: 'url', title: '操作url', width: '150px', align: 'left',sortable:true, halign: 'center'},
                                { field: 'formTitle', title: '表单名', width: '80px', align: 'left',sortable:true, halign: 'center'},
                                { field: 'menuCode', title: '菜单编号', width: '80px', align: 'left',sortable:true, halign: 'center'},
                                { field: 'modelName', title: '模块名称', width: '80px', align: 'left',sortable:true, halign: 'center'},
                                { field: 'optBrowse', title: '用户浏览器', width: '150px', align: 'left',sortable:true, halign: 'center'},
                                { field: 'optIp', title: '用户IP地址', width: '150px', align: 'left',sortable:true, halign: 'center'},
                            ]
                        ]
                    }).datagrid('clientPaging');
        });
        function refresh(){
//            $('#gridtable').datagrid('reload');
            loadList();
        }
        function search() {
            var condition = $('#serach').val();
            var url = '${ctx }/LogUserOper/findByCondition?condition='+encodeURI(condition)+ "&rdm="+ parseInt(Math.random()*100000);
            //win=url;dow.location.href
            $('#gridtable').datagrid({url:url});
        }

        function loadList(){
            $('#gridtable').datagrid(
                    {
                        url:'/LogUserOper/getAllLogUserOper?rdm='+ parseInt(Math.random()*100000)
                    });
        }
    </script>

</head>
<body>
<div class="navheader form-inline" style="padding:0 5px;height:40px;">

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
        </div>
    </div>
</div>
<div style="padding:0 5px;">
    <table id="gridtable" class="gridtable" style="width:100%;" >
    </table>
</div>

</body>
</html>
