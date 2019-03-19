<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/8/2
  Time: 14:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp"%>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>元数据列表</title>

    <link href="${ctx }/static/js/plugins/codemirror-5.14.2/lib/codemirror.css" rel="stylesheet"/>
    <link href="${ctx }/static/js/plugins/codemirror-5.14.2/theme/eclipse.css" rel="stylesheet" type="text/css"/>
    <script src="${ctx }/static/js/plugins/codemirror-5.14.2/lib/codemirror.js" type="text/javascript"></script>
    <script src="${ctx }/static/js/plugins/codemirror-5.14.2/mode/javascript/javascript.js"
            type="text/javascript"></script>
    <script src="${ctx }/static/js/plugins/codemirror-5.14.2/mode/sql/sql.js" type="text/javascript"></script>


    <script>
        var tableId = null;
        var CodeSQL = null;
        $(function(){
            var height = findDimensions_height();
            $("#l_datagrid").height(height-55);
//            loadList();
            $('#l_datagrid').datagrid(
                    {

                        url:'${ctx }/table/list?rdm='+ parseInt(Math.random()*100000),
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        autoRowHeight:false,
                        remoteSort:false,
                        columns: [
                            [
                                { field: 'id', title: '数据库表ID', width: '200px', align: 'left', sortable:true, halign: 'center'},
                                { field: 'name', title: '数据库表名', width: '100px', align: 'left', sortable:true,halign: 'center'},
                                { field: 'zhName', title: '中文表名', width: '100px', align: 'left',sortable:true, halign: 'center'},
                                { field:'bz',title:'备注',width: '100px', align: 'left', halign: 'center'},

                                { field: 'operate', title: '操作', width: '80px', align: 'left', halign: 'center',
                                    formatter:function(value,row,index){
                                        var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\' onclick="toUpdateTab(\'' + row.id + '\')"><span class=\'glyphicon  glyphicon glyphicon-pencil\'></span></button>';
                                        str+= '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="toDelTab(\'' + row.id + '\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></button>';
                                        return str;
                                    }
                                }

                            ]
                        ],

                        onClickRow: function(index,row) {
                            tableId = row.id;
                            //var url = '${ctx }/tabstruc/list?tableid='+row.id;
                            loadTabStruc();
                            showTableSql();
                        }

                    }).datagrid('clientPaging');
            $("#r_datagrid").height(height-55);
            //var url = "${ctx }/tabstruc/list?tableid=" + tableId;

            var sqlTextarea = document.getElementById('txtsql');
            CodeSQL = CodeMirror.fromTextArea(sqlTextarea, {
                mode: "text/x-mssql",
                lineNumbers: true
            });
            CodeSQL.setSize('auto', '102px');
            CodeSQL.setOption("theme", "eclipse");

            $('#r_datagrid').datagrid(
                    {
                        url:'',
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        autoRowHeight:false,
                        remoteSort:false,
                        columns: [
                            [
                                { field: 'id',title:'ID',hidden:true },
                                { field: 'xh', title: '序号', width: '40px' ,align: 'left',sortable:true, halign: 'center' },
                                { field: 'name', title: '字段名', width: '100px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'zhName', title: '中文名', width: '100px', align: 'left',sortable:true, halign: 'center' },
                                { field: 'type', title: '类型', width:'70px', align: 'center',sortable:true, halign: 'center' },
                                { field: 'colLength', title: '长度', width:'50px', align: 'right',sortable:true, halign: 'center' },
                                { field: 'isKey', title: '关键字', width:'40px', align: 'center', halign: 'center',
                                    formatter:function (value, row, index) {
                                        switch (value) {
                                            case true:
                                                return "√";
                                        }
                                    }
                                },
                                { field: 'bz', title: '备注', width:'120px', align: 'left', halign: 'center' },
                                { field: 'operate', title: '操作', width: '75px', align: 'left', halign: 'center',
                                    formatter:function(value,row,index){
                                        var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\' onclick="toUpdateTabStruc(\'' + row.id + '\')"><span class=\'glyphicon  glyphicon glyphicon-pencil\'></span></button>';
                                        str+= '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="toDelTabStruc(\'' + row.id + '\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></button>';
                                        return str;
                                    }
                                }
                            ]
                        ]
                    });
//            loadTabStruc();
        });

        function loadList() {
            $('#l_datagrid').datagrid(
                    {

                        url:'${ctx }/table/list?rdm='+ parseInt(Math.random()*100000)
                    });
        }

        function loadTabStruc() {
            $('#r_datagrid').datagrid(
                    {
                        url:'${ctx }/tabstruc/list?tableid='+tableId + "&rdm="+ parseInt(Math.random()*100000)
                    });
        }


        function openwinN(){
            layeropen(600,350,"新增名称","${ctx }/table/toadd");
        }
        function openwinY(){
            if (tableId != null) {
                layeropen(600,400,"新增元数据","${ctx }/tabstruc/toedit?tableid=" + tableId);
            }else{
                layerInfo("请选择表数据！");
                return;
            }
        }
        function openwinM(){
            if (tableId != null) {
                layeropen(600,300,"模板文件","${ctx }/table/toSaveFile?id=" + tableId);
            }
        }
        function refresh(){
            $('#r_datagrid').datagrid('loadData', { total: 0, rows: [] });
//            $('#l_datagrid').datagrid('reload');
            loadList();
        }

        function toUpdateTab(id) {
            // 阻止冒泡
            if ( event && event.stopPropagation ) {
                event.stopPropagation();
            } else{
                window.event.returnValue = false;
            }
            layeropen(600,350,"修改名称","${ctx }/table/toedit?id=" + id);
        }

        function toDelTab(id){
            // 阻止冒泡
            if ( event && event.stopPropagation ) {
                event.stopPropagation();
            } else{
                window.event.returnValue = false;
            }
            layerConfirm("是否确定删除?",function(){
                var url = '${ctx}/table/delete?id=' + id;
                $.ajax({
                    type: 'post',
                    url: url,
                    dataType: "json",
                    success: function (data) {
                        if (data.success == true) {
                            $('#l_datagrid').datagrid('reload');
                        } else {
                            alert(data.msg);
                        }
                    }
                });
            } );
        }

        function toUpdateTabStruc(id){
            var url = '${ctx}/tabstruc/toedit?tableid='+ tableId +'&id='+id;
            layeropen(600,400,"修改元数据",url);
        }

        function toDelTabStruc(id){
            layerConfirm("是否确定删除?",function(){
                var url = '${ctx}/tabstruc/delete?id=' + id;
                $.ajax({
                    type: 'post',
                    url: url,
                    dataType: "json",
                    success: function (data) {
                        if (data.success == true) {
                            $('#r_datagrid').datagrid('reload');
                        } else {
                            alert(data.msg);
                        }
                    }
                });
            } );

        }

        function search() {
            var condition = $('#serach').val();
            var url = '${ctx }/table/findByCondition?condition='+encodeURI(condition)+ "&rdm="+ parseInt(Math.random()*100000);
            $('#l_datagrid').datagrid({url:url});
        }

        function create(){
            layerConfirm("如果增加了元数据，只能手动修改，或是把数据库表删除后再来创建!",
            function(){
                //如果easyUI 设置可以选择多行，可以支持批量生成表
                var selections = $('#l_datagrid').datagrid('getSelections');
                var ids='';
                for(var i=0;i<selections.length;i++){
                    var id = selections[i].id;
                    ids=ids+id+"/";
                }
                $("#tableIds").val(ids);

                $.ajax({
                    type:'post',
                    url:$('#createfrom').attr('action'),
                    data:$('#createfrom').serialize(),
                    dataType: 'json',
                    success: function(data) {
                        if (data.success == true) {
                            layerSuccess("表创建完成！");
                        }else {
                            layerError("创建失败，表已存在！")
                        }
                    }
                });
            });
        }

        function saveTableSql() {

            var sql = CodeSQL.getValue().replace(/[\r\n]/g,"");
            var id = tableId;
            $.ajax({
                type: 'POST',
                url: '${ctx}/table/saveTableSql',
                data: {"tdId": id, "tableSql": sql},
                dataType: 'json',
                success: function (data) {

                    if (data.success == false) {
                        return false;
                    }
                    else {
                        layerSuccess("保存维代码SQL脚本成功！");
                    }
                    return false;
                }
            });

        }

        function showTableSql(){

            var id = tableId;
            $.ajax({
                type: 'POST',
                url: '${ctx}/table/showTableSql',
                data: {"tdId": id},
                dataType: 'json',
                success: function (data) {
                    debugger;
                    if (data.success == false) {
                        return false;
                    }
                    else {
                        CodeSQL.setValue(data.tableSql);
                        //layerSuccess("表创建完成！");
                    }
                    return false;
                }
            });

        }


    </script>
    <style>
        .defined>.panel{
            height:100%;
        }

        #txtsql + .CodeMirror {
            border: 1px solid darkblue;
        }


    </style>
</head>
<body>
<div class="navheader form-inline" style="padding:0 5px;height:40px;">
    <div class=" form-group">
        <label for="serach"style="padding:5px 10px 0px 20px;">查询</label>
        <input type="text" id="serach" class="form-control"placeholder="名称、拼音码" />
        <button type="button" class="btn btn-success bi-btn-search" onclick="search()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>
    <div class="btn-group-right">
        <div class="btn-group "  role="group">
            <button type="button" class="btn btn-default bi-btn-width90" onclick="refresh()">刷新</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="openwinN()">新增名称</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="openwinY()">新增元数据</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="create()">创建数据表</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="openwinM()">模板文件</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="saveTableSql()">保存代码</button>
        </div>
    </div>
</div>

<div style="margin:0 5px;" >
    <!--左边表格-->
    <div style="width:50%;float:left;display:inline-block;padding-right:5px;border-right:1px dotted #ccc;" >
            <div style="height:80%;" class="defined">
                <table id="l_datagrid"class="datagrid" ></table>
            </div>
            <div  style="height:20%;padding-top:5px">
            <p>sql脚本</p>
                <textarea id="txtsql" name="txtsql"  rows="3" cols="20"  style="width:100%;padding-top:5px;border:1px solid #ddd;"></textarea>
            </div>

    </div>

    <!--右边表格 -->
    <div style="width:50%;float:right;display:inline-block;padding-left:5px;">
        <table id="r_datagrid" class="datagrid"></table>
    </div>

</div>
<form action="${ctx }/table/create" id="createfrom" method="post">

    <input type="hidden" id="tableIds" name="tableIds" value="">
</form>
</body>
</html>
