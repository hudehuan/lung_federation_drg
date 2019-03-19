<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2017-05-22
  Time: 16:47
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html lang="en">
<head>
    <%--<%@ include file="/common/meta.jsp" %>--%>
    <title>${title}</title>

    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/bootstrap-3.3.5/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${ctx }/static/js/jquery-easyui-1.5/themes/metro/easyui.css">
    <link rel="stylesheet" type="text/css" href="${ctx }/static/js/jquery-easyui-1.5/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/Dldsnfrom.css?=1">
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/style.css">
    <%--<link rel="stylesheet" href="${ctx }/static/js/plugins/layer/skin/layer.css" />--%>
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js"></script>

    <script src="${ctx}/static/js/common.js?v=1" type="text/javascript"></script>
    <script src="${ctx }/static/js/plugins/validationEngine/jquery.validationEngine.js" type="text/javascript" charset="utf-8">
    </script>
    <script src="${ctx }/static/js/plugins/validationEngine/languages/jquery.validationEngine-zh_CN.js" type="text/javascript" charset="utf-8">
    </script>

    <link rel="stylesheet" href="${ctx }/static/js/plugins/validationEngine/css/validationEngine.jquery.css" type="text/css"/>


    <script type="text/javascript" src="${ctx}/static/js/jquery-ui.min.js"></script>
    <script src="${ctx}/static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/pagesjs/customfromCreateVcl.js"></script>
    <style>
        .datagrid-htable {
            height: 22px!important;;
        }
        .datagrid-row {
            height: 21.5px !important;
        }
    </style>
    <script>

        var templateId ="${tempdata.id}";
        var formid ="${tempdata.formId}";
        var vcljson = ${vcljson};
        var formField =[];

        var isedit = false;//是否编辑状态
        $(function () {


            //初始数据
            initControlProperties(vcljson);
            //加载控件数据
            initControlData();
        });

        //表单js
        ${tempdata.formjs};

        function formsave() {
            //配置的fromjs
            ${tempdata.savejs};
            //控件js
            $(tmpvcljson).each(function (i,n) {
                if ( n.vcljs != "" && $("#divvcl_"+fieldName).length>0) {
                    eval(n.vcljs);
                }
           });
        }
        function initControlData(){
            $.getJSON("/customFormData/getOneById?dataId=&tableId="+formid,function(data){

                if(data.success == true){
                    //得到全部的元数据定义
                    formField =data.customFormFieldEntityList;

                }
            });
        }
        function getFormControlValue(controltype,controlName) {

            var values="";
            switch (controltype){
                case  "多选控件":
                case  "1列多选控件":
                case  "2列多选控件":
                case  "3列多选控件":
                case  "4列多选控件":
                    $("input[name=" + controlName + "]:checkbox:checked").each(function(){
                        values += $(this).attr('value')+';';
                    });
                    break;
                case  "单选控件":
                case  "1列单选控件":
                case  "2列单选控件":
                case  "3列单选控件":
                case  "4列单选控件":
                    values = $("input[name=" + controlName + "]:checked").val();
                    break;
                case "日期控件":
                case "日期时间控件":
                case "年月控件":
                case "年控件":
                case "文本控件":
                case "多行文本控件":
                case "数字控件":
                case "字典SQL下拉控件":
                case "字典SQL表格控件":
                case "对应值下拉控件":
                    values =$("#"+controlName).val();
                    break;
            }

            return values;
        }
        function printdate(){
            var formData = "";
            <%--if('${tempdata.style}'=='B'){--%>

            <%--}else {--%>
            $("select").each(function (e, item) {
                var id = $(this).attr("id");
                var value = $(this).attr("value");
                if (!value) {
                    value = "";
                }
                $(this).after("<span id='" + id + "_span' >"+value+"</spna>");
                $(this).hide();
            });
            formData = $("#customform").html();
            formData = "<div style='width:100%;text-align:center;font-size:20px;margin-bottom:5px;font-family:宋体;font-weight: bold;'>${tempdata.name}</div>"+formData
            $("select").each(function (e, item) {
                $(this).next().hide();
                $(this).show();
            });
//            }
            var w = window.open();
            $.ajax({
                url:'/CustomFromPrint/toPDF?dataId=${dataId}&formID=${tempdata.formId}',
                type:'POST',
                dataType:'json',
                data:{"formData":formData},
                async:false,
                error: function(){
                    w.close();
                },
                success:function(data){
                    if(data.success==true){
                        w.location = data.pdfurl;
                    }
                    else{
                        layerInfo(data.msg);
                    }
                }
            });
        }
        function savedata() {
            empty = "";
            var fieldValues = [];
            for(var n = 0;n<formField.length;n++){
                var values = "";
                values = getFormControlValue(formField[n].controlType,formField[n].fieldName);
                var t={
                    field:formField[n].fieldName,
                    fieldvalue:values

                }

                fieldValues.push(t);
            }

            $.ajax({
                type: "POST",
                url: "?tableId="+formid,
                dataType: "json",
                contentType: "application/json",
                data: JSON.stringify(fieldValues),
                success: function (data) {
                    if (data.success == true) {
                        parent.loadList();
                        layerInfo(data.msg);
                        //关闭窗体
                        closeIndexWindwos();
//                        });


                    } else {
                        //alert(data.msg);
                        layerInfo("数据保存失败！");
                    }
                }
            });
        }
    </script>
<html>
<head>
    <title>自定义表单测试专用</title>
</head>
<body>
<div style="width: 100%;height: 40px;position: fixed;top: 0;background: #dff0d8;opacity:0.9; z-index: 100000000000;font-family: 宋体;">
    <div style="position:fixed;right: 0;top: 0; padding-top: 5px;" class="btn-group" role="group" >

        <button type="button" id="savepage_btn"  onclick="" class="btn btn-default bi-btn-width90">保存</button>
        <button type="button" id="loadpage_btn" onclick="" class="btn btn-default bi-btn-width90">审核</button>
        <button type="button" id="viewpageedit_btn"  onclick="printdate()" class="btn btn-default bi-btn-width90">打印</button>
        <button type="button" id="viewpageprint_btn"  onclick="" class="btn btn-default bi-btn-width90">退出</button> &nbsp;&nbsp;

    </div>
</div>
<form id="customform" style="margin-top: 50px">
   ${tempdata.html}



</form>
</body>
</html>
