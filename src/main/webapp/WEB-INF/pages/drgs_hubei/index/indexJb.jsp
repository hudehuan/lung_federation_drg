<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/09/11
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="format-detection" content="telephone=no,email=no,address=no">
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/base.css">
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/login-2.css">
    <link rel="stylesheet" href="${ctx }/static/js/layui/css/layui.css" />
    <script type="text/javascript" src="${ctx }/static/js/layui/layui.all.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js" ></script>
    <title></title>
    <style>
        .left-pt .w-125{
            margin:2.5px;
            width: 11em;
            height: 65px;
            line-height:57px;
            padding: 15px 0 15px 0;
            text-align: center;
        }
        .w-14em{
            width:9.5em!important;
        }
        .w-8em{
            width:9.5em!important;
        }
    </style>
</head>
<body>

<div class="box ">

    <div class="center-box " style="">
        <div class="header">湖北省省级住院医疗服务绩效评价平台</div>
        <div class="q-qubu shiClick" style="cursor: pointer;">
            <span><img src="${ctx}/static/img/quanbu.png"/></span>
            <p data-jb="@novalue|@novalue|">全部</p>
        </div>
        <div class="left-pt" style="font-size:16px;">
            <p class="djpt">三级医院</p>
            <ul>
                <li class="w-125  w-14em shiClick" >
                    <span><img src="${ctx}/static/img/quanbu.png"/></span>
                    <p data-jb="三级|@novalue|">全部</p>
                </li>
                <li class="w-125  w-8em shiClick">
                    <span><img src="${ctx}/static/img/wz-icon.png"/></span>
                    <p data-jb="三级|综合|">综合医院</p>
                </li>
                <li class="w-125  w-8em shiClick">
                    <span style="width:24px;"><img src="${ctx}/static/img/zhongyiyuan.png"/></span>
                    <p data-jb="三级|中医|">中医医院</p>
                </li>
                <li class="w-125  w-14em shiClick">
                    <span style="width:19px;"><img src="${ctx}/static/img/btn_fuchanke_03.png"/></span>
                    <p data-jb="三级|妇幼|">妇幼医院</p>
                </li>
                <li class="w-125  w-14em shiClick">
                    <span style="width:28px;"><img src="${ctx}/static/img/zhuanke.png"/></span>
                    <p data-jb="三级|专科|">专科医院</p>
                </li>
                <li class="w-125  w-8em shiClick">
                    <span style="width:28px;"><img src="${ctx}/static/img/minying.png"/></span>
                    <p data-jb="三级|民营|">民营医院</p>
                </li>
            </ul>
        </div>
        <div class="right-djs" style="font-size:16px;">
            <p class="djpt">二级医院</p>
            <ul>
                <li class="w-125  w-14em shiClick" >
                    <span><img src="${ctx}/static/img/quanbu.png"/></span>
                    <p data-jb="二级|@novalue|">全部</p>
                </li>
                <li class="w-125  w-8em shiClick">
                    <span><img src="${ctx}/static/img/wz-icon.png"/></span>
                    <p data-jb="二级|综合|">综合医院</p>
                </li>
                <li class="w-125  w-8em shiClick">
                    <span style="width:24px;"><img src="${ctx}/static/img/zhongyiyuan.png"/></span>
                    <p data-jb="二级|中医|">中医医院</p>
                </li>
                <li class="w-125  w-14em shiClick">
                    <span style="width:19px;"><img src="${ctx}/static/img/btn_fuchanke_03.png"/></span>
                    <p data-jb="二级|妇幼|">妇幼医院</p>
                </li>
                <li class="w-125  w-14em shiClick">
                    <span style="width:28px;"><img src="${ctx}/static/img/zhuanke.png"/></span>
                    <p data-jb="二级|专科|">专科医院</p>
                </li>
                <li class="w-125  w-8em shiClick">
                    <span style="width:28px;"><img src="${ctx}/static/img/minying.png"/></span>
                    <p data-jb="二级|民营|">民营医院</p>
                </li>
            </ul>
        </div>
    </div>
</div>
<script>
    $('body').on('click',".shiClick",function(){
        var bivar = "${shi}|"+$(this).find("p").attr("data-jb")
        window.location.href = '/index/index?bivar='+escape(escape(bivar))+'&${urlParam}';

    })

</script>
</body>
</html>
