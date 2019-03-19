<!doctype html>
<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/6/2
  Time: 15:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/blsj.css?v=3">
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/danbingzhong.css?v=3">
    <title></title>

    <script>
        $(function(){
            var height = findDimensions_height();
            var width = findDimensions_width();
            $("#zyptlb").height(height-50);
            $("#gridtable").height(height-88);



            var date = new Date;
            var year=date.getFullYear();

            var   startTime = year + '-01-01';
            var endTime = year + '-12-31';
            $("#sTime").val(startTime);
            $("#eTime").val(endTime);
            getAllTypeForTree();
            $('#gridtable').datagrid(
                {
                    url:"/CustomFormCheckList/getCheckListOfUserID?sTime="+startTime+"&eTime="+endTime+"&rdm="+ parseInt(Math.random()*100000),
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
                            { field: 'inputTime', title: '上报日期', width: '100px', align: 'left', halign: 'center'},
//                            { field: 'dataSbrq', title: '报告日期', width: '100px', align: 'left', halign: 'center'},
                            { field: 'formTypeName', title: '事件类型', width: '150px', align: 'left', halign: 'center' },
                            { field: 'formName', title: '表单类型', width: '150px', align: 'left', halign: 'center' },
                            { field: 'shName', title: '审核流程', width: '260px', align: 'left', halign: 'center' },
                            { field: 'formStatus', title: '审核状态', width: '130px', align: 'left', halign: 'center',
                                formatter:function (value, row, index) {
                                    switch (value) {
                                        case "0":
                                            return "未提交审核";
                                        case "1":
                                            return "审核中";
                                        case "2":
                                            return "审核结束";
                                        case "3":
                                            return "驳回";
                                    }
                                }
                            },
                            { field: 'operate', title: '操作', width: '220px', align: 'left', halign: 'center',
                                formatter:function(value,row,index){
                                    var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\'onclick="update(\''+row.dataId+'\',\''+row.formId+'\',\''+row.formName+'\',\''+row.formStatus+'\')" ><span class=\'glyphicon  glyphicon glyphicon-pencil\'></span></button>';
                                    str+=  '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\'onclick="datalook(\''+row.dataId+'\',\''+row.formId+'\',\''+row.formName+'\')" ><span>查看</span></button>';
                                    str+= '<button type=\'button\' class=\'btn btn-danger  bi-glyphicon\' onclick="shLog(\''+row.id+'\')"><span>审核记录</span></button>';
                                    str+= '<button type=\'button\' class=\'btn btn-danger  bi-glyphicon\' onclick="removeRow(\''+row.id+'\',\''+startTime+'\',\''+endTime+'\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></button>';
                                    return str;
                                }
                            }
                        ]
                    ],
                    onSelect : function(index, row){
                        selectid=row.nid;
                        selectindex=index;
                    }
                }).datagrid('clientPaging');
        })

        function loadCheckList(){
            var startTime = $("#sTime").val();
            var endTime = $("#eTime").val();
            $('#gridtable').datagrid(
                {
                    url: "/CustomFormCheckList/getCheckListOfUserID?sTime=" + startTime + "&eTime=" + endTime + "&rdm=" + parseInt(Math.random() * 100000)
                });
        }

        function shLog(id){
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(width*0.75,height-200,"审核记录查看","/V_CustomFormShLog/toLogList?checkID="+id);
        }


        function update(dataId,formId,formName,formStatus){
            if(formStatus==1||formStatus==2){
                layerInfo("数据审核中，禁止修改！");
                return false;
            }
            var url = "/v_customformdata/toEdit?dataId="+dataId+"&tableId="+formId+"&formStatus="+formStatus;
            openPage(formName,url);
        }
        function loadList() {
            loadCheckList();
        }
        function datalook(dataId,formId,formName){
            var url = "/v_customformdata/toEdit?dataId="+dataId+"&tableId="+formId+"&formStatus=-2";
            openPage(formName,url);
        }
        function openPage(formName,url){
//            $.ajax({
//                type: 'post',
//                url: url,
//                dataType: "json",
//                success: function (data) {
//                    if (data.success == true) {
                        var height = findDimensions_height();
                        var width = findDimensions_width();
                        layeropen(0.85*width,height-50,formName,url);
//                    }else {
//                        layerInfo(data.msg);
//                    }
//                }
//            });
        }

        function removeRow(id,startTime,endTime){
            layerConfirm("是否确定删除?", function () {
                var url = '';
                $.ajax({
                    type: 'post',
                    url: url,
                    dataType: "json",
                    success: function (data) {
                        if (data.success == true) {
                            $.ajax({
                                type: 'post',
                                url: data.msg,
                                dataType: "json",
                                success: function (data1) {
                                    if (data1.success == true) {
                                        loadCheckList();
                                        layerSuccess("成功", function () {

                                        });
                                    } else {
                                        layerError(data1.msg);
                                    }
                                }
                            });
                        } else {
                            layerError(data.msg);
                        }
                    }
                });
            });

        }
        var MenuTreeData;
        function getAllTypeForTree(){
            var url = "/CustomType/getAllTypeForTree";
            $.ajaxSettings.async = false;
            $.getJSON(url, function (data) {
                MenuTreeData = data;
            });
            $.ajaxSettings.async = true;
            var height = findDimensions_height();

            $("#typeTree").height(height *0.91- 35);
//            $("#menu1_warp").height(height *0.91);
            $('#typeTree').tree({
                method: "get",
                animate: true,
                url:url,
                data: MenuTreeData,

                onClick: function (node) {
                    if(node.id.length=0) return;
                    $.getJSON("/CustomForm/getFormByID?formId="+node.id,function(data){
                        $('#framelist').attr("src",'/V_CustomFormList/toList?listName='+data.listName+'&formId='+data.id);
                    });

                }

            });

        }
    </script>


    <style>
        body{overflow-y:  auto}
    </style>
</head>
<body style="height: 100%">



<div style="position:fixed;left:1px;top:0;background-color:#fff;z-index:9999;display:block;width:100%;height: 39px">
    <ul class="nav nav-tabs" role="tablist" id="mytab" >
        <li  class="active"><a href="#sjsb" data-toggle="tab">已报数据</a></li>
        <li ><a href="#zyptlb"  data-toggle="tab">明细数据</a></li>

    </ul>
</div>
<!--内容-->
<div id="tabContent" class="tab-content" style="margin-top:5px;">

    <!--已报数据开始-->
    <div class="tab-pane fade in active"    id="sjsb" >
        <div style="margin-top:38px;width:100%;">
            <div class="navheader form-inline" style="padding:0 5px;height:40px;">
                <div class=" form-group">
                    <span>上报时间：</span>
                    <span>
                            <input type="text" class="form-control Wdate" style="width:90px;" name="sTime" id="sTime" value=""
                                   onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd' })">
                            <span>至</span>
                            <input type="text" class="form-control Wdate" style="width:90px;" name="eTime" id="eTime" value=""
                                   onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd' })">
                            <button type="button" class="btn btn-success bi-btn-search" onclick="loadCheckList()">
                                <span class="glyphicon glyphicon glyphicon-search"></span>
                            </button>
                        </span>
                </div>
            </div>

            <table id="gridtable"  style="width:100%; " >

            </table>
        </div>


        <!--底下的三个panel开始-->
        <%-- <div style="padding-top:10px; width:99%;display: block;margin:0 5px;">
             <div style="width:49.5%; float:left;margin-right:0.5rem;border:1px solid #ddd;">
                 <div class="panel panel-default">
                     <div class="panel-heading">
                         <span>已报上报事件统计&nbsp;&nbsp;&nbsp;</span>
                         <span>
                             <input type="text" class="form-control Wdate" style="width:90px;" name="startTime" id="startTime" value=""
                                    onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd' })">
                             <span>至</span>
                             <input type="text" class="form-control Wdate" style="width:90px;" name="endTime" id="endTime" value=""
                                    onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd' })">
                             <button type="button" class="btn btn-success bi-btn-search" onclick="searchPie()">
                                 <span class="glyphicon glyphicon glyphicon-search"></span>
                             </button>
                         </span>
                     </div>
                     <div class="panel-body" style="padding:5px;border:none;height:450px;overflow: hidden;" id="form_style">
                     </div>

                 </div>
             </div>

             <div style="width:49.5%; float:right;border:1px solid #ddd;">
                 <div class="panel panel-default">
                     <div class="panel-heading">
                         <span>上报事件月上报数&nbsp;&nbsp;&nbsp;</span>
                         <span>
                             <input type="text" class="form-control Wdate" style="width:60px;" name="year" id="year" value=""
                                    onclick="WdatePicker({ dateFmt: 'yyyy' })">
                             <button type="button" class="btn btn-success bi-btn-search" onclick="searchBar()">
                                 <span class="glyphicon glyphicon glyphicon-search"></span>
                             </button>
                         </span>
                     </div>
                     <div class="panel-body" style="padding:5px;border:none;width:450px;height:450px;overflow: hidden;" id="month">
                     </div>
                 </div>
             </div>

         </div>--%>


    </div>
    <!--已报数据开始-->

    <!--明细数据开始-->
    <div class="tab-pane fade" id="zyptlb" >
        <div style="width:20%;border:1px solid #ddd;border-top:none;float:left;margin:38px 5px 0 0;height:100%;" >
            <ul id="typeTree" class="easyui-tree" style="padding:5px;"></ul>
        </div>
        <div style="width:79%;float:left;height:100%;padding:5px;margin-top:40px;">
            <div class="J_mainContent mainContent" id="" style="height:100%;">
                <iframe id="framelist" class="J_iframe" scrolling="auto" src="" style="border:none" name="iframe0" width="100%" height="100%"  frameborder="0" data-id="login.html"></iframe>
            </div>
        </div>
    </div>
    <!--明细数据结束-->

</div>


</body>
</html>
