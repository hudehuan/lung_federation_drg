<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2017/1/5
  Time: 10:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <script type="text/javascript">
        //		点取消关闭窗口
        function clearall() {
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
            parent.layer.close(index); //执行关闭
        }

        function search() {
            var condition = $('#serach').val();
            var url = '${ctx }/SysStaff/findByCondition?condition=' + encodeURI(condition)+ "&rdm="+ parseInt(Math.random()*100000);
            $('#gridtable').datagrid({url: url});
        }

        $(function () {
            $("input [type='checkbox']").click(function(){
                if($(this).attr("value")=='1'){
                    $(this).attr("value",0)

                }
                else{
                    $(this).attr("value",1)

                }
            })
            if ($('#id').val() != "") {
                $("input:checkbox[value='1']").attr('checked', 'true');
                $("input:checkbox[value='true']").attr('checked', 'true');
            } else {
                $("#on").attr('checked', 'true');
                $("#isCheck").attr('checked', 'true');
            }
            $("input:checkbox[value='1'][name='report']").attr('checked', 'true');
            $("input:checkbox[value='1'][name='menuRole']").attr('checked', 'true');
            $("#homePageId option[value='${user.homePageId}']").attr("selected", "selected");
            $("#userType option[value='${userInfoPt.userType}']").attr("selected", "selected");
            // 自定义参数调用
            formValiPost("yonghubianji", "${ctx}/SysUserInfoPt/save", function (json) {
                if (json.success == false) {
                    $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                }
                else {
                    parent.loadUserInfo();
                    layerSuccess("保存成功", function () {
                        //关闭窗体
                        closeIndexWindwos();
                    });

                }

            });

        });
        function ischg(){//当下面的复选框全部选中时，则将第一个复选框设置为选中，当下面的复选框中有一个没有被选中时，则第一个复选框取消选中；

            if($('#isCheck').attr("value")=='true'){
                $('#isCheck').attr("value",false)

            }
            else{
                $('#isCheck').attr("value",true)

            }

        }

        function onchg(){//当下面的复选框全部选中时，则将第一个复选框设置为选中，当下面的复选框中有一个没有被选中时，则第一个复选框取消选中；
            if($('#on').attr("value")=='1'){
                $('#on').attr("value",0)

            }
            else{
                $('#on').attr("value",1)

            }

        }
    </script>
</head>
<body>

<form id="yonghubianji" action="${ctx}/SysUserInfoPt/save" method="post">
    <input id="id" name="id" type="hidden" value="${user.id}"/>
    <input id="flag" name="flag" type="hidden" value="${user.id}"/>
    <input id="pwd" name="loginPwd" type="hidden" value="${user.loginPwd}"/>
    <div class="container from-content" style="padding: 15px 0px 20px;">
        <div class="div_border">
            <div class="div_h" style="padding: 10px 0px;">
                <label for="choose">人员选择&nbsp;&nbsp;</label>
                <input id="choose" name="choose" type="text" style="width:120px;" class="bi-width140 form-control "
                       value="${name}" readonly="readonly"/>
            </div>

            <div class="div_h" style="padding: 10px 0px;margin-left: 9px">
                <label for="loginName">用户登录&nbsp;&nbsp;</label>
                <input type="text" placeholder=" " id="loginName" name="loginName" style="width:100px;"
                       class="bi-width140 validate[required] form-control" value="${user.loginName}"/>
                <b class="redColor">*</b>
            </div>

            <div class="div_h" style="padding: 10px 0px;">
                    <input id="on" type="checkbox" name="on" style="margin-left:5px;" value="${user.status}" /><label for="on"> &nbsp;启用</label>
                <input id="isCheck" type="hidden" name="isCheck" value="true" />
            </div>
        </div>
        <div class="div_border">
            <div class="div_h" style="padding: 10px 0px;">
                <label for="wtLoginName">卫统登录&nbsp;&nbsp;</label>
                <input type="text" placeholder=" " id="wtLoginName" name="wtLoginName" style="width:120px;"
                       class="bi-width140 validate[required] form-control" value="${userInfoPt.wtLoginName}"/>
                <b class="redColor">*</b>
                <%--<select name="homePageId" id="homePageId" style="padding:2px 0px; width:120px; " class="bi-width80 form-control">
                    <c:forEach items="${homePageInterfaceList}" var="item">
                        <option value="${item.id}">${item.name}</option>
                    </c:forEach>
                </select>--%>
            </div>
            <div class="div_h" style="padding: 10px 0px;">
                <label for="homePageId">角色类型&nbsp;&nbsp;</label>
                <select name="userType" id="userType" style="padding:2px 0px; width:100px; " class="bi-width80 form-control">
                    <option value="省级">省级</option>
                    <option value="市级">市级</option>
                    <option value="机构">机构</option>
                </select>
            </div>
            <%--<div class="div_h" style="padding: 10px 0px;">--%>
                <%--<input id="menuRole" type="checkbox" name="menuRole" value="${userInfoPt.menuRole}" style="margin-left:5px;"/><label for="menuRole"> &nbsp;导入导出权限</label>--%>
            <%--</div>--%>
            <div class="div_h" style="padding: 10px 0px;">
                <input id="report" type="checkbox" name="report" value="${userInfoPt.report}" style="margin-left:5px;"/><label for="report"> &nbsp;上报权限</label>
            </div>
        </div>

        <button type="button" onclick="clearall()" class="btn btn-default bi-btn  bi-btn-width90"
                style="margin-left:118px;margin-right:160px;">取消
        </button>
        <button type="submit" class="btn btn-primary bi-btn bi-btn-width90">保存</button>

    </div>
</form>

</body>
</html>
