//导出execl脚本
/*var idTmr;
function  getExplorer() {
    var explorer = window.navigator.userAgent ;
    //ie
    if (explorer.indexOf("MSIE") >= 0) {
        return 'ie';
    }
    //firefox
    else if (explorer.indexOf("Firefox") >= 0) {
        return 'Firefox';
    }
    //Chrome
    else if(explorer.indexOf("Chrome") >= 0){
        return 'Chrome';
    }
    //Opera
    else if(explorer.indexOf("Opera") >= 0){
        return 'Opera';
    }
    //Safari
    else if(explorer.indexOf("Safari") >= 0){
        return 'Safari';
    }
}
function method(tableid) {
    if(getExplorer()=='ie')
    {
        var curTbl = document.getElementById(tableid);
        var oXL = new ActiveXObject("Excel.Application");
        var oWB = oXL.Workbooks.Add();
        var xlsheet = oWB.Worksheets(1);
        var sel = document.body.createTextRange();
        sel.moveToElementText(curTbl);
        sel.select();
        sel.execCommand("Copy");
        xlsheet.Paste();
        oXL.Visible = true;

        try {
            var fname = oXL.Application.GetSaveAsFilename("Excel.xls", "Excel Spreadsheets (*.xls), *.xls");
        } catch (e) {
            print("Nested catch caught " + e);
        } finally {
            oWB.SaveAs(fname);
            oWB.Close(savechanges = false);
            oXL.Quit();
            oXL = null;
            idTmr = window.setInterval("Cleanup();", 1);
        }

    }
    else
    {
        tableToExcel(tableid)
    }
}
function Cleanup() {
    window.clearInterval(idTmr);
    CollectGarbage();
}
if(parent.userType!='省级'){
    $('.daochu').hide();
}*/
var tableToExcel = (function() {
    var uri = 'data:application/vnd.ms-excel;base64,',
        template = '<html border="1"><head><meta charset="UTF-8"></head><body border="1"><table border="1"  rull="all" style="border-collapse: collapse">{table}</table></body></html>',
        base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))) },
        format = function(s, c) {
            return s.replace(/{(\w+)}/g,
                function(m, p) { return c[p]; }) }
    return function(table,tables,name) {
        tables=   '<caption><span  style="font-size: 18px;font-weight: 800;">'+name+'</span></caption>'+tables;
        var ctx = {worksheet: name || 'worksheet', table:tables }
        window.location.href = uri +base64(format(template, ctx));
    }
})()
//canvas转base64
function getFullCanvasDataURL(divId,daochu,imgname){
//将第一个画布作为基准。
    var baseCanvas = $("#"+divId).find("canvas").first()[0];
    if(!baseCanvas){
        return false;
    };
    var width = baseCanvas.width;
    var height = baseCanvas.height;
    var ctx = baseCanvas.getContext("2d");
    //遍历，将后续的画布添加到在第一个上
    $("#"+divId).find("canvas").each(function(i,canvasObj){
        if(i>0){
            var canvasTmp = $(canvasObj)[0];
            ctx.drawImage(canvasTmp,0,0,width,height);
        }
    });
    //获取base64位的url
    var triggerDownload = $("#"+daochu).attr("href", baseCanvas.toDataURL()).attr("download", imgname);
    triggerDownload[0].click();
    //triggerDownload.remove();
    //return baseCanvas.toDataURL();
}



function getBase64Image(divId){
//将第一个画布作为基准。
    var baseCanvas = $("#"+divId).find("canvas").first()[0];
    if(!baseCanvas){
        return false;
    };
    var width = baseCanvas.width;
    var height = baseCanvas.height;
    baseCanvas.shadowColor = 'rgb(0,0,0)';
    var ctx = baseCanvas.getContext("2d");
    //遍历，将后续的画布添加到在第一个上
    $("#"+divId).find("canvas").each(function(i,canvasObj){
        if(i>0){
            var canvasTmp = $(canvasObj)[0];
            ctx.drawImage(canvasTmp,0,0,width,height);
        }
    });
    return baseCanvas.toDataURL();
}

function ExcelDown(excleJson){
    CreateLoadWaitDiv("正在导出Excel文件...");

    // excleJson = {excel:JSON.stringify(//Excel数据类型
    //     [{
    //         img:JSON.stringify([a,b,c]), //a,b,c 为图片base64
    //         table:JSON.stringify(
    //             [{
    //                 title: JSON.stringify([titledata]),//表头数据
    //                 data:JSON.stringify([tabledata])//表格数据
    //             }]
    //         )
    //     },
    //      ...]//多个Excel Json数据创建多个Sheet
    // )}
    // var tableJson = {title: JSON.stringify(options["columns"]),data:JSON.stringify(options["data"])};
    $.ajax({
        url: "/hubei/ExcelDown/createExcelFile",
        type: 'POST',
        data: excleJson,
        dataType:"JSON",
        success: function (data) {
            CloseLoadWaitDiv();
            if(data.success==true){
                location.href = "/hubei/ExcelDown/fileDown?fName="+data.fileName;
            }else {
                layerInfo(data.msg);
            }
        }
    });
}



function CreateLoadWaitDiv(text) {
    var _html = ' <div  id ="bi-repopt-load" style="position:fixed;  cursor:wait;  width:95%;  background-color: rgba(192, 195, 195, 0.50);' +
        'filter:progid:DXImageTransform.Microsoft.Gradient(startColorstr=#55313131, endColorstr=#55313131);' +
        'height:94%;min-height:94%;  z-index:998910159;top :2.5%;left:2.5%;">' +
        '<div id="bi-repopt-load-memo"  style="position:relative; top:35%; margin:0 auto; ' +
        'width:240px; padding-left:3px; line-height:55px; height:60px;background-color:white; -moz-border-radius: 5px; -webkit-border-radius: 5px; border-radius:5px;">' +
        '<span style="display:inline-block;vertical-align:middle;">' +
        '<img src="/static/img/load.gif" />' +
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