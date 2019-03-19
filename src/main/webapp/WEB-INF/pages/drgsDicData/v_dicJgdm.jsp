<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/08/07
  Time: 10:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="${ctx }/static/portalres/jsfolder/htmlxjs/skins/dhtmlxgrid.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx }/static/portalres/jsfolder/htmlxjs/skins/dhtmlxgrid_pgn_bricks.css"/>
    <%@ include file="/common/meta.jsp" %>
    <script type="text/javascript" src="${ctx }/static/portalres/jsfolder/htmlxjs/dhtmlxcommon.js"></script>
    <script type="text/javascript" src="${ctx }/static/portalres/jsfolder/htmlxjs/dhtmlxcontainer.js"></script>
    <script type="text/javascript" src="${ctx }/static/portalres/jsfolder/htmlxjs/dhtmlxgrid.js"></script>
    <script type="text/javascript" src="${ctx }/static/portalres/jsfolder/htmlxjs/dhtmlxgridcell.js"></script>
    <script type="text/javascript" src="${ctx }/static/portalres/jsfolder/htmlxjs/dhtmlxgrid_filter.js"></script>
    <script type="text/javascript" src="${ctx }/static/portalres/jsfolder/htmlxjs/dhtmlxgrid_pgn.js"></script>
    <script type="text/javascript"  src='${ctx }/static/portalres/jsfolder/htmlxjs/dhtmlxgrid_export.js'></script>
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <script>

        var selectId =null;
        var treeUrl = null;
        $(function () {
            var height = findDimensions_height();
            $("#gridbox").height(height - 100);

            loadJgdm();
        })
        function getMenuTreeData(url) {
            $.ajaxSettings.async = false;
            $.getJSON(url, function (data) {
                MenuTreeData = data;
            });
            $.ajaxSettings.async = true;
        }
        function loadTree() {
            var url = '/DicJgdm/getTree?='+ parseInt(Math.random()*100000);
            getMenuTreeData(url);
            var height = findDimensions_height();
            $("#tree").height(height *0.91- 35);
            $("#div_tree").height(height *0.91);
            $('#tree').tree({
                method: "get",
                animate: true,
                url:url,
                data: MenuTreeData,

                onClick: function (node) {
                    treeUrl = '/DicJgdm/getAllJjdm?rdm=' + parseInt(Math.random() * 100000) +node.attributes.url;
                    reLoadGrid(treeUrl);
                },
                onDblClick: function(node) {
                    $(this).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
                    node.state = node.state === 'closed' ? 'open' : 'closed';
                }
            });
        }


        function loadJgdm() {
            selectId = null;
            mygrid = new dhtmlXGridObject('gridbox');
            mygrid.setImagePath("/static/portalres/jsfolder/htmlxjs/imgs/");
            mygrid.setHeader('序号,导入导出权限,导入导出码,代码Gid,名称,行政区划代码,行政区划名称,省,市,县,机构代码,医院法人（负责人）,信息上报负责人,联系电话,医院级别,医院等别,医院类别,委直,疾病版本,财务数据,简称,住院数据,编制床位数,实际开放床位数,在编执业医师数,在编执业护士数,合同医师数（人）,合同护士数（人）,住院面积(净)（㎡）,门诊面积(净)（㎡）,代码,卫生机构类别代码');
            mygrid.attachHeader('#rspan,#rspan,#rspan,#text_filter,#text_filter,#text_filter,#text_filter,#text_filter,#text_filter,#text_filter,#text_filter,#text_filter,#text_filter,#text_filter,#text_filter,#text_filter,#text_filter,#text_filter,#rspan,#rspan,#text_filter,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#text_filter,#text_filter');
            mygrid.setInitWidths('40,40,80,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120');
            mygrid.setColAlign('left,left,left,left,left,left,left,left,left,left,left,left,left,left,left,left,left,left,left,left,left,left,left,left,left,left,left,left,left,left,left,left');
            mygrid.setColTypes('ro,ro,ed,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro');
            mygrid.setColSorting('int,str,str,str,str,str,str,str,str,str,str,str,str,str,str,str,str,str,int,int,str,int,int,int,int,int,int,int,int,int,str,str');
            mygrid.enablePaging(true, 80, 10, 'pagingArea', true, 'recinfoArea');
            mygrid.setPagingSkin('bricks');
            mygrid.setSkin('dhx_terrace');
//            mygrid.setColumnHidden(0, true);
            mygrid.init();
            grid_Load();

            mygrid.attachEvent("onRowSelect", function (id, ind) {
                selectId = id;
            })
        }
        function reLoadGrid() {
            if(treeUrl){
                mygrid.clearAndLoad(treeUrl, "json");
            }else {
                grid_Load();
            }

        }
        
        function grid_Load() {
            mygrid.clearAndLoad('/DicJgdm/getAllJjdm?xzqh=&jglb=&rdm=' + parseInt(Math.random() * 100000), loadTree(), "json");
        }
        function eXcell_edit(cell) {
            if (cell) {                                                     //default pattern, just copy it
                this.cell = cell;
                this.grid = this.cell.parentNode.grid;
            }
            this.setValue = function (val) {
                var row_id = this.cell.parentNode.idd;
//                this.setCValue('<button type=\'button\' class=\'btn btn-primary bi-glyphicon\'onclick="doUpdate(\'' + row_id + '\')" ><span class=\'glyphicon  glyphicon glyphicon-pencil\'></span></span></button>');

            }
        }
        eXcell_edit.prototype = new eXcell;
        
        function dele(){
            if(selectId){
                layerConfirm("是否确定删除?", function () {
                    var url = '${ctx}/DicJgdm/del?id=' + selectId;
                    $.ajax({
                        type: 'post',
                        url: url,
                        dataType: "json",
                        success: function (data) {
                            if (data.success == true) {
                                reLoadGrid(treeUrl);
                            } else {
                                alert(data.msg);
                            }
                        }
                    });
                });
            }else {
                alert("请选择一个要删除的数据!");
            }
        }
        
        function update() {
            if(selectId){
                var height = findDimensions_height();
                var width = findDimensions_width();
                layeropen(0.45*width,height-100, "数据编辑", "/V_DicJgdm/toEdit?dm="+selectId);
            }else {
                alert("请选择一个要修改的数据!");
            }
        }
        
        function add() {
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(0.45*width,height-100, "数据编辑", "/V_DicJgdm/toEdit");
        }

        function menoRole(){
            if (selectId != null) {
                var confirm = "确定为机构添加导入导出数据权限？";
                if(mygrid.cells(selectId, 1).getValue()=="有"){
                    confirm = "确定取消机构导入导出数据权限？";
                }
                layerConfirm(confirm,function () {
                    $.ajax({
                        type : 'post',
                        url : "/DicJgdmTz/getMenuRole?jgdm="+selectId,
                        dataType: "json",
                        success:function(data){
                            if(data.success == true){
                                layerSuccess("操作成功！");
                                reLoadGrid();
                            }else{
                                alert(data.msg);
                            }
                        }
                    });
                })
            }else{
                layerInfo("请选择医疗机构！");
            }
        }

        function randPass(){
            if (selectId != null) {
                var confirm = "确定为机构添加导入导出数据密码？";
                if(mygrid.cells(selectId, 2).getValue()){
                    confirm = "重新生成导出密码，会导致之前数据无法导入！确定继续？";
                }
                layerConfirm(confirm,function () {
                    $.ajax({
                        type : 'post',
                        url : "/DicJgdmTz/getRandPass?jgdm="+selectId,
                        dataType: "json",
                        success:function(data){
                            if(data.success == true){
                                layerSuccess("已成功生成导出码！");
                                reLoadGrid();
                            }else{
                                alert(data.msg);
                            }
                        }
                    });
                })
            }else{
                layerInfo("请选择医疗机构！");
            }
        }
    </script>
</head>
<body>


<div class="navheader form-inline" style="padding:0 5px;height:40px;">

    <%--<div class=" form-group">--%>
        <%--<label for="serach" style="padding:5px 10px 0px 20px;">查询</label>--%>
        <%--<input type="text" id="serach" class="form-control" placeholder="名称、代码查询"/>--%>
        <%--<button type="button" class="btn btn-success bi-btn-search" onclick="search()">--%>
            <%--<span class="glyphicon glyphicon glyphicon-search"></span>--%>
        <%--</button>--%>
    <%--</div>--%>
    <div class="btn-group-right">
        <div class="btn-group " role="group">
            <button type="button" class="btn btn-default bi-btn-width90" onclick="grid_Load()">刷新</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="add()">新增</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="update()">修改</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="dele()">删除</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="menoRole()">修改权限</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="randPass()">生成导出码</button>
        </div>
    </div>
</div>



<div style="margin:0 5px; overflow: hidden; border:1px solid #ddd;" id="div_tree">
    <!--树形菜单-->
    <div style="width:20%;float:left;display:inline-block; padding:10px 0 0 0px; overflow:auto; ">

        <ul id="tree" class="easyui-tree"></ul>

    </div>
    <!--列表 -->

    <div style="width:80%;float:right;display:inline-block; padding:4px 4px 10px 4px;border-left:1px solid #ddd;">
        <%--<table id="gridtable" class="datagrid"></table>--%>
        <table style="width: 99.8%; ">
            <tr>
                <td id="recinfoArea"></td>
            </tr>
            <tr>
                <td>
                    <div id="gridbox" style="width: 100%;height: 300px;">
                    </div>
                </td>
            </tr>
            <tr>
                <td id="pagingArea"></td>
            </tr>
        </table>

    </div>

</div>
</body>
</html>
