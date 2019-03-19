package com.dldata.drgs.controller.pages;

import com.dldata.drgs.entity.CustomFormEntity;
import com.dldata.drgs.entity.CustomFormFieldEntity;
import com.dldata.drgs.entity.CustomFormTemplateEntity;
import com.dldata.drgs.service.customform.CustomFormFieldService;
import com.dldata.drgs.service.customform.CustomFormService;
import com.dldata.drgs.service.customform.CustomFormTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by 倪继文 on 2017/4/20.
 */

@Controller
@RequestMapping(value = "/v_Dldsnform")
public class V_DldsnformController {

    @Autowired
    private CustomFormTemplateService customFormTemplateService;

    @Autowired
    private CustomFormService customFormService;


    @Autowired
    private CustomFormFieldService customFormFieldService;

    @RequestMapping(value = "/toDldsnform")
    public String toDldsnform(String templateId,Model model){

        CustomFormTemplateEntity customFormTemplateEntity = customFormTemplateService.getTemplateById(templateId);

        model.addAttribute("templateEntity",customFormTemplateEntity);

        String formId = customFormTemplateEntity.getFormId();
        model.addAttribute("formId",formId);
        CustomFormEntity customFormEntity = customFormService.getCustomFormByFormId(formId);

        model.addAttribute("formEntity",customFormEntity);

        List<CustomFormFieldEntity> customFormFieldEntityList = new ArrayList<CustomFormFieldEntity>();
        customFormFieldEntityList = customFormFieldService.getAllFieldByFormId(formId);

        model.addAttribute("templateId",templateId);
        model.addAttribute("title","自定义表单设计");
        return "customform/v_Dldsnform";
    }


}
