<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/8/15
  Time: 9:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp"%>
    <title></title>
    <link href="${ctx }/static/codemirror-5.14.2/lib/codemirror.css" rel="stylesheet" />
    <script type="text/javascript" src="${ctx}/static/codemirror-5.14.2/lib/codemirror.js"></script>
    <script type="text/javascript" src="${ctx}/static/codemirror-5.14.2/mode/javascript/javascript.js"></script>
    <%--<script type="text/javascript" src="${ctx}/static/codemirror-5.14.2/mode/sql/sql.js"></script>--%>
    <script>
        $(function () {
            var myTextarea = document.getElementById('txtjs');
            var CodeMirrorEditor = CodeMirror.fromTextArea(myTextarea, {
                mode: "text/javascript",
                lineNumbers: true
            });
        });
        $(function(){
            $("#saveform").validate({
                //规则
                rules: {
                    name:{required: true, minlength:2, maxlength:90},
                    age:{required:true,digits:true},
                    price:{required:true,number:true}
                },
                //提示信息
                messages: {
                    name: { required:"请输入2~20位的商品名称"},
                    age:{required:"请填写过关人数!",digits:"只能输入整数!"},
                    price:{required:"请输入价格",number:"价格只能为数字"}
                }
            });
        });
    </script>


</head>
<body>

<form action="" id="saveform" method="post" >
    <div >
        <div class="basic_table">
            <div class="clospan">
                <p class="basic_name" style=" border-right:none;">name</p>
                <p>
                    <input name="name"  id="name" type="text"   class="easyui-textbox"   placeholder="name" />
                </p>
            </div>
        </div>
        <div class="basic_table">
            <div class="clospan">
                <p class="basic_name" style=" border-right:none;">age</p>
                <p>
                    <input name="age"  id="age" type="text"   class="easyui-textbox"   placeholder="age" />
                </p>
            </div>
        </div>

        <div class="basic_table">
            <div class="clospan">
                <p class="basic_name" style=" border-right:none;">price</p>
                <p>
                    <input name="price"  id="price" type="text"  class="easyui-textbox"
                            placeholder="price" />
                </p>
            </div>
        </div>





        <div class="clospan_func">
            <div class="btns">
                <input type="submit" value="保存">
            </div>
        </div>
    </div>
</form>

<textarea id="txtjs" readonly class="bi-l-textarea" style="width: 100%; height: 300px"></textarea>


</body>
</html>







