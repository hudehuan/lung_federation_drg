<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2017/5/8
  Time: 11:18
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
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/Dldsnfrom.css?=1">
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/style.css">
    <%--<link rel="stylesheet" href="${ctx }/static/js/plugins/layer/skin/layer.css" />--%>
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js"></script>


    <link href="${ctx}/static/js/htmlxjs/skins/dhtmlxgrid.css" rel="stylesheet" type="text/css" />
    <script src="${ctx}/static/js/htmlxjs/dhtmlxcommon.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/htmlxjs/dhtmlxcontainer.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/htmlxjs/dhtmlxgrid.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/htmlxjs/dhtmlxgridcell.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/htmlxjs/dhtmlxgrid_filter.js" type="text/javascript"></script>

    <script type="text/javascript" src="${ctx}/static/js/plugins/layer/layer.js"></script>
    <script src="${ctx}/static/js/common.js?v=1" type="text/javascript"></script>

    <script src="${ctx }/static/js/plugins/validationEngine/jquery.validationEngine.js" type="text/javascript" charset="utf-8">
    </script>
    <script src="${ctx }/static/js/plugins/validationEngine/languages/jquery.validationEngine-zh_CN.js" type="text/javascript" charset="utf-8">
    </script>

    <link rel="stylesheet" href="${ctx }/static/js/plugins/validationEngine/css/validationEngine.jquery.css" type="text/css"/>


    <script type="text/javascript" src="${ctx}/static/js/jquery-ui.min.js"></script>
    <script src="${ctx}/static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/FormValidation.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/pagesjs/DldsnFrom.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery-easyui-1.5/jquery.easyui.min.js"></script>


    <script>

        var formField = [];


        $(function () {

            //表单验证初始化
            $('#customform').validationEngine('attach', {
                scroll: false,
                autoHidePrompt: true,//自动隐藏错误
                autoHideDelay: 1000,//延时隐藏时间
                addFailureCssClassToField: "from-myerror"
            });

            // 自定义参数调用
            //var templateId = GetUrlParam("templateId");
            $.getJSON("/customFormData/getOneById?dataId=${dataId}&tableId=${tableId}",function(data){

                if(data.success == true){
                    //得到全部的元数据定义
                    formField =data.customFormFieldEntityList;
                    //绑定现在值到控件
                    initControlValues(data);
                    //设置控件属性，是否隐藏和是否只读、是否编辑时只读
                    initControlProperties();

                }
            });

        });
        
        
        function initControlData() {

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
                    case "文本控件":
                        $("#"+fieldName).val(value);
                        break;
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

        function initControlProperties() {
            //设置控件属性，是否隐藏和是否只读、是否编辑时只读
            for(var n = 0;n<formField.length;n++){
                var fieldName = formField[n].fieldName;
                var noshow = $("#divvcl_"+fieldName).attr("noshow");
                var edtreadonly = $("#divvcl_"+fieldName).attr("edtreadonly");
                if(noshow == 1){
                    set_show(fieldName,'none');
                }
                if(edtreadonly == 1 && "${dataId}" != ""){
                    set_readonly(fieldName,true);
                }


                //对选择框进行数据初始化
                switch (formField[n].controlType){

                    case  "字典SQL表格控件":

                        initSqlGridData(fieldName);
                        break;

                }
            }
        }

        function initSqlGridData(fieldName) {
            var url = "${ctx}CustomFormFieldTemplategetSqlData?templateId=${templateId}&fieldCode="
                +fieldName+"&tableId=${tableId}" + "&rdm="+ parseInt(Math.random()*100000);
            initSearchGrid(fieldName,url,
                [{field:'dm',title:'维代码',width:"70px"},
                    {field:'mc',title:'维名称',width:"100px"}],
                function(index,row){
                    //alert("选中行id:"+row.dm);
                    $("#"+fieldName).val(row.name);
                    //$("#wdm").val(row.dm);
                })
        }


        /**
         * @param {Object} id 控件id
         * @param {Object} ajaxurl 远程搜索地址
         * @param {Object} gridcolumn gird显示的行
         * @param {Object} selectEvent 选中回调事件
         */
        function initSearchGrid(id,ajaxurl,gridcolumn,selectEvent){

            var grid;
            var keyword="";
            var autoid="gridtable_"+id;
            //加载grid
            this.loadData=function(gid,Sevent){
                $('#'+gid).datagrid({
                    url:ajaxurl+keyword,
                    method:'get',
                    singleSelect:true,//是否只能选中一行
                    pagination:false,//是否启动分页
                    rownumbers:true,
                    columns:[gridcolumn],
                    //选中行事件
                    onSelect : function(index, row){
                        Sevent&&Sevent(index,row);
                    }
                });
                $('#'+gid).height($(".tooltip").height()-10);
            };
            $('#'+id).tooltip({
                position: 'bottom',
                content: '<table id="'+autoid+'"></table>',
                showEvent:"focus",
                hideEvent:"aa",
                onShow: function(){

                    //调整提示框位置
                    var top=$(this).tooltip('tip').offset().top-5;
                    $(this).tooltip('tip').attr("id","tips_"+id);
                    $(this).tooltip('tip').css({
                        top:top+'px'
                    });
                    //提示框鼠标离开事件
                    $("#tips_"+id).mouseleave(function(){

                        if($('#'+id+':focus').attr("id")!=id)
                            $("#tips_"+id).hide();
                    })
                    //绑定搜索框change事件
                    $("#"+id).unbind("input");
                    $("#"+id).unbind("propertychange");
                    $("#"+id).bind('input propertychange', function() {
                        //if($("#"+id).val()!="")
                        //{
                        keyword="keyword="+unescape($("#"+id).val());
                        if(ajaxurl.indexOf("?")>=0)
                        {
                            keyword="&"+keyword;
                        }else
                        {
                            keyword="?"+keyword;
                        }
                        loadData("gridtable_"+id,selectEvent);
                        //}
                    });
                    //加载过就不加载
                    if($("#tips_"+id).find(".datagrid").length<=0)
                        loadData("gridtable_"+id,selectEvent);
                }
            })
        }


        
        function savedata() {
            empty = "";

            if(!validateForm()){
               // return;
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
                url: "/customFormData/saveOne?tableId=${tableId}&templateId=${templateId}",
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
                case "文本控件":
                    values =$("#"+controlName).val();

                    break;
            }

            return values;
        }


        // 检查各项填入内容是否符合规定
        var empty = "";//看是否为空
        function validateForm() {

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
                        if(notrim==1){
                            required(fieldName);
                        }
                        break;

                    case "单选控件":
                        if(notrim==1) {
                            required_radio(fieldName);
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

</head>
<body>
<%--<div class="navheader form-inline" style="padding:0 5px;height:40px;">

    <div class="btn-group-right">
        <div class="btn-group "  role="group">
        </div>
    </div>
</div>--%>

<div style="width: 100%;height: 40px;position: fixed;top: 0;background: #dff0d8;opacity:0.9; z-index: 100000000000;font-family: 宋体;">
    <div style="position:fixed;right: 0;top: 0; padding-top: 5px;" class="btn-group" role="group" >

        <button type="button" class="btn btn-default bi-btn-width90" onclick="savedata()">保存审核</button>
        <button type="button" class="btn btn-default bi-btn-width90" onclick="shdata()" >审核</button>
        <button type="button" class="btn btn-default bi-btn-width90" onclick="printdate()">打印</button>
        <button type="button" id="viewpageprint_btn"  onclick="" class="btn btn-default bi-btn-width90">退出</button> &nbsp;&nbsp;

    </div>
</div>
<form id="customform">

${entity.html}


</form>


</body>
</html>
