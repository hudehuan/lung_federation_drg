<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                        url: '/SysUserOnline/getAllUserOnline?rdm='+ parseInt(Math.random()*100000),
                        method: 'get',
                        rownumbers: true,
                        singleSelect: true,
                        autoRowHeight: false,
                        pagination: true,
                        remoteSort:false,
                        clientPaging: true,
                        pageSize: 15,
                        pageList: [10, 15, 20, 25, 30, 40, 50],
                        columns: [
                            [
                                {field: 'id', title: 'ID', hidden: true},
                                {field: 'userId', title: 'UserID', hidden: true},
                                {field: 'userName', title: '姓名',sortable:true, width: '100px'},
                                {field: 'loginTime', title: '登录时间', sortable:true,width: '200px'},
                                {field: 'sessionId', title: 'SessionId', hidden: true},
                                {field: 'sysCode', title: '系统代码', sortable:true,width: '100px'}
                            ]],
                        toolbar: '#dlgToolbar'
                    }).datagrid('clientPaging');
        });
        function refresh() {
//            $('#gridtable').datagrid('reload');
            loadList();
        }
        function loadList() {
            $('#gridtable').datagrid(
                    {
                        url: '/SysUserOnline/getAllUserOnline?rdm='+ parseInt(Math.random()*100000)
                    });
        }

        function search() {
            var condition = $('#serach').val();
            var url = '${ctx }/SysUserOnline/findByCondition?condition=' + encodeURI(condition)+ "&rdm="+ parseInt(Math.random()*100000);
            $('#gridtable').datagrid({url: url});
        }

    </script>
</head>
<body>
<div class="navheader form-inline" style="padding:0 5px;height:40px;">
    <div class=" form-group">
        <label for="serach" style="padding:5px 10px 0px 20px;">查询</label>
        <input type="text" id="serach" class="form-control" placeholder="姓名、拼音码查询"/>
        <button type="button" class="btn btn-success bi-btn-search" onclick="search()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>
    <div class="btn-group-right">
        <div class="btn-group " role="group">
            <button type="button" class="btn btn-default bi-btn-width90" onclick="refresh()">刷新</button>
        </div>
    </div>
</div>

<div style="padding:0 5px;">
    <table id="gridtable" class="gridtable" style="width:100%;">
    </table>
</div>


</body>
</html>