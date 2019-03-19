<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/9/2
  Time: 13:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>雕龙数据</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/bootstrap-3.3.5/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/style.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/jquery-easyui-1.5/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/jquery-easyui-1.5/themes/default/easyui.css">
    <link rel="stylesheet" href="${ctx}/static/js/plugins/layer/skin/layer.css" />

    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/common.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/My97DatePicker/WdatePicker.js" ></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/easyuiPager.js"></script>


    <script>
        var selectid=null;//选中的参数id
        var r_selectid=null;//右侧表格选中行
        var selectindex=0;
        var r_tableColumns=[];

        $(function(){
            //

            $.ajaxSettings.async = false;
            var fvid_field ={ field: 'wdm' , title: '维代码', width: '120px', align: 'left',halign: 'center',hidden:true};
            var wdm_field ={ field: 'wName' , title: '名称', width: '120px', align: 'left',halign: 'center'};
            r_tableColumns.push(fvid_field);
            r_tableColumns.push(wdm_field);
            $.getJSON('${ctx}/formDefineField/getFormColumns?tdId=${tableId}'
            + "&rdm="+ parseInt(Math.random()*100000),function(data){
                for(var i=0;i<data.length;i++){
                    var field ={ field: data[i].fieldName , title: data[i].fieldZhName, width: '70px', align: 'left',halign: 'center'};
                    r_tableColumns.push(field);
                }
            });
            $.ajaxSettings.async = true;


            var height = findDimensions_height();
            $("#l_datagrid").height(height-50);

//            loadLeftList();
            $('#l_datagrid').datagrid(
                    {
                        url:'${ctx}/FormDefineValue/queryDefineValue?tdId=${tableId}&cxrqstart=${starttime}&cxrqend=${startend}'+ "&rdm="+ parseInt(Math.random()*100000),
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        autoRowHeight:false,
                        columns: [
                            [
                                { field:'tvId',title:'ID',width:'100px',hidden:true},
                                { field: 'isSh', title: '审核', width: '60px', align: 'left',sortable:true, halign: 'center',
                                    formatter:function (value, row, index) {
                                        switch (value) {
                                            case true:
                                                return "√";

                                        }

                                    }},
                                { field: 'rq', title: '上报日期', width: '110px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'inputDate', title: '输入日期', width: '140px', align: 'left',sortable:true, halign: 'center',
                                    formatter:function (value, row, index) {
                                        if (value != null) {
                                            return jsonYearMonthDay(value);
                                        }
                                    }
                                }


                            ]
                        ],
                        onSelect : function(index, row){
                            selectid=row.tvId;
                            loadRightList(row.tvId);
                            selectindex=index;
                        }
                    });
            $("#r_datagrid").height(height-50);
//            loadRightList();
            $('#r_datagrid').datagrid(
                    {
                        url:'',
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        autoRowHeight:false,
                        columns: [
                            r_tableColumns
                        ],
                        onSelect : function(index, row){
                            r_selectid=row.wdm;
                        }
                    });
        });

        function loadLeftList() {
            $('#l_datagrid').datagrid(
                    {
                        url:'${ctx}/FormDefineValue/queryDefineValue?tdId=${tableId}&cxrqstart=${starttime}&cxrqend=${startend}'+ "&rdm="+ parseInt(Math.random()*100000)
                    });
        }

        function loadRightList(tvId) {
            //右边表格未定义
            $('#r_datagrid').datagrid(
                    {
                        url:'/FormDefineFieldValue/getDefineFieldValue?tdId=${tableId}&tvId='+ tvId+ "&rdm="+ parseInt(Math.random()*100000)
                    });
        }
        function jsonYearMonthDay(milliseconds) {
            var datetime = new Date();
            datetime.setTime(milliseconds);
            var year = datetime.getFullYear();
            var month = datetime.getMonth() + 1 < 10 ? "0"
            + (datetime.getMonth() + 1) : datetime.getMonth() + 1;
            var date = datetime.getDate() < 10 ? "0" + datetime.getDate()
                    : datetime.getDate();
            return year + "-" + month + "-" + date;
        }
        function refresh(){
//            $('#r_datagrid').datagrid('reload');
//            $('#l_datagrid').datagrid('reload');
            loadLeftList();
            loadRightList();
        }
        function deleteMain(){
            if(!selectid)
            {
                layerInfo("请选择要删除的数据！");
                return;
            }
            layerConfirm("是否确定删除?",function(){
                //$('#l_datagrid').datagrid('deleteRow', selectindex);

                $.getJSON("/FormDefineValue/checkIsSHByTvId?tvId="+selectid,function(data){
                    if(data.success==true){
                        layerInfo("数据已审核,请先撤销审核后再删除!");
                        return;
                    }else{
                        //数据未审核时
                        $.ajax({
                            url:'/FormDefineValue/deleteDefineValue?tvId='+selectid,
                            type:'post',
                            dataType:'json',
                            success:function(data){
                                if(data.success == true){
                                    layerInfo(data.msg);
//                                    $('#l_datagrid').datagrid('reload');
                                    loadLeftList();
                                    selectid = null;
                                }
                                else{
                                    layerInfo(data.msg);

                                }
                            }
                        });
                    }
                });



            } );

        }

        function deleteR(){
            if(!r_selectid)
            {
                layerInfo("请选择要删除的数据！");
                return;
            }
            layerConfirm("是否确定删除?",function(){
                $.getJSON("/FormDefineValue/checkIsSHByTvId?tvId="+selectid,function(data){
                    if(data.success==true){
                        layerInfo("数据已审核,请先撤销审核后再删除!");
                        return;
                    }else{
                        //数据未审核时
                        $.ajax({
                            url:'/FormDefineFieldValue/deleteDefineFieldValue?wdm='+r_selectid + "&tvId="+selectid,
                            type:'post',
                            dataType:'json',
                            success:function(data){
                                if(data.success == true){
                                    layerInfo(data.msg);
                                    loadRightList(selectid);
                                }
                                else{
                                    layerInfo(data.msg);

                                }
                            }
                        });
                    }
                });
            });
        }

        //新增主表
        function addSbrq(){
            layeropen(800,500,"明细表单","${ctx}/FormDefineValue/addSbrq?tdId=${tableId}");
        }
        //新增维数据
        function add(){
            $.getJSON("/FormDefineValue/checkIsSHByTvId?tvId="+selectid,function(data){
                if(data.success==true){
                    layerError("数据已审核,禁止新增!");
                    return;
                }else{
                    if(!selectid)
                    {
                        layerInfo("请选择要新增的上报日期！");
                        return;
                    }
                    layeropen(800,500,"明细表单","${ctx}/FormDefineFieldValue/toInput?tdId=${tableId}&tvId="+selectid);
                }
            });
        }
        //编辑
        function compile(){
            $.getJSON("/FormDefineValue/checkIsSHByTvId?tvId="+selectid,function(data) {
                if (data.success == true) {
                    layerError("数据已审核,禁止编辑!");
                    return;
                } else {
                    if(!r_selectid || !selectid)
                    {
                        layerInfo("请选择要编辑的数据！");
                        return;
                    }
                    layeropen(800,500,"明细表单","${ctx}/FormDefineFieldValue/toInput?tdId=${tableId}&tvId="+selectid + "&wdm=" + r_selectid);


                }
            });
        }
        //审核
        function check(){
            if(!selectid)
            {
                layerInfo("请选择要审核的数据！");
                return;
            }

            $.ajax({
                url:'${ctx}/FormDefineValue/updatesh?tvId='+selectid,
                type:'post',
                dataType:'json',
                success:function(data){
                    if(data.success==true){
                        layerInfo(data.msg);
                        $('#l_datagrid').datagrid('reload');
                    }
                }

            });



        }

        function addMain(){
            layeropen(450,250,"上报日期表单","/FormDefineValue/addSbrq?tdId=${tableId}");
        }


        function search(){
            if($('#txtDatestart').val()==""){
                layerInfo("请选择查询开始时间！");
                return;
            }
            if($('#txtDateend').val()==""){
                layerInfo("请选择查询截止时间！");
                return;
            }
            $('#l_datagrid').datagrid({url:'${ctx}/FormDefineValue/queryDefineValue?tdId=${tableId}&cxrqstart='
            + $('#txtDatestart').val()+ '&cxrqend='+ $('#txtDateend').val()+ "&rdm="+ parseInt(Math.random()*100000)})

        }


        function print(){
            $.ajax({
                url:'${ctx}/FormDefineValue/print',
                type:'post',
                dataType:'json',
                success:function(data){
                    if(data.success==true){
                        layerInfo("print ok");
                        //$('#l_datagrid').datagrid('reload');
                    }
                }

            });
        }

        function doExcel(){
            if(!selectid)
            {
                layerInfo("请选择要打印的数据！");
                return;
            }
            $.messager.confirm('确认', '确认把该搜索结果导出Excel表格 ？', function(r) {
                if (r) {
                    $.messager.progress({
                    title : '处理中',
                    msg : '请稍后'
                    });
                    $.messager.progress('close');
                    debugger;
                    location.href = '${ctx}/ExcelImport/doExcel?tvId='+selectid+'&tdId=${tableId}';
                }
            })
            }


    </script>
    <style>
        /*去掉滚动条*/
        body{overflow-y:hidden;}
    </style>

</head>
<body>


<div class="navheader form-inline" style="padding:0 5px;height:40px;">
    <div class="form-group">
        <label for="txtDatestart">查询</label>
        <input id="txtDatestart" class="Wdate form-control" type="text"
               onclick="WdatePicker({dateFmt:'${dateFmt}'
               <c:out value="${dateFmt=='yyyy-MM季'?
               ',isQuarter:true, isShowOK:false, disabledDates:[\"....-0[5-9]-..\",\"....-1[0-2]-..\"], startDate:\"%y-01-01\"':
                ''
                }"/>})"
               style="height:25px;width:90px;border-color:#dcdcdc;" value="${starttime}"/>
        <label>至</label>

        <input id="txtDateend" class="Wdate form-control" type="text"
               onclick="WdatePicker({dateFmt:'${dateFmt}'
               <c:out value="${dateFmt=='yyyy-MM季'?
               ',isQuarter:true, isShowOK:false, disabledDates:[\"....-0[5-9]-..\",\"....-1[0-2]-..\"], startDate:\"%y-01-01\"':
                ' '
                }"/>})"
               style="height:25px;width:90px;border-color:#dcdcdc;" value="${startend}"/>

        <button type="button" class="btn btn-success bi-btn-search" onclick="search()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>

    <div class="btn-group-right">
        <div class="btn-group "  role="group">
            <button type="button" class="btn btn-default bi-btn-width90" onclick="doExcel()">Excel导出</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="check()">审核上报</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="addMain()">新增上报</button>    <!--主表是左边的表-->
            <button type="button" class="btn btn-default bi-btn-width90" onclick="deleteMain()">删除上报</button>  <!--主表是左边的-->
            <button type="button" class="btn btn-default bi-btn-width90" onclick="add()">新增数据</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="compile()">编辑数据</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="deleteR()">删除数据</button>


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
        <table id="r_datagrid" class="datagrid">
            <!--右边表格未定义-->
        </table>
    </div>
</div>



</body>
</html>
