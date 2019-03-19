<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/9/8
  Time: 10:08
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
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js"></script>
    <script src="${ctx}/static/js/plugins/validationEngine/languages/jquery.validationEngine-zh_CN.js" type="text/javascript" charset="utf-8">
    </script>
    <script type="text/javascript" src="${ctx}/static/js/My97DatePicker/WdatePicker.js">  </script>
    <script type="text/javascript" src="${ctx}/static/js/stickUp.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/common.js"></script>
    <script src="${ctx}/static/js/plugins/validationEngine/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/layer/layer.js"></script>

    <script type="text/javascript">

        //		点取消关闭窗口
        function clearall(){
            var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
            parent.layer.close(index); //执行关闭
        }


        $(function(){
            $.getJSON("/FormDefineFieldValue/getFormFieldValues?tdId=${tdId}&tvId=${tvId}",function(data){
                var ss = '';

                $('#inputdiv').html(ss);
                for(var n=0;n<data.formDefineFieldEntityList.length;n++){
                    ss = ss + "<div class='bi-form-div'>";
                    if(data.formDefineFieldEntityList[n].level==null){
                        ss = ss + "<div></div>";
                    }else{
                        ss = ss + "<div>" + data.formDefineFieldEntityList[n].level +"</div>";
                    }
                    if(data.formDefineFieldEntityList[n].fdName==null){
                        ss = ss + "<div></div>";
                    }else{
                        ss = ss + "<div>"+  data.formDefineFieldEntityList[n].fdName + "</div>";
                    }


                    if(data.formDefineFieldEntityList[n].itemId != null){
                        if(data.formDefineFieldValueEntityList.length>0){
                            var c = 0;
                            for(var m=0;m<data.formDefineFieldValueEntityList.length;m++){
                                if(data.formDefineFieldEntityList[n].fdId == data.formDefineFieldValueEntityList[m].fdId){
                                    ss = ss + "<div><input  type='text'  class='inputfield form-control' value='" + data.formDefineFieldValueEntityList[m].fdValue + "'";
                                    ss = ss +" data-item='" + data.formDefineFieldEntityList[n].itemId +  "' data-fdid='" + data.formDefineFieldEntityList[n].fdId + "'" ;
                                    ss = ss +" data-tdid='" + data.formDefineFieldEntityList[n].tdId + "' data-fdname='" + data.formDefineFieldEntityList[n].fdName + "'";
                                    ss = ss +" data-fvid='" + data.formDefineFieldValueEntityList[m].fvId + "'/></div>";

                                    c++;
                                }
                            }

                            if(c==0){
                                ss = ss + "<div><input  type='text'  class='inputfield form-control'";
                                ss = ss + " data-item='" + data.formDefineFieldEntityList[n].itemId + "' data-fdid='" + data.formDefineFieldEntityList[n].fdId +"'";
                                ss = ss + " data-tdid='" + data.formDefineFieldEntityList[n].tdId + "' data-fdname='" + data.formDefineFieldEntityList[n].fdName +"'" ;
                                ss = ss + " data-fvid=''/></div>";
                            }
                        }
                        else{
                            ss = ss + "<div><input  type='text'  class='inputfield form-control'";
                            ss = ss + " data-item='" + data.formDefineFieldEntityList[n].itemId + "' data-fdid='" + data.formDefineFieldEntityList[n].fdId +"'";
                            ss = ss + " data-tdid='" + data.formDefineFieldEntityList[n].tdId + "' data-fdname='" + data.formDefineFieldEntityList[n].fdName +"'" ;
                            ss = ss + " data-fvid=''/></div>";
                        }


                    }
                    if(data.formDefineFieldEntityList[n].unit==null){
                        ss = ss +"<div></div>";
                        ss = ss +"</div>";
                    }else{
                        ss = ss +"<div>" +data.formDefineFieldEntityList[n].unit + "</div>";
                        ss = ss +"</div>";
                    }


                }
                $('#inputdiv').html(ss);
            });

        });

        <%--function checkIsSH(){--%>
        <%--$.ajaxSettings.async = false;--%>
        <%--$.getJSON("/FormDefineValue/checkIsSH?rq="+$("#date").val()+ "&tdId=${tdId}",function(data){--%>

        <%--debugger;--%>
        <%--if(data.success==true){--%>
        <%--layerInfo(data.msg);--%>
        <%--return true;--%>
        <%--}--%>
        <%--else{--%>
        <%--return false;--%>
        <%--}--%>
        <%--});--%>
        <%--$.ajaxSettings.async = true;--%>
        <%--}--%>

        function saveInput(){

//            if(checkIsSH()){return;}

            var fieldValues=[];
            $.each($(".inputfield"), function (i, n) {
                //carAddGoodsCookie(goodsList[$(n).data("id")].goodsId);
                var d={
                    tdId:$(n).data("tdid"),
                    fdId:$(n).data("fdid"),
                    fdName:$(n).data("fdname"),
                    fieldValue:$(n).val(),
                    itemId:$(n).data("item"),
                    //wdm:$("#wdm").val(),
                    rq:$("#date").val(),
                    tvId:$("#tvId").val(),
                    fvId:$(n).data("fvid")
                }

                fieldValues.push(d);
            })

            $.ajax({
                type:"POST",
                url:"/FormDefineFieldValue/saveInputHzb",
                dataType:"json",
                contentType:"application/json",
                data:JSON.stringify(fieldValues),
                success:function(data){
                    if (data.success == true) {
                        //alert(data.msg);
                        parent.refresh();
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
</head>
<body>


<form  id="mingxi" >
    <input type="hidden"   name="tvId" id="tvId" value="${tvId}">
    <input type="hidden"   name="tdId" id="tdId" value="${tdId}">
    <div style="" class="bi-stickUp clearfix">
        <div style="float:left;">
            <label for="date" style="margin-right:23px;">上报日期</label>
            <c:choose>
                <c:when test="${tvId==''}">
                    <input  type="text" placeholder=" "   class="bi-width140 validate[required] form-control Wdate" id="date" name="date"
                            onclick="WdatePicker({dateFmt:'${dateFmt}'
                                <c:out value="${dateFmt=='yyyy-MM季'?
                                 ',isQuarter:true, isShowOK:false, disabledDates:[\"....-0[5-9]-..\",\"....-1[0-2]-..\"], startDate:\"%y-01-01\"':
                                 ' '
                                 }"/>})"
                            style="height:25px ;width:90px;border-color:#aaa;"/>
                </c:when>
                <c:otherwise>
                    <input  type="text" placeholder=" " value="${rq}"  class="bi-width140 validate[required] form-control Wdate" id="date" name="date"  style="height:25px ;width:90px;border-color:#aaa;"/>
                </c:otherwise>
            </c:choose>


        </div>
        <div class=""  role="group" style="float:right" >
            <button type="button" onclick="clearall();" class="btn btn-default bi-btn-width90">取消</button>
            <button type="button"  onclick="saveInput();" class="btn btn-primary  bi-btn-width90">保存</button>
        </div>
    </div>
    <div class="container " style="padding-top:12px;">
        <div style="border-top:1px solid #ddd;" id="inputdiv">

        </div>
    </div>
</form>



</body>
</html>
