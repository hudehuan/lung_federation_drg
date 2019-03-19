<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2017/1/24
  Time: 13:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title></title>
    <script>
        var MenuTreeData;
        $(function(){

            var height = findDimensions_height();
            $("#l_datagrid").height(height-40);
            $("#menu1").height(height -30);
            loadMenuList();
        })

        function loadMenuList(){
            $('#l_datagrid').datagrid(
                    {
                        url:'/sysMenuTemplate/getAllMenuTemplate?search=&rdm=' + parseInt(Math.random()*100000),
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        autoRowHeight:false,
                        idField: 'tid',
                        pagination: true,
                        clientPaging: true,
                        pageSize: 15,
                        pageList: [10, 15, 20, 25, 30, 40, 50],
                        columns: [
                            [
                                {field: 'tid', title: 'ID', width: '100px', hidden: true},
                                { field: 'name', title: '医院名称', width: '280px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'operate', title: '操作', width: '195px', align: 'left', halign: 'center',
                                    formatter:function(value,row,index){
                                        var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\'onclick="sele(\''+row.tid+'\')" ><span class=\'glyphicon  glyphicon glyphicon-pencil\'></span></button>';
                                        str+= '<button type=\'button\' class=\'btn btn-danger  bi-glyphicon\' onclick="removeRow(\''+row.tid+'\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></button>';
                                        return str;
                                    }
                                }
                            ]
                        ],
                        onSelect : function(index, row){
                            loadTree(row.tid);
                        }
                    }).datagrid('clientPaging');
        }
        function sele(tid){
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(0.4*width,height-300,'模板保存',"/V_SysMenuTemplate/toSaveMune?id="+tid);
        }
        function removeRow(tid){
            layerConfirm("是否确定删除?", function () {
                var url = '/sysMenuTemplate/delete?tid='+tid ;
                $.ajax({
                    type: 'post',
                    url: url,
                    dataType: "json",
                    success: function (data) {
                        $('#menu1').tree('loadData',{total:0,rows:[]});
                        $('#l_datagrid').datagrid(
                                {
                                    url: '/sysMenuTemplate/getAllMenuTemplate?search=&rdm=' + parseInt(Math.random() * 100000)
                                })
                    }
                });
            });
        }

        function search(){
            var search = $("#search").val();
            var type = $("#type").val();
            $('#l_datagrid').datagrid(
                    {
                        url: '/sysMenuTemplate/getAllMenuTemplate?search='+encodeURI(search)+'&rdm=' + parseInt(Math.random() * 100000)
                    })

        }

        function loadTree(tid) {
            var url = "/sysMenuTemplate/getAllMenu?tid="+tid;
            var height = findDimensions_height();
            $("#gridtable").height(height - 50);
            $("#menu1").height(height *0.91- 35);
            $("#menu1_warp").height(height *0.91);
            $('#menu1').tree({
                method: "get",
                animate: true,
                url:url,
                data: MenuTreeData,
                onDblClick: function(node) {
//                    $(this).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
//                    node.state = node.state === 'closed' ? 'open' : 'closed';
//                    var str = node.text.match(/\[(\S*)\]/)[1];
//                    if(str.length==9){
                        showSelectedSurveryDataOnMap(node.id);
//                    }
                }
//                onClick: function (node) {
//                    gotoUpdate(node.id);
//                    LoadCurrentMenu(node.id);
//                }
            });
        }

        function showSelectedSurveryDataOnMap(id){
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(0.55*width,height-50,'模板预览',"/V_SysMenuTemplate/toSysFunctionMenuView?id="+id);
        }
    </script>
</head>
<body>
<div class="navheader form-inline">
    <div class=" form-group">
        <label for="search" style="padding:5px 10px 0px 20px;">查询</label>
        <input type="text" id="search" class="bi-input-serach" placeholder="请输入模板名称"/>
        <button type="button" class="btn btn-success bi-btn-search" onclick="search()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>
</div>
<div style="margin:0 5px; overflow: hidden;" >
    <div style="width:40%;float:left;display:inline-block;padding-right:5px;border-right:1px dotted #ccc;" >
        <table id="l_datagrid" class="datagrid"></table>

    </div>
    <!--树形菜单-->
    <div style="width:60%;float:left;display:inline-block; padding:20px 0 0 20px; overflow:auto; ">

        <ul id="menu1" class="easyui-tree"></ul>

    </div>

</div>
</body>
</html>
