<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/8/23
  Time: 14:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <%@ include file="/common/meta.jsp"%>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <script type="text/javascript">
        //		点取消关闭窗口
        function clearall(){
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
            parent.layer.close(index); //执行关闭
        }
        

        function validateForm() {
            var filepath = $("#file").val();
            var re = /(\\+)/g;
            var filename=filepath.replace(re,"#");
            var array = filename.split(".");
            var last=array[array.length-1];
            if(last != "dat"){
                $("#file").validationEngine('showPrompt', "请上传正确文件！", 'error', true);
                return false;
            }

            var formData = new FormData($( "#change" )[0]);

            $.ajax({
                url: "${ctx}/CaseaData/upJsonPData",
                type: 'POST',
                data: formData,
                dataType:"JSON",
                async: false,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    if(data.success==true){
                        layerSuccess(data.msg,function () {
                            closeIndexWindwos();
                        })
                    }else{
                        alert(data.msg);
                    }
                },
                error: function (data) {
                    alert(data.msg);
                }
            });

        }

    </script>

</head>
<body>

<form  id="change"  method="get" enctype="multipart/form-data">
    <input type="hidden" id="fDate" name="fDate" value="${fDate}"/>
    <div class="container from-content">
        <!--  <div class="div_border">
                 <label for="c_password">初始密码&nbsp;&nbsp;</label>
                 <input  id="c_password" name="c_password" type="text" class="bi-width357 form-control validate[required]" />
         </div> -->
        <div  class=" div_border">

            <label for="file">上传数据&nbsp;&nbsp;</label>
            <input  type="file"style="margin-left: 2px;display: inline-block;height: 28px;"
                    id="file" name="file"
                    data-options="prompt:'选择文件'"class="bi-width357 form-control  text-input" />
        </div>
        <div style="text-align: right">
            <b style="color: red ;" >说明：请上传.dat结尾数据文件！</b>
        </div>
        <button type="button" onclick="clearall()" class="btn btn-default bi-btn bi-btn-default   bi-btn-width90" >取消</button>
        <button type="submit"  class="btn btn-primary bi-btn bi-btn-width90">保存</button>
        <%--<button type="button" onclick="validateForm()" class="btn btn-primary bi-btn bi-btn-width90">保存</button>--%>

    </div>
</form>
</body>
</html>
