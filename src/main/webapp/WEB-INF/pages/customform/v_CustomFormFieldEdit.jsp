<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2017/4/22
  Time: 14:39
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@ include file="/common/meta.jsp"%>
<head>
    <title>Title</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <script type="text/javascript">
        //		点取消关闭窗口
        function clearall(){
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
            parent.layer.close(index); //执行关闭
        }
        function refreshParent(){
            GetIndexActiveIframe().refresh();
        }
        function btnclose(){
            closeIndexWindwos();
        }

        $(function(){

            $("#fieldType option[value='${data.fieldType}']").attr("selected", "selected");
            $("#controlType option[value='${data.controlType}']").attr("selected", "selected");


            if(${data.pkey}){
                $("#pkey").attr('checked', 'true');
            }


            // 自定义参数调用
            formValiPost("formfield", "${ctx }/CustomFormField/save", function (json) {
                if (json.success == false) {
                    $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                }
                else {
                    //parent.loadTabStruc();

                    parent.reloadFormField();
                    layerSuccess("成功", function () {
                        //关闭窗体
                        //closeIndexWindwos();
                        $('#formfield')[0].reset();
                    });

                }

            });



        });
    </script>



</head>
<body>


<form  id="formfield" >
    <input type="hidden" name="formId" id ="formId" value="${formId}"/>
    <input type="hidden" name="id" id ="id" value="${data.id}"/>
    <div class="container from-content">
        <div class="div_border"  style="padding:10px 20px">
            <div class="div_h ">
                <label for="xh" style="margin-left: 11px;margin-right: 38px;">序号&nbsp;&nbsp;</label>
                <input  id="xh" type="number" name="xh" class="bi-width140  form-control"
                        onkeydown="DigitInput(this)" value="${data.xh}"/>
            </div>

            <div class="div_h" style="margin-left:27px;">
                <input id="pkey" type="checkbox" name="pkey"/>
                <label for="pkey">关键字&nbsp;&nbsp;</label>
            </div>


        </div>

        <div class="div_border"  style="padding:10px 20px">
            <div class="div_h">
                <label for="fieldName" style="margin-left: 11px;margin-right: 11px;">字段名称&nbsp;&nbsp;&nbsp;</label>
                <input  id="fieldName" type="text" name="fieldName" class="bi-width140  form-control validate[required]" value="${data.fieldName}"/>
                <b class="redColor">*</b>
            </div>
            <div class="div_h" style="margin-left:16px;">
                <label for="fieldZhname">字段中文名&nbsp;&nbsp;</label>
                <input  id="fieldZhname" type="text" name="fieldZhname" class="bi-width140 form-control validate[required]" value="${data.fieldZhname}"/>
                <b class="redColor">*</b>
            </div>

        </div>


        <div class="div_border"  style="padding:10px 20px">
            <div class="div_h">
                <label for="fieldType" style="margin-right: 11px;margin-left: 11px;">字段类型&nbsp;&nbsp;&nbsp;</label>
                <select  id="fieldType"  name="fieldType" class="bi-width140  form-control ">
                    <option value="nvarchar">nvarchar</option>
                    <option value="decimal">decimal</option>
                    <option value="numeric">numeric</option>
                    <option value="datetime">datetime</option>
                </select>
                <b class="redColor">*</b>
            </div>
            <div class="div_h" style="margin-left:20px; ">
                <label for="typeLength" style="margin-right: 25px;">长度&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <input  id="typeLength" type="number" name="typeLength" class="bi-width140 form-control validate[required]"
                        onkeydown="DigitInput(this)" value="255" value="${data.typeLength}"/>
                <b class="redColor">*</b>
            </div>

        </div>
        <div class="div_border"  style="padding:10px 20px">

            <div class="div_h">
                <label for="controlType" style="margin-right: 11px;margin-left: 11px;">控件风格&nbsp;&nbsp;&nbsp;</label>
                <select  id="controlType"  name="controlType" class="bi-width140  form-control ">
                    <option value="日期控件">日期控件</option>
                    <option value="日期时间控件" >日期时间控件</option>
                    <option value="年月控件">年月控件</option>
                    <option value="年控件" >年控件</option>
                    <option value="字典SQL表格控件">字典SQL表格控件</option>
                    <option value="PID0SQL树控件" >PID0SQL树控件</option>
                    <option value="LENSQL树控件">LENSQL树控件</option>
                    <option value="字典SQL下拉控件" >字典SQL下拉控件</option>
                    <option value="对应值下拉控件">对应值下拉控件</option>
                    <option value="文本控件" >文本控件</option>
                    <option value="多选控件">多选控件</option>
                    <option value="1列多选控件" >1列多选控件</option>
                    <option value="2列多选控件">2列多选控件</option>
                    <option value="3列多选控件" >3列多选控件</option>
                    <option value="4列多选控件">4列多选控件</option>
                    <option value="单选控件" >单选控件</option>
                    <option value="1列单选控件">1列单选控件</option>
                    <option value="2列单选控件" >2列单选控件</option>
                    <option value="3列单选控件" >3列单选控件</option>
                    <option value="4列单选控件" >4列单选控件</option>
                    <option value="数字控件" >数字控件</option>
                    <option value="多行文本控件" >多行文本控件</option>

                </select>

            </div>
        </div>
        <div  class=" div_border"  style="padding:10px 20px">
            <label for="dataSql" style="margin-right: 29px;margin-left: 11px;">数据项或SQL&nbsp;&nbsp;&nbsp;</label>
            <%--<input  type="text" placeholder=" " id="items" name="items" class="bi-width357  form-control"/>--%>
            <textarea id="dataSql" class="bi-width357  form-control"
                      type="text" placeholder=" " name="dataSql" style="width:450px;height:80px;">${data.dataSql}</textarea>

        </div>


        <button type="button" onclick="clearall()" class="btn btn-default bi-btn bi-btn-default  bi-btn-width90" >取消</button>
        <button type="submit"  class="btn btn-primary bi-btn bi-btn-width90">保存</button>

        <%--<div style="padding-left:25px; margin-top:20px;color:orangered;">--%>
            <%--<p>注：序号影响创建数据库字段位置</p>--%>
        <%--</div>--%>
    </div>

</form>



</body>
</html>
