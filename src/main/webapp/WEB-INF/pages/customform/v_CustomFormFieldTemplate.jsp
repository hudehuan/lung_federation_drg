<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2017/4/20
  Time: 17:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>Title</title>


    <script>
        //主表增加的
        var selectidMain=null;//选中的参数id


        $(function(){
            var height = findDimensions_height();
            $("#gridtable").height(height-50);
            loadForm();





        });

        function loadForm() {
            $('#gridtable').datagrid(
                {
                    url:'CustomFormFieldTemplategetAllPropertiesByTemplateId?templateId=${templateId}&rdm=' + parseInt(Math.random()*100000),
                    method:'get',
                    rownumbers:true,
                    singleSelect:true,
                    autoRowHeight:false,
                    columns: [
                        [
                            {field: 'id', title: 'ID', width: '100px', hidden: true},
                            { field: 'fieldCode', title: '字段编码', width: '160px', align: 'left',sortable:true, halign: 'center' },
                            { field: 'fieldZhname', title: '字段名称', width: '160px', align: 'left',sortable:true, halign: 'center' },
                            { field: 'operate', title: '操作', width: '120px', align: 'left', halign: 'center',
                                formatter:function(value,row,index){
                                    var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\' onclick="editform(\'' + row.id + '\')"><span class=\'glyphicon  glyphicon glyphicon-pencil\'></span></button>';
                                    str+= '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="delform(\''+row.id+'\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></button>';

                                    return str;
                                }
                            }
                        ]
                    ],
                    onSelect : function(index, row){
                        selectidMain=row.id;


                    }
                }).datagrid('clientPaging');
        }


        //		点取消关闭窗口
        function clearall(){
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
            parent.layer.close(index); //执行关闭
        }


    </script>
</head>
<body>


<div class="navheader form-inline" style="padding:0 5px;height:40px;">
    <%--<input type="hidden" id="gid"/>--%>
    <%--<input type="hidden" id="staffname" name="staffname"/>--%>

    <div class=" form-group">
        <label for="jstext">检索内容</label>
        <input type="text" name="jstext" id="jstext" class="form-control" style="width:90px;"/>
        <button type="button" class="btn btn-success " onclick="searchBtn()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>
    <div class="btn-group-right">
        <div class="btn-group " role="group">
            <button type="button" class="btn btn-default bi-btn-width90" onclick="refresh()">刷新列表</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="centain(未定义)">确定</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="clearall()">取消</button>

        </div>
    </div>
</div>
<div style="padding:0 5px;">
    <table id="gridtable" class="gridtable" style="width:100%;">
    </table>
</div>



</body>
</html>
