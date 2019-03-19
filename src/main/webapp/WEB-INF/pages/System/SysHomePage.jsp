<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/9/8
  Time: 15:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp"%>
    <title></title>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <script>

        $(function(){
            var height = findDimensions_height();
            $("#datagrid").height(height-50);
            $("#syjmwh").height(height-92);
//            lodMenu();
            $('#datagrid').datagrid(
                    {
                        url:'/HomePageInterface/getAllHomePageInterface?rdm=' + parseInt(Math.random()*100000),
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        autoRowHeight:false,
                        remoteSort:false,
                        columns: [
                            [
                                { field: 'id', title: 'ID', hidden: true },
                                { field: 'name', title: '名称', width: '150px', align: 'left', sortable:true,halign: 'center'},
                                { field: 'url', title: 'Url', width: '350px', align: 'left', sortable:true,halign: 'center'},
                                { field: 'operate', title: '操作', width: '40px', align: 'left', halign: 'center',
                                    formatter:function(value,row,index){
//                                        var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\' onclick="toUpdate(\'' + row.id + '\')"><span class=\'glyphicon  glyphicon glyphicon-pencil\'></span></button>';
                                        var str = '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="Del(\'' + row.id + '\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></button>';
                                        return str;
                                    }
                                }

                            ]
                        ],
                        onClickRow: function(index,row) {
                            var id = row.id;
                            $('#id').val(id);
                            LoadCurrent(id);
                        }
                    }).datagrid('clientPaging');
            formValiPost("save", "${ctx}/HomePageInterface/save", function (json) {
                if (json.success == false) {
                    $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                }
                else {
                    refresh();
                    layerSuccess("成功");
                }

            });
        });
        function loadMenu() {
            $('#datagrid').datagrid(
                    {
                        url:'/HomePageInterface/getAllHomePageInterface?rdm=' + parseInt(Math.random()*100000)
                    });
        }
        function LoadCurrent(id, data) {
            $.ajax({
                url: "/HomePageInterface/toUpdate?id=" + id,
                data: data,
                success: function (data) {
                    $('#name').val(data.name);
                    $('#url').val(data.url);
                    $('#type').val(data.type)
                }
            })
        }

        function refresh(){
            loadMenu();
            Clear();
        }

        function Del(id){
            // 阻止冒泡
            if ( event && event.stopPropagation ) {
                event.stopPropagation();
            } else{
                window.event.returnValue = false;
            }
            layerConfirm("是否确定删除?",function(){
                var url = '${ctx}/HomePageInterface/delete?id='+id;
                $.ajax({
                    type : 'post',
                    url : url,
                    dataType: "json",
                    success:function(data){
                        if(data.success == true){
                            refresh();
                        }else{
                            alert(data.msg);
                        }
                    }
                });
            });

        }

        function Clear() {
            $('#save').form('clear');
        }

        function search() {
            var condition = $('#serach').val();
            var url = '${ctx }/HomePageInterface/findByCondition?condition='+condition;
            $('#datagrid').datagrid({url:url});
        }

    </script>
</head>
<body>
<div class="navheader form-inline" style="padding:0 5px;height:40px;">
    <div class=" form-group">
        <label for="serach"style="padding:5px 10px 0px 20px;">查询</label>
        <input type="text" id="serach" class="form-control"placeholder="名称" />
        <button type="button" class="btn btn-success bi-btn-search" onclick="search()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>
    <div class="btn-group-right">
        <div class="btn-group "  role="group">
            <button type="button" class="btn btn-default bi-btn-width90" onclick="Clear()">新增</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="refresh()">刷新</button>
        </div>
    </div>
</div>

<div style="margin:0 5px; overflow: hidden;">
    <!--左边表格-->
    <div style="width:60%;float:left;display:inline-block;overflow: auto;">
        <table id="datagrid"class="datagrid"></table>

    </div>
    <!--右边表格 -->
    <div style="width:40%;float:right;display:inline-block;; padding:20px 20px 20px 60px;border:1px solid #ddd;border-left:none; " id="syjmwh">
        <h4 style="display:block;padding:10px 25px; position:relative;">
            <span style="    display: inline-block;float:left;margin-right:8px;height: 18px;width: 8px;background: #0066cc;"></span>
            首页界面维护
        </h4>

        <div style="padding:20px;margin-left:20px;margin-top: 80px;">
            <form id="save" action="${ctx}/HomePageInterface/save" method="post">
                <input type="hidden" name="id" id="id">

                <div class="div_border">
                    <div class="div_h">
                        <label for="name">名称&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                        <input type="text" class="bi-width140 form-control validate[required]" id="name" name="name">
                        <b class="redColor">*</b>
                    </div>
                </div>

                <div class="div_border">
                    <div class="div_h ">
                        <label for="url" style="line-height:30px;vertical-align: middle;margin-top:15px;float:left;">界面url&nbsp;&nbsp;</label>
                        <textarea id="url" class="bi-width357  form-control validate[required]" type="text"
                                  placeholder=" " name="url" style="width:230px;height:60px;"></textarea>
                        <b class="redColor">*</b>
                    </div>

                </div>


                <button type="button" class="btn btn-default  bi-btn bi-btn-width90"
                        style="margin-left:40px;margin-right:115px;" name="closed" onclick="Clear()">取消
                </button>
                <button type="submit" class="btn btn-primary bi-btn bi-btn-width90">保存</button>

            </form>
        </div>
    </div>
</div>
</body>
</html>