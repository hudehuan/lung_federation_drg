<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/09/18
  Time: 13:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="format-detection" content="telephone=no,email=no,address=no">
    <link rel="stylesheet" href="${ctx }/static/css/base.css" />
    <link rel="stylesheet" href="${ctx }/static/css/my-stlye.css" />
    <link rel="stylesheet" href="${ctx }/static/js/bootstrap-3.3.5/css/bootstrap.min.css" />
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js" ></script>
    <script type="text/javascript" src="${ctx }/static/js/common.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/layer/layer.js"></script>
    <title></title>

    <style>
        .xian{
            height:45px ;
            border-left:1px solid #22c3aa;
            position: absolute;
            top:0;
            left:5.6px;
            z-index: -1;
        }
        .current{
            color: #f58839!important;
        }
    </style>
</head>
<body style="width:100%;">

<%--<div id="menu" style="position:fixed;top: 10px;right: 20px;z-index:20000;font-size:12px;">
    <div class="xian"></div>
    <ul id="ulId">
        &lt;%&ndash;<li><a href="#drga0802" class="current"><span></span>- -近12月费用趋势</a></li>&ndash;%&gt;
        &lt;%&ndash;<li><a href="#drga0801" ><span></span>- -费用动因分析</a></li>&ndash;%&gt;
        &lt;%&ndash;<li><a href="#drga0803" ><span></span>- -费用动因分析</a></li>&ndash;%&gt;
        &lt;%&ndash;<li><a href="#drga0804" ><span></span>- -费用动因分析</a></li>&ndash;%&gt;
        &lt;%&ndash;<li><a href="#drga0805" ><span></span>- -费用动因分析</a></li>&ndash;%&gt;
    </ul>
</div>--%>

<div class="J_mainContent" id="content-main">
    <%--<iframe class="J_iframe" style="border:none;min-width: 1250px" id="drga0802"--%>
            <%--width="100%" border="0" marginwidth="0" marginheight="0"  scrolling="no"--%>
            <%--onload="this.height=this.contentDocument.body.scrollHeight;"--%>
            <%--src="${ctx}/V_Drgs0802/toList?hospital=${hospital}&year=${year}" frameborder="0"></iframe>--%>
    <%--<iframe class="J_iframe" style="border:none;min-width: 1250px" id="drga0801"--%>
            <%--width="100%" border="0" marginwidth="0" marginheight="0"  scrolling="no"--%>
            <%--onload="this.height=this.contentDocument.body.scrollHeight+50;"--%>
            <%--src="${ctx}/V_Drgs0801/toList?hospital=${hospital}&year=${year}" frameborder="0"></iframe>--%>

    <%--<iframe class="J_iframe" style="border:none;min-width: 1250px" id="drga0803"--%>
            <%--width="100%" border="0" marginwidth="0" marginheight="0"  scrolling="no"--%>
            <%--onload="this.height=this.contentDocument.body.scrollHeight+50;"--%>
            <%--src="${ctx}/V_Drgs0803/toList?hospital=${hospital}&year=${year}" frameborder="0"></iframe>--%>
    <%--<iframe class="J_iframe" style="border:none;min-width: 1250px" id="drga0804"--%>
            <%--width="100%" border="0" marginwidth="0" marginheight="0"  scrolling="no"--%>
            <%--onload="this.height=this.contentDocument.body.scrollHeight+50;"--%>
            <%--src="${ctx}/V_Drgs0804/toList?hospital=${hospital}&year=${year}" frameborder="0"></iframe>--%>
    <%--<iframe class="J_iframe" style="border:none;min-width: 1250px" id="drga0805"--%>
            <%--width="100%" border="0" marginwidth="0" marginheight="0"  scrolling="no"--%>
            <%--onload="this.height=this.contentDocument.body.scrollHeight+50;"--%>
            <%--src="${ctx}/V_Drgs0805/toList?hospital=${hospital}&year=${year}" frameborder="0"></iframe>--%>
</div>
<script>
    $(function(){
//        var kemu = "@novalue";
        var ifranmeArryay;
       /* if("${yhqx}"=='市级'){
            ifranmeArryay =
                [{"url":"${ctx}/hubei/V_Drgs0802/toList?hospital=${hospital}&year=${year}&kstj=${kstj}&mdctj=${mdctj}","id":"drga0802","name":"机构绩效级别排名展示"},
                    {"url":"${ctx}/hubei/V_Drgs0801/toList?hospital=${hospital}&year=${year}&kstj=${kstj}&mdctj=${mdctj}","id":"drga0801","name":"机构绩效区域、级别排名展示"}
                    ];
        }else{*/
            ifranmeArryay =
                [{"url":"${ctx}/hubei/V_Drgs0802/toList?hospital=${hospital}&year=${year}&kstj=${kstj}&mdctj=${mdctj}&yhqx=${yhqx}&rqkj=${rqkj}","id":"drga0802","name":"机构绩效级别排名展示"},
                    {"url":"${ctx}/hubei/V_Drgs0801/toList?hospital=${hospital}&year=${year}&kstj=${kstj}&mdctj=${mdctj}&yhqx=${yhqx}&rqkj=${rqkj}","id":"drga0801","name":"机构绩效区域、级别排名展示"},
                    {"url":"${ctx}/hubei/V_Drgs0803/toList?hospital=${hospital}&year=${year}&kstj=${kstj}&mdctj=${mdctj}&yhqx=${yhqx}&rqkj=${rqkj}","id":"drga0803","name":"机构专学科绩效区域、级别排名"},
                    /*{"url":"${ctx}/hubei/V_Drgs0804/toList?hospital=${hospital}&year=${year}&kemu="+kemu,"id":"drga0804","name":"科室医师医疗服务能力、质量、效率总览"},
                 {"url":"${ctx}/hubei/V_Drgs0805/toList?hospital=${hospital}&year=${year}&kemu="+kemu,"id":"drga0805","name":"医师医疗服务绩效综合评价"}*/];
       // }
        for(var i=0;i<ifranmeArryay.length;i++){
            var li ="";
            if(i==0){
                li = '<li><a href="#'+ifranmeArryay[i].id+'" class="current"><span></span>- -'+ifranmeArryay[i].name+'</a></li>';
            }else{
                li = '<li><a href="#'+ifranmeArryay[i].id+'" ><span></span>- -'+ifranmeArryay[i].name+'</a></li>';
            }
            $("#ulId").append(li);

            var iframe = ' <iframe class="J_iframe" style="border:none;" id="'+ifranmeArryay[i].id+'"'
           +' width="100%" border="0" marginwidth="0" marginheight="0"  scrolling="no"'
           +' onload="this.height=this.contentDocument.body.scrollHeight;"'
           +' src="'+ifranmeArryay[i].url+'" frameborder="0"></iframe>';
            $("#content-main").append(iframe);
        }

        $(window).scroll(function () {
            var items = $(".J_mainContent").find(".J_iframe");
            var menu = $("#menu");
            var top = $(document).scrollTop();
            var currentId = ""; //滚动条现在所在位置的item id
            items.each(function () {
                var m = $(this);
                //注意：m.offset().top代表每一个item的顶部位置
                if (top > m.offset().top - 300) {
                    currentId = "#" + m.attr("id");
                } else {
                    return false;
                }
            });
            var currentLink = menu.find(".current");
            if (currentId && currentLink.attr("href") != currentId) {
                currentLink.removeClass("current");
                menu.find("[href=" + currentId + "]").addClass("current");
            }
        });
        $('#menu li a').click(function () {
            $('html, body').animate({
                scrollTop: $($.attr(this, 'href')).offset().top-100
            }, 500);
            return false;
        });
    })

</script>
</body>
</html>
