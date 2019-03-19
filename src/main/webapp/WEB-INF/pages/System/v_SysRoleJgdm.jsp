<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/08/08
  Time: 10:47
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
        //保存需要更新的顶级菜单ID
        var SaveJgdmCode = [];

        var roleJgdm = [];

        var roleid = null;
        $(function(){
            var height = findDimensions_height();
            $("#l_datagrid").height(height-50);
            loadRole();

            $("#r_datagrid").height(height-50);
            loadRoleJgdm();

        });
        function  loadRole() {
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
                            { field: 'name', title: '名称', width: '150px', align: 'left', sortable:true,halign: 'center'}
                        ]
                    ],
                    onClickRow: function(index,row) {
                        var id = row.id;
                        roleid = id;
                        reLoadRoleJgdm(id);
                    }
                });
        }

        function loadRoleJgdm() {
            $('#r_datagrid').treegrid({
                method: 'get',
                url:'',
                rownumbers: true,
                animate: true,
                collapsible: true,
                fitColumns: true,
                idField: 'jgdm',
                treeField: 'jgmc',
                columns: GetGridColumn(),
                onLoadSuccess: function (row, data) {

                }
            });
        }
        function GetGridColumn() {
            return [[
                { field: 'id', title: '编号', hidden: true },
                { field: 'jgdm', title: '机构编码', hidden: true },
                { field: 'jgmc', title: '机构名称', width: '350px' ,align: 'left', halign: 'center' },
                { field: 'browse', title: '查看', width: '30px', align: 'center',halign: 'center',
                    formatter:function (value, rec, index) { return GetCheckBox(value, rec, index, "browse") }}
            ]]
        }
        function reLoadRole() {
            $('#l_datagrid').datagrid(
                {
                    url:'/SysRole/getAllRole?rdm='+ parseInt(Math.random()*100000)
                });
        }

        function reLoadRoleJgdm(roleid){
            $('#r_datagrid').treegrid({
                method: 'get',
                url:'/SysRoleJgdm/getJgdmByRoleID?roleId='+ roleid+ "&rdm="+ parseInt(Math.random()*100000)
            });
        }
        function GetCheckBox(value, rec, index, Id) {
            var isCheck = rec[Id] == true ? "Checked" : "";
            var strHTML = "<input id='Chk_" + rec.jgdm+"_" + Id + "' onclick='checkValue(this,\""+rec.pJgdm+"\")' type='checkbox' " + isCheck + " />";
            return strHTML;
        }

        function checkValue(obj,p) {
            var CurSelectData = $('#r_datagrid').treegrid('find', obj.id.split("_")[1]);
            var num=0;
            if(p){
                p = p.toString();
                $("input[type='checkbox']").each(function(){
                    var menuId = $(this).attr("id");
                    if(this.checked == true&&menuId.indexOf(p)<0){
                        num++;
                    }
                });
                if(num>20){
                    $("#"+obj.id).attr("checked",false);
                    alert("最多只能选20个！");
                    return;
                }
            }else {
                p = obj.id.split("_")[1]+"";
                $.each(SaveJgdmCode, function (i, n) {
                   var isc = false;
                    var a = $('#r_datagrid').treegrid('find', n);
                    $.each(a.children, function (i, n) {
                        if(this.browse == false && a.jgdm != p){
                            isc = true ;
                            return false;
                        }
                    });
                    if(isc){
                        removeChildren(a,obj);
                    }
                });
            }
            if (SaveJgdmCode.indexOf(p) == -1){
                SaveJgdmCode.push(p);
            }

            $('#r_datagrid').treegrid("select", obj.id.split("_")[1]);
            //选中节点
            setValue($('#r_datagrid').treegrid("getSelected"), obj);
            //子节点
            setValue($('#r_datagrid').treegrid("getChildren", obj.id.split("_")[1]), obj);
            //父节点,父节点需要考滤有多级父节点的情况和父节点下其他子节点已选的情况。
            SetParentValue($('#r_datagrid').treegrid("getParent", obj.id.split("_")[1]), obj);

        }
        function removeChildren(pMenu,obj){
            var id= obj.id.replace(obj.id.split("_")[1],pMenu.jgdm);
            $("#"+id).attr("checked",false);
            $.each(pMenu.children,function(index,item){
                var id= obj.id.replace(obj.id.split("_")[1],this.jgdm);
                $("#"+id).attr("checked",false);
                removeChildren(item,obj);
            })
        }

        function setValue(TGNode, obj) {
            var idsplit = obj.id.split("_");
            dataColumn = idsplit[2];
            $(TGNode).each(function () {
                this[dataColumn] = (obj.checked == true ? true : false);
                if (dataColumn != "browse" && obj.checked)
                    this["browse"] = true;

                $('#r_datagrid').treegrid('update', {
                    id: this.jgdm,
                    row: this
                });
            });
        }
        function SetParentValue(TGPNode, obj) {
            if (!TGPNode)
                return;
            var idsplit = obj.id.split("_");
            dataColumn = idsplit[2];
            var TGCNode = $('#r_datagrid').treegrid("getChildren", TGPNode.jgdm);
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
                SetParentValue($('#r_datagrid').treegrid("getParent", TGPNode.jgdm), obj)
            }
        }


        function refresh(){
            $('#r_datagrid').datagrid('loadData',{total:0,rows:[]});
            reLoadRole();
        }

        function DoSavePower() {
            if(!${roleMenu.isEdit}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }
            if (SaveJgdmCode.length == 0) {
                layerInfo('未对数据做任何更改，无需保存!!!');
                return;
            }
            var updated = [];
            $.each(SaveJgdmCode, function (i, n) {
                var a = $('#r_datagrid').treegrid('find', n);
                updated.push($('#r_datagrid').treegrid('find', n));
            });

            for(var i=0;i<updated.length;i++){
                var d = {
                    id:updated[i].id,
                    jgdm:updated[i].jgdm,
                    jgmc:updated[i].jgmc,
                    browse:updated[i].browse,
                    roleid:roleid
                }
                putChildren(updated[i]);
                if(updated[i].pJgdm){
                    if (roleJgdm.indexOf(updated[i]) == -1)
                    roleJgdm.push(d);
                }

            }

            var effectRow = new Object();
            effectRow = JSON.stringify(roleJgdm);
            SaveJgdmCode = [];
            roleJgdm = [];
            $.ajax({
                type:"POST",
                url:"/SysRoleJgdm/saveRoleJgdm?rdm=" + parseInt(Math.random()*100000),
                dataType:"json",
                contentType:"application/json",
                data:effectRow,

                success:function(data){
                    reLoadRoleJgdm(roleid);
                    layerMsg("保存成功！");
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
                    jgdm:pMenu.children[n].jgdm,
                    jgmc:pMenu.children[n].jgmc,
                    browse:pMenu.children[n].browse,
                    roleid:roleid
                }
                putChildren(pMenu.children[n]);
                if (roleJgdm.indexOf(pMenu.children[n]) == -1)
                roleJgdm.push(dd);
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
            <%--<button type="button" class="btn btn-default bi-btn-width90" onclick="openwin()">新增</button>--%>
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
</body>
</html>
