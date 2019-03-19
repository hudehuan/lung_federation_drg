<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/08/02
  Time: 11:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="format-detection" content="telephone=no,email=no,address=no">
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <link rel="stylesheet" href="${ctx }/static/css/base.css" />
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/css/bootstrap.css" />
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${ctx }/static/css/my-stlye.css" />

    <script type="text/javascript" src="${ctx }/static/js/jquery-1.11.2.min.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/bootstrap-3.3.5/bootstrap.min.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/my97DatePicker/WdatePicker.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/common.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/plugins/layer/layer.js"></script>
    <title></title>
</head>
<body>
<div id="loading" class="loader">
    <img class="Rotation" src="${ctx}/static/img/load.png" width="32" height="32"/>
</div>
<div class="top-demand" id="top-demand">
    <ul>
        <li>
            <label>年限：</label>
            <input type="text" class="Wdate " id="rq" style="width: 80px;height: 24px;vertical-align: middle;margin-bottom: 3px;border-radius:2px;border: 1px solid #ddd"
                   onfocus="WdatePicker({el:'rq',startDate:'%y',dateFmt:'yyyy',alwaysUseStartDate:true,maxDate:'%y'})">
        </li>
    </ul>
    <div class="top-btn" >查询</div>
</div>
<div class="main-center">
    <div  class="casea-data">
        <ul>
            <li>
                <div>
                    <a style="float: right;" data-month="01">下载</a>
                    <p>1月</p>
                    <p><span class="shuzi" id="rs1">0</span>例</p>
                    <p>入组率：<span class="shuzi" id="rzl1">0.00</span>%</p>
                </div>
            </li>
            <li>
                <div>
                    <a style="float: right;"  data-month="02">下载</a>
                    <p>2月</p>
                    <p><span class="shuzi" id="rs2">0</span>例</p>
                    <p>入组率：<span class="shuzi" id="rzl2">0.00</span>%</p>
                </div>
            </li>
            <li>
                <div>
                    <a style="float: right;"  data-month="03">下载</a>
                    <p>3月</p>
                    <p><span class="shuzi" id="rs3">0</span>例</p>
                    <p>入组率：<span class="shuzi" id="rzl3">0.00</span>%</p>
                </div>
            </li>
            <li>
                <div>
                    <a style="float: right;"  data-month="04">下载</a>
                    <p>4月</p>
                    <p><span class="shuzi" id="rs4">0</span>例</p>
                    <p>入组率：<span class="shuzi" id="rzl4">0.00</span>%</p>
                </div>
            </li>
            <li>
                <div>
                    <a style="float: right;"  data-month="05">下载</a>
                    <p>5月</p>
                    <p><span class="shuzi" id="rs5">0</span>例</p>
                    <p>入组率：<span class="shuzi" id="rzl5">0.00</span>%</p>
                </div>
            </li>
            <li>
                <div>
                    <a style="float: right;"  data-month="06">下载</a>
                    <p>6月</p>
                    <p><span class="shuzi" id="rs6">0</span>例</p>
                    <p>入组率：<span class="shuzi" id="rzl6">0.00</span>%</p>
                </div>
            </li>
            <li>
                <div>
                    <a style="float: right;"  data-month="07">下载</a>
                    <p>7月</p>
                    <p><span class="shuzi" id="rs7">0</span>例</p>
                    <p>入组率：<span class="shuzi" id="rzl7">0.00</span>%</p>
                </div>
            </li>
            <li>
                <div>
                    <a style="float: right;"  data-month="08">下载</a>
                    <p>8月</p>
                    <p><span class="shuzi" id="rs8">0</span>例</p>
                    <p>入组率：<span class="shuzi" id="rzl8">0.00</span>%</p>
                </div>
            </li>
            <li>
                <div>
                    <a style="float: right;"  data-month="09">下载</a>
                    <p>9月</p>
                    <p><span class="shuzi" id="rs9">0</span>例</p>
                    <p>入组率：<span class="shuzi" id="rzl9">0.00</span>%</p>
                </div>
            </li>
            <li>
                <div>
                    <a style="float: right;"  data-month="10">下载</a>
                    <p>10月</p>
                    <p><span class="shuzi" id="rs10">0</span>例</p>
                    <p>入组率：<span class="shuzi" id="rzl10">0.0</span>%</p>
                </div>
            </li>
            <li>
                <div>
                    <a style="float: right;"  data-month="11">下载</a>
                    <p>11月</p>
                    <p><span class="shuzi" id="rs11">0</span>例</p>
                    <p>入组率：<span class="shuzi" id="rzl11">0.00</span>%</p>
                </div>
            </li>
            <li>
                <div>
                    <a style="float: right;"  data-month="12">下载</a>
                    <p>12月</p>
                    <p><span class="shuzi" id="rs12">0</span>例</p>
                    <p>入组率：<span class="shuzi" id="rzl12">0.00</span>%</p>
                </div>
            </li>
        </ul>
    </div>
</div>
<script type="text/javascript" src="${ctx}/static/js/jsonpData.js" ></script>
<script type="text/javascript" src="${ctx}/static/js/dlcommon.js" ></script>
<script>
    //获取屏幕的高
    var H= 0;
    var yydm;
    var biIds =['1eb0997c-70fe-4faf-90c7-326a4e99ab6a','869e03c4-83ec-4f2b-97c6-13298b81f5c8'];//报表id
    var biKeys =[];//报表返回softkey
    $(document).ready(function () {
        H=$('#top-demand').height();
        $('.main-center').css('padding-top',H+'px');

    })
    $('.top-btn').click(function () {

        search();
    })
    $(function(){
        $.ajax({
            type:"POST",
            url:"/HBI/loadBiKsy?biIds="+biIds,
            dataType: "json",
            success:function(data){
                biKeys =data;
                search();
            }
        });
        var date = new Date;
        var year=date.getFullYear();
        $("#rq").val(year);
    })
    function search(){
        $("#loading").show();
        var loads=0;
        loads++;
        var postdata = {p_dm: "selectJgdmRole",userid:"${userid}"};
        dLong.getJSON("/commapiV2",postdata,function(data){
            if (data.success) {
               if(data.Table.length>0) yydm = data.Table[0].jgdm;
                loads--;
                test(loads);
            }
        });
        var srq = $("#rq").val()+"-01-01";
        var erq = $("#rq").val()+"-12-31";
        var cxtj0 = srq+";"+erq+"|";
        var url0 ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
            '&biyccs=&id=' +biKeys[0].id+'&softkey='+biKeys[0].softkey +
            '&cxtj='+escape(cxtj0)+'&topdata=&timew=&weiplan=';
        loads=loads+1;
        $.ajax({
            type:"GET",
            url:url0,
            dataType: "jsonp",
            success:function(data){
                loads=loads-1;
                test(loads);
                setData(data);
            }
        });
    }
    function setData(data) {
        var months = ['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'];
        data = jsonpDataInit(data);
        var tit = data.title.column[0].split(",");
        var row = data.rows.row[0];
        for(var i=0;i<months.length;i++){
            var rs = 0;
            var rzl = 0.00;
            for(var j=1;j<tit.length;j+=2){
                if(tit[j]==months[i]&&row.cell[i*2+1]){
                    rs =row.cell[i*2+1].split("^")[0];
                    rzl = row.cell[i*2+2];
                    break;
                }
            }
            $("#rs"+Number(i+1)).text(rs);
            $("#rzl"+Number(i+1)).text(rzl);
        }




    }


    $('body').on('click',".casea-data a",function(){
        var m = $(this).attr("data-month")
        CreateLoadWaitDiv("数据生成中，请等待!")

        var rq = $("#rq").val();
        var newDate = new Date(rq,m,0);
        var srq = rq+"-"+m+"-01";
        var erq = rq+"-"+m+"-"+newDate.getDate();
        var cxtj = srq+";"+erq+"|"+yydm+"|";
        var url ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx';
        var param = 'biqtuser=${biqtuser}&bivar='+
            '&biyccs=&id=' +biKeys[1].id+'&softkey='+biKeys[1].softkey +
            '&cxtj='+escape(cxtj)+'&topdata=&timew=&weiplan=';
//        location.href = "/CaseaData/postJsonPData?url="+escape(url)+
//            "&param="+escape(param)+"&fName="+rq+m+"&rdm=" + parseInt(Math.random() * 100000);

        $.ajax({
            type:"POST",
            url:"/CaseaData/postJsonPData",
            data:{"url":url,"param":param,"fName":rq+m,"time":new Date()},
            dataType: "json",
            success:function(data){
                CloseLoadWaitDiv();
                if(data.success==true){
                    location.href = "/CaseaData/fileDown?fName="+data.msg;
                }else {
                    layerInfo(data.msg);
                }
            }
        });
    });

    function CreateLoadWaitDiv(text) {
        var _html = ' <div  id ="bi-repopt-load" style="position:absolute;  cursor:wait;  width:95%;  background-color: rgba(192, 195, 195, 0.50);' +
            'filter:progid:DXImageTransform.Microsoft.Gradient(startColorstr=#55313131, endColorstr=#55313131);' +
            'height:94%;min-height:94%;  z-index:9999999;top :2.5%;left:2.5%;">' +
            '<div id="bi-repopt-load-memo"  style="position:relative; top:35%; margin:0 auto; ' +
            'width:240px; padding-left:3px; line-height:55px; height:60px;background-color:white; -moz-border-radius: 5px; -webkit-border-radius: 5px; border-radius:5px;">' +
            '<span style="display:inline-block;vertical-align:middle;">' +
            '<img src="${ctx}/static/img/load.gif" />' +
            '</span>' +
            '<span style="font-size:14px;display:inline-block;text-indent:5px;color:#383838">' +
            text+'</span>' +
            '</div>' +
            '</div>'
        $(_html).appendTo("body");
    }

    function CloseLoadWaitDiv() {
        var _mask = document.getElementById('bi-repopt-load');
        _mask.parentNode.removeChild(_mask);

    }


</script>
</body>
</html>

