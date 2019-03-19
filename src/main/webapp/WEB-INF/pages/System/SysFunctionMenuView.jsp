<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2017/2/4
  Time: 9:50
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
                id: "",
                code:"",
                pCode:"",
                name: "",
                url:"",
                printUrl:"",
                img:"",
                xh:"",
                status:"",
                sysCode:"",
                type:"",
                tid:""
            }
        })

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
            var id = GetUrlParam("id");
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
                    url: '/sysMenuTemplate/SysMenuTemplateEntity?id='+id,
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

<div style="margin:0 5px; overflow: hidden; border:1px solid #ddd;" id="menu1_warp">
    <!--表单 -->
    <div style="width:100%;display:inline-block; padding:10px 20px 10px 60px;border-left:1px solid #ddd;">
        <h4 style="display:block;padding:0; position:relative;">
            <span style="display: inline-block;float:left;margin-right:8px;height: 18px;width: 8px;background: #0066cc;"></span>
            菜单维护
        </h4>

        <div style="padding:0 10px 10px 20px;margin-left:20px;">
            <form id="formid"  ms-controller="formid" class="bi_form">
                <input type="hidden" name="id" id="id">
                <input type="hidden" name="refCode" id="refCode"/>
                <div class="div_border">
                    <div class="div_h ">
                        <label for="pCode">父菜单编码</label>
                        <input id="pCode" class="bi-width140 form-control" type="text" placeholder=" "
                              :duplex="@data.pCode" name="pCode" onkeydown="DigitInput()" style="width:137px;" readonly="readonly"/>
                    </div>

                </div>
                <div class="div_border">
                    <div class="div_h">
                        <label for="code">菜单编码&nbsp;&nbsp;&nbsp; </label>
                        <input type="text" class="bi-width140 validate[required] form-control" placeholder=" " id="code"
                               :duplex="@data.code" name="code" onkeydown="DigitInput()"/>
                        <b class="redColor">*</b>
                    </div>
                    <div class="div_h">
                        <label for="xh">&nbsp;&nbsp;&nbsp;&nbsp;序号&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                        <input type="number" class=" form-control bi-width140" id="xh" name="xh" style="width:50px;"
                               :duplex="@data.xh" onkeydown="DigitInput()"/>
                    </div>
                </div>


                <div class="div_border">
                    <div class="div_h">
                        <label for="name">菜单名称&nbsp;&nbsp;&nbsp; </label>
                        <input type="text" class="bi-width140 form-control validate[required]" id="name" :duplex="@data.name"
                               name="name">
                        <b class="redColor">*</b>
                    </div>
                </div>
                <div class="div_border">
                    <div class="div_h">
                        <label for="type">类型&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                        <select name="type" id="type" style="padding:2px 0px;width:140px;"
                                :duplex="@data.type" class="bi-width140 form-control" >
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
                    <div class="div_h ">
                        <label for="img">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;图标&nbsp;&nbsp;&nbsp;&nbsp;</label>
                        <input id="img" class="bi-width140 form-control" type="text" placeholder=" " name="img"
                               :duplex="@data.img" style="width:140px;"/>
                    </div>
                </div>
                <div class="div_border">
                    <div class="div_h ">
                        <label for="url" style="margin-top:20px;float: left;line-height: 25px;">导入url&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </label>
                        <textarea id="url" class="bi-width357  form-control"
                                  :duplex="@data.url" placeholder=" " name="url" style="width:354px;height:60px;"></textarea>
                    </div>

                </div>
                <div class="div_border">
                    <div class="div_h ">
                        <label for="printUrl" style="margin-top:20px;float: left;line-height: 25px;">打印url&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </label>
                        <textarea id="printUrl" class="bi-width357  form-control"
                                  :duplex="@data.printUrl" placeholder=" " name="printUrl" style="width:354px;height:60px;"></textarea>
                    </div>

                </div>

                <%--<button type="button" class="btn btn-default bi-btn-default bi-btn bi-btn-width90"--%>
                        <%--style="margin-left:110px;marrgin-top:25px;" name="closed" onclick="clearForm()">取消--%>
                <%--</button>--%>
                <%--<button type="submit" class="btn btn-primary bi-btn bi-btn-width90" style="margin-top:25px;">保存</button>--%>

            </form>
            <div>
                说明：只有类型为“分类”的菜单才能增加同级或下级，系统通用的功能类型要选择“系统”。
            </div>
        </div>
    </div>
</div>
</body>
</html>
