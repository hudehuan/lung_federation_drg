//表单名
$("#fromtitle-h5").html(getQueryStringRegExp('title') + "&nbsp;&nbsp");

//表单ID
//var fromid=getQueryStringRegExp('fromid');

//模板名称  

$("#temtitle-span").html(getQueryStringRegExp('temmc'));

//模板ID
var fromtemid = getQueryStringRegExp('fromtemid');
//模板风格
var pagelx = getQueryStringRegExp('pagelx');





function viewpageprint_btnclick(formId,formTemplateName,templateStyle) {
    var formData = "";
// <%--if('${tempdata.style}'=='B'){--%>

    // <%--}else {--%>
    $("select").each(function (e, item) {
        var id = $(this).attr("id");
        var value = $(this).attr("value");
        if (!value) {
            value = "";
        }
        $(this).after("<span id='" + id + "_span' >"+value+"</spna>");
        $(this).hide();
    });
    if (templateStyle=="A") {
        formData = $("#fromtabfg1_dsndiv").html();
    }else{
        formData = $("#fromtabfg2_dsndiv").html();
    }

    formData = "<div style='width:100%;text-align:center;font-size:20px;margin-bottom:5px;font-family:宋体;font-weight: bold;'>"+formTemplateName+"</div>"+formData
        $("select").each(function (e, item) {
            $(this).next().hide();
            $(this).show();
        });
//            }
//     if(!formData){
//         alert("请先保存页面");
//         return false;
//     }
        var w = window.open();
        $.ajax({
            url:'/CustomFromPrint/toPDF?dataId=&formID='+formId,
            type:'POST',
            dataType:'json',
            data:{"formData":formData},
            async:false,
            error: function(){
                w.close();
            },
            success:function(data){
                if(data.success==true){
                    w.location = data.pdfurl;
                }
                else{
                    layerInfo(data.msg);
                }
            }
        });


}

var dsnselectid = null;

function SetDsnSelectDomCss(id) {
	if($(dsnselectid).attr("id") == id)
		return;

    $(dsnselectid).removeClass("selectdomcss");
	$("#" + id).addClass("selectdomcss");

    dsnselectid = $("#" + id);

    Setdsnselectidopt();

	window.event ? window.event.cancelBubble = true : e.stopPropagation();
}
//以下是 BootStrap排版操作

function boot_addpanelclick() {
	var id = randomChar(20);
	var id1 = randomChar(20);
	var id2 = randomChar(20);
	var id3 = randomChar(20);
	var html = '<div class="panel panel-default boot-container" id="bootpanel_' + id + '" style="margin-top:10px ;">' +
		' <div class="panel-heading boot-panel-heading" id="bootpaneltitle_' + id + '" onclick="SetDsnSelectDomCss(\'bootpanel_' + id + '\')" >新建面板</div>' +
		'  <div class="panel-body boot-panel-body" id="bootpanelbody_' + id + '" onclick="SetDsnSelectDomCss(\'bootpanel_' + id + '\')" >' +
		'   <div id="bootpanelrowdiv_' + id1 + '" onclick="SetDsnSelectDomCss(\'bootpanelrowdiv_' + id1 + '\')">&nbsp;</div>' +
		'   <div id="bootpanelrowdiv_' + id2 + '" onclick="SetDsnSelectDomCss(\'bootpanelrowdiv_' + id2 + '\')">&nbsp;</div>' +
		'   <div id="bootpanelrowdiv_' + id3 + '" onclick="SetDsnSelectDomCss(\'bootpanelrowdiv_' + id3 + '\')">&nbsp;</div>' +
		'</div>' +
		'</div>' +
		'</div>';
	$("#fromtabfg1_dsndiv").append(html);
}

function boot_addpanelrowdivclick() {

	if(dsnselectid == null)
		return;

	var tmp = $(dsnselectid).attr("id").substr(0, 10);

	if(tmp != "bootpanel_") {
		alert("只有主面板、子面板才能增加行区域!");
		return;
	}
	var id = randomChar(20);
	var html = '<div id="bootpanelrowdiv_' + id + '" onclick="SetDsnSelectDomCss(\'bootpanelrowdiv_' + id + '\')">&nbsp;</div>';

    if ($(dsnselectid).attr("id").indexOf("bootpanel_sub_") > -1)
        $("#bootpanel_sub_" + $(dsnselectid).attr("id").substring(14)).append(html);
    else
        $("#bootpanelbody_" + $(dsnselectid).attr("id").substring(10)).append(html);
	//$(dsnselectid).append(html);
}

function boot_addpanelSubclick() {
	if(dsnselectid == null)
		return;
	var tmp = $(dsnselectid).attr("id").substr(0, 10);

	if(tmp != "bootpanel_") {
		alert("只有主面板才能增加子面板!");
		return;
	}
	var id = randomChar(20);
	var id1 = randomChar(20);
	var id2 = randomChar(20);
	var html = '<h6 class="boot-long_tit boot-h6" id="bootpanel_subtitle_' + id + '" onclick="SetDsnSelectDomCss(\'bootpanel_sub_' + id + '\')">我是子面板标题</h6>' +
		'<div class="boot-sanjietit" style="margin-bottom: 6px;" id="bootpanel_sub_' + id + '"  onclick="SetDsnSelectDomCss(\'bootpanel_sub_' + id + '\')">' +
		'<div id="bootpanelrowdiv_' + id1 + '" onclick="SetDsnSelectDomCss(\'bootpanelrowdiv_' + id1 + '\')">&nbsp;</div>' +
		'<div id="bootpanelrowdiv_' + id2 + '" onclick="SetDsnSelectDomCss(\'bootpanelrowdiv_' + id2 + '\')">&nbsp;</div>' +
		'</div>';

	$("#bootpanelbody_" + $(dsnselectid).attr("id").substring(10)).append(html);

}

function boot_addFltitleclick() {
	if(dsnselectid == null)
		return;
	var tmp = $(dsnselectid).attr("id").substr(0, 10);

	if(tmp != "bootpanel_") {
		alert("只有主面板才能增加分类标题!");
		return;
	}
	var id = randomChar(20);
    var html = '<h4 class="boot-h4" id="divvcl_' + id + '" onclick="SetDsnSelectDomCss(\'divvcl_' + id + '\')"><span></span> 我是个分类标题 </h4>';

	$("#bootpanelbody_" + $(dsnselectid).attr("id").substring(10)).append(html);
}

function addtextlabelclick() {
	if(dsnselectid == null)
		return;
   
	var id = randomChar(20);
    var html = ' <div id="divvcl_' + id + '"  class="divvclinput"   ldvcl ="" nodisabled="0"  notrim="0"  noshow="0"  regex="" edtreadonly="0" vclopt="labeltext"  onclick="SetDsnSelectDomCss(\'divvcl_' + id + '\')"><span class="spanlabel" id="spanlabel_' + id
        + '">我是个文字标签</span></div>';
	$(dsnselectid).append(html);
}

//以下是Table排版操作
//table的要拖才能选中


//专用table cell 是否选中 的
var tabletdid = null;

function SetTabledsnbuttonzt(b)
{
    if (b) {
        $("#addtable").attr("disabled", "true");
        $("#addtablerow").attr("disabled", "true");
        
        $("#tablesplit").attr("disabled", "true");
        $("#tablemerge").attr("disabled", "true");


        $("#dsntable *").each(function () {

            
            $(this).removeClass("ui-selected");   
            $(this).removeClass("ui-selecting");               
        });
  
        $("#dsntable").selectable("destroy");         

    }
    else 
        {
        $("#addtable").removeAttr("disabled");
        $("#addtablerow").removeAttr("disabled");
        
        $("#tablesplit").removeAttr("disabled");
        $("#tablemerge").removeAttr("disabled");
        $("#dsntable").selectable();
      
    }   
}

function table_addtableclick() {
 

    if ($("#dsntable").length > 0)
        return;

    var html = '<table class="table-container" id="dsntable" onclick="SetDsnSelectDomCss(\'dsntable\')">' ;

	for (var i=0;i<=30 ;i++)
	{	
		html+=' <tr>' ;
		for (var j=0;j<=35 ;j++) //36*20 =720px左右的宽度
		{
          
            var id1 = randomChar(20);
            html += ' <td id="tabletd_' + id1 + '" onclick="SetDsnSelectDomCss(\'tabletd_' + id1 + '\')"  valign="center"></td>';
		}
		html+=' </tr>' ;
	} 	
		html+='</table>';
	$("#fromtabfg2_dsndiv").append(html);
    $("#dsntable").selectable();

   
	// setTimeout($("#tablepanel_"+id).Selectable(),500);

}

function table_Mergeclick() {
	
	

	var $t = $("#dsntable");

	if($("table", $t).length > 0) {
		alert("不支持嵌套表格！");
		return;
	}

	var sigDel = "sign4delete"; // 删除标记，用作类名
	var sigSel = "ui-selected"; // 选中标记，用作类名

	// 补充单元格以便后继正确计算坐标
	$("th,td", $t).each(function() {
		// 坐标要实时计算，因会实时补充
		var ridx = $("tr", $t).index($(this).parent("tr"));
		var cidx = $(this).parent().children("th,td").index(this);
		var rowspan = Number($(this).attr("rowspan")) || 1;
		var colspan = Number($(this).attr("colspan")) || 1;
		var isSel = $(this).hasClass(sigSel);
		// 非选单元格拆出的单元格要加删除标记

		if(rowspan <= 1 && colspan <= 1)
			return;
		// 跨格开插
		$("tr", $t).each(function() {
			var idx = $("tr", $t).index(this);
			var arr, $td = $("<td>").addClass(isSel ? sigSel : sigDel);

			if(idx == ridx) {
				// 本行在 [cidx] 后插入 colspan-1 个

				arr = $(); // 准备待插单元格
				for(var i = 0; i < colspan - 1; i++)
					arr = arr.add($td.clone());
				// 插入
				$("th,td", this).eq(cidx).after(arr);

			} else if(ridx < idx && idx < ridx + rowspan) {
				// 以下行在 [cidx] 前插入 colspan 个

				arr = $(); // 准备待插单元格
				for(var i = 0; i < colspan; i++)
					arr = arr.add($td.clone());
				// 插入
				if(cidx > 0 && $("th,td", this).eq(cidx - 1).length > 0)
					$("th,td", this).eq(cidx - 1).after(arr);
				else if($("th,td", this).eq(cidx).length > 0)
					$("th,td", this).eq(cidx).before(arr);
				else
					$(this).prepend(arr);
			}
		});
	});

	var rmin = 10000,
		cmin = 10000;
	var rmax = 0,
		cmax = 0;
	var rnum, cnum;
	// 计算起始和跨距
	$("th,td", $t).filter("." + sigSel).each(function() {
		var ridx = $("tr", $t).index($(this).parent("tr"));
		rmin = ridx < rmin ? ridx : rmin;
		rmax = ridx > rmax ? ridx : rmax;
		var cidx = $(this).parent().children("th,td").index(this);
		cmin = cidx < cmin ? cidx : cmin;
		cmax = cidx > cmax ? cidx : cmax;
	});
	rnum = rmax - rmin + 1;
	cnum = cmax - cmin + 1;

	// 合并单元格
	$("th,td", $t).each(function() {
		var ridx = $("tr", $t).index($(this).parent("tr"));
		var cidx = $(this).parent().children("th,td").index(this);
		// 标记单元格待删
		if(rmin <= ridx && ridx <= rmax &&
			cmin <= cidx && cidx <= cmax)
			$(this).addClass(sigDel);
		// 处理被选左上角单元格
		if(ridx == rmin && cidx == cmin)
			$(this).removeClass(sigDel).attr({ rowspan: rnum, colspan: cnum });
		// 清理残余
		if($(this).attr("rowspan") == 1) $(this).removeAttr("rowspan");
		if($(this).attr("colspan") == 1) $(this).removeAttr("colspan");
	}).remove("." + sigDel);
	// 移除标记单元格
}

function table_Splitclick() {

     var $t = $("#dsntable");

	var sigDel = "sign4delete"; // 删除标记，类名，自定义
	var sigSel = "ui-selected"; // 选中标记，类名，jQuery UI 定义

	// 补充单元格以便后继正确计算坐标

	$("th,td", $t).each(function() {
		// 坐标要实时计算，因会实时补充
		var ridx = $("tr", $t).index($(this).parent("tr"));
		var cidx = $(this).parent().children("th,td").index(this);
		var rowspan = Number($(this).attr("rowspan")) || 1;
		var colspan = Number($(this).attr("colspan")) || 1;
		var isSel = $(this).hasClass(sigSel);
		// 非选单元格拆出的单元格要加删除标记

		if(rowspan <= 1 && colspan <= 1)
			return;

		if(isSel)
			$(this).removeAttr("colspan").removeAttr("rowspan");

		// 跨格开插
		$("tr", $t).each(function() {
			var idx = $("tr", $t).index(this);
			var arr, $td = $("<td>");

			if(!isSel)
				$td.addClass(sigDel);

			if(idx == ridx) {
				// 本行在 [cidx] 后插入 colspan-1 个

				arr = $(); // 准备待插单元格				
				for(var i = 0; i < colspan - 1; i++)
					arr = arr.add($td.clone());

				$("th,td", this).eq(cidx).after(arr);

			} else if(ridx < idx && idx < ridx + rowspan) {
				// 以下行在 [cidx] 前插入 colspan 个

				arr = $(); // 准备待插单元格
				for(var i = 0; i < colspan; i++)
					arr = arr.add($td.clone());

				if(cidx > 0 && $("th,td", this).eq(cidx - 1).length > 0)
					$("th,td", this).eq(cidx - 1).after(arr);
				else if($("th,td", this).eq(cidx).length > 0)
					$("th,td", this).eq(cidx).before(arr);
				else
					$(this).prepend(arr);
			}
		});
	});
	// 重新获取以取到删者并删之
	$("th,td", $t).remove("." + sigDel);
	
		$("td", $t).each(function() {
			if ($(this).attr("id")==null ||$(this).attr("id")==undefined)
			{
			  var id1 = randomChar(20);
              $(this).attr("id", "tabletd_" + id1);
              $(this).attr("valign", "center");
              $(this).attr("onclick","SetDsnSelectDomCss('tabletd_" +id1+"')");
			}
		});

}

function table_addrowclick()
{
    var html = '<tr>';
    for (var j = 0; j <= 35; j++) //36*20 =720px左右的宽度
    {
        var id1 = randomChar(20);
        html += ' <td id="tabletd_' + id1 + '" onclick="SetDsnSelectDomCss(\'tabletd_' + id1 + '\')"></td>';
    }
    html += ' </tr>';
$("#dsntable").append(html);	
}

function table_deltablerowclick() {

    if (dsnselectid == null)
        return;
    var tmp = $(dsnselectid).attr("id").substr(0, 8);

    if (tmp != "tabletd_") {      
        return;
    }

    if (!confirm("确认删除选中单元格当前行? 相应的控件都会删除"))
        return;

    $(dsnselectid).parent().remove();
    dsnselectid = null;
 
}



//Grid相关选中
function CreateVcl(id)
{
  
    if (dsnselectid == null)
        return;
    var tmp = $(dsnselectid).attr("id").split("_")[0];

    //bootpanelrowdiv_
    if (tmp != "tabletd" && tmp != "bootpanelrowdiv") {
        return;
    }

    var vcllx = mygridjh.cells(id, 1).getValue();
    var fcode = mygridjh.cells(id, 3).getValue();
    var fmc = mygridjh.cells(id, 0).getValue();
  

    if ($("#divvcl_" + fcode).length > 0) {
        SetDsnSelectDomCss("divvcl_" + fcode);
        return;
    }
    switch (vcllx) {
        case "日期控件":
            CreateVcl_date(id,fcode,fmc);
            break
        case "日期时间控件":
            CreateVcl_datetime(id,fcode,fmc);
            break;
        case "年月控件":
            CreateVcl_yearmonth(id,fcode,fmc);
            break;
        case "年控件":
            CreateVcl_year(id,fcode,fmc);
            break;
        case "字典SQL表格控件":
            //缺js
            CreateVcl_sqlgrid(id,fcode,fmc);
            break;
        case "PID0SQL树控件":
            //缺js
            CreateVcl_pidtree(id,fcode,fmc);
            break;
        case "LENSQL树控件":
            //缺js
            CreateVcl_lentree(id,fcode,fmc);
            break;
        case "字典SQL下拉控件":
            CreateVcl_sqlselect(id,fcode,fmc);
            break;
        case "对应值下拉控件":
            CreateVcl_keyselect(id,fcode,fmc);
            break;
        case "文本控件":
            CreateVcl_text(id,fcode,fmc);
            break;
        case "多选控件":
            CreateVcl_checkbox(id, fcode, fmc);
            break;
        case "1列多选控件":
            CreateVcl_onecheckbox(id,fcode,fmc);
            break;
        case "2列多选控件":
            CreateVcl_twocheckbox(id,fcode,fmc);
            break;
        case "3列多选控件":
            CreateVcl_threecheckbox(id,fcode,fmc);
            break;
        case "4列多选控件": 
            CreateVcl_fourcheckbox(id,fcode,fmc);
            break;
        case "单选控件":
            CreateVcl_radio(id, fcode, fmc);
            break;
        case "1列单选控件":
            CreateVcl_oneradio(id,fcode,fmc);
            break;
        case "2列单选控件":
            CreateVcl_tworadio(id,fcode,fmc);
            break;
        case "3列单选控件":
            CreateVcl_threeadio(id,fcode,fmc);
            break;
        case "4列单选控件":
            CreateVcl_fouradio(id,fcode,fmc);
            break;
        case "数字控件":
            CreateVcl_num(id,fcode,fmc);
            break;
        case "多行文本控件":
            CreateVcl_textarea(id,fcode,fmc);
            break;
    }
}
function SelectVcl(id) {
    var fcode = mygridjh.cells(id, 3).getValue();
    if ($("#divvcl_" + fcode).length > 0) {
        SetDsnSelectDomCss("divvcl_" + fcode);
    }
}


//控件创建
//<option>日期控件</option>
function CreateVcl_date(id, fcode, fmc) {

    var html = '<div id="divvcl_' + fcode + '" class="divvclinput"  ldvcl ="" nodisabled="0"  ldvcl ="" nodisabled="0"  notrim="0"  noshow="0"  regex="" edtreadonly="0" vclopt="date"  onclick="SetDsnSelectDomCss(\'divvcl_' + fcode + '\')"><span class="spanlabel" id ="spanlabel_' + fcode
        + '">' + fmc +'</span><input type="text"  style="width: 90px;display: inline-block;"  class="Wdate form-control input-sm " id="' + fcode + '" onclick="WdatePicker({dateFmt:&quot;yyyy-MM-dd&quot;})" /></div>';

    $(dsnselectid).append(html);
}
//    <option>日期时间控件</option>
function CreateVcl_datetime(id, fcode, fmc) {

    var html = '<div id="divvcl_' + fcode + '" class="divvclinput"   ldvcl ="" nodisabled="0"  notrim="0"  noshow="0"  regex="" edtreadonly="0" vclopt="datetime"  onclick="SetDsnSelectDomCss(\'divvcl_' + fcode + '\')"><span class="spanlabel" id ="spanlabel_' + fcode
        + '">' + fmc + '</span><input type="text" style="width: 114px;display: inline-block;"  class="form-control input-sm Wdate" id="' + fcode + '" onclick="WdatePicker({dateFmt:&quot;yyyy-MM-dd HH:mm&quot;})" /></div>';

    $(dsnselectid).append(html);
}
//    <option>年月控件</option>
function CreateVcl_yearmonth(id, fcode, fmc) {

    var html = '<div id="divvcl_' + fcode + '" class="divvclinput"   ldvcl ="" nodisabled="0"  notrim="0"  noshow="0"  regex="" edtreadonly="0" vclopt="yearmonth"  onclick="SetDsnSelectDomCss(\'divvcl_' + fcode + '\')"><span class="spanlabel" id ="spanlabel_' + fcode
        + '">' + fmc + '</span><input type="text" style="width: 90px;   display: inline-block;"  class="form-control input-sm Wdate" id="' + fcode + '" onclick="WdatePicker({dateFmt:&quot;yyyy-MM&quot;})" /></div>';

    $(dsnselectid).append(html);
}
//    <option>年控件</option>
function CreateVcl_year(id, fcode, fmc) {
    var html = '<div id="divvcl_' + fcode + '" class="divvclinput"   ldvcl ="" nodisabled="0"  notrim="0"  noshow="0"  regex="" edtreadonly="0" vclopt="year"  onclick="SetDsnSelectDomCss(\'divvcl_' + fcode + '\')"><span class="spanlabel" id ="spanlabel_' + fcode
        + '">' + fmc + '</span><input type="text" style="width:90px; display: inline-block;"  class="form-control input-sm Wdate" id="' + fcode + '" onclick="WdatePicker({dateFmt:&quot;yyyy&quot;})" /></div>';

    $(dsnselectid).append(html);
}
//    <option>字典SQL表格控件</option>
function CreateVcl_sqlgrid(id, fcode, fmc) {//得到
    var html = '<div id="divvcl_' + fcode + '" class="divvclinput"   ldvcl ="" nodisabled="0"  notrim="0"  noshow="0"  regex="" edtreadonly="0" vclopt="sqlgrid"  onclick="SetDsnSelectDomCss(\'divvcl_' + fcode + '\')"><span class="spanlabel" id ="spanlabel_' + fcode
        + '">' + fmc + '</span><input type="hidden"  id="'+fcode+'"/><input type="text"  style="background-color: #fff;width:144px; display: inline-block;" ' +
        ' class="form-control input-sm "  id="' + fcode + '_wmc" /></div>';
    $(dsnselectid).append(html);
}
// //    <option>PID0SQL树控件</option>
// function CreateVcl_pidtree(id, fcode, fmc) {
//     var html = '<div id="divvcl_' + fcode + '" class="divvclinput"   ldvcl ="" nodisabled="0"  notrim="0"  noshow="0"  regex="" edtreadonly="0" vclopt="pidtree"  onclick="SetDsnSelectDomCss(\'divvcl_' + fcode + '\')"><span class="spanlabel" id ="spanlabel_' + fcode
//         + '">' + fmc + '</span><input type="text"  style="background-color: #fff; width:144px; display: inline-block;"  class="form-control input-sm " readonly   id="' + fcode + '" /></div>';
//     $(dsnselectid).append(html);
// }
// //    <option>LENSQL树控件</option>
// function CreateVcl_lentree(id, fcode, fmc) {
//     var html = '<div id="divvcl_' + fcode + '" class="divvclinput"   ldvcl ="" nodisabled="0"  notrim="0"  noshow="0"  regex="" edtreadonly="0" vclopt="lentree"  onclick="SetDsnSelectDomCss(\'divvcl_' + fcode + '\')"><span class="spanlabel" id ="spanlabel_' + fcode
//         + '">' + fmc + '</span><input type="text"  style="background-color: #fff; width:144px; display: inline-block;" class="form-control input-sm " readonly id="' + fcode + '" /></div>';
//     $(dsnselectid).append(html);
// }
//    <option>字典SQL下拉控件</option>

function CreateVcl_sqlselect(id, fcode, fmc) {
    var html = '<div id="divvcl_' + fcode + '" class="divvclinput"   ldvcl ="" nodisabled="0"  notrim="0"  noshow="0"  regex="" edtreadonly="0" vclopt="sqlselect"  onclick="SetDsnSelectDomCss(\'divvcl_' + fcode + '\')"><span class="spanlabel" id ="spanlabel_' + fcode
        + '">' + fmc + '</span><select   id="' + fcode + '" ><option>选项一</option><option>选项二</option><option>选项三</option></select></div>';

    $(dsnselectid).append(html);
}
//    <option>对应值下拉控件</option>
function CreateVcl_keyselect(id, fcode, fmc) {
    var html = '<div id="divvcl_' + fcode + '" class="divvclinput"   ldvcl ="" nodisabled="0"  notrim="0"  noshow="0"  regex="" edtreadonly="0" vclopt="keyselect"  onclick="SetDsnSelectDomCss(\'divvcl_' + fcode + '\')"><span class="spanlabel" id ="spanlabel_' + fcode
        + '">' + fmc + '</span><select  id="' + fcode + '" ><option>选项一</option><option>选项二</option><option>选项三</option></select></div>';

    $(dsnselectid).append(html);
}
//    <option>文本控件</option>

function CreateVcl_text(id, fcode, fmc) {

    var html = '<div id="divvcl_' + fcode + '" class="divvclinput"   ldvcl ="" nodisabled="0"  notrim="0"  noshow="0"  regex="" edtreadonly="0" vclopt="text"  onclick="SetDsnSelectDomCss(\'divvcl_' + fcode + '\')"><span class="spanlabel" id ="spanlabel_' + fcode
        + '">' + fmc + '</span><input type="text"  style="width:144px; display: inline-block;" class="form-control input-sm " id="' + fcode + '" /></div>';
    $(dsnselectid).append(html);
}
    //    <option>多选控件</option>
function CreateVcl_checkbox(id, fcode, fmc) {
    var html = '<div id="divvcl_' + fcode + '" class="divvclinput_che_radio"    ldvcl ="" nodisabled="0"  notrim="0"  noshow="0"  regex="" edtreadonly="0" vclopt="checkbox"  onclick="SetDsnSelectDomCss(\'divvcl_' + fcode + '\')"><span class="spanlabel" id ="spanlabel_' + fcode
        + '">&nbsp;' + fmc + '</span>';
    for (var i = 1; i < 6; i++) {
        html += '<span class="span_che_radio" >';
        html += '<input type="checkbox" id="' + fcode + '_che' + i.toString() + '" name="' + fcode + '" value="'+i.toString()+'"/> <label for="' + fcode + '_che' + i.toString() + '">选项[' + i.toString() + ']</label>';
        html += '</span>';
    }

    html += '</div>';
    if ($(dsnselectid).html()  == "&nbsp;")
        $(dsnselectid).html(html);
    else
        $(dsnselectid).append(html);
}
//    <option>1列多选控件</option>
function CreateVcl_onecheckbox(id, fcode, fmc) {
    var html = '<div id="divvcl_' + fcode + '" class="divvclinput_che_radio"     ldvcl ="" nodisabled="0"  notrim="0"  noshow="0"  regex="" edtreadonly="0" vclopt="twocheckbox"  onclick="SetDsnSelectDomCss(\'divvcl_' + fcode + '\')"><div><span class="spanlabel" id ="spanlabel_' + fcode
        + '">&nbsp;' + fmc + '</span></div>';
    for (var i = 1; i < 6; i++) {
        html += '<div class="div_che_radio" >';   
        html += '<input type="checkbox" id="' + fcode + '_che' + i.toString() + '" name="' + fcode + '" value="'+i.toString()+'"/> <label for="' + fcode + '_che"' + i.toString()+ '>选项[' + i.toString() + ']</label>';
        html += '</div>';
    }    

    if ($(dsnselectid).html() == "&nbsp;")
        $(dsnselectid).html() (html);
    else
        $(dsnselectid).append(html);
}
//    <option>2列多选控件</option>
function CreateVcl_twocheckbox(id, fcode, fmc) {
    var html = '<div id="divvcl_' + fcode + '" class="divvclinput_che_radio"     ldvcl ="" nodisabled="0"  notrim="0"  noshow="0"  regex="" edtreadonly="0" vclopt="twocheckbox"  onclick="SetDsnSelectDomCss(\'divvcl_' + fcode + '\')"><div><span class="spanlabel" id ="spanlabel_' + fcode
        + '">&nbsp;' + fmc + '</span></div>';
    var k = 0;
        for (var i = 1; i < 6; i++)
        {
            html += '<div class="div_che_radio">';
            for (var j = 1; j < 3; j++)
            {
                html += '<span class="div_che_radio_spanwidth2"><input type="checkbox" id="' + fcode + '_che' + k.toString() + '" name="' + fcode + '" value="'+i.toString()+'"/><label for="' + fcode + '_che' + k.toString() + '">选项[' + k.toString() + ']</label></span>';
                k++;
            }
            html += '</div >';
        }
    
        html += '<div style="clear: both;font-size: 1px;height: 1px;">&nbsp</div></div>';
        if ($(dsnselectid).html()  == "&nbsp;")
            $(dsnselectid).html(html);
        else
            $(dsnselectid).append(html);
}
//    <option>3列多选控件</option>
function CreateVcl_threecheckbox(id, fcode, fmc) {
    var html = '<div id="divvcl_' + fcode + '" class="divvclinput_che_radio"     ldvcl ="" nodisabled="0"  notrim="0"  noshow="0"  regex="" edtreadonly="0" vclopt="threecheckbox"  onclick="SetDsnSelectDomCss(\'divvcl_' + fcode + '\')"><div><span class="spanlabel" id ="spanlabel_' + fcode
        + '">&nbsp;' + fmc + '</span></div>';
    var k = 0;
    for (var i = 1; i < 6; i++) {
        html += '<div class="div_che_radio" >';
        for (var j = 1; j < 4; j++) {
            html += '<span class="div_che_radio_spanwidth3"><input type="checkbox" id="' + fcode + '_che' + k.toString() + '" name="' + fcode + '" value="'+i.toString()+'"/><label for="' + fcode + '_che' + k.toString() + '">选项[' + k.toString() + ']</label></span>';
            k++;
        }
        html += '</div >';
    }

    html += '<div style="clear: both;font-size: 1px;height: 1px;">&nbsp</div></div>';
    if ($(dsnselectid).html()  == "&nbsp;")
        $(dsnselectid).html(html);
    else
        $(dsnselectid).append(html);
}
//    <option>4列多选控件</option>
function CreateVcl_fourcheckbox(id, fcode, fmc) {
    var html = '<div id="divvcl_' + fcode + '" class="divvclinput_che_radio"   ldvcl ="" nodisabled="0"  notrim="0"  noshow="0"  regex="" edtreadonly="0" vclopt="fourcheckbox"  onclick="SetDsnSelectDomCss(\'divvcl_' + fcode + '\')"><div><span class="spanlabel" id ="spanlabel_' + fcode
        + '">&nbsp;' + fmc + '</span></div>';
    var k = 0;
    for (var i = 1; i < 6; i++) {
        html += '<div class="div_che_radio" >';
        for (var j = 1; j < 5; j++) {
            html += '<span class="div_che_radio_spanwidth4"><input type="checkbox" id="' + fcode + '_che' +k.toString() + '" name="' + fcode + '" value="'+i.toString()+'"/> <label for="' + fcode + '_che' + k.toString() + '">选项[' + k.toString() + ']</label></span>';
            k++;
        }
        html += '</div >';
    }

    html += '<div style="clear: both;font-size: 1px;height: 1px;">&nbsp</div></div>';
    if ($(dsnselectid).html()  == "&nbsp;")
        $(dsnselectid).html(html);
    else
        $(dsnselectid).append(html);
}
//    <option>单选控件</option>
function CreateVcl_radio(id, fcode, fmc) {
    var html = '<div id="divvcl_' + fcode + '" class="divvclinput_che_radio"    ldvcl ="" nodisabled="0"  notrim="0"  noshow="0"  regex="" edtreadonly="0" vclopt="checkbox"  onclick="SetDsnSelectDomCss(\'divvcl_' + fcode + '\')"><span class="spanlabel" id ="spanlabel_' + fcode
        + '">&nbsp;' + fmc + '</span>';
    for (var i = 1; i < 6; i++) {
        html += '<span class="span_che_radio" >';
        html += '<input type="radio" id="' + fcode + '_che' + i.toString() + '" name="' + fcode + '" value="'+i.toString()+'"/> <label for="' + fcode + '_che"' + i.toString() + '>选项[' + i.toString() + ']</label>';
        html += '</span>';
    }

    html += '</div>';
    if ($(dsnselectid).html()  == "&nbsp;")
        $(dsnselectid).html(html);
    else
        $(dsnselectid).append(html);
}
//    <option>1列单选控件</option>
function CreateVcl_oneradio(id, fcode, fmc) {
    var html = '<div id="divvcl_' + fcode + '" class="divvclinput_che_radio"     ldvcl ="" nodisabled="0"  notrim="0"  noshow="0"  regex="" edtreadonly="0" vclopt="twocheckbox"  onclick="SetDsnSelectDomCss(\'divvcl_' + fcode + '\')"><div><span class="spanlabel" id ="spanlabel_' + fcode
        + '">&nbsp;' + fmc + '</span></div>';
    for (var i = 1; i < 6; i++) {
        html += '<div class="div_che_radio" >';
        html += '<input type="radio" id="' + fcode + '_che' + i.toString() + '" name="' + fcode + '" value="'+i.toString()+'"/> <label for="' + fcode + '_che"' + i.toString() + '>选项[' + i.toString() + ']</label>';
        html += '</div>';
    }
    if ($(dsnselectid).html() == "&nbsp;")
        $(dsnselectid).html(html);
    else
        $(dsnselectid).append(html);
}
//    <option>2列单选控件</option>
function CreateVcl_tworadio(id, fcode, fmc) {
    var html = '<div id="divvcl_' + fcode + '" class="divvclinput_che_radio"     ldvcl ="" nodisabled="0"  notrim="0"  noshow="0"  regex="" edtreadonly="0" vclopt="twocheckbox"  onclick="SetDsnSelectDomCss(\'divvcl_' + fcode + '\')"><div><span class="spanlabel" id ="spanlabel_' + fcode
        + '">&nbsp;' + fmc + '</span></div>';
    var k = 0;
    for (var i = 1; i < 6; i++) {
        html += '<div class="div_che_radio">';
        for (var j = 1; j < 3; j++) {
            html += '<span class="div_che_radio_spanwidth2"><input type="radio" id="' + fcode + '_che' + k.toString() + '" name="' + fcode + '" value="'+i.toString()+'"/> <label for="' + fcode + '_che' + k.toString() + '">选项[' + k.toString() + ']</label></span>';
            k++;
        }
        html += '</div >';
    }

    html += '<div style="clear: both;font-size: 1px;height: 1px;">&nbsp</div></div>';
    if ($(dsnselectid).html()  == "&nbsp;")
        $(dsnselectid).html(html);
    else
        $(dsnselectid).append(html);

}
//    <option>3列单选控件</option>
function CreateVcl_threeadio(id, fcode, fmc) {
    var html = '<div id="divvcl_' + fcode + '" class="divvclinput_che_radio"     ldvcl ="" nodisabled="0"  notrim="0"  noshow="0"  regex="" edtreadonly="0" vclopt="twocheckbox"  onclick="SetDsnSelectDomCss(\'divvcl_' + fcode + '\')"><div><span class="spanlabel" id ="spanlabel_' + fcode
        + '">&nbsp;' + fmc + '</span></div>';
    var k = 0;
    for (var i = 1; i < 6; i++) {
        html += '<div class="div_che_radio">';
        for (var j = 1; j < 4; j++) {
            html += '<span class="div_che_radio_spanwidth3"><input type="radio" id="' + fcode + '_che' + k.toString() + '" name="' + fcode + '" value="'+i.toString()+'"/> <label for="' + fcode + '_che' + k.toString() + '">选项[' + k.toString() + ']</label></span>';
            k++;
        }
        html += '</div >';
    }

    html += '<div style="clear: both;font-size: 1px;height: 1px;">&nbsp</div></div>';
    if ($(dsnselectid).html()  == "&nbsp;")
        $(dsnselectid).html(html);
    else
        $(dsnselectid).append(html);
}
//    <option>4列单选控件</option>
function CreateVcl_fouradio(id, fcode, fmc) {
    var html = '<div id="divvcl_' + fcode + '" class="divvclinput_che_radio"     ldvcl ="" nodisabled="0"  notrim="0"  noshow="0"  regex="" edtreadonly="0" vclopt="twocheckbox"  onclick="SetDsnSelectDomCss(\'divvcl_' + fcode + '\')"><div><span class="spanlabel" id ="spanlabel_' + fcode
        + '">&nbsp;' + fmc + '</span></div>';
    var k = 0;
    for (var i = 1; i < 6; i++) {
        html += '<div class="div_che_radio">';
        for (var j = 1; j < 5; j++) {
            html += '<span class="div_che_radio_spanwidth4"><input type="radio" id="' + fcode + '_che' + k.toString() + '" name="' + fcode + '" value="'+i.toString()+'"/> <label for="' + fcode + '_che' + k.toString()  + '">选项[' + k.toString() + ']</label></span>';
            k++;
        }
        html += '</div >';
    }

    html += '<div style="clear: both;font-size: 1px;height: 1px;">&nbsp</div></div>';
    if ($(dsnselectid).html()  == "&nbsp;")
        $(dsnselectid).html(html);
    else
        $(dsnselectid).append(html);
}
//    <option>数字控件</option>
function CreateVcl_num(id, fcode, fmc) {
    var html = '<div id="divvcl_' + fcode + '" class="divvclinput"   ldvcl ="" nodisabled="0"  notrim="0" regex="" noshow="0"  edtreadonly="0" vclopt="text"  onclick="SetDsnSelectDomCss(\'divvcl_' + fcode + '\')"><span class="spanlabel" id ="spanlabel_' + fcode
        + '">' + fmc + '</span> <input type="text" style="width:90px; display: inline-block;" class="form-control input-sm " id="' + fcode + '"  onkeydown="DigitInput()" /></div>';
    $(dsnselectid).append(html);
}
//    <option>多行文本控件</option>  
function CreateVcl_textarea(id, fcode, fmc) {
    var html = '<div id="divvcl_' + fcode + '"     ldvcl ="" nodisabled="0"  notrim="0"  regex="" edtreadonly="0"  noshow="0"  vclopt="textarea"  onclick="SetDsnSelectDomCss(\'divvcl_' + fcode + '\')"><span   class="spanlabel" id="spanlabel_' + fcode
        + '">' + fmc + '</span><textarea  style="overflow:hidden;height:100px;"  rows="5" class="form-control input-sm "  id="' + fcode + '" ></textarea>'+
     '</div> ';
    $(dsnselectid).append(html);
    //html = '<script type="text/javascript">' +
    //    'var text' + fcode + ' = document.getElementById("' + fcode + '"); HFautoTextarea(text' + fcode + ');' +
    //    '</script>';

    //$('#divvcl_' + fcode).append(html);

}

function delpaneldiv_btnclick()
{
    if (dsnselectid == null)
        return;
    var tmp = $(dsnselectid).attr("id").split("_")[0];

    if (tmp != "bootpanel" && tmp != "bootpanelrowdiv"   ) {
        alert("只有主面板、子面板、行 才能删除!");
        return;
    }
    if (!confirm("确定删除区域?相关的控件都会删除!!!!"))
        return;
   
    $(dsnselectid).remove();
    //bootpanelrowdiv_
    dsnselectid = null;
}

function delvcldiv_btnclick() {
    if (dsnselectid == null)
        return;
    var tmp = $(dsnselectid).attr("id").split("_")[0];

    if (tmp != "divvcl") {       
        return;
    }
    if (!confirm("确定删除的控件?"))
        return;

    $(dsnselectid).remove();

    dsnselectid = null;
}
function Setdsnselectidopt()
{
    if (dsnselectid == null)
        return;
    var tmp = $(dsnselectid).attr("id").split("_")[0];

    if (tmp != "divvcl") {
        opttabclick('opttab3');  
     
        SetPanelDivOpt();
    }
    else
    {
        opttabclick('opttab2');    
    
        SetDsnVclOpt();
        //读取控件值
        //数据库获取SQL及JS
        GetdsnVclData();
    }
}


function refreshdivvcl_btnclick()
{

    var str = $(dsnselectid).attr("id").split("_")[0];
    str = $(dsnselectid).attr("id").replace(str+"_","");
    $("#" + str).width($("#divvclwidth").val());
    $("#" + str).height($("#divvclheight").val());
    $("#spanlabel_" + str).html($("#divvcltitle").val().replace("[隐]",""));
    $(dsnselectid).attr("regex", $("#divvclregex").val());
    $("#spanlabel_" + str).width($("#divvcltitlewidth").val());
    $(dsnselectid).attr("vcldefault", $("#divvcldefault").val());
    $(dsnselectid).attr("edtreadonly", $("#divvcledtreadonly").prop("checked") ? "1" : "0");
    $(dsnselectid).attr("ldvcl", $("#dsnvclld").val());

    if ($("#divvclnoshow").prop("checked"))
    {
        $(dsnselectid).attr("noshow", "1");
        
        $("#spanlabel_" + str).html($("#divvcltitle").val()+"[隐]");
    }
    else
    {
        $(dsnselectid).attr("noshow","0");

    }

    if ($("#divvclnodisabled").prop("checked"))
    {
        $(dsnselectid).attr("nodisabled", "1");
        $("#spanlabel_" + str).html($("#divvcltitle").val());
    }
    else
    {
        $(dsnselectid).attr("nodisabled","0");
    }


    if ($("#divvclnotrim").prop("checked")) {
        if ($('#spannotrim_' + str).length <=0)
            $(dsnselectid).append('<span style="color:red" id="spannotrim_' + str + '" >*</span>');

        $(dsnselectid).attr("notrim", "1");       
    }
    else {
        $(dsnselectid).attr("notrim", "0");
        if ($('#spannotrim_' + str).length >0)
        $('#spannotrim_'+str).remove();
    }
 

    if ($("#divvcltitlebold").prop("checked"))
        $("#spanlabel_" + str).css("font-weight","bold");
    else
        $("#spanlabel_" + str).css("font-weight", "initial");

    if ($("#spanlabel_" + str).text()==""){
        $("#spanlabel_" + str).css("display","none");
    }else{
        $("#spanlabel_" + str).css("display","");
    }
    if($(".spanlabel").text()==""){
        $(".spanlabel").css("margin-right","0");
    }else{
        $(".spanlabel").css("margin-right","5px");
    }

}
function SetDsnVclOpt()
{
    var str = $(dsnselectid).attr("id").split("_")[0];
    str = $(dsnselectid).attr("id").replace(str+"_","");
    $("#vcldivid").val(str);
    $("#divvclwidth").val($("#" + str).width());
    $("#divvclheight").val($("#" + str).height());

    $("#divvcltitle").val($("#spanlabel_" + str).text());
    $("#divvcldefault").val($(dsnselectid).attr("vcldefault"));
    $("#dsnvclld").val($(dsnselectid).attr("ldvcl"));

    $("#divvclregex").val($(dsnselectid).attr("regex"));

    $("#divvcltitlewidth").val($("#spanlabel_" + str).width());
    
    if ($(dsnselectid).attr("notrim") == "0")
        $("#divvclnotrim").prop("checked", false);
    else
        $("#divvclnotrim").prop("checked", true);

    if ($(dsnselectid).attr("nodisabled") == "0")
        $("#divvclnodisabled").prop("checked", false);
    else
        $("#divvclnodisabled").prop("checked", true);

    if ($(dsnselectid).attr("edtreadonly") == "0")
        $("#divvcledtreadonly").prop("checked", false);
    else
        $("#divvcledtreadonly").prop("checked", true); 

    if ($(dsnselectid).attr("noshow") == "0")
        $("#divvclnoshow").prop("checked", false);
    else
        $("#divvclnoshow").prop("checked", true); 

    $("#divvclregex").val($(dsnselectid).attr("regex"));
    $("#divvcltype").val($(dsnselectid).attr("vclopt"));

    //加粗
    if ($("#spanlabel_" + str).css("font-weight") == "initial")
        $("#divvcltitlebold").prop("checked", false); 
    else
        $("#divvcltitlebold").prop("checked", true);     
}
function SetPanelDivOpt() {
    $("#paneldivid").val($(dsnselectid).attr("id"));
 
    $("#paneldivwidth").val($(dsnselectid).width());
    $("#paneldivheight").val($(dsnselectid).height());


    $("#panelopttitlecenter").prop("checked", false); 

    var tmp = $(dsnselectid).attr("id").split("_")[0];
    $("#divopt_span_paneltitle").hide();
    $("#divopt_paneltitle").hide();
    $("#divopt_span_noborder").hide();
    $("#divopt_ttitlecenter").hide();
    $("#divopt_titlememo").show();

    if (tmp == "bootpanel") {
        $("#divopt_paneltitle").show();
        $("#divopt_span_paneltitle").show();

       // $("#divopt_titlememo").show();
        if ($(dsnselectid).attr("id").indexOf("bootpanel_sub_") > -1) {

            if ($("#bootpanel_subtitle_" + $(dsnselectid).attr("id").substring(14)).is(':hidden')) {
                $("#paneloptnotitle").prop("checked", true);
            }
            else
                $("#paneloptnotitle").prop("checked", false);

            $("#paneltitlememo").val($("#bootpanel_subtitle_" + $(dsnselectid).attr("id").substring(14)).text());
        }
        else {
            $("#divopt_span_noborder").show();
            $("#paneltitlememo").val($("#bootpaneltitle_" + $(dsnselectid).attr("id").substring(10)).text());
            if ($("#bootpaneltitle_" + $(dsnselectid).attr("id").substring(10)).is(':hidden'))
                $("#paneloptnotitle").prop("checked", true);
            else
                $("#paneloptnotitle").prop("checked", false);


            if ($(dsnselectid).hasClass("panel"))
                $("#paneloptnoborder").prop("checked", false);
            else
                $("#paneloptnoborder").prop("checked", true);
        }
    }
    else if (tmp == "tabletd") {

        if ($(dsnselectid).children().length  == 0) {
            $("#divopt_ttitlecenter").show();

            $("#paneltitlememo").val($(dsnselectid).html());
        }
            if ($(dsnselectid).attr("valign") == "center")
                $("#panelopttitlecenter").prop("checked", true);
            else
                $("#panelopttitlecenter").prop("checked", false);

        }
  
    //$("#paneloptnotitle").prop("checked", );
}

function refreshpaneldiv_btnclick()
{
    if (dsnselectid == null)
        return;

    var tmp = $(dsnselectid).attr("id").split("_")[0];
    if (tmp == "bootpanel") {
        if ($(dsnselectid).attr("id").indexOf("bootpanel_sub_") > -1) {
            $("#bootpanel_subtitle_" + $(dsnselectid).attr("id").substring(14)).text($("#paneltitlememo").val());

            if ($("#paneloptnotitle").prop("checked")) {
                $("#bootpanel_subtitle_" + $(dsnselectid).attr("id").substring(14)).hide();
            } else
                $("#bootpanel_subtitle_" + $(dsnselectid).attr("id").substring(14)).show();
        }
        else {
            $("#bootpaneltitle_" + $(dsnselectid).attr("id").substring(10)).text($("#paneltitlememo").val());

            if ($("#paneloptnotitle").prop("checked")) {
                $("#bootpaneltitle_" + $(dsnselectid).attr("id").substring(10)).hide();
            } else
                $("#bootpaneltitle_" + $(dsnselectid).attr("id").substring(10)).show();

            if (!$("#paneloptnoborder").prop("checked"))
                $(dsnselectid).addClass("panel");
            else
                $(dsnselectid).removeClass("panel");
        }      
    }
    else if (tmp == "tabletd") {
        
        if ($(dsnselectid).children().length == 0) {
          
            $(dsnselectid).html($("#paneltitlememo").val());
            if ($("#paneltitlememo").val() == "")
            {
                $(dsnselectid).removeAttr("align");
            }
            else
            {
                $(dsnselectid).attr("align", "center");
            }
        }

        if ($("#panelopttitlecenter").prop("checked"))
            $(dsnselectid).attr("valign", "center");
        else
            $(dsnselectid).attr("valign", "top");
    }

}
