<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/9/7
  Time: 15:31
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
    <script type="text/javascript" src="${ctx}/static/js/My97DatePicker/WdatePicker.js" ></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/easyuiPager.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/common.js"></script>

    <script>
        var selectid=null;//选中的参数id
        var selectindex=0;
        var tableColumns=[];
        $(function(){
            var height = findDimensions_height();
            $("#gridtable").height(height-50);
        });



        $(function(){
            //生成columns

            var fieldtvid=  { field: 'tvId', title: '主键', width: '40px', align: 'left', halign: 'center',hidden:true };
            var fieldsh=  { field: 'isSh', title: '审核', width: '40px', align: 'left', halign: 'center',
                formatter:function (value, row, index) {
                    switch (value) {
                        case true:
                            return "√";

                    }

                } };
            var fieldrq= { field: 'rq', title: '上报日期', width: '100px', align: 'left', halign: 'center'};
            var fieldinputrq= { field: 'inputDate', title: '报告日期', width: '100px', align: 'left', halign: 'center'};
            tableColumns.push(fieldtvid);
            tableColumns.push(fieldsh);
            tableColumns.push(fieldrq);
            tableColumns.push(fieldinputrq);
            $.ajaxSettings.async = false;
            $.getJSON("/formDefineField/getFormColumns?tdId=${tableId}"
            + "&rdm="+ parseInt(Math.random()*100000),function(data){

                for(var i=0;i<data.length;i++){
                    var t_field ={ field: data[i].fieldName , title: data[i].fieldZhName, width: '70px', align: 'left',halign: 'center'};
                    tableColumns.push(t_field);
                }
            });
            $.ajaxSettings.async = true;
//            loadList();
            $('#gridtable').datagrid(
                    {
                        url:'/FormDefineFieldValue/getDefineFieldValueBytdId?tdId=${tableId}&cxrqstart=${starttime}&cxrqend=${startend}'
                        + "&rdm="+ parseInt(Math.random()*100000),
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        autoRowHeight:false,
                        pagination:true,
                        pageSize:15,
                        pageList:[15,20,25,30,40,50],
                        clientPaging:true,

                        columns: [
                            tableColumns

                        ],
                        onSelect : function(index, row){
                            selectid=row.tvId;
                            selectindex=index;


                        }
                    }).datagrid('clientPaging');
        });

        function loadList() {
            $('#gridtable').datagrid(
                    {
                        url:'/FormDefineFieldValue/getDefineFieldValueBytdId?tdId=${tableId}&cxrqstart=${starttime}&cxrqend=${startend}'
                        + "&rdm="+ parseInt(Math.random()*100000),
                    });
        }
        function refresh(){
//            $('#gridtable').datagrid('reload');
            loadList();
        }

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


                        $('#gridtable').datagrid({onLoadSuccess : function(data){
                            $('#gridtable').datagrid('selectRow',selectindex);
                        }});
//                        $('#gridtable').datagrid('reload');
                        loadList();
                    }
                }

            });
        }

        function change(){
            if(!selectid)
            {
                layerInfo("请选择要修改的数据！");
                return;
            }
            $.getJSON("/FormDefineValue/checkIsSHByTvId?tvId="+selectid,function(data){
                if(data.success==true) {
                    layerInfo("数据已审核,请先撤销审核后再删除!");
                    return;
                }else {
                    layeropen(800,500,"明细表单","/FormDefineValuehzb/toInput?tdId=${tableId}&tvId="+selectid);
                }
            })
        }


        function addMain(){
            layeropen(400,250,"上报日期表单","/FormDefineValue/addSbrq?tdId=${tableId}");
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
                                    loadList();
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


        function search(){

            if($('#txtDatestart').val()==""){
                layerInfo("请选择查询开始时间！");
                return;
            }
            if($('#txtDateend').val()==""){
                layerInfo("请选择查询截止时间！");
                return;
            }
            $('#gridtable').datagrid({url:'${ctx}/FormDefineFieldValue/getDefineFieldValueBytdId?tdId=${tableId}&cxrqstart='
            + $('#txtDatestart').val()+ '&cxrqend='+ $('#txtDateend').val()+ "&rdm="+ parseInt(Math.random()*100000)})
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
                ' '
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

            <button type="button" class="btn btn-default bi-btn-width90" onclick="check()">审核上报</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="addMain()">新增上报</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="deleteMain()">删除上报</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="change()">编辑数据</button>

        </div>
    </div>
</div>
<div style="padding:0 5px;">
    <table id="gridtable" style="width:100%;" >
    </table>
</div>


</body>
</html>
