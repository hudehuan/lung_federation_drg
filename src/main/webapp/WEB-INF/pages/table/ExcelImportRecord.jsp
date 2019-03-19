<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/8/31
  Time: 9:33
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
    <link rel="stylesheet" type="text/css" href="/static/js/bootstrap-3.3.5/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/static/js/jquery-easyui-1.5/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="/static/css/style.css">
    <link rel="stylesheet" href="/static/js/plugins/layer/skin/layer.css" />
    <script type="text/javascript" src="/static/js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="/static/js/common.js"></script>
    <script type="text/javascript" src="/static/js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/static/js/plugins/layer/layer.js"></script>
    <script type="text/javascript" src="/static/js/easyuiPager.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/My97DatePicker/WdatePicker.js"></script>


    <script>
        var selectrecordid=null;//选中的参数id
        var tableColumns=[];

        $(function(){
            $.ajaxSettings.async = false;
            $.getJSON("${ctx}/ExcelImportRecord/getStructure?tableId=${tableId}",function(data){
                for(var i=0;i<data.length;i++){
                     var field ={ field: data[i].name , title: data[i].zhName, width: '70px', align: 'left',halign: 'center'};
                    tableColumns.push(field)


                }

            });
            $.ajaxSettings.async = true;

            var height = findDimensions_height();
//            document.documentElement.clientHeight=(height-3)+"px";
            $("#l_datagrid").height(height-50);
            var myDate = new Date();
            var year =  myDate.getFullYear();
            var startTime = year+ "-01";
            var endTime = year + "-12";
            $("#startTime").val(startTime);
            $("#endTime").val(endTime);
            $('#l_datagrid').datagrid(
                    {
                        url:'${ctx}/ExcelImportRecord/getRecordByTableIdBytime?tableId=${tableId}&startTime='+startTime+'&endTime='+endTime,
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,//是否能够选中一行
                        autoRowHeight:false,
                        columns: [
                            [
                                { field: 'id', title: 'id', width: '40px', align: 'left',halign: 'center',hidden:true},
                                {
                                    field: 'isSh', title: '审核', width: '40px', align: 'left',halign: 'center',
                                    formatter:function (value, row, index) {
                                        switch (value) {
                                            case true:
                                                return "√";

                                        }

                                    }
                                },
                                { field: 'inputDate', title: '数据日期', width: '60px', align: 'left', sortable:true,halign: 'center',formatter:formatDatebox},
                                { field: 'userName', title: '导入人', width: '30px', align: 'left', sortable:true,halign: 'center'},
                                { field: 'importDate', title: '导入日期', width: '40px', align: 'left', sortable:true,halign: 'center',formatter:formatDatebox}

                            ]
                        ],
                        onSelect : function(index, row){
                            selectrecordid=row.id;
                            //loadData(selectrecordid);
                            //selectindex=index;
                            $('#r_datagrid').datagrid({url:'/ExcelImportRecord/loadData?recordId='+ row.id+'&tableId='+row.tableId})
                        }
                    }).datagrid('clientPaging');


            $("#r_datagrid").height(height-50);
            $('#r_datagrid').datagrid(
                    {
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
                            tableColumns
                        ]


                    }).datagrid('clientPaging');
        });

        function search(){
            var startTime = $("#startTime").val();
            var endTime = $("#endTime").val();
            $('#l_datagrid').datagrid(
                    {
                        url:'${ctx}/ExcelImportRecord/getRecordByTableIdBytime?tableId=${tableId}&startTime='+startTime+'&endTime='+endTime
                    })
        }

        function addDate(){
            layeropen(450,250,"新增导入日期","${ctx}/ExcelImport/toaddImportDate?tableId=${tableId}");
        }

        function openwin(){
            if(selectrecordid==null)
            {
                layerInfo("请选择要导入的日期！");
                return;
            }
            layeropen(600,300,"Excel数据导入","${ctx}/ExcelImport/toImport?tableId=${tableId}&recordId="+selectrecordid);
        }
        function deleteR(){
            if(selectrecordid==null)
            {
                layerInfo("请选择要删除的数据！");
                return;
            }
            layerConfirm("是否确定删除?",f_delete);
        }
        function f_delete(){
            //$('#l_datagrid').datagrid('deleteRow', selectrecordid);

            $.ajax({
                type:'post',
                url:'${ctx}/ExcelImportRecord/deleteImportData?recordId='+selectrecordid,
                dataType:'json',
                success:function(data){
                    if(data.success== true){
                        layerInfo("成功删除导入的数据！");
                        $('#l_datagrid').datagrid('reload');
                        $('#r_datagrid').datagrid('reload');

                        selectrecordid=null;//选中的参数id
                    }else{
                        layerInfo("导入数据已审核，请先取消审核！");
                    }
                }

            });


            //selectindex=0;
        }

        function recordSH(){
            $.ajax({
                type:'post',
                url:'${ctx}/ExcelImportRecord/checkImportData?recordId='+selectrecordid,
                dataType:'json',
                success:function(data){
                    if(data.success== true){
                        layerInfo(data.msg);
                        $('#l_datagrid').datagrid('reload');
                        //$('#r_datagrid').datagrid('reload');
                    }
                }

            });
        }

        function refresh(){
            $('#r_datagrid').datagrid('reload');
            $('#l_datagrid').datagrid('reload');
        }
        // 	加载复选框

        Date.prototype.format = function (format) {
            var o = {
                "M+": this.getMonth() + 1, // month
                "d+": this.getDate(), // day
                "h+": this.getHours(), // hour
                "m+": this.getMinutes(), // minute
                "s+": this.getSeconds(), // second
                "q+": Math.floor((this.getMonth() + 3) / 3), // quarter
                "S": this.getMilliseconds()
                // millisecond
            }
            if (/(y+)/.test(format))
                format = format.replace(RegExp.$1, (this.getFullYear() + "")
                        .substr(4 - RegExp.$1.length));
            for (var k in o)
                if (new RegExp("(" + k + ")").test(format))
                    format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
            return format;
        }
        function formatDatebox(value) {
            if (value == null || value == '') {
                return '';
            }
            var dt;
            if (value instanceof Date) {
                dt = value;
            } else {
                dt = new Date(value);
            }

            return dt.format("yyyy-MM-dd hh:mm:ss"); //扩展的Date的format方法(上述插件实现)
        }


        function download(){

            //window.open('/table/download?tableId=${tableId}')
            location.href = '/table/download?tableId=${tableId}'
        }

    </script>
    <style>
        /*去掉滚动条*/
        body{overflow-y:hidden;}
    </style>


</head>
<body>


<div class="navheader form-inline" style="padding:0 5px;height:40px;">
    <div class=" form-group">
        <label for="startTime">查询</label>
        <input type="text" style ="width: 80px;" class="form-control Wdate" name="startTime" value="" id="startTime"
               onfocus="WdatePicker({el:'startTime',dateFmt:'yyyy-MM'})">
        <label>至</label>

        <input type="text"style ="width: 80px;" class="form-control Wdate" name="endTime" value="" id="endTime"
               onfocus="WdatePicker({el:'endTime',dateFmt:'yyyy-MM'})">

        <button type="button" class="btn btn-success bi-btn-search" onclick="search()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>
    <div class="btn-group-right">
        <div class="btn-group "  role="group">
            <button type="button" class="btn btn-default bi-btn-width90" onclick="refresh()">刷新</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="download()">下载模板</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="addDate()">新增导入日期</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="openwin()">导入数据</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="recordSH()">审核</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="deleteR()">删除</button>
        </div>
    </div>
</div>

<div style="margin:0 5px; overflow: hidden;" >
    <!--左边表格-->
    <div style="width:20%;float:left;display:inline-block;padding-right:5px;border-right:1px dotted #ccc;" >
        <table id="l_datagrid"class="datagrid"></table>

    </div>
    <!--右边表格 -->
    <div style="width:80%;float:right;display:inline-block;padding-left:5px;">
        <table id="r_datagrid" class="datagrid"></table>
    </div>
</div>



</body>
</html>
