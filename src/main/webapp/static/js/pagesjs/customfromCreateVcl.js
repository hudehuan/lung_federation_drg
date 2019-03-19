/**
 * Created by admin on 2017-05-22.
 */
//自定义表单创建控件JS

function SetDsnSelectDomCss(){

}
function showHz(code,str,id){
    if(str.indexOf(code)>-1){
        $("#"+id).show();
    }
}
//加载初始化数据
function initDefaultDate(tmpvcljson,data){
    var fieldName="";
    $("div").removeAttr("onclick");
    $(tmpvcljson).each(function (i,n) {

        fieldName = n.fieldCode;
        if ( $("#divvcl_"+fieldName).length>0) {
            $("#divvcl_"+fieldName).unbind("click");

            var vcldefault = $("#divvcl_"+fieldName).attr("vcldefault");

            // if(' [#usercode] [#sysdate] [#username] [#userks] '.indexOf(vcldefault)>-1){
            if(vcldefault){
                set_default(fieldName,vcldefault, n.controlType);
            }
        }
    });



}
//修改控件的readonly状态
function set_readonly(id,isreadonly) {
    $("#"+id).attr("disabled", isreadonly)//将input元素设置为readonly
}


function set_show(id,isshow) {

    $("#divvcl_"+id).css('display',isshow);
    //$("#id").css('display','none'); //隐藏
    //$("#id").css('display', 'block'); //显示
}
function set_default(fieldName,vcldefault,controlType){
    var value = "";
    if(vcldefault.indexOf('[#usercode]')>-1){
        value= defaultDate.userid;
    }
    else if(vcldefault.indexOf('[#sysdate]')>-1){
        value= defaultDate.sysdate;
    }
    else if(vcldefault.indexOf('[#username]')>-1){
        value= defaultDate.username;
    }
    else if(vcldefault.indexOf('[#userks]')>-1){
        value= defaultDate.userks;
    }
    else{
        value = vcldefault;
    }

    switch (controlType) {
        case  "多选控件":
        case  "1列多选控件":
        case  "2列多选控件":
        case  "3列多选控件":
        case  "4列多选控件":
            CheckboxValue(value, fieldName);
            break;
        case  "单选控件":
        case  "1列单选控件":
        case  "2列单选控件":
        case  "3列单选控件":
        case  "4列单选控件":
            //values = $("input[name=" + controlName + "]:checked").val();
            $("input[name=" + fieldName + "][value='" + value + "']").attr("checked", 'checked');
            break;
        case "文本控件":
        case "多行文本控件":
        case "数字控件":
        case "日期时间控件":
            $("#" + fieldName).val(value);
            break;
        case "日期控件":
            $("#" + fieldName).val(value.substring(0,10));
            break;
        case "年月控件":
            $("#" + fieldName).val(value.substring(0,7));
            break;
        case "年控件":
            $("#" + fieldName).val(value.substring(0,4));
            break;
        case "字典SQL下拉控件":
        case "对应值下拉控件":
            $("#" + fieldName + " option[value='" + value + "']").attr("selected", "selected");
            var mc = $("#" + fieldName + " option[value='" + value + "']").text();
            $("#" + fieldName).attr("name", "select");
            $("#" + fieldName).attr("value", mc);
            break;
        case "字典SQL表格控件":
            $('#' + fieldName + "_wmc").combogrid({
                onLoadSuccess: function(){
                    $('#' + fieldName + "_wmc").combogrid('grid').datagrid('selectRecord',value);
                    value= "";
                }
            });
            // $('#' + fieldName + "_wmc").combogrid('grid').datagrid('selectRecord', value);
            //打印赋值
            var mc = $('#' + fieldName + "_wmc").combogrid('getText');
            $('#' + fieldName + "_wmc").attr("value", mc);
            $("input[value='" + value + "'][class='textbox-value']").prev().attr("value", mc);
            break;
    }
}


function initControlProperties(tmpvcljson) {
    //设置控件属性，是否隐藏和是否只读、是否编辑时只读
    //数据初始化
    var fieldName="";
    $("div").removeAttr("onclick");
    $(tmpvcljson).each(function (i,n) {

        fieldName = n.fieldCode;
        if ( $("#divvcl_"+fieldName).length>0) {
            $("#divvcl_"+fieldName).unbind("click");


            var noshow = $("#divvcl_" + fieldName).attr("noshow");
            var edtreadonly = $("#divvcl_" + fieldName).attr("edtreadonly");
            var nodisabled = $("#divvcl_" + fieldName).attr("nodisabled");
            if (noshow == 1) {
                set_show(fieldName, 'none');
            }
            if (edtreadonly == 1 && dataId != "") {
                set_readonly(fieldName, true);
            }
            if (nodisabled == 1 ) {
                set_readonly(fieldName, true);
            }

            if (n.dataSql.indexOf("(sql)")<0 && n.dataSql!="") //键值 绑定
            {
                bundlingData(fieldName, n.controlType, n.dataSql);

                //只读联动事件绑定 | 作为分割符
                var ldvcl = $("#divvcl_" + fieldName).attr("ldvcl");
                if (ldvcl != "") {
                    //控件事件绑定
                    bundlingld_click(fieldName, n.controlType, ldvcl);
                }
            }


            if (n.dataSql=="(sql)" ) // 要执行SQl并是没有联动的
                bundingDataAjaxSql(fieldName,n.controlType);

            //表格控件绑定click事件 key事件 ajax查询数据 有个联动
            //如果有个SQL联动，就需要绑定事件到click上 而不能马上ajax获取数据

            CreateComboGrid(fieldName,n.controlType,n.dataSql);

        }
    });
}

function CreateComboGrid(fieldName,vcllx,dataSql) {

    if (vcllx != "字典SQL表格控件") //只有这一个控件
        return;
    $('#' + fieldName + "_wmc").keydown(function () {
        query();
    });
    if (dataSql=="(sql)") {
        $('#' + fieldName + "_wmc").combogrid({
            panelHeigh: 400,
            panelWidth: 230,
            idField: 'dm',        //ID字段
            textField: 'mc',    //显示的字段
            url: "/CustomFormFieldTemplate/getSqlData?templateId=" + templateId + "&fieldCode=" + fieldName + "&rdm=" + Math.random(),
            fitColumns: true,
            striped: true,
            rownumbers: true,           //序号
            collapsible: false,         //是否可折叠的

            method: 'get',


            columns: [[
                {field: 'dm', title: '代码', width: 80, hidden: true},
                {field: 'mc', title: '名称', width: 150},
            ]],
            onSelect: function () {              //选中处理
                $('#'+fieldName+"_wmc").val($('#'+fieldName+"_wmc").combogrid('grid').datagrid('getSelected').mc);
                $('#'+fieldName).val($('#'+fieldName+"_wmc").combogrid('grid').datagrid('getSelected').dm);
            },
            keyHandler: {
                up: function () {
                },
                down: function () {
                },
                enter: function () {
                },
                query: function (q) {
                    //动态搜索
                    $('#' + fieldName + "_wmc").combogrid("grid").datagrid("reload", {'mc': q});
                    $('#' + fieldName + "_wmc").combogrid("setValue", q);
                }
            }
        });
    }
    else //有联动
    {

        $('#' + fieldName + "_wmc").attr("vcldata",dataSql.replace("(sql)",""));
        $('#' + fieldName + "_wmc").combogrid({
            panelHeigh: 400,
            panelWidth: 230,
            idField: 'dm',        //ID字段
            textField: 'mc',    //显示的字段
            url: "/CustomFormFieldTemplate/getSqlData?templateId=" + templateId + "&fieldCode=" + fieldName + "&rdm=" + Math.random(),
            fitColumns: true,
            striped: true,

            rownumbers: true,           //序号
            collapsible: false,         //是否可折叠的

            method: 'get',


            columns: [[
                {field: 'dm', title: '代码', width: 80, hidden: true},
                {field: 'mc', title: '名称', width: 150},
            ]],
            onSelect: function () {              //选中处理
                $('#'+fieldName+"_wmc").val($('#'+fieldName+"_wmc").combogrid('grid').datagrid('getSelected').mc);
                $('#'+fieldName).val($('#'+fieldName+"_wmc").combogrid('grid').datagrid('getSelected').dm);
            },
            keyHandler: {
                up: function () {
                },
                down: function () {
                },
                enter: function () {
                },
                query: function (q) {
                    //动态搜索


                    $('#' + fieldName + "_wmc").combogrid("grid").datagrid("reload", {'mc': q,'tj':$("#"+$('#'+fieldName+"_wmc").attr("vcldata")).val()});
                    $('#' + fieldName + "_wmc").combogrid("setValue", q);
                }
            }
        });
    }
}



//SQL执行绑定数据
function bundingDataAjaxSql(fieldName,vcllx) {

    if (vcllx != "字典SQL下拉控件") //只有这一个控件
        return;

    var url = "/CustomFormFieldTemplate/getSqlData?templateId=" + templateId + "&fieldCode="
        + fieldName + "&rdm=" + Math.random();
    $("#" + fieldName).empty();

    $.getJSON(url, function (data) {
        var tmps="";
        for (var i = 0; i < data.length; i++) {
            tmps += "<option value='" + data[i].dm + "'>" + data[i].mc + "</option>";
        }
        $("#" + fieldName).append(tmps);
        var ldvcl = $("#divvcl_" + id).attr("ldvcl");
        if (ldvcl != "") {
            //控件事件绑定
            bundlingld_click(fieldName, "对应值下拉控件", ldvcl);
        }

    });
}

var arrldvclid =  new Array(); //存放联动数据
var arrldvcldata =  new Array(); //存放联动数据
//联动控件只读绑定
function bundlingld_click(id,vcllx,data) {

    var arrdata =data.split('|');
    if (arrdata.length<=1)
        return;

    arrldvclid.push([id]);
    arrldvcldata.push([data]);

    switch (vcllx) {
        case "字典SQL下拉控件":
        case "对应值下拉控件":
            $("#"+id).change(function () {
                for (var i=0;i<arrldvclid.length;i++)
                {
                    if (arrldvclid[i]== $(this).attr("id"))
                    {
                        var data = arrldvcldata[i].toString().split('|');
                        if ($(this).val()==data[0])
                            $("#"+data[1]).attr("disabled",false);
                        else
                            $("#"+data[1]).attr("disabled",true);
                        return;
                    }
                }
            })
            break;
        case "多选控件":
        case "1列多选控件":
        case "2列多选控件":
        case "3列多选控件":
        case "4列多选控件":
            $("#divvcl_"+id+" input").change(function () {
                for (var i=0;i<arrldvclid.length;i++)
                {
                    if (arrldvclid[i]== $(this).parent().parent().attr("id"))
                    {
                        var data = arrldvcldata[i].split('|');
                        if (  $(this).val()==data[0]) {  //只有值相同的才有用
                            if ($(this).prop())
                                $("#" + data[1]).attr("disabled", false);
                            else
                                $("#" + data[1]).attr("disabled", true);
                        }
                        return;
                    }
                }
            });
            break;
        case "单选控件":
        case "1列单选控件":
        case "2列单选控件":
        case "3列单选控件":
        case "4列单选控件":
            $("#divvcl_"+id+" input").change(function () {
                for (var i=0;i<arrldvclid.length;i++)
                {
                    if (arrldvclid[i]== $(this).parent().parent().attr("id"))
                    {
                        var data = arrldvcldata[i].split('|');
                        if (  $(this).val()==data[0]) {  //只有值相同的才有用
                            if ($(this).prop())
                                $("#" + data[1]).attr("disabled", false);
                            else
                                $("#" + data[1]).attr("disabled", true);
                        }
                        return;
                    }
                }
            });
            break;
    }
}

//数据绑定
function bundlingData(id,vcllx,data){
    switch (vcllx) {
        case "对应值下拉控件":
            CreateVcl_keyselect(id,data);
            break;
        case "多选控件":
            CreateVcl_checkbox(id,data);
            break;
        case "1列多选控件":
            CreateVcl_onecheckbox(id,data);
            break;
        case "2列多选控件":
            CreateVcl_twocheckbox(id,data);
            break;
        case "3列多选控件":
            CreateVcl_threecheckbox(id,data);
            break;
        case "4列多选控件":
            CreateVcl_fourcheckbox(id,data);
            break;

        case "单选控件":
            CreateVcl_radio(id,data);
            break;

        case "1列单选控件":
            CreateVcl_oneradio(id,data);
            break;
        case "2列单选控件":
            CreateVcl_tworadio(id,data);
            break;
        case "3列单选控件":
            CreateVcl_threeadio(id,data);
            break;
        case "4列单选控件":
            CreateVcl_fouradio(id,data);
            break;
    }
}


//    <option>对应值下拉控件</option>
function CreateVcl_keyselect(id,data) {

    var arrdata =data.split("/");
    $("#"+id).empty();
    var tmps = "";
    for (var i=0;i<arrdata.length;i++)
    {
        var tmp = arrdata[i].split("#");
        tmps +="<option value='"+tmp[0]+"'>"+tmp[1]+"</option>";
    }
    $("#"+id).append(tmps);
}


//    <option>多选控件</option>
function CreateVcl_checkbox(id, data) {

    var arrdata =data.split("/");

    $("#divvcl_"+id+" .span_che_radio").remove();
    var html ="";
    for (var i = 0; i < arrdata.length; i++) {

        var tmp = arrdata[i].split("#");
        html += '<span class="span_che_radio" >';
        html += '<input type="checkbox" name="' + id + '"id="' + id + '_che' + i.toString() + '" value="'+tmp[0]+'"/> <label for="' + id + '_che' + i.toString()+ '">' + tmp[1] + '</label>';
        html += '</span>';
    }
    $("#divvcl_"+id).append(html);
}


//    <option>1列多选控件</option>
function CreateVcl_onecheckbox(id,data) {
    var arrdata =data.split("/");
    $("#divvcl_"+id+" .div_che_radio").remove();
    var html = "";

    for (var i = 0; i < arrdata.length; i++) {

        var tmp = arrdata[i].split("#");
        html += '<div class="div_che_radio" >';
        html += '<input type="checkbox" name="' + id + '"id="' + id + '_che' + i.toString() + '" value="'+tmp[0]+'"/> <label for="' + id + '_che' + i.toString()+ '">' + tmp[1] + '</label>';
        html += '</div>';
    }

    $("#divvcl_"+id).append(html);
}
//    <option>2列多选控件</option>
function CreateVcl_twocheckbox(id,data) {

    var arrdata =data.split("/");
    $("#divvcl_"+id+" .div_che_radio").remove();
    var html = "";
    var k = 0;
    while (k<arrdata.length)
    {
        html += '<div class="div_che_radio">';
        for (var j = 1; j < 3; j++)
        {
            if (k>=arrdata.length)
                break;
            var tmp = arrdata[k].split("#");

            html += '<span class="div_che_radio_spanwidth2"><input type="checkbox" name="' + id + '"id="' + id + '_che' + k.toString() + '" value="'+tmp[0]+'"/> <label for="' + id + '_che' + k.toString()+ '">' + tmp[1] + '</label></span>';
            k++;
        }
        html += '</div >';
    }
    $("#divvcl_"+id +" :last").remove();
    $("#divvcl_"+id ).append(html+'<div style="clear: both;font-size: 1px;height: 1px;">&nbsp</div>');
}
//    <option>3列多选控件</option>
function CreateVcl_threecheckbox(id,data) {
    var arrdata =data.split("/");
    $("#divvcl_"+id+" .div_che_radio").remove();
    var html = "";
    var k = 0;
    while (k<arrdata.length)
    {
        html += '<div class="div_che_radio">';
        for (var j = 1; j < 4; j++)
        {
            if (k>=arrdata.length)
                break;

            var tmp = arrdata[k].split("#");

            html += '<span class="div_che_radio_spanwidth3"><input type="checkbox" name="' + id + '"id="' + id + '_che' + k.toString() + '" value="'+tmp[0]+'"/> <label for="' + id + '_che' + k.toString()+ '">' + tmp[1] + '</label></span>';
            k++;
        }
        html += '</div >';
    }
    $("#divvcl_"+id +" :last").remove();
    $("#divvcl_"+id ).append(html+'<div style="clear: both;font-size: 1px;height: 1px;">&nbsp</div>');
}
//    <option>4列多选控件</option>
function CreateVcl_fourcheckbox(id,data) {
    var arrdata =data.split("/");
    $("#divvcl_"+id+" .div_che_radio").remove();
    var html = "";
    var k = 0;
    while (k<arrdata.length)
    {
        html += '<div class="div_che_radio">';
        for (var j = 1; j < 5; j++)
        {
            if (k>=arrdata.length)
                break;

            var tmp = arrdata[k].split("#");

            html += '<span class="div_che_radio_spanwidth4"><input type="checkbox" name="' + id + '"id="' + id + '_che' + k.toString() + '" value="'+tmp[0]+'"/> <label for="' + id + '_che' + k.toString()+ '">' + tmp[1] + '</label></span>';
            k++;
        }
        html += '</div >';
    }
    $("#divvcl_"+id +" :last").remove();
    $("#divvcl_"+id ).append(html+'<div style="clear: both;font-size: 1px;height: 1px;">&nbsp</div>');

}

//    <option>单选控件</option>
function CreateVcl_radio(id, data) {

    var arrdata =data.split("/");

    $("#divvcl_"+id+" .span_che_radio").remove();
    var html = "";
    for (var i = 0; i < arrdata.length; i++) {

        var tmp = arrdata[i].split("#");
        html += '<span class="span_che_radio" >';
        html += '<input type="radio" name="' + id + '" id="' + id + '_che' + i.toString() + '" value="'+tmp[0]+'"/> <label for="' + id + '_che' + i.toString()+ '">' + tmp[1] + '</label>';
        html += '</span>';
    }
    $("#divvcl_"+id).append(html);

}


//    <option>1列单选控件</option>
function CreateVcl_oneradio(id,data) {

    var arrdata =data.split("/");
    $("#divvcl_"+id+" .div_che_radio").remove();
    var html = "";
    for (var i = 0; i < arrdata.length; i++) {

        var tmp = arrdata[i].split("#");
        html += '<div class="div_che_radio" >';
        html += '<input type="radio" name="' + id + '" id="' + id + '_che' + i.toString() + '" value="'+tmp[0]+'"/> <label for="' + id + '_che' + i.toString()+ '">' + tmp[1] + '</label>';
        html += '</div>';
    }



    $("#divvcl_"+id).append(html);
}
//    <option>2列单选控件</option>
function CreateVcl_tworadio(id,data) {
    var arrdata =data.split("/");
    $("#divvcl_"+id+" .div_che_radio").remove();
    var html = "";
    var k = 0;
    while (k<arrdata.length)
    {
        html += '<div class="div_che_radio">';
        for (var j = 1; j < 3; j++)
        {
            if (k>=arrdata.length)
                break;

            var tmp = arrdata[k].split("#");

            html += '<span class="div_che_radio_spanwidth2"><input type="radio" name="' + id + '" id="' + id + '_che' + k.toString() + '" value="'+tmp[0]+'"/> <label for="' + id + '_che' + k.toString()+ '">' + tmp[1] + '</label></span>';
            k++;
        }
        html += '</div >';
    }
    $("#divvcl_"+id +" :last").remove();
    $("#divvcl_"+id ).append(html+'<div style="clear: both;font-size: 1px;height: 1px;">&nbsp</div>');

}
//    <option>3列单选控件</option>
function CreateVcl_threeadio(id,data) {
    var arrdata =data.split("/");
    $("#divvcl_"+id+" .div_che_radio").remove();
    var html = "";
    var k = 0;
    while (k<arrdata.length)
    {
        html += '<div class="div_che_radio">';
        for (var j = 1; j < 4; j++)
        {
            if (k>=arrdata.length)
                break;

            var tmp = arrdata[k].split("#");

            html += '<span class="div_che_radio_spanwidth3"><input type="radio" name="' + id + '" id="' + id + '_che' + k.toString() + '" value="'+tmp[0]+'"/> <label for="' + id + '_che' + k.toString()+ '">' + tmp[1] + '</label></span>';
            k++;
        }
        html += '</div >';
    }
    $("#divvcl_"+id +" :last").remove();
    $("#divvcl_"+id ).append(html+'<div style="clear: both;font-size: 1px;height: 1px;">&nbsp</div>');
}
//    <option>4列单选控件</option>
function CreateVcl_fouradio(id,data) {
    var arrdata =data.split("/");
    $("#divvcl_"+id+" .div_che_radio").remove();
    var html = "";
    var k = 0;
    while (k<arrdata.length)
    {
        html += '<div class="div_che_radio">';
        for (var j = 1; j < 5; j++)
        {
            if (k>=arrdata.length)
                break;

            var tmp = arrdata[k].split("#");

            html += '<span class="div_che_radio_spanwidth4"><input type="radio" name="' + id + '" id="' + id + '_che' + k.toString() + '" value="'+tmp[0]+'"/> <label for="' + id + '_che' + k.toString()+ '">' + tmp[1] + '</label></span>';
            k++;
        }
        html += '</div >';
    }
    $("#divvcl_"+id +" :last").remove();
    $("#divvcl_"+id ).append(html+'<div style="clear: both;font-size: 1px;height: 1px;">&nbsp</div>');
}