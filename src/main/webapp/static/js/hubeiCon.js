var hubeiCon = {
    initCon:function(ptDm){
        var userType = parent.userType;
        var bivar = parent.bivar;
        var biArray = [];
        if(bivar){
            biArray= bivar.split("|");
        }else{
            biArray =["","",""];
        }

        if(biArray[2]=="@novalue"){
            biArray[2] = "";
        }
        if(biArray[1]=="@novalue"){
            biArray[1] = "";
            //biArray[1] = "全部";
        }
        if(biArray[0]=="@novalue"||userType=='全国'){
            biArray[0] = "全国";
        }
        if(userType=='全国'){
            $("#"+ptDm).show();
        }
        $("#"+ptDm).val(biArray[0]+biArray[1]+biArray[2]);
        var ds;
        var jb;
        var tipindex;
        // var s="<div class='dengji'><span class='jibei-yiyuan ds-xz' id='dengji-shi'>"+biArray[0]+"</span><a class='jibei-yiyuan'>级别机构</a><span class='shenji-pintai'>全省地市</span></div>";
        // s +='<div class="t-quanbu jb-active jibei-yiyuan"><div><a class="active" bi-jibei="全部">全部</a></div><div class="ji-b san-ji">三级:</div><ul class="san-ji-ul"><li><a bi-jibei="三级全部">全部</a></li><li><a bi-jibei="三级综合">综合医院</a></li><li><a bi-jibei="三级专科">专科医院</a></li><li><a bi-jibei="三级中医">中医医院</a></li><li><a bi-jibei="三级妇幼">妇幼医院</a></li><li><a bi-jibei="三级民营">民营医院</a></li></ul><div class="ji-b er-ji">二级:</div><ul class="er-ji-ul"><li><a bi-jibei="二级全部">全部</a></li><li><a bi-jibei="二级综合">综合医院</a></li><li><a bi-jibei="二级专科">专科医院</a></li><li><a bi-jibei="二级中医">中医医院</a></li><li><a bi-jibei="二级妇幼">妇幼医院</a></li><li><a bi-jibei="二级民营">民营医院</a></li></ul></div>'
        // s +='<div class="t-quanbu jb-active shenji-pintai"><div><a class="active">全省</a></div><ul><li><a>委直</a></li><li><a>太原市</a></li><li><a>大同市</a></li><li><a>忻州市</a></li><li><a>阳泉市</a></li><li><a>晋中市</a></li><li><a>长治市</a></li><li><a>晋城市</a></li><li><a>临汾市</a></li><li><a>运城市</a></li><li><a>吕梁市</a></li><li><a>朔州市</a></li></ul></div>'
        // s +='<div class="btn-bottom layui-btn-group"><a class="layui-btn layui-btn-primary layui-btn-small" style="margin-right: 8px!important;">取消</a></div>'


        var s="<div class='dengji'><span class='jibei-yiyuan ds-xz-t' ><span id='dengji-sheng'>"+biArray[0]+"</span></span><span class='jibei-yiyuan ds-xz'></span><span class='shenji-pintai'>全国省市</span></div>";
        s +='<div class="t-quanbu jb-active shenji-pintai"><div><a class="active" data-sheng="全国">全国</a></div><ul>' +
            '<li><a data-sheng="北京市">北京市</a></li>' +
            '<li><a data-sheng="上海市">上海市</a></li>' +
            '<li><a data-sheng="天津市">天津市</a></li>' +
            '<li><a data-sheng="重庆市">重庆市</a></li>' +
            '<li><a data-sheng="河北省">河北省</a></li>' +
            '<li><a data-sheng="山西省">山西省</a></li>' +
            '<li><a data-sheng="辽宁省">辽宁省</a></li>' +
            '<li><a data-sheng="吉林省">吉林省</a></li>' +
            '<li><a data-sheng="黑龙江省">黑龙江省</a></li>' +
            '<li><a data-sheng="江苏省">江苏省</a></li>' +
            '<li><a data-sheng="浙江省">浙江省</a></li>' +
            '<li><a data-sheng="安徽省">安徽省</a></li>' +
            '<li><a data-sheng="福建省">福建省</a></li>' +
            '<li><a data-sheng="江西省">江西省</a></li>' +
            '<li><a data-sheng="山东省">山东省</a></li>' +
            '<li><a data-sheng="重庆市">重庆市</a></li>' +
            '<li><a data-sheng="河北省">河北省</a></li>' +
            '<li><a data-sheng="山西省">山西省</a></li>' +
            '<li><a data-sheng="河南省">河南省</a></li>' +
            '<li><a data-sheng="湖北省">湖北省</a></li>' +
            '<li><a data-sheng="湖南省">湖南省</a></li>' +
            '<li><a data-sheng="广东省">广东省</a></li>' +
            '<li><a data-sheng="海南省">海南省</a></li>' +
            '<li><a data-sheng="四川省">四川省</a></li>' +
            '<li><a data-sheng="贵州省">贵州省</a></li>' +
            '<li><a data-sheng="云南省">云南省</a></li>' +
            '<li><a data-sheng="陕西省">陕西省</a></li>' +
            '<li><a data-sheng="河南省">河南省</a></li>' +
            '<li><a data-sheng="甘肃省">甘肃省</a></li>' +
            '<li><a data-sheng="青海省">青海省</a></li>' +
            '<li><a data-sheng="台湾省">台湾省</a></li>' +
            '<li><a data-sheng="内蒙古自治区">内蒙古自治区</a></li>' +
            '<li><a data-sheng="广西壮族自治区">广西壮族自治区</a></li>' +
            '<li><a data-sheng="西藏自治区">西藏自治区</a></li>' +
            '<li><a data-sheng="宁夏回族自治区">宁夏回族自治区</a></li>' +
            '<li><a data-sheng="新疆维吾尔自治区">新疆维吾尔自治区</a></li>' +
            '<li><a data-sheng="香港特别行政区">香港特别行政区</a></li>' +
            '<li><a data-sheng="澳门特别行政区">澳门特别行政区</a></li>' +
            '</ul></div>'
        s +='<div class="btn-bottom layui-btn-group"><a class="layui-btn layui-btn-primary layui-btn-small" style="margin-right: 8px!important;">取消</a></div>'
        $('.center-back-cs .'+ptDm).on('click',function(){
            var that = this;
            tipindex = layer.tips(s,that,{time:0, maxWidth:250,fix:true});
        });
        $('body').on('click',".btn-bottom a",function(){
            $('.layui-layer-tips').hide();
        });
       /* $('body').on('click',".dengji .jibei-yiyuan",function(){
            if(userType == "省级") return;
            $(".shenji-pintai").show();
            $(".jibei-yiyuan").hide();
        });
        $('body').on('click',".jibei-yiyuan a",function(){
            $('.layui-layer-tips').hide();
        });*/
        $('body').on('click',".shenji-pintai a",function(){
            $(".shenji-pintai").hide();
            $('.layui-layer-tips').hide();
           // $(".jibei-yiyuan").show();
        });
        $('body').on('click',".shenji-pintai a",function(){
            $('body .shenji-pintai a').removeClass('active');
            $(this).addClass('active');
            var ds=$(this).attr("data-sheng");
            $("#dengji-sheng").text(ds);
            $("#"+ptDm).val(ds);
            var yy = document.getElementById("dept");
            if(yy!=null&&typeof yy!='undefined'){
                hubeiCon.loadyydate();
            }

        });
       /* $('body').on('click',".jibei-yiyuan a",function(){
            $('body .jibei-yiyuan a').removeClass('active');
            $(this).addClass('active');
            var jb=$(this).attr("bi-jibei");
            var  ds =  $("#dengji-shi").text();
            $("#"+ptDm).val(ds+'全部');
            $("#"+jbDm).val(ds+'全部');
        });*/
    },





//科室 病组 控件
    mdcTreeData : [],
    mdcId:"",
    hospitalCon:function (mdc){
        this.mdcId = mdc;
        $("#"+mdc).click(function(){
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(width*0.95,height*0.9,"","/hubei/V_hospitalCon/toHospitalCon/V_mdcCon?treeData=");
        });
        var treeHtml ="<div style='display:inline-block; overflow:auto;color: #000 '>"+
            "<ul id='treeId' class='easyui-tree'></ul>"+
            " </div>";
        this.loadmdcui(mdc);
        // $("#"+ks).on('mouseenter',function(){//mouseenter
        //     if(ksTreeData.length>0){
        //         // layer.tips(treeHtml.replace("treeId","treeId"+ks),this,{tips:1,time:0, Width:150,fix:true});
        //         loadKsTree(ks,ksTreeData);
        //     }
        // });
        // $("#"+ks).on('mouseout',function(){//mouseenter
        //     layer.closeAll("tips");
        // });
        // $("#"+mdc).on('mouseenter',function(){//mouseenter
        //     if(mdcTreeData.length>0){
        //         layer.tips(treeHtml.replace("treeId","treeId"+mdc),this,{tips:1,time:0, Width:150,fix:true});
        //         loadMdcTree("treeId"+mdc,mdcTreeData)
        //     }
        // });
        // $("#"+mdc).on('mouseout',function(){//mouseenter
        //     layer.closeAll("tips");
        // });
    },
    loadMdcTree:function(id,data){
        var treeJson = [];
        var pCodes = [];
        for(var i=0;i<data.length;i++){
            var p_code = data[i].MDCdm;
            if($.inArray(p_code,pCodes)>-1){
                continue;
            }
            pCodes.push(p_code);
            var childJson = [];
            for(var j=0;j<data.length;j++) {
                var c_json;
                if(data[j].MDCdm==p_code&& data[j].DRGsdm){
                    c_json = {"id":data[j].DRGsdm, "text":"[ "+data[j].DRGsdm+" ]"+data[j].DRGsmc, "iconCls":"icon-save"};
                    childJson.push(c_json);
                }

            }
            var p_json;
            if(childJson.length>0){
                p_json= {"id":data[i].MDCdm, "text":"[ "+data[i].MDCdm+" ]"+data[i].MDCmc, "iconCls":"icon-save", "state":"closed","children":childJson};
            }else{
                p_json= {"id":data[i].MDCdm, "text":"[ "+data[i].MDCdm+" ]"+data[i].MDCmc, "iconCls":"icon-save"};
            }
            treeJson.push(p_json);
        }
        $('#'+id).tree({
            method: "get",
            animate: true,
            data: treeJson,
            onClick: function(node) {
                $(this).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
                node.state = node.state === 'closed' ? 'open' : 'closed';
            }
        });
    },
    loadyydate:function(){
        var sheng = $("#sj-pt").val()
        //sheng = sheng.substring(0,sheng.lastIndexOf("全"));
        if(sheng=='全国'||sheng==''){
            sheng = ''
        }
        var postdata = {p_dm: "selectxqName",xqName:sheng};
        dLong.getJSON("/commapiV2",postdata,function(data){
            if (data.success) {
                var s='<option value="-1"></option><option value="全部"  class="qbyy" id="@novalue">全部</option>';
                if(data.Table.length>0){
                    $.each(data.Table,function(index,item){
                        s+='<option class="yy" id="'+item.name+'|" value="'+item.name+'">'+item.name+'</option >'
                    })
                }
                //$('.yy').remove();
                $('.qbyy').after(s);
                $('.dept_select').html(s)
                $('.dept_select').trigger("chosen:updated");
                
            }
        },true);
    },
    loadmdcui:function(id){
        var mdcthis = this;
        $('#'+id).tooltip({
            position: 'top',
            content: "<ul id='treeId"+id+"' class='easyui-tree'></ul>",
            showEvent:"mouseenter",
            hideEvent:"aa",
            onShow: function(){
                var top=$(this).tooltip('tip').offset().top-12;
                $(this).tooltip('tip').attr("id","tips_"+id);
                $(this).tooltip('tip').css({
                    top:'28px'
                });

                $("#tips_"+id).mouseleave(function(){
                    $("#tips_"+id).hide();
                })
                $("#"+id).mouseleave(function(){
                    $("#tips_"+id).hide();
                })
                $("#tips_"+id).mouseenter(function(){
                    $("#tips_"+id).show();
                })
                if(mdcthis.mdcTreeData.length>0){
                    mdcthis.loadMdcTree("treeId"+id,mdcthis.mdcTreeData);
                }else{
                    $("#tips_"+id).hide();
                }

            }
        })
    },
    changeRqkj:function(){
        var val = $("#rqkj").val();
        var date = new Date;
        switch (val){
            case "n":
                $("#rq").attr("onfocus","WdatePicker({el:'rq',startDate:'%y',dateFmt:'yyyy',alwaysUseStartDate:true,maxDate:'%y'})");
                $("#rq").val(date.getFullYear());
                break;
            case "j":
                $("#rq").attr("onfocus","WdatePicker({el:'rq',dateFmt:'yyyy-MM季',isQuarter:true, isShowOK:false, disabledDates:['....-0[5-9]-..','....-1[0-2]-..'], startDate:'%y-01-01'})");
                $("#rq").val(date.getFullYear()+"-01季");
                break;
            case "y":
                $("#rq").attr("onfocus","WdatePicker({el:'rq',startDate:'%y',dateFmt:'yyyy-MM',alwaysUseStartDate:true,maxDate:'%y'})");
                var year = date.getFullYear();
                var month = date.getMonth()+1;
                if(month<10){
                    month = "0"+month;
                }
                if(Number(month)==0){
                    $("#rq").val((year-1)+"-12");
                }else{
                    $("#rq").val(year+"-"+month);
                }
                return;
        }
    },
    getTimeStr:function(){
        var cxsj ="";
        var rqkj = $("#rqkj").val();
        var rq = $("#rq").val();
        var sTime = "",eTime = "";
        switch (rqkj){
            case 'n':
                sTime = rq + "-01-01";
                eTime = rq + "-12-31";
                break;
            case 'j':
                var year = rq.split("-")[0];
                var jd = rq.split("-")[1];
                switch (jd){
                    case"01季":
                        sTime = year + "-01-01";
                        eTime = year +"-03-31";
                        break;
                    case"02季":
                        sTime = year + "-04-01";
                        eTime = year +"-06-30";
                        break;
                    case"03季":
                        sTime = year + "-07-01";
                        eTime = year +"-09-30";
                        break;
                    case"04季":
                        sTime = year + "-10-01";
                        eTime = year +"-12-31";
                        break;
                }
                break;
            case 'y':
                sTime = rq + "-01";
                eTime = rq +"-"+ (new Date(rq.substring(0,4),rq.substring(5,7),0)).getDate();
                break;
        }
        cxsj=sTime+";"+eTime;
        return cxsj;
    }
}