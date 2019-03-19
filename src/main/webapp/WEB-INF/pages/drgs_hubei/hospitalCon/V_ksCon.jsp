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

    <%--<script type="text/javascript" src="${ctx}/static/js/jsonpData.js" ></script>--%>
    <script type="text/javascript" src="${ctx}/static/js/dlcommon.js" ></script>
    <script>
        var biIds =['3087132c-1143-4b7f-adbf-3555ab05b39c'];//报表id
        var biKeys =[];//报表返回softkey
        var ksData;
        var selectData = parent.hubeiCon.ksTreeData;
        $(function () {
            var height = findDimensions_height();
            $("#r_datagrid1").height(height-50);
            $("#r_datagrid2").height(height-50);
            loadGrid2();
            loadGrid3();
            loadData();
        })
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
                            { field: 'code', title: '代码', width: '60px', align: 'left',sortable:true, halign: 'center'},
                            { field: 'name', title: '科室', width: '120px', align: 'left',sortable:true,  halign: 'center'},
                            { field: 'operate', title: '操作', width: '40px', align: 'left', sortable:false,halign: 'center',
                                formatter:function(value,row,index){
                                    var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\' onclick="select(\'' + row.code + '\')"><span class=\'glyphicon  glyphicon glyphicon-ok\'></span></button>';
                                    return str;
                                }
                            }
                        ]
                    ],
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
                            { field: 'code', title: '代码', width: '60px', align: 'left',sortable:true, halign: 'center'},
                            { field: 'name', title: '科室', width: '120px', align: 'left',sortable:true,  halign: 'center'},
                            { field: 'operate', title: '操作', width: '40px', align: 'left', sortable:false,halign: 'center',
                                formatter:function(value,row,index){
                                    var str= '<button type=\'button\' class=\'btn btn-danger bi-glyphicon\' onclick="dele(\'' + row.code + '\')"><span class=\'glyphicon glyphicon glyphicon-remove\'></span></button>';
                                    return str;
                                }
                            }
                        ]
                    ]
                });
            loadSelectData();
        }

        function loadData(){
            var postdata = {p_dm: "V_ksCon_selectKsData"};
            dLong.getJSON("/commapiV2",postdata,function(data){
                if (data.success) {
                    ksData = data.Table;
                    var griddata = dLong.getGridData(data.Table,data.pagecount);//数据转化为easyui格式
                    $('#r_datagrid1').datagrid('loadData', griddata);
                }
            },true);
        }

        function select(dm){
            for(var i=0;i<ksData.length;i++){
                if(ksData[i].code==dm){
                    if(JSON.stringify(selectData).toString().indexOf(JSON.stringify(ksData[i]).toString())<0){
                       selectData.push(ksData[i]);
                    }
                    break;
                }
            }
            loadSelectData();
        }

        function dele(dm){
            for(var i=0;i<selectData.length;i++){
                if(selectData[i].code==dm){
                    selectData.splice(i,1)
                }
            }
            loadSelectData();
        }

        function search(){

            var search = $("#search").val();
            var ejks = [];
            for(var i=0;i<ksData.length;i++){
                if(ksData[i].code.indexOf(search)>-1 || ksData[i].name.indexOf(search)>-1){
                    ejks.push(ksData[i]);
                }
            }
            $('#r_datagrid1').datagrid({"data":ejks});
        }
        function on() {
            parent.hubeiCon.ksTreeData = selectData;
            closeIndexWindwos();
        }

        function em(){
            parent.hubeiCon.ksTreeData = [];
            selectData = [];
            loadSelectData();
        }

        function seleAll(){
            var data = $('#r_datagrid1').datagrid("getRows");
            for(var i=0;i<data.length;i++){
                if(JSON.stringify(selectData).toString().indexOf(JSON.stringify(data[i]).toString())<0){
                    selectData.push(data[i]);
                }
            }
            loadSelectData();
        }
        function loadSelectData(){
            var num = selectData.length;
            if(num !=0){
                parent.$("#"+parent.ksId).val("已选[ "+num+" ]项");
            }else{
                parent.$("#"+parent.ksId).val("");
            }
            $('#r_datagrid2').datagrid({"data":selectData});
        }
    </script>
</head>
<body>

<div class="navheader form-inline" style="padding:0 5px;height:40px;">
    <div class=" form-group" style="display: inline;">
        <label for="search"style="padding:5px 10px 0px 20px;">科室：</label>
        <input type="text" id="search" class="bi-input-serach" placeholder="代码、名称"/>
        <button type="button" class="btn btn-success bi-btn-search" onclick="search()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>
    <div class="btn-group-right" style="padding-top: 8px;">
        <div class="btn-group " role="group">
            <button type="button" class="btn btn-default bi-btn-width90" onclick="em()">清空</button>
            <%--<button type="button" class="btn btn-default bi-btn-width90" onclick="seleAll()">全选</button>--%>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="on()">确定</button>
        </div>
    </div>
</div>

<div style="margin:0 5px; overflow: hidden;" >
    <!--左边表格-->
    <div style="width:45%;float:left;display:inline-block;padding-right:5px;border-right:1px dotted #ccc;" >
        <table id="r_datagrid1" class="datagrid">
        </table>
    </div>
    <!--右边表格 -->
    <div style="width:55%;float:right;display:inline-block;padding-left:5px;">
        <%--<div style="padding:0 0 5px 0;border-bottom:1px dotted #ccc;">--%>
        <%--<div style="overflow: hidden;">--%>
            <%--<div style="width:100%;float:left;display:inline-block;padding-right:5px;border-right:1px dotted #ccc;" >--%>
                <%--<table id="r_datagrid1" class="datagrid">--%>
                <%--</table>--%>
            <%--</div>--%>
        <%--</div>--%>
        <div style="overflow: hidden;">
            <div style="width:100%;float:left;display:inline-block;" >
                <table id="r_datagrid2" class="datagrid">
                </table>
            </div>
            <!--右边表格 -->
        </div>
    </div>
</div>
</body>
</html>
