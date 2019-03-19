<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    //设置无缓存
    response.setHeader("progma","no-cache");
    response.setHeader("Cache-Control","no-cache");
%>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<meta name="format-detection" content="telephone=no,email=no,address=no">

<link rel="stylesheet" type="text/css" href="${ctx }/static/js/bootstrap-3.3.5/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="${ctx }/static/js/jquery-easyui-1.5/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${ctx }/static/js/jquery-easyui-1.5/themes/icon.css">
<link rel="stylesheet" href="${ctx }/static/js/plugins/validationEngine/css/validationEngine.jquery.css" type="text/css"/>
<link rel="stylesheet" type="text/css" href="${ctx }/static/css/style.css">
<link rel="stylesheet" href="${ctx }/static/js/plugins/layer/skin/layer.css" />

<script type="text/javascript" src="${ctx }/static/js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="${ctx }/static/js/bootstrap-3.3.5/bootstrap.js"></script>
<script type="text/javascript" src="${ctx }/static/js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctx }/static/js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${ctx }/static/js/common.js"></script>
<script type="text/javascript" src="${ctx }/static/js/my97DatePicker/WdatePicker.js" ></script>
<script type="text/javascript" src="${ctx }/static/js/plugins/layer/layer.js"></script>
<script type="text/javascript" src="${ctx }/static/js/easyuiPager.js?=5"></script>

<script src="${ctx }/static/js/plugins/validationEngine/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctx }/static/js/plugins/validationEngine/languages/jquery.validationEngine-zh_CN.js" type="text/javascript" charset="utf-8">
</script>
<style>
    /*去掉滚动条*/
    body{overflow-y:hidden;}
</style>