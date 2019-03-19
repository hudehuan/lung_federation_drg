<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/11/2
  Time: 16:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>填写审核日志</title>


    <script type="text/javascript">
        function doCancel(){
            <%--document.location.href="${ctx }/users/userlist";--%>
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
            parent.layer.close(index); //执行关闭
//            closeIndexWindwos();
        }


        function save(){
            $.ajax({
                type: "POST",
                url:'/CustomFormShLog/dobohui',
                data:$('#logform').serialize(),
                dataType: 'json',
                success: function(data) {
                    if(data.success == true){
                        //刷新父页面列表
                        parent.loadList();
                        parent.layerSuccess("成功", function () {
                            //刷新父页面列表
//                            parent.loadCheckList();
//                            parent.ref();
                            //关闭窗体
                            closeIndexWindwos();
                        });
                    }else{
                        layerInfo(data.msg);
                    }


                }
            });
        }


    </script>




</head>
<body>



<form id="logform" action="${ctx}/sjsbFormShLog/dobohui" method="post">

    <input type="hidden" name="checkID" value="${checkID}"/>
    <input type="hidden" name="formID" value="${formID}"/>
    <input type="hidden" name="flowID" value="${flowID}"/>
    <input type="hidden" name="stepID" value="${stepID}"/>
    <input type="hidden" name="dataID" value="${dataID}"/>



    <div style="margin: 10px">
        <textarea name="sm" rows="8"  style="margin-top:5px; width: 100%;"></textarea>

    </div>






    <div style="text-align: center;" >
        <div class="btns">
            <button type="button" onclick="doCancel()" id="doSubmit" class="btn btn-default bi-btn bi-btn-width90 blank_btn" style="margin-left:20px;margin-right:90px;">返回</button>
            <button type="button"  onclick="save();" class="btn btn-primary bi-btn bi-btn-width90 blank_btn">保存</button>

        </div>
    </div>
</form>






</body>
</html>
