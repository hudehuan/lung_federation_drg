<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/06/27
  Time: 10:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>上报数据查看</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <script>
        $(function(){
            var date = new Date;
            var year=date.getFullYear();
            var startTime = year + '-01-01';
            var endTime = year + '-12-31';
            $("#startTime").val(startTime);
            $("#endTime").val(endTime);
            var height = findDimensions_height();

            $("#gridtable").height(height-50);
            loadList(startTime,endTime);

        });


        function loadList(startTime,endTime) {
            $('#gridtable').datagrid(
                {
                    url:'/CustomFormCheckList/getAllCheckList?startTime='+startTime+'&endTime='+endTime
                    +'&ks=&formid=&formStatus=&r='+Math.random(),
                    method:'get',
                    rownumbers:true,
                    singleSelect:true,
                    autoRowHeight:false,
                    pagination:true,
                    clientPaging:true,
                    pageSize:15,
                    pageList:[10,15,20,25,30,40,50],
                    columns: [
                        [
                            { field: 'dataId', title: '数据id', width: '60px', align: 'center', hidden: true },
                            { field: 'checkId', title: '审核id', width: '60px', align: 'center', hidden: true },
                            { field: 'inputKsId', title: '上报科室id', width: '60px', align: 'left', hidden: true },
                            { field: 'formId', title: '表单id', width: '60px', align: 'left', hidden: true },

                            { field: 'inputUserName', title: '上报人', width: '70px', align: 'left', halign: 'center' },
                            { field: 'inputTime', title: '上报时间', width: "120px", align: 'left', halign: 'center' },
                            { field: 'inputKs', title: '上报科室', width: '100px', align: 'left', halign: 'center' },

                            { field: 'checkUserName', title: '审核人', width: '70px', align: 'left', halign: 'center' },
                            { field: 'checkTime', title: '审核时间', width: '120px', align: 'left', halign: 'center' },
                            { field: 'step', title: '待审核步骤', width: '200px', align: 'left', halign: 'center' },
                            { field: 'form_status', title: '审核状态', width: '120px', align: 'left', halign: 'center',
                                formatter:function (value, row, index) {
                                    switch (value) {
                                        case "0":
                                            return "未提交审核";
                                        case "1":
                                            return "审核中";
                                        case "2":
                                            return "审核结束";
                                        case "3":
                                            return "驳回";
                                    }
                                }
                            },
                            { field: 'formName', title: '事件类型', width: '150px', align: 'left', halign: 'center' },

                            { field: 'operate', title: '操作', width: "150px", align: 'left', halign: 'center',
                                formatter:function(value,row,index){
                                    var str='<button type=\'button\' class=\'btn btn-success bi-glyphicon \'onclick="sele(\'' + row.dataId + '\',\'' + row.formId + '\',\''+row.formName+'\')">查看</button>';
                                    str+= '<button type=\'button\' class=\'btn btn-danger  bi-glyphicon\' onclick="shck(\''+row.checkId+'\')"><span>审核记录</span></button>';
                                    return str;
                                }
                            }
                        ]
                    ]
                }).datagrid('clientPaging');
        }

        function shck(id){
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(width*0.75,height-200,"审核记录查看","/V_SjsbFormShLog/toLogList?checkID="+id);
        }

        function sele(dataId,formId,formName){
            var url = "/v_customformdata/toEdit?dataId="+dataId+"&tableId="+formId+"&formStatus=-2";
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(0.85*width,height-50,formName,url);
        }

        function search(){
            var ks = $("#ks").val();
            var sh = $("#sh").val();
            var formId = $("#formId").val();
            var startTime = $("#startTime").val();
            var endTime = $("#endTime").val();
            $('#gridtable').datagrid(
                {
                    url:'/CustomFormCheckList/getAllCheckList?startTime='+startTime+'&endTime='+endTime
                    +'&ks='+encodeURI(ks)+'&formid='+formId+'&formStatus='+sh+'&r='+Math.random()
                })
        }
    </script>
</head>
<body>
<div class="navheader form-inline" style="padding:0 5px;height:40px;">
    <div class=" form-group">
        <span>上报时间：</span>
        <span>
            <input type="text" class="form-control Wdate" style="width:90px;" name="startTime" id="startTime" value=""
                   onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd' })">
            <span>至</span>
            <input type="text" class="form-control Wdate" style="width:90px;" name="endTime" id="endTime" value=""
                   onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd' })">
        </span>
        <label for="ks">科室：</label>
        <input type="text"   name="ks" id="ks" class="form-control " placeholder="科室名称、拼音" style="width:90px;height: 20px;"/>
        <label for="formId">事件类型：</label>
        <select id="formId" name="formId">
            <option value="">全部</option>
            <c:forEach items="${form}" var="form">
                <option value="${form.id}">${form.name}</option>
            </c:forEach>
        </select>
        <label for="sh">审核状态：</label>
        <select id="sh">
            <option value="">全部</option>
            <option value="0">未审核</option>
            <option value="1">审核中</option>
            <option value="2">审核结束</option>
            <option value="3">驳回</option>
        </select>

        <button type="button" class="btn btn-success " onclick="search()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>
</div>
<div style="padding:0 5px;">
    <table id="gridtable" class="gridtable" style="width:100%;" >
    </table>
</div>
</body>
</html>
