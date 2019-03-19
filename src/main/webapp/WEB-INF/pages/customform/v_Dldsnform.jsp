<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2017/4/19
  Time: 17:26
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="UTF-8">
    <title>${title}</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/bootstrap-3.3.5/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/Dldsnfrom.css?=3">
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js"></script>


    <link href="${ctx}/static/js/htmlxjs/skins/dhtmlxgrid.css" rel="stylesheet" type="text/css" />
    <script src="${ctx}/static/js/htmlxjs/dhtmlxcommon.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/htmlxjs/dhtmlxcontainer.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/htmlxjs/dhtmlxgrid.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/htmlxjs/dhtmlxgridcell.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/htmlxjs/dhtmlxgrid_filter.js" type="text/javascript"></script>
    <link href="${ctx}/static/js/plugins/codemirror-5.14.2/lib/codemirror.css" rel="stylesheet" />
    <script src="${ctx}/static/js/plugins/codemirror-5.14.2/lib/codemirror.js"></script>
    <script src="${ctx}/static/js/plugins/codemirror-5.14.2/mode/javascript/javascript.js"></script>
    <script src="${ctx}/static/js/plugins/codemirror-5.14.2/mode/xml/xml.js"></script>
    <script src="${ctx}/static/js/plugins/codemirror-5.14.2/mode/css/css.js"></script>
    <script src="${ctx}/static/js/plugins/codemirror-5.14.2/mode/sql/sql.js"></script>

    <script src="${ctx}/static/js/plugins/codemirror-5.14.2/mode/htmlmixed/htmlmixed.js"></script>

    <script type="text/javascript" src="${ctx}/static/js/plugins/layer/layer.js"></script>
    <script src="${ctx}/static/js/common.js?=1" type="text/javascript"></script>
    <script src="${ctx}/static/js/pagesjs/DldsnFrom.js?v=03"  type="text/javascript"></script>

    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/jquery-ui.css">
    <script type="text/javascript" src="${ctx}/static/js/jquery-ui.min.js"></script>
    <script src="${ctx}/static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
</head>


<script type="text/javascript">
    var mygridjh = null;
    var dsnhtml = "";
    var CodeMirrorEditor=null;
    var CodeMirrorformjseditor = null;
    $(function () {
        $("#divLeft").height(findDimensions_height()-50);
        $("#fromtabfg2_dsndiv").height(findDimensions_height()-135);
        $("#fromtabfg1_dsndiv").height(findDimensions_height()-135);
        $("#opttab1_div").height(findDimensions_height()-120);
        $("#opttab2_div").height(findDimensions_height()-120);
        $("#opttab3_div").height(findDimensions_height()-120);

        $("#gridfield").height(findDimensions_height() - 105);

        var myTextarea = document.getElementById('txtcode');
        CodeMirrorEditor = CodeMirror.fromTextArea(myTextarea, {
            mode: 'htmlmixed',
            lineWrapping: true,
            lineNumbers: true,
            autoMatchParens: true
        });

        var myTextareaformjs = document.getElementById('formjscode');
        CodeMirrorformjseditor = CodeMirror.fromTextArea(myTextareaformjs, {
            mode: 'text/javascript',
            lineWrapping: true,
            lineNumbers: true,
            autoMatchParens: true
        });

        CodeMirrorformjseditor.setSize("100%","500")

        if ("${templateEntity.style}"=="A") {
            $("#fromtabfg2_maindsndiv").remove();

            fgtabclick("fromtabfg1");
        }
        else {
            $("#fromtabfg1_maindsndiv").remove();
            fgtabclick("fromtabfg2");
            SetTabledsnbuttonzt(false);
        }
        loadTemplateProperties();

        dhhtmlLoad();



    });


    function openhtmlwondows(e) {
        $("#divbzbtn").hide();
        layer.open({
            type: 1,
            title: "HTML代码",
            closeBtn: 0,
            area: '80%',
            shadeClose: true,
            content: $('#divbz')
        });
        CodeMirrorEditor.setOption("mode", "htmlmixed");
        if (e == 0) {

            CodeMirrorEditor.getDoc().setValue($("#" + selectfromfgtab + "_dsndiv").html());
        }
        else {

            CodeMirrorEditor.getDoc().setValue($(dsnselectid).html());
        }
        CodeMirrorEditor.refresh();
    }


    function openjswondows(id) {



        $("#divbzbtn").show();
        $("#divbzbtn").data("type",id);



        layer.open({
            type: 1,
            title: "JS-SQL代码",
            closeBtn: 0,
            area: '600px',
            shadeClose: true,
            content: $('#divbz')
        });
        if (id == "dsn_fielddata")
        {
            CodeMirrorEditor.setOption("mode", "text/x-mssql");
        }
        else
            CodeMirrorEditor.setOption("mode", "text/javascript");

        //CodeMirrorEditor.getDoc().setValue($("#"+id).html());

        CodeMirrorEditor.setValue($("#" + $("#divbzbtn").data("type")).val());


        CodeMirrorEditor.refresh();

    }
    
    function fromjsoptclick (id) {

        $("#formjsdivbtn").show();
        $("#formjsdivbtn").data("type",id);

    	  layer.open({
            type: 1,
            title: "formjs代码",
            closeBtn: 0,            
            area: [findDimensions_width()*0.75+'px','600px'],
            shadeClose: true,
            content: $('#formjsdiv')
       });      
        CodeMirrorformjseditor.refresh();
    }
    function SetJsOK()
    {//dsn_fielddata

        $("#" + $("#divbzbtn").data("type")).val(CodeMirrorEditor.getValue());
        var type = $("#divbzbtn").data("type");

        if(type == "dsn_fielddata" || type=="dsn_filedjs" ){


            var filedCode = $(dsnselectid).attr("id").split("_")[0];
            filedCode = $(dsnselectid).attr("id").replace(filedCode+"_","");

            var datastr = CodeMirrorEditor.getValue();
            $.ajax({
                type:"POST",
                url:"/CustomFormFieldTemplate/"+(type=="dsn_fielddata"?"saveDataSql":"saveDatajs"),
                dataType:"json",
                //contentType:"application/json",
                contentType:"application/x-www-form-urlencoded",
                data:{str:datastr,filedCode:filedCode,templateId:'${templateId}'},
                success:function(data){
                    if (data.success == true) {
                        layerSuccess(data.msg, function () {
                            //关闭窗体
                            layer.closeAll();
                        });
                    } else {
                        //alert(data.msg);
                        layerInfo(data.msg);
                    }
                    // $.messager.progress("close");
                }
            });
        }
        else{
            layer.closeAll();
        }


    }
    var multiline = false;
    var line = false;
    function printinputtodiv1Click(){
        if ($("#printinputtodiv1").attr('checked')) {
            $("#printinputtodiv1").attr('checked',false);
            multiline = false;
        }
        else{
            $("#printinputtodiv1").attr('checked',true);
            multiline = true;
        }
    }

    function printinputtodiv2Click(){
        if ($("#printinputtodiv2").attr('checked')) {
            $("#printinputtodiv2").attr('checked',false);
            line = false;
        }
        else{
            $("#printinputtodiv2").attr('checked',true);
            line = true;
        }
    }


    function  savePageJS() {

        var fieldValues=[];
        var d={
            templateId:$("#templateId").val(),
            savejs: $("#dsn_savejs").val(),
            multiline:multiline,
            line:line

            //templateJS:CodeMirrorEditor.getValue()
        }
        fieldValues.push(d);

        $.ajax({
            type:"POST",
            url:"/CustomFormTemplate/saveTemplateopt",
            dataType:"json",
            contentType:"application/json",

            data:JSON.stringify(fieldValues),
            success:function(data){
                if (data.success == true) {
                    layerSuccess(data.msg, function () {
                        //关闭窗体
                        layer.closeAll();
                    });
                } else {
                    //alert(data.msg);
                    layerInfo("数据保存失败！");
                }
                // $.messager.progress("close");
            }
        });
    }

    function loadTemplateProperties(){


        if(${templateEntity.multilineDiv}){
            $("#printinputtodiv1").attr('checked', 'true');
        }

        if(${templateEntity.lineDiv}){
            $("#printinputtodiv2").attr('checked', 'true');
        }


    }

    function dhhtmlLoad() {
        //$("#gridfield").height(findDimensions_height()-460);
        mygridjh = new dhtmlXGridObject("gridfield");
        //mygridjh.setImagePath("../../前端通用代码/js/htmlxjs/imgs/")
        mygridjh.setHeader("名称,控件类型,字段类型,字段代码");
        mygridjh.attachHeader("#text_filter,#rspan,#rspan,#text_filter");
        mygridjh.setInitWidths("150,150,150,150");
        mygridjh.setColAlign("left,left,left,left");
        mygridjh.setColTypes("ro,ro,ro,ro");
        mygridjh.setColSorting("str,str,str,str");
        mygridjh.setSkin("dhx_terrace");
        mygridjh.init();

        mygridjh.attachEvent("onRowDblClicked", function (rId, cInd) {

            CreateVcl(rId);
        });
        mygridjh.attachEvent("onRowSelect", function (rId, cInd) {

            SelectVcl(rId);
        });

        $.ajax({
            type:"POST",
            url:"/CustomFormField/getFieldJsonByFormId?formId=${formId}",
            dataType:"json",
//            contentType:"application/json",
//            data:JSON.stringify(fieldValues),
            success:function(data){
                if (data.success == true) {
                    mygridjh.parse(data.json1, "json");
                } else {
                    //alert(data.msg);
                    layerInfo(data.msg);

                }
                // $.messager.progress("close");
            }
        });




    }
    //风格控制切换
    var selectfromfgtab ="";
    function fgtabclick(id)
    {
        if (id==selectfromfgtab)
            return;
//        if(selectfromfgtab == ""){
//            $("#fromtabfg1_maindsndiv").hide();
//        }
//        else{
//            $("#" + selectfromfgtab + "_maindsndiv").hide();
//        }

        selectfromfgtab =id;
        //$("#" + id + "_dsndiv").html(dsnhtml);
        $("#"+selectfromfgtab).removeClass("active");


        $(".selectdomcss").removeClass("selectdomcss");

        //正式环境无用
       // dsnhtml = $("#" + selectfromfgtab + "_dsndiv").html();
       // $("#" + selectfromfgtab + "_dsndiv").html("");

        $("#"+id).addClass("active");

        $("#"+id+"_maindsndiv").show();




    }

    //属性OPT
    var selectopttab ="opttab1";
    function opttabclick(id)
    {
        if (id==selectopttab)
            return;
        $("#"+selectopttab).removeClass("active");
        $("#"+selectopttab+"_div").hide();

        $("#"+id).addClass("active");
        $("#"+id+"_div").show();

        selectopttab =id;
    }

    function SavePageHtml() {

        var fieldValues1=[];
        var str = $("#" + selectfromfgtab + "_dsndiv").html();
        var d={

            html: str

            //templateJS:CodeMirrorEditor.getValue()
        }
        fieldValues1.push(d);

        $.ajax({
            type:"POST",
            url:"/CustomFormTemplate/savehtml?templateId=${templateId}",
            data: JSON.stringify(fieldValues1),
            contentType:"application/json",
            dataType:"json",
            success:function(data){
                    layerInfo(data.msg);
            }
        });
    }

    function Saveformjs() {

        var d={
            formjs: CodeMirrorformjseditor.getValue()
            //templateJS:CodeMirrorEditor.getValue()
        }

        $("#" + $("#formjsdivbtn").data("type")).val(CodeMirrorformjseditor.getValue());
        $.ajax({
            type:"POST",
            url:"/CustomFormTemplate/saveformjs?templateId=${templateId}",
            data: "["+JSON.stringify(d)+"]",
            contentType:"application/json",
            dataType:"json",
            success:function(data){

//                layerSuccess(data.msg,function(){
                    //关闭窗体
                    layer.closeAll();
//                });
            }
        });
    }

    function  loadpage_btnclick() {

        if (!confirm("确认重新加载页面?当前设计不会保存!"))
            return;

        $.ajax({
            url:"/CustomFormTemplate/gethtml?templateId=${templateId}",
            dataType:"text",
            success:function(data){
                $("#" + selectfromfgtab + "_dsndiv").html(data);
            }
        });
    }

    //获取控件数据
    function GetdsnVclData()
    {
        if ($("#vcldivid").val()=="")
            return;

       $.ajax({
            url:"/CustomFormFieldTemplate/getdatafieldcode?templateId=${templateId}&fcode="+$("#vcldivid").val(),
            dataType:"json",
            contentType:"application/json",
            success:function(data){
                $("#dsn_fielddata").val(data.dataSql);
                $("#dsn_filedjs").val(data.js);
            }
        });
    }

    function viewpageedit_btnclick() {
        window.open("/v_DldsnformPreview/toDldsnformPreview?templateId=${templateId}");
    }
</script>

<style type="text/css">
    div.gridbox_dhx_terrace .xhdr {
        background-color: #fff !important;
        border-bottom: 2px solid #444 !important;
        font-family: "微软雅黑" !important;
    }

    div.gridbox_dhx_terrace table.hdr td {
        border: none !important;
        background-color: #fff !important;
    }

    .gridbox_dhx_terrace td[align="left"] {
        padding-left: 10px !important;
    }

    div.gridbox_dhx_terrace table.hdr td {
        padding-left: 5px !important;
        text-align: left !important;
    }

    .divleft {
        width: 19%;
        float: left;
    }

    .divmain {
        min-width: 810px;
        width: 59%;
        height: 500px;
        float: left;
        margin: 3px;
    }

    .dsndiv {

        overflow: auto;
        border: 1px #D0D0D0 solid;

        padding: 10px;
        margin-top: 3px;
    }

    #divright label {
        vertical-align: middle;
        font-weight: normal;
    }

    .selectdomcss {
        background-color: #f0feec;
        border: solid 1px red;
    }


    .table-container td.ui-selecting { background: #FECA40; }
    .table-container td.ui-selected  { background: #F39814; color: white; }

    .ui-selectable-helper { position: absolute; z-index: 100; border:1px dotted black; }

</style>


<body>
<div style="text-indent: 10px; padding-top: 5px; height: 42px;line-height: 28px; border-bottom: 1px solid #E0E0E0;">

    <input type="hidden" name="templateId" id="templateId" value="${templateId}"/>

    <div style="float: left; width: 50%;">
        <h5 id="fromtitle-h5">${formEntity.name}&nbsp;&nbsp;<span class="label label-primary" id="temtitle-span">${templateEntity.name}</span></h5>
    </div>
    <div style="float: right;text-align: right;padding-top: 5px;" class="btn-group" role="group" >

        <button type="button" id="savepage_btn"  onclick="SavePageHtml()" class="btn btn-default">保存当前页面</button>
        <button type="button" id="loadpage_btn" onclick="loadpage_btnclick()" class="btn btn-default">重加载页面</button>
        <button type="button" id="viewpageedit_btn"  onclick="viewpageedit_btnclick()" class="btn btn-default">编辑模式预览</button>
        <button type="button" id="viewpageprint_btn"  onclick="viewpageprint_btnclick('${formId}','${templateEntity.name}','${templateEntity.style}')" class="btn btn-default">打印模式预览</button> &nbsp;&nbsp;

    </div>
    <div style="clear: both;font-size: 1px;height: 1px;">&nbsp</div>
</div>

<div style=" margin: 5px;">
    <div id="divLeft" class="divleft">
        <h6>
            表单字段 (双击加入)
        </h6>
        <div id="gridfield" style="width: 100%;">
        </div>
    </div>
    <div id="divcon" class="divmain">
        <div style="height: 32px; display: none ">
            <ul class="nav nav-tabs" id="fromfgtab_ul">
                <li role="presentation"  id="fromtabfg1" class="active">
                    <a href="javascript:void()" onclick="fgtabclick('fromtabfg1')">bootstrap风格</a>
                </li>
                <li role="presentation" id="fromtabfg2">
                    <a href="javascript:void()" onclick="fgtabclick('fromtabfg2')">Table风格</a>
                </li>
            </ul>
        </div>
        <div style="clear: both;font-size: 1px;height: 1px;"> &nbsp</div>


        <div id="fromtabfg1_maindsndiv"  style="display: none;">
            <div  class="btn-group" role="group" style="text-align: right; padding-top: 5px; padding-left: 100px; ">

                <button type="button"   onclick="boot_addpanelclick()" class="btn btn-default btn-sm">增加主面板</button>
                <button type="button"   onclick="boot_addpanelSubclick()" class="btn btn-default btn-sm">增加子面板</button>
                <button type="button"    onclick="boot_addpanelrowdivclick()" class="btn btn-default btn-sm">增加行区域</button>
                <button type="button"   onclick="boot_addFltitleclick()" class="btn btn-default btn-sm">增加分类标题</button>
                <button type="button"  onclick="addtextlabelclick()" class="btn btn-default btn-sm">增加文字标签</button>
                <%--<button type="button"  onclick="fromjsoptclick()" class="btn btn-default btn-sm">表单JS</button>--%>
            </div>
            <div id="fromtabfg1_dsndiv" class="dsndiv"  >
                ${templateEntity.html}
            </div>
        </div>

        <div id="fromtabfg2_maindsndiv" style="display: none;">
            <div  class="input-group" role="group" style="text-align: right; padding-top: 5px; padding-left: 30px; ">

                <label class="radio-inline">
                    <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="1"  onclick="SetTabledsnbuttonzt(false)"> 排版模式
                </label>
                <label class="radio-inline">
                    <input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="2" checked="checked" onclick="SetTabledsnbuttonzt(true)"> 设计模式
                </label>
                &nbsp;
                &nbsp;
                <button type="button" id="addtable" disabled   onclick="table_addtableclick()" class="btn btn-default btn-sm">增加Table</button>
                <button type="button"  id="addtablerow" disabled onclick="table_addrowclick()" class="btn btn-default btn-sm">增加一行</button>
                <button type="button" id="tablesplit"  disabled onclick="table_Splitclick()" class="btn btn-default btn-sm">拆分选中单元格</button>
                <button type="button" id="tablemerge"disabled  onclick="table_Mergeclick()" class="btn btn-default btn-sm">合并选中单元格</button>
                <button type="button" id="deltablerow" onclick="table_deltablerowclick()" class="btn btn-default btn-sm">删除当前行</button>
                <button type="button"   onclick="addtextlabelclick()" class="btn btn-default btn-sm">增加文字标签</button>
                <%--<button type="button"  onclick="fromjsoptclick()" class="btn btn-default btn-sm">表单JS</button>--%>
            </div>

            <div id="fromtabfg2_dsndiv" class="dsndiv"  >
                ${templateEntity.html}
            </div>


        </div>



    </div>

    <div id="divright" class="divleft">
        <div style="height: 32px;">
            <ul class="nav nav-tabs">
                <li role="presentation" id="opttab1" class="active">
                    <a href="javascript:void()" onclick="opttabclick('opttab1')">表单属性</a>
                </li>
                <li role="presentation"  id="opttab3">
                    <a href="javascript:void()" onclick="opttabclick('opttab3')">面板属性</a>
                </li>
                <li role="presentation" id="opttab2">
                    <a href="javascript:void()"  onclick="opttabclick('opttab2')">控件属性</a>
                </li>
            </ul>
        </div>

        <div id="opttab1_div" style="overflow: auto; width: 100%;">
            <div class="list-group" >
                <div class="list-group-item">
                    <input id="printinputtodiv1" type="checkbox"  onclick="printinputtodiv1Click()"/><label for="printinputtodiv1">打印时多行文本转div</label>
                    <input id="printinputtodiv2" type="checkbox"  onclick="printinputtodiv2Click()"/><label for="printinputtodiv2">打印时单行文本转div</label>
                </div>
                <div class="input-group" style="padding-top: 2px;padding-bottom: 1px;">
                    <textarea class="form-control input-sm" id="dsn_savejs" style="width: 100%;" rows="5" readonly>
                        ${templateEntity.savejs}
                    </textarea>
                    <span class="input-group-addon" style="background-color: white;">
                            <button type="button"  onclick="openjswondows('dsn_savejs')" class="btn btn-primary btn-xs ">保存前JS</button>
                        </span>
                </div>
                <div class="input-group" style="padding-top: 2px;padding-bottom: 1px;">
                    <textarea class="form-control input-sm" id="dsn_fromjs" style="width: 100%;" rows="5" readonly>
                        ${templateEntity.formjs}
                    </textarea>
                    <span class="input-group-addon" style="background-color: white;">
                            <button type="button"  onclick="fromjsoptclick('dsn_fromjs')" class="btn btn-primary btn-xs ">表单JS</button>
                        </span>
                </div>

                <div class="list-group-item">
                    <button type="button" id="refreshpaneldiv_btn1" class="btn btn-default "  onclick="savePageJS()">表单属性保存</button>

                    <button type="button" id="refreshpaneldiv_btn2" class="btn btn-success btn-xs ">所有字段属性</button>
                </div>
                <div class="list-group-item">
                    <button type="button" onclick="openhtmlwondows(0)" class="btn btn-default btn-xs">全部HTML</button>
                    <button type="button" onclick="openhtmlwondows(1)" class="btn btn-default btn-xs ">当前选中HTML</button>
                </div>
            </div>
        </div>
        <div id="opttab2_div" style="overflow: auto;width: 100%; display: none; " >
            <div class="list-group">
                <div class="input-group" style="padding-top: 1px;">
                    <span class="input-group-addon">控件</span>
                    <input id="vcldivid" class="form-control input-sm" type="text" readonly="readonly"/>
                </div>

                <div class="input-group" style="padding-top: 1px;">
                    <span class="input-group-addon">宽度</span>
                    <input id="divvclwidth" type="text" class="form-control input-sm" />
                </div>
                <div class="input-group" style="padding-top: 1px;">
                    <span class="input-group-addon">高度</span>
                    <input id="divvclheight" type="text" class="form-control input-sm" />
                </div>
                <div style="color: brown;">* 默认PX</div>
                <div style="height: 5px; font-size: 5px;">&nbsp;</div>
                <div class="input-group" style="padding-top: 1px;">
                    <span class="input-group-addon">标题</span>
                    <input id="divvcltitle" class="form-control input-sm" type="text" />
                </div>
                <div class="input-group" style="padding-top: 1px;">
                    <span class="input-group-addon">标题宽度</span>
                    <input id="divvcltitlewidth" class="form-control input-sm" type="text" />
                </div>

                <div class="input-group" style="padding-top: 1px;">
                    <span class="input-group-addon">验证</span>
                    <input id="divvclregex" class="form-control input-sm" type="text"/>
                </div>
                <div style="color: brown;">* 正则表达式</div>
                <div style="height: 5px; font-size: 5px;">&nbsp;</div>

                <div class="input-group" style="padding-top: 1px;">
                    <span class="input-group-addon">默认</span>
                    <input id="divvcldefault" class="form-control input-sm" type="text"/>
                </div>
                <div style="color: brown;">* [#usercode] 用户ID [#sysdate] 当前日期</div>
                <div style="color: brown;">* [#username] 用户名 [#userks] 用户科室</div>
                <div style="height: 5px;  font-size: 5px;">&nbsp;</div>

                <div class="list-group-item" >
                    <input id="divvcltitlebold" type="checkbox" checked="checked"/><label for="divvcltitlebold">标题加粗</label>
                    <!--<input id="divvcltitleisbr" type="checkbox" checked="checked"/><label for="panelborderdown">标题起一行</label>-->
                    <input id="divvclnotrim" type="checkbox" /><label for="divvclnotrim">必填</label>
                    <input id="divvclnoshow" type="checkbox" /><label for="divvclnoshow">隐藏</label>
                    <input id="divvcledtreadonly" type="checkbox" /><label for="divvcledtreadonly">编辑只读</label>
                    <input id="divvclnodisabled" type="checkbox" /><label for="divvclnodisabled">禁用</label>
                </div>

                <div class="input-group" style="padding-top: 2px;">
                    <span class="input-group-addon">只读联动</span>
                    <input id="dsnvclld" class="form-control input-sm" type="text"/>
                </div>
                <div style="color: brown;">*根据值联动控件ID为只读 值|ID 格式 单选控件，多选控件，下拉控件有用</div>
                <div style="height: 5px; font-size: 5px;">&nbsp;</div>

                <div class="list-group-item">
                    <button type="button"  onclick="refreshdivvcl_btnclick()" class="btn btn-primary">刷新控件</button>
                    <button type="button"  onclick="delvcldiv_btnclick()" class="btn btn-danger btn-xs ">删除</button>
                </div>
                <div class="input-group">


                    <span class="input-group-addon">控件类型</span>
                    <input id="divvcltype" class="form-control input-sm" type="text" readonly="readonly" >
                    <!--<select id="panelalign" class="form-control input-sm">
                        <option>日期控件</option>
                        <option>日期时间控件</option>
                        <option>年月控件</option>
                        <option>年控件</option>
                        <option>字典SQL表格控件</option>
                        <option>PID0SQL树控件</option>
                        <option>LENSQL树控件</option>
                        <option>字典SQL下拉控件</option>
                        <option>对应值下拉控件</option>
                        <option>文本控件</option>
                        <option>1行多选控件</option>
                        <option>2行多选控件</option>
                        <option>3行多选控件</option>
                        <option>4行多选控件</option>
                        <option>1行单选控件</option>
                        <option>2行单选控件</option>
                        <option>3行单选控件</option>
                        <option>4行单选控件</option>
                        <option>数字控件</option>
                        <option>多行文本控件</option>
                    </select>-->


                </div>
                <div class="input-group" style="padding-top: 1px;padding-bottom: 1px;">
                    <textarea class="form-control input-sm" id="dsn_fielddata" style="width: 100%;" rows="3" readonly></textarea>
                    <span class="input-group-addon" style="background-color: white;">
                            <button type="button"  onclick="openjswondows('dsn_fielddata')"  class="btn btn-primary btn-xs ">编辑数据</button>
                        </span>

                </div>
                <div style="color: brown;">
                    * 多选和单选只能是键值数据 SQL控件写法:
                    Select dm,mc From Table dm mc 不可少
                    查询写法 Select dm,mc From Table mc like '%[#tj]%'
                    拼音码方式: $("#字段代码").val(getpym($("#字段代码").val());
                    键值: dm#mc/dm#mc
                    联动SQL配置: Select dm,mc  From table Where 字段名=[#val]|其它控件ID[放到最后];

                </div>
                <%--<div class="input-group" style="padding-top: 2px;">--%>
                    <%--<span class="input-group-addon">联动控件</span>--%>
                    <%--<input id="panelmemo2" class="form-control input-sm" type="text" />
                    * 树形控件默认时为(树字段维)分类字段为: pid 配置内容是 分类字段名称 根的pid只能是 0
                    树形控件选择层次码类型时 则配置 2-4 这样的层次规则 直接关联维代码 如是SQL要写成
                    Select dm,mc , '2-4' as dmlen From table [dmlen]不能少
                    --%>
                <%--</div>--%>
                <%--<div style="color: brown;">*根据联动控件ID 的数据来加载数据</div>--%>
                <div style="height: 5px; font-size: 5px;">&nbsp;</div>


                <div class="input-group" style="padding-top: 1px;padding-bottom: 1px;">

                    <textarea class="form-control input-sm" id="dsn_filedjs" style="width: 100%;" rows="5" readonly></textarea>
                    <span class="input-group-addon" style="background-color: white;">
                            <button type="button" onclick="openjswondows('dsn_filedjs')"   class="btn btn-primary btn-xs ">保存前JS</button>
                        </span>
                </div>


            </div>
        </div>
        <div id="opttab3_div" style="overflow: auto;width: 100%; display : none;">
            <div class="list-group" id="grop-panelopt">

                <div class="input-group" style="padding-top: 1px;">
                    <span class="input-group-addon">面板(Table)</span>
                    <input id="paneldivid" class="form-control input-sm" type="text" readonly="readonly"></input>
                </div>

                <div class="input-group" style="padding-top: 1px;">
                    <span class="input-group-addon">宽度</span>

                    <input id="paneldivwidth" type="text" readonly="readonly" class="form-control input-sm" ></input>


                </div>
                <div class="input-group" style="padding-top: 1px;">
                    <span class="input-group-addon">高度</span>


                    <input id="paneldivheight" type="text" readonly="readonly" class="form-control input-sm" ></input>
                </div>





                <div class="list-group-item"  >
                    <span id="divopt_span_paneltitle"> <input id="paneloptnotitle" type="checkbox" checked="checked" /> <label for="paneloptnotitle">无标题</label></span>
                    <span id="divopt_span_noborder" ><input id="paneloptnoborder" type="checkbox" checked="checked" /> <label for="paneloptnoborder">无边</label></span>
                </div>





                <div class="input-group" style="padding-top: 1px; " id="divopt_titlememo">
                    <span class="input-group-addon">  标题(内容)</span>
                    <input id="paneltitlememo" type="text" class="form-control input-sm" ></input>
                </div>
                <div class="list-group-item"  id="divopt_ttitlecenter">
                    <!--<input id="panelopttitlebole" type="checkbox" checked="checked"></input><label for="panelopttitlebole">加粗</label>-->

                    <input id="panelopttitlecenter" type="checkbox" checked="checked"></input><label for="panelopttitlecenter">垂直居中</label>
                </div>
                <!--<div class="input-group" style="padding-top: 1px;">
                    <span class="input-group-addon">标题位置</span>
                    <select id="panelalign" class="form-control input-sm">
                          <option >center</option>
                        <option>left</option>
                        <option>right</option>
                        </select>
</div>-->


                <div style="height: 5px; font-size: 5px;">&nbsp;</div>



                <div class="list-group-item">
                    <button type="button" id="refreshpaneldiv_btn" onclick="refreshpaneldiv_btnclick()" class="btn btn-primary input-sm">刷新面板</button>
                    <button type="button" id="delpaneldiv_btn" onclick="delpaneldiv_btnclick()" class="btn btn-danger btn-xs ">删除</button>
                </div>

                <div style="color: red; font-size:14px;">* 页面最宽是780PX 一张A4大小</div>
                <div style="height: 5px; font-size: 5px;">&nbsp;</div>
                <div style="color: red; font-size:14px;">
                    *以上功能 Table时指的选中的单元格

                </div>
                <div style="height: 5px; font-size: 5px;">&nbsp;</div>

            </div>
        </div>
    </div>
</div>


<div id="divbz" style="display: none">

        <textarea  class="form-control input-sm " id="txtcode" style="width: 100%; height: 500px">

        </textarea>

    <div id="divbzbtn"  style="display: none;padding:3px;text-align:center; border-top:1px solid #E0E0E0"  >
        <button type="button"   onclick="SetJsOK()" class="btn btn-primary input-sm">确定</button>
        <button type="button"  onclick=" layer.closeAll()" class="btn btn-danger btn-xs ">取消</button>
    </div>
</div>



<div id="formjsdiv" style="display: none">

        <textarea  id="formjscode" style="width: 100%; height: 600px">
            ${templateEntity.formjs}
        </textarea>

    <div  id="formjsdivbtn"  style="padding:3px;text-align:center; border-top:1px solid #E0E0E0"  >
        <button type="button"   onclick="Saveformjs()" class="btn btn-primary input-sm">确定</button>
        <button type="button"  onclick=" layer.closeAll()" class="btn btn-danger btn-xs ">取消</button>
    </div>
</div>


</body>
</html>
