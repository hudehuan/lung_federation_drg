<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2017/4/22
  Time: 14:40
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <%@ include file="/common/meta.jsp" %>

    <title>Title</title>

    <script>
        //		点取消关闭窗口
        function clearall() {
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引

            parent.layer.close(index); //执行关闭
        }


        $(function(){

            $("input[name=style][value='${data.style}']").attr("checked",'checked');
            if('${data.active}'){
                $("#active").attr('checked', 'true');
            }

            if('${data.standard}'){
                $("#standard").attr('checked', 'true');
            }


            formValiPost("formtemplet", "${ctx}/CustomFormTemplate/save", function (json) {
                if (json.success == false) {
                    $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                }
                else {

                    layerSuccess("成功", function () {
                        //刷新父窗口数据
                        parent.refloadFormTemplet();
                        //关闭窗体
                        closeIndexWindwos();
                        $('#formtemplet')[0].reset()


                    });
                }
            });

        });





    </script>


</head>
<body>



<%--<input type="hidden" id="fieldID" value="${fieldID}"/>--%>

<form  id="formtemplet" >



    <input type="hidden" name="id" id="id" value="${data.id}"/>
    <input type="hidden" name="formId" id="formId" value="${formId}"/>
    <%--<input type="hidden" name="createTime" id="createTime" value="${sjsbSysFormTempletEntity.createTime}"/>--%>
    <div class="container from-content">

        <div class="div_border"  style="padding:10px 20px">
            <div class="div_h">
                <label for="xh" style="margin-right:33px;">序号</label>
                <input id="xh" class="bi-width140  form-control"
                       type="text" placeholder=" " value="${data.xh}" name="xh" />
                <b class="redColor">*</b>
            </div>
            <div class="div_h" style="margin-left:16px;">
                <label for="name" style="margin-right:10px;">模板名称</label>
                <input id="name" class="bi-width140  form-control" type="text" placeholder=" " value="${data.name}" name="name" />
                <b class="redColor">*</b>
            </div>

        </div>
        <div class="div_border"  style="padding:10px 20px">
            <div class="div_h">
                <%--<label for="style" style="margin:0 10px 0 0px;">模板风格</label>--%>
                <%--<input id="style" class="bi-width140  form-control" type="text" placeholder=" " value="" name="style" />--%>
                <%--<select  id="style"  name="style" class="bi-width140  form-control ">--%>
                    <%--<option value="1">Bootstrap风格</option>--%>
                    <%--<option value="2" selected="selected">Table风格</option>--%>

                    <%----%>
                <%--</select>--%>
                <span class="long_tit" style="margin-right:30px;">模板风格:</span>
                <input type="radio" name="style" id="style-1" value="A"> <label for="style-1" style="margin-right:33px;">Bootstrap风格</label>
                <input type="radio" name="style" id="style-2" value="B"> <label for="style-2" style="margin-right:33px;">Table风格</label>
                <b class="redColor">*</b>

            </div>

        </div>

        <div class="div_border"  style="padding:10px 20px">
            <div class="div_h">

                <span class="long_tit" style="margin-right:30px;">审核设置:</span>
                <input type="radio" name="shenhe" id="nocheck" value="0"> <label for="nocheck" style="margin-right:33px;">仅保存数据</label>
                <input type="radio" name="shenhe" id="check" value="1"
                       style="margin-left:20px;">
                <label for="check" style="margin-right:33px;">保存数据并审核</label>
                <b class="redColor">*</b>

            </div>


        </div>
        <div class="div_border"  style="padding:10px 20px">
            <div class="div_h">

                <input id="active" type="checkbox" name="active" style="margin-left:85px;"/>
                <label for="active" >是否激活</label>

            </div>

            <div class="div_h" style="margin-left:16px;">

                <input id="standard" type="checkbox" name="standard" style="margin-left:48px;"/>
                <label for="standard" >是否标准模板</label>
            </div>

        </div>








        <%--<div class="div_border">--%>
            <%--<label for="js" style="margin-right:10px;">JS</label>--%>
            <%--<textarea id="js" class="bi-width357  form-control"--%>
                      <%--type="text" placeholder=" " name="js"  style="width:400px;height:200px;"></textarea>--%>
            <%--&lt;%&ndash;<input class="easyui-textbox" id="mbContext" name="mbContext" data-options="multiline:true" style="width:800px;height:280px;">${sjsbSysFormTempletEntity.mbContext}</input>&ndash;%&gt;--%>
        <%--</div>--%>




        <button type="button" onclick="clearall()" class="btn btn-default bi-btn-default bi-btn bi-btn-width90 " name="closed">取消</button>
        <button type="submit"  class="btn btn-primary bi-btn bi-btn-width90 ">保存</button>


    </div>
</form>





</body>
</html>
