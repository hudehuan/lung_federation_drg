<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/07/31
  Time: 16:26
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
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
            $("#gridtable").height(height-50);
            loadList();

        })

        function loadList() {
            $('#gridtable').datagrid(
                {
                    url:'/DicCm3Define/getList?search=&rdm='+ parseInt(Math.random()*100000),
                    method:'get',
                    rownumbers:true,
                    singleSelect:true,
                    autoRowHeight:false,
                    pagination:true,
                    clientPaging:true,
                    remoteSort:false,
                    pageSize:15,
                    pageList:[10,15,20,25,30,40,50],
                    columns: [
                        [
                            { field:'id',title:'ID',width:'100px',hidden:true},
                            { field: 'cm3Dm', title: '系统cm3编码', width: '100px', align: 'left',sortable:true,  halign: 'center'},
                            { field: 'cm3Mc', title: '系统cm3名称', width: '100px', align: 'left',sortable:true, halign: 'center'},
                            { field: 'code', title: '对照编码', width: '100px', align: 'left',sortable:true,  halign: 'center'},
                            { field: 'type', title: '编码类型', width:'100px', align: 'left',sortable:true, halign: 'center'},
                            { field: 'sm', title: '说明', width: '100px', align: 'left',sortable:true,  halign: 'center'},
                            { field: 'operate', title: '操作', width: '75px', align: 'left', halign: 'center',
                                formatter:function(value,row,index){
                                    var str= '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' ' +
                                        'onclick="del(\'' + row.id + '\')">' +
                                        '<span class=\'glyphicon glyphicon glyphicon-remove\'></span></button>';
                                    return str;
                                }
                            }
                        ]
                    ]
                }).datagrid('clientPaging');
        }

        function reLoadList() {
            search();
        }

        function toAdd() {
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(0.45*width,height-100, "数据编辑", "/V_DicCm3Define/toEdit");
        }

        function del(id) {
            layerConfirm("是否确定删除?", function () {
                var url = '${ctx}/DicCm3Define/del?id=' + id;
                $.ajax({
                    type: 'post',
                    url: url,
                    dataType: "json",
                    success: function (data) {
                        if (data.success == true) {
                            reLoadList();
                        } else {
                            alert(data.msg);
                        }
                    }
                });
            });
        }
        function search(){
            var search = $("#search").val();
            $('#gridtable').datagrid(
                {
                    url:'/DicCm3Define/getList?search='+encodeURI(search)+'&rdm='+ parseInt(Math.random()*100000)
                })
        }


    </script>
</head>
<body>

<div class="navheader form-inline" style="padding:0 5px; height:40px;">
    <div class=" form-group">
        <label for="search"style="padding:5px 10px 0px 20px;">查询</label>
        <input type="text" id="search" class="form-control"placeholder="" />
        <button type="button" class="btn btn-success bi-btn-search" onclick="search()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>
    <div class="btn-group-right">
        <div class="btn-group "  role="group">
            <button type="button" class="btn btn-default bi-btn-width90" onclick="toAdd()">新增</button>
        </div>
    </div>
</div>

<div style="padding:0  5px;">
    <table id="gridtable"  style="width:100%;" >
    </table>
</div>

</body>
</html>
