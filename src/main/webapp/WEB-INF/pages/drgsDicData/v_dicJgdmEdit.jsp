<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/08/07
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <script type="text/javascript" src="${ctx }/static/js/stickUp.min.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/FormValidation.js"></script>
    <title></title>
    <script>

        $(function () {
            setTimeout(function(){
                $(".btn-group-right").stickUp();
            },1)

            if('${entity.dm}'){
                $("#dm").attr("readonly","readonly");
            }

            formValiPost2("formid", "${ctx}/DicJgdm/save",validateForm, function (json) {
                parent.reLoadGrid();
                if (json.success == false) {
                    if(json.id){
                        $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                    }else{
                        layerInfo(json.msg);
                    }
                }
                else {
                    parent.layerSuccess("成功", function () {
                        //关闭窗体
                        closeIndexWindwos();
                    });
                }
            });
        })

        var empty="";//看是否为空
        function validateForm(){

            required("dm");   //类型
            required("mc");   //名称
            if(empty.indexOf("0,")>=0){
                return false;
            }
            return true;

        }

        function clearall(){
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
            parent.layer.close(index); //执行关闭
        }
    </script>


    <style>
        label{
            /*text-align:right;*/
            display: inline-block;
            width: 118px;
        }
        body{overflow-y: auto}
        .bi-stickUp{
            display:block;background-color:#dff0d8 ;opacity:0.9;padding:5px;overflow: hidden;width:100%;z-index: 999;border:1px solid #dff0d8;
        }
    </style>

</head>
<body>
<form id="formid">
    <div class="btn-group-right bi-stickUp" >
        <div class="btn-group "  role="group" style="float:right">
            <button type='submit' class="btn btn-default bi-btn-width90" >保存</button>
            <button type='button' class="btn btn-default bi-btn-width90" onclick="clearall()">退出</button>
        </div>
    </div>


    <div class="container from-content" style="padding: 20px 20px 20px ;">

        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h">
                <label for="xh" style="">序号:</label>
                <input id="xh" style="width:280px;" class="bi-width140  form-control"  type="text" placeholder=" " name="xh" value="${entity.xh}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h" style="">
                <label for="dm" style="">代码Gid:</label>
                <input id="dm" style="width:280px;" class="bi-width140  form-control"  type="text" placeholder=" " name="dm" value="${entity.dm}"/>
                <b class="redColor">*</b>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h">
                <label for="mc" style="">名称:</label>
                <input id="mc" style="width:280px;"  class="bi-width140  form-control"  type="text" placeholder=" " name="mc" value="${entity.mc}"/>
                <b class="redColor">*</b>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h" style="">
                <label for="xzqh" style="">行政区划代码:</label>
                <input id="xzqh" style="width:280px;"  class="bi-width140  form-control"  type="text" placeholder=" " name="xzqh" value="${entity.xzqh}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h">
                <label for="xzqhmc" style="">行政区划名称:</label>
                <input id="xzqhmc" style="width:280px;"  class="bi-width140  form-control"  type="text" placeholder=" " name="xzqhmc" value="${entity.xzqhmc}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h" style="">
                <label for="sheng" style="">省:</label>
                <input id="sheng" style="width:280px;"  class="bi-width140  form-control"  type="text" placeholder=" " name="sheng" value="${entity.sheng}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h">
                <label for="shi" style="">市:</label>
                <input id="shi" style="width:280px;"  class="bi-width140  form-control"  type="text" placeholder=" " name="shi" value="${entity.shi}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h" style="">
                <label for="xian" style="">县:</label>
                <input id="xian" style="width:280px;"  class="bi-width140  form-control"  type="text" placeholder=" " name="xian" value="${entity.xian}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h">
                <label for="jgdm" style="">机构代码:</label>
                <input id="jgdm" style="width:280px;"  class="bi-width140  form-control"  type="text" placeholder=" " name="jgdm" value="${entity.jgdm}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h" style="">
                <label for="yyfr" style="">医院法人（负责人）:</label>
                <input id="yyfr"  style="width:280px;" class="bi-width140  form-control"  type="text" placeholder=" " name="yyfr" value="${entity.yyfr}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h">
                <label for="yyzrr" style="">信息上报负责人:</label>
                <input id="yyzrr" style="width:280px;"  class="bi-width140  form-control"  type="text" placeholder=" " name="yyzrr" value="${entity.yyzrr}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h" style="">
                <label for="tel" style="">联系电话:</label>
                <input id="tel"  style="width:280px;" class="bi-width140  form-control"  type="text" placeholder=" " name="tel" value="${entity.tel}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h">
                <label for="yyjb" style="">医院级别:</label>
                <input id="yyjb"  style="width:280px;" class="bi-width140  form-control"  type="text" placeholder=" " name="yyjb" value="${entity.yyjb}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h" style="">
                <label for="yydj" style="">医院等别:</label>
                <input id="yydj"  style="width:280px;" class="bi-width140  form-control"  type="text" placeholder=" " name="yydj" value="${entity.yydj}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h">
                <label for="yylb" style="">医院类别:</label>
                <input id="yylb"  style="width:280px;" class="bi-width140  form-control"  type="text" placeholder=" " name="yylb" value="${entity.yylb}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h" style="">
                <label for="issz" style="">委直:</label>
                <input id="issz"  style="width:280px;" class="bi-width140  form-control"  type="text" placeholder=" " name="issz" value="${entity.issz}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h">
                <label for="isbjorqg" style="">疾病版本:</label>
                <input id="isbjorqg"  style="width:280px;" class="bi-width140  form-control"  type="text" placeholder=" " name="isbjorqg" value="${entity.isbjorqg}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h" style="">
                <label for="iscwtj" style="">财务数据:</label>
                <input id="iscwtj"  style="width:280px;" class="bi-width140  form-control"  type="text" placeholder=" " name="iscwtj" value="${entity.iscwtj}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h">
                <label for="jc" style="">简称:</label>
                <input id="jc"  style="width:280px;" class="bi-width140  form-control"  type="text" placeholder=" " name="jc" value="${entity.jc}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h" style="">
                <label for="sysb" style="">住院数据:</label>
                <input id="sysb" style="width:280px;"  class="bi-width140  form-control"  type="text" placeholder=" " name="sysb" value="${entity.sysb}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h">
                <label for="bzcw" style="">编制床位数:</label>
                <input id="bzcw" style="width:280px;"  class="bi-width140  form-control"  type="text" placeholder=" " name="bzcw" value="${entity.bzcw}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h" style="">
                <label for="sjkfcw" style="">实际开放床位数:</label>
                <input id="sjkfcw" style="width:280px;"  class="bi-width140  form-control"  type="text" placeholder=" " name="sjkfcw" value="${entity.sjkfcw}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h">
                <label for="zbys" style="">在编执业医师数:</label>
                <input id="zbys" style="width:280px;"  class="bi-width140  form-control"  type="text" placeholder=" " name="zbys" value="${entity.zbys}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h" style="">
                <label for="zbzyhs" style="">在编执业护士数:</label>
                <input id="zbzyhs" style="width:280px;"  class="bi-width140  form-control"  type="text" placeholder=" " name="zbzyhs" value="${entity.zbzyhs}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h">
                <label for="htyss" style="">合同医师数（人）:</label>
                <input id="htyss"  style="width:280px;" class="bi-width140  form-control"  type="text" placeholder=" " name="htyss" value="${entity.htyss}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h" style="">
                <label for="hthss" style="">合同护士数（人）:</label>
                <input id="hthss"  style="width:280px;" class="bi-width140  form-control"  type="text" placeholder=" " name="hthss" value="${entity.hthss}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h">
                <label for="zymj" style="">住院面积(净)（㎡）:</label>
                <input id="zymj" style="width:280px;"  class="bi-width140  form-control"  type="text" placeholder=" " name="zymj" value="${entity.zymj}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h" style="">
                <label for="mzmj" style="">门诊面积(净)（㎡）: </label>
                <input id="mzmj"  style="width:280px;" class="bi-width140  form-control"  type="text" placeholder=" " name="mzmj" value="${entity.mzmj}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h">
                <label for="gid" style="">代码:</label>
                <input id="gid" style="width:280px;"  class="bi-width140  form-control"  type="text" placeholder=" " name="gid" value="${entity.gid}"/>
            </div>
        </div>
        <div class="div_border"  style="padding:5px 0px;">
            <div class="div_h" style="">
                <label for="jglbdm" style="">卫生机构类别代码:</label>
                <input id="jglbdm" style="width:280px;"  class="bi-width140  form-control"  type="text" placeholder=" " name="jglbdm" value="${entity.jglbdm}"/>
            </div>
        </div>

    </div>


</form>


</body>
</html>
