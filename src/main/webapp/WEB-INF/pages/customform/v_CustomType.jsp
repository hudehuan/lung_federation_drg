<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2017/4/20
  Time: 17:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<html lang="en">
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>表单分类</title>


    <script>
        var selectid=null;//选中的参数id
        var selectindex=0;
        $(function () {
            var height = findDimensions_height();
            $("#l_datagrid").height(height - 50);
            loadCustomType();

            $("#r_datagrid").height(height-50);
            loadCustomFormType();
        });

        function loadCustomType() {
            $('#l_datagrid').datagrid(
                {
                    url: '/CustomType/getAllCustomType?rdm=' + parseInt(Math.random()*100000),
                    method: 'get',
                    rownumbers: true,
                    singleSelect: true,
                    autoRowHeight: false,
                    pagination: true,
                    clientPaging: true,
                    idField: 'id',
                    pageSize: 15,
                    pageList: [10, 15, 20, 25, 30, 40, 50],
                    remoteSort:false,
                    columns: [
                        [
                            {field: 'id', title: 'ID', width: '100px', hidden: true},
                            { field: 'xh', title: '序号', width: '30px', align: 'left',sortable:true, halign: 'center' },
                            {field: 'name', title: '分类名称', width: '120px', align: 'left',sortable:true, halign: 'center'},
                            {field: 'sm', title: '说明', width: '120px', align: 'left',sortable:true, halign: 'center'},
                            {
                                field: 'operate', title: '操作', width: '75px', align: 'left', halign: 'center',
                                formatter: function (value, row, index) {
                                    var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\' onclick="editCustomType(\'' + row.id + '\')"><span class=\'glyphicon  glyphicon glyphicon-pencil\'></span></button>';
                                    str+= '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="del(\'' + row.id + '\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></button>';
                                    return str;
                                }
                            }

                        ]
                    ],
                    onSelect : function(index, row){
                        selectid=row.id;
                        selectindex=index;
                        reLoadCustomFormType(row.id);
                    }
                }).datagrid('clientPaging');

        };


        function loadCustomFormType(){
            $('#r_datagrid').datagrid(
                {
                    url:"",
                    method:'get',
                    rownumbers:true,
                    singleSelect:true,
                    autoRowHeight:false,
                    idField: 'id',
                    pagination: true,
                    clientPaging: true,
                    pageSize: 15,
                    pageList: [10, 15, 20, 25, 30, 40, 50],
                    columns: [
                        [
                            {field: 'formTypeId', title: 'formTypeId', width: '100px', hidden: true},
                            {field: 'formId', title: 'formId', width: '100px', hidden: true},
                            { field: 'xh', title: '序号', width: '50px', align: 'left',sortable:true, halign: 'center' },
                            { field: 'name', title: '表单名称', width: '180px', align: 'left',sortable:true, halign: 'center' },
                            { field: 'code', title: '表单编码', width: '160px', align: 'left',sortable:true, halign: 'center' },
                            { field: 'sm', title: '说明', width: '200px', align: 'left',sortable:true, halign: 'center' },
                            { field: 'operate', title: '操作', width: '80px', align: 'left', halign: 'center',
                            formatter:function(value,row,index){
                                var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\'onclick="editCustomFormType(\''+row.formTypeId+'\')" ><span class=\'glyphicon  glyphicon glyphicon-pencil\'></span></button>';
                                str+= '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="deleteCustomFormType(\''+row.formTypeId+'\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></button>';
                                return str;
                            }
                        }
                        ]
                    ]
                }).datagrid('clientPaging');
        }


        function reLoadCustomType(){
            $('#l_datagrid').datagrid(
                    {
                        url: '/CustomType/getAllCustomType?rdm=' + parseInt(Math.random()*100000)
                    });
        }

        function reLoadCustomFormType(typeId){
            $('#r_datagrid').datagrid(
                    {
                        url:'/CustomFormType/getFormByTypeID?typeId=' + typeId +'&rdm=' + parseInt(Math.random()*100000)
//                        url:'/CustomForm/getFormByTypeID?typeId=' + typeId +'&rdm=' + parseInt(Math.random()*100000)
                    });
        }

        function dorefresh(){
            reLoadCustomType();
            selectid = null;
            $('#r_datagrid').datagrid('loadData',{total:0,rows:[]});
        }

        function addCustomType(){
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(0.45*width,height-200, "数据编辑","${ctx}/v_customformtype/toEdit");
        }

        function editCustomType(typeId){
            if(!typeId){
                typeId = "";
            }
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(0.45*width,height-200, "数据编辑","${ctx}/v_customformtype/toEdit?typeId="+typeId);
        }

        function editCustomFormType(formTypeId){
                if(selectid!=null){
                    if(!formTypeId){
                        formTypeId = "";
                    }
                    var height = findDimensions_height();
                    var width = findDimensions_width();
                    layeropen(0.45*width,height-50, "数据编辑", "${ctx}/v_customformtabletype/toEdit?typeId="+selectid+"&formTypeId="+formTypeId);
                }else{
                    layerError("请选择分类！");
                }
        }

        function addCustomForm(){
            if(selectid!=null){
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(0.45*width,height-50, "数据编辑", "${ctx}/v_customformtabletype/toEdit?typeId="+selectid);
            }else{
                layerError("请选择分类！");
            }

        }

        function deleteCustomFormType(formTypeId){
            layerConfirm("是否确定删除?", function () {
                var url = '${ctx}/CustomFormType/delete?formTypeId=' + formTypeId;
                $.ajax({
                    type: 'post',
                    url: url,
                    dataType: "json",
                    success: function (data) {
                        if (data.success == true) {
                            reLoadCustomFormType(selectid);
                            layerSuccess(data.msg);
                        } else {
                            layerError(data.msg);
                        }
                    }
                });
            });
        }



    </script>
</head>
<body>


<div class="navheader form-inline" style="height: 40px">
    <div class=" form-group">
        <label for="serach" style="padding:5px 10px 0 20px;">查询</label>
        <input type="text" id="serach" class="form-control" placeholder="名称、拼音码、代码查询"/>
        <button type="button" class="btn btn-success bi-btn-search" onclick="searchBtn()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>
    <div class="btn-group-right">
        <div class="btn-group " role="group">
            <button type="button" class="btn btn-default bi-btn-width90" onclick="dorefresh()">刷新</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="addCustomType()">新增分类</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="addCustomForm()">新增表单</button>
        </div>
    </div>
</div>
<%--<div  style="padding:0 5px;">--%>
    <%--<table id="gridtable" class="gridtable" style="width:100%;">--%>

    <%--</table>--%>
<%--</div>--%>
<div style="margin:0 5px; overflow: hidden;" >
    <!--左边表格-->
    <div style="width:30%;float:left;display:inline-block;padding-right:5px;border-right:1px dotted #ccc;" >
        <table id="l_datagrid" class="datagrid"></table>

    </div>
    <!--右边表格 -->
    <div style="width:69%;float:left;display:inline-block;padding-left:5px;">
        <table id="r_datagrid" class="datagrid">
            <!--右边表格未定义-->
        </table>
    </div>
</div>


</body>
</html>
