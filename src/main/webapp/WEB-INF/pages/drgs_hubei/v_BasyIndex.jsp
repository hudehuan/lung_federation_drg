<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 吴岳峰
  Date: 2017/08/09
  Time: 9:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html  style="background: #fff">
<head>
    <meta charset="utf-8">
    <meta name="format-detection" content="telephone=no,email=no,address=no">
    <%--<%@ include file="/common/meta.jsp" %>--%>
    <script type="text/javascript" src="${ctx }/static/js/jquery-1.11.2.min.js"></script>
    <title>病案首页</title>
    <link rel="stylesheet" type="text/css" href="${ctx }/static/css/list.css">
    <link rel="stylesheet" href="${ctx }/static/css/my-stlye.css"/>
    <script type="text/javascript" src="${ctx}/static/js/jsonpData.js"></script>
    <script>

        var biIds =['ff7d429c-a7f2-4008-ac7a-e963858812aa'];//报表id
        var biKeys =[];//报表返回softkey
        $(function () {
            $.ajax({
                type:"POST",
                url:"/HBI/loadBiKsy?biIds="+biIds,
                dataType: "json",
                success:function(data){
                    biKeys =data;
                    loadData();
                }
            });
            $("input").attr("readonly","readonly");

        })

        var loads =0;
        function loadData() {
            loads++;
            var cxtj = '${bah}|';
            var url ='${biIp}/view/Dsnreport/ajax/AjaxGetReportJsonpData.ashx?callback=?&biqtuser=${biqtuser}&bivar='+
                '&biyccs=&id=' +biKeys[0].id+'&softkey='+biKeys[0].softkey +
                '&cxtj='+escape(cxtj)+'&topdata=&timew=&weiplan=';
//            console.log(url.toString());

            $.ajax({
                type:"GET",
                url:url,
                dataType: "jsonp",
                success:function(data){loads--;
                    test(loads);
                   //console.log(data);
                    data = jsonpDataInit(data);
                    if(data.rows.row.length>0){
                        var datay = data.rows.row[0];
                        for(var i = 0; i<222;i++){
                            var id = "text"+i;
                            if ( $("#"+id).length > 0 ) {
                                if(117<i&&i<148){
                                    $("#"+id).val(datay.cell[i]);
                                }else if(parseInt(datay.cell[i])!=0){
                                    $("#"+id).val(datay.cell[i]);
                                }
                            }
                        }
                        setRadioVal(datay.cell[7],datay.cell[15],datay.cell[78],datay.cell[161],datay.cell[103],
                            datay.cell[73],datay.cell[89],datay.cell[76],datay.cell[105],datay.cell[106]);
                    }
                  }
            });
        }

        function setRadioVal(sex,hy,rytj,ywgm,swsj,xx,rh,bazl,lyfs,zzyjh) {
            $(" :radio[name='sex'][value='"+sex+"']").prop('checked', true);
            $(" :radio[name='hy'][value='"+hy+"']").prop('checked', true);
            $(" :radio[name='rytj'][value='"+rytj+"']").prop('checked', true);
            if(ywgm){
                $(" :radio[name='ywgm'][value='2']").prop('checked', true);
            }else {
                $(" :radio[name='ywgm'][value='1']").prop('checked', true);
            }
//            $(" :radio[name='ywgm'][value='"+ywgm+"']").prop('checked', true);
            $(" :radio[name='swsj'][value='"+swsj+"']").prop('checked', true);
            $(" :radio[name='xx'][value='"+xx+"']").prop('checked', true);
            $(" :radio[name='rh'][value='"+rh+"']").prop('checked', true);
            $(" :radio[name='bazl'][value='"+bazl+"']").prop('checked', true);
            $(" :radio[name='lyfs'][value='"+lyfs+"']").prop('checked', true);
            $(" :radio[name='zzyjh'][value='"+zzyjh+"']").prop('checked', true);
        }

    </script>
    <style>
        input{
            color: #00a0e9;
        }
        input[type='radio']{
            color: #00a0e9;
        }
    </style>

</head>
<body style="background: #fff">
<div id="loading" class="loader">
    <img class="Rotation" src="${ctx}/static/img/load.png" width="32" height="32"/>
</div>
<div class="container">
    <h2 style="text-align:center;">住院病案首页</h2>
    <h4>附件1：</h4>
    <p><strong>医疗机构</strong>
        <input type="text" id="text158" class="" style="width:200px"  value="${entity.yljg}"/><%--yydm--%>
        (<strong>组织机构代码</strong>
        <input type="text"id="text221" class="" value="${entity.zzjgdm}" />)
    </p>
    <p><strong>医疗付费方式</strong>
        <input type="text" id="text83" class="" style="width:80px" value="${entity.CH0A82}"/><strong style="margin-left:20px" >健康卡号</strong>
        <input type="text" id="text1" class=""value="${entity.P800}" /><strong style="margin-left:20px" >第</strong>
        <input type="text" id="text159" class="" style="width:50px"  value="${entity.InHosTimesP2}"/><strong>次住院</strong><strong style="margin-left:20px" >病案号</strong>
        <input type="text" id="text3" class="" style="width:100px"  value="${entity.CH0A01}"/>
    </p>
    <table class="table_one" style="margin-top:6px">
        <tr>
            <td>
                <div>
                    <span class="long_tit">姓名:</span>
                    <input type="text" id="text5" class=""  value="${entity.CH0A02}"/>
                    <span class="long_tit">性别:</span>
                    <span class="span_dwradio">
								<div><input type="radio"  id="nan" name="sex" value="男"/><label for="nan">男</label></div>
								<div><input type="radio"  id="nv" name="sex" value="女"/><label for="nv">女</label></div>
							</span>
                    <span class="long_tit">出生日期:</span>
                    <input type="text" id="text9" class=""  value="${entity.CH0A04}"/>
                    <span class="long_tit">年龄:</span>
                    <input type="text" id="text12" class="" style="width:50px" value="${entity.CH0A06}" />
                    <span class="long_tit">国籍:</span>
                    <input type="text" id="text84" class="" style="width:50px" value="${entity.CH0AA2}" />
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">新生儿年龄:</span>
                    <input type="text" id="text162" class="" style="width:50px" value="${entity. AgeOfInfantP66}"/>
                    <span>月（年龄不足一周岁的）</span>
                    <span class="long_tit">新生儿出生体重:</span>
                    <input type="text" id="text94" class="" style="width:50px" value="${entity.Ch0AN2}"/>
                    <span>克</span>
                    <span class="long_tit">新生儿入院体重:</span>
                    <input type="text" id="text95" class="" style="width:50px" value="${entity.Ch0AN3}"/>
                    <span>克</span>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">出生地:</span>
                    <input type="text" id="text18" class="" style="width:300px" value="${entity.csdSheng}"/><%--CH0A09--%>
                    <%--<span>省（区丶市）</span>--%>
                    <%--<input type="text" class="" style="width:50px" value="${entity.csdShi}"/>--%>
                    <%--<span>市</span>--%>
                    <%--<input type="text" class="" style="width:50px"value="${entity.csdXian}"/>--%>
                    <%--<span>县</span>--%>
                    <span class="long_tit">籍贯:</span>
                    <input type="text" id="text96" class="" style="width:150px" value="${entity.jgSheng}"/><%--Ch0AN4--%>
                    <%--<span>省（区丶市）</span>--%>
                    <%--<input type="text" class="" style="width:50px" value="${entity.jgShi}"/>--%>
                    <%--<span>市</span>--%>
                    <span class="long_tit">民族:</span>
                    <input type="text" id="text19" class="" style="width:50px" ${entity.CH0A10}/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">身份证号:</span>
                    <input type="text" id="text10" class="" value="${entity.CH0A05}"/>
                    <span class="long_tit">职业:</span>
                    <input type="text" id="text17" class="" style="width:80px"value="${entity.CH0A08}" />
                    <span class="long_tit">婚姻:</span>
                    <span class="span_dwradio">
								<div><input type="radio"  id="weihun" name="hy" value="未婚"/><label for="weihun">未婚</label></div>
								<div><input type="radio"  id="yihun" name="hy" value="已婚"/><label for="yihun">已婚</label></div>
								<div><input type="radio"  id="sangou" name="hy" value="丧偶"/><label for="sangou">丧偶</label></div>
								<div><input type="radio"  id="lihun" name="hy" value="离婚"/><label for="lihun">离婚</label></div>
								<div><input type="radio"  id="hunyinqt" name="hy" value="其他"/><label for="hunyinqt">其他</label></div>
							</span>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">现住址:</span>
                    <input type="text" id="text97" class="" style="width:300px" value="${entity.xzzSheng}"/><%--Ch0AN5--%>
                    <%--<span>省（区丶市）</span>--%>
                    <%--<input type="text" class="" style="width:50px" value="${entity.xzzShi}"/>--%>
                    <%--<span>市</span>--%>
                    <%--<input type="text" class="" style="width:50px"value="${entity.xzzXian}"/>--%>
                    <%--<span>县</span>--%>
                    <span class="long_tit">电话:</span>
                    <input type="text" id="text99" class="" value="${entity.Ch0AN7}"/>
                    <span class="long_tit">邮编:</span>
                    <input type="text" id="text100" class="" style="width:80px" value="${entity.Ch0AN8}"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">户口住址:</span>
                    <input type="text" id="text22" class="" style="width:300px" value="${entity.hkSheng}"/><%--CH0A12--%>
                    <%--<span>省（区丶市）</span>--%>
                    <%--<input type="text" class="" style="width:50px"value="${entity.hkShi}"/>--%>
                    <%--<span>市</span>--%>
                    <%--<input type="text" class="" style="width:50px"value="${entity.hkXian}"/>--%>
                    <%--<span>县</span>--%>
                    <span class="long_tit">邮编:</span>
                    <input type="text" id="text25" class="" style="width:80px" value="${entity.CH0A14}"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">工作单位及住址:</span>
                    <input type="text" id="text85" class="" style="width:270px" value="${entity.CH0AA3}"/>
                    <span class="long_tit">单位电话:</span>
                    <input type="text" id="text87" class="" value="${entity.CH0AA5}"/>
                    <span class="long_tit">邮编:</span>
                    <input type="text" id="text86" class="" style="width:80px"value="${entity.CH0AA4}"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">联系人姓名:</span>
                    <input type="text" id="text26" class="" style="width:80px"value="${entity.CH0A15}"/>
                    <span class="long_tit">关系:</span>
                    <input type="text" id="text28" class="" style="width:80px"value="${entity.CH0A16}"/>
                    <span class="long_tit">地址:</span>
                    <input type="text" id="text31" class="" style="width:180px"value="${entity.CH0A17}"/>
                    <span class="long_tit">电话:</span>
                    <input type="text" id="text34" class=""value="${entity.CH0A19}"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="tit">入院途径:</span>
                    <span class="span_dwradio">
								<div><input type="radio"  name="rytj" id="rytj1" class="validate[required]" value="急诊"/>
                                    <label for="rytj1">急诊</label></div>
								<div><input type="radio"  name="rytj" id="rytj2" class="validate[required]" value="门诊"/>
                                    <label for="rytj2">门诊</label></div>
								<div><input type="radio"  name="rytj" id="rytj3" class="validate[required]" value="其他医疗机构转入"/>
                                    <label for="rytj3">其他医疗机构转入</label></div>
								<div><input type="radio"  name="rytj" id="rytj4" class="validate[required]" value="其他"/>
                                    <label for="rytj4">其他</label></div>
							</span>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">入院时间:</span>
                    <input type="text" id="text40" class="" value="${entity.CH0A24}"/>
                    <span class="long_tit">入院科别:</span>
                    <input type="text" id="text38" class="" style="width:80px" value="${entity.CH0A21}"/>
                    <span class="long_tit">病房:</span>
                    <input type="text" id="text101" class="" style="width:80px" value="${enity.Ch0ANA}"/>
                    <span class="long_tit">转科科别:</span>
                    <input type="text"id="text42" class="" value="${entity.CH0A22}"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">出院时间:</span>
                    <input type="text" id="text48" class="" value="${entity.CH0A27}"/>
                    <span class="long_tit">出院科别:</span>
                    <input type="text" id="text45" class="" style="width:80px"value="${entity.CH0A23}"/>
                    <span class="long_tit">病房:</span>
                    <input type="text" id="text102" class="" style="width:80px"value="${entity.Ch0ANB}"/>
                    <span class="long_tit">实际住院:</span>
                    <input type="text" id="text51" class="" style="width:80px"value="${entity.CH0A29}"/>
                    <span>天</span>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">门（急）诊诊断:</span>
                    <input type="text" id="text8" class="" style="width:280px"value="${entity.p281}"/>
                    <span class="long_tit">疾病编码:</span>
                    <input type="text" id="text6" class="" style="width:80px"value="${entity.p28}"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <table class="tab_bq">
                    <tr>
                        <td style="width:212px">出院诊断</td>
                        <td style="width:auto">疾病编码</td>
                        <td style="width:60px">入院病情</td>
                        <td style="width:212px">出院诊断</td>
                        <td style="width:100px">疾病编码</td>
                        <td style="width:60px">入院病情</td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" id="text92" class="" style="width:100%;border-bottom: none;"/>
                            <%--${entity.CH0A65}--%>
                            <%--<span class="long_tit">主要诊断:</span>--%>
                        </td>
                        <td>
                            <input type="text" id="text91" class="" style="width:100%;border-bottom: none;"/>
                            <%--${entity.CH0A38}--%>
                        </td>
                        <td>
                            <input type="text" id="text37" class="" style="width:100%;border-bottom: none;" />
                            <%--<c:choose>--%>
                                <%--<c:when test="${entity.Ch0ANO==1}">有</c:when>--%>
                                <%--<c:when test="${entity.Ch0ANO==2}">临床未确定</c:when>--%>
                                <%--<c:when test="${entity.Ch0ANO==3}">情况不明</c:when>--%>
                                <%--<c:otherwise >无</c:otherwise>--%>
                            <%--</c:choose>--%>
                        </td>
                        <td>
                            <input type="text" id="text13" class="" style="width:100%;border-bottom: none;"/>
                            ${entity.p325}
                            <%--<span class="long_tit">其他诊断:</span>--%>
                        </td>
                        <td>
                            <input type="text" id="text14" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p324}</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" id="text16" class="" style="width:100%;border-bottom: none;"/>
                            ${entity.p328}
                            <%--<span class="long_tit">其他诊断:</span>--%>
                        </td>
                        <td>
                            <input type="text" id="text65" class="" style="width:100%;border-bottom: none;"/>
                        ${entity.p327}</td>
                        <td></td>
                        <td>
                            <input type="text" id="text63" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p3292}</td>
                        <td>
                            <input type="text" id="text20" class="" style="width:100%;border-bottom: none;"/>
                            ${entity.p3291}</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" id="text21" class="" style="width:100%;border-bottom: none;"/>
                            ${entity.p3295}</td>
                        <td>
                            <input type="text" id="text67" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p3294}</td>
                        <td></td>
                        <td>
                            <input type="text" id="text24" class="" style="width:100%;border-bottom: none;"/>
                            ${entity.p3298}</td>
                        <td>
                            <input type="text" id="text27" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p3297}</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td> <input type="text" id="text29" class="" style="width:100%;border-bottom: none;"/>
                        ${entity.p3282}</td>
                        <td> <input type="text" id="text30" class="" style="width:100%;border-bottom: none;" />
                        ${entity.p3281}</td>
                        <td></td>
                        <td> <input type="text" id="text33" class="" style="width:100%;border-bottom: none;" />
                        ${entity.p3285}</td>
                        <td><input type="text" id="text35" class="" style="width:100%;border-bottom: none;" />
                        ${entity.p3284}</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td> <input type="text" id="text36" class="" style="width:100%;border-bottom: none;" />
                        ${entity.p3288}</td>
                        <td> <input type="text" id="text39" class="" style="width:100%;border-bottom: none;" />
                        ${entity.p3287}</td>
                        <td></td>
                        <td> <input type="text" id="text41" class="" style="width:100%;border-bottom: none;" />
                        ${entity.p3272}</td>
                        <td> <input type="text" id="text43" class="" style="width:100%;border-bottom: none;" />
                        ${entity.p3271}</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td> <input type="text" id="text44" class="" style="width:100%;border-bottom: none;" />
                        ${entity.p3275}</td>
                        <td> <input type="text" id="text46" class="" style="width:100%;border-bottom: none;" />
                        ${entity.p3274}</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="6" style="padding-left:14px">入院病情：1.有，2.临床未确定，3.情况不明，4.无</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">损伤丶中毒外部原因:</span>
                    <input type="text" class="" style="width:280px" ${entity.CH0A79}/>
                    <span class="long_tit">疾病编码:</span>
                    <input type="text" class="" style="width:80px"value=""/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">病理诊断:</span>
                    <input type="text" class="" style="width:280px" value="${entity.p352}"/>
                    <span class="long_tit">疾病编码:</span>
                    <input type="text" class="" style="width:80px" value="${entity.p351}"/>
                    <span class="long_tit">病理号:</span>
                    <input type="text" id="text160" class="" style="width:80px" ${entity.CellCheckCodeP816}/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">药物过敏:</span>
                    <span class="span_dwradio">
								<div><input type="radio"  id="ywgmw" name="ywgm" value="1"/><label for="ywgmw">无</label></div>
								<div><input type="radio"  id="ywgmy" name="ywgm" value="2"/><label for="ywgmy">有，过敏药物：</label></div>
							</span>
                    <input type="text" id="text113" class="" style="width:180px" value="${entity.AllergyMedicineP372}"/>
                    <span class="long_tit">死亡患者尸检:</span>
                    <span class="span_dwradio">
								<div><input type="radio"  id="swsj-s" name="swsj" value="1"/><label for="swsj-s">是</label></div>
								<div><input type="radio"  id="swsj-f" name="swsj" value="2"/><label for="swsj-f">否</label></div>
							</span>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">血型:</span>
                    <span class="span_dwradio">
								<div><input type="radio"  id="xxa" name="xx" value="A"/><label for="xxa">A</label></div>
								<div><input type="radio"  id="xxb" name="xx" value="B"/><label for="xxb">B</label></div>
								<div><input type="radio"  id="xxo" name="xx" value="O"/><label for="xxo">O</label></div>
								<div><input type="radio"  id="xxab" name="xx" value="AB"/><label for="xxab">AB</label></div>
								<div><input type="radio"  id="xxbx" name="xx" value="不详"/><label for="xxbx">不详</label></div>
								<div><input type="radio"  id="xxwc" name="xx" value="未查"/><label for="xxwc">未查</label></div>
							</span>
                    <span class="long_tit">Rh:</span>
                    <span class="span_dwradio">
								<div><input type="radio"  id="rhyin" name="rh" value="阴性"/><label for="rhyin">阴性</label></div>
								<div><input type="radio"  id="rhying" name="rh" value="阳性"/><label for="rhying">阳性</label></div>
								<div><input type="radio"  id="rhbx" name="rh" value="不详"/><label for="rhbx">不详</label></div>
								<div><input type="radio"  id="rhwc" name="rh" value="未查"/><label for="rhwc">未查</label></div>
							</span>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">科主任:</span>
                    <input type="text" id="text148" class="" style="width:90px" value="${entity.CH0AB1}"/>
                    <span class="long_tit">主任（副主任）医师:</span>
                    <input type="text" id="text149" class="" style="width:90px" value="${entity.CH0A32}"/>
                    <span class="long_tit">主治医师:</span>
                    <input type="text" id="text150" class="" style="width:90px"value="${entity.CH0A33}"/>
                    <span class="long_tit">住院医师:</span>
                    <input type="text" id="text151" class="" style="width:90px" value="${entity.CH0A34}"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">责任护士:</span>
                    <input type="text" id="text104" class="" style="width:90px" value="${entity.Ch0AND}"/>
                    <span class="long_tit">进修医师:</span>
                    <input type="text" id="text62" class="" style="width:90px"value="${entity.CH0AB2}"/>
                    <span class="long_tit">实习医师:</span>
                    <input type="text" id="text64" class="" style="width:90px"value="${entity.CH0AB3}${entity.CH0AB4}"/>
                    <span class="long_tit">编码员:</span>
                    <input type="text" id="text79" class="" style="width:90px" value="${entity.CH0A59}"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">病案质量:</span>
                    <span class="span_dwradio">
								<div><input type="radio"  id="bazla" name="bazl" value="1"/><label for="bazla">甲</label></div>
								<div><input type="radio"  id="bazlb" name="bazl" value="2"/><label for="bazlb">乙</label></div>
								<div><input type="radio"  id="bazlc" name="bazl" value="3"/><label for="bazlc">丙</label></div>
							</span>
                    <span class="long_tit">质控医师:</span>
                    <input type="text" id="text66" class="" style="width:80px" ${entity.CH0AB5}/>
                    <span class="long_tit">质控护士:</span>
                    <input type="text" id="text80" class="" style="width:80px" ${entity.CH0A69}/>
                    <span class="long_tit">质控日期:</span>
                    <input type="text" id="text88" class=""${entity.CH0AB6}/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <table class="tab_bq">
                    <tr>
                        <td style="width:100px" rowspan="2">手术及操作编码</td>
                        <td style="width:100px" rowspan="2">手术及操作日期</td>
                        <td style="width:50px" rowspan="2">手术级别</td>
                        <td style="width:120px" rowspan="2">手术及操作名称</td>
                        <td colspan="3">手术及操作医师</td>
                        <td style="width:50px" rowspan="2">切口等级</td>
                        <td style="width:70px" rowspan="2">麻醉方式</td>
                        <td style="width:auto" rowspan="2">麻醉医师</td>
                    </tr>
                    <tr class="center">
                        <td style="width:60px">术者</td>
                        <td style="width:60px">I助</td>
                        <td style="width:60px">II助</td>
                    </tr>
                    <tr>
                        <td><input type="text" id="text152" class="" style="width:100%;border-bottom: none;" />
                        ${entity.CH0E05}</td>
                        <td><input type="text" id="text153" class="" style="width:100%;border-bottom: none;" />
                        ${entity.ssrq}</td>
                        <td><input type="text" id="text181" class="" style="width:100%;border-bottom: none;" />
                        ${entity.ZSSJB}</td>
                        <td><input type="text" id="text157" class="" style="width:100%;border-bottom: none;" />
                        ${entity.ssmc}</td>
                        <td><input type="text" id="text218" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p495}</td>
                        <td></td>
                        <td></td>
                        <td><input type="text" id="text219" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p1817}</td>
                        <td><input type="text" id="text156" class="" style="width:100%;border-bottom: none;" />
                            ${entity.CH0E10}</td>
                        <td><input type="text" id="text220" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4910}</td>
                    </tr>
                    <tr>
                        <td><input type="text" id="text47" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4911}</td>
                        <td><input type="text" id="text183" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4912}</td>
                        <td><input type="text" id="text182" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p821}</td>
                        <td><input type="text" id="text49" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4913}</td>
                        <td><input type="text" id="text186" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4916}</td>
                        <td></td>
                        <td></td>
                        <td><input type="text" id="text184" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4920}</td>
                        <td><input type="text" id="text185" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4919}</td>
                        <td><input type="text" id="text187" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4921}</td>
                    </tr>
                    <tr>
                        <td><input type="text" id="text50" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4922}</td>
                        <td><input type="text" id="text189" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4923}</td>
                        <td><input type="text" id="text188" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p822}</td>
                        <td><input type="text" id="text52" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4924}</td>
                        <td><input type="text" id="text192" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4527}</td>
                        <td></td>
                        <td></td>
                        <td><input type="text" id="text190" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4531}</td>
                        <td><input type="text" id="text191" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4530}</td>
                        <td><input type="text" id="text193" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4532}</td>
                    </tr>
                    <tr>
                        <td><input type="text" id="text54" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4533}</td>
                        <td><input type="text" id="text195" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4534}</td>
                        <td><input type="text" id="text194" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p823}</td>
                        <td><input type="text" id="text55" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4535}</td>
                        <td><input type="text" id="text198" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4538}</td>
                        <td></td>
                        <td></td>
                        <td><input type="text" id="text196" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4542}</td>
                        <td><input type="text" id="text197" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4541}</td>
                        <td><input type="text" id="text199" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4543}</td>
                    </tr>
                    <tr>
                        <td><input type="text" id="text56" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4544}</td>
                        <td><input type="text" id="text201" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4545}</td>
                        <td><input type="text" id="text200" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p824}</td>
                        <td><input type="text" id="text57" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4546}</td>
                        <td><input type="text" id="text204" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4549}</td>
                        <td></td>
                        <td></td>
                        <td><input type="text" id="text202" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4553}</td>
                        <td><input type="text" id="text203" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4552}</td>
                        <td><input type="text" id="text205" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p4554}</td>
                    </tr>
                    <tr>
                        <td><input type="text" id="text58" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p45002}</td>
                        <td><input type="text" id="text207" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p45003}</td>
                        <td><input type="text" id="text206" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p825}</td>
                        <td><input type="text" id="text59" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p45004}</td>
                        <td><input type="text" id="text210" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p45007}</td>
                        <td></td>
                        <td></td>
                        <td><input type="text" id="text208" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p45012}</td>
                        <td><input type="text" id="text209" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p45010}</td>
                        <td><input type="text" id="text211" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p45013}</td>
                    </tr>
                    <tr>
                        <td><input type="text" id="text60" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p45014}</td>
                        <td><input type="text" id="text213" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p45015}</td>
                        <td><input type="text" id="text212" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p826}</td>
                        <td><input type="text" id="text61" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p45016}</td>
                        <td><input type="text" id="text216" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p45019}</td>
                        <td></td>
                        <td></td>
                        <td><input type="text" id="text214" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p45024}</td>
                        <td><input type="text" id="text214" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p45022}</td>
                        <td><input type="text" id="text217" class="" style="width:100%;border-bottom: none;" />
                            ${entity.p45025}</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">离院方式:</span>
                    <div class="span_dwradio div_marginLeft">
                        <table class="table_two">
                            <tr>
                                <td>
                                    <div><input type="radio"  id="lyfsly" name="lyfs" value="医嘱离院"/><label for="lyfsly">医嘱离院</label></div>
                                    <div><input type="radio"  id="lyfszy" name="lyfs" value="医嘱转院，拟接收医疗机构名称"/><label for="lyfszy">医嘱转院，拟接收医疗机构名称</label></div>
                                    <input type="text" class="" value="${entity.Ch0ANF}"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div><input type="radio"  id="lyfsyzzy" name="lyfs" value="医嘱转社区卫生服务机构/乡镇卫生院，拟接收医疗机构名称"/><label for="lyfsyzzy">医嘱转社区卫生服务机构/乡镇卫生院，拟接收医疗机构名称</label></div>
                                    <input type="text" class=""value="${entity.Ch0ANF}"/>
                                    <div><input type="radio"  id="lyfsfyzly" name="lyfs" value="非医嘱离院"/><label for="lyfsfyzly">非医嘱离院</label></div>
                                    <div><input type="radio"  id="lyfslysw" name="lyfs" value="死亡"/><label for="lyfslysw">死亡</label></div>
                                    <div><input type="radio"  id="lyfslyqt" name="lyfs" value="其他"/><label for="lyfslyqt">其他</label></div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">是否有出院31天内再住院计划:</span>
                    <span class="span_dwradio">
								<div><input type="radio"  id="zzyjhw" name="zzyjh" value="无"/><label for="zzyjhw">无</label></div>
								<div><input type="radio"  id="zzyjhy" name="zzyjh" value="有"/><label for="zzyjhy">有，目的</label></div>
							</span>
                    <input type="text" style="width:200px"value="${entity.Ch0ANH}"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">颅脑损伤患者昏迷时间:</span>
                    <span>入院前</span>
                    <input type="text" id="text107" class="" style="width:50px" value="${entity.Ch0ANI}"/>
                    <span>天</span>
                    <input type="text" id="text108" class="" style="width:50px"value="${entity.Ch0ANJ}"/>
                    <span>小时</span>
                    <input type="text" id="text109" class="" style="width:50px"value="${entity.Ch0ANK}"/>
                    <span>分钟</span>
                    <span style="margin-left:10px">入院后</span>
                    <input type="text" id="text110" class="" style="width:50px"value="${entity.Ch0ANL}"/>
                    <span>天</span>
                    <input type="text" id="text111" class="" style="width:50px"value="${entity.Ch0ANM}"/>
                    <span>小时</span>
                    <input type="text" id="text112" class="" style="width:50px"value="${entity.Ch0ANN}"/>
                    <span>分钟</span>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">住院费用（元）:</span>
                    <span>总费用</span>
                    <input type="text" id="text118" class="" style="width:80px" value="${entity.CH0B83}"/>
                    <span>（自付金额：</span>
                    <input type="text" id="text119" class="" style="width:50px" value="${entity.CH0BP1}"/>
                    <span>）</span>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">1.综合医疗服务类：</span>
                    <span>一般医疗服务费：</span>
                    <input type="text" id="text120" class="" style="width:60px" value="${entity.CH0BP2}"/>
                    <span>一般治疗操作费：</span>
                    <input type="text" id="text121" class="" style="width:60px" value="${entity.CH0BP3}"/>
                    <span>护理费：</span>
                    <input type="text" id="text122" class="" style="width:60px" value="${entity.CH0BP4}"/>
                    <span>其他费：</span>
                    <input type="text" id="text123" class="" style="width:60px"value="${entity.CH0BP5}"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">2.诊断类：</span>
                    <span>病理诊断费：</span>
                    <input type="text" id="text124" class="" style="width:60px"value="${entity.CH0BP6}"/>
                    <span>实验室诊断费：</span>
                    <input type="text" id="text125" class="" style="width:60px"value="${entity.CH0BP7}"/>
                    <span>护影像学诊断费：</span>
                    <input type="text" id="text126" class="" style="width:60px"value="${entity.CH0BP8}"/>
                    <span>临床诊断项目费：</span>
                    <input type="text" id="text127" class="" style="width:60px"value="${entity.CH0BP9}"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">3.治疗类：</span>
                    <span>非手术治疗项目费：</span>
                    <input type="text" id="text128" class="" style="width:40px"value="${entity.CH0BPA}"/>
                    （<span>临床物理治疗费：</span>
                    <input type="text" id="text129" class="" style="width:30px"value="${entity.CH0BPB}"/>）
                    <span>手术治疗费：</span>
                    <input type="text" id="text130" class="" style="width:30px"value="${entity.CH0BPC}"/>
                    （<span>手术费：</span>
                    <input type="text" id="text132" class="" style="width:30px"value="${entity.CH0BPE}"/>
                    <span>麻醉费：</span>
                    <input type="text" id="text131" class="" style="width:30px"value="${entity.CH0BPD}"/>）
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">4.康复类：</span>
                    <span>康复费：</span>
                    <input type="text" id="text133" class="" style="width:60px"value="${entity.CH0BPF}"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">5.中医类：</span>
                    <span>中医治疗费：</span>
                    <input type="text" id="text134" class="" style="width:60px"value="${entity.CH0BPG}"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">6.西药类：</span>
                    <span>西药费：</span>
                    <input type="text" id="text135" class="" style="width:60px"value="${entity.CH0BPH}"/>
                    （<span>抗菌药物费用：</span>
                    <input type="text" id="text136" class="" style="width:60px"value="${entity.CH0BPI}"/>）
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">7.中药类：</span>
                    <span>中成药费：</span>
                    <input type="text" id="text137" class="" style="width:60px"value="${entity.CH0BPJ}"/>
                    <span>中草药费：</span>
                    <input type="text" id="text138" class="" style="width:60px"value="${entity.CH0BPK}"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">8.血液和血液制品类:</span>
                    <div class="span_dwradio div_marginLeft">
                        <table class="table_two">
                            <tr>
                                <td>
                                    <span>血费：</span>
                                    <input type="text" id="text139" class="" style="width:60px"value="${entity.CH0BPL}"/>
                                    <span>白蛋白类制品费：</span>
                                    <input type="text" id="text140" class="" style="width:60px"value="${entity.CH0BPM}"/>
                                    <span>球蛋白类制品费：</span>
                                    <input type="text" id="text141" class="" style="width:60px"value="${entity.CH0BPN}"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>凝血因子类制品费：</span>
                                    <input type="text" id="text142" class="" style="width:60px"value="${entity.CH0BPO}"/>
                                    <span>细胞因子类制品费：</span>
                                    <input type="text" id="text143" class="" style="width:60px"value="${entity.CH0BPP}"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">9.耗材类：</span>
                    <span>检查用一次性医用材料费：</span>
                    <input type="text" id="text144" class="" style="width:60px"value="${entity.CH0BPQ}"/>
                    <span>治疗用一次性医用材料费：</span>
                    <input type="text" id="text145" class="" style="width:60px"value="${entity.CH0BPR}"/>
                    <span>手术用一次性医用材料费：</span>
                    <input type="text" id="text146" class="" style="width:60px"value="${entity.CH0BPS}"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit">10.其他类：</span>
                    <span>其他费：</span>
                    <input type="text" id="text147" class="" style="width:60px"value="${entity.CH0BPT}"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span class="long_tit"></span>
                    <span></span>
                </div>
            </td>
        </tr>
    </table>
    <p><strong>说明：</strong>（一）医疗付费方式  1.城镇职工基本医疗保险  2.城镇居民基本医疗保险 3.新型农村合作医疗 4.贫困救助  5.商业医疗保险 6.全公费  7.全自费  8.其他社会保险  9.其他
        （二）凡可由医院信息系统提供住院费用清单的，住院病案首页中可不填写“住院费用”。</p>
</div>
</body>
</html>
