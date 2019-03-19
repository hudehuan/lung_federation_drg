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
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/style.css?v1=3">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/jquery-easyui-1.5/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/jquery-easyui-1.5/themes/default/easyui.css">
    <link rel="stylesheet" href="${ctx}/static/js/plugins/layer/skin/layer.css"/>
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/easyuiPager.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/common.js"></script>

    <script>
        var selectid = null;//选中的参数id
        var selectindex = 0;


        function refresh() {
//            $('#datagrid').datagrid('reload');
            loadList();
        }

        //var r_tableFields=[];
        $(function () {

            var height = findDimensions_height();
            $("#datagrid").height(height - 50);
            $(".bi-table").height(height - 50);
            $("#inputdiv").height($(".bi-table").height() - $("#tab").height()-18);

//            loadList();
            $('#datagrid').datagrid(
                    {
                        url: '/FormDefineValue/queryDefineValue?tdId=${tableId}&cxrqstart=${starttime}&cxrqend=${startend}'
                        + "&rdm="+ parseInt(Math.random()*100000),
                        method: 'get',
                        rownumbers: true,
                        singleSelect: true,
                        autoRowHeight: false,
                        columns: [
                            [
                                {field: 'tvId', title: 'ID', width: '100px', hidden: true},
                                {
                                    field: 'isSh',
                                    title: '审核',
                                    width: '60px',
                                    align: 'left',
                                    sortable: true,
                                    halign: 'center',
                                    formatter: function (value, row, index) {
                                        switch (value) {
                                            case true:
                                                return "√";

                                        }

                                    }
                                },
                                {
                                    field: 'rq',
                                    title: '上报日期',
                                    width: '110px',
                                    align: 'left',
                                    sortable: true,
                                    halign: 'center'
                                },
                                {
                                    field: 'inputDate',
                                    title: '输入日期',
                                    width: '140px',
                                    align: 'left',
                                    sortable: true,
                                    halign: 'center',
                                    formatter: function (value, row, index) {
                                        if (value != null) {
                                            return jsonYearMonthDay(value);
                                        }
                                    }
                                }
                            ]
                        ],
                        onSelect: function (index, row) {
                            selectid = row.tvId;
                            selectindex = index;
                            loadTable(row.tvId);


                        }
                    });
        });

        function loadList() {
            $('#datagrid').datagrid(
                    {
                        url: '/FormDefineValue/queryDefineValue?tdId=${tableId}&cxrqstart=${starttime}&cxrqend=${startend}'
                        + "&rdm="+ parseInt(Math.random()*100000)
                    });
        }

        function loadTable(tvId){
            $.getJSON("/FormDefineFieldValue/getFormFieldValues?tdId=${tableId}&tvId=" + tvId+ "&rdm="+ parseInt(Math.random()*100000), function (data) {
                var ss = '';
                $('#inputdiv').html(ss);
                for (var n = 0; n < data.formDefineFieldEntityList.length; n++) {
                    ss = ss + "<div class='bi-form-div'>";
                    if (data.formDefineFieldEntityList[n].level == null) {
                        ss = ss + "<div></div>";
                    } else {
                        ss = ss + "<div>" + data.formDefineFieldEntityList[n].level + "</div>";
                    }
                    if (data.formDefineFieldEntityList[n].fdName == null) {
                        ss = ss + "<div></div>";
                    } else {
                        ss = ss + "<div >" + data.formDefineFieldEntityList[n].fdName + "</div>";
                    }


                    if (data.formDefineFieldEntityList[n].itemId != null) {
                        if (data.formDefineFieldValueEntityList.length > 0) {
                            var c = 0;
                            for (var m = 0; m < data.formDefineFieldValueEntityList.length; m++) {
                                if (data.formDefineFieldEntityList[n].fdId == data.formDefineFieldValueEntityList[m].fdId) {
                                    ss = ss + "<div><input  type='text'  class='inputfield form-control' value='" + data.formDefineFieldValueEntityList[m].fdValue + "'";
                                    ss = ss + " data-item='" + data.formDefineFieldEntityList[n].itemId + "' data-fdid='" + data.formDefineFieldEntityList[n].fdId + "'";
                                    ss = ss + " data-tdid='" + data.formDefineFieldEntityList[n].tdId + "' data-fdname='" + data.formDefineFieldEntityList[n].fdName + "'";
                                    ss = ss + " data-fvid='" + data.formDefineFieldValueEntityList[m].fvId + "'/></div>";

                                    c++;
                                }
                            }

                            if (c == 0) {
                                ss = ss + "<div><input  type='text'  class='inputfield form-control'";
                                ss = ss + " data-item='" + data.formDefineFieldEntityList[n].itemId + "' data-fdid='" + data.formDefineFieldEntityList[n].fdId + "'";
                                ss = ss + " data-tdid='" + data.formDefineFieldEntityList[n].tdId + "' data-fdname='" + data.formDefineFieldEntityList[n].fdName + "'";
                                ss = ss + " data-fvid=''/></div>";
                            }
                        }
                        else {
                            ss = ss + "<div><input  type='text'  class='inputfield form-control'";
                            ss = ss + " data-item='" + data.formDefineFieldEntityList[n].itemId + "' data-fdid='" + data.formDefineFieldEntityList[n].fdId + "'";
                            ss = ss + " data-tdid='" + data.formDefineFieldEntityList[n].tdId + "' data-fdname='" + data.formDefineFieldEntityList[n].fdName + "'";
                            ss = ss + " data-fvid=''/></div>";
                        }


                    }
                    if (data.formDefineFieldEntityList[n].unit == null) {
                        ss = ss + "<div></div>";
                        ss = ss + "</div>";
                    } else {
                        ss = ss + "<span class=\"long_tit\">" + data.formDefineFieldEntityList[n].unit + "</span>";
                        ss = ss + "</div>";
                    }


                }


                $('#inputdiv').html(ss);
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
        //审核
        function check() {
            if (!selectid) {
                layerInfo("请选择要审核的数据！");
                return;
            }

            $.ajax({
                url: '${ctx}/FormDefineValue/updatesh?tvId=' + selectid,
                type: 'post',
                dataType: 'json',
                success: function (data) {
                    if (data.success == true) {
                        layerInfo(data.msg);


                        $('#datagrid').datagrid({
                            onLoadSuccess: function (data) {
                                $('#datagrid').datagrid('selectRow', selectindex);
                            }
                        });
//                        $('#datagrid').datagrid('reload');
                        loadList();
                    }
                }

            });
        }


        function checkIsSH() {
            $.ajaxSettings.async = false;
            $.getJSON("/FormDefineValue/checkIsSH?rq=" + $("#date").val() + "&tdId=${tdId}", function (data) {

                debugger;
                if (data.success == true) {
                    layerInfo(data.msg);
                    return true;
                }
                else {
                    return false;
                }
            });
            $.ajaxSettings.async = true;
        }


        function saveInput() {

            if (checkIsSH()) {
                return;
            }

            var fieldValues = [];
            $.each($(".inputfield"), function (i, n) {
                //carAddGoodsCookie(goodsList[$(n).data("id")].goodsId);
                var d = {
                    tdId: $(n).data("tdid"),
                    fdId: $(n).data("fdid"),
                    fdName: $(n).data("fdname"),
                    fieldValue: $(n).val(),
                    itemId: $(n).data("item"),
                    //wdm:$("#wdm").val(),
                    //rq:$("#date").val(),
                    tvId: selectid,
                    fvId: $(n).data("fvid")
                }

                fieldValues.push(d);
            })
            $.getJSON("/FormDefineValue/checkIsSHByTvId?tvId=" + selectid, function (data) {
                if (data.success == true) {
                    layerError("数据已审核,禁止修改!");
                    return;
                } else {
                    $.ajax({
                        type: "POST",
                        url: "/FormDefineFieldValue/saveInputHza",
                        dataType: "json",
                        contentType: "application/json",
                        data: JSON.stringify(fieldValues),
                        success: function (data) {

                            if (data.success == true) {
                                //alert(data.msg);
                                //parent.refresh();
                                loadTable(selectid);
                                layerSuccess(data.msg);
                            } else {
                                //alert(data.msg);
                                layerInfo("数据保存失败！");
                            }

                            // $.messager.progress("close");
                        }
                    });
                }
            });




        }


        function addMain() {
            layeropen(450, 250, "上报日期表单", "/FormDefineValue/addSbrq?tdId=${tableId}");
        }

        //新增主表


        function deleteMain() {
            if (!selectid) {
                layerInfo("请选择要删除的数据！");
                return;
            }
            layerConfirm("是否确定删除?", function () {
                //$('#l_datagrid').datagrid('deleteRow', selectindex);

                $.getJSON("/FormDefineValue/checkIsSHByTvId?tvId=" + selectid, function (data) {
                    if (data.success == true) {
                        layerInfo("数据已审核,请先撤销审核后再删除!");
                        return;
                    } else {
                        //数据未审核时
                        $.ajax({
                            url: '/FormDefineValue/deleteDefineValue?tvId=' + selectid,
                            type: 'post',
                            dataType: 'json',
                            success: function (data) {
                                if (data.success == true) {
                                    layerInfo(data.msg);
//                                    $('#datagrid').datagrid('reload');
                                    loadList();
                                    selectid = null;
                                }
                                else {
                                    layerInfo(data.msg);

                                }
                            }
                        });
                    }
                });


            });

        }


        function search() {
            if ($('#txtDatestart').val() == "") {
                layerInfo("请选择查询开始时间！");
                return;
            }
            if ($('#txtDateend').val() == "") {
                layerInfo("请选择查询截止时间！");
                return;
            }
            $('#datagrid').datagrid({url: '${ctx}/FormDefineValue/queryDefineValue?tdId=${tableId}&cxrqstart='
            + $('#txtDatestart').val() + '&cxrqend=' + $('#txtDateend').val()+ "&rdm="+ parseInt(Math.random()*100000)})
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
                ''
                }"/>})"
               style="height:25px;width:90px;border-color:#dcdcdc;" value="${startend}"/>

        <button type="button" class="btn btn-success bi-btn-search" onclick="search()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>


    <div class="btn-group-right">
        <div class="btn-group " role="group">
            <button type="button" class="btn btn-default bi-btn-width90" onclick="check()">审核上报</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="addMain()">新增上报</button>
            <!--主表是左边的表-->
            <button type="button" class="btn btn-default bi-btn-width90" onclick="saveInput()">保存数据</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="deleteMain()">删除上报</button>
        </div>
    </div>
</div>

<div style="margin:0 5px; overflow: hidden;">
    <!--左边表格-->
    <div style="width:20%;float:left;display:inline-block;padding-right:5px;border-right:1px dotted #ccc;">
        <table id="datagrid" class="datagrid"></table>

    </div>
    <!--右边表单 -->

    <%--<input type="hidden"   name="tvId" id="tvId" value="${tvId}">--%>
    <input type="hidden" name="tdId" id="tdId" value="${tableId}">

    <div style="width:80%;float:right;display:inline-block;padding-left:5px;">
        <div class="panel panel-default bi-table" style="border:1px solid #ddd;border-radius: 5px;">
            <div class="panel-heading" id="tab">表格</div>

            <div id="inputdiv"  style=" overflow-y:auto;">
                <%--class="bi-table"/--%>
            </div>

        </div>

    </div>

</div>

</body>
</html>
