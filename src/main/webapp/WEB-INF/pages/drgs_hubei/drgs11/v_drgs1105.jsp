<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/08/25
  Time: 10:19
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <%@ include file="/common/meta.jsp" %>
    <title>${titlename}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">


    <script>
        $(function () {
            var height = findDimensions_height();
            $("#table1").height(height-50);
            loadTable();

        })

        function loadTable(){
            $('#table1').datagrid(
                {
                    url: "${ctx}/hubei/Drgs1105/getYkssList?rdm=" + parseInt(Math.random() * 100000),
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
                            {field: 'id', title: 'ID', hidden: true},
                            {field: 'name', title: '名称', width:"100",align:"left",sortable:true, halign: 'center' },
                            {field: 'status', title: '状态', width:"60",align:"left",sortable:true, halign: 'center' },
                            {field: 'year', title: '年度', width:"100",align:"left",sortable:true, halign: 'center' },
                            {field: 'address', title: '地区', width:"100",align:"left",sortable:true, halign: 'center' },
                            {field: 'ckqz', title: '参考权重', width:"100",align:"left",sortable:true, halign: 'center' },
                            {field: 'yjqz', title: '预计权重', width:"100",align:"left",sortable:true, halign: 'center' },
                            {field: 'fffl', title: '支付费率', width:"200",align:"left",sortable:true, halign: 'center' },
//                            {field: 'zed', title: '总额度公式', width:"200",align:"center"},
                            { field: 'operate', title: '操作', width: '180px', align: 'left', halign: 'center',
                                formatter:function(value,row,index){
                                    var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\' onclick="gsck(\'' + row.id + '\')"><span >总额度公式查看</span></button>';
                                    str+= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\' onclick="editData(\''+row.id+'\')"><span class=\'glyphicon glyphicon-pencil\'></span></button>';
                                    str+= '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="delData(\''+row.id+'\')"><span class=\'glyphicon  glyphicon-remove\'></span></button>';
                                    return str;
                                }
                            }
                        ]
                    ]
                }).datagrid('clientPaging');
        }



        function refresh(){
            $('#table1').datagrid(
                {
                    url: "${ctx}/hubei/Drgs1105/getYkssList?rdm=" + parseInt(Math.random() * 100000),
                });
        }

        function addData(){
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(0.6*width,height-50,'内容编辑','/hubei/V_Drgs1105/toEdit');
        }

        function delData(id){
            layerConfirm("是否确定删除?", function () {
                var url = '/hubei/Drgs1105/ykssDel?id=' + id;
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

        function editData(id){
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(0.6*width,height-50,'内容编辑','/hubei/V_Drgs1105/toEdit?id='+id);
        }
        function gsck(id){
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(0.6*width,height-50,'总额度公式','/hubei/V_Drgs1105/to_2List?id='+id);
        }

        function search(){
            var serach = $("#serach").val();
            $('#table1').datagrid(
                {
                    url: "${ctx}/hubei/Drgs1105/findYkssListBySearch?search="+serach+"&rdm=" + parseInt(Math.random() * 100000),
                });
        }
    </script>

</head>
<body style="height: 98%">
<div style="position: absolute;background: #000;width: 100%;height: 100%;z-index: 10000;opacity: 0.5;">
    <p style="color: #fff;margin-top: 200px;text-align: center;font-size: 26px;">该用户无权使用</p>
</div>
<%--<div class="navheader form-inline" style="padding:0 5px;height:40px;">

    <div class=" form-group">
        <label for="serach"style="padding:5px 10px 0px 20px;">查询</label>
        <input type="text" id="serach" class="form-control"placeholder="名称、拼音码、代码查询" />
        <button type="button" class="btn btn-success bi-btn-search" onclick="search()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>
    <div class="btn-group-right">
        <div class="btn-group "  role="group">
            <button type="button" class="btn btn-default bi-btn-width90" onclick="refresh()">刷新</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="addData()">新增</button>
        </div>
    </div>
</div>
<div style="padding:0 5px;" id>
    <table id="table1" class="datagrid" ></table>
</div>--%>
</body>
</html>
