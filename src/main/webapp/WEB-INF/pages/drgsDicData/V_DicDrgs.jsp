<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/08/01
  Time: 15:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <script>

        $(function () {
            var height = findDimensions_height();
            $("#l_datagrid").height(height-50);
            $("#r_datagrid1").height(height/2-30);
            $("#r_datagrid2").height(height/2-30);
            loadMdc();
            loadDrgs();
            loadLikeDrgs();

        })
        function loadMdc() {
            $('#l_datagrid').datagrid(
                {
                    url:'/DicMdc/getList?search=&rdm='+ parseInt(Math.random()*100000),
                    method:'get',
                    rownumbers:true,
                    singleSelect:true,
                    autoRowHeight:false,
                    clientPaging:true,
                    remoteSort:false,
                    columns: [
                        [
                            { field: 'xh', title: '序号', width: '40px', align: 'left',sortable:true,  halign: 'center'},
                            { field: 'dm', title: '代码', width: '60px', align: 'left',sortable:true, halign: 'center'},
                            { field: 'mc', title: '名称', width: '260px', align: 'left',sortable:true,  halign: 'center'},
                        ]
                    ],
                    onSelect:function (value, row, index) {
                        reLoadDrgs(row.dm);
                    }
                });
        }
        function loadDrgs() {
            $('#r_datagrid1').datagrid(
                {
                    url:'',
                    method:'get',
                    rownumbers:true,
                    singleSelect:true,
                    autoRowHeight:false,
                    clientPaging:true,
                    remoteSort:false,
                    columns: [
                        [
                            { field: 'xh', title: '序号', width: '40px', align: 'left',sortable:true,  halign: 'center'},
                            { field: 'dm', title: '代码', width: '60px', align: 'left',sortable:true, halign: 'center'},
                            { field: 'mc', title: '名称', width: '260px', align: 'left',sortable:true,  halign: 'center'},
                        ]
                    ],
                    onSelect:function (value, row, index) {
                        reLoadLikeDrgs(row.dm);
                    }
                });
        }
        function reLoadDrgs(dm) {
            $('#r_datagrid1').datagrid(
                {
                    url:'/DicDrgs/findByMdc?dm='+dm+'&rdm='+ parseInt(Math.random()*100000)
                });
        }
        function loadLikeDrgs(dm) {
            $('#r_datagrid2').datagrid(
                {
                    url:'',
                    method:'get',
                    rownumbers:true,
                    singleSelect:true,
                    autoRowHeight:false,
                    clientPaging:true,
                    remoteSort:false,
                    columns: [
                        [
                            { field: 'xh', title: '序号', width: '40px', align: 'left',sortable:true,  halign: 'center'},
                            { field: 'dm', title: '代码', width: '60px', align: 'left',sortable:true, halign: 'center'},
                            { field: 'mc', title: '名称', width: '260px', align: 'left',sortable:true,  halign: 'center'},
                        ]
                    ]
                });
        }
        function reLoadLikeDrgs(dm) {
            $('#r_datagrid2').datagrid(
                {
                    url:'/DicDrgs/findByDmLike3?dm='+dm+'&rdm='+ parseInt(Math.random()*100000)
                });
        }

        function search() {
            var search = $("#search").val();
            $('#l_datagrid').datagrid(
                {
                    url: '/DicMdc/getList?search='+encodeURI(search)+'&rdm=' + parseInt(Math.random() * 100000)
                });
        }
    </script>
</head>
<body>

<div class="navheader form-inline" style="padding:0 5px;height:40px;">
    <div class=" form-group">
        <label for="search"style="padding:5px 10px 0px 20px;">drgs分组：</label>
        <input type="text" id="search" class="bi-input-serach" placeholder="代码、名称"/>
        <button type="button" class="btn btn-success bi-btn-search" onclick="search()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>
</div>

<div style="margin:0 5px; overflow: hidden;" >
    <!--左边表格-->
    <div style="width:35%;float:left;display:inline-block;padding-right:5px;border-right:1px dotted #ccc;" >
        <table id="l_datagrid" class="datagrid"></table>
    </div>
    <!--右边表格 -->
    <div style="width:65%;float:right;display:inline-block;padding-left:5px;">
        <%--<div style="padding:0 0 5px 0;border-bottom:1px dotted #ccc;">--%>
        <div style="overflow: hidden;">
            <div style="width:100%;float:left;display:inline-block;padding-right:5px;border-right:1px dotted #ccc;" >
                <table id="r_datagrid1" class="datagrid">
                </table>
            </div>
        </div>
        <div style="overflow: hidden;">
            <div style="width:100%;float:left;display:inline-block;padding-right:5px;border-right:1px dotted #ccc;" >
                <table id="r_datagrid2" class="datagrid">
                </table>
            </div>
            <!--右边表格 -->
        </div>
    </div>
</div>
</body>
</html>
