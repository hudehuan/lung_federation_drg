<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/09/25
  Time: 17:21
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
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/login-hubei.css">
    <link rel="stylesheet" href="${ctx }/static/js/layui/css/layui.css" />
    <script type="text/javascript" src="${ctx }/static/js/layui/layui.all.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js" ></script>
    <title></title>
    <style>
        body{overflow: hidden}
        .t-tips a{
            display: block;
            width: 80%;
            margin: 0 auto;
        }
    </style>
</head>
<body>

<div class="box ">

    <div class="center-box " style="">
        <div class="header">湖北省省级住院医疗服务绩效评价平台</div>
        <div class="left-pt" style="font-size:16px;">
            <div class="w-250 r-tip f-zhuan t-tips s-pintai" id='dg'>
                <a>
                <span style="width: 26px;"><img src="${ctx}/static/img/hubei.png"/></span>
                <p data-shi="@novalue">省级平台</p>
                </a>
            </div>
            <c:if test="${peizhi=='peizhi'}" var="condition" scope="request">
            <div class="wz-pz">
                <div class="w-250 r-tip f-zhuan t-tips peizhi">
                    <span><img src="${ctx}/static/img/pz-icon.png"/></span>
                    <p data-shi="配置">配置</p>
                </div>
            </div>
            </c:if>
        </div>
        <div class="right-djs" style="font-size:16px;">
            <ul>
                <li class="w-125 t-tips">
                    <a>
                        <span><img src="${ctx}/static/img/cs-icon.png"/></span>
                        <p data-shi="省属">省属</p>
                    </a>
                </li>
                <li class="w-125 t-tips">
                    <a>
                    <span><img src="${ctx}/static/img/cs-icon.png"/></span>
                    <p data-shi="武汉市">武汉市</p>
                    </a>
                </li>
                <li class="w-125 t-tips">
                    <a>
                    <span><img src="${ctx}/static/img/cs-icon.png"/></span>
                    <p data-shi="黄石市">黄石市</p>
                    </a>
                </li>
                <li class="w-125 t-tips">
                    <a>
                    <span><img src="${ctx}/static/img/cs-icon.png"/></span>
                    <p data-shi="十堰市">十堰市</p>
                    </a>
                </li>
                <li class="w-125 t-tips">
                    <a>
                    <span><img src="${ctx}/static/img/cs-icon.png"/></span>
                    <p data-shi="宜昌市">宜昌市</p>
                    </a>
                </li>
                <li class="w-125 t-tips">
                    <a>
                    <span><img src="${ctx}/static/img/cs-icon.png"/></span>
                    <p data-shi="襄阳市">襄阳市</p>
                        </a>
                </li>
                <li class="w-125 t-tips">
                    <a>
                    <span><img src="${ctx}/static/img/cs-icon.png"/></span>
                    <p data-shi="鄂州市">鄂州市</p>
                    </a>
                </li>
                <li class="w-125 t-tips">
                    <a>
                    <span><img src="${ctx}/static/img/cs-icon.png"/></span>
                    <p data-shi="荆门市">荆门市</p>
                    </a>
                </li>
                <li class="w-125 t-tips">
                    <a>
                    <span><img src="${ctx}/static/img/cs-icon.png"/></span>
                    <p data-shi="孝感市">孝感市</p>
                    </a>
                </li>
                <li class="w-125 t-tips">
                    <a>
                    <span><img src="${ctx}/static/img/cs-icon.png"/></span>
                    <p data-shi="荆州市">荆州市</p>
                    </a>
                </li>
                <li class="w-125 t-tips">
                    <a>
                    <span><img src="${ctx}/static/img/cs-icon.png"/></span>
                    <p data-shi="黄冈市">黄冈市</p>
                    </a>
                </li>
                <li class="w-125 t-tips">
                    <a>
                    <span><img src="${ctx}/static/img/cs-icon.png"/></span>
                    <p data-shi="咸宁市">咸宁市</p>
                    </a>
                </li>
                <li class="w-125 t-tips">
                    <a>
                    <span><img src="${ctx}/static/img/cs-icon.png"/></span>
                    <p data-shi="随州市">随州市</p>
                    </a>
                </li>
                <li class="w-125 t-tips">
                    <a>
                    <span><img src="${ctx}/static/img/cs-icon.png"/></span>
                    <p data-shi="恩施土家族苗族自治州">恩施</p>
                    </a>
                </li>
                <li class="w-125 t-tips">
                    <a>
                        <span><img src="${ctx}/static/img/cs-icon.png"/></span>
                        <p data-shi="省直辖县级行政单位">省直辖</p>
                    </a>
                </li>

            </ul>
        </div>
    </div>



</div>

<script>
    $('body').on('click',".t-quanbu a",function(){
        $(this).addClass('active');
        $(this).parent('li').siblings().children('a').removeClass('active');
        var bivar = $(this).attr("data-bivar");
        window.location.href = '/index/index?bivar='+escape(escape(bivar))+'&${urlParam}';
    })

    var tipindex;
    var s="<div style='color:#333;font-size:16px;margin:5px 0 10px 0'>请选择相应的机构分类:</div>";
    s +='<div class="t-quanbu t-mar-top"><ul><li><a class="active" data-bivar="sxshi|@novalue|@novalue|">全部</a></li>' +
        '<li><a data-bivar="sxshi|所有|综合|">综合医院</a></li><li><a data-bivar="sxshi|所有|专科|">专科医院</a></li>' +
        '<li><a data-bivar="sxshi|所有|中医|">中医医院</a></li><li><a data-bivar="sxshi|所有|妇幼|">妇幼医院</a></li>' +
        '<li><a data-bivar="sxshi|所有|民营|">民营医院</a></li></ul></div>'
    s +='<p class="jgjb"><span><img src="${ctx}/static/img/jb.png"/></span>三级机构</p>'
    s +='<div class="t-quanbu jb-active"><ul><li><a  data-bivar="sxshi|三级|@novalue|">全部</a></li>' +
        '<li><a data-bivar="sxshi|三级|综合|">综合医院</a></li><li><a data-bivar="sxshi|三级|专科|">专科医院</a></li>' +
        '<li><a data-bivar="sxshi|三级|中医|">中医医院</a></li><li><a data-bivar="sxshi|三级|妇幼|">妇幼医院</a></li>' +
        '<li><a data-bivar="sxshi|三级|民营|">民营医院</a></li></ul></div>'
    s +='<p class="jgjb lanse"><span><img src="${ctx}/static/img/lb.png"/></span>二级机构</p>'
    s +='<div class="t-quanbu lb-active"><ul><li><a data-bivar="sxshi|二级|@novalue|">全部</a></li>' +
        '<li><a data-bivar="sxshi|二级|综合|">综合医院</a></li><li><a data-bivar="sxshi|二级|专科|">专科医院</a></li>' +
        '<li><a data-bivar="sxshi|二级|中医|">中医医院</a></li><li><a data-bivar="sxshi|二级|妇幼|">妇幼医院</a></li>' +
        '<li><a data-bivar="sxshi|二级|民营|">民营医院</a></li></ul></div>'
    $('.t-tips').on('mouseenter',function(){//mouseenter
        var that = $(this).find("a");
        var shi = $(this).find("p").attr("data-shi");
        if(shi!="配置"){
            var re = /(sxshi+)/g;
            var tips = s.replace(re,shi);
            tipindex = layer.tips(tips,that,{tips:[1],time:0, maxWidth:500});
        }else{
            layer.closeAll("tips");
        }

    });

    $('.box').on('mouseenter',function(){
        layer.closeAll("tips");
    });

    $(".peizhi").on("click",function(){
        var bivar = $(this).find("p").attr("data-shi");
        window.location.href = '/index/index?bivar='+escape(escape(bivar))+'&${urlParam}';
    })
</script>
</body>
</html>
