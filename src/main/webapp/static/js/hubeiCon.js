var hubeiCon = {
    initCon:function(ptDm,jbDm){
        var userType = parent.userType;
        var bivar = parent.bivar;
        var biArray = [];
        if(bivar){
            biArray= bivar.split("|");
        }else{
            biArray =["","",""];
        }

        if(biArray[2]=="@novalue"){
            biArray[2] = "全部";
        }
        if(biArray[1]=="@novalue"){
            biArray[2] = "";
            biArray[1] = "全部";
        }
        if(biArray[0]=="@novalue"){
            biArray[0] = "全国";
            if(biArray[1]=="全部"){
                biArray[1] = "";
            }
        }
        switch (userType){
            case "全国" :
                $("#"+ptDm).show();
                $("#"+ptDm).val(biArray[0]+biArray[1]+biArray[2]);
                break;
            case "省级" :
                $("#"+jbDm).show();
                $("#"+jbDm).val(biArray[0]+biArray[1]+biArray[2]);
                break;
        }
        var ds;
        var jb;
        var tipindex;
        // var s="<div class='dengji'><span class='jibei-yiyuan ds-xz' id='dengji-shi'>"+biArray[0]+"</span><a class='jibei-yiyuan'>级别机构</a><span class='shenji-pintai'>全省地市</span></div>";
        // s +='<div class="t-quanbu jb-active jibei-yiyuan"><div><a class="active" bi-jibei="全部">全部</a></div><div class="ji-b san-ji">三级:</div><ul class="san-ji-ul"><li><a bi-jibei="三级全部">全部</a></li><li><a bi-jibei="三级综合">综合医院</a></li><li><a bi-jibei="三级专科">专科医院</a></li><li><a bi-jibei="三级中医">中医医院</a></li><li><a bi-jibei="三级妇幼">妇幼医院</a></li><li><a bi-jibei="三级民营">民营医院</a></li></ul><div class="ji-b er-ji">二级:</div><ul class="er-ji-ul"><li><a bi-jibei="二级全部">全部</a></li><li><a bi-jibei="二级综合">综合医院</a></li><li><a bi-jibei="二级专科">专科医院</a></li><li><a bi-jibei="二级中医">中医医院</a></li><li><a bi-jibei="二级妇幼">妇幼医院</a></li><li><a bi-jibei="二级民营">民营医院</a></li></ul></div>'
        // s +='<div class="t-quanbu jb-active shenji-pintai"><div><a class="active">全省</a></div><ul><li><a>委直</a></li><li><a>太原市</a></li><li><a>大同市</a></li><li><a>忻州市</a></li><li><a>阳泉市</a></li><li><a>晋中市</a></li><li><a>长治市</a></li><li><a>晋城市</a></li><li><a>临汾市</a></li><li><a>运城市</a></li><li><a>吕梁市</a></li><li><a>朔州市</a></li></ul></div>'
        // s +='<div class="btn-bottom layui-btn-group"><a class="layui-btn layui-btn-primary layui-btn-small" style="margin-right: 8px!important;">取消</a></div>'


        var s="<div class='dengji'><span class='jibei-yiyuan ds-xz-t' ><span id='dengji-shi'>"+biArray[0]+"</span></span><span class='jibei-yiyuan ds-xz'></span><span class='shenji-pintai'>全省地市</span></div>";
        s +='<div class="t-quanbu jb-active jibei-yiyuan"><div class="ji-b er-ji" style="color: #24BB12;">所有:</div><ul class="er-ji-ul"><li><a bi-jibei="全部">全部</a></li><li><a bi-jibei="所有综合">综合医院</a></li><li><a bi-jibei="所有专科">专科医院</a></li><li><a bi-jibei="所有中医">中医医院</a></li><li><a bi-jibei="所有妇幼">妇幼医院</a></li><li><a bi-jibei="所有民营">民营医院</a></li></ul><div class="ji-b er-ji">三级:</div><ul class="er-ji-ul"><li><a bi-jibei="三级全部">全部</a></li><li><a bi-jibei="三级综合">综合医院</a></li><li><a bi-jibei="三级专科">专科医院</a></li><li><a bi-jibei="三级中医">中医医院</a></li><li><a bi-jibei="三级妇幼">妇幼医院</a></li><li><a bi-jibei="三级民营">民营医院</a></li></ul><div class="ji-b san-ji">二级:</div><ul class="san-ji-ul"><li><a bi-jibei="二级全部">全部</a></li><li><a bi-jibei="二级综合">综合医院</a></li><li><a bi-jibei="二级专科">专科医院</a></li><li><a bi-jibei="二级中医">中医医院</a></li><li><a bi-jibei="二级妇幼">妇幼医院</a></li><li><a bi-jibei="二级民营">民营医院</a></li></ul></div>'
        s +='<div class="t-quanbu jb-active shenji-pintai"><div><a class="active" data-shi="全省">全省</a></div><ul><li><a data-shi="省属">省属</a></li><li><a data-shi="武汉市">武汉市</a></li><li><a data-shi="黄石市">黄石市</a></li><li><a data-shi="十堰市">十堰市</a></li><li><a data-shi="宜昌市">宜昌市</a></li><li><a data-shi="襄阳市">襄阳市</a></li><li><a data-shi="鄂州市">鄂州市</a></li><li><a data-shi="荆门市">荆门市</a></li><li><a data-shi="孝感市">孝感市</a></li><li><a data-shi="荆州市">荆州市</a></li><li><a data-shi="黄冈市">黄冈市</a></li><li><a data-shi="咸宁市">咸宁市</a></li><li><a data-shi="随州市">随州市</a></li><li><a data-shi="恩施土家族苗族自治州">恩施</a></li><li><a data-shi="省直辖县级行政单位">省直辖</a></li></ul></div>'
        s +='<div class="btn-bottom layui-btn-group"><a class="layui-btn layui-btn-primary layui-btn-small" style="margin-right: 8px!important;">取消</a></div>'

        $('.center-back-cs .'+ptDm).on('click',function(){
            var that = this;
            tipindex = layer.tips(s,that,{time:0, maxWidth:250,fix:true});
        });
        $('body').on('click',".btn-bottom a",function(){
            $('.layui-layer-tips').hide();
        });
        $('body').on('click',".dengji .jibei-yiyuan",function(){
            if(userType == "省级") return;
            $(".shenji-pintai").show();
            $(".jibei-yiyuan").hide();
        });
        $('body').on('click',".jibei-yiyuan a",function(){
            $('.layui-layer-tips').hide();
        });
        $('body').on('click',".shenji-pintai a",function(){
            $(".shenji-pintai").hide();
            $(".jibei-yiyuan").show();
        });
        $('body').on('click',".shenji-pintai a",function(){
            $('body .shenji-pintai a').removeClass('active');
            $(this).addClass('active');
            var ds=$(this).attr("data-shi");
            $("#dengji-shi").text(ds);
        });
        $('body').on('click',".jibei-yiyuan a",function(){
            $('body .jibei-yiyuan a').removeClass('active');
            $(this).addClass('active');
            var jb=$(this).attr("bi-jibei");
            var  ds =  $("#dengji-shi").text();
            $("#"+ptDm).val(ds+jb);
            $("#"+jbDm).val(ds+jb);
        });

//第二个
        var tipsdishi;
        var a = document.getElementById(jbDm);
        $('.center-back-cs .'+jbDm).on('click',function(){
            var c = a.value;
            if(c==""){
                var that = this;
                tipsdishi = layer.tips(s,that,{time:0, maxWidth:250,fix:true});
            }else{

                var that = this;
                tipsdishi = layer.tips(s,that,{time:0, maxWidth:250,fix:true});
                $('body .shenji-pintai').css('display','none');
                $('body .jibei-yiyuan').css('display','inline-block');
            }
        });
    },





//科室 病组 控件
    ksTreeData : [],
    mdcTreeData : [],
    ksId:"",
    mdcId:"",
    hospitalCon:function (ks,mdc){
        this.ksId = ks;
        this.loadKsui(ks);
        this.mdcId = mdc;
        $("#"+ks).click(function(){
            var height = findDimensions_height();
            var width = findDimensions_width();
            layeropen(width*0.55,height*0.9-150,"","/hubei/V_hospitalCon/toHospitalCon/V_ksCon?treeData=");
        });
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
    loadKsTree:function(id,data){
        var treeJson = [];
        var pCodes = [];
        for(var i=0;i<data.length;i++){
            var p_code = data[i].td0.substring(0,2);
            if($.inArray(p_code,pCodes)>-1){
                continue;
            }
            pCodes.push(p_code);
            var childJson = [];
            for(var j=0;j<data.length;j++) {
                var c_json;
                if(data[j].td0.substring(0,2)==p_code){
                    c_json = {"id":data[j].td0, "text":data[j].td1, "iconCls":"icon-save"};
                    childJson.push(c_json);
                }

            }
            var p_json;
            if(childJson.length>0){
                p_json= {"id":data[i].td0, "text":data[i].td2, "iconCls":"icon-save", "state":"open","children":childJson};
            }else{
                p_json= {"id":data[i].td0, "text":data[i].td2, "iconCls":"icon-save"};
            }
            treeJson.push(p_json);
        }
        $('#'+id).tree({
            method: "get",
            animate: true,
            data: treeJson
        });
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
    loadKsui:function(id) {
        var ksthis = this;
        var grid;
        var keyword="";
        var autoid="gridtable_"+id;
        //加载grid
        var loadData=function(gid){
            $('#'+gid).height(228);
            $('#'+gid).datagrid({
                url:'',
                method:'get',
                data:ksthis.ksTreeData,
                singleSelect:true,//是否只能选中一行
                pagination:false,//是否启动分页
                rownumbers:true,
                columns:[
                    [
                        { field: 'code', title: '代码', width: '80px', align: 'left',sortable:true,  halign: 'center'},
                        { field: 'name', title: '名称', width: '198px', align: 'left',sortable:true,  halign: 'center'},
                    ]
                ]
            });
            // $('#'+gid).datagrid({'data':ksTreeData});

        };
        $('#'+id).tooltip({
            position: 'top',
            content: '<table id="'+autoid+'"></table>',
            showEvent:"mouseenter",
            hideEvent:"aa",
            // dataX:40,
            // dataY:80,
            onShow: function(){
                var top=$(this).tooltip('tip').offset().top-12;
                $(this).tooltip('tip').attr("id","tips_"+id);
                $(this).tooltip('tip').css({
                    top:'28px'
                });
                $("#tips_"+id).mouseleave(function(){
                    $("#tips_"+id).hide();
                })
                $("#"+id).mouseleave(function(event) {
                    $("#tips_"+id).hide();
                })
                $("#tips_"+id).mouseenter(function(){
                    $("#tips_"+id).show();
                })
                if(ksthis.ksTreeData.length>0){
                    loadData("gridtable_"+id);
                }else{
                    $("#tips_"+id).hide();
                }

            }
        })
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