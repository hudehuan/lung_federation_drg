<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/8/3
  Time: 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>交流讨论表管理</title>
    <script type="text/javascript">

    </script>
</head>
<body>
<div id="dlg" class="easyui-dialog" title="交流讨论表管理" style="width:400px;height:600px;padding:10px"
     closed="true" data-options="iconCls:'icon-save', buttons:'#bb'">

    <form action="${ctx}/SysDiscuss/save" method="post" id="save" >

        <input type="hidden" name="disId" value="${param.id}"/>
        <div style="margin-bottom:20px">
            <div>发表时间:</div>
            <input type="text" class="easyui-textbox" style="width:100%;height:32px" name ="disTime" id ="disTime">
        </div>
        <div style="margin-bottom:20px">
            <div>发表者人员ID:</div>
            <input class="easyui-textbox" style="width:100%;height:32px" name ="publisher" id="publisher">
        </div>
        <div style="margin-bottom:20px">
            <div>发表标题:</div>
            <input class="easyui-textbox" style="width:100%;height:32px" name ='title'>
        </div>
        <div style="margin-bottom:20px">
            <div>发表内容:</div>
            <input class="easyui-textbox" style="width:100%;height:32px" name ='discontent'>
        </div>
        <div style="margin-bottom:20px">
            <div>系统代码:</div>
            <input class="easyui-textbox" style="width:100%;height:32px" name ='sysCode'>
        </div>
        <div style="margin-bottom:20px">
            <div>类型:</div>
            <input class="easyui-textbox" style="width:100%;height:32px" name ='type'>
        </div>
        <div style="margin-bottom:20px">
            <div>状态:</div>
            <input class="easyui-textbox" style="width:100%;height:32px" name ='status'>
        </div>

        <input type="submit" value="save">
    </form>

</div>

</body>
</html>
