<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/07/31
  Time: 16:26
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title></title>
    <script type="text/javascript" src="${ctx }/static/js/FormValidation.js"></script>

    <script>

        $(function () {
            var height = findDimensions_height();
            $("#gridtable").height(height-50);
            loadList();

            formValiPost2("formid", "${ctx}/DicCm3Define/save",validateForm, function (json) {
                parent.reLoadList();
                if (json.success == false) {
                    if(json.id){
                        $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                    }
                }
                else {
                    layerSuccess("成功", function () {
                        //关闭窗体
                        closeIndexWindwos();
                    });
                }
            });
        })

        var empty="";//看是否为空
        function validateForm(){
            if(!$("#cm3dm").val()||!$("#cm3mc").val()){
                layerInfo("请选择手术编码！");
                return false;
            }
            empty="";//看是否为空
            required("type");   //类型
            required("code");   //名称
            if(empty.indexOf("0,")>=0){
                return false;
            }
            return true;

        }

        function loadList() {
            $('#cm3').combogrid({
                panelHeigh: 400,
                panelWidth: 300,
                idField: 'dm',        //ID字段
                textField: 'mc',    //显示的字段
                url:  "${ctx}/DicCm3/getList",
                fitColumns: true,
                striped: true,
                rownumbers: true,           //序号
                collapsible: false,         //是否可折叠的
                mode:"remote",
                method: 'get',
                columns: [[
                    {field: 'dm', title: '代码', width: 20},
                    {field: 'mc', title: '名称', width: 50}
                ]],
                onSelect: function (index,row) {
                    $("#cm3dm").val(row.dm);
                    $("#cm3mc").val(row.mc);
                }
            });

//            $('#gridtable').datagrid(
//                {
//                    url:'/DicCm3/getList?search=&rdm='+ parseInt(Math.random()*100000),
//                    method:'get',
//                    singleSelect:true,
//                    autoRowHeight:false,
//                    pagination:true,
//                    clientPaging:true,
//                    remoteSort:false,
//                    pageSize:15,
//                    pageList:[10,15,20,25,30,40,50],
//                    columns: [
//                        [
//                            { field:'id',title:'ID',width:'100px',hidden:true},
//                            { field: 'dm', title: 'cm3编码', width: '80px', align: 'left',sortable:true,  halign: 'center'},
//                            { field: 'mc', title: 'cm3名称', width: '200px', align: 'left',sortable:true, halign: 'center'},
//                            { field: 'lx', title: 'cm3类型', width: '100px', align: 'left',sortable:true, halign: 'center'},
//                        ]
//                    ],
//                    onSelect :function(value,row,index){
//                        $("#cm3dm").val(row.dm);
//                        $("#cm3mc").val(row.mc);
//                    }
//                }).datagrid('clientPaging');
        }
        function search() {
            var search = $("#search").val();
            $('#gridtable').datagrid(
                {
                    url: '/DicCm3/getList?search='+encodeURI(search)+'&rdm=' + parseInt(Math.random() * 100000)
                })
        }

        function clearall() {
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
            parent.layer.close(index); //执行关闭
        }
    </script>
    <style>
        /*去掉滚动条*/
        body{overflow-y:auto;}
    </style>
</head>
<body>

<div style="margin:0 5px; overflow: hidden; border:1px solid #ddd;" id="menu1_warp">

    <%--<div style="width:50%;float:left;display:inline-block;  overflow:auto; ">--%>
    <%--<label for="search">cm3：</label>--%>
    <%--<!--此处添加弹出框-->--%>
    <%--<input type="text" class="form-control bi-width140" id="search" name="search" value="" placeholder=""/>--%>
    <%--<button type="button" class="btn btn-success " onclick="search()">--%>
    <%--<span class="glyphicon glyphicon glyphicon-search"></span>--%>
    <%--</button>--%>
    <%--<table id="gridtable" class="gridtable" >--%>

    <%--</table>--%>

    <%--</div>--%>
    <!--表单 -->
    <div style="width:100%;float:right;display:inline-block; padding:10px 20px 10px 60px;border-left:1px solid #ddd;">

        <div style="padding:0 10px 0px 0px;margin-left:0px;">
            <form id="formid"  method="post">
                <input type="hidden" name="cm3Dm" id="cm3dm" value="${entity.cm3Dm}"/>
                <input type="hidden" name="id" id="id" value="${entity.id}"/>
                <input type="hidden" name="cm3Mc" id="cm3mc" value="${entity.cm3Mc}"/>

                <div class="div_border"  style="padding:10px 20px">
                    <div class="div_h">
                        <label for="cm3" style="margin-right:10px;">cm3名称</label>
                        <input type="text"   name="cm3" id="cm3" class="form-control " style="width:140px;height: 20px;"/>
                        <b class="redColor">*</b>
                    </div>
                </div>

                <div class="div_border"  style="padding:10px 20px">
                    <div class="div_h">
                        <label for="code" style="margin-right:10px;">对照编码</label>
                        <input id="code" class=" bi-width140  form-control" value="${entity.code}"
                               type="text"  placeholder=" " name="code">
                        <b class="redColor">*</b>
                    </div>
                </div>

                <div class="div_border"  style="padding:10px 20px">
                    <div class="div_h">
                        <label for="type" style="margin-right:10px;">编码类型</label>
                        <input id="type" class="bi-width140  form-control" value="${entity.type}" type="text"
                               placeholder=" " name="type" />
                        <b class="redColor">*</b>
                    </div>
                </div>



                <div class="div_border"  style="padding:10px 20px">
                    <div class="div_h">
                        <label for="sm" style="margin-right:10px;">说&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;明</label>
                        <%--<input id="bz" class="bi-width140  form-control" value="${entity.bz}"  type="text"--%>
                        <%--placeholder=" " name="bz" />--%>
                        <textarea id="sm"  name="sm" rows="5" style="width:100%">${entity.sm}</textarea>
                    </div>
                </div>

                <button type="button" class="btn btn-default bi-btn-default bi-btn bi-btn-width90"
                        style="marrgin-top:25px; margin-left :60px;" name="closed" onclick="clearall()">取消
                </button>
                <button type="submit" class="btn btn-primary bi-btn bi-btn-width90"
                        style="margin-top:25px;">保存</button>

            </form>

        </div>
    </div>
</div>
</body>
</html>
