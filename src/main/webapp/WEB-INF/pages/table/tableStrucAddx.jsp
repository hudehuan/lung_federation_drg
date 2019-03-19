<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/8/3
  Time: 15:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp"%>
    <title>元数据表结构定义</title>

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
            // 自定义参数调用
                formValiPost("yuansuju", "${ctx }/tabstruc/save", function (json) {
                    if (json.success == false) {
                        $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                    }
                    else {
                        parent.loadTabStruc();
                        layerSuccess("成功", function () {
                            //关闭窗体
                            closeIndexWindwos();
                        });

                    }

                });
        });
    </script>

</head>
<body>
<form  id="yuansuju" action="${ctx }/tabstruc/save " method="post">
    <input type="hidden" name="tableId" id ="tableId" value="${tableid}"/>
    <input type="hidden" name="id" id ="id"/>
    <div class="container from-content">
        <div class="div_border"  style="padding:10px 20px">
            <div class="div_h ">
            <label for="xh" style="margin-left: 11px;margin-right: 11px;">序号&nbsp;&nbsp;</label>
            <input  id="xh" type="number" name="xh" class="bi-width140  form-control"
                    onkeydown="DigitInput(this)"/>
        </div>
        <div class="div_h" style="margin-left:27px;">
            <input id="isKey" type="checkbox" name="isKey"/>
            <label for="isKey">关键字&nbsp;&nbsp;</label>
        </div>
    </div>
    <div class="div_border"  style="padding:10px 20px">
        <div class="div_h">
            <label for="name" style="margin-left: 11px;margin-right: 11px;">字段&nbsp;&nbsp;&nbsp;</label>
            <input  id="name" type="text" name="name" class="bi-width140  form-control validate[required]"/>
            <b class="redColor">*</b>
        </div>
        <div class="div_h" style="margin-left:16px;">
            <label for="zhName">中文名&nbsp;&nbsp;</label>
            <input  id="zhName" type="text" name="zhName" class="bi-width140 form-control validate[required]"/>
            <b class="redColor">*</b>
        </div>
    </div>
    <div class="div_border"  style="padding:10px 20px">
        <div class="div_h">
            <label for="type" style="margin-right: 11px;margin-left: 11px;">类型&nbsp;&nbsp;&nbsp;</label>
            <select  id="type"  name="type" class="bi-width140  form-control ">
                <option value="nvarchar">nvarchar</option>
                <option value="decimal">decimal</option>
            </select>
            <b class="redColor">*</b>
        </div>
        <div class="div_h" style="margin-left:20px; ">
            <label for="colLength">长度&nbsp;&nbsp;&nbsp;&nbsp;</label>
            <input  id="colLength" type="number" name="colLength" class="bi-width140 form-control validate[required]"
                    onkeydown="DigitInput(this)"/>
            <b class="redColor">*</b>
        </div>
    </div>
    <div  class=" div_border"  style="padding:10px 20px">
        <label for="bz" style="margin-right: 11px;margin-left: 11px;">备注&nbsp;&nbsp;&nbsp;</label>
        <input  type="text" placeholder=" "id="bz" name="bz" class="bi-width357  form-control"/>

    </div>
    <button type="button" onclick="clearall()" class="btn btn-default bi-btn bi-btn-default  bi-btn-width90" >取消</button>
    <button type="submit"  class="btn btn-primary bi-btn bi-btn-width90">保存</button>

        <div style="padding-left:25px; margin-top:20px;color:orangered;">
            <p>注：序号影响创建数据库字段位置</p>
        </div>
    </div>

</form>


</body>
</html>
