<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/8/12
  Time: 10:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link href="${ctx }/static/codemirror-5.14.2/lib/codemirror.css" rel="stylesheet"/>
    <script type="text/javascript" src="${ctx}/static/codemirror-5.14.2/lib/codemirror.js"></script>
    <script type="text/javascript" src="${ctx}/static/codemirror-5.14.2/mode/javascript/javascript.js"></script>
    <script type="text/javascript" src="${ctx}/static/codemirror-5.14.2/mode/sql/sql.js"></script>

    <script type="text/javascript">
        //		点取消关闭窗口
        function clearall() {
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
            parent.layer.close(index); //执行关闭
        }
        function refreshParent() {
            GetIndexActiveIframe().refresh();
        }
        function btnclose() {
            closeIndexWindwos();
        }

        $(function () {
            // 自定义参数调用
            formValiPost("biaodan", "${ctx}/formDefine/save", function (json) {
                if (json.success == false) {
                    $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                }
                else {
                    window.parent.loadFormDefine();
//                    window.parent.refresh();
                    $('#biaodan')[0].reset();
                    layerSuccess("成功",function(){
                        //关闭窗体
                        closeIndexWindwos();
                    });

                }

            });
        });
    </script>
</head>
<body>
<form id="biaodan" action="${ctx}/formDefine/save" method="post">
    <div class="container from-content">
        <div class="div_border">
            <label for="name" style="margin-right:23px;">名称&nbsp;&nbsp;&nbsp;</label>
            <input type="text" placeholder=" " id="name" name="name"
                   class="bi-width357 validate[required] form-control"/>
            <b class="redColor">*</b>
        </div>
        <div class=" div_border">
            <div class="div_h">
                <label for="fg" style="margin-right:10px;">表单风格</label>
                <select name="fg" id="fg" style="padding:2px 0px;width:140px;text-align: center ;border:1px solid #aaa;
                        height:25px;color:#555;border-radius: 2px;" >
                    <option value="1">风格1</option>
                    <option value="2">风格2</option>
                    <option value="3">风格3</option>
                </select>
            </div>
            <div class="div_h" style="margin-left:15px;">
                <label for="dateType" style="margin-right:5px;">日期类型</label>
                <select name="datetype" id="dateType" style="padding:2px 0px;width:140px"
                        class="bi-width140 form-control validate[required]" >
                    <option value="年">年</option>
                    <option value="月">季</option>
                    <option value="月">月</option>
                    <option value="日">日</option>
                </select>
                <b class="redColor">*</b>
            </div>
        </div>
            <div class="div_border">
                <label for="bz" style="margin-right:23px;">说明&nbsp;&nbsp;&nbsp;</label>
                <input id="bz" type="text" placeholder=" " name="bz" class="bi-width357 form-control">
            </div>
        <div class="div_border">
            <div class="bi-div-checkbox">
                <input id="isNew" type="checkbox" name="isNew"/>
                <label for="isNew">新增</label>
            </div>
            <div class="bi-div-checkbox">
                <input id="isEdit" type="checkbox" name="isEdit"/>
                <label for="isEdit">修改</label>
            </div>
            <div class="bi-div-checkbox">
                <input id="isDel" type="checkbox" name="isDel"/>
                <label for="isDel">删除</label>
            </div>
            <div class="bi-div-checkbox">
                <input id="isSh" type="checkbox" name="isSh"/>
                <label for="isSh">审核</label>
            </div>
        </div>
        <button type="button" onclick="clearall()" class="btn btn-default bi-btn bi-btn-default  bi-btn-width90">取消
        </button>
        <button type="submit" class="btn btn-primary bi-btn bi-btn-width90">保存</button>

    </div>
</form>


</body>
</html>