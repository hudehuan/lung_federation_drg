<%--
  Created by IntelliJ IDEA.
  User: DL
  Date: 2017-06-17
  Time: 14:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>费用增长与控制指标</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/bootstrap-3.3.5/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/index.css">
    <link rel="stylesheet" href="${ctx}/static/js/plugins/metisMenu/metisMenu.css" />
    <link rel="stylesheet" href="${ctx}/static/js/plugins/layer/skin/layer.css" />

    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/bootstrap-3.3.5/bootstrap.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/my97DatePicker/WdatePicker.js" ></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/metisMenu/jquery.metisMenu.min.js" ></script>
    <script type="text/javascript" src="${ctx}/static/js/common.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/index.js"></script>
    <style>
        .tsxx-class{
            box-shadow:1px 7px 28px rgba(0,0,0,.2)!important;
        }
        .tsxx-class .layui-layer-title{
            background: #55a6f7;
            color: #fff;
        }
        .tsxx-class .layui-layer-content p{
            font-size: 15px;
            margin-left: 30px;
            margin-top: 30px;
        }
        {margin:0.98in 0.75in 0.98in 0.75in;
            mso-header-margin:0.51in;
            mso-footer-margin:0.51in;}
        tr
        {mso-height-source:auto;
            mso-ruby-visibility:none;}
        col
        {mso-width-source:auto;
            mso-ruby-visibility:none;}
        br
        {mso-data-placement:same-cell;}
        .font0
        {color:#000000;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:134;}
        .font1
        {color:#000000;
            font-size:12.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:134;}
        .font2
        {color:#000000;
            font-size:12.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:134;}
        .font3
        {color:#000000;
            font-size:12.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:134;}
        .font4
        {color:#FF0000;
            font-size:12.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:134;}
        .font5
        {color:#7F7F7F;
            font-size:11.0pt;
            font-weight:400;
            font-style:italic;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font6
        {color:#44546A;
            font-size:11.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:134;}
        .font7
        {color:#9C0006;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font8
        {color:#9C6500;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font9
        {color:#44546A;
            font-size:15.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:134;}
        .font10
        {color:#3F3F76;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font11
        {color:#FFFFFF;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font12
        {color:#3F3F3F;
            font-size:11.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font13
        {color:#44546A;
            font-size:13.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:134;}
        .font14
        {color:#000000;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font15
        {color:#FA7D00;
            font-size:11.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font16
        {color:#0000FF;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:underline;
            text-underline-style:single;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font17
        {color:#FFFFFF;
            font-size:11.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font18
        {color:#800080;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:underline;
            text-underline-style:single;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font19
        {color:#FA7D00;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font20
        {color:#000000;
            font-size:11.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font21
        {color:#FF0000;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font22
        {color:#006100;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font23
        {color:#44546A;
            font-size:18.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:134;}
        .style0
        {mso-number-format:"General";
            text-align:general;
            vertical-align:middle;
            white-space:nowrap;
            mso-rotate:0;
            mso-pattern:auto;
            mso-background-source:auto;
            color:#000000;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:134;
            border:none;
            mso-protection:locked visible;
            mso-style-name:"常规";
            mso-style-id:0;}
        .style16
        {mso-number-format:"_ \0022\00A5\0022* \#\,\#\#0_ \;_ \0022\00A5\0022* \\-\#\,\#\#0_ \;_ \0022\00A5\0022* \0022-\0022_ \;_ \@_ ";
            mso-style-name:"货币[0]";
            mso-style-id:7;}
        .style17
        {mso-pattern:auto none;
            background:#EDEDED;
            color:#000000;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"20% - 强调文字颜色 3";}
        .style18
        {mso-pattern:auto none;
            background:#FFCC99;
            color:#3F3F76;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            border:.5pt solid #7F7F7F;
            mso-style-name:"输入";}
        .style19
        {mso-number-format:"_ \0022\00A5\0022* \#\,\#\#0\.00_ \;_ \0022\00A5\0022* \\-\#\,\#\#0\.00_ \;_ \0022\00A5\0022* \0022-\0022??_ \;_ \@_ ";
            mso-style-name:"货币";
            mso-style-id:4;}
        .style20
        {mso-number-format:"_ * \#\,\#\#0_ \;_ * \\-\#\,\#\#0_ \;_ * \0022-\0022_ \;_ \@_ ";
            mso-style-name:"千位分隔[0]";
            mso-style-id:6;}
        .style21
        {mso-pattern:auto none;
            background:#DBDBDB;
            color:#000000;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"40% - 强调文字颜色 3";}
        .style22
        {mso-pattern:auto none;
            background:#FFC7CE;
            color:#9C0006;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"差";}
        .style23
        {mso-number-format:"_ * \#\,\#\#0\.00_ \;_ * \\-\#\,\#\#0\.00_ \;_ * \0022-\0022??_ \;_ \@_ ";
            mso-style-name:"千位分隔";
            mso-style-id:3;}
        .style24
        {mso-pattern:auto none;
            background:#C9C9C9;
            color:#FFFFFF;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"60% - 强调文字颜色 3";}
        .style25
        {color:#0000FF;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:underline;
            text-underline-style:single;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"超链接";
            mso-style-id:8;}
        .style26
        {mso-number-format:"0%";
            mso-style-name:"百分比";
            mso-style-id:5;}
        .style27
        {color:#800080;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:underline;
            text-underline-style:single;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"已访问的超链接";
            mso-style-id:9;}
        .style28
        {mso-pattern:auto none;
            background:#FFFFCC;
            border:.5pt solid #B2B2B2;
            mso-style-name:"注释";}
        .style29
        {mso-pattern:auto none;
            background:#F4B084;
            color:#FFFFFF;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"60% - 强调文字颜色 2";}
        .style30
        {color:#44546A;
            font-size:11.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:134;
            mso-style-name:"标题 4";}
        .style31
        {color:#FF0000;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"警告文本";}
        .style32
        {color:#44546A;
            font-size:18.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:134;
            mso-style-name:"标题";}
        .style33
        {color:#7F7F7F;
            font-size:11.0pt;
            font-weight:400;
            font-style:italic;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"解释性文本";}
        .style34
        {color:#44546A;
            font-size:15.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:134;
            border-bottom:1.0pt solid #5B9BD5;
            mso-style-name:"标题 1";}
        .style35
        {color:#44546A;
            font-size:13.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:134;
            border-bottom:1.0pt solid #5B9BD5;
            mso-style-name:"标题 2";}
        .style36
        {mso-pattern:auto none;
            background:#9BC2E6;
            color:#FFFFFF;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"60% - 强调文字颜色 1";}
        .style37
        {color:#44546A;
            font-size:11.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:134;
            border-bottom:1.0pt solid #ACCCEA;
            mso-style-name:"标题 3";}
        .style38
        {mso-pattern:auto none;
            background:#FFD966;
            color:#FFFFFF;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"60% - 强调文字颜色 4";}
        .style39
        {mso-pattern:auto none;
            background:#F2F2F2;
            color:#3F3F3F;
            font-size:11.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            border:.5pt solid #3F3F3F;
            mso-style-name:"输出";}
        .style40
        {mso-pattern:auto none;
            background:#F2F2F2;
            color:#FA7D00;
            font-size:11.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            border:.5pt solid #7F7F7F;
            mso-style-name:"计算";}
        .style41
        {mso-pattern:auto none;
            background:#A5A5A5;
            color:#FFFFFF;
            font-size:11.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            border:2.0pt double #3F3F3F;
            mso-style-name:"检查单元格";}
        .style42
        {mso-pattern:auto none;
            background:#E2EFDA;
            color:#000000;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"20% - 强调文字颜色 6";}
        .style43
        {mso-pattern:auto none;
            background:#ED7D31;
            color:#FFFFFF;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"强调文字颜色 2";}
        .style44
        {color:#FA7D00;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            border-bottom:2.0pt double #FF8001;
            mso-style-name:"链接单元格";}
        .style45
        {color:#000000;
            font-size:11.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            border-top:.5pt solid #5B9BD5;
            border-bottom:2.0pt double #5B9BD5;
            mso-style-name:"汇总";}
        .style46
        {mso-pattern:auto none;
            background:#C6EFCE;
            color:#006100;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"好";}
        .style47
        {mso-pattern:auto none;
            background:#FFEB9C;
            color:#9C6500;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"适中";}
        .style48
        {mso-pattern:auto none;
            background:#D9E1F2;
            color:#000000;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"20% - 强调文字颜色 5";}
        .style49
        {mso-pattern:auto none;
            background:#5B9BD5;
            color:#FFFFFF;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"强调文字颜色 1";}
        .style50
        {mso-pattern:auto none;
            background:#DDEBF7;
            color:#000000;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"20% - 强调文字颜色 1";}
        .style51
        {mso-pattern:auto none;
            background:#BDD7EE;
            color:#000000;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"40% - 强调文字颜色 1";}
        .style52
        {mso-pattern:auto none;
            background:#FCE4D6;
            color:#000000;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"20% - 强调文字颜色 2";}
        .style53
        {mso-pattern:auto none;
            background:#F8CBAD;
            color:#000000;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"40% - 强调文字颜色 2";}
        .style54
        {mso-pattern:auto none;
            background:#A5A5A5;
            color:#FFFFFF;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"强调文字颜色 3";}
        .style55
        {mso-pattern:auto none;
            background:#FFC000;
            color:#FFFFFF;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"强调文字颜色 4";}
        .style56
        {mso-pattern:auto none;
            background:#FFF2CC;
            color:#000000;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"20% - 强调文字颜色 4";}
        .style57
        {mso-pattern:auto none;
            background:#FFE699;
            color:#000000;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"40% - 强调文字颜色 4";}
        .style58
        {mso-pattern:auto none;
            background:#4472C4;
            color:#FFFFFF;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"强调文字颜色 5";}
        .style59
        {mso-pattern:auto none;
            background:#B4C6E7;
            color:#000000;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"40% - 强调文字颜色 5";}
        .style60
        {mso-pattern:auto none;
            background:#8EA9DB;
            color:#FFFFFF;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"60% - 强调文字颜色 5";}
        .style61
        {mso-pattern:auto none;
            background:#70AD47;
            color:#FFFFFF;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"强调文字颜色 6";}
        .style62
        {mso-pattern:auto none;
            background:#C6E0B4;
            color:#000000;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"40% - 强调文字颜色 6";}
        .style63
        {mso-pattern:auto none;
            background:#A9D08E;
            color:#FFFFFF;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:0;
            mso-style-name:"60% - 强调文字颜色 6";}
        td
        {mso-style-parent:style0;
            padding-top:1px;
            padding-right:1px;
            padding-left:1px;
            mso-ignore:padding;
            mso-number-format:"General";
            text-align:general;
            vertical-align:middle;
            white-space:nowrap;
            mso-rotate:0;
            mso-pattern:auto;
            mso-background-source:auto;
            color:#000000;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:134;
            border:none;
            mso-protection:locked visible;}
        .xl65
        {mso-style-parent:style0;
            font-size:12.0pt;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
        .xl66
        {mso-style-parent:style0;
            mso-number-format:"0\.00_ ";
            font-size:12.0pt;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
        .xl67
        {mso-style-parent:style0;
            text-align:left;
            white-space:normal;
            mso-pattern:auto none;
            background:#EFF3F7;
            font-size:12.0pt;
            font-weight:700;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
        .xl68
        {mso-style-parent:style0;
            text-align:center;
            white-space:normal;
            mso-pattern:auto none;
            background:#EFF3F7;
            font-size:12.0pt;
            font-weight:700;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
        .xl69
        {mso-style-parent:style0;
            text-align:center;
            white-space:normal;
            mso-pattern:auto none;
            background:#EFF3F7;
            font-size:12.0pt;
            font-weight:700;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
        .xl70
        {mso-style-parent:style0;
            text-align:left;
            white-space:normal;
            mso-pattern:auto none;
            background:#F9EDE9;
            font-size:12.0pt;
            font-weight:700;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
        .xl71
        {mso-style-parent:style0;
            white-space:normal;
            mso-pattern:auto none;
            background:#F9EDE9;
            font-size:12.0pt;
            font-weight:700;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
        .xl72
        {mso-style-parent:style0;
            text-align:right;
            white-space:normal;
            mso-pattern:auto none;
            background:#EFF3F7;
            font-size:12.0pt;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
        .xl73
        {mso-style-parent:style0;
            mso-number-format:"0\.00%";
            text-align:right;
            white-space:normal;
            mso-pattern:auto none;
            background:#EFF3F7;
            font-size:12.0pt;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
        .xl74
        {mso-style-parent:style0;
            text-align:right;
            white-space:normal;
            mso-pattern:auto none;
            background:#F9EDE9;
            font-size:12.0pt;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
        .xl75
        {mso-style-parent:style0;
            text-align:right;
            white-space:normal;
            mso-pattern:auto none;
            background:#EFF3F7;
            font-size:12.0pt;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
        .xl76
        {mso-style-parent:style0;
            text-align:right;
            white-space:normal;
            mso-pattern:auto none;
            background:#F9EDE9;
            font-size:12.0pt;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
        .xl77
        {mso-style-parent:style0;
            text-align:left;
            white-space:normal;
            mso-pattern:auto none;
            background:#EFF3F7;
            font-size:12.0pt;
            font-weight:700;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
        .xl78
        {mso-style-parent:style0;
            text-align:left;
            white-space:normal;
            mso-pattern:auto none;
            background:#F9EDE9;
            font-size:12.0pt;
            font-weight:700;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
        .xl79
        {mso-style-parent:style0;
            mso-number-format:"0\.00%";
            text-align:right;
            white-space:normal;
            mso-pattern:auto none;
            background:#EFF3F7;
            color:#FF0000;
            font-size:12.0pt;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
        .xl80
        {mso-style-parent:style0;
            mso-number-format:"0\.00%";
            font-size:12.0pt;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
        .xl81
        {mso-style-parent:style0;
            white-space:normal;
            mso-pattern:auto none;
            background:#F9EDE9;
            font-size:12.0pt;
            font-weight:700;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
        .xl82
        {mso-style-parent:style0;
            mso-number-format:"0\.00%";
            text-align:right;
            white-space:normal;
            mso-pattern:auto none;
            background:#F9EDE9;
            font-size:12.0pt;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
        .xl83
        {mso-style-parent:style0;
            mso-number-format:"0\.00%";
            text-align:right;
            white-space:normal;
            mso-pattern:auto none;
            background:#F9EDE9;
            color:#FF0000;
            font-size:12.0pt;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
    </style>
</head>
<body onload="startTime()" style="background-color:#f1f1f1 ;">
<%--<div id="div1" style="float: right;margin:10px 10px 0 0;"></div>--%>
<div style="min-width: 1200px;margin-top: 10px;">
    <div id="main8" style="width: 99%;height: 50%;margin: 5px 0 0 10px;border-style:solid; border-width:5px; border-color:#c6daeb"></div>
    <div id="main9" style="width: 99%;height: 50%;margin: 5px 0 0 10px;border-style:solid; border-width:5px; border-color:#c6daeb">
        <body link="blue" vlink="purple" class="xl65">
        <table width="1204" border="0" cellpadding="0" cellspacing="0" style='width:903.00pt;border-collapse:collapse;table-layout:fixed;'>
            <col width="141" class="xl65" style='mso-width-source:userset;mso-width-alt:4512;'/>
            <col width="101" span="2" class="xl65" style='mso-width-source:userset;mso-width-alt:3232;'/>
            <col width="110" class="xl65" style='mso-width-source:userset;mso-width-alt:3520;'/>
            <col width="107" class="xl65" style='mso-width-source:userset;mso-width-alt:3424;'/>
            <col width="57" class="xl65" style='mso-width-source:userset;mso-width-alt:1824;'/>
            <col width="141" class="xl66" style='mso-width-source:userset;mso-width-alt:4512;'/>
            <col width="101" class="xl66" style='mso-width-source:userset;mso-width-alt:3232;'/>
            <col width="101" span="2" class="xl65" style='mso-width-source:userset;mso-width-alt:3232;'/>
            <col width="143" class="xl65" style='mso-width-source:userset;mso-width-alt:4576;'/>
            <col width="72" span="16373" class="xl65" style='mso-width-source:userset;mso-width-alt:2304;'/>
            <tr height="19" style='height:14.25pt;'>
                <td style="text-align:center;
            white-space:normal;
            mso-pattern:auto none;
            background:#EFF3F7;
            font-size:18.0pt;
            font-weight:700;
            mso-font-charset:134;" colspan="11">费用增长动因分析  以ID：18机构为例</td>
            </tr>
            <tr height="19" style='height:14.25pt;'>
                <td class="xl67" height="19" style='height:14.25pt;' x:str>门诊费用动因分析</td>
                <td class="xl68" x:num>2015</td>
                <td class="xl68" x:num>2016</td>
                <td class="xl69" x:str>　费用增长</td>
                <td class="xl69" x:str>　率增长构成</td>
                <td class="xl69"></td>
                <td class="xl70" x:str>住院费用动因分析</td>
                <td class="xl71" align="right" x:num>2015</td>
                <td class="xl71" align="right" x:num>2016</td>
                <td class="xl81" x:str>　费用增长</td>
                <td class="xl81" x:str>　率增长构成</td>
            </tr>
            <tr height="19" style='height:14.25pt;'>
                <td class="xl67" height="19" style='height:14.25pt;' x:str>门诊总费用</td>
                <td class="xl72" x:num>77431192.17</td>
                <td class="xl72" x:num>93966128.66</td>
                <td class="xl72" x:num>16534936.49</td>
                <td class="xl73" x:num="0.21350000000000002">21.35%</td>
                <td class="xl73"></td>
                <td class="xl70" x:str>住院总费用</td>
                <td class="xl74" x:num>165697885.3</td>
                <td class="xl74" x:num>222859754.2</td>
                <td class="xl74" x:num>57161868.97</td>
                <td class="xl82" x:num="0.34499999999999997">34.50%</td>
            </tr>
            <tr height="19" style='height:14.25pt;'>
                <td class="xl67" height="19" style='height:14.25pt;' x:str>门诊均费</td>
                <td class="xl75" x:num>265.62</td>
                <td class="xl75" x:num>328.93</td>
                <td class="xl72"></td>
                <td class="xl72"></td>
                <td class="xl72"></td>
                <td class="xl70" x:str>住院均费</td>
                <td class="xl76" x:num>12004.48</td>
                <td class="xl76" x:num>14232.06</td>
                <td class="xl74"></td>
                <td class="xl74"></td>
            </tr>
            <tr height="19" style='height:14.25pt;'>
                <td class="xl67" height="19" style='height:14.25pt;' x:str>门诊量</td>
                <td class="xl72" x:num>291515</td>
                <td class="xl72" x:num>285672</td>
                <td class="xl72"></td>
                <td class="xl72"></td>
                <td class="xl72"></td>
                <td class="xl70" x:str>出院人次</td>
                <td class="xl74" x:num>13803</td>
                <td class="xl74" x:num>15659</td>
                <td class="xl74"></td>
                <td class="xl74"></td>
            </tr>
            <tr height="19" style='height:14.25pt;'>
                <td class="xl77" height="19" style='height:14.25pt;'></td>
                <td class="xl72"></td>
                <td class="xl72"></td>
                <td class="xl72"></td>
                <td class="xl72"></td>
                <td class="xl72"></td>
                <td class="xl78"></td>
                <td class="xl74"></td>
                <td class="xl74"></td>
                <td class="xl74"></td>
                <td class="xl74"></td>
            </tr>
            <tr height="19" style='height:14.25pt;'>
                <td class="xl67" height="19" style='height:14.25pt;' x:str>价格动因</td>
                <td class="xl72"></td>
                <td class="xl72"></td>
                <td class="xl72" x:num>18456875.25</td>
                <td class="xl79" x:num="0.23829999999999998">23.83%</td>
                <td class="xl79"></td>
                <td class="xl70" x:str>价格动因</td>
                <td class="xl74"></td>
                <td class="xl74"></td>
                <td class="xl74" x:num>30747174.3</td>
                <td class="xl83" x:num="0.18559999999999999">18.56%</td>
            </tr>
            <tr height="19" style='height:14.25pt;'>
                <td class="xl67" height="19" style='height:14.25pt;' x:str>门诊量动因</td>
                <td class="xl72"></td>
                <td class="xl72"></td>
                <td class="xl72" x:num>-1551997.173</td>
                <td class="xl79" x:num="-2.e-002">-2.00%</td>
                <td class="xl79"></td>
                <td class="xl70" x:str>出院人次动因</td>
                <td class="xl74"></td>
                <td class="xl74"></td>
                <td class="xl74" x:num>22280321.31</td>
                <td class="xl83" x:num="0.13449999999999998">13.45%</td>
            </tr>
            <tr height="19" style='height:14.25pt;'>
                <td class="xl67" height="19" style='height:14.25pt;' x:str>交互动因</td>
                <td class="xl72"></td>
                <td class="xl72"></td>
                <td class="xl72" x:num>-369941.5882</td>
                <td class="xl79" x:num="-4.7999999999999996e-003">-0.48%</td>
                <td class="xl79"></td>
                <td class="xl70" x:str>交互动因</td>
                <td class="xl74"></td>
                <td class="xl74"></td>
                <td class="xl74" x:num>4134373.361</td>
                <td class="xl83" x:num="2.5000000000000001e-002">2.50%</td>
            </tr>
        </table>
        </body>
    </div>
</div>
<script type="text/javascript" src="${ctx}/static/js/echarts-2.2.7/build/dist/echarts-all.js"></script>
<script>
    // 标准气泡图  三个值
    var myChart8 = echarts.init(document.getElementById('main8'));
    option8 = {
        title : {
            text: '费用增幅与机构动因'
        },
        tooltip : {
            trigger: 'axis'
        },
        legend: {
            data:['总费用增幅','门诊','住院']
        },
        toolbox: {
            show : true,
            feature : {
                mark : {show: true},
                dataView : {show: true, readOnly: false},
                magicType : {show: true, type: ['line', 'bar']},
                restore : {show: true},
                saveAsImage : {show: true}
            }
        },
        calculable : true,
        xAxis : [
            {
                type : 'category',
                name:'医疗机构',
                boundaryGap : false,
                data : ['	18	',
                    '	22	',
                    '	41	',
                    '	40	',
                    '	27	',
                    '	24	',
                    '	28	',
                    '	2	',
                    '	8	',
                    '	36	',
                    '	30	',
                    '	35	',
                    '	25	',
                    '	16	',
                    '	1	',
                    '	43	',
                    '	21	',
                    '	11	',
                    '	33	',
                    '	19	',
                    '	9	',
                    '	4	',
                    '	5	',
                    '	3	',
                    '	15	',
                    '	14	',
                    '	31	',
                    '	29	',
                    '	10	',
                    '	42	',
                    '	39	',
                    '	12	',
                    '	7	',
                    '	20	',
                    '	23	',
                    '	26	',
                    '	13	',
                    '	38	',
                    '	37	',
                    '	17	',
                    '	34	',
                    '	6	']
            }
        ],
        yAxis : [
            {
                type : 'value',
                name:'占比（%）',
                axisLabel : {
                    formatter: '{value} %'
                }
            }
        ],
        series : [
            {
                name:'总费用增幅',
                type:'line',
                data:[30.31 	,
                    29.20 	,
                    26.26 	,
                    23.03 	,
                    19.00 	,
                    17.26 	,
                    16.68 	,
                    16.64 	,
                    16.40 	,
                    14.37 	,
                    13.83 	,
                    13.59 	,
                    12.58 	,
                    12.30 	,
                    12.14 	,
                    11.66 	,
                    11.46 	,
                    9.92 	,
                    9.42 	,
                    8.98 	,
                    7.70 	,
                    7.60 	,
                    7.57 	,
                    7.30 	,
                    7.03 	,
                    6.89 	,
                    6.24 	,
                    5.58 	,
                    5.05 	,
                    4.29 	,
                    3.94 	,
                    3.53 	,
                    3.31 	,
                    3.11 	,
                    2.60 	,
                    2.33 	,
                    1.94 	,
                    1.42 	,
                    0.92 	,
                    0.43 	,
                    -5.68 	,
                    -6.39 	],
                markPoint : {
                    data : [
                        {type : 'max', name: '最大值'},
                        {type : 'min', name: '最小值'}
                    ]
                }/*,
                markLine : {
                    data : [
                        {type : 'average', name: '平均值'}
                    ]
                }*/
            },
            {
                name:'门诊',
                type:'line',
                data:[21.35 	,
                    15.36 	,
                    20.04 	,
                    16.99 	,
                    14.68 	,
                    10.58 	,
                    12.56 	,
                    13.35 	,
                    15.37 	,
                    18.50 	,
                    15.33 	,
                    15.50 	,
                    0.37 	,
                    24.85 	,
                    18.23 	,
                    14.04 	,
                    13.82 	,
                    9.69 	,
                    11.57 	,
                    15.84 	,
                    5.51 	,
                    4.17 	,
                    4.90 	,
                    8.39 	,
                    -1.85 	,
                    9.50 	,
                    -1.71 	,
                    4.67 	,
                    10.51 	,
                    0.06 	,
                    4.35 	,
                    8.41 	,
                    -6.80 	,
                    4.62 	,
                    4.38 	,
                    -4.66 	,
                    16.25 	,
                    -4.57 	,
                    -3.17 	,
                    2.44 	,
                    -4.43 	,
                    -3.25 	],
                markPoint : {
                    data : [
                        {type : 'max', name: '最大值'},
                        {type : 'min', name: '最小值'}
                    ]
                }/*,
                markLine : {
                    data : [
                        {type : 'average', name : '平均值'}
                    ]
                }*/
            },
            {
                name:'住院',
                type:'line',
                data:[34.50 	,
                    33.46 	,
                    29.93 	,
                    25.61 	,
                    20.41 	,
                    19.99 	,
                    18.53 	,
                    17.76 	,
                    16.82 	,
                    13.78 	,
                    13.46 	,
                    11.91 	,
                    16.00 	,
                    7.96 	,
                    10.13 	,
                    7.81 	,
                    10.20 	,
                    10.04 	,
                    9.17 	,
                    6.94 	,
                    8.24 	,
                    8.69 	,
                    8.81 	,
                    6.78 	,
                    10.51 	,
                    5.79 	,
                    8.86 	,
                    6.03 	,
                    1.70 	,
                    6.11 	,
                    3.80 	,
                    1.90 	,
                    6.17 	,
                    2.40 	,
                    1.70 	,
                    3.90 	,
                    -3.57 	,
                    3.44 	,
                    4.32 	,
                    -0.34 	,
                    -6.80 	,
                    -7.45 	],
                markPoint : {
                    data : [
                        {type : 'max', name: '最大值'},
                        {type : 'min', name: '最小值'}
                    ]
                }/*,
    markLine : {
                    data : [
                        {type : 'average', name : '平均值'}
                    ]
                }*/
            }
        ]
    };

    myChart8.setOption(option8);
</script>
</body>
</html>

