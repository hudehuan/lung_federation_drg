<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/11/4
  Time: 16:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <%@ include file="/common/meta.jsp" %>
    <script type="text/javascript" src="${ctx }/static/js/FormValidation.js"></script>
    <title>表单流程定义</title>


    <script>

        var selectidMain = null;
        var selectid = null;

        $(function(){

            var height = findDimensions_height();
            $("#l_datagrid").height(height-50);
            $("#r_datagrid2").height(height/2-30);

            $('#l_datagrid').datagrid(
                    {
                        url:'/CustomForm/getFormByTypeID?typeId=${typeId}&rdm=' + parseInt(Math.random()*100000),
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        autoRowHeight:false,
                        columns: [
                            [
                                {field: 'id', title: 'ID', width: '100px', hidden: true},
//                                { field: 'xh', title: '序号', width: '50px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'name', title: '表单名称', width: '160px', align: 'left',sortable:true, halign: 'center' }
                            ]
                        ],
                        onSelect : function(index, row){
                            selectidMain=row.id;
                            selectindexMain=index;

                            loadFlowByFormID(row.id);
                            loadKeshiByFormID(row.id);

                            loadStepByFlowIdnull();
                            loadUsernull();

                            $("input").val("");
                            $("textarea").val("");
                            $("input[name=xh]").removeAttr("readonly");

                            selectid = null;
                        }
                    });


            $("#r_datagrid1").height(height/2-30);
            $("#r_datagrid2").height(height/2-30);

            $('#r_datagrid1').datagrid(
                    {
                        url:'',
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        autoRowHeight:false,
                        columns: [
                            [
                                {field: 'id', title: 'ID', width: '100px', hidden: true},
                                { field: 'xh', title: '序号', width: '50px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'name', title: '名称', width: '140px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'sm', title: '备注', width: '220px', align: 'left',sortable:true, halign: 'center' },

                                { field: 'operate', title: '操作', width: '160px', align: 'left', halign: 'center',
                                    formatter:function(value,row,index){
                                        var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\'onclick="editFlow(\''+row.id+'\')"  ><span class=\'glyphicon  glyphicon glyphicon-pencil\'></span></button>';
                                        str+= '<button type=\'button\' class=\'btn btn-warning bi-glyphicon\' onclick="addStep(\''+row.id+'\')">新增步骤</button>';
//                                        str+= '<button type=\'button\' class=\'btn btn-warning bi-glyphicon\' onclick="setdefault(\''+row.id+'\')">默认</button>';
//                                        str+= '<button type=\'button\' class=\'btn btn-warning bi-glyphicon\' onclick="setstop(\''+row.id+'\')">停用</button>';
                                        str += '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="deletelc(\''+row.id+'\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></span></button>';
                                        return str;
                                    }
                                }
                            ]
                        ],
                        onClickRow : function(index, row){
                            selectid=row.id;
                            selectindex=index;

                            loadFormByFlowId(row.id);
                            loadUsernull();

                            $("input").val("");
                            $("textarea").val("");
                            $("input[name=xh]").removeAttr("readonly");


                        }
                    });

            $('#r_datagrid2').datagrid(
                {
                    url:'',
                    method:'get',
                    rownumbers:true,
                    singleSelect:true,
                    autoRowHeight:false,
                    columns: [
                        [
                            {field: 'id', title: 'ID', width: '100px', hidden: true},
                            { field: 'code', title: '科室代码', width: '90px', align: 'left',sortable:true, halign: 'center' },
                            { field: 'name', title: '科室名称', width: '160px', align: 'left',sortable:true, halign: 'center' },
                            { field: 'operate', title: '操作', width: '60px', align: 'left', halign: 'center',
                                formatter:function(value,row,index){
                                    var str= '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="deleteKeshi(\''+row.id+'\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></span></button>';
                                    return str;
                                }
                            }
                        ]
                    ]
                });

            $("#rx_datagrid").height(height/2-30);
            $("#ry_datagrid").height(height/2-30);


            $('#rx_datagrid').datagrid(
                    {
                        url:'',
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        autoRowHeight:false,
                        columns: [
                            [
                                {field: 'id', title: 'ID', width: '100px', hidden: true},
                                { field: 'xh', title: '序号', width: '50px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'name', title: '名称', width: '140px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'operate', title: '操作', width: '160px', align: 'left', halign: 'center',
                                    formatter:function(value,row,index){
                                        var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\' onclick="editStep(\''+row.id+'\')"><span class=\'glyphicon  glyphicon glyphicon-pencil\'></span></button>';
                                        str += '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="deleteStep(\''+row.id+'\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></span></button>';
                                        str+= '<button type=\'button\' class=\'btn btn-warning bi-glyphicon\' onclick="seleUser(\''+row.id+'\')">用户选择</button>';
                                        return str;
                                    }
                                }
                            ]
                        ],
                        onSelect : function(index, row){
                            selectidf=row.id;
                            selectindexf=index;
                            loadUser(row.id)
                        }
                    });

            $('#ry_datagrid').datagrid(
                    {
                        url: '',
                        method: 'get',
                        idField: 'id',
//                        pagination: true,
                        rownumbers: true,
                        singleSelect: true,
                        autoRowHeight: false,
//                        clientPaging: true,
//                        pageSize: 10,
//                        pageList: [10, 15, 20, 25, 30, 40, 50],
                        columns: [
                            [
                                {field: 'id', title: '步骤用户', width: '80px',sortable:true, hidden: true},
                                {field: 'username', title: '姓名', width: '60px', align: 'left',sortable:true, halign: 'center'},
                                {field: 'ksname', title: '科室', width: '100px', align: 'left',sortable:true, halign: 'center'},
                                {field: 'zhi_cheng', title: '职称', width: '80px', align: 'left', sortable:true,halign: 'center'},
                                {field: 'zhi_wei', title: '职位', width: '80px', align: 'left',sortable:true, halign: 'center'},
                                { field: 'is_only_ks', title: '是否只看本科室', width: '100px', align: 'left',sortable:true, halign: 'center' },
                                {
                                    field: 'operate', title: '操作', width: '150px', align: 'left', halign: 'center',
                                    formatter: function (value, row, index) {
                                        var str = '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="deleUser(\''+row.id+'\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></span></button>';
                                        str+= '<button type=\'button\' class=\'btn btn-warning bi-glyphicon\' onclick="updaOnlyKs(\''+row.id+'\')">是否查看本科室</button>';
                                        return str;
                                    }
                                }
                            ]
                        ]

                    });

        });


        function loadFlowByFormIDnull(){
            $('#r_datagrid1').datagrid('loadData',{total:0,rows:[]});
        }
        function loadStepByFlowIdnull(){
            $('#rx_datagrid').datagrid('loadData',{total:0,rows:[]});
        }
        function loadKeshiByFormIDnull(){
            $('#r_datagrid2').datagrid('loadData',{total:0,rows:[]});
        }
        function loadUsernull(){
            $('#ry_datagrid').datagrid('loadData',{total:0,rows:[]});
        }



        function loadFormByFlowId(flowId){
            $('#rx_datagrid').datagrid(
                    {
                        url:'/CustomFormFlowStep/getFormByFlowId?flowId='+ flowId+'&rdm=' + parseInt(Math.random()*100000)
                    });
        }

        function editStep(id){
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(0.45*width,height-240, "数据编辑", "${ctx}/V_CustomFormFlowStep/toStpeEdit?id="+id+"&flowId="+selectid);
        }

        function seleUser(id){
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(0.75*width,height-50, "选择用户", "${ctx}/V_CustomFormFlowStepUser/toSeleStepUser?stepId="+id+"&flowId="+selectid);
        }

        function deleteStep(id){
            layerConfirm("是否确定删除?", function () {
                var url = '${ctx}/CustomFormFlowStep/dele?id=' + id;
                $.ajax({
                    type: 'post',
                    url: url,
                    dataType: "json",
                    success: function (data) {
                        if (data.success == true) {
                            loadFormByFlowId(selectid);
                            loadUsernull();
                        } else {
                            layerError(data.msg);
                        }
                    }
                });
            });

        }

        function selectFormType(){
            var typeid=$('#formType').children('option:selected').val();//这就是selected的值

            loadFormByTypeID(typeid);

            loadFlowByFormIDnull();

            loadKeshiByFormIDnull();

            loadStepByFlowIdnull();

            loadUsernull();

            selectidMain = null;
            selectid = null;

//            $("input").val("");
//            $("textarea").val("");
//            $("input[name=xh]").removeAttr("readonly");


        }


        function loadFormByTypeID(typeID){
            $('#l_datagrid').datagrid(
                    {
                        url:'/CustomForm/getFormByTypeID?typeId='+ typeID+'&rdm=' + parseInt(Math.random()*100000)
                    });
        }
        function loadKeshiByFormID(formID){
            $('#r_datagrid2').datagrid(
                {
                    url:'/CustomFormKeshi/findByFormId?formId='+ formID+'&rdm=' + parseInt(Math.random()*100000)
                });
        }

        function loadUser(stepId){
            $('#ry_datagrid').datagrid(
                    {
                        url: '/CustomFormFlowStepUser/getStepUser?stepId='+stepId+'&rdm=' + parseInt(Math.random()*100000)
                    });
        }
        function updaOnlyKs(id){
            //防止冒泡
            if ( event && event.stopPropagation ) {
                event.stopPropagation();}
            else{
                window.event.returnValue = false;
            }
            layerConfirm("是否确定修改?", function () {
                var url = '${ctx}/CustomFormFlowStepUser/updaOnlyKs?id=' + id;
                $.ajax({
                    type: 'post',
                    url: url,
                    dataType: "json",
                    success: function (data) {
                        if (data.success == true) {
                            loadUser(selectidf);
                        } else {
                            layerError(data.msg);
                        }
                    }
                });
            });
        }

        function deleUser(id){
            if ( event && event.stopPropagation ) {
                event.stopPropagation();}
            else{
                window.event.returnValue = false;
            }
            layerConfirm("是否确定删除?", function () {
                var url = '${ctx}/CustomFormFlowStepUser/deleUser?id=' + id;
                $.ajax({
                    type: 'post',
                    url: url,
                    dataType: "json",
                    success: function (data) {
                        if (data.success == true) {
                            loadUser(selectidf);
                        } else {
                            layerError(data.msg);
                        }
                    }
                });
            });
        }

        function loadFlowByFormID(formID){
            $('#r_datagrid1').datagrid(
                    {
                        url:'/CustomFormFlow/getFlowByFormID?formID='+formID+'&rdm=' + parseInt(Math.random()*100000)
                    });
        }

        function loadDefaultFlowByTypeID(typeID){

        }
        function addStep(id){
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(0.45*width,height-240, "添加步骤", "${ctx}/V_CustomFormFlowStep/toStpeEdit?id=&flowId="+id);
        }


        function addflow(){
            if(selectidMain!=null){
                layeropen(600, 400, "数据编辑", "${ctx}/V_CustomFormFlow/toEdit?formId="+selectidMain);
            }else{
                layerError("请选择表单！");
            }
        }

        function setdefault(id){
            //防止冒泡
            if ( event && event.stopPropagation ) {
                event.stopPropagation();}
            else{
                window.event.returnValue = false;
            }
            layerConfirm("是否确定修改?", function () {
                var url = '${ctx}/CustomFormFlow/updateMoren?id=' + id;
                $.ajax({
                    type: 'post',
                    url: url,
                    dataType: "json",
                    success: function (data) {
                        if (data.success == true) {
                            loadFlowByFormID(selectidMain);
                        } else {
                            layerError(data.msg);
                        }
                    }
                });
            });
        }

        function setstop(id){
            if ( event && event.stopPropagation ) {
                event.stopPropagation();}
            else{
                window.event.returnValue = false;
            }
            layerConfirm("是否确定修改?", function () {
                var url = '${ctx}/CustomFormFlow/updateQy?id=' + id;
                $.ajax({
                    type: 'post',
                    url: url,
                    dataType: "json",
                    success: function (data) {
                        if (data.success == true) {
                            loadFlowByFormID(selectidMain);
                        } else {
                            layerError(data.msg);
                        }
                    }
                });
            });
        }

        function deletelc(id){
            if ( event && event.stopPropagation ) {
                event.stopPropagation();}
            else{
                window.event.returnValue = false;
            }
            layerConfirm("是否确定删除?", function () {
                var url = '${ctx}/CustomFormFlow/deletelc?id=' + id;
                $.ajax({
                    type: 'post',
                    url: url,
                    dataType: "json",
                    success: function (data) {
                        if (data.success == true) {
                            layerSuccess(data.msg);
                            loadFlowByFormID(selectidMain);
                            loadStepByFlowIdnull();
                            loadUsernull();
                        } else {
                            layerError(data.msg);
                        }
                    }
                });
            });
        }

        function editFlow(id){
            if ( event && event.stopPropagation ) {
                event.stopPropagation();}
            else{
                window.event.returnValue = false;
            }
            // loadStepByFlowIdnull();
            //$('#rx_datagrid').datagrid('loadData',{total:0,rows:[]});
            layeropen(600, 400, "数据编辑", "${ctx}/V_CustomFormFlow/toEdit?id="+id+"&formId="+selectidMain);
        }

        function toFormKeshi(){
            if(selectidMain==null){
                layerInfo("请选择表单！");
            }else{
                layeropen(600, 450, "科室选择", "/V_CustomFormFlowStepUser/toFormKeshi");
            }
        }

        function addFormKeshi(id,name){
            if(id!=''&&id!=null){
                $.ajax({
                    type: 'post',
                    url: '/CustomFormKeshi/addFormKeshi?id='+id+'&formId='+selectidMain,
                    dataType: "json",
                    success: function (data) {
                        if (data.success == true) {
                            loadKeshiByFormID(selectidMain);
                            layerMsg(data.msg);
                        } else {
                            layerError(data.msg);
                        }
                    }
                });
            }
        }

        function deleteKeshi(id){
            layerConfirm("是否确定删除?", function () {
                var url = '/CustomFormKeshi/deleFormKeshi?id=' + id;
                $.ajax({
                    type: 'post',
                    url: url,
                    dataType: "json",
                    success: function (data) {
                        if (data.success == true) {
                            loadKeshiByFormID(selectidMain);
                            layerMsg(data.msg);
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

<div class="navheader form-inline" style="padding:0 5px;height:40px;">
    <div class=" form-group">
        <label for="formType"style="padding:5px 10px 0px 20px;">分类</label>
        <select id = "formType" name="formType" style="height:25px;width:190px;border-color:#dcdcdc;"
                onchange="selectFormType()">
            <%--<option value="">条目一</option>--%>
            <c:forEach items="${formTypes}" var="type" varStatus="status">
                <option value="${type.id}">${type.name}</option>
            </c:forEach>
        </select>
    </div>
    <div class="btn-group-right">
        <div class="btn-group "  role="group">
            <%--<button type="button" class="btn btn-default bi-btn-width90" onclick="setdefault()">默认</button>--%>
            <%--<button type="button" class="btn btn-default bi-btn-width90" onclick="setstop()">停用</button>--%>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="addflow()">新增流程</button>
                <button type="button" class="btn btn-default bi-btn-width90" onclick="toFormKeshi()">选择科室</button>
        </div>
    </div>
</div>

<div style="margin:0 5px; overflow: hidden;" >
    <!--左边表格-->
    <div style="width:20%;float:left;display:inline-block;padding-right:5px;border-right:1px dotted #ccc;" >
        <table id="l_datagrid" class="datagrid"></table>

    </div>
    <!--右边表格 -->
    <div style="width:80%;float:right;display:inline-block;padding-left:5px;">
        <%--<div style="padding:0 0 5px 0;border-bottom:1px dotted #ccc;">--%>
        <div style="overflow: hidden;">
            <div style="width:61%;float:left;display:inline-block;padding-right:5px;border-right:1px dotted #ccc;" >
                <table id="r_datagrid1" class="datagrid">
                    <!--右边表格未定义-->
                </table>
            </div>
            <div style="width:39%;float:right;display:inline-block;padding-left:5px;">
                <table id="r_datagrid2" class="datagrid">
                </table>
            </div>
        </div>
        <div style="overflow: hidden;">
            <div style="width:39%;float:left;display:inline-block;padding-right:5px;border-right:1px dotted #ccc;" >
                <table id="rx_datagrid" class="datagrid">
              </table>
            </div>
            <!--右边表格 -->
            <div style="width:61%;float:right;display:inline-block;padding-left:5px;">
                <table id="ry_datagrid" class="datagrid">
                    <!--右边表格未定义-->
                </table>
            </div>

        </div>

    </div>
</div>



</body>
</html>
