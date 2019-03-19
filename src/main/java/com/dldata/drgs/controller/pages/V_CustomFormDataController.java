package com.dldata.drgs.controller.pages;

import com.dldata.drgs.entity.*;
import com.dldata.drgs.service.System.SysKeShiService;
import com.dldata.drgs.service.System.SysStaffService;
import com.dldata.drgs.service.customform.CustomFormFieldTemplateService;
import com.dldata.drgs.service.customform.CustomFormService;
import com.dldata.drgs.service.customform.CustomFormTemplateService;
import net.sf.json.JSONArray;
import net.sf.json.JSONSerializer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;

import java.sql.Timestamp;
import java.util.*;

/**
 * Created by 倪继文 on 2017/5/26.
 */

@Controller
@RequestMapping(value = "/v_customformdata")
public class V_CustomFormDataController {

    @Autowired
    private CustomFormFieldTemplateService customFormFieldTemplateService;

    @Autowired
    private CustomFormTemplateService customFormTemplateService;

    @Autowired
    private CustomFormService customFormService;

    @Autowired
    private SysStaffService sysStaffService;

    @Autowired
    private SysKeShiService sysKeShiService;

    @RequestMapping(value = "/toEdit")
    public String toEdit(String tableId,String dataId,String formStatus,
                         @CookieValue(value = "userid",defaultValue = "")String userId, Model model){

        CustomFormTemplateEntity customFormTemplateEntity = customFormTemplateService.getFormActivtyTemplateByFormId(tableId);
        if(customFormTemplateEntity==null){

            return "error";
        }

        //得到表单激活模板ID
        String templateId  = customFormTemplateEntity.getId();

        List<CustomFormFieldTemplateEntity> tempfieldlist = customFormFieldTemplateService.getAllByTemplateId(templateId);
        CustomFormEntity customFormEntity = customFormService.getCustomFormByFormId(tableId);

        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();
        tempfieldlist.forEach(
                (p) -> {
                    Map<String, String> tmpmap = new HashMap<String, String>();
                    tmpmap.put("fieldCode", p.getFieldCode());
                    tmpmap.put("controlType", p.getControlType());
                    if (p.getdataSql().toLowerCase().indexOf("select")>-1 && p.getdataSql().toLowerCase().indexOf("from") >-1)
                    {
                        if (p.getdataSql().split("\\|").length>1)//有联动配置
                            tmpmap.put("dataSql", "(sql)"+p.getdataSql().split("\\|")[1]);
                        else
                            tmpmap.put("dataSql", "(sql)");
                    }
                    else
                        tmpmap.put("dataSql", p.getdataSql());
                    tmpmap.put("vcljs", p.getJs()); //这里有可能json数据报错，

                    mapList.add(tmpmap);
                }
        );

        if (mapList.size()>0)
            model.addAttribute("vcljson", JSONArray.fromObject(mapList).toString());
        customFormTemplateEntity.getHtml();
        model.addAttribute("tempdata", customFormTemplateEntity);
        model.addAttribute("dataId",dataId==null?"":dataId);
        model.addAttribute("tableId",tableId);
        model.addAttribute("formStatus",formStatus==null?"":formStatus);
        model.addAttribute("formCode",customFormEntity.getCode());
        Map<String,String> defaultDate = new HashMap<String,String>();
        defaultDate.put("userid",userId);
        SysStaffEntity sysStaffEntity = sysStaffService.getStaffByID(userId);
        defaultDate.put("username","");
        defaultDate.put("userks","");
        defaultDate.put("sysdate","");
        if(sysStaffEntity!=null){
            defaultDate.put("username",sysStaffEntity.getName());
            SysKsEntity sysKsEntity = sysKeShiService.findOne(sysStaffEntity.getKsId());
            defaultDate.put("userks",sysKsEntity==null?"":sysKsEntity.getId());
            defaultDate.put("sysdate",new Timestamp(new Date().getTime()).toString().substring(0,19));
        }
        model.addAttribute("defaultDate", JSONSerializer.toJSON(defaultDate).toString());
        int num = (int)(Math.random()*100000);
        model.addAttribute("num",num);


        boolean isCheck = true;
        //model.addAttribute("isCheck",true);

        //根据templateId 得到是否需要进行审核
        if(customFormTemplateEntity.getShenhe()){
            return "/customform/v_CustomFormDataCheck";
        }
        else{
            return "/customform/v_CustomFormDataNoCheck";
        }
    }
}
