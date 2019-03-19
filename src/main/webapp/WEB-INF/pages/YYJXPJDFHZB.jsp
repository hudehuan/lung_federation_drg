<%--
  Created by IntelliJ IDEA.
  User: DL
  Date: 2017-06-17
  Time: 12:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>负担情况</title>
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
        <style>
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
            font-size:18.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:134;}
        .font2
        {color:#000000;
            font-size:9.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:134;}
        .font3
        {color:#000000;
            font-size:9.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:134;}
        .font4
        {color:#000000;
            font-size:9.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:134;}
        .font5
        {color:#000000;
            font-size:9.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:134;}
        .font6
        {color:#FA7D00;
            font-size:11.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font7
        {color:#44546A;
            font-size:18.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:134;}
        .font8
        {color:#44546A;
            font-size:13.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:134;}
        .font9
        {color:#FFFFFF;
            font-size:11.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font10
        {color:#7F7F7F;
            font-size:11.0pt;
            font-weight:400;
            font-style:italic;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font11
        {color:#800080;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:underline;
            text-underline-style:single;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font12
        {color:#3F3F76;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font13
        {color:#44546A;
            font-size:11.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:134;}
        .font14
        {color:#3F3F3F;
            font-size:11.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font15
        {color:#FF0000;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font16
        {color:#FFFFFF;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font17
        {color:#000000;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font18
        {color:#9C0006;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font19
        {color:#000000;
            font-size:11.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font20
        {color:#006100;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font21
        {color:#0000FF;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:underline;
            text-underline-style:single;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font22
        {color:#FA7D00;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
        .font23
        {color:#44546A;
            font-size:15.0pt;
            font-weight:700;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:134;}
        .font24
        {color:#9C6500;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:"宋体";
            mso-generic-font-family:auto;
            mso-font-charset:0;}
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
            text-align:center;
            mso-pattern:auto none;
            background:#9BC2E6;
            font-size:18.0pt;
            font-weight:700;
            mso-font-charset:134;}
        .xl66
        {mso-style-parent:style0;
            text-align:center;
            mso-pattern:auto none;
            background:#9BC2E6;
            mso-font-charset:134;}
        .xl67
        {mso-style-parent:style0;
            text-align:center;
            mso-pattern:auto none;
            background:#9BC2E6;
            font-size:9.0pt;
            font-weight:700;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
        .xl68
        {mso-style-parent:style0;
            text-align:center;
            mso-pattern:auto none;
            background:#9BC2E6;
            font-size:9.0pt;
            font-weight:700;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
        .xl69
        {mso-style-parent:style0;
            text-align:center;
            mso-pattern:auto none;
            background:#92D050;
            font-size:9.0pt;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
        .xl70
        {mso-style-parent:style0;
            mso-number-format:"0\.00%";
            text-align:center;
            mso-pattern:auto none;
            background:#92D050;
            font-size:9.0pt;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
        .xl71
        {mso-style-parent:style0;
            mso-number-format:"0\.00_ ";
            text-align:center;
            mso-pattern:auto none;
            background:#92D050;
            font-size:9.0pt;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
        .xl72
        {mso-style-parent:style0;
            text-align:center;
            mso-pattern:auto none;
            background:#92D050;
            font-size:9.0pt;
            mso-font-charset:134;
            border:.5pt solid windowtext;}
        .xl73
        {mso-style-parent:style0;
            text-align:center;
            mso-pattern:auto none;
            background:#9BC2E6;
            font-size:9.0pt;
            font-weight:700;
            mso-font-charset:134;
            border-left:.5pt solid windowtext;
            border-right:.5pt solid windowtext;}
        .xl74
        {mso-style-parent:style0;
            text-align:center;
            mso-pattern:auto none;
            background:#9BC2E6;
            font-size:9.0pt;
            font-weight:700;
            mso-font-charset:134;
            border:.5pt solid windowtext;}</style>
</head>
<body style="background-color:#f1f1f1 ;">
<%--<div id="div1" style="float: right;margin:10px 10px 0 0;"></div>--%>
<div style="width: 98%;margin-top: 10px;">
    <div id="main8" style="overflow-x:scroll;width: 98%;height: 99%;margin: 5px 0 0 10px;border-style:solid; border-width:5px; border-color:#c6daeb">
        <body link="blue" vlink="purple">
        <table width="1198" border="0" cellpadding="0" cellspacing="0" style='width:98%;height:100%;border-collapse:collapse;table-layout:fixed;'>
            <col width="37" style='mso-width-source:userset;mso-width-alt:1184;'/>
            <col width="72" span="11" style='width:54.00pt;'/>
            <col width="41" style='mso-width-source:userset;mso-width-alt:1312;'/>
            <col width="72" span="3" style='width:54.00pt;'/>
            <col width="40" style='mso-width-source:userset;mso-width-alt:1280;'/>
            <col width="72" style='width:54.00pt;'/>
            <tr height="54.67" style='height:41.00pt;mso-height-source:userset;mso-height-alt:820;'>
                <td class="xl65" height="54.67" width="1198" colspan="18" style='height:41.00pt;width:898.50pt;border-right:none;border-bottom:none;' x:str>医院绩效评价等分汇总表</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl67" height="18" style='height:13.50pt;' x:str>序号</td>
                <td class="xl68" x:str>总费用增幅</td>
                <td class="xl68" x:str>门诊</td>
                <td class="xl68" x:str>住院</td>
                <td class="xl68" x:str>门急诊均为</td>
                <td class="xl68" x:str>住院均费</td>
                <td class="xl68" x:str>CMI</td>
                <td class="xl68" x:str>出院患者数</td>
                <td class="xl68" x:str>总权重数</td>
                <td class="xl68" x:str>34级常规手<span style='display:none;'>术占比</span></td>
                <td class="xl68" x:str>疑难杂症</td>
                <td class="xl68" x:str>关键技术</td>
                <td class="xl73" x:str>……</td>
                <td class="xl68" x:str>医生负担权<span style='display:none;'>重</span></td>
                <td class="xl68" x:str>医生负担床<span style='display:none;'>日</span></td>
                <td class="xl74" x:str>每CMI床日费<span style='display:none;'>用</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl68" x:str>得分</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>1</td>
                <td class="xl70" x:num="0.12141432557712524">12.14%</td>
                <td class="xl70" x:num="0.18225847668248113">18.23%</td>
                <td class="xl70" x:num="0.10125144599308745">10.13%</td>
                <td class="xl71" x:num="413.84182269628343">413.84<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="18139.524120842692">18139.52<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.95730967964177571">0.96<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>8709</td>
                <td class="xl72" x:num="8337.2100000002247">8337.21</td>
                <td class="xl70" x:num="0.25468164794007492">25.47%</td>
                <td class="xl70" x:num="0.16614995981168906">16.61%</td>
                <td class="xl70" x:num="0.22704447632711622">22.70%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="5.0436842105264512">5.04<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="2.0588618452129381">2.06<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1499.7514650705859">1499.75<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>2</td>
                <td class="xl70" x:num="0.16636169572572415">16.64%</td>
                <td class="xl70" x:num="0.13354304059389621">13.35%</td>
                <td class="xl70" x:num="0.17756544485582604">17.76%</td>
                <td class="xl71" x:num="290.09781402288723">290.10<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="19533.431164170979">19533.43<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.94746027953650092">0.95<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>8371</td>
                <td class="xl72" x:num="7931.1900000000487">7931.19</td>
                <td class="xl70" x:num="0.28404189772027111">28.40%</td>
                <td class="xl70" x:num="4.0377493728347869e-002">4.04%</td>
                <td class="xl70" x:num="0.26763415457306783">26.76%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="3.9875263951734787">3.99<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.4763941403748011">1.48<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1682.9800710642196">1682.98<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>3</td>
                <td class="xl70" x:num="7.3011723911862697e-002">7.30%</td>
                <td class="xl70" x:num="8.3898990570126245e-002">8.39%</td>
                <td class="xl70" x:num="6.7800020143438999e-002">6.78%</td>
                <td class="xl71" x:num="369.67413972570603">369.67<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="16078.476757091734">16078.48<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.95005673266179558">0.95<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>8637</td>
                <td class="xl72" x:num="8205.6399999999285">8205.64</td>
                <td class="xl70" x:num="0.29606495940037475">29.61%</td>
                <td class="xl70" x:num="5.5922195206668981e-002">5.59%</td>
                <td class="xl70" x:num="0.21826809015421114">21.83%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="3.8742398489140357">3.87<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.3541542163064146">1.35<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1426.5534751133875">1426.55<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>4</td>
                <td class="xl70" x:num="7.6012216548243708e-002">7.60%</td>
                <td class="xl70" x:num="4.1692110486462382e-002">4.17%</td>
                <td class="xl70" x:num="8.6937417941646278e-002">8.69%</td>
                <td class="xl71" x:num="329.15731253719844">329.16<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="21815.96238907173">21815.96<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.96204223987598059">0.96<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>10322</td>
                <td class="xl72" x:num="9930.1999999998716">9930.2</td>
                <td class="xl70" x:num="0.24881414402759811">24.88%</td>
                <td class="xl70" x:num="0.2142995543499322">21.43%</td>
                <td class="xl70" x:num="0.15273509526736326">15.27%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="4.5219489981784475">4.52<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.5618384609626468">1.56<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1805.8167712772938">1805.82<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>5</td>
                <td class="xl70" x:num="7.5659110671998583e-002">7.57%</td>
                <td class="xl70" x:num="4.9012851839141849e-002">4.90%</td>
                <td class="xl70" x:num="8.8108753621634867e-002">8.81%</td>
                <td class="xl71" x:num="311.46563260413433">311.47<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="14237.777832045107">14237.78<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.96916979640244594">0.97<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>5059</td>
                <td class="xl72" x:num="4903.0299999999743">4903.03</td>
                <td class="xl70" x:num="0.11554921540656206">11.55%</td>
                <td class="xl70" x:num="0.14983198260525796">14.98%</td>
                <td class="xl70" x:num="0.22825219473264166">22.83%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="3.255664010624153">3.26<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.1876439447688698">1.19<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1106.3179903200489">1106.32<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>6</td>
                <td class="xl70" x:num="-6.3875258953087682e-002">-6.39%</td>
                <td class="xl70" x:num="-3.2536918422538051e-002">-3.25%</td>
                <td class="xl70" x:num="-7.4471596806525667e-002">-7.45%</td>
                <td class="xl71" x:num="315.54410505578181">315.54<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="11342.588475708359">11342.59<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.98349283967865742">0.98<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>2863</td>
                <td class="xl72" x:num>2815.74</td>
                <td class="xl70" x:num="0.10106382978723404">10.11%</td>
                <td class="xl70" x:num="1.7464198393293748e-002">1.75%</td>
                <td class="xl70" x:num="0.35118110236220473">35.12%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="2.2400477326968944">2.24<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.12392846634191">1.12<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="692.33402444818205">692.33<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>7</td>
                <td class="xl70" x:num="3.3122526148705748e-002">3.31%</td>
                <td class="xl70" x:num="-6.8041829695109038e-002">-6.80%</td>
                <td class="xl70" x:num="6.1697917055053932e-002">6.17%</td>
                <td class="xl71" x:num="240.53421513868943">240.53<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="13227.939382165769">13227.94<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.92691109735972776">0.93<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>9696</td>
                <td class="xl72" x:num="8987.3299999999199">8987.33</td>
                <td class="xl70" x:num="0.10684931506849316">10.68%</td>
                <td class="xl70" x:num="2.5474422442244224e-002">2.55%</td>
                <td class="xl70" x:num="0.25752380952380954">25.75%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="4.8632738095237658">4.86<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.7481764810531935">1.75<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="999.83328013393577">999.83<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>8</td>
                <td class="xl70" x:num="0.16395920138304632">16.40%</td>
                <td class="xl70" x:num="0.1536927916230747">15.37%</td>
                <td class="xl70" x:num="0.168174623945683">16.82%</td>
                <td class="xl71" x:num="227.49719103622147">227.50<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="11102.295531382364">11102.30<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.98094007609386014">0.98<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>6308</td>
                <td class="xl72" x:num="6187.7700000000696">6187.77</td>
                <td class="xl70" x:num="0.24925373134328357">24.93%</td>
                <td class="xl70" x:num="4.724159797083069e-002">4.72%</td>
                <td class="xl70" x:num="0.23321123321123322">23.32%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="3.9513218390805043">3.95<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.4342098357214086">1.43<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="887.45401674441985">887.45<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>9</td>
                <td class="xl70" x:num="7.7035859828023551e-002">7.70%</td>
                <td class="xl70" x:num="5.5055347998809533e-002">5.51%</td>
                <td class="xl70" x:num="8.2404224696854267e-002">8.24%</td>
                <td class="xl71" x:num="157.74630092848352">157.75<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="10652.053317186395">10652.05<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.9514172015404363">0.95<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>7790</td>
                <td class="xl72" x:num>7411.54</td>
                <td class="xl70" x:num="3.7735849056603772e-002">3.77%</td>
                <td class="xl70" x:num="0.19229781771501925">19.23%</td>
                <td class="xl70" x:num="0.">0.00%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="4.0566721401204155">4.06<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.5581978091189239">1.56<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="828.40420676961241">828.40<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>10</td>
                <td class="xl70" x:num="5.0495189850591253e-002">5.05%</td>
                <td class="xl70" x:num="0.10510419432231204">10.51%</td>
                <td class="xl70" x:num="1.6981353383045416e-002">1.70%</td>
                <td class="xl71" x:num="295.17307014339787">295.17<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="8032.1698755854804">8032.17<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.0088341404358343">1.01<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>8260</td>
                <td class="xl72" x:num="8332.9699999999921">8332.97</td>
                <td class="xl70" x:num="0.12632594021215043">12.63%</td>
                <td class="xl70" x:num="6.561743341404358e-002">6.56%</td>
                <td class="xl70" x:num="0.30836707152496629">30.84%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="5.6227867746288744">5.62<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="2.1065276468304588">2.11<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="667.65360017640728">667.65<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>11</td>
                <td class="xl70" x:num="9.9161615700950043e-002">9.92%</td>
                <td class="xl70" x:num="9.6912592374077899e-002">9.69%</td>
                <td class="xl70" x:num="0.10038008529786269">10.04%</td>
                <td class="xl71" x:num="240.15474661621082">240.15<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="12149.705262561123">12149.71<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.97722188815394306">0.98<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>6652</td>
                <td class="xl72" x:num="6500.4800000000296">6500.48</td>
                <td class="xl70" x:num="1.">100.00%</td>
                <td class="xl70" x:num="0.10162357185808779">10.16%</td>
                <td class="xl70" x:num="0.">0.00%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="5.7628368794326503">5.76<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="2.0993879335470709">2.10<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="922.45732764418813">922.46<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>12</td>
                <td class="xl70" x:num="3.532169556162406e-002">3.53%</td>
                <td class="xl70" x:num="8.4125261387817715e-002">8.41%</td>
                <td class="xl70" x:num="1.9029246902136029e-002">1.90%</td>
                <td class="xl71" x:num="326.22983274080946">326.23<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="12299.000071576407">12299.00<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.95213181818182213">0.95<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>2200</td>
                <td class="xl72" x:num="2094.6900000000087">2094.69</td>
                <td class="xl70" x:num="0.16201117318435754">16.20%</td>
                <td class="xl70" x:num="7.7272727272727271e-002">7.73%</td>
                <td class="xl70" x:num="0.21603563474387527">21.60%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="4.1072352941176637">4.11<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.6584045124899276">1.66<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="582.89889261928772">582.90<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>13</td>
                <td class="xl70" x:num="1.9412704353068577e-002">1.94%</td>
                <td class="xl70" x:num="0.16249430622686148">16.25%</td>
                <td class="xl70" x:num="-3.570367519472753e-002">-3.57%</td>
                <td class="xl71" x:num="299.71286689822534">299.71<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="14158.169066966799">14158.17<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.96762778764555402">0.97<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>5067</td>
                <td class="xl72" x:num="4902.9700000000221">4902.97</td>
                <td class="xl70" x:num="0.15166461159062886">15.17%</td>
                <td class="xl70" x:num="0.16439707913953031">16.44%</td>
                <td class="xl70" x:num="0.15391084945332212">15.39%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="4.2121735395189193">4.21<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.6903827143058889">1.69<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1035.7702715933533">1035.77<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>14</td>
                <td class="xl70" x:num="6.8868331060427626e-002">6.89%</td>
                <td class="xl70" x:num="9.4970904331779904e-002">9.50%</td>
                <td class="xl70" x:num="5.7895582812936081e-002">5.79%</td>
                <td class="xl71" x:num="240.37513126945993">240.38<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="11131.449168489458">11131.45<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.0084725918041602">1.01<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>5637</td>
                <td class="xl72" x:num="5684.7600000000511">5684.76</td>
                <td class="xl70" x:num="0.23891402714932128">23.89%</td>
                <td class="xl70" x:num="0.10910058541777541">10.91%</td>
                <td class="xl70" x:num="0.24676125848241826">24.68%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="4.0317446808511006">4.03<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.3814514718740891">1.38<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="887.61304032497264">887.61<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>15</td>
                <td class="xl70" x:num="7.0283708760310634e-002">7.03%</td>
                <td class="xl70" x:num="-1.8469946725681936e-002">-1.85%</td>
                <td class="xl70" x:num="0.10514705516988535">10.51%</td>
                <td class="xl71" x:num="211.61910647614951">211.62<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="11889.055191937985">11889.06<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.93413247172859482">0.93<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>3095</td>
                <td class="xl72" x:num>2891.14</td>
                <td class="xl70" x:num="0.10223048327137546">10.22%</td>
                <td class="xl70" x:num="0.20096930533117932">20.10%</td>
                <td class="xl70" x:num="0.11370716510903427">11.37%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="2.9381504065040658">2.94<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.516939525559639">1.52<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="496.83356315663684">496.83<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>16</td>
                <td class="xl70" x:num="0.12301364414906257">12.30%</td>
                <td class="xl70" x:num="0.24853381994052498">24.85%</td>
                <td class="xl70" x:num="7.9598838068265787e-002">7.96%</td>
                <td class="xl71" x:num="301.69239493210654">301.69<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="11688.958877644895">11688.96<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.94695982017420244">0.95<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>3559</td>
                <td class="xl72" x:num="3370.2299999999864">3370.23</td>
                <td class="xl70" x:num="0.26548672566371684">26.55%</td>
                <td class="xl70" x:num="3.568418094970497e-002">3.57%</td>
                <td class="xl70" x:num="0.20794701986754968">20.79%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="3.9417894736841945">3.94<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.4424609468877674">1.44<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="973.26793641435052">973.27<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>17</td>
                <td class="xl70" x:num="4.3248403657128332e-003">0.43%</td>
                <td class="xl70" x:num="2.4358335778128782e-002">2.44%</td>
                <td class="xl70" x:num="-3.4450246117156027e-003">-0.34%</td>
                <td class="xl71" x:num="315.59806303236797">315.60<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="12097.041907707369">12097.04<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.95179078014185459">0.95<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>9588</td>
                <td class="xl72" x:num="9125.7700000001023">9125.77</td>
                <td class="xl70" x:num="0.33748361730013104">33.75%</td>
                <td class="xl70" x:num="4.4117647058823532e-002">4.41%</td>
                <td class="xl70" x:num="0.16563706563706565">16.56%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="5.6541325898389729">5.65<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="2.0984875490146151">2.10<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1055.8223632180188">1055.82<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>18</td>
                <td class="xl70" x:num="0.30311802370980107">30.31%</td>
                <td class="xl70" x:num="0.21354361242040004">21.35%</td>
                <td class="xl70" x:num="0.34497645444814429">34.50%</td>
                <td class="xl71" x:num="328.93013196953149">328.93<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="14232.055318985887">14232.06<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.98001162340178893">0.98<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>2581</td>
                <td class="xl72" x:num="2529.4100000000171">2529.41</td>
                <td class="xl70" x:num="1.">100.00%</td>
                <td class="xl70" x:num="6.7028283611003492e-002">6.70%</td>
                <td class="xl70" x:num="0.">0.00%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="2.547240684793572">2.55<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.1076439183876174">1.11<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1007.5851277388613">1007.59<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>19</td>
                <td class="xl70" x:num="8.9814951928351969e-002">8.98%</td>
                <td class="xl70" x:num="0.15838218236718873">15.84%</td>
                <td class="xl70" x:num="6.939660630328702e-002">6.94%</td>
                <td class="xl71" x:num="274.53087394408442">274.53<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="13463.782331118115">13463.78<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.95558395595753032">0.96<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>5086</td>
                <td class="xl72" x:num>4860.1</td>
                <td class="xl70" x:num="0.21529745042492918">21.53%</td>
                <td class="xl70" x:num="0.13645300825796303">13.65%</td>
                <td class="xl70" x:num="0.22792607802874743">22.79%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="3.2335994677312043">3.23<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.2112760779810241">1.21<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1034.3299891044612">1034.33<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>20</td>
                <td class="xl70" x:num="3.1143271526345016e-002">3.11%</td>
                <td class="xl70" x:num="4.6212827272188228e-002">4.62%</td>
                <td class="xl70" x:num="2.399077024712121e-002">2.40%</td>
                <td class="xl71" x:num="283.42243174671574">283.42<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="13095.023025257118">13095.02<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.95619222462201969">0.96<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>4630</td>
                <td class="xl72" x:num="4427.169999999951">4427.17</td>
                <td class="xl70" x:num="0.13843351548269581">13.84%</td>
                <td class="xl70" x:num="3.3477321814254862e-002">3.35%</td>
                <td class="xl70" x:num="0.15575465196416263">15.58%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="4.3531661750245343">4.35<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.6155170323675598">1.62<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1171.6034600308844">1171.60<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>21</td>
                <td class="xl70" x:num="0.11457696470273855">11.46%</td>
                <td class="xl70" x:num="0.13817673638860323">13.82%</td>
                <td class="xl70" x:num="0.10201750780210331">10.20%</td>
                <td class="xl71" x:num="280.84784625436305">280.85<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="5327.2391610811592">5327.24<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.96335209003215316">0.96<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>6220</td>
                <td class="xl72" x:num="5992.0499999999929">5992.05</td>
                <td class="xl70" x:num="7.9754601226993863e-002">7.98%</td>
                <td class="xl70" x:num="7.5562700964630219e-002">7.56%</td>
                <td class="xl70" x:num="0.29397590361445786">29.40%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="5.8231778425655909">5.82<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.488302248492352">1.49<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="556.91859449448134">556.92<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>22</td>
                <td class="xl70" x:num="0.2919891423658873">29.20%</td>
                <td class="xl70" x:num="0.15355660205533783">15.36%</td>
                <td class="xl70" x:num="0.33458552367755273">33.46%</td>
                <td class="xl71" x:num="271.19856940239765">271.20<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="12537.488427493283">12537.49<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.92564333612741312">0.93<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>4772</td>
                <td class="xl72" x:num="4417.1700000000155">4417.17</td>
                <td class="xl70" x:num="8.2222222222222224e-002">8.22%</td>
                <td class="xl70" x:num="0.1487845766974015">14.88%</td>
                <td class="xl70" x:num="0.21199999999999999">21.20%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="3.5911951219512321">3.59<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.1098696959572336">1.11<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1180.7367870421467">1180.74<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>23</td>
                <td class="xl70" x:num="2.6035747266367454e-002">2.60%</td>
                <td class="xl70" x:num="4.3779314895187861e-002">4.38%</td>
                <td class="xl70" x:num="1.6961471263775795e-002">1.70%</td>
                <td class="xl71" x:num="348.87957783101132">348.88<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="10935.276425895187">10935.28<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.93749848820801662">0.94<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>4961</td>
                <td class="xl72" x:num="4650.9299999999703">4650.93</td>
                <td class="xl70" x:num="0.12023460410557185">12.02%</td>
                <td class="xl70" x:num="0.1816166095545253">18.16%</td>
                <td class="xl70" x:num="0.25538707102952912">25.54%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="4.6555855855855564">4.66<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.4757661771360402">1.48<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1045.0643588424573">1045.06<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>24</td>
                <td class="xl70" x:num="0.17261772177231449">17.26%</td>
                <td class="xl70" x:num="0.1057902185305272">10.58%</td>
                <td class="xl70" x:num="0.1998860136460216">19.99%</td>
                <td class="xl71" x:num="336.11761864658433">336.12<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="11376.902709275668">11376.90<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.96057708298685962">0.96<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>6013</td>
                <td class="xl72" x:num="5775.9499999999871">5775.95</td>
                <td class="xl70" x:num="0.15349194167306215">15.35%</td>
                <td class="xl70" x:num="0.18942291701313821">18.94%</td>
                <td class="xl70" x:num="0.29095209934949734">29.10%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="6.0354754440961207">6.04<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.8045776613561215">1.80<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1074.3747034049657">1074.37<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>25</td>
                <td class="xl70" x:num="0.12575544234266953">12.58%</td>
                <td class="xl70" x:num="3.7486362183773336e-003">0.37%</td>
                <td class="xl70" x:num="0.16001320392084886">16.00%</td>
                <td class="xl71" x:num="232.27560031241717">232.28<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="14136.637532688239">14136.64<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.98530348084659825">0.99<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>5717</td>
                <td class="xl72" x:num>5632.98</td>
                <td class="xl70" x:num="0.23127572016460907">23.13%</td>
                <td class="xl70" x:num="0.22266923211474549">22.27%</td>
                <td class="xl70" x:num="0.29588014981273408">29.59%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="5.1442739726027416">5.14<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.949604053293301">1.95<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="967.36365802769194">967.36<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>26</td>
                <td class="xl70" x:num="2.3255151292599061e-002">2.33%</td>
                <td class="xl70" x:num="-4.6635956839336606e-002">-4.66%</td>
                <td class="xl70" x:num="3.8975570446943317e-002">3.90%</td>
                <td class="xl71" x:num="271.23174753470636">271.23<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="9311.9867247544989">9311.99<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.9320353767870061">0.93<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>4127</td>
                <td class="xl72" x:num="3846.5099999999743">3846.51</td>
                <td class="xl70" x:num="0.1965389369592089">19.65%</td>
                <td class="xl70" x:num="2.5926823358371699e-002">2.59%</td>
                <td class="xl70" x:num="0.25417075564278707">25.42%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="6.9683152173912575">6.97<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="2.3531268612269209">2.35<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="762.83971283464973">762.84<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>27</td>
                <td class="xl70" x:num="0.19000907895137292">19.00%</td>
                <td class="xl70" x:num="0.14679275650747101">14.68%</td>
                <td class="xl70" x:num="0.20411086257231795">20.41%</td>
                <td class="xl71" x:num="267.24909120755746">267.25<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="13929.638350950911">13929.64<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.95011617353421962">0.95<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>5509</td>
                <td class="xl72" x:num="5234.190000000016">5234.19</td>
                <td class="xl70" x:num="0.19185059422750425">19.19%</td>
                <td class="xl70" x:num="4.9192230894899255e-002">4.92%</td>
                <td class="xl70" x:num="0.11972930765226444">11.97%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="2.6197147147147226">2.62<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.92541856925418564">0.93<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1210.3955641249793">1210.40<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>28</td>
                <td class="xl70" x:num="0.16678594933127047">16.68%</td>
                <td class="xl70" x:num="0.12560715784420615">12.56%</td>
                <td class="xl70" x:num="0.1852678750243707">18.53%</td>
                <td class="xl71" x:num="335.29071124838947">335.29<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="11103.238336675424">11103.24<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.95384297520661054">0.95<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>5082</td>
                <td class="xl72" x:num="4847.4299999999948">4847.43</td>
                <td class="xl70" x:num="0.2455573505654281">24.56%</td>
                <td class="xl70" x:num="8.2644628099173556e-002">8.26%</td>
                <td class="xl70" x:num="0.25480283114256824">25.48%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="4.2521315789473642">4.25<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.4810382119682768">1.48<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="906.19376988536374">906.19<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>29</td>
                <td class="xl70" x:num="5.5765610595159991e-002">5.58%</td>
                <td class="xl70" x:num="4.6681737385470948e-002">4.67%</td>
                <td class="xl70" x:num="6.0297836313077786e-002">6.03%</td>
                <td class="xl71" x:num="259.96149263608521">259.96<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="8404.115363709032">8404.12<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.94476495043172759">0.94<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>3127</td>
                <td class="xl72" x:num="2954.280000000012">2954.28</td>
                <td class="xl70" x:num="0.21459227467811159">21.46%</td>
                <td class="xl70" x:num="3.5817077070674767e-002">3.58%</td>
                <td class="xl70" x:num="0.10518292682926829">10.52%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="3.4193055555555696">3.42<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.1778158295281582">1.18<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="682.81194755623801">682.81<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>30</td>
                <td class="xl70" x:num="0.13832941738146873">13.83%</td>
                <td class="xl70" x:num="0.15332085094381426">15.33%</td>
                <td class="xl70" x:num="0.13463222438284644">13.46%</td>
                <td class="xl71" x:num="296.72494654844286">296.72<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="13174.931224670634">13174.93<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.96695226773956322">0.97<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>10936</td>
                <td class="xl72" x:num="10574.589999999864">10574.59</td>
                <td class="xl70" x:num="0.25662482566248257">25.66%</td>
                <td class="xl70" x:num="0.2038222384784199">20.38%</td>
                <td class="xl70" x:num="0.28190184049079753">28.19%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="6.2057453051642391">6.21<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="2.2088172872853562">2.21<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1081.7767408485417">1081.78<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>31</td>
                <td class="xl70" x:num="6.2366997270951338e-002">6.24%</td>
                <td class="xl70" x:num="-1.7115928859399641e-002">-1.71%</td>
                <td class="xl70" x:num="8.8585902800770097e-002">8.86%</td>
                <td class="xl71" x:num="296.03883582639963">296.04<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="8754.9897284677463">8754.99<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.91431866825207864">0.91<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>4205</td>
                <td class="xl72" x:num="3844.7099999999905">3844.71</td>
                <td class="xl70" x:num="0.24926686217008798">24.93%</td>
                <td class="xl70" x:num="1.7122473246135552e-002">1.71%</td>
                <td class="xl70" x:num="0.2552594670406732">25.53%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="6.5054314720812023">6.51<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="2.2197065572630552">2.22<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="661.40786524074952">661.41<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>32</td>
                <td class="xl70"></td>
                <td class="xl70"></td>
                <td class="xl70"></td>
                <td class="xl71"></td>
                <td class="xl71"></td>
                <td class="xl71" x:num="0.95785608964906799">0.96<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>3391</td>
                <td class="xl72" x:num="3248.0899999999897">3248.09</td>
                <td class="xl70" x:num="9.2071611253196933e-002">9.21%</td>
                <td class="xl70" x:num="0.18932468298437038">18.93%</td>
                <td class="xl70" x:num="0.38731707317073172">38.73%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71"></td>
                <td class="xl71"></td>
                <td class="xl71" x:num="870.51128000472261">870.51<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>33</td>
                <td class="xl70" x:num="9.4161273265720991e-002">9.42%</td>
                <td class="xl70" x:num="0.11566301448700243">11.57%</td>
                <td class="xl70" x:num="9.1671203159405454e-002">9.17%</td>
                <td class="xl71" x:num="832.40497576068367">832.40<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="21648.443506161049">21648.44<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.91464981794814804">0.91<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>14007</td>
                <td class="xl72" x:num="12811.499999999709">12811.5</td>
                <td class="xl70" x:num="0.68318042813455659">68.32%</td>
                <td class="xl70" x:num="0.24644820446919397">24.64%</td>
                <td class="xl70" x:num="0.18033677349266702">18.03%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="7.0238486842103667">7.02<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="3.3451333813987021">3.35<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1458.7518375736618">1458.75<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>34</td>
                <td class="xl70" x:num="-5.6754530972306969e-002">-5.68%</td>
                <td class="xl70" x:num="-4.4316710497479553e-002">-4.43%</td>
                <td class="xl70" x:num="-6.8020977713558153e-002">-6.80%</td>
                <td class="xl71" x:num="216.44028244022562">216.44<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="6917.9829525601399">6917.98<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.98894894894893437">0.99<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>1665</td>
                <td class="xl72" x:num="1646.5999999999758">1646.6</td>
                <td class="xl70" x:num="0.16391085549964055">16.39%</td>
                <td class="xl70" x:num="0.26906906906906908">26.91%</td>
                <td class="xl70" x:num="0.14465408805031446">14.47%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="4.0063260340632016">4.01<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.82487751224877515">0.82<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="916.4542636526636">916.45<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>35</td>
                <td class="xl70" x:num="0.1359055081134676">13.59%</td>
                <td class="xl70" x:num="0.15502190372477445">15.50%</td>
                <td class="xl70" x:num="0.11910588537721745">11.91%</td>
                <td class="xl71" x:num="345.11477071647329">345.11<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="8569.7003242620885">8569.70<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.0180559687616348">1.02<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>10756</td>
                <td class="xl72" x:num="10950.210000000145">10950.21</td>
                <td class="xl70" x:num="0.17178276269185361">17.18%</td>
                <td class="xl70" x:num="0.13862030494607661">13.86%</td>
                <td class="xl70" x:num="0.26466108149276468">26.47%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="6.250119863013782">6.25<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.3950084443610433">1.40<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1114.9542832186426">1114.95<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>36</td>
                <td class="xl70" x:num="0.14368932724232888">14.37%</td>
                <td class="xl70" x:num="0.1850492059293749">18.50%</td>
                <td class="xl70" x:num="0.1378025320284624">13.78%</td>
                <td class="xl71" x:num="374.87126091893992">374.87<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="22442.216210239836">22442.22<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.946676497277672">0.95<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>4408</td>
                <td class="xl72" x:num="4172.949999999978">4172.95</td>
                <td class="xl70" x:num="0.97916666666666663">97.92%</td>
                <td class="xl70" x:num="0.15494555353901995">15.49%</td>
                <td class="xl70" x:num="0.35498220640569395">35.50%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="5.7957638888888576">5.80<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.888173515981735">1.89<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="2332.0330512686282">2332.03<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>37</td>
                <td class="xl70" x:num="9.1601726963084877e-003">0.92%</td>
                <td class="xl70" x:num="-3.1711313790590695e-002">-3.17%</td>
                <td class="xl70" x:num="4.323426815414539e-002">4.32%</td>
                <td class="xl71" x:num="1133.3321604674891">1133.33<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="20207.655822882007">20207.66<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.99423184357541694">0.99<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>716</td>
                <td class="xl72" x:num="711.86999999999853">711.87</td>
                <td class="xl70" x:num="0.35294117647058826">35.29%</td>
                <td class="xl70" x:num="5.5865921787709494e-002">5.59%</td>
                <td class="xl70" x:num="0.16560509554140126">16.56%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="1.6593706293706258">1.66<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.69531564326084871">0.70<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1232.0110062114345">1232.01<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>38</td>
                <td class="xl70" x:num="1.4211232685631753e-002">1.42%</td>
                <td class="xl70" x:num="-4.5749226692721981e-002">-4.57%</td>
                <td class="xl70" x:num="3.4438581139107902e-002">3.44%</td>
                <td class="xl71" x:num="513.28011356258594">513.28<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="15363.68008507585">15363.68<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.0008429828624386">1.00<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>2159</td>
                <td class="xl72" x:num>2160.82</td>
                <td class="xl70" x:num="0.">0.00%</td>
                <td class="xl70" x:num="5.5581287633163501e-003">0.56%</td>
                <td class="xl70" x:num="0.44642857142857145">44.64%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="4.3389959839357521">4.34<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="3.4338999834956261">3.43<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="501.40555556572292">501.41<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>39</td>
                <td class="xl70" x:num="3.9400914851930924e-002">3.94%</td>
                <td class="xl70" x:num="4.3543835361049978e-002">4.35%</td>
                <td class="xl70" x:num="3.8042694485164064e-002">3.80%</td>
                <td class="xl71" x:num="518.61930982141189">518.62<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="18447.076467486819">18447.08<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.0013169984686117">1.00<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>653</td>
                <td class="xl72" x:num="653.86000000000342">653.86</td>
                <td class="xl70"></td>
                <td class="xl70" x:num="1.5313935681470138e-003">0.15%</td>
                <td class="xl70"></td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="1.1177094017094076">1.12<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.0947102212855637">1.09<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="476.5262741410005">476.53<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>40</td>
                <td class="xl70" x:num="0.23027038613854711">23.03%</td>
                <td class="xl70" x:num="0.16986057713987016">16.99%</td>
                <td class="xl70" x:num="0.2560676495402146">25.61%</td>
                <td class="xl71" x:num="724.28589693204867">724.29<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="22296.425944897164">22296.43<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.0043083003952564">1.00<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>253</td>
                <td class="xl72" x:num>254.09</td>
                <td class="xl70"></td>
                <td class="xl70" x:num="0.">0.00%</td>
                <td class="xl70"></td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="1.0082936507936504">1.01<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.98016960208741033">0.98<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="258.14596089383275">258.15<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>41</td>
                <td class="xl70" x:num="0.2626240269530124">26.26%</td>
                <td class="xl70" x:num="0.20040052349680612">20.04%</td>
                <td class="xl70" x:num="0.29925441540989506">29.93%</td>
                <td class="xl71" x:num="196.92161060631685">196.92<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="6149.1527564208782">6149.15<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.96025090102578159">0.96<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>7214</td>
                <td class="xl72" x:num="6927.2499999999882">6927.25</td>
                <td class="xl70" x:num="0.13872022419430172">13.87%</td>
                <td class="xl70" x:num="3.1605212087607429e-002">3.16%</td>
                <td class="xl70" x:num="0.2326858108108108">23.27%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="14.522536687631003">14.52<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="3.1262514000172308">3.13<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="806.3600470914979">806.36<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>42</td>
                <td class="xl70" x:num="4.2912005710371674e-002">4.29%</td>
                <td class="xl70" x:num="6.3592104722372147e-004">0.06%</td>
                <td class="xl70" x:num="6.1059952795697717e-002">6.11%</td>
                <td class="xl71" x:num="428.18444316414127">428.18<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="16465.001300448428">16465.00<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.0019469026548657">1.00<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>226</td>
                <td class="xl72" x:num>226.44</td>
                <td class="xl70"></td>
                <td class="xl70" x:num="0.">0.00%</td>
                <td class="xl70"></td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="1.3242105263157875">1.32<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="1.2981494832972842">1.30<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="217.57392695961263">217.57<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr height="18" style='height:13.50pt;'>
                <td class="xl69" height="18" style='height:13.50pt;' x:num>43</td>
                <td class="xl70" x:num="0.11664912169795626">11.66%</td>
                <td class="xl70" x:num="0.14035909141544636">14.04%</td>
                <td class="xl70" x:num="7.8062741146241135e-002">7.81%</td>
                <td class="xl71" x:num="246.09230251979611">246.09<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="4370.6691742220037">4370.67<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.9516485507246335">0.95<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl72" x:num>552</td>
                <td class="xl72" x:num="525.30999999999767">525.31</td>
                <td class="xl70" x:num="0.">0.00%</td>
                <td class="xl70" x:num="3.6231884057971016e-002">3.62%</td>
                <td class="xl70" x:num="0.">0.00%</td>
                <td class="xl73" x:str>……</td>
                <td class="xl71" x:num="3.3673717948717798">3.37<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="0.78630136986301369">0.79<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl71" x:num="490.93691639577355">490.94<span style='mso-spacerun:yes;'>&nbsp;</span></td>
                <td class="xl73" x:str>……</td>
                <td class="xl72" x:str>**</td>
            </tr>
            <tr width="0" style='display:none;'>
                <td width="37" style='width:28;'></td>
                <td width="41" style='width:31;'></td>
                <td width="40" style='width:30;'></td>
            </tr>
        </table>
        </body>
    </div>
</div>
</body>
</html>

