<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2017/4/20
  Time: 17:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>表单定义</title>

        <script>
            //主表增加的
            var selectidMain=null;//选中的参数id

            $(function(){



                var height = findDimensions_height();
                $("#l_datagrid").height(height-50);
                loadForm();

                $("#r1_datagrid").height(height-88);
                $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                    $('#r1_datagrid').datagrid('resize', {
                        width: $($(e.target).attr("href")).width()-10


                    })
                });
//			右边表格未定义
                loadFormField();

                //$("#rt_datagrid").height(height-88);
                $("#rt_datagrid").height(height/2-70);
                $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                    $('#rt_datagrid').datagrid('resize', {
                        width: $($(e.target).attr("href")).width()-10


                    })
                });
                loadFormTemplate();


                $("#rb_datagrid").height(height/2-30);


                $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                    $('#rb_datagrid').datagrid('resize', {
                        width: $($(e.target).attr("href")).width()-10


                    })
                });
                loadFormTemplateProperties();

            });


            function loadForm(){
                $('#l_datagrid').datagrid(
                    {
                        url:'/CustomForm/getAllCustomForm?rdm=' + parseInt(Math.random()*100000),
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
                                {field: 'id', title: 'ID', width: '100px', hidden: true},
                                { field: 'name', title: '表单名称', width: '200px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'code', title: '表单编码', width: '160px', align: 'left',sortable:true, halign: 'center' },
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
                            selectindexMain=index;
                            //加载表单元数据
                            $('#r1_datagrid').datagrid({url:'/CustomFormField/getFieldsByFormId?formId=' + row.id+'&rdm=' + parseInt(Math.random()*100000)});

                            //加载表单模板
                            $('#rt_datagrid').datagrid({url:'/CustomFormTemplate/getCustomFormTemplateByFormId?formId=' + row.id+'&rdm=' + parseInt(Math.random()*100000)});

                            $('#rb_datagrid').datagrid('loadData', { total: 0, rows: [] });
                        }
                    }).datagrid('clientPaging');
            }



            function loadFormField() {
                $('#r1_datagrid').datagrid(
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
                                {field: 'id', title: 'ID', width: '100px', hidden: true},
                                { field: 'fieldZhname', title: '中文名称', width: '240px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'fieldName', title: '字段名称', width: '120px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'pkey', title: '关键字', width: '80px', align: 'left',sortable:true, halign: 'center',
                                    formatter:function (value, row, index) {
                                        switch (value) {
                                            case true:
                                                return "√";
                                        }

                                    }},
//                                { field: 'fieldCode', title: '字段代码', width: '200px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'fieldType', title: '字段类型', width: '240px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'controlType', title: '控件类型', width: '200px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'operate', title: '操作', width: '120px', align: 'left', halign: 'center',
                                    formatter:function(value,row,index){
                                        var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\'onclick="editfield(\''+row.id+'\')" ><span class=\'glyphicon  glyphicon glyphicon-pencil\'></span></button>';
                                        str+= '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="delfield(\''+row.id+'\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></button>';

                                        return str;
                                    }
                                }
                            ]
                        ]
                    }).datagrid('clientPaging');
            }

            function loadFormTemplate(){
                $('#rt_datagrid').datagrid(
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
                                {field: 'id', title: 'ID', width: '100px', hidden: true},
                                { field: 'name', title: '模板名称', width: '240px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'active', title: '激活', width: '40px', align: 'left',sortable:true, halign: 'center'},
                                { field: 'style', title: '模板风格', width: '200px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'createTime', title: '创建时间', width: '100px', align: 'left',sortable:true, halign: 'center'},
                                { field: 'operate', title: '操作', width: '300px', align: 'left', halign: 'center',
                                formatter:function(value,row,index){
                                    var   str = '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="activetemplate(\''+row.id+'\')">激活</button>';
                                    str += '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="deltemplet(\''+row.id+'\')">删除</button>';
                                    str += '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="designtemplate(\''+row.id+'\')">设计</button>';
                                    str += '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\'onclick="previewtemplet(\''+row.id+'\')" >预览</button>';
                                    str += '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\'onclick="clonetemplet(\''+row.id+'\')" >克隆</button>';
                                    str += '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\'onclick="edittemplet(\''+row.id+'\')" >修改</button>';

                                    return str;
                                }
                            }
                            ]
                        ],
                        onSelect : function(index, row){
                            //加载表单模板属性
                            $('#rb_datagrid').datagrid({url:'/CustomFormFieldTemplate/getAllByTemplateId?templateId=' + row.id+'&rdm=' + parseInt(Math.random()*100000)});


                        }
                    }).datagrid('clientPaging');

            }


            function loadFormTemplateProperties() {
                $('#rb_datagrid').datagrid(
                    {
                        url:"",
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        autoRowHeight:false,
                        idField: 'Id',
                        pagination: true,
                        clientPaging: true,
                        pageSize: 15,
                        pageList: [10, 15, 20, 25, 30, 40, 50],
                        columns: [
                            [
                                {field: 'Id', title: 'ID', width: '100px', hidden: true},
                                { field: 'fieldZhname', title: '字段名称', width: '100px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'fieldCode', title: '字段代码', width: '100px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'fieldtype', title: '数据类型', width: '80px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'b_controlType', title: '标准控件类型', width: '80px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'controlType', title: '控件类型', width: '80px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'b_dataSql', title: '标准数据SQL', width: '100px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'dataSql', title: '数据SQL', width: '100px', align: 'left',sortable:true, halign: 'center' }
//                                { field: 'operate', title: '操作', width: '120px', align: 'left', halign: 'center',
//                                    formatter:function(value,row,index){
//                                        var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\'onclick="edittemplet(\''+row.id+'\')" ><span class=\'glyphicon  glyphicon glyphicon-pencil\'></span></button>';
//                                        return str;
//                                    }
//                                }
                            ]
                        ]
                    }).datagrid('clientPaging');
            }


            //增加表单
            function addform(){
                var height = findDimensions_height();
                var width = findDimensions_width();
                layeropen(0.5*width,height-50, "增加表单", "${ctx}/v_customform/toEdit");
            }

            //修改表单
            function editform(formId){
                var height = findDimensions_height();
                var width = findDimensions_width();
                layeropen(0.5*width,height-50, "编辑表单", "${ctx}/v_customform/toEdit?formId=" + formId);
            }

            //删除表单
            function delform(formId) {

            }

            //增加元数据字段
            function addfield() {
                var height = findDimensions_height();
                var width = findDimensions_width();

                if(selectidMain == null){
                    layerInfo("请先选择右侧要增加字段的表单");
                    return;
                }

                layeropen(800,450, "增加字段", "${ctx}/v_customformfield/toEdit?formId=" + selectidMain);


            }

            //修改元数据字段
            function editfield(fieldId){
                var height = findDimensions_height();
                var width = findDimensions_width();

                if(selectidMain == null){
                    layerInfo("请先选择右侧要增加字段的表单");
                    return;
                }


                layeropen(0.85*width,height-50, "编辑字段", "${ctx}/v_customformfield/toEdit?formId=" + selectidMain + "&fieldId=" + fieldId);
            }

            //删除元数据字段
            function delfield(fieldId) {
                
            }


            //增加模板
            function addtemplet() {
                var height = findDimensions_height();
                var width = findDimensions_width();

                if(selectidMain == null){
                    layerInfo("请先选择右侧要增加字段的表单");
                    return;
                }

                layeropen(600,400, "增加模板", "${ctx}/v_customformtemplate/toEdit?formId=" + selectidMain);

            }

            //编辑模板
            function edittemplet(templateId) {
                var height = findDimensions_height();
                var width = findDimensions_width();

                if(selectidMain == null){
                    layerInfo("请先选择右侧要增加字段的表单");
                    return;
                }

                layeropen(600,400, "编辑模板", "${ctx}/v_customformtemplate/toEdit?formId=" + selectidMain + "&templateId=" + templateId);

            }


            //删除模板
            function deltemplet(templateId) {
                layerConfirm("是否确定删除?", function () {
                    var url = '${ctx}/CustomFormTemplate/deltemplet?templateId=' + templateId;
                    $.ajax({
                        type: 'post',
                        url: url,
                        dataType: "json",
                        success: function (data) {
                            if (data.success == true) {
                                refloadFormTemplet();
                            } else {
                                layerError(data.msg);
                            }
                        }
                    });
                });

            }
//            refloadFormField
            function reloadFormField() {
                $('#r1_datagrid').datagrid({url:'/CustomFormField/getFieldsByFormId?formId=' + selectidMain+'&rdm=' + parseInt(Math.random()*100000)});

            }

//            function refloadFormField(){
//                $('#r1_datagrid').datagrid({
//                    url: '/CustomFormField/getFieldsByFormId?formId='+selectidMain+ '&rdm=' + parseInt(Math.random()*100000)
//                });
//            }


            function refloadFormTemplet(){
                $('#rt_datagrid').datagrid(
                    {

                        url: '/CustomFormTemplate/getCustomFormTemplateByFormId?formId=' + selectidMain + '&rdm=' + parseInt(Math.random() * 100000)
                    })
            }
            function activetemplate(templateId){
                $.ajax({

                    url: "/CustomFormTemplate/active?formId=" + selectidMain+"&templateId="+ templateId,
                    dataType: "json",
                    success: function (data) {

                        if (data.success == true) {
                            refloadFormTemplet();

                        } else {
                            //alert(data.msg);
                            layerInfo("数据保存失败！");
                        }
                    }
                });
            }
            var index = 0;
            function designtemplate(templateId,pagelx) {
//                flag = false;
//                currentUrl = '/TBZ3Xlsj/findByBrbh?brbh=';
                var height = findDimensions_height();
                var width = findDimensions_width();
                //index = layeropen(0.85 * width, height - 50, "模板页面设计", "/v_Dldsnform/toDldsnform?templateId=" + templateId+"&pagelx="+pagelx);

                window.open("/v_Dldsnform/toDldsnform?templateId=" + templateId+"&pagelx="+pagelx,"_blank","");


            }


            //模板预览
            function previewtemplet(templateId) {
                var height = findDimensions_height();
                var width = findDimensions_width();
                //index = layeropen(0.85 * width, height - 50, "模板页面预览", "/v_customformtemplatepreview/toPreview?templateId=" + templateId);

                window.open("/v_DldsnformPreview/toDldsnformPreview?templateId=" + templateId,"_blank","");

            }
            function clonetemplet(templateId) {
                var height = findDimensions_height();
                var width = findDimensions_width();
                layeropen(600,400, "克隆模板", "/v_customformtemplate/toClone?templateId=" + templateId);


            }


            function searchForm(){
                var searchForm = $("#searchForm").val();
                $('#l_datagrid').datagrid(
                    {
                        url: "/CustomForm/findBySearch?searchForm="+searchForm+"&rdm=" + parseInt(Math.random() * 100000)
                    })

                $('#r1_datagrid').datagrid('loadData', { total: 0, rows: [] });

                $('#rt_datagrid').datagrid('loadData', { total: 0, rows: [] });

                $('#rb_datagrid').datagrid('loadData', { total: 0, rows: [] });
            }

            function fieldtest(){
                if(selectidMain){
                    $.ajax({
                        url: "/CustomFormField/testField?formId=" + selectidMain,
                        dataType: "json",
                        success: function (data) {
                            if (data.success == true) {
                                alert(data.msg);
                            } else {
                                layerError(data.msg);
                            }
                        }
                    });
                }else{
                    layerInfo("请选择表单！");
                }
            }
        </script>
</head>
<body>



<div class="navheader form-inline" style="padding:0 5px;height:40px;">
    <div class=" form-group">
        <label for="searchForm">检索内容：</label>
        <input type="text" class="form-control" name="searchForm" id="searchForm" style="width:180px;"placeholder="表单名、表单编码、表名"/>
        <button type="button" class="btn btn-success " onclick="searchForm()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>

    <div class="btn-group-right">
        <div class="btn-group "  role="group">
            <button type="button" class="btn btn-default bi-btn-width90" onclick="fieldtest()">表单字段测试</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="addform()">新增表单</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="addfield()" style="width:100px;">新增字段</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="addtemplet()" style="width:100px;">新增模板</button>
        </div>
    </div>
</div>

<div style="margin:0 5px; overflow: hidden;" >
    <!--左边表格-->
    <div style="width:35%;float:left;display:inline-block;padding-right:5px;border-right:1px dotted #ccc;" >
        <table id="l_datagrid" class="datagrid"></table>
    </div>
    <!--右边选项卡 -->
    <div style="width:65%;float:right;display:inline-block;padding-left:5px;" >
        <!--选项卡导航条-->
        <div>
            <!--<div style="position:fixed;left:1px;top:0;background-color:#fff;z-index:9999;display:block;width:100%;">-->
            <ul class="nav nav-tabs" role="tablist" id="mytab">
                <li class="active"><a href="#bdzd" data-toggle="tab">表单字段</a></li>
                <li><a href="#bdmb" data-toggle="tab">表单模板</a></li>
            </ul>
        </div>
        <!--选项卡	-->
        <div class="tab-content">
            <div class="tab-pane active"  id="bdzd">
                <table id="r1_datagrid" class="datagrid" style="width:100%;">
                    <!--右边表格未定义-->
                </table>
            </div>
            <div class="tab-pane"  id="bdmb">
                <%--<table id="r2_datagrid" class="datagrid" style="width:100%;">--%>
                    <%--<!--右边表格未定义-->--%>
                <%--</table>--%>

                <div style="overflow: hidden;text-align: right;">

                    <table class="datagrid" id="rt_datagrid"style=" overflow: auto;"></table>
                </div>
                <div style="overflow: hidden;text-align: right;margin-top:10px;">

                    <table class="datagrid" id="rb_datagrid" style="overflow: auto;"></table>
                </div>


            </div>
        </div>
    </div>
</div>


</body>
</html>
