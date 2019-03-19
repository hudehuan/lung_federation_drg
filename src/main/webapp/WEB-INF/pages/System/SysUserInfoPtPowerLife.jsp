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
        
        function load() {

            //创建一个FileReader对象
            var reader = new FileReader();
            //绑定load事件当FileReader对象通过readAsDataURL读取数据成功后，就会触发load事件。target中的result属性的值，就是该文件的base64数据
            reader.onload = function(e) {
                $("#powerFile").val(e.target.result);
            }

            /**
             * 开始读取指定的Blob对象或File对象中的内容.
             * 当读取操作完成时,readyState属性的值会成为DONE,如果设置了onloadend事件处理程序,则调用之.
             * 同时,result属性中将包含一个data: URL格式的字符串以表示所读取文件的内容.
             */
//            reader.readAsDataURL(document.getElementsByName('img')[0].files[0]);
            /**
             * * 同上, result属性中将包含一个字符串以表示所读取的文件内容.
             * encoding是可选项,类型为字符串,表示了返回数据所使用的编码.如果不指定,默认为UTF-8.
             * */
            reader.readAsText(document.getElementsByName('file')[0].files[0],"utf-8");
            /**
             * * 同上, result属性中将包含一个ArrayBuffer对象以表示所读取文件的内容.
             */
//            reader.readAsArrayBuffer(file);
            /**
             29  * 同上, result属性中将包含所读取文件的原始二进制数据.
             */
//            reader.readAsBinaryString(file);
        }

        function validateForm() {
            var filepath = $("#file").val();
            var re = /(\\+)/g;
            var filename=filepath.replace(re,"#");
            var array = filename.split(".");
            var last=array[array.length-1];
            if(last != "lisp"){
                $("#file").validationEngine('showPrompt', "请上传正确文件！", 'error', true);
                return false;
            }
            return true;
        }

        $(function(){
            // 自定义参数调用
            formValiPost2("change", "${ctx}/SysUserInfoPt/getPowerFile",validateForm, function (json) {
                if (json.success == false) {
                    layerInfo(json.msg);
                }
                else {
                    parent.refresh();
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

<form  id="change"  method="post" enctype="multipart/form-data">
    <input type="hidden" id="userid" name="userid" value="${ptInfo.userid}"/>
    <input type="hidden" id="sysCode" name="sysCode" value="${ptInfo.sysCode}"/>
    <input type="hidden" id="userType" name="userType" value="${ptInfo.userType}"/>
    <input type="hidden" id="powerFile" name="powerFile"value="" />
    <div class="container from-content">
        <!--  <div class="div_border">
                 <label for="c_password">初始密码&nbsp;&nbsp;</label>
                 <input  id="c_password" name="c_password" type="text" class="bi-width357 form-control validate[required]" />
         </div> -->
        <div  class=" div_border">

            <label for="xlh">序列化&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
            <input  type="text"  style="height: 28px;" placeholder=" "id="xlh" name="xlh" class="bi-width357 validate[required]  form-control"/>
            <b style="color: red">*</b>

        </div>
        <div  class=" div_border">

            <label for="file">授权文件&nbsp;&nbsp;</label>
            <input  type="file"style="margin-left: 2px;display: inline-block;height: 28px;" placeholder=" "id="file" name="file" onchange="load()"
                    data-options="prompt:'选择文件'"class="bi-width357 form-control  text-input" />
        </div>
        <div style="text-align: right">
            <b style="color: red">说明：请上传.lisp结尾注册文件！</b>
        </div>
        <button type="button" onclick="clearall()" class="btn btn-default bi-btn bi-btn-default   bi-btn-width90" >取消</button>
        <button type="submit"  class="btn btn-primary bi-btn bi-btn-width90">保存</button>

    </div>
</form>
</body>
</html>
