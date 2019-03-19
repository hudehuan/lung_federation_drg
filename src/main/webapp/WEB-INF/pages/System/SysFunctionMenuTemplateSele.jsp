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
            $("#l_datagrid").height(height-50);
            $("#menu1").height(height *0.91- 35);
//            loadMenuList();
            $('#l_datagrid').datagrid(
                    {
                        url:'/sysMenuTemplate/getAllMenuTemplate?search=&rdm=' + parseInt(Math.random()*100000),
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        autoRowHeight:false,
                        columns: [
                            [
                                {field: 'tid', title: 'ID', width: '100px', hidden: true},
                                { field: 'name', title: '医院名称', width: '210px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'operate', title: '操作', width: '85px', align: 'left', halign: 'center',
                                    formatter:function(value,row,index){
                                        var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\' onclick="sele(\'' + row.tid + '\')"><span class=\'glyphicon glyphicon glyphicon-ok\'></span></button>';
                                        return str;
                                    }
                                }
                            ]
                        ],
                        onSelect : function(index, row){
                            loadTree(row.tid);
                        }
                    });
        })

        function loadMenuList(){
            $('#l_datagrid').datagrid(
                    {
                        url:'/sysMenuTemplate/getAllMenuTemplate?search=&rdm=' + parseInt(Math.random()*100000)
                    });
        }
        function sele(tid){
            layerConfirm("是否确定选择模板?", function () {
                $.ajax({
                    mehtod: "POST",
                    url:"/sysMenuTemplate/saveMenu?tid="+tid,
                    dataType:"JSON",
                    success:function(data){
                        if (data.success == false) {
                            layerError(data.msg);
                            // closeIndexWindwos();
                        }
                        else {
                            layerSuccess("成功", function () {
                                var url = '/sysMenu/getAllMenu?='+ parseInt(Math.random()*100000);
                                parent.loadTree(url);

                                //关闭窗体
                                closeIndexWindwos();
                            });
                        }
                    }
                })
            })

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
                data: MenuTreeData

//                onClick: function (node) {
//                    gotoUpdate(node.id);
//                    LoadCurrentMenu(node.id);
//                }
            });
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
