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
        <link rel="stylesheet" type="text/css" href="${ctx }/static/js/jquery-easyui-1.5/themes/default/easyui.css">
        <link rel="stylesheet" type="text/css" href="${ctx }/static/js/jquery-easyui-1.5/themes/icon.css">
        <link rel="stylesheet" type="text/css" href="${ctx}/static/css/Dldsnfrom.css?v=${num}">
        <link rel="stylesheet" type="text/css" href="${ctx }/static/css/style.css">
        <%--<link rel="stylesheet" href="${ctx }/static/js/plugins/layer/skin/layer.css" />--%>
        <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js"></script>

        <script src="${ctx}/static/js/common.js?v=1" type="text/javascript"></script>
        <script src="${ctx }/static/js/plugins/validationEngine/jquery.validationEngine.js" type="text/javascript" charset="utf-8">
        </script>
        <script src="${ctx }/static/js/plugins/validationEngine/languages/jquery.validationEngine-zh_CN.js" type="text/javascript" charset="utf-8">
        </script>
        <script type="text/javascript" src="${ctx }/static/js/stickUp.min.js"></script>
        <link rel="stylesheet" href="${ctx }/static/js/plugins/validationEngine/css/validationEngine.jquery.css" type="text/css"/>

        <script type="text/javascript" src="${ctx }/static/js/plugins/layer/layer.js"></script>
        <script type="text/javascript" src="${ctx}/static/js/jquery-ui.min.js"></script>
        <script src="${ctx}/static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
        <script type="text/javascript" src="${ctx}/static/js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
        <script type="text/javascript" src="${ctx}/static/js/pagesjs/customfromCreateVcl.js?v=${num}"></script>
        <script type="text/javascript" src="/static/json/sjsbJson.js?v=${num}"></script>
        <script src="${ctx}/static/js/FormValidation.js?v=${num}" type="text/javascript"></script>
    <script>

        var templateId ="${tempdata.id}";
        var formid ="${tempdata.formId}";
        var dataId = '${dataId}';
        var defaultDate = ${defaultDate};
        var vcljson = ${vcljson};
        var formField = [];
        var isedit = false;//是否编辑状态
        var dataJson  = [];

        //按钮控制
        var code ='${formCode}';
        var crbattr = 'CrbBbkEntity';
        var zyattr = 'SjsbBdSrhwsbEntity,SjsbBdYszxsbEntity,SjsbBdTssbEntity,SjsbBdZszssbEntity,' +
            'SjsbBdSzlysbEntity,SjsbBdDdzcsbEntity,SjsbBdYcsbEntity,SjsbBdQthlblsjsbEntity,SjsbBdYpblfysbEntity,' +
            'SjsbBdDdzcpfEtEntity,SjsbDbYcpfEtEntity,SjsbDbYcpfCrEntity,SjsbBdDdzcpfCrEntity,SjsbBdZszspgEntity,' +
            'SjsbBdZsfxpgEntity,SjsbBdDdzcybCrEntity,SjsbBdDdzcybEtEntity,SjsbBdYcybCrEntity,SjsbBdYcybEtEntity,' +
            'SjsbBdDghtsbEntity,SjsbBdDghtpgEntity';
        var pfattr = '';
        $(function () {


            //表单验证初始化
            $('#customform').validationEngine('attach', {
                scroll: false,
                autoHidePrompt: true,//自动隐藏错误
                autoHideDelay: 1000,//延时隐藏时间
                addFailureCssClassToField: "from-myerror"
            });



            //grid控件添加打印样式
            $("input[class='textbox-value']").each(function(e,item){
                $(this).prev().addClass("form-control input-sm ");
                $(this).prev().attr("style","width:144px; display: inline-block;");
            });
            setTimeout(function(){
                $(".btn-group-right").stickUp();
            },1)

            //初始控件数据和属性
            initControlProperties(vcljson);

            initDefaultDate(vcljson,defaultDate);

            //加载控件数据
            initControlData();

            showHz(code,crbattr,'crbhz');
            showHz(code,zyattr,'zyhz');
            showHz(code,pfattr,'pfhz');

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

            savedata();


        }


        function savedata() {
            empty = "";

            if(!validateForm()){
                 return;
            }
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
                url: "/customFormData/saveOne?tableId=${tableId}",
                dataType: "json",
                contentType: "application/json",
                data: JSON.stringify(fieldValues),
                success: function (data) {

                    if (data.success == true) {
                        parent.loadList();
                        layerSuccess(data.msg, function () {
                            //关闭窗体
                            closeIndexWindwos();
                        });


                    } else {
                        //alert(data.msg);
                        layerInfo("数据保存失败！");
                    }
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

        function initControlData(){
            $.getJSON("/customFormData/getOneById?dataId=${dataId}&tableId=${tableId}",function(data){

                if(data.success == true){
                    dataJson  = data.entity;
                    //得到全部的元数据定义
                    formField =data.customFormFieldEntityList;
                    //绑定现在值到控件
                    initControlValues(data);

                    //设置控件属性，是否隐藏和是否只读、是否编辑时只读
                    //initControlProperties();

                }
            });
        }

        function initControlValues(data){

            //绑定现在值到控件
            for(var n=0;n<data.customFormFieldEntityList.length;n++){

                var value = data.entity[data.customFormFieldEntityList[n].fieldName];
                if(value=="" || value == null) continue;
                var fieldName = data.customFormFieldEntityList[n].fieldName;

                switch (data.customFormFieldEntityList[n].controlType){
                    case  "多选控件":
                    case  "1列多选控件":
                    case  "2列多选控件":
                    case  "3列多选控件":
                    case  "4列多选控件":
                        CheckboxValue(value,fieldName);
                        break;
                    case  "单选控件":
                    case  "1列单选控件":
                    case  "2列单选控件":
                    case  "3列单选控件":
                    case  "4列单选控件":
                        //values = $("input[name=" + controlName + "]:checked").val();
                        $("input[name=" + fieldName + "][value='"+value+"']").attr("checked", 'checked');
                        break;
                    case "多行文本控件":
                        $("#"+fieldName).text(value);
                        break;
                    case "文本控件":
                    case "数字控件":
                    case "日期控件":
                    case "日期时间控件":
                    case "年月控件":
                    case "年控件":
                        $("#"+fieldName).attr("value",value);
//                        $("#"+fieldName).val(value);
                        break;
                    case "字典SQL下拉控件":
                    case "对应值下拉控件":
                        $("#"+fieldName+" option[value='"+value+"']").attr("selected", "selected");
                        var mc = $("#"+fieldName+" option[value='"+value+"']").text();
                        $("#"+fieldName).attr("name", "select");
                        $("#"+fieldName).attr("value", mc);
                        break;
                    case "字典SQL表格控件":
                        $('#' + fieldName + "_wmc").combogrid('grid').datagrid('selectRecord',value);
                        //打印赋值
                        var mc = $('#' + fieldName + "_wmc").combogrid('getText');
                        $('#' + fieldName + "_wmc").attr("value",mc);
                        $("input[value='"+value+"'][class='textbox-value']").prev().attr("value",mc);
                        break;
//                        $('#' + fieldName + "_wmc").combogrid('grid').datagrid('selectRecord',value);
//                        break;
                }
            }
        }

        // 给checkbook赋值
        function CheckboxValue(value, name) {
            if (value != "") {
                var values = new Array();
                values = value.split(";");
                $.each(values, function (i, item) {
                    if(item != ""){
                        $("input[name=" + name + "][value=" + item + "]").attr("checked", "checked");
                    }

                });
            }
        }


        function printdate(){
            $("select").each(function(e,item){
                var id = $(this).attr("id");
                var value = $(this).attr("value");
                if(!value){
                    value = "";
                }
                $(this).after("<span id='" + id + "_span' >"+value+"</spna>");
                $(this).hide();
            });
            var formData = $("#customform").html();
            formData = $.action.replaceAll(formData,"\\*","");
            formData = "<div style='width:100%;text-align:center;font-size:20px;margin-bottom:5px;font-family:宋体;font-weight: bold;'>${tempdata.name}</div>"+formData
            $("select").each(function(e,item){
                $(this).next().hide();
                $(this).show();
            });
            var w = window.open();
            $.ajax({
                url:'/CUSTOMFORMPrint/toPDF?dataId=${dataId}&formID=${tableId}',
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
        function zyhz(){
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(width,height,"患者选择","/V_searchHz/toZyHzSearch" );
        }
        function crbhz(){
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(width,height,"患者选择","/V_searchHz/toCrbHzSearch" );

        }
        function pfhz(){
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(width,height,"患者选择","/V_searchHz/toPfHzSearch?formCode="+code );

        }



        // 检查各项填入内容是否符合规定
        var empty = "";//看是否为空
        function validateForm() {
            empty = "";//看是否为空
            for(var n = 0;n<formField.length;n++){

                var fieldName = formField[n].fieldName;
                var notrim = $("#divvcl_"+fieldName).attr("notrim");
                var noshow = $("#divvcl_"+fieldName).attr("noshow");
                var regex = $("#divvcl_"+fieldName).attr("regex");
                var edtreadonly = $("#divvcl_"+fieldName).attr("edtreadonly");
                var vclopt = $("#divvcl_"+fieldName).attr("vclopt");


                if(regex != ""){

                    //regExp_check(fieldName,regex);
                    var value=$("#"+fieldName).val();
                    var re=new RegExp(regex);
                    if(re.test(value) == false){

                        $("#" + fieldName).validationEngine('showPrompt', '*此项格式错误', 'error', true);
                        empty+="0,";
                    }
                    else{
                        empty+="1,";
                    }
                }

                switch (formField[n].controlType){
                    case  "文本控件":
                    case "日期控件":
                    case "日期时间控件":
                    case "年月控件":
                    case "年控件":
                    case "多行文本控件":
                    case "数字控件":
                    case "对应值下拉控件":
                        if(notrim==1){
                            required(fieldName);
                        }
                        break;
                    case "字典SQL表格控件":
                    case "字典SQL下拉控件":
                        if(notrim==1){
                            if ($("#" + fieldName).val() == "undefined" || $('#' + fieldName).val() == "") {
                                $('#' + fieldName+"_wmc").next().validationEngine('showPrompt', '*此项必填', 'error', true);
                                empty += fieldName + "0,";
                            }
                            else {
                                empty += fieldName + "1,";
                            }
                        }
                        break;
                    case "单选控件":
                    case  "1列单选控件":
                    case  "2列单选控件":
                    case  "3列单选控件":
                    case  "4列单选控件":
                        if(notrim==1) {
                            required_radio(fieldName);
                        }
                        break;
                    case  "多选控件":
                    case  "1列多选控件":
                    case  "2列多选控件":
                    case  "3列多选控件":
                    case  "4列多选控件":
                        if(notrim==1) {
                            required_checkbox(fieldName);
                        }
                        break;
                }
            }

            if (empty.indexOf("0,") >= 0) {
                return false;
            }else{
                return true;
            }
        }


    </script>
        <style>
            body{overflow-y: auto;}
            .bi-stickUp{
                display:block;background-color:#dff0d8 ;opacity:0.9;padding:5px;overflow: hidden;width:100%;z-index: 999;border:1px solid #dff0d8;
            }
        </style>
    <html>
    <head>
        <title>自定义表单测试专用</title>
    </head>
<body>
    <div class="btn-group-right bi-stickUp" >
        <div class="btn-group "  role="group" style="float:right">
            <div id="divhz" class="btn-group "   >
                <button type="button" class="btn btn-default bi-btn-width90" style="display: none" onclick="zyhz()" id="zyhz">患者选择</button>
                <button type="button" class="btn btn-default bi-btn-width90" style="display: none" onclick="crbhz()" id="crbhz">患者选择</button>
                <button type="button" class="btn btn-default bi-btn-width90" style="display: none" onclick="pfhz()" id="pfhz">患者选择</button>
            </div>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="savedata()">保存数据</button>

            <button type="button" class="btn btn-default bi-btn-width90" onclick="printdate()" >打印</button>
        </div>
    </div>


<form id="customform" style="margin-top:10px">

    ${tempdata.html}



</form>
</body>
</html>
