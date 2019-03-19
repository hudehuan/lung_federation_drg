<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/8/2
  Time: 16:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp"%>
    <title></title>
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
            var id = $('#id').val();
            if (id != "") {
                $('#name').attr("readonly","readonly");
            }
            formValiPost("mingcheng", "${ctx }/table/save", function (json) {
                if (json.success == false) {
                    $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                }
                else {

                    parent.loadList();
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
<form  id="mingcheng" action="${ctx }/table/save" method="post">
    <input type="hidden" name="excelName" value="${table.excelName}"/>
    <div class="container from-content">
        <div class=" div_border">
            <label for="name">数据库表名</label>
            <input type="hidden" name="id" id ="id" value="${table.id}"/>
            <input type="hidden" name="status" id ="status" value="${table.status}"/>
            <input id="name" type="text" placeholder=" " name="name" class="bi-width357 validate[required] form-control"
                    style="width: 300px" value="${table.name}">
            <b class="redColor">*</b>
        </div>
        <div  class=" div_border">
            <label for="zhName" style="margin-right:11px;">中文表名</label>
            <input  type="text" placeholder=" "id="zhName" name="zhName" class="bi-width357 validate[required] form-control"
                    style="width: 300px" value="${table.zhName}"/>
            <b class="redColor">*</b>
        </div>

        <div  class=" div_border">
            <label for="bz" style="margin-right:35px;">备注</label>
            <input  type="text" placeholder=" "id="bz" name="bz" class="bi-width357 form-control"
                    style="width: 300px" value="${table.bz}"/>
        </div>

        <button type="button" onclick="clearall()" class="btn btn-default bi-btn bi-btn-default  bi-btn-width90">取消</button>
        <button type="submit"  class="btn btn-primary bi-btn bi-btn-width90">保存</button>

        <div style="padding-left:25px; margin-top:20px;color:orangered;">
            <p>注：默认在数据库表名前自动添加“${sysCode}_Excel_”</p>
        </div>
    </div>

</form>
<%--<form id="fileUpload" action="${ctx }/table/saveFile" method="post" enctype="multipart/form-data">--%>
    <%--<div style="padding:10px;color:orangered;">Excel模板文件</div>--%>
    <%--<div class=" div_border">--%>
        <%--<label for="exceltemplate">选择&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>--%>
        <%--<input id="exceltemplate" type="text" placeholder=" " name="file" value="${table.excelName}"--%>
               <%--class="bi-width357 easyui-filebox form-control validate[required]"  data-options="prompt:'选择文件'">--%>
    <%--</div>--%>
<%--</form>--%>
</body>
</html>