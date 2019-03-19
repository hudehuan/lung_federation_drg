<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/8/12
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link href="${ctx }/static/js/plugins/codemirror-5.14.2/lib/codemirror.css" rel="stylesheet"/>
    <link href="${ctx }/static/js/plugins/codemirror-5.14.2/theme/eclipse.css" rel="stylesheet" type="text/css"/>
    <script src="${ctx }/static/js/plugins/codemirror-5.14.2/lib/codemirror.js" type="text/javascript"></script>
    <script src="${ctx }/static/js/plugins/codemirror-5.14.2/mode/javascript/javascript.js"
            type="text/javascript"></script>
    <script src="${ctx }/static/js/plugins/codemirror-5.14.2/mode/sql/sql.js" type="text/javascript"></script>
    <script>
        var selectid = null;//选中的参数id
        var selectindex = 0;
        var CodeMirrorEditor = null;
        var CodeSQL = null;
        var tdID = "";

        $(function () {
            var height = findDimensions_height();
            $("#datagrid").height(height - 50);
            $("#x_datagrid").height(height - 150);
            $("#text").height(height - 150);
            $("#slider").height(height - 100);

//    	表单验证框代码
            var myTextarea = document.getElementById('txtjs');
            CodeMirrorEditor = CodeMirror.fromTextArea(myTextarea, {
                mode: "text/javascript",
                lineNumbers: true
            });
            var sqlTextarea = document.getElementById('txtsql');
            CodeSQL = CodeMirror.fromTextArea(sqlTextarea, {
                mode: "text/x-mssql",
                lineNumbers: true
            });
            CodeMirrorEditor.setSize('auto', '301px');
//            CodeMirrorEditor
            CodeMirrorEditor.setOption("theme", "eclipse");
            CodeSQL.setSize('auto', '102px');
            CodeSQL.setOption("theme", "eclipse");

//            loadFormDefine();
            $('#datagrid').datagrid(
                    {
                        url: '/formDefine/getAllFormDefine?rdm='+ parseInt(Math.random()*100000),
                        method: 'get',
                        rownumbers: true,
                        singleSelect: true,
                        autoRowHeight: false,
                        pagination: true,
                        remoteSort: false,
                        pageSize: 15,
                        pageList: [15, 20, 25, 30, 40, 50],
                        clientPaging: true,
                        columns: [
                            [
                                {field: 'tdId', title: 'GUID', width: '280px', align: 'left', halign: 'center'},
                                {field: 'name', title: '表单名称', width: '180px', align: 'left', halign: 'center'},
                                {field: 'datetype', title: '日期', width: '40px', align: 'left', halign: 'center'},
                                {
                                    field: 'isNew', title: '新增', width: '40px', align: 'left', halign: 'center',
                                    formatter: function (value, row, index) {
                                        switch (value) {
                                            case true:
                                                return "√";
                                        }
                                    }
                                },
                                {
                                    field: 'isEdit', title: '修改', width: '40px', align: 'left', halign: 'center',
                                    formatter: function (value, row, index) {
                                        switch (value) {
                                            case true:
                                                return "√";
                                        }
                                    }
                                },
                                {
                                    field: 'isDel', title: '删除', width: '40px', align: 'left', halign: 'center',
                                    formatter: function (value, row, index) {
                                        switch (value) {
                                            case true:
                                                return "√";
                                        }
                                    }
                                },
                                {
                                    field: 'isSh', title: '审核', width: '40px', align: 'left', halign: 'center',
                                    formatter: function (value, row, index) {
                                        switch (value) {
                                            case true:
                                                return "√";
                                        }
                                    }
                                },
                                {field: 'bz', title: '说明', width: '220px', align: 'left', halign: 'center'},
                                {
                                    field: 'fg', title: '表单风格', width: '120px', align: 'left', halign: 'center',
                                    formatter: function (value, row, index) {
                                        switch (value) {
                                            case 1:
                                                return "风格1";
                                            case 2:
                                                return "风格2";
                                            case 3:
                                                return "风格3";
                                        }
                                    }
                                },
                                {
                                    field: 'operate', title: '操作', width: '80px', align: 'left', halign: 'center',
                                    formatter: function (value, row, index) {
                                        var str = '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\' onclick="toUpdate(\'' + row.tdId + '\')"><span class=\'glyphicon  glyphicon glyphicon-pencil\'></span></button>';
                                        str += '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="toDel(\'' + row.tdId + '\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></button>';
                                        return str;
                                    }
                                }

                            ]
                        ],
                        onClickRow: function (index, row) {
                            tdID = row.tdId;
//                            loadField();

                        },
                        onSelect: function (index, row) {
                            selectindex = index;
                        }
                    }).datagrid('clientPaging');
            $('#x_datagrid').datagrid(
                    {
                        url: '',
                        method: 'get',
                        rownumbers: true,
                        singleSelect: true,
                        autoRowHeight: false,
                        columns: [
                            [
                                {field: 'fdId', title: 'ID', hidden: true},
                                {field: 'tdId', title: '表单ID', hidden: true},
                                {field: 'xh', title: '序号', width: '40px', align: 'left', halign: 'center'},
                                {field: 'level', title: '层次码', width: '100px', align: 'left', halign: 'center'},
                                {field: 'fdName', title: '显示名称', width: '150px'},
//                                {
//                                    field: 'isEdit', title: '修改', width: '40px',
//                                    formatter: function (value, row, index) {
//                                        switch (value) {
//                                            case true:
//                                                return "√";
//                                        }
//                                    }
//                                },
                                {field: 'itemId', title: '元素ID', hidden: true},
                                {field: 'name', title: '对应元素', width: '150px', align: 'left', halign: 'center'},
//                                {field: 'defaultValue', title: '默认值', width: '100px', align: 'left', halign: 'center'},
                                {field: 'unit', title: '单位', width: '60px', align: 'left', halign: 'center'},
                                {
                                    field: 'operate', title: '操作', width: '75px', align: 'left', halign: 'center',
                                    formatter: function (value, row, index) {
                                        var str = '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\' onclick="toEditDefineField(\'' + row.fdId + '\')"><span class=\'glyphicon  glyphicon glyphicon-pencil\'></span></button>';
                                        str += '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="DelValue(\'' + row.fdId + '\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></button>';
                                        return str;
                                    }
                                }

                            ]
                        ],
                        onSelect: function (index, row) {
                            selectid = row.nid;
                            selectindex = index;
                        }
                    });
        });
        function openwinB() {
            if(!${roleMenu.isAdd}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }
            layeropen(600, 400, "新增表单", "${ctx}/formDefine/toEdit");
        }
        function openwinY() {
            if(!${roleMenu.isAdd}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }
            layeropen(800, 500, "新增元素", "${ctx}/formDefineField/toSave?tdId=" + tdID);
        }
        function toEditDefineField(id) {
            if(!${roleMenu.isEdit}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }
            layeropen(600, 350, "操作元素", "${ctx}/formDefineField/toUpdate?id=" + id);
        }
        function toUpdate(id) {
            // 阻止冒泡
            if ( event && event.stopPropagation ) {
                event.stopPropagation();
            } else{
                window.event.returnValue = false;
            }
            if(!${roleMenu.isEdit}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }
            layeropen(600, 400, "修改表单", "${ctx}/formDefine/toEdit?id=" + id);
        }

        function refresh() {
//            $('#datagrid').datagrid('reload');
            loadFormDefine();
        }

        function toDel(id) {
            // 阻止冒泡
            if ( event && event.stopPropagation ) {
                event.stopPropagation();
            } else{
                window.event.returnValue = false;
            }
            if(!${roleMenu.isDel}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }
            layerConfirm("是否确定删除?", function () {
                var url = '${ctx}/formDefine/delete?id=' + id;
                $.ajax({
                    type: 'post',
                    url: url,
                    dataType: "json",
                    success: function (data) {
                        if (data.success == true) {
                            loadFormDefine();
                        } else {
                            alert(data.msg);
                        }
                    }
                });
            });

        }
        function loadFormDefine() {
            $('#datagrid').datagrid(
                    {
                        url: '/formDefine/getAllFormDefine?rdm='+ parseInt(Math.random()*100000)
                    });
        }
        function DelValue(id) {
            if(!${roleMenu.isDel}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }
            layerConfirm("是否确定删除?", function () {
                var url = '${ctx}/formDefineField/delete?id=' + id;
                $.ajax({
                    type: 'post',
                    url: url,
                    dataType: "json",
                    success: function (data) {
                        if (data.success == true) {
                            doSearch();
                        } else {
                            alert(data.msg);
                        }
                    }
                });
            });
        }
        function doSearch() {
//            $('#x_datagrid').datagrid('reload'); // 重新载入当前页面数据
            loadField();
        }
        function deploy() {

            if(!${roleMenu.isEdit}){
                layerInfo("没有权限!请找系统管理员申请权限!");
                return;
            }

            if (tdID == "") {
                layerInfo("请选择要配置的数据！");
                return;
            }
            showDiv();
        }
        function showDiv() {
            $("#slider").animate({right: "0px"});
            var angelright = $("#content").width();
            loadField();
        }

        function hideDiv() {
            var width = $("#slider").width();
            $("#slider").animate({right: (-width) + "px"});
        }
        function loadField() {
            $.ajax({
                type: 'post',
                url: '${ctx}/formDefineField/showTextarea?tdId=' + tdID+ "&rdm="+ parseInt(Math.random()*100000),
                dataType: "json",
                success: function (data) {
//                                    alert("test");
                    if (data.success == true) {
                        if (data.sql != "null") {
                            CodeSQL.setValue(data.sql);
                        } else {
                            CodeSQL.setValue("");
                        }
                        if (data.js != "null") {
                            CodeMirrorEditor.setValue(data.js);
                        } else {
                            CodeMirrorEditor.setValue("");
                        }
                    } else {
                        alert(data.msg);
                    }
                }
            })
            $('#x_datagrid').datagrid(
                    {
                        url: '/formDefineField/getAllFormDefineField?tdId=' + tdID+ "&rdm="+ parseInt(Math.random()*100000)
                    });
        }
        function getjsValue() {
            var js = CodeMirrorEditor.getValue();
            var sql = CodeSQL.getValue();
            var id = tdID;
            $.ajax({
                type: 'POST',
                url: '${ctx}/formDefine/saveTextarea',
                data: {"tableJs": js, "tdId": id, "tableSql": sql},
                dataType: 'json',
                success: function (data) {
//                    alert('test');
                    if (data.success == false) {
                        return false;
                    }
                    else {
                        layerSuccess("成功", function () {
                            //关闭窗体
                            //closeIndexWindwos();
                            hideDiv();
                        });
                    }
                    return false;
                }
            });

        }

    </script>
    <style>
        #slider {
            position: absolute;
            width: 80%;
            background-color: #fff;
            -moz-box-shadow: 1px 1px 9px #888888;
            box-shadow: 1px 1px 9px #888888;
            border: 1px solid #ccc;
            right: -80%;
            top: 50px;
            z-index: 47;
        }

        #txtjs + .CodeMirror {
            border: 1px solid #006400;
        }

        #txtsql + .CodeMirror {
            border: 1px solid darkblue;
        }

        html, body {
            overflow: hidden;
        }
    </style>
</head>
<body>
<div class="navheader form-inline" style="padding:0 5px;">
    <div class="btn-group-right">
        <div class="btn-group " role="group">
            <button type="button" class="btn btn-default bi-btn-width90" onclick="openwinB()">新增表单</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="deploy()">配置</button>
        </div>
    </div>
</div>
<div style="padding:0 5px;">
    <table id="datagrid" class="datagrid'" style="width:100%;">
    </table>
</div>

<!--从右边滑出来的div-->
<div id="slider">
    <div class="navheader form-inline"
         style="height:40px; text-indent: 5px; line-height: 36px; vertical-align: middle;">
        <div style="float: left;width: 50%">
            <span>
        <button class="btn btn-danger" onclick="hideDiv()">关闭</button>
      </span>
            <span style="color: #ff0000;font-size: 11px;">
          &nbsp; *绿色框填入表单JS，蓝色框填入维sql
           </span>
        </div>
        <div class="btn-group-right">
            <div class="btn-group " role="group">
                <button type="button" class="btn btn-default bi-btn-width90" onclick="getjsValue()">保存代码</button>
                <button type="button" class="btn btn-default bi-btn-width90" onclick="openwinY()">新增元素</button>
            </div>
        </div>
    </div>
    <div style="margin:0 5px; overflow: hidden;">
        <!--左边表格-->
        <div style="width:65%;float:left;display:inline-block;padding-right:5px;">
            <table id="x_datagrid" class="datagrid"></table>
        </div>
        <!--文本框 -->
        <div style="width:35%;float:right;display:inline-block;padding-left:5px;border-left:1px dotted #ddd;overflow-y: scroll;" id="text">
            <div style=" margin-bottom:10px;">
                <textarea name="txtjs" rows="2" cols="20" id="txtjs"
                          style="overflow: auto; "></textarea>
            </div>
            <div>
                <textarea name="txtsql" rows="2" cols="20" id="txtsql"
                          style="overflow: auto;"></textarea>
            </div>
            <div style="color:red;padding:5px 3px;">
                <ul>注意：
                    <li>1.只有风格3的表单才需要写SQL,如：'select code as dm,name as name from sys_ks'。</li>
                    <li>2.SQL语句必须要有 dm 和 mc 两字段。</li>
                    <li>3.js代码可以注入到页面上，在保存时触发。</li>
                </ul>
            </div>
        </div>
    </div>
</div>

</body>
</html>
