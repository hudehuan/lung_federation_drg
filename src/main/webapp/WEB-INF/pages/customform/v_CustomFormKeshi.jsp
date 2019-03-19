<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/6/7
  Time: 10:14
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
            var str ="";
            var name = "";
            var id = "";
            $("input:checkbox[name='uname']:checked").each(function(){
                str = $(this).val();
                id+= ","+str.substring(0,str.indexOf(","));
                name+= ","+str.substring(str.indexOf(",")+1,str.length);
            })
            id = id.substring(1,id.length);
            name = name.substring(1,name.length);
            parent.addFormKeshi(id,name);
            closeIndexWindwos();
        }

        function search() {
            var condition = $('#search').val();
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
                            {field: 'code', title: '代码', width: '100px', align: 'left', halign: 'center'},
                            {field: 'name', title: '名称', width: '100px', align: 'left', halign: 'center'},
                            {
                                field: 'operate', title: '操作', width: '100px', align: 'center', halign: 'center',
                                formatter: function (value, row, index) {
                                    var str = '<input type=\'checkbox\'name="uname" align="center" class=\'btn btn-info bi-glyphicon\' value="' + row.id + ','+row.name+'"></button>';
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
        <label for="search" style="padding:5px 10px 0px 20px;">查询</label>
        <input type="text" id="search" class="bi-input-serach" placeholder=""/>
        <button type="button" class="btn btn-success bi-btn-search" onclick="search()">
        <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
        <button type="button" class="btn btn-info bi-glyphicon" onclick="selectvalue()" style="float: right;margin-top: 10px;">
            <span class="glyphicon glyphicon glyphicon-ok">确定</span></button>
    </div>
</div>

<table id="gridtable" class="gridtable" style="height:350px;">

</table>

</body>
</html>
