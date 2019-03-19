<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/08/01
  Time: 15:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <script type="text/javascript" src="${ctx}/static/js/jsonpData.js" ></script>
    <script type="text/javascript" src="${ctx}/static/js/dlcommon.js" ></script>
    <script>
        var biIds =['5029cc6e-84a7-43f7-8492-6976e6354f41'];//报表id
        var biKeys =[];//报表返回softkey
        var mdcData;
        var MDCdm;
        var drgsData;
        var selectData = parent.hubeiCon.mdcTreeData;
        $(function () {
            var height = findDimensions_height();
            $("#l_datagrid").height(height-50);
            $("#r_datagrid1").height(height/2-27);
            $("#r_datagrid2").height(height/2-27);
            loadGrid1();
            loadGrid2();
            loadGrid3();
            loadData();
        })
        function loadGrid1() {
            $('#l_datagrid').datagrid({
                url:'',
                method:'get',
                rownumbers:true,
                singleSelect:true,
                autoRowHeight:false,
                clientPaging:true,
                remoteSort:false,
                columns: [
                    [
                        { field: 'MDCdm', title: 'MDC代码', width: '80px', align: 'left',sortable:true,  halign: 'center'},
                        { field: 'MDCmc', title: 'MDC名称', width: '240px', align: 'left',sortable:true,  halign: 'center'},

                    ]
                ],
                onSelect:function (value, row, index) {
                    MDCdm = row.MDCdm;
                    loadDRGs(row.MDCdm);
                }
            });
        }
        function loadGrid2() {
            $('#r_datagrid1').datagrid({
                url:'',
                method:'get',
                rownumbers:true,
                singleSelect:true,
                autoRowHeight:false,
                clientPaging:true,
                remoteSort:false,
                columns: [
                    [
                        { field: 'DRGsdm', title: 'DRGs代码', width: '80px', align: 'left',sortable:true,  halign: 'center'},
                        { field: 'DRGsmc', title: 'DRGs名称', width: '240px', align: 'left',sortable:true, halign: 'center'},
                        { field: 'MDCmc', title: 'MDC名称', width: '240px', align: 'left',sortable:true,  halign: 'center'},
                        { field: 'operate', title: '操作', width: '60px', align: 'left', sortable:false,halign: 'center',
                            formatter:function(value,row,index){
                                var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\' onclick="select(\'' + row.DRGsdm + '\')"><span class=\'glyphicon  glyphicon glyphicon-ok\'></span></button>';
                                return str;
                            }
                        }
                    ]
                ],
                onSelect:function (value, row, index) {
//                        loadDRGs(row.dm);
                }
            });
        }
        function loadGrid3() {
            $('#r_datagrid2').datagrid({
                url:'',
                method:'get',
                rownumbers:true,
                singleSelect:true,
                autoRowHeight:false,
                clientPaging:true,
                remoteSort:false,
                columns: [
                    [
                        { field: 'dm', title: '代码', width: '80px', align: 'left',sortable:true,  halign: 'center'},
                        { field: 'mc', title: '名称', width: '480px', align: 'left',sortable:true, halign: 'center'},
//                        { field: 'MDCmc', title: 'MDC名称', width: '200px', align: 'left',sortable:true,  halign: 'center'},
                        { field: 'operate', title: '操作', width: '60px', align: 'left', sortable:false,halign: 'center',
                            formatter:function(value,row,index){
                                var str= '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="dele(\'' + row.dm + '\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></button>';
                                return str;
                            }
                        }
                    ]
                ]
            });
            loadSelectData()
        }

        function loadData(){
            var postdata = {p_dm: "V_mdcCon_selectData"};
            dLong.getJSON("/commapiV2",postdata,function(data){
                if (data.success) {
                    mdcData = data.Table;
                    drgsData = data.Table1;
                    var griddata = dLong.getGridData(data.Table,data.pagecount);//数据转化为easyui格式
                    $('#l_datagrid').datagrid('loadData', griddata);
                }
            },true);
        }

        function loadDRGs(dm){
            var DRGs = [];
            for(var i=0;i<drgsData.length;i++){
                if(drgsData[i].MDCdm==dm ){
                    DRGs.push(drgsData[i]);
                }
            }
            $('#r_datagrid1').datagrid({"data":DRGs});
        }
        function select(dm){
            for(var i=0;i<drgsData.length;i++){
                if(drgsData[i].DRGsdm==dm){
                    var isc = true;
                    for(var j=0;j<selectData.length;j++){
                        if(!selectData[j].DRGsdm && drgsData[i].MDCdm==selectData[j].MDCdm){
                            isc = false;
                            break;
                        }
                    }
                    if(isc && JSON.stringify(selectData).toString().indexOf(JSON.stringify(drgsData[i]).toString())<0){
                        selectData.push(drgsData[i]);
                    }
                    break;
                }
            }
            loadSelectData()
        }

        function dele(dm){
            for(var i=0;i<selectData.length;i++){
                if(selectData[i].DRGsdm==dm || selectData[i].MDCdm==dm){
                    selectData.splice(i,1)
                }
            }
            loadSelectData()
        }
        
        function search(){
            var search = $("#search").val();
            var DRGs = [];
            for(var i=0;i<drgsData.length;i++){
                if((drgsData[i].DRGsdm.indexOf(search)>-1 || drgsData[i].DRGsmc.indexOf(search)>-1)){
                    DRGs.push(drgsData[i]);
                }
            }
            $('#r_datagrid1').datagrid({"data":DRGs});
        }
        function on() {
            parent.hubeiCon.mdcTreeData = selectData;
            closeIndexWindwos();
        }
        function em(){
            parent.hubeiCon.mdcTreeData = [];
            selectData = [];
            loadSelectData()
        }

        function seleAll(){
            var data = $('#r_datagrid1').datagrid("getRows");
            for(var i=0;i<selectData.length;){
                if(JSON.stringify(data).toString().indexOf(JSON.stringify(selectData[i]).toString())>-1) {
                    selectData.splice(i,1);
                }else{
                    i++
                }
            }
            for(var j=0;j<mdcData.length;j++){
                if(mdcData[j].MDCdm==MDCdm){
                    if(JSON.stringify(selectData).toString().indexOf(JSON.stringify(mdcData[j]).toString())<0){
                        selectData.push(mdcData[j]);
                    }
                    break;
                }
            }
            loadSelectData();
        }

        function loadSelectData(){
            var num = selectData.length;
            if(num !=0){
                parent.$("#"+parent.mdcId).val("已选[ "+num+" ]项");
            }else{
                parent.$("#"+parent.mdcId).val("");
            }
            var gridData=[];
            for(var i=0;i<selectData.length;i++){
                var j;
                if(selectData[i].DRGsdm){
                    j={"dm":selectData[i].DRGsdm,"mc":selectData[i].DRGsmc};
                }else {
                    j={"dm":selectData[i].MDCdm,"mc":selectData[i].MDCmc};
                }
                gridData.push(j);
            }
            $('#r_datagrid2').datagrid({"data":gridData});
        }
    </script>
</head>
<body>

<div class="navheader form-inline" style="padding:0 5px;height:40px;">
    <div class=" form-group">
        <label for="search"style="padding:5px 10px 0px 20px;">DRGs分组：</label>
        <input type="text" id="search" class="bi-input-serach" placeholder="代码、名称"/>
        <button type="button" class="btn btn-success bi-btn-search" onclick="search()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>
    <div class="btn-group-right" style="padding-top: 8px;">
        <div class="btn-group " role="group">
            <button type="button" class="btn btn-default bi-btn-width90" onclick="em()">清空</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="seleAll()">全选</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="on()">确定</button>
        </div>
    </div>
</div>

<div style="margin:0 5px; overflow: hidden;" >
    <!--左边表格-->
    <div style="width:35%;float:left;display:inline-block;padding-right:5px;border-right:1px dotted #ccc;" >
        <table id="l_datagrid" class="datagrid"></table>
    </div>
    <!--右边表格 -->
    <div style="width:65%;float:right;display:inline-block;padding-left:5px;">
        <%--<div style="padding:0 0 5px 0;border-bottom:1px dotted #ccc;">--%>
        <div style="overflow: hidden;">
            <div style="width:100%;float:left;display:inline-block;" >
                <table id="r_datagrid1" class="datagrid">
                </table>
            </div>
        </div>
        <div style="overflow: hidden;">
            <div style="width:100%;float:left;display:inline-block;padding-top: 4px" >
                <table id="r_datagrid2" class="datagrid">
                </table>
            </div>
            <!--右边表格 -->
        </div>
    </div>
</div>
</body>
</html>
