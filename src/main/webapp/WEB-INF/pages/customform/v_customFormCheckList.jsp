<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/11/14
  Time: 13:48
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <%@ include file="/common/meta.jsp" %>
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/blsj.css?v=3">
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/danbingzhong.css?v=3">
    <script type="text/javascript" src="${ctx }/static/js/echarts-2.2.7/build/source/echarts-all.js"></script>



    <title>事件审核</title>

    <script>
        $(function(){

            var height = findDimensions_height();
            var width = findDimensions_width();
            $("#gridtable").height(height-180);

            $("#gridtable1").height(height-180);

            //	宽度
            $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {

                $('#gridtable1').datagrid('resize', {
                    width: $($(e.target).attr("href")).width()-10
                })
            });
            $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                $('#gridtable').datagrid('resize', {
                    width: $($(e.target).attr("href")).width()-10
                })
            });

            $("#sjsh").height(height-50);    //对主页数据上报限制高度
            getAllTypeForTree();

            var date = new Date;
            var year=date.getFullYear();


            var   startTime = year + '-01-01';
            var  day = date.getDate();
            var endTime = year + '-12-31';
            $("#startTime").val(startTime);
            $("#endTime").val(endTime);
            $("#sTime").val(startTime);
            $("#eTime").val(endTime);
//            loadCheckList();
            $('#gridtable').datagrid(
                    {
                        url:"/CustomFormCheckList/getNoCheckList?sTime="+startTime+"&eTime="+endTime+"&formStatus=1&formId=&r="+Math.random(),
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        autoRowHeight:false,
                        pagination:true,
                        pageSize:15,
                        pageList:[15,20,25,30,40,50],
                        clientPaging:true,
                        columns: [
                            [
                                {field: 'id', title: 'ID', hidden: true},
                                {field: 'dataId', title: 'dataId', hidden: true},
                                { field: 'inputTime', title: '填报时间', width: '100px', align: 'left', halign: 'center'},
                                { field: 'inputUserName', title: '填报人', width: '100px', align: 'left', halign: 'center' },

                                { field: 'formTypeName', title: '事件类型', width: '100px', align: 'left', halign: 'center' },
                                { field: 'formName', title: '表单类型', width: '100px', align: 'left', halign: 'center' },
                                { field: 'ShName', title: '审核流程', width: '260px', align: 'left', halign: 'left' },
                                { field: 'formStatus', title: '审核状态', width: '100px', align: 'left', halign: 'center',
                                    formatter:function (value, row, index) {
                                        switch (parseInt(value)) {
                                            case 0:
                                                return "未提交审核";
                                            case 1:
                                                return "审核中";
                                            case 2:
                                                return "审核结束";
                                            case 3:
                                                return "驳回";
                                        }
                                    }
                                },

                                { field: 'operate', title: '操作', width: '100px', align: 'left', halign: 'center',
                                    formatter:function(value,row,index){
                                        var str= '<button type=\'button\' class=\'btn btn-primary bi-glyphicon\'onclick="openCheck(\''+row.dataId+'\',\''+row.formId+'\',\''+row.formName+'\',\''+row.formStatus+'\')" ><span class=\'glyphicon  glyphicon glyphicon-pencil\'></span></span></button>';
                                        return str;
                                    }
                                }
                            ]
                        ],
                        onSelect : function(index, row){
                            selectid=row.nid;
                            selectindex=index;
                        }
                    }).datagrid('clientPaging');
            $("#staTime").val(startTime);
            $("#enTime").val(endTime);
//            loadCheckedList();
            $('#gridtable1').datagrid(
                    {
                        url:"/CustomFormCheckList/getCheckedList?sTime="+startTime+"&eTime="+endTime+"&formId=&all=&r="+Math.random(),
                        method:'get',
                        rownumbers:true,
                        singleSelect:true,
                        autoRowHeight:false,
                        pagination:true,
                        pageSize:15,
                        pageList:[15,20,25,30,40,50],
                        clientPaging:true,
                        columns: [
                            [

                                {field: 'id', title: 'ID', hidden: true},
                                {field: 'lid', title: 'LID', hidden: true},
                                {field: 'dataId', title: 'dataId', hidden: true},
                                { field: 'name', title: '我审核的步骤', width: '150px', align: 'left', halign: 'center' },
                                { field: 'checkName', title: '审核人', width: '150px', align: 'left', halign: 'center' },
                                { field: 'Sjtime', title: '审核时间', width: '100px', align: 'left', halign: 'center'},
                                { field: 'inputUserName', title: '填报人', width: '100px', align: 'left', halign: 'center' },
                                { field: 'inputTime', title: '填报时间', width: '100px', align: 'left', halign: 'center'},
                                { field: 'formTypeName', title: '事件类型', width: '100px', align: 'left', halign: 'center' },
                                { field: 'formName', title: '表单类型', width: '100px', align: 'left', halign: 'center' },
                                { field: 'ShName', title: '审核流程', width: '260px', align: 'left', halign: 'left' },
                                { field: 'formStatus', title: '审核状态', width: '100px', align: 'left', halign: 'center',
                                    formatter:function (value, row, index) {

                                        switch (parseInt(value)) {
                                            case 0:
                                                return "未提交审核";
                                            case 1:
                                                return "审核中";
                                            case 2:
                                                return "审核结束";
                                            case 3:
                                                return "驳回";
                                        }
                                    }
                                },
                                { field:'tools', title: '操作', width: "60px", align: 'left', halign: 'center',
                                    formatter:function(value,row,index){
                                        var str='<button type=\'button\' class=\'btn btn-success bi-glyphicon \'onclick="openView(\''+row.dataId+'\',\''+row.formId+'\',\''+row.formName+'\',\''+row.formStatus+'\')">查看</button>';
                                        return str;
                                    }
                                }
                            ]
                        ],
                        onSelect : function(index, row){
                            selectid=row.nid;
                            selectindex=index;
                        }
                    }).datagrid('clientPaging');
        });


        function openCheck(dataId,formId,formName,formStaus){
            var url = "/v_customformdata/toEdit?dataId="+dataId+"&tableId="+formId+"&formStatus="+formStaus;
            openPage(formName,url);
        }
        function loadList() {
            loadCheckedList();
//            loadCheckList();
            ref();
        }
        function openView(dataId,formId,formName,formStatus){
            var url = "/v_customformdata/toEdit?dataId="+dataId+"&tableId="+formId+"&formStatus="+formStatus;
            openPage(formName,url);
        }
        function openPage(formName,url){
                        var height = findDimensions_height();
                        var width = findDimensions_width();
                        layeropen(0.85*width,height-50,formName,url);
        }

        function loadCheckedList(){
            var all = "";
            if($("#all").is(':checked')){
                all = "all";
            }
            var startTime = $("#staTime").val();
            var endTime = $("#enTime").val();
            var formId=$('#selForm2').children('option:selected').val();//这就是selected的值
            $('#gridtable1').datagrid(
                    {
                        url:"/CustomFormCheckList/getCheckedList?sTime="+startTime+"&eTime="+endTime+"&formId="+formId+"&all="+all+"&r="+Math.random()
                    });
        }
        function loadCheckList(){
            var startTime = $("#sTime").val();
            var endTime = $("#eTime").val();
            var formId=$('#selForm1').children('option:selected').val();//这就是selected的值
            $('#gridtable').datagrid(
                {
                    url:"/CustomFormCheckList/getNoCheckList?sTime="+startTime+"&eTime="+endTime+"&formStatus=1&formId="+formId+"&r="+Math.random()

                }
            );
        }


        function ref(){

            var url = '${ctx}/CustomFormCheckList/dorefresh?formStatus=1';
            var args = {"time":new Date()};
            $.getJSON(url,args,function(data){
                $("#refe").empty();
                var $refe = "<div>有<span onclick=\"tiao('')\">"+data.count+"</span>条未审核数据。</div>";

                var fo = data.formCountList;
                var sel1 = '';
                $('#selForm1').html(sel1);
                sel1 = sel1 + "<option value=''>全部</option>";
                for(var a = 0;a<fo.length;a++){
                    $refe+= "<div>"+fo[a].formName+"<span onclick=\"tiao('"+fo[a].formId+"')\">"+fo[a].count+"</span>条</div>"
                    sel1 = sel1 + "<option value='" + fo[a].formId + "'>" + fo[a].formName + "</option>";
                }
                $("#refe").append($refe);
                $('#selForm1').html(sel1);
            });
            loadCheckList();
        }




        var MenuTreeData;
        function getAllTypeForTree() {
            var url = "/CustomType/getAllTypeForTreeOfUserID";
            $.ajaxSettings.async = false;
            $.getJSON(url, function (data) {
                MenuTreeData = data;
            });
            $.ajaxSettings.async = true;
            var height = findDimensions_height();

            $("#typeTree").height(height * 0.91 - 35);
            $('#typeTree').tree({
                method: "get",
                animate: true,
                url: url,
                data: MenuTreeData,

                onClick: function (node) {

                    if (node.id.length = 0) return;
                    $.getJSON("/CustomForm/getFormByID?formId="+node.id,function(data){
                        $('#framelist').attr("src",'/V_CustomFormList/toList?listName='+data.listName+'&formId='+data.id);
                    });

                }

            });
        }

        function tiao(formId){
            var startTime = $("#sTime").val();
            var endTime = $("#eTime").val();
            $('#gridtable').datagrid(
                    {
                        url:"/CustomFormCheckList/getNoCheckList?sTime="+startTime+"&eTime="+endTime+"&formStatus=1&formId="+formId+"&r="+Math.random()
                    });
        }
    </script>



</head>
<body>



<!--导航条-->
<div style="position:fixed;left:1px;top:0;background-color:#fff;z-index:9999;display:block;width:100%;">
    <ul class="nav nav-tabs" role="tablist" id="mytab" >
        <li  class="active"><a href="#sbsju" data-toggle="tab">数据审核</a></li>
        <li ><a href="#sjsh"  data-toggle="tab">审核明细</a></li>
    </ul>
</div>
<!--内容-->
<div  class="tab-content" >
    <!--上报数据开始-->
    <div class="tab-pane fade in active" style="margin-top:30px;" id="sbsju">
        <div style="padding: 15px;border:none;" >
            <!--数据审核按钮-->

            <!--11月14日修改-->
            <div class="shsj_header" style="border:1px solid #bbb;padding:10px 20px;border-radius: 3px;" id="refe">
                <div>有<input type="hidden" value=""/><span onclick="tiao('')" >${noCheckNums}</span>条未审核数据。</div>
                <c:forEach items="${FormCounts}" var="f" varStatus="status">
                    <%--<option value="${type.id}">${type.name}</option>--%>
                    <div>${f.formName}<input type="hidden" value="${f.formId}"/><span onclick="tiao('${f.formId}')" >${f.count}</span>条</div>

                </c:forEach>

                <%--表单1<span>12</span>条 表单2<span>12</span>条  表单3<span>12</span>条--%>
            </div>

        </div>
        <!--表格开始-->
        <!--小导航条-->
        <div style="background-color:#fff; width:99%;">
            <ul class="nav nav-tabs " role="tablist" id="mySb" >
                <li  class="active"><a href="#Sb_shsj" data-toggle="tab">待审核数据</a></li>
                <li ><a href="#Sb_wshsj"  data-toggle="tab" >最近审核数据</a></li>
            </ul>
        </div>
        <!--小内容-->
        <div  class="tab-content" style="margin:0 5px">
            <div class="tab-pane  active"  id="Sb_shsj">
                <div class="navheader form-inline" style="padding:0 5px;height:40px;">
                    <div class=" form-group">
                        <span>上报时间：</span>
                    <span>
                            <input type="text" class="form-control Wdate" style="width:90px;" name="sTime" id="sTime" value=""
                                   onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd' })">
                            <span>至</span>
                            <input type="text" class="form-control Wdate" style="width:90px;" name="eTime" id="eTime" value=""
                                   onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd' })">
                            <button type="button" class="btn btn-success bi-btn-search" onclick="loadCheckList()">
                                <span class="glyphicon glyphicon glyphicon-search"></span>
                            </button>
                        </span>
                    </div>

                    <div class="table_header">

                        <span>上报事件</span>
                        <%--<span>表单类型</span>--%>
                        <select name="selForm1" id="selForm1" style="margin:0;width:200px;display:inline-block;" onchange="loadCheckList()">
                            <option value="">全部</option>
                            <c:forEach items="${FormCounts}" var="f" varStatus="status">
                                <option value="${f.formId}">${f.formName}</option>
                            </c:forEach>
                        </select>

                    </div>
                </div>
                <table id="gridtable"  style="width:100%;" >
                </table>

            </div>



            <div class="tab-pane "  id="Sb_wshsj" >
                <div class="navheader form-inline" style="padding:0 5px;height:40px;">
                    <div class=" form-group">
                        <span>上报时间：</span>
                    <span>
                            <input type="text" class="form-control Wdate" style="width:90px;" name="staTime" id="staTime" value=""
                                   onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd' })">
                            <span>至</span>
                            <input type="text" class="form-control Wdate" style="width:90px;" name="enTime" id="enTime" value=""
                                   onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd' })">
                            <button type="button" class="btn btn-success bi-btn-search" onclick="loadCheckedList()">
                                <span class="glyphicon glyphicon glyphicon-search"></span>
                            </button>
                        </span>
                    </div>

                    <div class="table_header">
                        <input type="checkbox" name="all" id="all" value="all" onclick="loadCheckedList()"/> <label for="all">全部数据</label>
                        <%--最近<input type="text" class="form-control" placeholder="100" id="num" style="width:50px;"/>条数据--%>
                        <%--<span>上报时间</span>--%>
                        <span>上报事件</span>
                        <select name="selForm2" id="selForm2" style="margin:0;width:200px;display:inline-block;" onchange="loadCheckedList()">
                            <option value="">全部</option>
                            <c:forEach items="${checkForm}" var="f" varStatus="status">
                                <option value="${f.id}">${f.name}</option>
                            </c:forEach>
                            <%--<c:forEach items="${formTypes}" var="type" varStatus="status">--%>
                                <%--<option value="${type.id}">${type.name}</option>--%>
                            <%--</c:forEach>--%>
                        </select>
                        <%--<span>表单类型</span>--%>
                        <%--<select name="" id="" class="form-control" style="margin:0;width:200px;display:inline-block;">--%>
                        <%--<option value="">类型一</option>--%>
                        <%--<option value="">类型二</option>--%>
                        <%--<option value="">类型三</option>--%>
                        <%--<option value="">类型四</option>--%>
                        <%--</select>--%>

                    </div>
                </div>

                <table id="gridtable1"  style="width:100%;" >
                </table>

            </div>

        </div>

    </div>
    <!--上报数据结束-->
    <!--数据审核-->
    <div class="tab-pane fade" id="sjsh" >
        <div style="width:20%;border:1px solid #ddd;border-top:none;float:left;margin:38px 5px 0 0;height:100%;" >
            <ul id="typeTree" class="easyui-tree" style="padding:5px;"></ul>
        </div>
        <div style="width:79%;float:left;height:100%;padding:5px;margin-top:40px;">
            <div class="J_mainContent mainContent" id="" style="height:100%;">
                <iframe id="framelist" class="J_iframe" scrolling="auto" src="" style="border:none" name="iframe0" width="100%" height="100%"  frameborder="0" ></iframe>
            </div>
        </div>
    </div>
</div>




</body>
</html>
