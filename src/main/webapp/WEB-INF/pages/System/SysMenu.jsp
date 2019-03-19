<%--
  Created by IntelliJ IDEA.
  User: 倪继文
  Date: 2016/7/21
  Time: 13:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <%@ include file="/common/meta.jsp" %>
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <script>
        var MenuTreeData;
        $(function () {
            var url = '/sysMenu/getAllMenu?='+ parseInt(Math.random()*100000);
            loadTree(url);
            if(${roleMenu.isEdit}){
                formValiPost("caidan", "${ctx}/sysMenu/save", function (json) {
                    if (json.success == false) {
                        $(json.id).validationEngine('showPrompt', json.msg, 'error', true);
                    }
                    else {
                        layerSuccess("成功");
                        refresh();
                    }

                });
            }
            else{
                layerInfo("没有权限!请找系统管理员申请权限!");
            }
        });
        function getMenuTreeData(url) {
            $.ajaxSettings.async = false;
            $.getJSON(url, function (data) {
                MenuTreeData = data;
            });
            $.ajaxSettings.async = true;
        }
        function loadTree(url) {
            getMenuTreeData(url);
            var height = findDimensions_height();
            $("#gridtable").height(height - 50);
            $("#menu1").height(height *0.91- 35);
            $("#menu1_warp").height(height *0.91);
            $('#menu1').tree({
                method: "get",
                animate: true,
                url:url,
                data: MenuTreeData,

                onClick: function (node) {
                    gotoUpdate(node.id);
                    LoadCurrentMenu(node.id);
                }
//                onLoadSuccess: function (node, data) {
//                    if ((data.length || 0) > 0 && data[0].id != "") {
//                        var node = $('#menu1').tree('find', data[0].id);
//                        $('#menu1').tree('select', node.target);
//                    }
//                }
            });
        }

        function addNext() {
            if(${roleMenu.isAdd}){
                if ( $('#type').val() != 'sort') {
                    layerError("该类型无法添加下级！");
                    return;
                }
                var pCode = $('#code').val();
                if (pCode == "") {
                    layerInfo("请选择分类！");
                        return;
                }
                clearForm();
                $('#pCode').val(pCode);
                $('#refCode').val(pCode);
            }
            else{
                layerInfo("没有权限!请找系统管理员申请权限!");
            }
        }

        function addCurrent() {
            if(${roleMenu.isAdd}){
                if ( $('#type').val() != 'sort') {
                    layerError("该类型无法添加同级！");
                    return;
                };
                var code = $('#code').val();
                if (code == "") {
                    layerInfo("请选择分类！");
                    return;
                }
                var pCode = $('#pCode').val();
                clearForm();
                if (pCode == "") {
                    return;
                }
                $('#pCode').val(pCode);
                $('#refCode').val(pCode);
            }
            else{
                layerInfo("没有权限!请找系统管理员申请权限!");
            }
        }

        function refresh() {
            loadTree('/sysMenu/getAllMenu?='+ parseInt(Math.random()*100000));
            $("input").val("");
            $("textarea").val("");
        }
        function clearForm() {
            $('#caidan').form('clear');
            $('#xh').val(0);
        }
        function gotoUpdate(id) {
            $('#id').val(id);
        }

        function LoadCurrentMenu(menuId, Menu) {
            $.ajax({
                url: "/sysMenu/getMenu?id=" + menuId+ "&rdm="+ parseInt(Math.random()*100000),
                data: Menu,
                success: function (data) {
                    $('#code').val(data.code);
                    $('#pCode').val(data.pCode);
                    $('#refCode').val(data.pCode);
                    $('#name').val(data.name);
                    $('#url').val(data.url);
                    $('#printUrl').val(data.printUrl);
                    $('#img').val(data.img);
                    $('#xh').val(data.xh);
                    $('#type').val(data.type)
                }
            })
        }
        function search() {
            var condition = $('#serach').val();
            var url = '/sysMenu/findByCondition?condition=' + encodeURI(condition) + "&rdm="+ parseInt(Math.random()*100000);
            //win=url;dow.location.href
            loadTree(url);
        }

        function sele(){
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(0.6*width,height-50,'选择菜单','/V_SysMenuFunction/toSeleList');
        }

        function initData(data){
            $("#name").val(data.name);
            $("#url").val(data.url);
            $('#type').val(data.type)
            $("#printUrl").val(data.printUrl);
        }

        function deleteOne(){
            if(${roleMenu.isAdd}){
                layerConfirm("是否确定删除?", function () {
                var id = $('#id').val();
                if ( id!= ''&& id !=null) {
                    $.ajax({
                        method: "POST",
                        url: "/sysMenu/delete?id="+id,
                        dataType: "JSON",
                        success: function(data){
                            if(data.success == true){
                                layerSuccess("删除成功",function(data){
                                    var url = '/sysMenu/getAllMenu?='+ parseInt(Math.random()*100000);
                                    loadTree(url);
                                    $("input").val("");
                                    $("textarea").val("");
                                })
                            }else{
                                layerError(data.msg);
                            }
                        }
                    })
                }else{
                    layerError("请选择需要删除菜单名！");
                    return;
                }
                })
            }else{
                layerInfo("没有权限!请找系统管理员申请权限!");
            }
        }

        function update(){
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(0.4*width,height-300,'模板保存','/V_SysMenuTemplate/toSaveMune');
        }

        function selectMenu(){
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(0.65*width,height-50,'模板选择','/V_SysMenuTemplate/selectMenu');
        }

        function setSelectRead() {
            $("#type").attr("readonly",'readonly');
            $("#url").attr("readonly",'readonly');
            $("#printUrl").attr("readonly",'readonly');
            var sex = document.getElementById("type");
            sex.onclick = function () {
                var index = this.selectedIndex;
                this.onchange = function () {
                    this.selectedIndex = index;
                };
            };

        }

        function removeSelectRead() {
            $("#type").removeAttr("readonly",'readonly');
            $("#url").removeAttr("readonly",'readonly');
            $("#printUrl").removeAttr("readonly",'readonly');
            var sex = document.getElementById("type");
            sex.onclick = function () {
//                var index = this.selectedIndex;
                this.onchange = function () {
                    this.selectedIndex = this.selectedIndex;
                };
            };

        }
        function downMenu(){
            layerConfirm('是否确定导出text文本数据?', function() {
                    location.href = "/sysMenu/downMenu?rdm=" + parseInt(Math.random() * 100000);
            })/*
            layerConfirm("是否确定导出?", function () {
                $.ajax({
                    method: "POST",
                    dataType: "JSON",
                    url: "/sysMenu/downMenu?rdm=" + parseInt(Math.random() * 100000),
                    success: function (data) {
                        if(data.success==true){
                            layerSuccess(data.msg);
                        }else{
                            layerInfo(data.msg);
                        }
                    }
                })
            })*/
        }
        function loadMenu(){
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(0.65*width,height*0.65,'模板文件导入','/sysMenu/loadMenu');
        }


    </script>
</head>
<body>
<div class="navheader form-inline" style="padding:0 5px;height:40px;">

    <div class=" form-group">
        <label for="serach" style="padding:5px 10px 0px 20px;">查询</label>
        <input type="text" id="serach" class="form-control" placeholder="名称、代码查询"/>
        <button type="button" class="btn btn-success bi-btn-search" onclick="search()">
            <span class="glyphicon glyphicon glyphicon-search"></span>
        </button>
    </div>
    <div class="btn-group-right">
        <div class="btn-group " role="group">
            <%--<button type="button" class="btn btn-default bi-btn-width90" onclick="setSelectRead()">zhidu</button>--%>
            <%--<button type="button" class="btn btn-default bi-btn-width90" onclick="removeSelectRead()">buzhid</button>--%>
                <button type="button" class="btn btn-default bi-btn-width90" onclick="loadMenu()">模板导入</button>
                <button type="button" class="btn btn-default bi-btn-width90" onclick="downMenu()">模板导出</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="selectMenu()">模板选择</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="update()">保存模板</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="sele()">功能选择</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="refresh()">刷新</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="addNext()" >新增下级</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="addCurrent()">新增同级</button>
            <button type="button" class="btn btn-default bi-btn-width90" onclick="deleteOne()">删除</button>
        </div>
    </div>
</div>




<div style="margin:0 5px; overflow: hidden; border:1px solid #ddd;" id="menu1_warp">
    <!--树形菜单-->
    <div style="width:30%;float:left;display:inline-block; padding:20px 0 0 20px; overflow:auto; ">

        <ul id="menu1" class="easyui-tree"></ul>

    </div>
    <!--表单 -->
    <div style="width:70%;float:right;display:inline-block; padding:10px 20px 10px 60px;border-left:1px solid #ddd;">
        <h4 style="display:block;padding:0; position:relative;">
            <span style="display: inline-block;float:left;margin-right:8px;height: 18px;width: 8px;background: #0066cc;"></span>
            菜单维护
        </h4>

        <div style="padding:0 10px 10px 20px;margin-left:20px;">
            <form id="caidan" action="${ctx}/sysMenu/save" method="post">
                <input type="hidden" name="id" id="id">
                <input type="hidden" name="refCode" id="refCode"/>
                <div class="div_border">
                    <div class="div_h ">
                        <label for="pCode">父菜单编码</label>
                        <input id="pCode" class="bi-width140 form-control" type="text" placeholder=" "
                               name="pCode" onkeydown="DigitInput()" style="width:137px;" readonly="readonly"/>
                    </div>

                </div>
                <div class="div_border">
                    <div class="div_h">
                        <label for="code">菜单编码&nbsp;&nbsp;&nbsp; </label>
                        <input type="text" class="bi-width140 validate[required] form-control" placeholder=" " id="code"
                               name="code" onkeydown="DigitInput()"/>
                        <b class="redColor">*</b>
                    </div>
                    <div class="div_h">
                        <label for="xh">&nbsp;&nbsp;&nbsp;&nbsp;序号&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                        <input type="number" class=" form-control bi-width140" id="xh" name="xh" style="width:50px;"
                               onkeydown="DigitInput()"/>
                    </div>
                </div>


                <div class="div_border">
                    <div class="div_h">
                        <label for="name">菜单名称&nbsp;&nbsp;&nbsp; </label>
                        <input type="text" class="bi-width140 form-control validate[required]" id="name" name="name">
                        <b class="redColor">*</b>
                    </div>
                </div>
                <div class="div_border">
                    <div class="div_h">
                        <label for="type">类型&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                        <select name="type" id="type" style="padding:2px 0px;width:140px;"
                                class="bi-width140 form-control" >
                            <option value="function" name="function">功能</option>
                            <option value="System" name="System">系统</option>
                            <option value="sort" name="sort">分类</option>
                            <option value="BI" name="BI">BI图表</option>
                            <option value="BIolap" name="BIolap">BIolap</option>
                            <option value="comment" name="comment">BI评价方案</option>
                            <option value="report" name="report">BI分析报告</option>
                            <option value="form" name="form">自定义表单</option>
                            <option value="excel" name="excel">Excel导入</option>
                        </select>
                    </div>
                    <div class="div_h ">
                        <label for="img">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;图标&nbsp;&nbsp;&nbsp;&nbsp;</label>
                        <input id="img" class="bi-width140 form-control" type="text" placeholder=" " name="img"
                               style="width:140px;"/>
                    </div>
                </div>
                <div class="div_border">
                    <div class="div_h ">
                        <label for="url" style="margin-top:20px;float: left;line-height: 25px;">导入url&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </label>
                        <textarea id="url" class="bi-width357  form-control"
                                  placeholder=" " name="url" style="width:354px;height:60px;"></textarea>
                    </div>

                </div>
                <div class="div_border">
                    <div class="div_h ">
                        <label for="printUrl" style="margin-top:20px;float: left;line-height: 25px;">打印url&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </label>
                        <textarea id="printUrl" class="bi-width357  form-control"
                                  placeholder=" " name="printUrl" style="width:354px;height:60px;"></textarea>
                    </div>

                </div>

                <button type="button" class="btn btn-default bi-btn-default bi-btn bi-btn-width90"
                        style="margin-left:110px;marrgin-top:25px;" name="closed" onclick="clearForm()">取消
                </button>
                <button type="submit" class="btn btn-primary bi-btn bi-btn-width90" style="margin-top:25px;">保存</button>

            </form>
            <div>
                说明：只有类型为“分类”的菜单才能增加同级或下级，系统通用的功能类型要选择“系统”。
            </div>
        </div>
    </div>
</div>
</body>
</html>