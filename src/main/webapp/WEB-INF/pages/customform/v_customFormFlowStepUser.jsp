<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/12/14
  Time: 19:12
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <script type="text/javascript" src="${ctx }/static/js/FormValidation.js"></script>
    <title></title>
    <script>
        var selectId = null;
        var stepId = null;
        var flowId = null;
        $(function(){
            stepId = GetUrlParam("stepId");
            flowId = GetUrlParam("flowId");

            var height = findDimensions_height();
            $("#l_datagrid").height(height-50);

            $("#r_datagrid").height(height-50);

//            loadKeshi();
            $('#l_datagrid').datagrid(
                    {
                        url: '/SysKeShi/getAllKeShi?rdm=' + parseInt(Math.random()*100000),
                        method: 'get',
                        idField: 'id',
                        pagination: true,
                        rownumbers: true,
                        singleSelect: true,
                        autoRowHeight: false,
                        clientPaging: true,
                        pageSize: 10,
                        pageList: [10, 15, 20, 25, 30, 40, 50],
                        columns: [
                            [
                                {field: 'id', title: '科室ID', width: '80px', hidden: true},
                                {field: 'code', title: '代码', width: '80px', align: 'left', halign: 'center'},
                                {field: 'name', title: '名称', width: '80px', align: 'left', halign: 'center'},
                                {field: 'ksType', title: '类型', width: '100px', align: 'left', halign: 'center'},

                            ]
                        ],
                        onSelect : function(index, row){
                            selectId = row.id;
                            loadUser(row.id);
                        }
                    }).datagrid('clientPaging');

//            loadUser(null);
            $('#r_datagrid').datagrid(
                    {
                        url: '',
                        method: 'get',
                        idField: 'id',
                        pagination: true,
                        rownumbers: true,
                        singleSelect: true,
                        autoRowHeight: false,
                        clientPaging: true,
                        pageSize: 10,
                        pageList: [10, 15, 20, 25, 30, 40, 50],
                        columns: [
                            [
                                {field: 'id', title: '医生ID', width: '80px', hidden: true},
                                {field: 'code', title: '编号', width: '60px', align: 'left', halign: 'center'},
                                {field: 'name', title: '姓名', width: '80px', align: 'left', halign: 'center'},
                                {field: 'ksName', title: '科室', width: '80px', align: 'left', halign: 'center'},
                                {field: 'zhiCheng', title: '职称', width: '80px', align: 'left', halign: 'center'},
                                {field: 'zhiWei', title: '职位', width: '100px', align: 'left', halign: 'center'},
                                {
                                    field: 'operate', title: '操作', width: '40px', align: 'left', halign: 'center',
                                    formatter: function (value, row, index) {
                                        var str = '<button type=\'button\'class=\'btn btn-info bi-glyphicon\' onclick=\'selectUser("' + row.id + '")\'><span class=\'glyphicon glyphicon glyphicon-ok\'></span></button>';
                                        return str;
                                    }
                                }
                            ]
                        ]

                    }).datagrid('clientPaging');
        })

        function loadKeshi(){
            $('#l_datagrid').datagrid(
                    {
                        url: '/SysKeShi/getAllKeShi?rdm=' + parseInt(Math.random()*100000)
                    });
        }


        function loadUser(ksId){
            $('#r_datagrid').datagrid(
                    {
                        url: '/CustomFormFlowStepUser/getKsStaff?search=&ksId='+ksId+'&rdm=' + parseInt(Math.random()*100000)
                    });
        }

        function selectUser(id){
            $.ajax({
                method: "POST",
                dataType:"JSON",
                url: "/CustomFormFlowStepUser/doSeleYh?userId="+id+"&stepId="+stepId+"&flowId="+flowId,
                success: function(data){
                    if(data.success == true){
                        parent.loadUser(stepId);
                        layerMsg(data.msg);
                    }else{
                        layerMsg(data.msg);
                    }
                }
            })
        }

        function searchKeshi() {
            var condition = $('#serach').val();
            selectId=null;
            var url = '/SysKeShi/findByCondition?condition='+encodeURI(condition)+ "&rdm="+ parseInt(Math.random()*100000);
            $('#l_datagrid').datagrid({url:url});
        }

        function searchUser(){
                var search = $('#searchUser').val();
                var url = '/CustomFormFlowStepUser/getKsStaffBys?search='+encodeURI(search)+'&rdm=' + parseInt(Math.random()*100000);
                $('#r_datagrid').datagrid({url:url});

        }

    </script>
</head>
<body>
<%--<div class=" form-group">--%>
    <%--<label for="serach" style="padding:5px 10px 0px 20px;">查询</label>--%>
    <%--<input type="text" id="serach" class="bi-input-serach" placeholder="请输入科室或科室拼音"/>--%>
    <%--<button type="button" class="btn btn-success bi-btn-search" onclick="search()">--%>
        <%--<span class="glyphicon glyphicon glyphicon-search"></span>--%>
    <%--</button>--%>
<%--</div>--%>
<div class="navheader form-inline" style="padding:0 5px;height:40px;">
<div class=" form-group">
    <label for="serach" style="padding:5px 10px 0px 20px;">科室查询</label>
    <input type="text" id="serach" class="bi-input-serach" placeholder="请输入科室或科室拼音"/>
    <button type="button" class="btn btn-success bi-btn-search" onclick="searchKeshi()">
        <span class="glyphicon glyphicon glyphicon-search"></span>
    </button>

</div>
<div class="btn-group-right">
    <label for="searchUser" style="padding:5px 10px 0px 20px;">医师查询</label>
    <input type="text" id="searchUser" class="bi-input-serach "  placeholder="请输入编号姓名或拼音"/>
    <button type="button" class="btn btn-success bi-btn-search" onclick="searchUser()">
        <span class="glyphicon glyphicon glyphicon-search"></span>
    </button>
</div>
</div>


<div style="margin:0 5px; overflow: hidden;" >
    <!--左边表格-->
    <div style="width:45%;float:left;display:inline-block;padding-right:5px;border-right:1px dotted #ccc;" >
        <table id="l_datagrid" class="datagrid"></table>

    </div>
    <!--右边表格 -->
    <div style="width:55%;float:right;display:inline-block;padding-left:5px;">
        <table id="r_datagrid" class="datagrid">
            <!--右边表格未定义-->
        </table>
    </div>
</div>
</body>
</html>
