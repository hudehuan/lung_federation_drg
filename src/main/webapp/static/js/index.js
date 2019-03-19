//tabjs

function initEvent(){
	function t(t) {
		var e = 0;
		return $(t).each(function() {
			e += $(this).outerWidth(!0)
		}), e
	}
	 function nextTabRight() {
        var o = Math.abs(parseInt($(".page-tabs-content").css("margin-left")));
        var l = t($(".content-tabs").children().not(".J_menuTabs"));
        var k = $(".content-tabs").outerWidth(true) - l;
        var p = 0;
        if ($(".page-tabs-content").width() < k) {
            return false
        } else {
            var m = $(".J_menuTab:first");
            var n = 0;
            while ((n + $(m).outerWidth(true)) <= o) {
                n += $(m).outerWidth(true);
                m = $(m).next()
            }
            n = 0;
            while ((n + $(m).outerWidth(true)) < (k) && m.length > 0) {
                n += $(m).outerWidth(true);
                m = $(m).next()
            }
            p = t($(m).prevAll());
            if (p > 0) {
                $(".page-tabs-content").animate({
                    marginLeft: 0 - p + "px"
                },
                "fast")
            }
        }
    }
	function rightTab(e) {
		var a = t($(e).prevAll()),
			i = t($(e).nextAll()),
			n = t($(".content-tabs").children().not(".J_menuTabs")),
			s = $(".content-tabs").outerWidth(!0) - n,
			r = 0;
		if($(".page-tabs-content").outerWidth() < s) r = 0;
		else if(i <= s - $(e).outerWidth(!0) - $(e).next().outerWidth(!0)) {
			if(s - $(e).next().outerWidth(!0) > i) {
				r = a;
				for(var o = e; r - $(o).outerWidth() > $(".page-tabs-content").outerWidth() - s;) r -= $(o).prev().outerWidth(), o = $(o).prev()
			}
		} else a > s - $(e).outerWidth(!0) - $(e).prev().outerWidth(!0) && (r = a - $(e).prev().outerWidth(!0));
		$(".page-tabs-content").animate({
			marginLeft: 0 - r + "px"
		}, "fast")
	}

	function LeftTab() {
		var e = Math.abs(parseInt($(".page-tabs-content").css("margin-left"))),
			a = t($(".content-tabs").children().not(".J_menuTabs")),
			i = $(".content-tabs").outerWidth(!0) - a,
			n = 0;
		if($(".page-tabs-content").width() < i) return !1;
		for(var s = $(".J_menuTab:first"), r = 0; r + $(s).outerWidth(!0) <= e;) r += $(s).outerWidth(!0), s = $(s).next();
		if(r = 0, t($(s).prevAll()) > i) {
			for(; r + $(s).outerWidth(!0) < i && s.length > 0;) r += $(s).outerWidth(!0), s = $(s).prev();
			n = t($(s).prevAll())
		}
		$(".page-tabs-content").animate({
			marginLeft: 0 - n + "px"
		}, "fast")
	}

	function i() {
		var e = Math.abs(parseInt($(".page-tabs-content").css("margin-left"))),
			a = t($(".content-tabs").children().not(".J_menuTabs")),
			i = $(".content-tabs").outerWidth(!0) - a,
			n = 0;
		if($(".page-tabs-content").width() < i) return !1;
		for(var s = $(".J_menuTab:first"), r = 0; r + $(s).outerWidth(!0) <= e;) r += $(s).outerWidth(!0), s = $(s).next();
		for(r = 0; r + $(s).outerWidth(!0) < i && s.length > 0;) r += $(s).outerWidth(!0), s = $(s).next();
		n = t($(s).prevAll()), n > 0 && $(".page-tabs-content").animate({
			marginLeft: 0 - n + "px"
		}, "fast")
	}

	function NewTab() {
		
		var t = $(this).attr("href"),
			a = $(this).data("index"),
			i = $.trim($(this).html()),
			n = !0;
			
		if(void 0 == t || 0 == $.trim(t).length) return !1;
		if($(".J_menuTab").each(function() {
				return $(this).data("id") == t ? ($(this).hasClass("active") || ($(this).addClass("active").siblings(".J_menuTab").removeClass("active"), 
				rightTab(this), $(".J_mainContent .J_iframe").each(function() {
					return $(this).data("id") == t ? ($(this).show().siblings(".J_iframe").hide(), !1) : void 0
				})), n = !1, !1) : void 0
			}), n) 
			{
				var value=i;
				if(value.length>10)
				{
					value=value.substr(0,9)+"...";
				}
			var s = '<a href="javascript:;" title="'+i+'" class="active J_menuTab" data-id="' + t + '">' + value + ' <i class="glyphicon glyphicon-remove-circle"></i></a>';
			$(".J_menuTab").removeClass("active");
			var r = '<iframe  scrolling="auto" style="border:none" class="J_iframe" name="iframe' + a + '" width="100%" height="100%" src="' + t + '" frameborder="0" data-id="' + t + '" ></iframe>';
			$(".J_mainContent").find("iframe.J_iframe").hide().parents(".J_mainContent").append(r);
			//var o = layer.load();
			$(".J_mainContent iframe:visible").load(function() {
				//layer.close(o)
			}), 
			$(".J_menuTabs .page-tabs-content").append(s), rightTab($(".J_menuTab.active"))
		}
			setFrameHeight();
		return !1
	}

	function closeTab() {
		var t = $(this).parents(".J_menuTab").data("id"),
			a = $(this).parents(".J_menuTab").width();
		if($(this).parents(".J_menuTab").hasClass("active")) {
			if($(this).parents(".J_menuTab").next(".J_menuTab").size()) {
				var i = $(this).parents(".J_menuTab").next(".J_menuTab:eq(0)").data("id");
				$(this).parents(".J_menuTab").next(".J_menuTab:eq(0)").addClass("active"), $(".J_mainContent .J_iframe").each(function() {
					return $(this).data("id") == i ? ($(this).show().siblings(".J_iframe").hide(), !1) : void 0
				});
				var n = parseInt($(".page-tabs-content").css("margin-left"));
				0 > n && $(".page-tabs-content").animate({
					marginLeft: n + a + "px"
				}, "fast"), $(this).parents(".J_menuTab").remove(), $(".J_mainContent .J_iframe").each(function() {
					return $(this).data("id") == t ? ($(this).remove(), !1) : void 0
				})
			}
			if($(this).parents(".J_menuTab").prev(".J_menuTab").size()) {
				var i = $(this).parents(".J_menuTab").prev(".J_menuTab:last").data("id");
				$(this).parents(".J_menuTab").prev(".J_menuTab:last").addClass("active"), $(".J_mainContent .J_iframe").each(function() {
					return $(this).data("id") == i ? ($(this).show().siblings(".J_iframe").hide(), !1) : void 0
				}), $(this).parents(".J_menuTab").remove(), $(".J_mainContent .J_iframe").each(function() {
					return $(this).data("id") == t ? ($(this).remove(), !1) : void 0
				})
			}
		} else $(this).parents(".J_menuTab").remove(), $(".J_mainContent .J_iframe").each(function() {
			return $(this).data("id") == t ? ($(this).remove(), !1) : void 0
		}), rightTab($(".J_menuTab.active"));
		return !1
	}

	function CloseOtherTab() {
		$(".page-tabs-content").children("[data-id]").not(":first").not(".active").each(function() {
			$('.J_iframe[data-id="' + $(this).data("id") + '"]').remove(), $(this).remove()
		}), $(".page-tabs-content").css("margin-left", "0")
	}

	function ActiveTab() {
		rightTab($(".J_menuTab.active"))
	}

	function openTab() {
		if(!$(this).hasClass("active")) {
			var t = $(this).data("id");
			$(".J_mainContent .J_iframe").each(function() {
				return $(this).data("id") == t ? ($(this).show().siblings(".J_iframe").hide(), !1) : void 0
			}), $(this).addClass("active").siblings(".J_menuTab").removeClass("active"), rightTab(this)
		}
	}
function refreshTab(){
	var active=$(".J_menuTab.active");
	var t = $(active).data("id");
			$(".J_mainContent .J_iframe").each(function() {
				if($(this).data("id") == t)
				$(this).attr('src', $(this).attr('src'));
			}),  rightTab(active)
}
	function c() {
		var t = $('.J_iframe[data-id="' + $(this).data("id") + '"]'),
			e = t.attr("src"),
			a = layer.load();
		t.attr("src", e).load(function() {
			layer.close(a)
		})
	}
//	$(".J_menuItem").each(function(t) {
//		$(this).attr("data-index") || $(this).attr("data-index", t)
//	});
	
	$(".J_menuItem").on("click", NewTab);
	$(".J_menuTabs").on("click", ".J_menuTab i", closeTab);
	$(".J_tabCloseOther").on("click", CloseOtherTab);
	$(".J_tabShowActive").on("click", ActiveTab);
	$(".J_menuTabs").on("click", ".J_menuTab", openTab); 
	//$(".J_menuTabs").on("dblclick", ".J_menuTab", c);
	$(".J_tabLeft").on("click", LeftTab); 
	$(".J_tabRight").on("click", nextTabRight);
	$(".J_tabRefrsh").on("click", refreshTab);
	
	$(".J_tabCloseAll").on("click", function() {
		$(".page-tabs-content").children("[data-id]").not(":first").each(function() {
			$('.J_iframe[data-id="' + $(this).data("id") + '"]').remove(), $(this).remove()
		}); 
		$(".page-tabs-content").children("[data-id]:first").each(function() {
			$('.J_iframe[data-id="' + $(this).data("id") + '"]').show(), $(this).addClass("active")
		}); 
		$(".page-tabs-content").css("margin-left", "0")
	})
	
};
var menuid=-1;
$(function() {
	setFrameHeight();
	addMenuEnvent();
	initEvent();
})
function addMenuEnvent(){
	$(".nav-item").on('mouseover', function(e) {
		var id=1;		
		id = $(this).data('id');
        showMenu(id);
	});
	
	$("#nav-menu").on('mouseleave', function(e) {
	   $("#nav-menu").hide()
	});

	$('.metismenu').metisMenu();
}
function setFrameHeight() {
	var height = findDimensions_height();
	$(".J_iframe").height(height - 100);
	
}

function showMenu(i) {
	$('#nav-menu').show();
	if (i==menuid )
	return;
	
    $("#menu"+menuid).hide();
	$('#menu'+i).show();
    menuid=i;
}

//index窗体弹窗，用于全局弹窗，如果是内部弹窗，自己写
function layeropen(w, h, title, url) {
	//iframe窗
	layer.open({
		type: 2,
		title: title,
		closeBtn: 1, //不显示关闭按钮
		shade: [0.3, '#000000'],
		area: [w + 'px', h + 'px'],
		offset: 'auto', //右下角弹出
		shift: 0,
		content: url //iframe的url，no代表不显示滚动条
	});
}
/**
 * 创建菜单Menu
 * @param {Object} jsonData:json数据
 * @param {String} menuid:一级菜单容器id
 * @param {String} childid:子菜单容器id
 * @param {String} topid:顶级父id
 */
function createMenu(jsonData,menuid,childid,topid){
		var topMenu= $.linq.where(jsonData, function (v) { return v.pid == topid;});
		var s="";
		var child="";
		$.each(topMenu, function(index,data) {
			s+='<li class="nav-item" data-id="'+data.id+'">';
			s+='<div class="nav-item_main "  >';
			s+='<div class="nav-item_icon"></div>';
			s+='<p class="nav-item_title ">';
			s+=data.mc;
			s+='</p>';
			s+='</div>';
			s+='</li>';
			child+=loadChild(jsonData,data,true);
		});
		$("#"+menuid).html(s);
		$("#"+childid).html(child);
		addMenuEnvent();
		initEvent();
	}
	function loadChild(jsonData,item,expanded){
		var childMenu= $.linq.where(jsonData, function (v) { return v.pid == item.id;});
		var str="";
		str+='<ul class="metismenu"  id="menu'+item.id+'" data-id="'+item.id+'" style="display: none;">'
		$.each(childMenu, function(index,data) {
			str+=eachChild(jsonData,data,"",expanded,index);
			});
		str+='</ul>';
		return str;
	}
	function eachChild(jsonData,item,str,expanded,num){
		var childMenu= $.linq.where(jsonData, function (v) { return v.pid == item.id;});
		if(childMenu.length<=0)
				{
					str+='<li>';
					str+='<a class="J_menuItem" href="'+item.href+'" data-index="'+item.id+'">'+item.mc+'</a>';
					str+='</li>';
					return str;
				}
		else
		{
			if(num==0&&expanded)
			{
			 str+='<li  class="active">';
			 str+='<a href="javascript:;" aria-expanded="true">';
			}
			 else{
			 str+='<li>';
			 str+='<a href="javascript:;" >';
			 }
			 str+=item.mc;		
			 str+='<span class="glyphicon arrow"></span>';
			 str+='</a>';
			 str+='<ul class="nav nav-second-level">';
			$.each(childMenu, function(index,data) {
					str=eachChild(jsonData,data,str,expanded,1);
			});
			str+='</ul>';
		}
		return str;
	}
