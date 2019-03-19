package com.dldata.drgs.controller.pages;

import com.dldata.drgs.entity.CustomFormTemplateEntity;
import com.dldata.drgs.service.customform.CustomFormTemplateService;
import com.dldata.drgs.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 倪继文 on 2017/4/21.
 */
@Controller
@RequestMapping(value = "/v_customformtemplate")
public class V_CustomFormTemplateController {

    @Autowired
    private CustomFormTemplateService customFormTemplateService;


    @RequestMapping(value = "/toEdit")
    public String toEdit(Model model, String formId, String templateId){
        if(!StringUtil.isNullOrSpace(templateId)){
            CustomFormTemplateEntity entity = customFormTemplateService.getTemplateById(templateId);
            model.addAttribute("data",entity);
        }
        model.addAttribute("formId",formId);

        return "customform/v_CustomFormTemplateEdit";
        //return "customform/v_Dldsnform";
    }

    @RequestMapping(value = "/toClone")
    public String toClone(Model model, String templateId){
        model.addAttribute("templateId",templateId);

        return "customform/v_CustomFormTemplateClone";
    }






}
