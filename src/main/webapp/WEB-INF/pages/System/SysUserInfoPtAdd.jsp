<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/8/23
  Time: 10:56
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
            $("input [type='checked']").click(function(){
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

                $("#on").attr('value', '1');
                $("#isCheck").attr('value', 'true');
            }
            $("#homePageId option[value='${user.homePageId}']").attr("selected", "selected");
            loadStaff();
            // 自定义参数调用
            formValiPost("yonghubianji", "${ctx}/SysUserInfoPt/save", function (json) {
                if (json.success == false) {
                    $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                }
                else {
                    parent.loadUserInfo();
                    layerSuccess("成功", function () {
                        //关闭窗体
                        closeIndexWindwos();
                    });

                }

            });

        });

        function loadStaff() {

            $('#gridtable').datagrid(
                    {
                        method: 'get',
                        rownumbers: true,
                        singleSelect: true,
                        autoRowHeight: false,
                        pagination: true,
                        clientPaging: true,
                        remoteSort:false,
                        pageSize: 6,
                        pageList: [6],
                        columns: [
                            [
                                {field: 'id', title: '用户ID', hidden: true},
                                {field: 'code', title: '人员代码', width: '70px', align: 'left', halign: 'center'},
                                {field: 'name', title: '人员名称', width: '70px', align: 'left', halign: 'center'},
//                                {field: 'yqName', title: '院区', width: '100px', align: 'left', halign: 'center'},
//                                {field: 'ksName', title: '科室', width: '80px', align: 'left', halign: 'center'},
//                                {field: 'userClass', title: '人员类型', width: '100px', align: 'left', halign: 'center'},
//                                {field: 'kswName', title: '护理工作站', width: '80px', align: 'left', halign: 'center'},
//                                {field: 'zhiWei', title: '职位', width: '80px', align: 'left', halign: 'center'}
                            ]
                        ],
                        onClickRow: function (index, row) {
                            var name = row.name;
                            var id = row.id;
                            //var url = '/SysDictionaryItem/getAllDictionaryItemById?did='+row.did;
                            //loadDicItem(url);
                            $('#choose').val(name);
                            $('#loginName').val(row.code);
                            $('#id').val(id);
                        }
                    }).datagrid('clientPaging');
        }


        function ischg(){//当下面的复选框全部选中时，则将第一个复选框设置为选中，当下面的复选框中有一个没有被选中时，则第一个复选框取消选中；

            if($('#isCheck').attr("value")=='true'){
                $('#isCheck').attr("value",false)

            }
            else{
                $('#isCheck').attr("value",true)

            }

        }

        function onchg(){//当下面的复选框全部选中时，则将第一个复选框设置为选中，当下面的复选框中有一个没有被选中时，则第一个复选框取消选中；
            if($('#on').attr("value")=='true'){
                $('#on').attr("value",0)

            }
            else{
                $('#on').attr("value",1)

            }

        }

    </script>
</head>
<body>
<div class="navheader form-inline">
    <div class=" form-group">
        <label for="serach" style="padding:5px 10px 0px 20px;">查询</label>
        <input type="text" id="serach" class="bi-input-serach " placeholder="名称、代码、拼音查询"/>
        <button type="button" class="btn btn-success bi-btn-search" onclick="search()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>
</div>

<table id="gridtable" style="height:250px;">

</table>
<form id="yonghubianji" action="${ctx}/SysUserInfo/save" method="post">
    <input id="id" name="id" type="hidden" value="${user.id}"/>
    <input id="flag" name="flag" type="hidden" value="${user.id}"/>
    <input id="check" name="check" type="hidden" value="0"/>
    <div class="container from-content" style="padding: 15px 0px 20px;">
        <div class="div_border">
            <div class="div_h" style="padding: 10px 0px;">
                <label for="choose">人员选择&nbsp;&nbsp;</label>
                <input id="choose" name="choose" type="text" style="width:120px;" class="bi-width140 validate[required] form-control "
                       value="${name}" readonly="readonly"/>
            </div>

            <div class="div_h" style="padding: 10px 0px;margin-left: 9px">
                <label for="loginName">用户登录&nbsp;&nbsp;</label>
                <input type="text" placeholder=" " id="loginName" name="loginName" style="width:100px;"
                       class="bi-width140 validate[required] form-control" value="${user.loginName}"/>
                <b class="redColor">*</b>
            </div>

            <div class="div_h" style="padding: 10px 0px;">
                    <input id="on" type="checkbox" name="on" style="margin-left:5px;" value="${user.status}"   /><label for="on"> &nbsp;启用</label>
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
                <%--<input id="menuRole" type="checkbox" name="menuRole" style="margin-left:5px;"/><label for="menuRole"> &nbsp;导入导出权限</label>--%>
            <%--</div>--%>
            <div class="div_h" style="padding: 10px 0px;">
                <input id="report" type="checkbox" name="report" style="margin-left:5px;"/><label for="report"> &nbsp;上报权限</label>
            </div>
        </div>


        <button type="button" onclick="clearall()" class="btn btn-default bi-btn  bi-btn-width90"
                style="margin-left:118px;margin-right:160px;margin-top:15px;">取消
        </button>
        <button type="submit" class="btn btn-primary bi-btn bi-btn-width90" style="margin-top:15px;">保存</button>

    </div>
</form>

</body>
</html>