<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/12/14
  Time: 11:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>步骤添加</title>
    <script type="text/javascript" src="${ctx }/static/js/avalon.js"></script>
    <script>
        var vm = avalon.define({
            $id: "formid",
            data: {
                id:"",
                xh:"",
                name:"",
                sm:"",
                flowId:""
            }
        })
        $(function(){
            var id = GetUrlParam("id");
            vm.data.id = id;
            initData(id);
            var flowId = GetUrlParam("flowId");
            vm.data.flowId = flowId;
                formValiPost3("formid",'/CustomFormFlowStep/saveStep',validateForm,function(){
                var newdata=vm.$model.data;

                for (var a in vm.$model.data) {
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
                        //关闭窗体
                        parent.loadFormByFlowId(flowId);
                        closeIndexWindwos();
                    });
                }
            });
        })

        function initData(id){
            if(id!=null&&id!=""){
                $.ajax({
                    method: "POST",
                    url: "/CustomFormFlowStep/getStepById?id="+id,
                    dataType: "JSON",
                    success: function(data){
                        $("#xh").attr("readonly","readonly");
                        vm.data = data;
                    }
                })
            }
        }

        function validateForm(){
            return true;
        }
        function clearall(){
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
            parent.layer.close(index); //执行关闭
        }
    </script>
</head>
<body>
<form  id="formid"  ms-controller="formid" class="bi_form" >
    <input type="hidden" id="id" :duplex="@data.id" value=""/>
    <input type="hidden" id="flowId" :duplex="@data.flowId" value=""/>

        <div class="div_border">
            <label for="xh">序号</label>
            <input id="xh" type="text" placeholder=" " :duplex="@data.xh" class="form-control bi-width140 validate[required]"
                   onkeydown="DigitInput()" style="margin-left:20px;"/>
            <b class="redColor">*</b>
        </div>
        <div class="div_border">
            <label for="name" >名称</label>
            <input  id="name" type="text" placeholder=" "  :duplex="@data.name"  class="form-control bi-width140 validate[required]" style="margin-left:20px;"/>
            <b class="redColor">*</b>
        </div>
        <div class="div_border">
            <span style="margin-right:20px;position: relative;top: -15px">说明</span>
            <textarea style="width:357px;border:1px solid #aaa;border-radius: 3px;;"id="sm" :duplex="@data.sm"></textarea>

        </div>

    <div class="div_border">
        <button type="button" onclick="clearall()" class="btn btn-default bi-btn-default bi-btn bi-btn-width90 " name="closed">取消</button>
        <button type="submit"  class="btn btn-primary bi-btn bi-btn-width90 ">保存</button>

    </div>

</form>
</body>
</html>
