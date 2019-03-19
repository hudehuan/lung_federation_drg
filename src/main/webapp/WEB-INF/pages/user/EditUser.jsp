<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/7/18
  Time: 17:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp"%>
    <title></title>


    <script type="text/javascript">
        function doCancel(){
            document.location.href="${ctx }/users/userlist";
        }



        $(function(){
            $('#form1').form({
                onSubmit: function(){
                    var v = $(this).form('validate');
                    if(v){
                        $("#doSubmit").unbind('click');
                    }
                    return v;
                },
                success:function(data){
                    data = eval('(' + data + ')');
                    if(data.success == true){
                        document.location.href="${ctx }/users/userlist";
                    }else {
                        $("#doSubmit").bind("click",function(){
                            $('#form1').submit();
                        });
                        alert(data.msg);
                    }
                }
            });
            $("#doSubmit").click(function() {
                $('#form1').submit();
                return false;
            });
        });
    </script>



</head>
<body>


<form action="${ctx }/users/save " id="form1" method="post">
    <div class="dengji_table">
        <div class="basic_table">
            <div class="clospan">
                <p class="basic_name" style=" border-right:none;">名称</p>
                <p>
                    <input name="name"  id="name" type="text"   class="easyui-validatebox"  data-options="required:true" placeholder="用户姓名"/>
                </p>
            </div>
        </div>
        <div class="basic_table">
            <div class="clospan">
                <p class="basic_name" style=" border-right:none;">年龄</p>
                <p>
                    <input name="age"  id="age" type="number"  min="18" max="99" class="easyui-validatebox"  data-options="required:true" placeholder="年龄不得小于18"/>
                </p>
            </div>
        </div>
        <div class="basic_table">
            <div class="clospan">
                <p class="basic_name" style=" border-right:none;">地址</p>
                <p>
                    <input name="addree"  id="addree" type="text"  class="easyui-validatebox"  data-options="required:true" placeholder="现居住地址"/>
                </p>
            </div>
        </div>
        <div class="clospan_func">
            <div class="btns">
                <a href="javascript:void(0);" id="doSubmit" class="blank_btn" onclick="save();">保存</a>
                <a href="javascript:void(0);" onclick="doCancel();" class="blank_btn">返回</a>
            </div>
        </div>
    </div>
</form>

</body>
</html>
