<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/12/13
  Time: 15:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <script type="text/javascript" src="${ctx }/static/js/avalon.js"></script>
    <script>
        var vm = avalon.define({
            $id: "formid",
            data: {
                id:"",
                name:"",
                url:"",
                xh:"",
                stauts:"",
                sysCode:"",
                type:"function",
                printUrl:"",
                hospitelName:"",
                bz:"",
                cjrqStr:""
            }
        })
        $(function(){
            var dataID = GetUrlParam("id");
            vm.data.id = dataID;
            initData(dataID);
//            var url = '/sysMenu/getAllMenu?='+ parseInt(Math.random()*100000);
            <%--if(${roleMenu.isEdit}){--%>
            <%--formValiPost("formid", "${ctx}/sysMenuFunction/save", function (json) {--%>
            formValiPost3("formid",'${ctx}/sysMenuFunction/save',validateForm,function(){
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
                        layerError(json,msg);
                    }
                    // closeIndexWindwos();
                }
                else {
                    layerSuccess("成功", function () {
                        //关闭窗体
                        parent.loadMenuList();
                        closeIndexWindwos();
                    });
                }
            });
//            }
//            else{
//                layerInfo("没有权限!请找系统管理员申请权限!");
//            }

        });

        function initData(id){
            if(id!=null&&id!=""){
                $.ajax({
                    method: "POST",
                    url: "${ctx}/sysMenuFunction/getById?id="+id,
                    success: function(data){
                        vm.data = data;
                    }
                })
            }
        }

        function validateForm(){
            return true;
        }

    </script>
</head>
<body>
<form  id="formid"  ms-controller="formid" class="bi_form" >
    <input type="hidden" :duplex='@data.id' id="id">
    <div class="div_border">
        <div class="div_h">
            <label for="xh">序号&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
            <input type="number" class=" form-control bi-width140" id="xh" :duplex='@data.xh' style="width:50px;"
                   onkeydown="DigitInput()"/>
        </div>
    </div>


    <div class="div_border">
        <div class="div_h">
            <label for="name">类型名称&nbsp;&nbsp;&nbsp; </label>
            <input type="text" class="bi-width140 form-control validate[required]" id="name" :duplex='@data.name'>
            <b class="redColor">*</b>
        </div>
        <div class="div_h">
            <label for="type">类型&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
            <select :duplex='@data.type' id="type" style="padding:2px 0px;width:140px;"
                    class="bi-width140 form-control">
                <option value="function" name="function">功能</option>
                <option value="System" name="System">系统</option>
                <option value="sort" name="sort">分类</option>
                <option value="BI" name="BI">BI图表</option>
                <option value="BIolap" name="BIolap">BIolap</option>
                <option value="comment" name="comment">BI评价方案</option>
                <option value="report" name="report">BI分析报告</option>
                <option value="form" name="form">自定义表单</option>
                <option value="excel" name="excel">Excel导入</option>
            </select>
        </div>
    </div>
    <div class="div_border">

        <div class="div_h">
            <label for="hospitelName">&nbsp;医院名称&nbsp;&nbsp;&nbsp; </label>
            <input type="text" style="width: 350px;" class="bi-width140 form-control " id="hospitelName" :duplex='@data.hospitelName'>
        </div>
    </div>
    <div class="div_border">
        <div class="div_h ">
            <label for="url" style="margin-top:20px;float: left;line-height: 25px;">导入url&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </label>
                        <textarea id="url" class="bi-width357  form-control"
                                  placeholder=" " :duplex='@data.url' style="width:356px;height:60px;"></textarea>
        </div>

    </div>
    <div class="div_border">
        <div class="div_h ">
            <label for="printUrl" style="margin-top:20px;float: left;line-height: 25px;">打印url&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </label>
                        <textarea id="printUrl" class="bi-width357  form-control"
                                  placeholder=" " :duplex='@data.printUrl' style="width:356px;height:60px;"></textarea>
        </div>

    </div>

    <div class="div_border">
        <div class="div_h ">
            <label for="bz" style="margin-top:20px;float: left;line-height: 25px;">备注&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </label>
                        <textarea id="bz" class="bi-width357  form-control"
                                  placeholder=" " :duplex='@data.bz' style="width:356px;height:60px;"></textarea>
        </div>
    </div>

    <%--<button type="button" class="btn btn-default bi-btn-default bi-btn bi-btn-width90"--%>
            <%--style="margin-left:110px;marrgin-top:25px;" name="closed" onclick="clearForm()">取消--%>
    <%--</button>--%>
    <%--<button type="submit" class="btn btn-primary bi-btn bi-btn-width90" style="margin-top:25px;">保存</button>--%>

</form>
</body>
</html>
