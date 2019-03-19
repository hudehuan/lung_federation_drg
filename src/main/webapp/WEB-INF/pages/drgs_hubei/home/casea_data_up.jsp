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
<div id="loading" class="loader"></div>
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
                    <a style="float: right;" data-month="01">导入</a>
                    <p>1月</p>
                    <p><span class="shuzi">4078</span>例</p>
                </div>
            </li>
            <li>
                <div>
                    <a style="float: right;"  data-month="02">导入</a>
                    <p>2月</p>
                    <p><span class="shuzi">4078</span>例</p>
                </div>
            </li>
            <li>
                <div>
                    <a style="float: right;"  data-month="03">导入</a>
                    <p>3月</p>
                    <p><span class="shuzi">4078</span>例</p>
                </div>
            </li>
            <li>
                <div>
                    <a style="float: right;"  data-month="04">导入</a>
                    <p>4月</p>
                    <p><span class="shuzi">4078</span>例</p>
                </div>
            </li>
            <li>
                <div>
                    <a style="float: right;"  data-month="05">导入</a>
                    <p>5月</p>
                    <p><span class="shuzi">4078</span>例</p>
                </div>
            </li>
            <li>
                <div>
                    <a style="float: right;"  data-month="06">导入</a>
                    <p>6月</p>
                    <p><span class="shuzi">4078</span>例</p>
                </div>
            </li>
            <li>
                <div>
                    <a style="float: right;"  data-month="07">导入</a>
                    <p>7月</p>
                    <p><span class="shuzi">4078</span>例</p>
                </div>
            </li>
            <li>
                <div>
                    <a style="float: right;"  data-month="08">导入</a>
                    <p>8月</p>
                    <p><span class="shuzi">4078</span>例</p>
                </div>
            </li>
            <li>
                <div>
                    <a style="float: right;"  data-month="09">导入</a>
                    <p>9月</p>
                    <p><span class="shuzi">4078</span>例</p>
                </div>
            </li>
            <li>
                <div>
                    <a style="float: right;"  data-month="10">导入</a>
                    <p>10月</p>
                    <p><span class="shuzi">4078</span>例</p>
                </div>
            </li>
            <li>
                <div>
                    <a style="float: right;"  data-month="11">导入</a>
                    <p>11月</p>
                    <p><span class="shuzi">4078</span>例</p>
                </div>
            </li>
            <li>
                <div>
                    <a style="float: right;"  data-month="12">导入</a>
                    <p>12月</p>
                    <p><span class="shuzi">4078</span>例</p>
                </div>
            </li>
        </ul>
    </div>
</div>

<script>
    //获取屏幕的高
    var H= 0;
    var biIds =['a785c016-0fb2-4a07-8165-7d062fd49af1'];//报表id    1eb0997c-70fe-4faf-90c7-326a4e99ab6a   ,7ba81124-f5cf-419a-ba81-c063cf923dc9
    var biKeys =[];//报表返回softkey
    $(document).ready(function () {
        H=$('#top-demand').height();
        $('.main-center').css('padding-top',H+'px');

    })

    $(function(){
        $.ajax({
            type:"POST",
            url:"/HBI/loadBiKsy?biIds="+biIds,
            dataType: "json",
            success:function(data){
                biKeys =data;
                $("#loading").fadeOut("slow");
            }
        });
        var date = new Date;
        var year=date.getFullYear();
        $("#rq").val(year);
    })
    $('body').on('click',".casea-data a",function(){
        var m = $(this).attr("data-month")
        if(biKeys.length==0) alert("数据加载中，请稍等！");

        var rq = $("#rq").val();

        layeropen(600,300,"导入数据","/V_CaseaData/toHomePageCaseaDataUpDat?fDate="+ rq+"-"+m);

    });


</script>
</body>
</html>

