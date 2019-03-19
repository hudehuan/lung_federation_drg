<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/7/21
  Time: 13:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <%@ include file="/common/meta.jsp"%>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <script type="text/javascript">
        //		点取消关闭窗口
        function btnclose(){
            closeIndexWindwos();
        }
        function save(value) {
            <%--var url = '${ctx }/SysUserRoles/save?uerId='+userId + "&roleId=" + value;--%>
            <%--parent.location.href = url;--%>
            var postData = {
                "uerId":$('#userId').val(),
                "roleId":value
            }
            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: "${ctx }/SysUserRoles/save",
                data:postData,
                success: function (data) { //如果执行成功，那么执行此方法
                    if (data.success == false) {
                        layerError("权限已存在！");
//                        id = null;
                    }
                    else {
                        parent.loadUserRoles($('#userId').val());
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
            var url = '${ctx }/SysRole/findByCondition?condition='+encodeURI(condition)+ "&rdm="+ parseInt(Math.random()*100000);
            $('#gridtable').datagrid({url:url});
        }

        $(function(){

            $('#gridtable').datagrid(
                    {
                        url:'/SysRole/getAllRole?rdm='+ parseInt(Math.random()*100000),
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        autoRowHeight:false,
                        clientPaging:true,
                        remoteSort:false,
                        columns:[
                            [
                                { field:'id',title:'角色ID',width:'100px',hidden:true},
                                { field: 'xh', title: '序号', width: '60px',align: 'left', halign: 'center'},
                                { field: 'name', title: '用户角色', width: '240px',align: 'left', halign: 'center'},
//                                { field: 'type', title: '类型', width: '80px',align: 'left', halign: 'center'},
                                { field: 'operate', title: '操作', width: '60px', align: 'left', halign: 'center',
                                    formatter:function(value,row,index){
                                        var str='<button type=\'button\'class=\'btn btn-info bi-glyphicon\' onclick="save(\'' + row.id + '\')"><span class=\'glyphicon glyphicon glyphicon-ok\'></span></button>';
                                        return str;
                                    }
                                }

                            ]
                        ]
                    });

        });

    </script>

<body >
<input type="hidden" id="userId" name="userId" value="${userId}"/>
<div class="navheader form-inline">
    <div class=" form-group">
        <label for="serach" style="padding:5px 10px 0px 20px;">查询</label>
        <input type="text" id="serach" class="bi-input-serach"placeholder="名称、代码、拼音查询" />
        <button type="button" class="btn btn-success bi-btn-search" onclick="search()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>
</div>
<table id="gridtable" class="gridtable" style="height:270px;" >
</table>
</body>
</html>