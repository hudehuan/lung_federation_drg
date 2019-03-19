<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/8/3
  Time: 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp"%>
    <title>字典表项目表</title>
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
            formValiPost("xiangmu","${ctx}/SysDictionaryItem/save",function(json){
                if(json.success==false)
                {
                    $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                }
                else
                {
                    parent.loadDicItem($('#did').val());
                    layerSuccess("成功",function(){
                        //关闭窗体
                        closeIndexWindwos();
                    });

                }
            });
        });
    </script>

</head>
<body>


<form  id="xiangmu" action="${ctx}/SysDictionaryItem/save" method="post">
    <input type="hidden" name="itemId" value="${dicItem.itemId}"/>
    <input type="hidden" id="did" name="did" value="${did}"/>
    <div class="container from-content">
        <div style="margin-top:10px;color:orange">${dicName}编辑项目</div>
        <div class="div_border">
            <div class="div_h">
                <label for="xh" style="margin-right:12px;">序号</label>
                <input  id="xh" type="number" class="bi-width140 form-control" onkeydown="DigitInput()"
                        name="xh"style="" value="${dicItem.xh}"/>
            </div>
            <div class="div_h">
                <label for="itemCode"  style="margin-right:24px;margin-left: 24px">代码</label>
                <input  type="text" placeholder=" " class="bi-width140 validate[required] form-control" id="itemCode"
                         name="itemCode" value="${dicItem.itemCode}"/>
                <b class="redColor">*</b>
            </div>
        </div>
        <div  class=" div_border">
            <label for="dicName" style="margin-right:12px;">名称</label>
            <input  type="text" placeholder=" "id="dicName" name="dicName" value="${dicItem.dicName}"
                    class="bi-width357 validate[required] form-control"/>
            <b class="redColor">*</b>
        </div>
        <div class=" div_border">
            <label for="bz"  style="margin-right:12px;">说明</label>
            <input id="bz" name="bz" type="text" placeholder=" " class="bi-width357 form-control" value="${dicItem.bz}"/>
        </div>
        <button type="button" onclick="clearall()" class="btn btn-default bi-btn bi-btn-default  bi-btn-width90">取消</button>
        <button type="submit"  class="btn btn-primary bi-btn bi-btn-width90">保存</button>

    </div>
</form>


</body>
</html>
