<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/12/13
  Time: 14:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title></title>
    <script>
        $(function(){
            var height = findDimensions_height();
            $("#l_datagrid").height(height-50);
//            loadMenuList();
            $('#l_datagrid').datagrid(
                    {
                        url:'/sysMenuFunction/getAllFunction?search=&type=&rdm=' + parseInt(Math.random()*100000),
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        autoRowHeight:false,
                        pagination:true,
                        pageSize:15,
                        pageList:[15,20,25,30,40,50],
                        clientPaging:true,
                        columns: [
                            [
                                {field: 'id', title: 'ID', width: '100px', hidden: true},
                                { field: 'xh', title: '序号', width: '50px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'name', title: '类型名称', width: '80px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'type', title: '类型', width: '80px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'hospitelName', title: '医院名称', width: '140px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'url', title: '导入url', width: '80px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'printUrl', title: '打印url', width: '80px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'bz', title: '备注', width: '140px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'operate', title: '操作', width: '80px', align: 'left', halign: 'center',
                                    formatter:function(value,row,index){
                                        var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\' onclick="sele(\'' + row.id + '\')"><span class=\'glyphicon glyphicon glyphicon-ok\'></span></button>';
                                        return str;
                                    }
                                }
                            ]
                        ]
                    }).datagrid('clientPaging');
        })

        function loadMenuList(){
            $('#l_datagrid').datagrid(
                    {
                        url:'/sysMenuFunction/getAllFunction?search=&type=&rdm=' + parseInt(Math.random()*100000)
                    });
        }
        function sele(id){
            $.ajax({
                mehtod: "POST",
                url:"/sysMenuFunction/getById?id="+id,
                dataType:"JSON",
                success:function(data){
                    parent.initData(data);
                    parent.setSelectRead();
                    closeIndexWindwos();
                }
            })
        }

        function search(){
            var search = $("#search").val();
            var type = $("#type").val();
            $('#l_datagrid').datagrid(
                    {
                        url: '/sysMenuFunction/getAllFunction?search='+encodeURI(search)+'&type='+type+'&rdm=' + parseInt(Math.random() * 100000)
                    })

        }
    </script>
</head>
<body>
<div class="navheader form-inline">
    <div class=" form-group">
        <label for="search" style="padding:5px 10px 0px 20px;">查询</label>
        <input type="text" id="search" class="bi-input-serach" placeholder="请输入类型名称"/>
        <label for="type">类型</label>
        <select id="type" style="padding:2px 0px;width:140px;"
                class="bi-width140 form-control">
            <option value="" name="function">全部</option>
            <option value="function" name="function">功能</option>
            <option value="System" name="System">系统</option>
            <option value="sort" name="sort">分类</option>
            <option value="BI" name="BI">BI图表</option>
            <option value="BIolap" name="BIolap">BIolap</option>
            <option value="comment" name="comment">BI评价方案</option>
            <option value="report" name="report">BI分析报告</option>
            <option value="form" name="form">自定义表单</option>
            <option value="excel" name="excel">Excel导入</option>
        </select>
        <button type="button" class="btn btn-success bi-btn-search" onclick="search()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>
</div>

<div style="margin:0 5px; overflow: hidden;" >
    <div style="width:100%;float:left;display:inline-block;padding-right:5px;border-right:1px dotted #ccc;" >
        <table id="l_datagrid" class="datagrid"></table>

    </div>
</div>
</body>
</html>
