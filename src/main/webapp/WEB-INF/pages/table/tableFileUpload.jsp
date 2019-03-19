<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/8/30
  Time: 9:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <%@ include file="/common/meta.jsp" %>
    <script type="text/javascript" src="${ctx }/static/js/ajaxfileupload.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <script type="text/javascript">
        //		点取消关闭窗口
        function clearall() {
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
            parent.layer.close(index); //执行关闭
        }
        function refreshParent() {
            GetIndexActiveIframe().refresh();
        }
        function btnclose() {
            closeIndexWindwos();
        }

        $(function () {
            $('#addbtn').bind('click', function () {
                submit();
            })
        })
        function submit() {
            var formData = new FormData($('#fileUpload')[0]);
            $.ajax({
                url: '${ctx }/table/saveFile',
                type: 'POST',
                data: formData,
                dataType: 'json',
                async: false,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
//                    alert('test');
                    if (data.success == false) {
                        return false;
                    }
                    else {
                        parent.refresh();
                        layerSuccess("成功", function () {
                            //关闭窗体
                            closeIndexWindwos();
                        });

                    }
                    return false;
                }
            });
        }
    </script>
</head>
<body>
<form id="fileUpload" action='${ctx}/table/saveFile' method="post" enctype="multipart/form-data">
    <input type="hidden" id="id" name="id" value="${id}"/>

    <div class="container from-content">
        <div style="padding:10px;color:orangered;">Excel模板文件</div>
        <div class=" div_border">
            <label for="exceltemplate">选择</label>
            <input id="exceltemplate" type="text" placeholder=" " name="file"
                   class="bi-width357 easyui-filebox form-control" data-options="prompt:'选择文件'">
        </div>
        <button type="button" onclick="clearall()" class="btn btn-default bi-btn bi-btn-default  bi-btn-width90">取消
        </button>
        <button type="button" class="btn btn-primary bi-btn bi-btn-width90" id="addbtn">保存</button>

    </div>
</form>
</body>
</html>
