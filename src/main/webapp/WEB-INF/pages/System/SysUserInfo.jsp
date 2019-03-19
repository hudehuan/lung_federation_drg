<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/7/21
  Time: 13:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp"%>
    <title>${titlename}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <script>
        $(function(){
            var height = findDimensions_height();
            $("#l_datagrid").height(height-50);
//            loadUserInfo();
            $('#l_datagrid').datagrid(
                    {
                        url:'/SysUserInfo/getAllUserInfo?rdm='+ parseInt(Math.random()*100000),
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        idField: 'id',
                        autoRowHeight:false,
                        pagination:true,
                        clientPaging:true,
                        remoteSort:false,
                        pageSize:15,
                        pageList:[10,15,20,25,30,40,50],
                        columns: [
                            [
                                { field:'id',title:'人员ID',hidden:true},
                                { field: 'name', title: '名称', width: '80px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'loginName', title: '登录代码', width: '80px', align: 'left',sortable:true, halign: 'center'},
                                { field: 'ksName', title: '科室', width: '120px', align: 'left',sortable:true, halign: 'center'},
                                { field: 'homePage', title: '首页界面', width: '120px', align: 'left',sortable:true, halign: 'center'},
                                {field: 'zhiCheng', title: '职称', width: '60px', align: 'left',sortable:true, halign: 'center'},
                                {field: 'zhiWei', title: '职位', width: '60px', align: 'left',sortable:true, halign: 'center'},
                                { field: 'status', title: '启用', width: '60px', align: 'left',sortable:true, halign: 'center',
                                    formatter:function (value, row, index) {
                                        switch (value) {
                                            case 1:
                                                return "√";
                                        }
                                    }
                                },
                                { field: 'isCheck', title: '检查', width: '60px', align: 'left',sortable:true, halign: 'center',
                                    formatter:function (value, row, index) {
                                        if(value){
                                            return "√";
                                        }
                                    }
                                },
                                { field: 'operate', title: '操作', width: '75px', align: 'left', halign: 'center',
                                    formatter:function(value,row,index){
                                        var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\' onclick="toUpdate(\'' + row.id + '\')"><span class=\'glyphicon  glyphicon glyphicon-pencil\'></span></button>';
                                        str+= '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="toDelUser(\'' + row.id + '\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></button>';
                                        return str;
                                    }
                                }

                            ]
                        ],
                        onClickRow: function(index,row) {
                            id = row.id;
                            loadUserKs(row.id);
                            loadUserRoles(row.id);
                        }
                    }).datagrid('clientPaging');
            //$('#l_datagrid').datagrid('selectRow',{index:0});
            $("#rt_datagrid").height(height/2-30);
            $('#rt_datagrid').datagrid(
                    {
                        url : '',
//                        url:'/SysUserKs/getAllUserKs?userid='+ id+ "&rdm="+ parseInt(Math.random()*100000),
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        autoRowHeight:false,
                        clientPaging:true,
                        remoteSort:false,
                        sortName:'xh',
                        idField: 'id',
                        columns: [
                            [
                                {field:'id',title:'ID',hidden:true},
                                { field: 'xh', title: '序号', width: '40px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'name', title: '可看科室', width: '200px', align: 'left', sortable:true,halign: 'center'},

                                { field: 'operate', title: '操作', width: '40px', align: 'left',sortable:false, halign: 'center',
                                    formatter:function(value,row,index){
                                        var str='<button type=\'button\'class=\'btn btn-danger bi-glyphicon\' onclick="toDelKs(\'' + row.id + '\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></button>';
                                        return str;
                                    }
                                }

                            ]
                        ]
                    });
            $("#rb_datagrid").height(height/2-30);
            $('#rb_datagrid').datagrid(
                    {
                        url : "",
//                        url:'/SysUserRoles/getAllRole?uerId='+ id+ "&rdm="+ parseInt(Math.random()*100000),
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        autoRowHeight:false,
                        sortName:'xh',
                        remoteSort:false,
                        columns: [
                            [
                                { field:'id',title:'ID',hidden:true},
                                { field: 'xh', title: '序号', width: '40px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'name', title: '用户角色', width: '200px', align: 'left', sortable:true,halign: 'center'},
                                { field: 'operate', title: '操作', width: '40px', align: 'left', halign: 'center',
                                    formatter:function(value,row,index){
                                        var str='<button type=\'button\'class=\'btn btn-danger bi-glyphicon\' onclick="toDelRole(\'' + row.id + '\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></button>';
                                        return str;
                                    }
                                }

                            ]
                        ]
                    });
        });

        id = null;
        function loadUserInfo() {
            $('#l_datagrid').datagrid(
                    {
                        url:'/SysUserInfo/getAllUserInfo?rdm='+ parseInt(Math.random()*100000)
                    });
        }

        function loadUserKs(id) {
            $('#rt_datagrid').datagrid(
                    {
                        url:'/SysUserKs/getAllUserKs?userid='+ id+ "&rdm="+ parseInt(Math.random()*100000)
                    });
        }

        function loadUserRoles(id) {
            $('#rb_datagrid').datagrid(
                    {
                        url:'/SysUserRoles/getAllRole?uerId='+ id+ "&rdm="+ parseInt(Math.random()*100000)
                    });

        }
        // 删除用户
        function toDelUser(id) {
            // 阻止冒泡
            if ( event && event.stopPropagation ) {
                event.stopPropagation();}
            else{
                window.event.returnValue = false;
            }
            if(!${roleMenu.isDel}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }
            layerConfirm("是否确定删除?", function(){
                var url = '${ctx}/SysUserInfo/delete?id='+id;
                $.ajax({
                    type : 'post',
                    url : url,
                    dataType: "json",
                    success:function(data){
                        if(data.success == true){
                            $('#l_datagrid').datagrid(
                                    {
                                        url: '/SysUserInfo/getAllUserInfo?rdm=' + parseInt(Math.random() * 100000)
                                    });
                            $('#rt_datagrid').datagrid('loadData',{total:0,rows:[]});
                            $('#rb_datagrid').datagrid('loadData',{total:0,rows:[]});
                        }else{
                            alert(data.msg);
                        }
                    }
                });
            });
        }

        function toDelKs(id) {
            var url = '${ctx}/SysUserKs/delete?id='+id;
            if(!${roleMenu.isDel}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }
            layerConfirm("是否确定删除?",function(){
                $.ajax({
                    type : 'post',
                    url : url,
                    dataType: "json",
                    success:function(data){
                        if(data.success == true){
                            $('#rt_datagrid').datagrid(
                                    {
                                        url:'/SysUserKs/getAllUserKs?userid='+ id+ "&rdm="+ parseInt(Math.random()*100000)
                                    });
                        }else{
                            alert(data.msg);
                        }
                    }
                });
            });
        }

        //删除角色
        function toDelRole(id) {
            if(!${roleMenu.isDel}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }

            layerConfirm("是否确定删除?",function(){

                var url = '${ctx}/SysUserRoles/delete?id='+id;
                $.ajax({
                    type : 'post',
                    url : url,
                    dataType: "json",
                    success:function(data){
                        if(data.success == true){
                            $('#rb_datagrid').datagrid(
                                    {
                                        url: '/SysUserRoles/getAllRole?uerId=' + id + "&rdm=" + parseInt(Math.random() * 100000)
                                    });
                        }else{
                            alert(data.msg);
                        }
                    }
                });
            });
        }

        // 修改
        function toUpdate(id){
            if ( event && event.stopPropagation ) {
                event.stopPropagation();}
            else{
                window.event.returnValue = false;
            }
            if(!${roleMenu.isEdit}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }
            var url= '${ctx}/V_SysUserInfo/toEdit?id='+id;
            layeropen(600,200,"修改角色",url);
        }

        function openwin(){
            if(!${roleMenu.isAdd}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }
            layeropen(600,500,"增加用户","/V_SysUserInfo/toUserStaff");
        }

        function editPwd() {
            if(!${roleMenu.isEdit}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }
            if (id != null) {
                layeropen(600,300,"修改密码","/V_SysUserInfo/toEditPwd?id="+ id);
            }else{
                layerInfo("请选择用户！");
            }
        }

        function addRole() {
            if(!${roleMenu.isEdit}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }
            if (id != null) {
                layeropen(600,350,"增加角色","/V_SysUserRoles/toList?userId="+ id);
            }else{
                layerInfo("请选择用户！");
            }
        }

        function addKs() {
            if(!${roleMenu.isEdit}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }

            if (id != null) {
                layeropen(600,300,"增加科室","/V_SysUserKs/toUserKs?userid="+ id);
            }else{
                layerInfo("请选择用户！");
            }
        }

        function refresh(){
            $('#l_datagrid').datagrid(
                    {
                        url: '/SysUserInfo/getAllUserInfo?rdm=' + parseInt(Math.random() * 100000)
                    });
            $('#rt_datagrid').datagrid(
                    {
                        url:'/SysUserKs/getAllUserKs?userid='+ id+ "&rdm="+ parseInt(Math.random()*100000)
                    });
            $('#rb_datagrid').datagrid(
                    {
                        url: '/SysUserRoles/getAllRole?uerId=' + id + "&rdm=" + parseInt(Math.random() * 100000)
                    });
        }

        //增加人员科室的查询
        function search() {
            var condition = $('#serach').val();
            var kscondition = $('#serachks').val();
            var url = '${ctx }/SysUserInfo/findByCondition?condition='+encodeURI(condition)+'&kscondition='+encodeURI(kscondition);
            $('#l_datagrid').datagrid({url:url});
        }

    </script>
</head>
<body>
<div class="navheader form-inline" style="padding:0 5px;height:40px;">
    <div class=" form-group">
        <label for="serach"style="padding:5px 10px 0px 20px;">用户</label>
        <input type="text" id="serach" class="form-control"placeholder="名称、拼音码、代码查询" />
        <label for="serachks"style="padding:5px 10px 0px 20px;">科室</label>
        <input type="text" id="serachks" class="form-control"placeholder="名称、拼音码、代码查询" />

        <button type="button" class="btn btn-success bi-btn-search" onclick="search()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>
    <div class="btn-group-right">
        <div class="btn-group "  role="group">
            <button type="button" class="btn btn-default bi-btn-width90" onclick="refresh()">刷新</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="openwin()">新增</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="addKs()">新增科室</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="addRole()">新增角色</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="editPwd()">修改密码</button>
        </div>
    </div>
</div>

<div style="margin:0 5px; overflow: hidden;" >
    <!--左边表格-->
    <div style="width:60%;float:left;display:inline-block;padding-right:5px;border-right:1px dotted #ccc;" >
        <table id="l_datagrid" class="datagrid"></table>

    </div>
    <!--右边表格 -->
    <div style="width:40%;float:right;display:inline-block;padding-left:5px;">
        <div style="overflow: hidden;text-align: right;">

            <table class="datagrid" id="rt_datagrid"style=" overflow: auto;"></table>
        </div>
        <div style="overflow: hidden;text-align: right;margin-top:10px;">

            <table class="datagrid" id="rb_datagrid" style="overflow: auto;"></table>
        </div>
    </div>
</div>
</body>
</html>
