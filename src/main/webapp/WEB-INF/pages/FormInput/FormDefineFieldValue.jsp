<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/8/31
  Time: 9:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <meta charset="UTF-8">
    <title>雕龙数据</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/bootstrap-3.3.5/css/bootstrap.css">

    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/style.css">
    <link rel="stylesheet" href="${ctx}/static/js/plugins/layer/skin/layer.css" />
    <link rel="stylesheet" href="${ctx}/static/js/plugins/validationEngine/css/validationEngine.jquery.css" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/jquery-easyui-1.5/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/jquery-easyui-1.5/themes/default/easyui.css">
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js"></script>
    <script src="${ctx}/static/js/plugins/validationEngine/languages/jquery.validationEngine-zh_CN.js" type="text/javascript" charset="utf-8">
    </script>
    <script type="text/javascript" src="${ctx}/static/js/My97DatePicker/WdatePicker.js">  </script>
    <script type="text/javascript" src="${ctx}/static/js/stickUp.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/common.js"></script>
    <script src="${ctx}/static/js/plugins/validationEngine/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery-easyui-1.5/jquery.easyui.min.js"></script>

    <script type="text/javascript">
        //		点取消关闭窗口
        function clearall(){
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
            parent.layer.close(index); //执行关闭
        }
        function refreshParent(){
            GetIndexActiveIframe().refresh();
        }
        function btnclose(){
            closeIndexWindwos();
        }

    </script>
    <style>
        .tooltip {
            width: 240px;
            height: 240px;
            overflow: auto;
        }

        /*去掉滚动条*/
        body{overflow-y:hidden;}


        /*stickUp插件*/
        .bi-stickUp{
            display:block;background-color:#dff0d8 ;opacity:0.9;padding:5px;overflow: hidden;width:100%;z-index: 999;border:1px solid #dff0d8;
        }
    </style>


    <script>

        $(function(){

           // $("#wdm option[value='${wdm}']").attr("selected", "selected");

//debugger
            if($("#wdm").val()==""){
            initSearchGrid("wdmname","${ctx}/FormDefineFieldValue/getWdm?tdId=${tdId}&tvId=${tvId}"
                    + "&rdm="+ parseInt(Math.random()*100000),
                    [{field:'dm',title:'维代码',width:"70px"},
                        {field:'name',title:'维名称',width:"100px"}],
                    function(index,row){
                        //alert("选中行id:"+row.dm);
                        $("#wdmname").val(row.name);
                        $("#wdm").val(row.dm);
                    })
            }
        });


        function checkIsSH(){
            $.ajaxSettings.async = false;
            $.getJSON("/FormDefineValue/checkIsSH?rq="+$("#date").val()+ "&tdId=${tdId}"
            + "&rdm="+ parseInt(Math.random()*100000),function(data){
                if(data.success==true){
                    layerInfo(data.msg);
                    return true;
                }
                else{
                    return false;
                }
            });
            $.ajaxSettings.async = true;
        }

        function saveInput(){

            //$('#wdmname').removeAttr("disabled");

            if($("#date").val()==''){
                //alert("日期必填");
                layerInfo("请选择上报日期！");
                return ;
            }
            if($('#wdmname').val()==''){
                layerInfo("请选择名称！");
                return ;
            }
            <%--$.ajaxSettings.async = false;--%>
            <%--//先判断数据是否已审核--%>
          <%--if( $.getJSON("/FormDefineValue/checkIsSH?rq="+$("#date").val()+ "&tdId=${tdId}",function(data){--%>

                <%--if(data.success==true){--%>
                    <%--layerInfo(data.msg);--%>
                    <%--return true;--%>
                <%--}--%>
            <%--})){--%>
                <%--return;--%>
            <%--}--%>
            <%--$.ajaxSettings.async = true;--%>

            if(checkIsSH()){return;}

            var fieldValues=[];
            $.each($(".inputfield"), function (i, n) {
                //carAddGoodsCookie(goodsList[$(n).data("id")].goodsId);
                var d={
                    tdId:$(n).data("tdid"),
                    fdId:$(n).data("fdid"),
                    fdName:$(n).data("fdname"),
                    fieldValue:$(n).val(),
                    itemId:$(n).data("item"),
                    wdm:$("#wdm").val(),
                    rq:$("#date").val(),
                    tvId:$("#tvId").val(),
                    fvId:$(n).data("fvid")
                }

                fieldValues.push(d);
            })

            $.ajax({
                type:"POST",
                url:"/FormDefineFieldValue/saveInput",
                dataType:"json",
                contentType:"application/json",
                data:JSON.stringify(fieldValues),
                success:function(data){
                    if (data.success == true) {
                        //alert(data.msg);
                        parent.loadRightList($('#tvId').val());
                        layerSuccess(data.msg, function () {
                            //关闭窗体
                            closeIndexWindwos();
                        });
                    } else {
                        //alert(data.msg);
                        layerInfo("数据保存失败！");
                    }
                    // $.messager.progress("close");
                }
            });
        }


        /**
         * @param {Object} id 控件id
         * @param {Object} ajaxurl 远程搜索地址
         * @param {Object} gridcolumn gird显示的行
         * @param {Object} selectEvent 选中回调事件
         */
        function initSearchGrid(id,ajaxurl,gridcolumn,selectEvent){
            var grid;
            var keyword="";
            var autoid="gridtable_"+id;
            //加载grid
            this.loadData=function(gid,Sevent){
                $('#'+gid).datagrid({
                    url:ajaxurl+keyword,
                    method:'get',
                    singleSelect:true,//是否只能选中一行
                    pagination:false,//是否启动分页
                    rownumbers:true,
                    columns:[gridcolumn],
                    //选中行事件
                    onSelect : function(index, row){
                        Sevent&&Sevent(index,row);
                    }
                });
                $('#'+gid).height($(".tooltip").height()-10);
            };
            $('#'+id).tooltip({
                position: 'bottom',
                content: '<table id="'+autoid+'"></table>',
                showEvent:"focus",
                hideEvent:"aa",
                onShow: function(){
                    //调整提示框位置
                    var top=$(this).tooltip('tip').offset().top-5;
                    $(this).tooltip('tip').attr("id","tips_"+id);
                    $(this).tooltip('tip').css({
                        top:top+'px'
                    });
                    //提示框鼠标离开事件
                    $("#tips_"+id).mouseleave(function(){
                        if($('#'+id+':focus').attr("id")!=id)
                            $("#tips_"+id).hide();
                    })
                    //绑定搜索框change事件
                    $("#"+id).unbind("input");
                    $("#"+id).unbind("propertychange");
                    $("#"+id).bind('input propertychange', function() {
                        //if($("#"+id).val()!="")
                        //{
                            keyword="keyword="+unescape($("#"+id).val());
                            if(ajaxurl.indexOf("?")>=0)
                            {
                                keyword="&"+keyword;
                            }else
                            {
                                keyword="?"+keyword;
                            }
                            loadData("gridtable_"+id,selectEvent);
                        //}
                    });
                    //加载过就不加载
                    if($("#tips_"+id).find(".datagrid").length<=0)
                        loadData("gridtable_"+id,selectEvent);
                }
            })
        }


    </script>



</head>
<body>


<form  id="mingxi" >
    <input type="hidden"   name="tvId" id="tvId" value="${tvId}">
    <input type="hidden"   name="tdId" id="tdId" value="${tdId}">
    <input type="hidden"   name="wdm" id="wdm" value="${wdm}">
    <div style="" class="bi-stickUp clearfix">
        <div style="float:left;">
            <label for="date" style="margin-right:23px;">上报日期</label>
            <input  type="text" placeholder=" " value="${rq}"  class="bi-width140 validate[required] form-control Wdate" id="date" name="date"  style="height:25px ;width:90px;border-color:#aaa;"/>
            <label for="wdmname" style="margin-right:23px;">名称</label>
            <input href="javascript:void(0)" name="wdmname" id="wdmname"  value="${wdmname}"  type="text" placeholder=" " style="width: 240px; display: inline-block;" class="form-control">


            <%--<c:choose>--%>
                <%--<c:when test="${wdm==''}">--%>
                    <%--<select name="wdm" id="wdm" style="padding:2px 0px;" class="bi-width140 form-control">--%>
                        <%--<c:forEach items="${wdmList}" var="wdm">--%>
                            <%--<option value="${wdm.dm}" >${wdm.name}</option>--%>
                        <%--</c:forEach>--%>
                    <%--</select>--%>
                <%--</c:when>--%>
                <%--<c:otherwise>--%>
                    <%--<select name="wdm" id="wdm" disabled="disabled" style="padding:2px 0px;" class="bi-width140 form-control">--%>
                        <%--<c:forEach items="${wdmList}" var="wdm">--%>
                            <%--<option value="${wdm.dm}" >${wdm.name}</option>--%>
                        <%--</c:forEach>--%>
                    <%--</select>--%>
                <%--</c:otherwise>--%>
            <%--</c:choose>--%>

            <%--<c:if test="${wdm} == ''">--%>
                <%--$('#wdmname').attr("readonly","readonly");--%>
            <%--</c:if>--%>
        </div>
        <div class=""  role="group" style="float:right" >
            <button type="button" onclick="clearall();" class="btn btn-default bi-btn-width90">取消</button>
            <button type="button"  onclick="saveInput();" class="btn btn-primary  bi-btn-width90">保存</button>
        </div>
    </div>
    <div class="container " style="padding-top:12px;">
        <div style="border-top:1px solid #ddd;" id="inputdiv">

            <c:forEach items="${fields}" var="field">
                <div class="bi-form-div">
                    <div>${field.level}</div>
                    <div>${field.fdName}</div>
                    <c:if test="${field.itemId!= null}">
                            <c:choose>
                                <c:when test="${fn:length(fieldsValue)>0}">
                                    <c:forEach items="${fieldsValue}" var="fieldvalue">
                                        <c:if test="${field.fdId == fieldvalue.fdId}">
                                            <div><input class="inputfield" type="text"  class="form-control" style="position:relative;line-height:19px;border:1px solid #aaa;" value="${fieldvalue.fdValue}"
                                            data-item="${field.itemId}"  data-fdid="${field.fdId}"
                                            data-tdid="${field.tdId}" data-fdname="${field.fdName}"
                                                    data-fvid="${fieldvalue.fvId}"/></div>

                                        </c:if>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div><input class="inputfield" type="text"  class="form-control" style="position:relative;line-height:19px;border:1px solid #aaa;"
                                                data-item="${field.itemId}"  data-fdid="${field.fdId}"
                                                data-tdid="${field.tdId}" data-fdname="${field.fdName}"
                                                data-fvid="${fieldvalue.fvId}"/></div>

                                </c:otherwise>
                            </c:choose>



                    </c:if>
                    <div style="width: 80px;">${field.unit}</div>
                </div>
            </c:forEach>

        </div>
    </div>
</form>

</body>
</html>
