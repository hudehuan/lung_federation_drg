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
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <script>
        var RoleTreeData;
        //保存需要更新的顶级菜单ID
        var SaveMenuCode = [];

        var rolemenus = [];

        var roleid = null;
        $(function(){
            var height = findDimensions_height();
            $("#l_datagrid").height(height-50);
//            loadRole();
            $('#l_datagrid').datagrid(
                    {
                        url:'/SysRole/getAllRole?rdm='+ parseInt(Math.random()*100000),
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        autoRowHeight:false,
                        remoteSort:false,
                        columns: [
                            [
                                { field: 'id', title: '角色ID', hidden: true },
                                { field: 'xh', title: '序号', width: '40px', align: 'left',sortable:true, halign: 'center' },
//                                { field: 'type', title: '分类', width: '80px', align: 'left',sortable:true, halign: 'center'},
                                { field: 'name', title: '名称', width: '150px', align: 'left', sortable:true,halign: 'center'},
                                { field: 'operate', title: '操作', width: '80px', align: 'left', halign: 'center',
                                    formatter:function(value,row,index){
                                        var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\' onclick="toUpdate(\'' + row.id + '\')"><span class=\'glyphicon  glyphicon glyphicon-pencil\'></span></button>';
                                        str+= '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="Del(\'' + row.id + '\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></button>';
                                        return str;
                                    }
                                }

                            ]
                        ],
                        onClickRow: function(index,row) {
                            var id = row.id;
                            roleid = id;
                            LoadRoleMenu(id);
                        }
                    });
            $("#r_datagrid").height(height-50);
//            LoadRoleMenu(roleid);
            $('#r_datagrid').treegrid({
                method: 'get',
                url:'',
                rownumbers: true,
                animate: true,
                collapsible: true,
                fitColumns: true,
                idField: 'menuCode',
                treeField: 'menuName',
                columns: GetGridColumn(),
                onLoadSuccess: function (row, data) {

                    //$('#tbl_MenuCode').treegrid('collapseAll');
                    if (!row) {
                        //SaveMenuCode = [];
                    }
                    else {
//                            $.each(data, function (i, n) {
//                                if (n.state == "closed")
//                                    $('#tbl_MenuCode').treegrid('expandAll', n.menuId);
//                            });
                    }

                }
            });
        });

        function loadRole() {
            $('#l_datagrid').datagrid(
                    {
                        url:'/SysRole/getAllRole?rdm='+ parseInt(Math.random()*100000)
                    });
        }
        function LoadRoleMenu(roleid){
            $('#r_datagrid').treegrid({
                method: 'get',
                url:'/SysRoleMenu/getMenuByRoleID?roleId='+ roleid+ "&rdm="+ parseInt(Math.random()*100000)
            });
        }

        function GetGridColumn() {
            return [[
                { field: 'id', title: '编号', hidden: true },
                { field: 'menuId', title: '菜单编号', hidden: true },
                { field: 'menuCode', title: '菜单编号', hidden: true },
                { field: 'menuName', title: '菜单名称', width: '350px' ,align: 'left', halign: 'center' },
                { field: 'type', title: '类型', width: '100px', align: 'left', halign: 'center',
                    formatter:function (value, rec, index) {
                        switch (value) {
                            case "function":
                                return "功能";
                            case "System":
                                return "系统";
                            case "BI":
                                return "BI图表";
                            case "BIolap":
                                return "BIolap";
                            case "comment":
                                return "BI评价方案";
                            case "report":
                                return "BI分析报告";
                            case "form":
                                return "自定义表单";
                            case "excel":
                                return "Excel导入";
                        }
                    }
                },
                { field: 'browse', title: '浏览', width: '30px', align: 'center',halign: 'center',
                    formatter:function (value, rec, index) { return GetCheckBox(value, rec, index, "browse") }},
                { field: 'add', title: '新增', width:'30px', align: 'center',halign: 'center',
                    formatter:function (value, rec, index) { return GetCheckBox(value, rec, index, "add") } },
                { field: 'edit', title: '修改', width: '30px', align: "center",halign: 'center',
                    formatter: function (value, rec, index) { return GetCheckBox(value, rec, index, "edit") } },
                { field: 'del', title: '删除', width:'30px', align: 'center',halign: 'center' ,
                    formatter:function (value, rec, index) { return GetCheckBox(value, rec, index, "del") } },
                { field: 'print', title: '打印', width:'30px', align: 'center', halign: 'center' ,
                    formatter:function (value, rec, index) { return GetCheckBox(value, rec, index, "print") }},
                { field: 'myimport', title: '导入', width: '30px', align: 'center', halign: 'center' ,
                    formatter:function (value, rec, index) { return GetCheckBox(value, rec, index, "myimport") }},
                { field: 'export', title: '导出', width: '30px', align: 'center', halign: 'center' ,
                    formatter:function (value, rec, index) { return GetCheckBox(value, rec, index, "export") }},
                { field: 'check', title: '审核', width:'30px', align: 'center', halign: 'center',
                    formatter:function (value, rec, index) { return GetCheckBox(value, rec, index, "check") } },
                { field: 'undo', title: '撤销', width:'30px', align: 'center', halign: 'center',
                    formatter:function (value, rec, index) { return GetCheckBox(value, rec, index, "undo") } },
                { field: 'pMenuCode', title: '', hidden: true}
            ]]
        }

        function GetCheckBox(value, rec, index, Id) {
            var isCheck = rec[Id] == true ? "Checked" : "";
            var strHTML = "<input id='Chk_" + rec.menuCode + "_" + Id + "' onclick='checkValue(this)' type='checkbox' " + isCheck + " />";
            return strHTML;
        }

        function checkValue(obj) {
            var CurSelectData = $('#r_datagrid').treegrid('find', obj.id.split("_")[1]);
            if (SaveMenuCode.indexOf(obj.id.split("_")[1].substr(0,3)) == -1)
                SaveMenuCode.push(obj.id.split("_")[1].substr(0,3));
//                if (CurSelectData.state == "closed" && $('#tbl_MenuCode').treegrid('getChildren', obj.id.split("_")[1]).length == 0) {
//                    $.messager.progress({ msg: '正在处理数据，请稍候...' });
//                    //AppendChild(CurSelectData.MenuCode);
//                    //var jQueryAsync = jQuery.ajaxSettings.async;
//                    $.ajaxSettings.async = false;
//                    $('#tbl_MenuCode').treegrid('expandAll', CurSelectData.MenuCode);
//                    $.ajaxSettings.async = true;
//                    $.messager.progress('close');
//                }
            $('#r_datagrid').treegrid("select", obj.id.split("_")[1]);
            //选中节点
            setValue($('#r_datagrid').treegrid("getSelected"), obj);
            //子节点
            setValue($('#r_datagrid').treegrid("getChildren", obj.id.split("_")[1]), obj);
            //父节点,父节点需要考滤有多级父节点的情况和父节点下其他子节点已选的情况。
            SetParentValue($('#r_datagrid').treegrid("getParent", obj.id.split("_")[1]), obj);
        }

        function setValue(TGNode, obj) {
            var idsplit = obj.id.split("_");
            dataColumn = idsplit[2];
            $(TGNode).each(function () {
                this[dataColumn] = (obj.checked == true ? true : false);
                if (dataColumn != "browse" && obj.checked)
                    this["browse"] = true;
                if (dataColumn == "browse" && !obj.checked) {
                    this["add"] = false;
                    this["edit"] = false;
                    this["del"] = false;
                    this["print"] = false;
                    this["myimport"] = false;
                    this["export"] = false;
                    this["check"] = false;
                    this["undo"] = false;

                }
                $('#r_datagrid').treegrid('update', {
                    id: this.menuCode,
                    row: this
                });
            });
        }


        function SetParentValue(TGPNode, obj) {
            if (!TGPNode)
                return;
            var idsplit = obj.id.split("_");
            dataColumn = idsplit[2];
            var TGCNode = $('#r_datagrid').treegrid("getChildren", TGPNode.menuCode);
            if (TGCNode) {
                var objChecked = obj.checked;
                for (i = 0; i < TGCNode.length; i++) {
                    if ((TGCNode[i][dataColumn] == true && !obj.checked)) {
                        obj.checked = (TGCNode[i][dataColumn] == true && !obj.checked);
                        break;
                    }
                }
                setValue(TGPNode, obj);
                obj.checked = objChecked;
                SetParentValue($('#r_datagrid').treegrid("getParent", TGPNode.menuCode), obj)
            }
        }

        function DoSavePower() {
            if(!${roleMenu.isEdit}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }

            if (SaveMenuCode.length == 0) {
                layerInfo('未对数据做任何更改，无需保存!!!');
                return;
            }
            //$.messager.progress({ msg: '正在保存数据，请稍候...' });
            var updated = [];
            // var TGNodes;
            $.each(SaveMenuCode, function (i, n) {
                updated.push($('#r_datagrid').treegrid('find', n));
                //TGNodes = $('#tbl_MenuCode').treegrid("getChildren", n);
                //if (TGNodes)
                //updated = updated.concat(TGNodes);
            });

            for(var i=0;i<updated.length;i++){
                var d = {
                    id:updated[i].id,
                    menuid:updated[i].menuId,
                    menucode:updated[i].menuCode,
                    menuname:'['+ updated[i].menuCode + ']'+ updated[i].menuName,
                    browse:updated[i].browse,
                    add:updated[i].add,
                    edit:updated[i].edit,
                    del:updated[i].del,
                    print:updated[i].print,
                    myimport:updated[i].myimport,
                    export:updated[i].export,
                    check:updated[i].check,
                    undo:updated[i].undo,
                    pmenucode:updated[i].pMenuCode,
                    roleid:roleid
                }
                putChildren(updated[i]);
                rolemenus.push(d);

            }

            var effectRow = new Object();
            effectRow = JSON.stringify(rolemenus);
            //$("#hfPowerData").val(effectRow);
            //$("#btnSavePower").click();
            //alert(effectRow);
            SaveMenuCode = [];
            rolemenus = [];
            $.ajax({
                type:"POST",
                url:"/SysRoleMenu/saveRoleMenu?rdm=" + parseInt(Math.random()*100000),
                dataType:"json",
                contentType:"application/json",
                data:effectRow,
                success:function(data){
                    layerMsg("保存成功！");
                    // $.messager.progress("close");
                },
                error:function(data){
                    layerMsg("保存出错！");
                }
            });



        }


        function putChildren(pMenu){
            for(var n=0;n<pMenu.children.length;n++){
                var dd={
                    id:pMenu.children[n].id,
                    menuid:pMenu.children[n].menuId,
                    menucode:pMenu.children[n].menuCode,
                    menuname:'['+ pMenu.children[n].menuCode + ']'+ pMenu.children[n].menuName,
                    browse:pMenu.children[n].browse,
                    add:pMenu.children[n].add,
                    edit:pMenu.children[n].edit,
                    del:pMenu.children[n].del,
                    print:pMenu.children[n].print,
                    myimport:pMenu.children[n].myimport,
                    export:pMenu.children[n].export,
                    check:pMenu.children[n].check,
                    undo:pMenu.children[n].undo,
                    pmenucode:pMenu.children[n].pMenuCode,
                    roleid:roleid
                }

                putChildren(pMenu.children[n]);
                rolemenus.push(dd);
            }
        }

        function openwin(){
            if(${roleMenu.isAdd}){
                layeropen(600,300,"角色编辑","/V_SysRole/toEdit");
            }
            else{
                layerInfo("没有权限!请找系统管理员申请权限!");
            }
        }
        function refresh(){
            $('#r_datagrid').datagrid('loadData',{total:0,rows:[]});
//            $('#l_datagrid').datagrid('reload');
            loadRole();
        }

        function Del(id){
            // 阻止冒泡
            if ( event && event.stopPropagation ) {
                event.stopPropagation();
            } else{
                window.event.returnValue = false;
            }
            if(${roleMenu.isDel}){
                layerConfirm("是否确定删除?",function(){
                    var url = '${ctx}/SysRole/delete?id='+id;
                    $.ajax({
                        type : 'post',
                        url : url,
                        dataType: "json",
                        success:function(data){
                            if(data.success == true){
                                refresh();
                            }else{
                                alert(data.msg);
                            }
                        }
                    });
                });
            }
            else{
                layerInfo("没有权限!请找系统管理员申请权限!");
            }

        }

        function toUpdate(id){
            // 阻止冒泡
            if ( event && event.stopPropagation ) {
                event.stopPropagation();
            } else{
                window.event.returnValue = false;
            }
            if(${roleMenu.isEdit}){
                var url= '${ctx}/V_SysRole/toEdit?id='+id;
                layeropen(600,300,"角色编辑",url);
            }
            else{
                layerInfo("没有权限!请找系统管理员申请权限!");
            }
        }

        function search() {
            var condition = $('#serach').val();
            var url = '${ctx }/SysRole/findByCondition?condition='+encodeURI(condition) + "&rdm="+ parseInt(Math.random()*100000);
            $('#l_datagrid').datagrid({url:url});
        }

    </script>
</head>
<body>
<div class="navheader form-inline" style="padding:0 5px;height:40px;">
    <div class=" form-group">
        <label for="serach"style="padding:5px 10px 0px 20px;">查询</label>
        <input type="text" id="serach" class="form-control"placeholder="名称、拼音码" />
        <button type="button" class="btn btn-success bi-btn-search" onclick="search()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>
    <div class="btn-group-right">
        <div class="btn-group "  role="group">
            <button type="button" class="btn btn-default bi-btn-width90" onclick="refresh()">刷新</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="openwin()">新增</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="DoSavePower()">保存权限</button>
        </div>
    </div>
</div>

<div style="margin:0 5px; overflow: hidden;" >
    <!--左边表格-->
    <div style="width:30%;float:left;display:inline-block;padding-right:5px;border-right:1px dotted #ccc;" >
        <table id="l_datagrid"class="datagrid"></table>

    </div>
    <!--右边表格 -->
    <div style="width:70%;float:right;display:inline-block;padding-left:5px;">
        <table id="r_datagrid" class="treegrid"></table>
    </div>
</div>
</body>
</html>