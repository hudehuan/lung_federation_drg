<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2017/1/24
  Time: 9:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <%@ include file="/common/meta.jsp" %>
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <script type="text/javascript" src="${ctx }/static/js/stickUp.min.js"></script>

    <script type="text/javascript" src="${ctx }/static/js/avalon.js"></script>
    <script>
        var vm = avalon.define({
            $id: "formid",
            data: {
                tid: "",
                name: ""
            }
        })

        var id =null;
        $(function(){
            formValiPost3("formid",'/sysMenuTemplate/saveTemplate',validateForm,function(){
                var newdata=vm.$model.data;
                console.log(JSON.stringify(vm.$model.data));
                for (var a in vm.$model.data) {
                    console.log(vm.$model.data[a]);
                    if (Object.prototype.toString.call(vm.$model.data[a]) === "[object Array]") {
                        newdata[a] = vm.$model.data[a].join(",")
                    }
                }
                return newdata;
            },function (json) {
                if (json.success == false) {
                    if(json.id!=null&&json.id!=""){
                        $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                    }else{
                        layerError(json.msg);
                    }
                    // closeIndexWindwos();
                }
                else {
                    layerSuccess("成功", function () {
                        if(id!=null){
                            parent.loadMenuList();
                        }
                        //关闭窗体
                        closeIndexWindwos();
                    });
                }
            });

            id = GetUrlParam("id");
            vm.data.id = id;
            initbind(id);
        })

        var empty="";//看是否为空
        function validateForm(){
            return true;
        }

        function initbind(id){
            if(id!=null&&id!=""){
                $.ajax({
                    method: "POST",
                    url: '//sysMenuTemplate/getUpdateMenu?id='+id,
                    success: function (data) {
                        vm.data =data;
                    }
                })
            }
        }

        function clearForm(){
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
            parent.layer.close(index); //执行关闭
        }

    </script>
</head>
<body>
<div style="width:100%;float:right;display:inline-block; padding:10px 20px 10px 60px;border-left:1px solid #ddd;">
    <div style="padding:0 10px 10px 20px;margin-left:20px;">
        <form id="formid"  ms-controller="formid" class="bi_form">
            <input type="hidden" id="tid" :duplex='@data.tid'/>
            <div class="div_border">
                <div class="div_h">
                    <label for="name">菜单模板名称&nbsp;&nbsp;&nbsp; </label>
                    <input type="text" class="bi-width140 form-control validate[required]" id="name" :duplex='@data.name' name="">
                    <b class="redColor">*</b>
                </div>
            </div>
            <button type="button" class="btn btn-default bi-btn-default bi-btn bi-btn-width90"
                    style="margin-left:10px;marrgin-top:25px;" name="closed" onclick="clearForm()">取消
            </button>
            <button type="submit" class="btn btn-primary bi-btn bi-btn-width90" style="margin-top:25px;">保存</button>

        </form>
    </div>
</div>
</div>
</body>
</html>