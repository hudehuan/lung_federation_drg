<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/7/21
  Time: 13:41
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
        var did = null;
        $(function(){
            var height = findDimensions_height();
            $("#l_datagrid").height(height-50);
            $("#r_datagrid").height(height-50);

//            loadDic();
            $('#l_datagrid').datagrid(
                    {
                        url:'/SysDictionary/getAllDictionary?rdm=' + parseInt(Math.random()*100000),
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        autoRowHeight:false,
                        pagination:true,
                        clientPaging:true,
                        idField: 'did',
                        remoteSort:false,
                        pageSize:14,
                        pageList:[10,14,20,25,30,40,50],
                        columns: [
                            [
                                { field:'did',title:'字典编号',hidden:true},
                                { field: 'dicCode', title: '代码', width: '53px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'dicName', title: '名称', width: '120px', align: 'left',sortable:true, halign: 'center'},
                                { field: 'bz', title: '说明', width: '100px', align: 'left',sortable:true, halign: 'center'},
                                { field: 'operate', title: '操作', width: '75px', align: 'left', sortable:false,halign: 'center',
                                    formatter:function(value,row,index){
                                        var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\' onclick="editDic(\'' + row.did + '\')"><span class=\'glyphicon  glyphicon glyphicon-pencil\'></span></button>';
                                        str+= '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="delDic(\'' + row.did + '\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></button>';
                                        return str;
                                    }
                                }

                            ]
                        ],
                        onClickRow: function(index,row) {
                            did = row.did;
                            var url = '/SysDictionaryItem/getAllDictionaryItemById?did='+row.did+ "&rdm="+ parseInt(Math.random()*100000);
                            $('#dicName').text(row.dicName);
                            loadDicItem(row.did);
                        }
                    }).datagrid('clientPaging');
//                    loadDicItem();
            $('#r_datagrid').datagrid(
                    {
                        url:'',
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        autoRowHeight:false,
                        pagination:true,
                        clientPaging:true,
                        pageSize:15,
                        pageList:[10,15,20,25,30,40,50],
                        columns: [
                            [
                                { field:'itemId',title:'字典项ID',hidden:true},
                                { field: 'xh', title: '序号', width: '40px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'itemCode', title: '代码', width: '100px', align: 'left', sortable:true,halign: 'center'},
                                { field:'did',title:'所属字典ID',hidden:true},
                                { field: 'dicName', title: '名称', width: '200px', align: 'left', sortable:true,halign: 'center'},
                                { field: 'bz', title: '说明', width: '150px', align: 'left',sortable:true, halign: 'center'},
                                { field: 'operate', title: '操作', width: '75px', align: 'left',sortable:false, halign: 'center',
                                    formatter:function(value,row,index){

                                        var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\' onclick="editItem(\'' + row.itemId + '\')"><span class=\'glyphicon  glyphicon glyphicon-pencil\'></span></button>';
                                        str+= '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="delItem(\'' + row.itemId + '\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></button>';
                                        return str;
                                    }
                                }

                            ]
                        ]
                    }).datagrid('clientPaging');
        });

        function loadDic() {
            $('#l_datagrid').datagrid(
                    {
                        url:'/SysDictionary/getAllDictionary?rdm=' + parseInt(Math.random()*100000)
                    });
        }

        function loadDicItem(id) {
            $('#r_datagrid').datagrid(
                    {
                        url:'/SysDictionaryItem/getAllDictionaryItemById?did='+id+ "&rdm="+ parseInt(Math.random()*100000)
                    });
        }

        function editDic(id) {
            // 阻止冒泡
            if ( event && event.stopPropagation ) {
                event.stopPropagation();}
            else{
                window.event.returnValue = false;
            }
            if(${roleMenu.isEdit}){
                layeropen(600, 350, "字典编辑", "${ctx}/V_SysDictionary/toEdit?did="+id);
            }
            else{
                layerInfo("没有权限!请找系统管理员申请权限!");
            }
        }
        function delDic(id) {
            // 阻止冒泡
            if ( event && event.stopPropagation ) {
                event.stopPropagation();
            } else{
                window.event.returnValue = false;
            }
            if(${roleMenu.isDel}){
                layerConfirm("删除字典可能会影响整个系统,是否确定删除?", function () {
                    var url = '${ctx}/SysDictionary/delete?did=' + id;
                    $.ajax({
                        type: 'post',
                        url: url,
                        dataType: "json",
                        success: function (data) {
                            if (data.success == true) {
                                refresh();
                            } else {
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
        function openwinZ(){

            if(${roleMenu.isAdd}){
                layeropen(600,350,"新增字典","${ctx}/V_SysDictionary/toEdit");
            }
            else{
                layerInfo("没有权限!请找系统管理员申请权限!");
            }
        }

        function openwinP(){

            if(${roleMenu.isAdd}){
                if (did != null) {
                    layeropen(600,350,"项目编辑","${ctx}/V_SysDictionaryItem/toEdit?did="+did);
                }else{
                    layerInfo("请选择字典名！")
                }
            }
            else{
                layerInfo("没有权限!请找系统管理员申请权限!");
            }

        }

        function search() {
            var condition = $('#serach').val();
            var url = '${ctx }/SysDictionary/findByCondition?condition='+encodeURI(condition);
            <%--var url2 = '${ctx }/SysDictionaryItem/findByCondition?condition='+encodeURI(condition);--%>
            $('#l_datagrid').datagrid({url:url});
            $('#r_datagrid').datagrid('loadData',{total:0,rows:[]});
        }
        function editItem(id) {
            if(${roleMenu.isEdit}){
                layeropen(600, 350, "数据编辑", "${ctx}/V_SysDictionaryItem/toEdit?itemId="+id+"&did="+did);
            }
            else{
                layerInfo("没有权限!请找系统管理员申请权限!");
            }
        }
        function delItem(id) {
            if(${roleMenu.isDel}){
                layerConfirm("是否确定删除?", function () {
                var url = '${ctx}/SysDictionaryItem/delete?itemId=' + id;
                $.ajax({
                    type: 'post',
                    url: url,
                    dataType: "json",
                    success: function (data) {
                        if (data.success == true) {
                            refresh();
                        } else {
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
        function refresh(){
            loadDic();
            loadDicItem();
//            $('#r_datagrid').datagrid('reload');
//            $('#l_datagrid').datagrid('reload');
        }

    </script>
</head>
<body>
<div class="navheader form-inline" style="padding:0 5px;height:40px;">

    <div class=" form-group">
        <label for="serach"style="padding:5px 10px 0px 20px;">查询</label>
        <input type="text" id="serach" class="form-control"placeholder="名称、代码查询" />
        <button type="button" class="btn btn-success bi-btn-search" onclick="search()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>
    <div style="display:inline-block;float:right;width:70%;">
        <div style="display:inline-block; padding-left: 20px;font-size: 14px;font-weight: 600" id="dicName"></div>
        <%--<div class="form-group">--%>
            <%--<label for="serach"style="padding:5px 10px 0px 20px;">查询</label>--%>
            <%--<input type="text" id="serach1" class="form-control"placeholder="名称、拼音码、代码查询" />--%>
            <%--<button type="button" class="btn btn-success bi-btn-search" onclick="search()">--%>
                <%--<span class="glyphicon glyphicon glyphicon-search"></span>--%>
            <%--</button>--%>
        <%--</div>--%>
        <div class="btn-group-right">
            <div class="btn-group "  role="group">
                <button type="button" class="btn btn-default bi-btn-width90" onclick="refresh()">刷新</button>
                <button type="button" class="btn btn-default bi-btn-width90" onclick="openwinZ()">新增字典</button>
                <button type="button" class="btn btn-default bi-btn-width90" onclick="openwinP()">新增项目</button>
            </div>
        </div>
    </div>

</div>

<div style="margin:0 5px; overflow: hidden; " >
    <!--左边表格-->
    <div style="width:30%;float:left;display:inline-block;padding-right:5px;border-right:1px dotted #ccc;" >
        <table id="l_datagrid"class="datagrid"></table>

    </div>
    <!--右边表格 -->
    <div style="width:70%;float:right;display:inline-block;padding-left:5px;">
        <table id="r_datagrid" class="datagrid"></table>
    </div>
</div>
</body>
</html>
