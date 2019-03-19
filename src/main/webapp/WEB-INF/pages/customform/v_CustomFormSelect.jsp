<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/5/26
  Time: 16:31
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
            loadForm();

        })

        function loadForm(){
            $('#l_datagrid').datagrid(
                    {
                        url:'/CustomForm/getAllCustomForm?rdm=' + parseInt(Math.random()*100000),
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        autoRowHeight:false,
                        idField: 'id',
//                        pagination: true,
//                        clientPaging: true,
//                        pageSize: 15,
//                        pageList: [10, 15, 20, 25, 30, 40, 50],
                        columns: [
                            [
                                {field: 'id', title: 'ID', width: '100px', hidden: true},
                                { field: 'name', title: '表单名称', width: '200px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'code', title: '表单编码', width: '160px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'operate', title: '操作', width: '40px', align: 'left', halign: 'center',
                                    formatter:function(value,row,index){
                                        var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\' onclick="addFormType(\'' + row.id + '\',\'' + row.name + '\')"><span class=\'glyphicon  glyphicon glyphicon-ok\'></span></button>';

                                        return str;
                                    }
                                }
                            ]
                        ],
                        onSelect : function(index, row){

                        }
                    });
        }

        function addFormType(formId,formName){
            parent.addFormType(formId,formName);
            closeIndexWindwos();
                <%--layerConfirm("确定添加表单？",function() {--%>
                    <%--$.ajax({--%>
                        <%--method: "POST",--%>
                        <%--dataType:"JSON",--%>
                        <%--url: "/CustomForm/addFormType?formId="+formId+"&typeId=${typeId}",--%>
                        <%--success: function(data){--%>
                            <%--if(data.success == true){--%>
                                <%--parent.reLoadCustomFormType('${typeId}');--%>
                                <%--layerMsg(data.msg);--%>
                            <%--}else{--%>
                                <%--layerMsg(data.msg);--%>
                            <%--}--%>
                        <%--}--%>
                    <%--})--%>
                <%--});--%>

        }

        function search(){
            var serach = $("#serach").val();
            $('#l_datagrid').datagrid(
                {
                    url: '/CustomForm/findBySearch?searchForm='+encodeURI(serach)+'&rdm=' + parseInt(Math.random() * 100000)
                })


        }

    </script>


</head>
<body>
<div class="navheader form-inline" style="padding:0 5px;height:40px;">
    <div class=" form-group">
        <label for="serach" style="padding:5px 10px 0px 20px;">表单查询</label>
        <input type="text" id="serach" class="bi-input-serach" placeholder="请输入表单名称"/>
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
